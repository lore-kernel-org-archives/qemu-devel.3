Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A38FC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfRm-0001JS-Vt; Mon, 24 Feb 2025 15:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tmfRl-0001JB-Ek
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:53:01 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tmfRj-0005C6-25
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:53:01 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220d28c215eso75290295ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740430377; x=1741035177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MucZrRAiftAZglxTBuWuYGvPsPPilrwX3iRaXpSVwgU=;
 b=WASCfcxt9b1ysCr8YwYX+nPlnkRicVEOBlRJmnky8BLzUB1X21DBuVwOBipVNYIDGX
 rbCiKOlr2M2CGYc1oiy4tsRYmgxMNnVuSztZ4R4MyLQcG8UfKHBc9D0y2HI7ihlsk9ea
 K/vFxDIN2UDC/vXuzXIGyUD2v5bFjBkdLoEkOtr3K6QDWiNIbaSIcdKKPFVhAaIImuTP
 pybf5u+BxICq1AeKYB56T6Q5c66noqm8x7PFOuctyNDtk5nzbTYtnr+SUzDtWggXVeuQ
 IEbbJfZbfg3AZ+oglSKtIEUmHjAAx0qbuSKyBbwukT+DVeD7JnUKEQvjyOo9CqVcbU/C
 99lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740430377; x=1741035177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MucZrRAiftAZglxTBuWuYGvPsPPilrwX3iRaXpSVwgU=;
 b=iXqTQpyBiRC9hbzGoXaQcG/sAfskvMh3QtyCxbRfD7prEmRN9N4Je+grycuqPYM8o+
 M37k98/kA85BvFXv7FKKkba7Xi4KopNpnW4DAaveiuXq2dt9+LIrAcLZMVRLiX6z2YxE
 MYcKmYmGHKtpWWoMHtBoxdJoV24uaYYMv8qCRsPT3CvMFTTtq6MaCN9rd86CsvYAQrBZ
 XnqEyUR9as2xS4zbIHbXUCzZTb3FJZ9NmatQNIThseP7T+c7GTMZydDj9grO2thhnoEK
 OOCXqZXmJutJjcxigYSVUkEGUwOhuQzfNXxh43WvHlT+jxbvkB9jHkXMcMrH6GbWWcYG
 OvCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFF6PZX6jGtFcxpwy+3BJ2dJlY9R/ud16Y1ZxFLwWD8D07IIYuBT35N1y9LA/a2JHIJm0gL3vqb2jm@nongnu.org
X-Gm-Message-State: AOJu0YzLNyXlm13ilA+qRcfGrzOQzIAdKj0gDe/+Vz+1VaHn2L20xVAd
 a5Y6hHyKEZimNRHtCrbHdp6xvd/GYcDoiAoU275BA3+EDdwoEQq/xYDdSAsXLRI=
X-Gm-Gg: ASbGncssraR0idFngEg0RSfkmO85yPGTvMtKyKmHArj6XYKs3rED7Z4ONFftAHQbETJ
 aWxfOomwAvY3JenIpRsje9+wtESz6JNNWhGU43+qG8GIfSsiEO95zNbjpDkGRQhVCxL74jfHAjd
 fySG8u4ztA8gPFrAEONEfrLe25lY1j3WlxsRSmlWfRVPHpwXJOFcEjqXkfyd6V97mWx1XYGd9+V
 Z/zpCMc4uVOfF13Q3uZbxcICUiu3uQ6wmoKg/jxy8yg2ID8ds3BDJJtERs+T+cK28ijhKhwo+au
 iZW2f+Ee7b6tH0thW66ztXw+o797zh5i4EzOE/Y=
X-Google-Smtp-Source: AGHT+IHjqVS408sbE8e0VH2nj6AKz24WIOnbZBnEjorQrLbjbZtYhX/OPEgepEmlb6PUJ8Eaj7bh0g==
X-Received: by 2002:a17:903:32cc:b0:220:c94f:eb28 with SMTP id
 d9443c01a7336-22307b5b09amr11272285ad.27.1740430377494; 
 Mon, 24 Feb 2025 12:52:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0960edsm378055ad.138.2025.02.24.12.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 12:52:57 -0800 (PST)
Message-ID: <4ff5c838-27b8-43ce-adb9-1816c9e4a097@linaro.org>
Date: Mon, 24 Feb 2025 12:52:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/17] hw/misc: Add nr_regs and cold_reset_values to
 NPCM GCR
Content-Language: en-US
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com,
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me,
 philmd@linaro.org
References: <20250219184609.1839281-1-wuhaotsh@google.com>
 <20250219184609.1839281-7-wuhaotsh@google.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250219184609.1839281-7-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello,

This patch introduces a buffer-overflow, now reported by address sanitizer.

I sent a patch:
https://lore.kernel.org/qemu-devel/20250224205053.104959-1-
pierrick.bouvier@linaro.org/T/#u

You're welcome to review it, or fix the problem differently if there is 
a better approach.

Regards,
Pierrick

