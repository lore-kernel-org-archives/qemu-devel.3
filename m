Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56E7CFA746
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 04:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swZko-0000QH-Mu; Fri, 04 Oct 2024 00:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swZkj-0000Pg-HK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 00:17:17 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swZkf-0001KW-Ui
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 00:17:17 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8323dddfca2so96795039f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 21:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728015432; x=1728620232;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BnrDyQLhR0U+YMI1a3HCP/1jOkmY5FsSDonFN4KJZLs=;
 b=1P3t6I1BSZQ+ruNRha+MQq78mXY42NgtUJJog9+yal8adw6SXP7VydYpQhAJv3rAM/
 +86RguQ8sMrtFeu1oBoeUBf3+wAtVqO95Vy5DvMwzLlwf/zg+ceUCt7ziN5s/oWcle/E
 6NJ43Fv0JzkUwQ0U/jTgSFNLlFRJokuGtux+3e7UhGwwHHOyw4h4o5KB7IqTSCz9yHPN
 xLPHyEFqUvyZV4WYBqOdGrajXhHUPHtXCtyXr9IhbeQGESbumggifZR2VVK/MbFSExyO
 73XYx/0DNr0mNQp5OKxStGeDsbMxjZ4Q8HvDi4GooYs864Wz1v3HHT5s9WPpn2LFkp68
 sJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728015432; x=1728620232;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BnrDyQLhR0U+YMI1a3HCP/1jOkmY5FsSDonFN4KJZLs=;
 b=HtHsJSI7KPcoj6W4Wqp09f0Y9RE4aMWqJE+MBv2Wyehp8Ca/3H5ykrWFGCYYXskL/v
 BU1o1h0CH4v+wA2aH8BDQheD5Ri4Cvh0mzDEgHv85LSBLa4ynQRRW7ROfo/L8Yo7urwY
 ECQCtCI0knWqfvWUaKaOLWryIKg3ZeWrUfkVVG0qEwqTySckwfuhYKM3WJpt42LsYQvq
 26IauvsFn0jpfwuL4g++qpJ7vVfj5U2nk5jgsGUZIeCvFdJjIiwCKwDCnDkhSxcMP89B
 EKNHun34Rnyf98nt+Ik2lYL0MK3tOZl4NpkdSEuLV1Lo653073c37MmH35uCpTLC/Gwu
 T0Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5nmiglFBIYmOWj3LXyoKmNRBsAepdE6yEhLjLrBfTrrMiWyXs1y+m+mxHqNOAOZ1XVxI1nRK+Pv9S@nongnu.org
X-Gm-Message-State: AOJu0Yy2IWIgDC1wIX7svxHgiW5aWQY5bggW4BsAh469od8cr1vbun2t
 V/tPtBQkh7o6fMhW9QfBXPHxZCq7mlQzCsQK6j/MzGAmpaQtyfoeLjfY5zoCIgk=
X-Google-Smtp-Source: AGHT+IFwgWkppUKlUN22iS7kotc4eXH+WvkeslJdwC+mDaCcsP38i+NZEjArJefU84JMIZp250a4hA==
X-Received: by 2002:a05:6e02:2195:b0:3a3:6ada:9a62 with SMTP id
 e9e14a558f8ab-3a375976d4dmr16624715ab.1.1728015432467; 
 Thu, 03 Oct 2024 21:17:12 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9dcb4fc47sm1559411a12.71.2024.10.03.21.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 21:17:11 -0700 (PDT)
Message-ID: <ab82d2b3-4b06-4f9e-b58a-ea9a5d6c5000@daynix.com>
Date: Fri, 4 Oct 2024 13:17:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v3 04/14] hw/display/apple-gfx: Adds configurable mode list
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-5-phil@philjordan.eu>
Content-Language: en-US
In-Reply-To: <20240928085727.56883-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd33.google.com
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

