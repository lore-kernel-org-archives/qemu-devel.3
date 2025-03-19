Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvM3-0005fT-Eb; Wed, 19 Mar 2025 11:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tuvM0-0005f9-WC
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:29:13 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tuvLv-0003fL-Vg
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:29:12 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1BAC245088;
 Wed, 19 Mar 2025 16:28:57 +0100 (CET)
Message-ID: <8183674f-a9cc-4727-bb52-fe3d3e44804b@proxmox.com>
Date: Wed, 19 Mar 2025 16:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/11] hpet: fix and cleanup persistence of interrupt status
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-6-pbonzini@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
In-Reply-To: <20240723141529.551737-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.07.24 um 16:15 schrieb Paolo Bonzini:
> There are several bugs in the handling of the ISR register:
> 
> - switching level->edge was not lowering the interrupt and
>   clearing ISR
> 
> - switching on the enable bit was not raising a level-triggered
>   interrupt if the timer had fired
> 
> - the timer must be kept running even if not enabled, in
>   order to set the ISR flag, so writes to HPET_TN_CFG must
>   not call hpet_del_timer()

we've been getting user reports about increased CPU usage for QEMU
processes on the host after they updated from QEMU 9.0 to QEMU 9.2.
Bisecting points to this change, and users confirmed that adding the
machine option hpet=off reduces the CPU usage again. Some quick
experimentation suggests that in particular the last part here, i.e.
"timer must be kept running even if not enabled" is the reason for this.

I reproduced the issue with a Debian 12.10 guest with kernel 6.1. It
enables and then immediately disables the HPET timer again during boot
(i.e. the HPET_TN_ENABLE bit).

I also installed 6.13.7 in the guest for comparison, but that just made
the issue worse, because it uses a higher frequency for the timer.

Is this something Linux should/could handle differently? I suppose there
is nothing that can be done on the QEMU side to avoid this while aiming
to keep the implementation correct?

If necessary, our management layer downstream could disable the hpet
timer by default and make users explicitly enable it if
desired/required. I just wanted to ask if the issue is known and if
there are any other suggestions? Thanks!

Best Regards,
Fiona


