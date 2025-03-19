Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FABC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvmf-0005Ip-6A; Wed, 19 Mar 2025 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tuvmS-0005GC-RR
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:56:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tuvmM-00085C-3i
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:56:32 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2BA04419A3;
 Wed, 19 Mar 2025 16:56:22 +0100 (CET)
Message-ID: <caf36713-7067-4e55-92a0-0b813b5ba19e@proxmox.com>
Date: Wed, 19 Mar 2025 16:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/11] hpet: fix and cleanup persistence of interrupt status
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-6-pbonzini@redhat.com>
 <8183674f-a9cc-4727-bb52-fe3d3e44804b@proxmox.com>
 <CABgObfaKJ5NFVKmYLFmu4C0iZZLJJtcWksLCzyA0tBoz0koZ4A@mail.gmail.com>
 <dffba4bb-081b-4f34-a9d4-ce16d8d6a15a@proxmox.com>
 <CABgObfYnOzg=BPeG5BjSmGEV_Q0pR7xGg6L3XNQCONtU_GiuGA@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CABgObfYnOzg=BPeG5BjSmGEV_Q0pR7xGg6L3XNQCONtU_GiuGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 19.03.25 um 16:51 schrieb Paolo Bonzini:
> On Wed, Mar 19, 2025 at 4:47 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>> We'll only be able to disable it starting from a new (downstream)
>> machine version, but that is fine. For now, I'll go for the revert,
>> thank you for the suggestion! Is disabling it strongly suggested because
>> of those bug reports? Or are there issues in general?
> 
> No, the bug reports are really just for corner cases and there are no
> huge issues. However, both Linux and Windows give the HPET a
> relatively high priority that it probably does not deserve. :)
> 
> For Linux you should be using kvmclock already, and for Windows the
> Hyper-V paravirtualized clock. If you don't have the Hyper-V pv clock,
> the RTC periodic timer is more battle-tested as an emulated
> clock/timer device; disabling the HPET ensures that Windows uses the
> RTC.

Good to know! Right, for Windows guests, we actually already disable HPET :)

Best Regards,
Fiona


