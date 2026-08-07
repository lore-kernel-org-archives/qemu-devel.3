Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2AFC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 02:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsAZC-00066S-04; Thu, 06 Aug 2026 22:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongweimin@kylinos.cn>)
 id 1wsAZ8-00065d-SA
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 22:44:10 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongweimin@kylinos.cn>)
 id 1wsAZ5-0001DT-5N
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 22:44:10 -0400
X-UUID: d40eaa98920911f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:22f29574-be46-4cfa-addd-64f71ad05ebb, IP:0,
 U
 RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:8
X-CID-META: VersionHash:e7bac3a, CLOUDID:ccac7ddb1b4882427b67e2dd9480b6cb,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
 |15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d40eaa98920911f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <xiongweimin@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1213189868; Fri, 07 Aug 2026 10:43:53 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
 qemu-devel@nongnu.org, Weimin Xiong <xiongwm2026@163.com>
Subject: Re: [PATCH 1/3] hw/virtio: Optimize vhost_log_sync_range to avoid N^2
 complexity
Date: Fri,  7 Aug 2026 10:43:50 +0800
Message-ID: <20260807024351.2157806-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724055156-mutt-send-email-mst@kernel.org>
References: <20260724055156-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=xiongweimin@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 05:56:03AM -0400, Michael S. Tsirkin wrote:
> As any optimization, I expect actual perf measurements
> showing an improvement to be included please.
>
> So it is still O(N^2) right? It just skips calling it for
> some sections.

You are right.  The change only skipped non-overlapping sections and
did not really address the complexity, and I do not have measurements
showing a meaningful win on the only call site (full-range sync in
vhost_log_put).

I will drop this patch.

Thanks,
Xiong Weimin

