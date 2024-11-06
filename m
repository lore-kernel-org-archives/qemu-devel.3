Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3ACD29FAF
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aJH-0005mk-OX; Wed, 06 Nov 2024 02:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8aJG-0005m4-Of
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:18:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8aJD-0007H5-Je
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:18:34 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c70abba48so57036245ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 23:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730877510; x=1731482310;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mwjcjta+UqNMI30m75CjEWyjUTGv3K0T8e6n7gP3+CU=;
 b=hgDqKUamqLnvNBn5J+RVpTYaAV37k77f893fW7h/bAansxpFn/qezKPoRNLpn9uO5X
 JV0ia0k12m5PEbuaVceKJHL8TdqqsoUoqNfirJx3/BdIupm9PAJ5rpVhoJ3DV0E/X0Y5
 a3mfpsCHRwoFb68LfFwz6OgbSVE7PLpBSDEsvuX7IbOk6CGDxe+xYW6ME3nbtmbGJiSZ
 nnd7PuNhspQkzBRNS7OaNld0LCDYmO0iPs0KCl4T3iL4Ww1e0W10WYyoRtfqzwWjvTAv
 gOYhTchqsg7gQeROnqbGuKKRgd69e0mON+ogjN0oRut9u3bzruO6PBvj8IyIWsd2POVK
 Iodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730877510; x=1731482310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwjcjta+UqNMI30m75CjEWyjUTGv3K0T8e6n7gP3+CU=;
 b=oBNfo58z+dmKbp1sUOt5eKvWBktGv91YlqfgsxltAuWXWPY2DzDuL7ZsX0IV7YCWav
 n9vYV1XONKmG1f9IyR9umMWkovbIKcv2hhmVNrV96N+t0Q+AcLULHhRJTdcqzlB6jv99
 Ompvg1/IjcNIO0L2tTCZcHXnxWihQcXC8UXGo0KkNl8PV0wIuk6Ux+gyNYfWtK48JBhK
 FaLXJoy61s8SPNcHSbq7e6M+266ZSBFcgTatcsdxGKotg/OzkYQOudUwHLoqm0z4V0q8
 PMhfoSTnXR8epgjmIZnRj4xHNVnNtIqWstsGnjSVnjd/JhcYci2N4vXb5d8FmW/ZIBxA
 JDkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgQZVN5/QWNwrlrA4GOd2nYrffv0s19mbQZqg+Za72J2wI5R8cFEgp5jQgh1+gSg4+v50ioIdnM7e5@nongnu.org
X-Gm-Message-State: AOJu0YxJFH5I3iwVxy9orSLHAcvdcyrx+BgkKEiWwoXzH+OUv6EsJhPu
 I7lMmjTPqixBfNTPULuRZ+XrdhAzXvERNSbXA+w9riz65NqQ5K0+LrqG19hvZoQ=
X-Google-Smtp-Source: AGHT+IGpucHVxL5hAVEjcCt+GR3ZtCTn3cTahnmNTaaeYVrII79JsOAk3sT/r5RkDUkZQsdHmrGKJA==
X-Received: by 2002:a17:90b:1c01:b0:2d8:3fe8:a195 with SMTP id
 98e67ed59e1d1-2e94c294fc3mr26275896a91.4.1730877509805; 
 Tue, 05 Nov 2024 23:18:29 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a5a542dsm833806a91.39.2024.11.05.23.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 23:18:29 -0800 (PST)
Message-ID: <3c3f5e98-ebe6-4b88-a9dd-4de3043431f4@daynix.com>
Date: Wed, 6 Nov 2024 16:18:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/15] hw/display/apple-gfx: Adds configurable mode list
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241105153022.91101-1-phil@philjordan.eu>
 <20241105153022.91101-5-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241105153022.91101-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/11/06 0:30, Phil Dennis-Jordan wrote:
> This change adds a property 'display_modes' on the graphics device
> which permits specifying a list of display modes. (screen resolution
> and refresh rate)
> 
> The property is an array of a custom type to make the syntax slightly
> less awkward to use, for example:
> 
> -device '{"driver":"apple-gfx-pci", "display-modes":["1920x1080@60", "3840x2160@60"]}'
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v4:
> 
>   * Switched to the native array property type, which recently gained
> 	 command line support.
>   * The property has also been added to the -mmio variant.
>   * Tidied up the code a little.
> 
> v5:
> 
>   * Better error handling and buffer management in property parsing and
>     output.
> 
> v6:
> 
>   * Switched to using NSMutableArray for the mode list to avoid need for
>     allocating a temporary array - previously done with alloca.
> 
> v7:
> 
>   * Simplified error handling in property parsing
> 
>   hw/display/apple-gfx-mmio.m |   8 +++
>   hw/display/apple-gfx-pci.m  |   9 ++-
>   hw/display/apple-gfx.h      |  12 ++++
>   hw/display/apple-gfx.m      | 136 +++++++++++++++++++++++++++++++-----
>   hw/display/trace-events     |   2 +
>   5 files changed, 147 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> index 10f52b0797b..54258782abe 100644
> --- a/hw/display/apple-gfx-mmio.m
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -258,6 +258,12 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
>       [s->common.pgdev reset];
>   }
>   
> +static Property apple_gfx_mmio_properties[] = {
> +    DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
> +                      common.num_display_modes, common.display_modes,
> +                      qdev_prop_display_mode, AppleGFXDisplayMode),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
>   
>   static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
>   {
> @@ -267,6 +273,8 @@ static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
>       rc->phases.hold = apple_gfx_mmio_reset;
>       dc->hotpluggable = false;
>       dc->realize = apple_gfx_mmio_realize;
> +
> +    device_class_set_props(dc, apple_gfx_mmio_properties);
>   }
>   
>   static TypeInfo apple_gfx_mmio_types[] = {
> diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
> index 8bd7c0df443..712a08a5c8f 100644
> --- a/hw/display/apple-gfx-pci.m
> +++ b/hw/display/apple-gfx-pci.m
> @@ -112,6 +112,13 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
>       [s->common.pgdev reset];
>   }
>   
> +static Property apple_gfx_pci_properties[] = {
> +    DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
> +                      common.num_display_modes, common.display_modes,
> +                      qdev_prop_display_mode, AppleGFXDisplayMode),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -128,7 +135,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
>       pci->class_id = PCI_CLASS_DISPLAY_OTHER;
>       pci->realize = apple_gfx_pci_realize;
>   
> -    // TODO: Property for setting mode list
> +    device_class_set_props(dc, apple_gfx_pci_properties);
>   }
>   
>   static TypeInfo apple_gfx_pci_types[] = {
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> index 91b55299338..3868ea87391 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -16,6 +16,7 @@
>   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>   #include "qemu/typedefs.h"
>   #include "exec/memory.h"
> +#include "hw/qdev-properties.h"
>   #include "ui/surface.h"
>   
>   @class PGDeviceDescriptor;
> @@ -27,6 +28,7 @@
>   
>   typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
>   
> +struct AppleGFXDisplayMode;
>   typedef struct AppleGFXState {
>       /* Initialised on init/realize() */
>       MemoryRegion iomem_gfx;
> @@ -36,6 +38,8 @@ typedef struct AppleGFXState {
>       id<MTLDevice> mtl;
>       id<MTLCommandQueue> mtl_queue;
>       dispatch_queue_t render_queue;
> +    struct AppleGFXDisplayMode *display_modes;
> +    uint32_t num_display_modes;
>   
>       /* List `tasks` is protected by task_mutex */
>       QemuMutex task_mutex;
> @@ -54,6 +58,12 @@ typedef struct AppleGFXState {
>       bool cursor_show;
>   } AppleGFXState;
>   
> +typedef struct AppleGFXDisplayMode {
> +    uint16_t width_px;
> +    uint16_t height_px;
> +    uint16_t refresh_rate_hz;
> +} AppleGFXDisplayMode;
> +
>   void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
>   void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
>                                 Error **errp);
> @@ -61,5 +71,7 @@ uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
>                                                  uint64_t length, bool read_only,
>                                                  MemoryRegion **mapping_in_region);
>   
> +extern const PropertyInfo qdev_prop_display_mode;
> +
>   #endif
>   
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index b0428648394..9670938f799 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -31,9 +31,10 @@
>   #include "sysemu/dma.h"
>   #include "ui/console.h"
>   
> -static const PGDisplayCoord_t apple_gfx_modes[] = {
> -    { .x = 1440, .y = 1080 },
> -    { .x = 1280, .y = 1024 },
> +static const AppleGFXDisplayMode apple_gfx_default_modes[] = {
> +    { 1920, 1080, 60 },
> +    { 1440, 1080, 60 },
> +    { 1280, 1024, 60 },
>   };
>   
>   /* ------ PGTask and task operations: new/destroy/map/unmap ------ */
> @@ -685,22 +686,24 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>       return disp_desc;
>   }
>   
> -static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
> +static NSArray<PGDisplayMode *> *apple_gfx_create_display_mode_array(
> +    const AppleGFXDisplayMode display_modes[], uint32_t display_mode_count)
>   {
> -    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> -    NSArray<PGDisplayMode*>* mode_array = nil;
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> -        modes[i] =
> -            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> -    }
> -
> -    mode_array = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
> -
> -    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> -        [modes[i] release];
> -        modes[i] = nil;
> +    uint32_t i;
> +    PGDisplayMode *mode_obj;
> +    NSMutableArray<PGDisplayMode *> *mode_array =
> +        [[NSMutableArray alloc] initWithCapacity:display_mode_count];
> +
> +    for (i = 0; i < display_mode_count; i++) {
> +        const AppleGFXDisplayMode *mode = &display_modes[i];
> +        trace_apple_gfx_display_mode(i, mode->width_px, mode->height_px);
> +        PGDisplayCoord_t mode_size = { mode->width_px, mode->height_px };
> +
> +        mode_obj =
> +            [[PGDisplayMode alloc] initWithSizeInPixels:mode_size
> +                                        refreshRateInHz:mode->refresh_rate_hz];
> +        [mode_array addObject:mode_obj];
> +        [mode_obj release];
>       }
>   
>       return mode_array;
> @@ -736,6 +739,9 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
>                                 Error **errp)
>   {
>       PGDisplayDescriptor *disp_desc = nil;
> +    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
> +    int num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);