On 2/19/25 10:45, Hao Wu wrote:
> These 2 values are different between NPCM7XX and NPCM8XX
> GCRs. So we add them to the class and assign different values
> to them.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_gcr.c         | 27 ++++++++++++++++-----------
>   include/hw/misc/npcm_gcr.h | 13 +++++++++++--
>   2 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
> index 0959f2e5c4..d89e8c2c3b 100644
> --- a/hw/misc/npcm_gcr.c
> +++ b/hw/misc/npcm_gcr.c
> @@ -66,10 +66,9 @@ enum NPCM7xxGCRRegisters {
>       NPCM7XX_GCR_SCRPAD          = 0x013c / sizeof(uint32_t),
>       NPCM7XX_GCR_USB1PHYCTL,
>       NPCM7XX_GCR_USB2PHYCTL,
> -    NPCM7XX_GCR_REGS_END,
>   };
>   
> -static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
> +static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
>       [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
>       [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
>       [NPCM7XX_GCR_SPSWC]         = 0x00000003,
> @@ -88,8 +87,9 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       uint32_t reg = offset / sizeof(uint32_t);
>       NPCMGCRState *s = opaque;
> +    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
>   
> -    if (reg >= NPCM7XX_GCR_NR_REGS) {
> +    if (reg >= c->nr_regs) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
>                         __func__, offset);
> @@ -106,11 +106,12 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
>   {
>       uint32_t reg = offset / sizeof(uint32_t);
>       NPCMGCRState *s = opaque;
> +    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
>       uint32_t value = v;
>   
> -    trace_npcm_gcr_write(offset, value);
> +    trace_npcm_gcr_write(offset, v);
>   
> -    if (reg >= NPCM7XX_GCR_NR_REGS) {
> +    if (reg >= c->nr_regs) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
>                         __func__, offset);
> @@ -156,10 +157,12 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
>   static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
>   {
>       NPCMGCRState *s = NPCM_GCR(obj);
> +    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
>   
> -    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> -
> -    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> +    g_assert(sizeof(s->regs) >= sizeof(c->cold_reset_values));
> +    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
> +    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
> +    /* These 3 registers are at the same location in both 7xx and 8xx. */
>       s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
>       s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
>       s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
> @@ -224,7 +227,7 @@ static const VMStateDescription vmstate_npcm_gcr = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
> +        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM_GCR_MAX_NR_REGS),
>           VMSTATE_END_OF_LIST(),
>       },
>   };
> @@ -238,7 +241,6 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
>       dc->realize = npcm_gcr_realize;
>       dc->vmsd = &vmstate_npcm_gcr;
>   
> @@ -247,13 +249,15 @@ static void npcm_gcr_class_init(ObjectClass *klass, void *data)
>   
>   static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
>   {
> +    NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
> -    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END != NPCM7XX_GCR_NR_REGS);
>       dc->desc = "NPCM7xx System Global Control Registers";
>       rc->phases.enter = npcm7xx_gcr_enter_reset;
>   
> +    c->nr_regs = NPCM7XX_GCR_NR_REGS;
> +    c->cold_reset_values = npcm7xx_cold_reset_values;
>   }
>   
>   static const TypeInfo npcm_gcr_info[] = {
> @@ -262,6 +266,7 @@ static const TypeInfo npcm_gcr_info[] = {
>           .parent             = TYPE_SYS_BUS_DEVICE,
>           .instance_size      = sizeof(NPCMGCRState),
>           .instance_init      = npcm_gcr_init,
> +        .class_size         = sizeof(NPCMGCRClass),
>           .class_init         = npcm_gcr_class_init,
>           .abstract           = true,
>       },
> diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
> index 6d3d00d260..9af24e5cdc 100644
> --- a/include/hw/misc/npcm_gcr.h
> +++ b/include/hw/misc/npcm_gcr.h
> @@ -18,6 +18,7 @@
>   
>   #include "exec/memory.h"
>   #include "hw/sysbus.h"
> +#include "qom/object.h"
>   
>   /*
>    * NPCM7XX PWRON STRAP bit fields
> @@ -53,6 +54,7 @@
>    * Number of registers in our device state structure. Don't change this without
>    * incrementing the version_id in the vmstate.
>    */
> +#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
>   #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
>   
>   typedef struct NPCMGCRState {
> @@ -60,15 +62,22 @@ typedef struct NPCMGCRState {
>   
>       MemoryRegion iomem;
>   
> -    uint32_t regs[NPCM7XX_GCR_NR_REGS];
> +    uint32_t regs[NPCM_GCR_MAX_NR_REGS];
>   
>       uint32_t reset_pwron;
>       uint32_t reset_mdlr;
>       uint32_t reset_intcr3;
>   } NPCMGCRState;
>   
> +typedef struct NPCMGCRClass {
> +    SysBusDeviceClass parent;
> +
> +    size_t nr_regs;
> +    const uint32_t *cold_reset_values;
> +} NPCMGCRClass;
> +
>   #define TYPE_NPCM_GCR "npcm-gcr"
>   #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
> -OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)
> +OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)
>   
>   #endif /* NPCM_GCR_H */


