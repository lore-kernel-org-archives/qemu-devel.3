Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D552AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp4Vb-0002Ts-2G; Tue, 26 Mar 2024 06:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rp4VZ-0002TH-83; Tue, 26 Mar 2024 06:58:21 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rp4VX-0002ki-MD; Tue, 26 Mar 2024 06:58:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 05B7D4216E;
 Tue, 26 Mar 2024 11:58:08 +0100 (CET)
Message-ID: <220be383-3b0d-4938-b584-69ad214e5d5d@proxmox.com>
Date: Tue, 26 Mar 2024 11:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Question about block graph lock limitation with generated co-wrappers
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,
we have a custom block driver downstream, which currently calls
bdrv_get_info() (for its file child) in the bdrv_refresh_limits()
callback. However, with graph locking, this doesn't work anymore.
AFAICT, the reason is the following:

The block driver has a backing file option.
During initialization, in bdrv_set_backing_hd(), the graph lock is
acquired exclusively.
Then the bdrv_refresh_limits() callback is invoked.
Now bdrv_get_info() is called, which is a generated co-wrapper.
The bdrv_co_get_info_entry() function tries to acquire the graph lock
for reading, sees that has_writer is true and so the coroutine will be
put to wait, leading to a deadlock.

For my specific case, I can move the bdrv_get_info() call to bdrv_open()
as a workaround. But I wanted to ask if there is a way to make generated
co-wrappers inside an exclusively locked section work? And if not, could
we introduce/extend the annotations, so the compiler can catch this kind
of issue, i.e. calling a generated co-wrapper while in an exclusively
locked section?

Best Regards,
Fiona