Let's type it uint32_t to keep it consistent with 
apple_gfx_create_display_mode_array().

> +    NSArray<PGDisplayMode *> *mode_array;
>   
>       if (apple_gfx_mig_blocker == NULL) {
>           error_setg(&apple_gfx_mig_blocker,
> @@ -762,9 +768,101 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
>       s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
>                                                 port:0 serialNum:1234];
>       [disp_desc release];
> -    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> +
> +    if (s->display_modes != NULL && s->num_display_modes > 0) {
> +        trace_apple_gfx_common_realize_modes_property(s->num_display_modes);
> +        display_modes = s->display_modes;
> +        num_display_modes = s->num_display_modes;
> +    }
> +    s->pgdisp.modeList = mode_array =
> +        apple_gfx_create_display_mode_array(display_modes, num_display_modes);
> +    [mode_array release];
>   
>       s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
>   
>       qatomic_set(&s->cursor_show, true);
>   }
> +
> +/* ------ Display mode list device property ------ */
> +
> +static void apple_gfx_get_display_mode(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop = opaque;
> +    AppleGFXDisplayMode *mode = object_field_prop_ptr(obj, prop);
> +    /* 3 uint16s (max 5 digits) + 2 separator characters + nul. */
> +    char buffer[5 * 3 + 2 + 1];
> +    char *pos = buffer;
> +
> +    int rc = snprintf(buffer, sizeof(buffer),
> +                      "%"PRIu16"x%"PRIu16"@%"PRIu16,
> +                      mode->width_px, mode->height_px,
> +                      mode->refresh_rate_hz);
> +    assert(rc < sizeof(buffer));
> +
> +    visit_type_str(v, name, &pos, errp);
> +}
> +
> +static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop = opaque;
> +    AppleGFXDisplayMode *mode = object_field_prop_ptr(obj, prop);
> +    const char *endptr;
> +    g_autofree char *str = NULL;
> +    int ret;
> +    int val;
> +
> +    visit_type_str(v, name, &str, errp);
> +    if (*errp) {
> +        return;
> +    }
> +
> +    endptr = str;
> +
> +    ret = qemu_strtoi(endptr, &endptr, 10, &val);
> +    if (ret || val > UINT16_MAX || val <= 0) {
> +        error_setg(errp, "width in '%s' must be a decimal integer number "
> +                   "of pixels in the range 1..65535", name);
> +        return;
> +    }
> +    mode->width_px = val;
> +    if (*endptr != 'x') {
> +        goto separator_error;
> +    }
> +
> +    ret = qemu_strtoi(endptr + 1, &endptr, 10, &val);
> +    if (ret || val > UINT16_MAX || val <= 0) {
> +        error_setg(errp, "height in '%s' must be a decimal integer number "
> +                   "of pixels in the range 1..65535", name);
> +        return;
> +    }
> +    mode->height_px = val;
> +    if (*endptr != '@') {
> +        goto separator_error;
> +    }
> +
> +    ret = qemu_strtoi(endptr + 1, &endptr, 10, &val);
> +    if (ret || val > UINT16_MAX || val <= 0) {
> +        error_setg(errp, "refresh rate in '%s'"
> +                   " must be a positive decimal integer (Hertz)", name);
> +        return;
> +    }
> +    mode->refresh_rate_hz = val;
> +    return;
> +
> +separator_error:
> +    error_setg(errp, "Each display mode takes the format "
> +               "'<width>x<height>@<rate>'");
> +}
> +
> +const PropertyInfo qdev_prop_display_mode = {
> +    .name  = "display_mode",
> +    .description =
> +        "Display mode in pixels and Hertz, as <width>x<height>@<refresh-rate> "
> +        "Example: 3840x2160@60",
> +    .get   = apple_gfx_get_display_mode,
> +    .set   = apple_gfx_set_display_mode,
> +};
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 260eab9146d..4987cc2d357 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -212,6 +212,8 @@ apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d widt
>   apple_gfx_cursor_show(uint32_t show) "show=%d"
>   apple_gfx_cursor_move(void) ""
>   apple_gfx_common_init(const char *device_name, size_t mmio_size) "device: %s; MMIO size: %zu bytes"
> +apple_gfx_common_realize_modes_property(uint32_t num_modes) "using %u modes supplied by 'display-modes' device property"
> +apple_gfx_display_mode(uint32_t mode_idx, uint16_t width_px, uint16_t height_px) "mode %2"PRIu32": %4"PRIu16"x%4"PRIu16
>   
>   # apple-gfx-mmio.m
>   apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64