On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> This change adds a property 'display_modes' on the graphics device
> which permits specifying a list of display modes. (screen resolution
> and refresh rate)
> 
> PCI variant of apple-gfx only for the moment.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/display/apple-gfx-pci.m |  43 ++++++++++-
>   hw/display/apple-gfx.h     |  17 ++++-
>   hw/display/apple-gfx.m     | 151 ++++++++++++++++++++++++++++++++++---
>   3 files changed, 198 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
> index 9370258ee46..ea86a1f4a21 100644
> --- a/hw/display/apple-gfx-pci.m
> +++ b/hw/display/apple-gfx-pci.m
> @@ -16,6 +16,7 @@
>   #include "apple-gfx.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/pci/msi.h"
> +#include "hw/qdev-properties.h"
>   #include "qapi/error.h"
>   #include "trace.h"
>   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> @@ -101,6 +102,46 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
>       [s->common.pgdev reset];
>   }
>   
> +static void apple_gfx_pci_get_display_modes(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    Property *prop = opaque;
> +    AppleGFXDisplayModeList *mode_list = object_field_prop_ptr(obj, prop);
> +
> +    apple_gfx_get_display_modes(mode_list, v, name, errp);
> +}
> +
> +static void apple_gfx_pci_set_display_modes(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    Property *prop = opaque;
> +    AppleGFXDisplayModeList *mode_list = object_field_prop_ptr(obj, prop);
> +
> +    apple_gfx_set_display_modes(mode_list, v, name, errp);
> +}
> +
> +const PropertyInfo apple_gfx_pci_prop_display_modes = {
> +    .name  = "display_modes",
> +    .description =
> +        "Colon-separated list of display modes; "
> +        "<width>x<height>@<refresh-rate>; the first mode is considered "
> +        "'native'. Example: 3840x2160@60:2560x1440@60:1920x1080@60",

Please use DEFINE_PROP_ARRAY() instead of inventing your own way to 
define an array.

> +    .get   = apple_gfx_pci_get_display_modes,
> +    .set   = apple_gfx_pci_set_display_modes,
> +};
> +
> +#define DEFINE_PROP_DISPLAY_MODES(_name, _state, _field) \
> +    DEFINE_PROP(_name, _state, _field, apple_gfx_pci_prop_display_modes, \
> +                AppleGFXDisplayModeList)
> +
> +static Property apple_gfx_pci_properties[] = {
> +    DEFINE_PROP_DISPLAY_MODES("display-modes", AppleGFXPCIState,
> +                              common.display_modes),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -118,7 +159,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
>       pci->class_id = PCI_CLASS_DISPLAY_OTHER;
>       pci->realize = apple_gfx_pci_realize;
>   
> -    // TODO: Property for setting mode list
> +    device_class_set_props(dc, apple_gfx_pci_properties);
>   }
>   
>   static TypeInfo apple_gfx_pci_types[] = {
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> index 995ecf7f4a7..baad4a98652 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -5,14 +5,28 @@
>   #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
>   
>   #include "qemu/typedefs.h"
> +#include "qemu/osdep.h"
>   
>   typedef struct AppleGFXState AppleGFXState;
>   
> +typedef struct AppleGFXDisplayMode {
> +    uint16_t width_px;
> +    uint16_t height_px;
> +    uint16_t refresh_rate_hz;
> +} AppleGFXDisplayMode;
> +
> +typedef struct AppleGFXDisplayModeList {
> +    GArray *modes;
> +} AppleGFXDisplayModeList;
> +
>   void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
> +void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
> +                                 const char *name, Error **errp);
> +void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
> +                                 const char *name, Error **errp);
>   
>   #ifdef __OBJC__
>   
> -#include "qemu/osdep.h"
>   #include "exec/memory.h"
>   #include "ui/surface.h"
>   #include <dispatch/dispatch.h>
> @@ -38,6 +52,7 @@ struct AppleGFXState {
>       bool new_frame;
>       bool cursor_show;
>       QEMUCursor *cursor;
> +    AppleGFXDisplayModeList display_modes;
>   
>       dispatch_queue_t render_queue;
>       /* The following fields should only be accessed from render_queue: */
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index 6ef1048d93d..358192db6a0 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -16,6 +16,9 @@
>   #include "trace.h"
>   #include "qemu-main.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/cutils.h"
> +#include "qapi/visitor.h"
> +#include "qapi/error.h"
>   #include "ui/console.h"
>   #include "monitor/monitor.h"
>   #include "qapi/error.h"
> @@ -23,9 +26,10 @@
>   #include <mach/mach_vm.h>
>   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
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
>   typedef struct PGTask_s { // Name matches forward declaration in PG header
> @@ -264,7 +268,6 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
>   static void create_fb(AppleGFXState *s)
>   {
>       s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
> -    set_mode(s, 1440, 1080);
>   
>       s->cursor_show = true;
>   }
> @@ -466,20 +469,24 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>       return disp_desc;
>   }
>   
> -static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
> +static NSArray<PGDisplayMode*>* apple_gfx_create_display_mode_array(
> +    const AppleGFXDisplayMode display_modes[], int display_mode_count)
>   {
> -    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> +    PGDisplayMode **modes = alloca(sizeof(modes[0]) * display_mode_count);
>       NSArray<PGDisplayMode*>* mode_array = nil;
>       int i;
>   
> -    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> +    for (i = 0; i < display_mode_count; i++) {
> +        const AppleGFXDisplayMode *mode = &display_modes[i];
> +        PGDisplayCoord_t mode_size = { mode->width_px, mode->height_px };
>           modes[i] =
> -            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> +            [[PGDisplayMode alloc] initWithSizeInPixels:mode_size
> +                                        refreshRateInHz:mode->refresh_rate_hz];
>       }
>   
> -    mode_array = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
> +    mode_array = [NSArray arrayWithObjects:modes count:display_mode_count];
>   
> -    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> +    for (i = 0; i < display_mode_count; i++) {
>           [modes[i] release];
>           modes[i] = nil;
>       }
> @@ -516,6 +523,8 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>   void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
>   {
>       PGDisplayDescriptor *disp_desc = nil;
> +    const AppleGFXDisplayMode *display_modes = apple_gfx_default_modes;
> +    int num_display_modes = ARRAY_SIZE(apple_gfx_default_modes);
>   
>       QTAILQ_INIT(&s->tasks);
>       s->render_queue = dispatch_queue_create("apple-gfx.render",
> @@ -533,7 +542,127 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
>       s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
>                                                 port:0 serialNum:1234];
>       [disp_desc release];
> -    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> +
> +    if (s->display_modes.modes != NULL && s->display_modes.modes->len > 0) {
> +        display_modes =
> +            &g_array_index(s->display_modes.modes, AppleGFXDisplayMode, 0);
> +        num_display_modes = s->display_modes.modes->len;
> +    }
> +    s->pgdisp.modeList =
> +        apple_gfx_create_display_mode_array(display_modes, num_display_modes);
>   
>       create_fb(s);
>   }
> +
> +void apple_gfx_get_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
> +                                 const char *name, Error **errp)
> +{
> +    GArray *modes = mode_list->modes;
> +    /* 3 uint16s (max 5 digits) and 3 separator characters per mode + nul. */
> +    size_t buffer_size = (5 + 1) * 3 * modes->len + 1;
> +
> +    char *buffer = alloca(buffer_size);
> +    char *pos = buffer;
> +
> +    unsigned used = 0;
> +    buffer[0] = '\0';
> +    for (guint i = 0; i < modes->len; ++i)
> +    {
> +        AppleGFXDisplayMode *mode =
> +            &g_array_index(modes, AppleGFXDisplayMode, i);
> +        int rc = snprintf(pos, buffer_size - used,
> +                          "%s%"PRIu16"x%"PRIu16"@%"PRIu16,
> +                          i > 0 ? ":" : "",
> +                          mode->width_px, mode->height_px,
> +                          mode->refresh_rate_hz);
> +        used += rc;
> +        pos += rc;
> +        assert(used < buffer_size);
> +    }
> +
> +    pos = buffer;
> +    visit_type_str(v, name, &pos, errp);
> +}
> +
> +void apple_gfx_set_display_modes(AppleGFXDisplayModeList *mode_list, Visitor *v,
> +                                 const char *name, Error **errp)
> +{
> +    Error *local_err = NULL;
> +    const char *endptr;
> +    char *str;
> +    int ret;
> +    unsigned int val;
> +    uint32_t num_modes;
> +    GArray *modes;
> +    uint32_t mode_idx;
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    // Count colons to estimate modes. No leading/trailing colons so start at 1.
> +    num_modes = 1;
> +    for (size_t i = 0; str[i] != '\0'; ++i)
> +    {
> +        if (str[i] == ':') {
> +            ++num_modes;
> +        }
> +    }
> +
> +    modes = g_array_sized_new(false, true, sizeof(AppleGFXDisplayMode), num_modes);
> +
> +    endptr = str;
> +    for (mode_idx = 0; mode_idx < num_modes; ++mode_idx)
> +    {
> +        AppleGFXDisplayMode mode = {};
> +        if (mode_idx > 0)
> +        {
> +            if (*endptr != ':') {
> +                goto separator_error;
> +            }
> +            ++endptr;
> +        }
> +
> +        ret = qemu_strtoui(endptr, &endptr, 10, &val);
> +        if (ret || val > UINT16_MAX || val == 0) {
> +            error_setg(errp, "width of '%s' must be a decimal integer number "
> +                       "of pixels in the range 1..65535", name);
> +            goto out;
> +        }
> +        mode.width_px = val;
> +        if (*endptr != 'x') {
> +            goto separator_error;
> +        }
> +
> +        ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
> +        if (ret || val > UINT16_MAX || val == 0) {
> +            error_setg(errp, "height of '%s' must be a decimal integer number "
> +                       "of pixels in the range 1..65535", name);
> +            goto out;
> +        }
> +        mode.height_px = val;
> +        if (*endptr != '@') {
> +            goto separator_error;
> +        }
> +
> +        ret = qemu_strtoui(endptr + 1, &endptr, 10, &val);
> +        if (ret) {
> +            error_setg(errp, "refresh rate of '%s'"
> +                       " must be a non-negative decimal integer (Hertz)", name);
> +        }
> +        mode.refresh_rate_hz = val;
> +        g_array_append_val(modes, mode);
> +    }
> +
> +    mode_list->modes = modes;
> +    goto out;
> +
> +separator_error:
> +    error_setg(errp, "Each display mode takes the format "
> +               "'<width>x<height>@<rate>', modes are separated by colons. (:)");
> +out:
> +    g_free(str);
> +    return;
> +}


