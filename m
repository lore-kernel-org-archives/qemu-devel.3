Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15369CCD185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 01:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8TOI-00086i-Qj; Mon, 13 Oct 2025 20:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8TOH-00086Z-5Q
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 20:59:49 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8TOD-0001iJ-Ox
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 20:59:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760403569; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=alW0lnQhP/ZVtYgAZI55A2D/y0kZ32I5fCe9wXNUY9AtOvFsb/paQiXDtXTkhgaLFFGEudeTywR5Y3F7qjp9f5ulNVFmQLVCCR94OtGpbukgXyTlTj8W/Kmcu0mBRkFDp0WszuT218JJxU6DVoyHNYEv5yB082zhQsZVk/S6oOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760403569;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QXCenP5Gm35OLBnk4m4/EWtxc7TXt6DjGIME68bOnWU=; 
 b=aF7joMGH0Jdpvic5cYJnNzrq9FnlYkU1DkWk98h84cX5r7rkDDgeu1bcia0EBbd01pK8EdHagvx+hWfUjHp6+GyMad3242NMwEf4exSLFI4Jp30/DsVBsjkWwmCRR1zWd/oKv+k2Q7Tap8IUWQgXuqY8FiYcnpeEGu27yEdP9ko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760403569; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=QXCenP5Gm35OLBnk4m4/EWtxc7TXt6DjGIME68bOnWU=;
 b=Lb1kZbC+V7YCJqSMBGV/DPQBJ4e7DAyOn4vGqVkVT7TtR1F69nalqCRiV2C9IymJ
 byO4ZVFfXZE6n8KXNgoWkN6e0bIct44W95xXNX1GYK19tAE140ZmlaZ6CHzOWZRN6h1
 WxFmV2DgieIG85R50SmBzVx5dZ2oUEVL63Zr2Cxg=
Received: by mx.zohomail.com with SMTPS id 1760403566013776.7243932602355;
 Mon, 13 Oct 2025 17:59:26 -0700 (PDT)
Message-ID: <9eaadef8-2fa7-4fb0-aeff-9842a75c3804@collabora.com>
Date: Tue, 14 Oct 2025 03:59:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v6 1/1] Honor guest PAT on x86, absent Bochs display
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <176006500714.5527.9159197863408802401-1@git.sr.ht>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <176006500714.5527.9159197863408802401-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/10/25 05:43, ~myrslint wrote:
> From: myrslint <qemu.haziness801@passinbox.com>
> 
> On x86_64, where most CPUs support self-snoop, it is preferrable to
> always honor guest PAT. Not doing so is a quirk. There is a default
> enabled KVM quirk flag which enforces not doing so due to a former bug
> in Bochs display driver.
> 
> The bug has been fixed but not enough has yet passed since so we only
> disable said quirk flag if a Bochs display is not configured for the
> virtual machine.
> 
> This commit also moves around a bit of code that would be called when
> the initialization of a VM is done.
> 
> Signed-off-by: myrslint <qemu.haziness801@passinbox.com>
> ---
>  accel/kvm/kvm-all.c        |  1 +
>  accel/stubs/kvm-stub.c     |  1 +
>  hw/display/bochs-display.c |  5 +++++
>  include/system/kvm.h       |  9 ++++++++
>  target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
>  5 files changed, 51 insertions(+), 7 deletions(-)
> 

...
> +#include "system/kvm.h"
> +
>  typedef struct BochsDisplayMode {
>      pixman_format_code_t format;
>      uint32_t             bytepp;
> @@ -261,6 +263,7 @@ static const GraphicHwOps bochs_display_gfx_ops = {
>      .gfx_update = bochs_display_update,
>  };
>  
> +

Nit: please remove the extra newline

>  static void bochs_display_realize(PCIDevice *dev, Error **errp)
>  {
>      BochsDisplayState *s = BOCHS_DISPLAY(dev);
> @@ -309,6 +312,8 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
>      }
>  
>      memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
> +
> +    kvm_bochs_drm = true;

The patch looks good, only minor suggestions from me:

1. rename kvm_bochs_drm -> kvm_bochs_drm_quirk for more clarity

2. add clarifying comment to the code explaining what this quirk does
and why it's needed, basically repeating the commit msg

...
> +static void handle_machine_done(Notifier *n, void *unused)
> +{
> +    if (kvm_x86_smm_enabled()) {
> +        register_smram_listener();
> +    }
> +    if (!kvm_has_bochs_drm() && \
> +        (kvm_x86_disable_quirsk2_mask() & KVM_X86_QUIRK_IGNORE_GUEST_PAT)) {
> +        if (kvm_disable_ignore_guest_pat()) {
> +            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
> +                         "modifiable but we failed to disable it\n");

Nit: the extra "\n" shouldn't be needed for error_report()


-- 
Best regards,
Dmitry

