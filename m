Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94764EF8FE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxlxr-0007f4-Vk; Wed, 04 Mar 2026 08:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vxlxp-0007er-NW; Wed, 04 Mar 2026 08:08:33 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vxlxn-0005Ye-SG; Wed, 04 Mar 2026 08:08:33 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BF84041D98;
 Wed, 04 Mar 2026 14:08:28 +0100 (CET)
Message-ID: <5fcac7c0-2e20-4fe6-b857-77e436f368b8@proxmox.com>
Date: Wed, 4 Mar 2026 14:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: only migrate error code if actually set
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, wangxinxin.wang@huawei.com,
 qemu-stable@nongnu.org
References: <20260303144024.366764-1-f.ebner@proxmox.com>
Content-Language: en-US
In-Reply-To: <20260303144024.366764-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772629682064
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 03.03.26 um 4:57 PM schrieb Fiona Ebner:
> If cpu->env.has_error_code is true, backwards migration of a VM from
> a QEMU binary with commit 27535e9cca to a QEMU binary without commit
> 27535e9cca will fail:
> 
>> kvm: error while loading state for instance 0x0 of device 'cpu'
> 
> This happens even if error_code == 0. Fix it by only sending the
> error code if it is actually set.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 27535e9cca ("target/i386: Add support for save/load of exception error code")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  target/i386/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index c913961281..b47b14d819 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
>  {
>      X86CPU *cpu = opaque;
>  
> -    return cpu->env.has_error_code != 0;
> +    return cpu->env.has_error_code != 0 && cpu->env.error_code != 0;
>  }
>  
>  static const VMStateDescription vmstate_error_code = {

This is not enough in practice and we might need proper machine
versioning here.

For a guest with '-smp 4,sockets=1,cores=4,maxcpus=4' running Ubuntu
24.10, I still have issues, e.g. with error codes 6 and 20 being set
sometimes, leading to the following error again:
kvm: error while loading state for instance 0x0 of device 'cpu'

The original commit mentions guest kernel panics:

> commit 27535e9ccae89db5856bfb5e3357f44645812143
> Author: Xin Wang <wangxinxin.wang@huawei.com>
> Date:   Tue Aug 19 22:58:34 2025 +0800
> 
>     target/i386: Add support for save/load of exception error code
>     
>     For now, qemu save/load CPU exception info(such as exception_nr and
>     has_error_code), while the exception error_code is ignored. This will
>     cause the dest hypervisor reinject a vCPU exception with error_code(0),
>     potentially causing a guest kernel panic.
>     
>     For instance, if src VM stopped with an user-mode write #PF (error_code 6),
>     the dest hypervisor will reinject an #PF with error_code(0) when vCPU resume,
>     then guest kernel panic as:
>       BUG: unable to handle page fault for address: 00007f80319cb010
>       #PF: supervisor read access in user mode
>       #PF: error_code(0x0000) - not-present page
>       RIP: 0033:0x40115d
>     
>     To fix it, support save/load exception error_code.

Is there some other factor needed for the guest kernel panic to trigger?
Migrating my guest between 10.1.2 and 10.1.2 seems to work without any
noticeable issue within the guest even though I can see that error_code
is often set during the time of the migration.

Best Regards,
Fiona


