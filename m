Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF04CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaAz-00042P-OQ; Fri, 02 Oct 2026 06:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.fastermann@proxmox.com>)
 id 1xCaAw-00041o-Az; Fri, 02 Oct 2026 06:07:34 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.fastermann@proxmox.com>)
 id 1xCaAu-0002Sh-90; Fri, 02 Oct 2026 06:07:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B76AB460C1;
 Fri, 02 Oct 2026 12:07:20 +0200 (CEST)
From: Erik Fastermann <e.fastermann@proxmox.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
Date: Fri,  2 Oct 2026 12:07:03 +0200
Message-ID: <20261002100703.244967-1-e.fastermann@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <95e5ffd8-d193-41ff-9d65-433ed2ce6949@virtuozzo.com>
References: <95e5ffd8-d193-41ff-9d65-433ed2ce6949@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790935640089
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=e.fastermann@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/1/26 14:50, Denis V. Lunev wrote:
> On 9/1/26 14:23, Fiona Ebner wrote:
>> Should also go into stable I suppose?
>
> Unsure. We do not know real consequences, there are no reports.
> I found this problem by accident only testing migration with
> big trees a lot.

I came across the bug by accident while exploring the code.

It is easy to trigger with a plain -drive next to a detached -blockdev
node. If the last BlockBackend root is not monitor-owned, it is not on
monitor_bdrv_states, so bdrv_next_monitor_owned() returns NULL right
away and the second phase returns no node at all, not only those added
before it.

Reproducer:

  qemu-img create -f qcow2 a.qcow2 64M
  qemu-img create -f qcow2 b.qcow2 64M
  qemu-system-x86_64 -S -nodefaults -display none -monitor stdio \
    -drive file=a.qcow2,if=none,id=drv0 \
    -blockdev file,filename=b.qcow2,node-name=bfile \
    -blockdev qcow2,file=bfile,node-name=b0
  (qemu) savevm s1
  (qemu) info snapshots
  (qemu) quit
  qemu-img snapshot -l a.qcow2
  qemu-img snapshot -l b.qcow2

Without the fix, only a.qcow2 has snapshot s1 and savevm does not
report an error. Since "info snapshots" uses the same iterator, it
even lists s1 as present on all disks. With the fix, both images have
it.

For savevm, only nodes without any parent are affected, since
snapshots only consider nodes that are attached to a BlockBackend or
have no parent at all. Such detached nodes are rare and often
short-lived in practice I think, which would explain the lack of
reports. Still, the failure is silent, it is a regression since 9.0,
and the fix is a single line, so I think it is a good candidate for
stable.

Best regards,
Erik


