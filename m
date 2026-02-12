Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C20EEE36AE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqaGe-00063W-5n; Thu, 12 Feb 2026 12:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1vqaGc-000631-Fh
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:14:14 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1vqaGa-0001c0-Vs
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=0lIxgB38Z1IpChk/3gsaDwm0GDKDNEv82RrB4uVgH00=; b=E9tR49BoxnMNuL2hxFNiUmscAA
 37tSGNXofU5ulE5vz00IvtiErC4gU/6iIDw6mSlyCDcP1NpFcTXGkxIhH6toRSpuo62kPWsaNBIjg
 +Bcpcz4/QfJ1URZiQl58suFeSfK6xYiIHSuh9+zoFI3yKoaKTH+p/u5AmwH+tiSUN0M0=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1vqaGW-005Hen-0x;
 Thu, 12 Feb 2026 17:14:08 +0000
Received: from [2a01:cb15:80df:da00:6611:8a9c:a536:346a] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1vqaGV-0058uM-1j;
 Thu, 12 Feb 2026 17:14:08 +0000
Date: Thu, 12 Feb 2026 18:14:06 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH] xen-hvm: Handle framebuffer relocation
Message-ID: <aY4KXj5ReRxCNbGv@l14>
References: <20260108132514.1862552-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108132514.1862552-1-ross.lagerwall@citrix.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 08, 2026 at 01:25:14PM +0000, Ross Lagerwall wrote:
> It is possible for a guest to relocate the linear framebuffer by writing
> to the VGA device's BAR. This causes QEMU to report an error and if the
> VM is migrated, the destination QEMU hits an assertion.
> The problem is that updating the BAR causes the PCI core code to call
> the del region callback followed by the add region callback but the
> xen-hvm code ignores the del region call and therefore the subsequent
> call to xen_relocate_memory() during the add region callback fails
> because the source address is not correct.
> 
> Fix it by calling in to xen_remove_from_physmap() in response to a
> del region callback for the linear framebuffer so that the subsequent
> add region callback succeeds.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index a6e1683885a0..fd7ef56bdba9 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -720,7 +720,8 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
>          return;
>      }
>  
> -    if (log_dirty != add) {
> +    if (log_dirty != add &&
> +        !(section->mr == framebuffer && start_addr > 0xbffff)) {
>          return;
>      }
>  

That condition and others on the path are getting convoluted, and
there's a similar condition in xen_add_to_physmap(). I wonder if the
condition is still useful. Anyway, it seems to be good enough. I've
given a try and do see an extra "xen: unmapping vram" and "xen: mapping
vram" when I migrate a guest. So all good:

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 
Anthony PERARD

