Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B0DD625FA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 07:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vipAB-0007K2-EJ; Thu, 22 Jan 2026 02:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vip9f-00072G-DR; Thu, 22 Jan 2026 02:31:05 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vip9c-0006Dk-KC; Thu, 22 Jan 2026 02:30:59 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60M7U85Q017084
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Jan 2026 16:30:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=61yzW9aRQJx0n0klDfuOnq1uMlSYoOX1ehdAVHURWKE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769067013; v=1;
 b=bfseSgTHbpJEp9CesdML3VbiJMUTYf8zqTdX1gHREOXwodXgwIX0pjXrp0X8ocya
 VzAeOLAc5926Goo1+n7SKK6Ap0QpjIPLBheJ3JUxsR91b+tNFndoEpMFsZ4aprxK
 Y8uZdctuheXjaviJMWR9A2CJbSF0IEMdCKVMbHoxC8nS8KWPe1dJyvsKUnJymdiJ
 YWNXz9ObDe2b3gsA0XS8wPz/ITjaY/WkWVo+A/Uz5e0kI1BEIOT/sF0D4gFIhsi7
 Ucm4T9gWVqF4Y+jEtSrHyhWewCqVyBoa3tpgLS71L64lt+ha+LZfZA3EI+GR0OiC
 KS+GYcmCv/CFIG0l6Uofng==
Message-ID: <0b7ca5c8-6627-4609-ae96-9436d578f43c@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 22 Jan 2026 16:30:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] vmapple: apple-gfx: move legacy memory management
 APIs away from inline
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>
References: <20260114152220.89640-1-mohamed@unpredictable.fr>
 <20260114152220.89640-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260114152220.89640-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/15 0:22, Mohamed Mediouni wrote:
> They're not function pointers but blocks.
> Adding this to address review comments but I don't think it's worthwhile.

Address review comments by *either* making an argument against review 
comments or making a change according to them; don't do both and send 
send a mixed signal.

I think your argument is sensible and this patch should be dropped.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/display/apple-gfx-mmio.m | 31 ++++++++++++++++++-------------
>   1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> index 2031baceda..fa4362653b 100644
> --- a/hw/display/apple-gfx-mmio.m
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -188,6 +188,22 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
>       return true;
>   }
>   
> +/* Legacy memory management API: Gone in macOS 15.4 and later. */
> +static bool (^apple_gfx_map_memory)
> + (uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f)
> + = ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f){
> +    *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> +
> +    trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> +
> +    return *va != NULL;
> +};
> +
> +static bool (^apple_gfx_unmap_memory)(void *va, void *b, void *c, void *d, void *e, void *f)
> + = ^bool(void *va, void *b, void *c, void *d, void *e, void *f){
> +    return apple_gfx_mmio_unmap_surface_memory(va);
> +};
> +
>   static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
>       AppleGFXMMIOState *s)
>   {
> @@ -207,19 +223,8 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
>           iosfc_desc.mmioLength = 0x10000;
>           iosfc_desc.memoryMapDescriptor = memoryMapDescriptor;
>       } else {
> -        iosfc_desc.mapMemory =
> -            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> -                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> -
> -                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> -
> -                return *va != NULL;
> -            };
> -
> -        iosfc_desc.unmapMemory =
> -            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> -                return apple_gfx_mmio_unmap_surface_memory(va);
> -            };
> +        iosfc_desc.mapMemory = apple_gfx_map_memory;
> +        iosfc_desc.unmapMemory = apple_gfx_unmap_memory;
>       }
>   
>       iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {


