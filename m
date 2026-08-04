Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60060C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr7pD-0005zn-B4; Tue, 04 Aug 2026 01:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wr7pB-0005zK-OZ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:36:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wr7p9-00072b-BM
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:36:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso32339945ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785821782; x=1786426582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XjUlHMDmEYRww5GYz+xDw+QZQfEX6f4KXeW2pr+vdtc=;
 b=Hqq0gHqLDVg2XFVDj477kxF6uVMWJnfeYHerGeNmwWCEXpnjCKiJ+vtw9NAC2cMVRt
 lSKotsAxsMrI0VIMhuwWLRoWJo+hsfomYgYFokQWWwXrqwsUo35f03nvEyejdGgKnFkP
 ZoQnYdjMllAlFlVQPCh12hnFqOo/u7l78t+OxqTW05pndFWz/kS0Hi0UmGa9fMPIB8/s
 EBp9QZKlS9VUbhxApParwVa2DvqCLr0xb5h9jinNB//5uuDkgjyemqCzqZ6cMyLDhXYp
 d6rKApYtdOwG9bDWfnXMyKh3zG4bWsGIIMLzIXw49vfIfQ3HbuyegZevJPqqBxfzntR3
 iFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785821782; x=1786426582;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XjUlHMDmEYRww5GYz+xDw+QZQfEX6f4KXeW2pr+vdtc=;
 b=kU2oorshsNo8101mprmpPjn22TflHbsHX4qdyjxMJ3RzIYQ1Wz9CZtaZty/AJu7JyE
 gzNkolkQSIF03JpzXAywUl2YbUWewkBH/j3Vn6HfkxAYGs/O0r9S0ZBEplYZrKv5awGT
 xyJttX6g61rZsp39fRaGYYD4vu0v030ml0RxbKBX/P5W91bLxlTiqFrK8/oMfiJX0RaH
 VSWfe5TStmtfgBgj5VuJvG1GGHYq9nMwabJ16N4B95Xb3ZKwdbZOODGYAroN40KV+OKH
 AHC7FhnI+5eUTe/U6iNf0VhRQz7Y1jwp4x8+cVGT/lpmMva9+MakxnYw0RonBfChj0TA
 9qMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+/7tA3Y9xPzPY26sya0lvkfSO4Qyv0HTsF0JrwQLI/GlLAS4qcWUUSFtm5KkNXIbYzvJfgHKtJv+W@nongnu.org
X-Gm-Message-State: AOJu0YwU3WdLcpVKCLOaHmVYW4W1l5sIFv9SdOuQ2Xv519VeAioIN8YN
 IqpVBDnTlxXyFLy07J/PJw0YFd5EMWOhd94fYLkDn4qgXx0UTbvDGr34
X-Gm-Gg: AR+sD120rlDqNsnrz+axsv/AjKWsinvEEW16jYEpqfUoOAJ6SNmSgAZDtNlzG+irgCM
 4Dm9cEmEssPpnBFuysvXvQb2NB1/CA0wJH7vg2ha+dN9lqVEHGf+nZwjJg+/7dwxk59woFe23Bp
 UYq+34naZ2lKhRGCjvt+hSz/pFnnB/xjpwX+e6Bq4kU3FolB3vxVHYsznQ6PgblJkkiWaxFFDki
 D88oRtU6w8HKL/hwnkzRJmpGF2MXcVnoYaqP5lex3Xhb3DA2gFYUxhbeeGg3YKAe1Hj6Etgt382
 R/63dJxbc6w6vPcEYkpPmHNBnXNuQMO8iKfa0tY6tcP41XrsZYXI6pxMbqt9YYaBpEI6/xx09j4
 THA2yrMxodeCHgKDgG2FoncLPqepGswKRYsF2ZB8cy4ssHibaIxvVJIFlVUiFUIocGFP23iWCkn
 EV1WaYBOK2cfWvynajnvWnrgC3l2w38OMTTosmZ2twMHkgNt8kwA0GIZLg04GNNtggHlDHRyVCy
 pf0bZC+AKsz4pHARXDt1oZGQQ==
X-Received: by 2002:a17:903:388b:b0:2c9:b48c:fdde with SMTP id
 d9443c01a7336-2d05229828cmr131854415ad.26.1785821781545; 
 Mon, 03 Aug 2026 22:36:21 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04aea2514sm46648275ad.37.2026.08.03.22.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 22:36:21 -0700 (PDT)
Message-ID: <0ebb6351-48ac-4a28-ac51-9861627361b6@gmail.com>
Date: Tue, 4 Aug 2026 14:36:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/qxl: validate primary surface stride
 against width
From: Akihiko Odaki <akihiko.odaki@gmail.com>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260725122411.1769492-1-marcandre.lureau@redhat.com>
 <4f2961e4-1670-4e1a-8d60-4238ee7fd731@gmail.com>
Content-Language: en-US
In-Reply-To: <4f2961e4-1670-4e1a-8d60-4238ee7fd731@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2026/08/04 13:54, Akihiko Odaki wrote:
> Sorry for a late review; I missed this patch.
> 
> On 2026/07/25 21:24, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> The existing validation in qxl_create_guest_primary() checks that
>> abs(stride) * height fits in vgamem_size and that stride is 4-byte
>> aligned, but never checks that abs(stride) is large enough to hold one
>> row of pixels for the declared width and format.
>>
>> A malicious guest can create a primary surface with a stride much
>> smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
>> surface). The spice server rejects this via red_validate_surface(), but
>> the return is void and QEMU unconditionally proceeds to set up the local
>> rendering state. On the next display refresh, VNC or SDL reads width *
>> bytes_pp per scanline from a region backed by only stride bytes per
>> row, causing a host-side out-of-bounds read.
>>
>> Add three checks in qxl_create_guest_primary() before creating the
>> surface:
>>   - reject unknown surface formats
>>   - reject zero width or height
>>   - reject surfaces where abs(stride) < width * bytes_per_pixel
>>
>> Also fix three related issues in qxl-render.c:
>>   - qxl_blit() used abs_stride to advance the dst pointer into the
>>     DisplaySurface, but when stride is negative the DisplaySurface is a
>>     packed buffer whose stride may be smaller. Use surface_stride()
>>     instead.
>>   - qxl_render_update_area_unlocked() uses guest_head0_width (set via
>>     QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
>>     abs_stride, bypassing the new validation. Clamp the effective width
>>     to abs_stride / bytes_pp to prevent out-of-bounds access while
>>     tolerating the normal transient where the monitor config arrives
>>     before the primary surface is resized to match.
>>   - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
>>     validation. Without clamping, abs_stride * height can overrun
>>     vgamem_size, and the product can also overflow 32 bits (e.g.
>>     abs_stride=16 MiB, height=256 wraps to zero), defeating the
>>     qxl_phys2virt() bounds check. Clamp height to
>>     vgamem_size / abs_stride to prevent both.

With negative strides, qxl_blit() walks src scanlines in reverse order. 
The starting point is determined with guest_primary.surface.height. So 
it will overrun if:

     guest_primary.surface.height
          < guest_head0_height
          <= vgamem_size / abs_stride
>>
>> Fixes: CVE-2026-16271
>> Fixes: 3761abb16784 ("hw/display/qxl: fix signed to unsigned comparison")
> 
> The Fixes: 3761abb16784 tag is incorrect. That commit only repaired 
> overflow in an existing total-size check; short-stride surfaces were 
> already accepted. The vulnerable local renderer originated in 
> a19cbfb34642, while the monitor-dimension bypass came from 979f7ef8966b 
> and the overflowable qxl_phys2virt() size expression from 
> 8efec0ef8bbc/6dbbf055148c.
> 
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
>> Reported-by: huntr bubble
>> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>> ---
>> v2:
>>   - also clamp height
>>   - factor out qxl_format_bpp() helper
>> ---
>>   hw/display/qxl.h        |  2 ++
>>   hw/display/qxl-render.c | 46 ++++++++++++++++----------------
>>   hw/display/qxl.c        | 59 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 84 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
>> index 48d664f77736..6f5b96fe86cc 100644
>> --- a/hw/display/qxl.h
>> +++ b/hw/display/qxl.h
>> @@ -181,6 +181,8 @@ void qxl_spice_oom(PCIQXLDevice *qxl);
>>   void qxl_spice_reset_memslots(PCIQXLDevice *qxl);
>>   void qxl_spice_reset_image_cache(PCIQXLDevice *qxl);
>>   void qxl_spice_reset_cursor(PCIQXLDevice *qxl);
>> +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
>> +                    uint32_t *bytes_pp, uint32_t *bits_pp);
>>   /* qxl-logger.c */
>>   int qxl_log_cmd_cursor(PCIQXLDevice *qxl, QXLCursorCmd *cmd, int 
>> group_id);
>> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
>> index 4799c9e8befd..b0a71a95ad66 100644
>> --- a/hw/display/qxl-render.c
>> +++ b/hw/display/qxl-render.c
>> @@ -27,6 +27,7 @@
>>   static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
>>   {
>>       DisplaySurface *surface = qemu_console_surface(qxl->vga.con);
>> +    int dst_stride = surface_stride(surface);
>>       uint8_t *dst = surface_data(surface);
>>       uint8_t *src;
>>       int len, i;
>> @@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect 
>> *rect)
>>       } else {
>>           src += rect->top * qxl->guest_primary.abs_stride;
>>       }
>> -    dst += rect->top  * qxl->guest_primary.abs_stride;
>> +    dst += rect->top  * dst_stride;
>>       src += rect->left * qxl->guest_primary.bytes_pp;
>>       dst += rect->left * qxl->guest_primary.bytes_pp;
>>       len  = (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
>>       for (i = rect->top; i < rect->bottom; i++) {
>>           memcpy(dst, src, len);
>> -        dst += qxl->guest_primary.abs_stride;
>> +        dst += dst_stride;
>>           src += qxl->guest_primary.qxl_stride;
>>       }
>>   }
>> @@ -64,27 +65,9 @@ void qxl_render_resize(PCIQXLDevice *qxl)
>>       qxl->guest_primary.qxl_stride = sc->stride;
>>       qxl->guest_primary.abs_stride = abs(sc->stride);
>>       qxl->guest_primary.resized++;
>> -    switch (sc->format) {
>> -    case SPICE_SURFACE_FMT_16_555:
>> -        qxl->guest_primary.bytes_pp = 2;
>> -        qxl->guest_primary.bits_pp = 15;
>> -        break;
>> -    case SPICE_SURFACE_FMT_16_565:
>> -        qxl->guest_primary.bytes_pp = 2;
>> -        qxl->guest_primary.bits_pp = 16;
>> -        break;
>> -    case SPICE_SURFACE_FMT_32_xRGB:
>> -    case SPICE_SURFACE_FMT_32_ARGB:
>> -        qxl->guest_primary.bytes_pp = 4;
>> -        qxl->guest_primary.bits_pp = 32;
>> -        break;
>> -    default:
>> -        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
>> -                qxl->guest_primary.surface.format);
>> -        qxl->guest_primary.bytes_pp = 4;
>> -        qxl->guest_primary.bits_pp = 32;
>> -        break;
>> -    }
>> +    /* fallback to default bpp if format is unknown */
>> +    qxl_format_bpp(qxl, sc->format, &qxl->guest_primary.bytes_pp,
>> +                   &qxl->guest_primary.bits_pp);
>>   }
>>   static void qxl_set_rect_to_surface(PCIQXLDevice *qxl, QXLRect *area)
>> @@ -103,6 +86,23 @@ static void 
>> qxl_render_update_area_unlocked(PCIQXLDevice *qxl)
>>       int height = qxl->guest_head0_height ?: qxl- 
>> >guest_primary.surface.height;
>>       int i;
>> +    if (width <= 0 || height <= 0) {
>> +        qxl_set_guest_bug(qxl, "%s: invalid dimension %dx%d",
>> +                          __func__, width, height);
>> +        goto end;
>> +    }
> 
> The new dimension check runs before the existing !guest_primary.data 
> exit. A qxl device starts in QXL_MODE_UNDEFINED with a zeroed primary 
> surface, and qxl_render_update() explicitly calls this function in that 
> state. Thus a host refresh—GTK, VNC, or screendump—sees 0×0 and calls 
> qxl_set_guest_bug().
> 
> Below is an LLM-generated reproducer:
> 
> qemu-system-x86_64 -machine q35 -nodefaults -device qxl,id=qxl0 \
> -display none -S -qmp stdio -trace enable=qxl_set_guest_bug <<'EOF'
> {"execute":"qmp_capabilities"}
> {"execute":"screendump","arguments":{"filename":"/dev/ 
> null","device":"qxl0","format":"ppm"}}
> {"execute":"quit"}
> EOF
> 
> Regards,
> Akihiko Odaki
> 
>> +
>> +    if (qxl->guest_primary.bytes_pp > 0) {
>> +        int max_width = qxl->guest_primary.abs_stride
>> +                        / qxl->guest_primary.bytes_pp;
>> +        width = MIN(width, max_width);
>> +    }
>> +
>> +    if (qxl->guest_primary.abs_stride > 0) {
>> +        int max_height = qxl->vgamem_size / qxl- 
>> >guest_primary.abs_stride;
>> +        height = MIN(height, max_height);
>> +    }
>> +
>>       if (qxl->guest_primary.resized) {
>>           qxl->guest_primary.resized = 0;
>>           qxl->guest_primary.data = qxl_phys2virt(qxl,
>> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
>> index b7d871b9ee33..384b8767b8e6 100644
>> --- a/hw/display/qxl.c
>> +++ b/hw/display/qxl.c
>> @@ -1489,6 +1489,47 @@ static void 
>> qxl_create_guest_primary_complete(PCIQXLDevice *qxl)
>>       qxl_render_resize(qxl);
>>   }
>> +/*
>> + * Convert a SpiceSurfaceFormat to bytes per pixel and bits per pixel.
>> + *
>> + * Only valid for surface suitable for rendering.
>> + */
>> +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
>> +                    uint32_t *bytes_pp, uint32_t *bits_pp)
>> +{
>> +    uint32_t bypp = 4;
>> +    uint32_t bipp = 32;
>> +    bool ret = true;
>> +
>> +    switch (format) {
>> +    case SPICE_SURFACE_FMT_16_555:
>> +        bypp = 2;
>> +        bipp = 15;
>> +        break;
>> +    case SPICE_SURFACE_FMT_16_565:
>> +        bypp = 2;
>> +        bipp = 16;
>> +        break;
>> +    case SPICE_SURFACE_FMT_32_xRGB:
>> +    case SPICE_SURFACE_FMT_32_ARGB:
>> +        bypp = 4;
>> +        bipp = 32;
>> +        break;
>> +    default:
>> +        ret = false;
>> +        qxl_set_guest_bug(qxl, "%s: unhandled format: %x", __func__, 
>> format);
>> +    }
>> +
>> +    if (bytes_pp != NULL) {
>> +        *bytes_pp = bypp;
>> +    }
>> +    if (bits_pp != NULL) {
>> +        *bits_pp = bipp;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>>                                        qxl_async_io async)
>>   {
>> @@ -1496,6 +1537,7 @@ static void 
>> qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>>       QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
>>       uint32_t requested_height = le32_to_cpu(sc->height);
>>       int requested_stride = le32_to_cpu(sc->stride);
>> +    uint32_t bytes_pp;
>>       if (requested_stride == INT32_MIN ||
>>           abs(requested_stride) * (uint64_t)requested_height
>> @@ -1532,6 +1574,23 @@ static void 
>> qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>>           return;
>>       }
>> +    if (!qxl_format_bpp(qxl, surface.format, &bytes_pp, NULL)) {
>> +        return;
>> +    }
>> +
>> +    if (surface.width == 0 || surface.height == 0) {
>> +        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
>> +                          __func__, surface.width, surface.height);
>> +        return;
>> +    }
>> +
>> +    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
>> +        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
>> +                          " stride %d width %u bpp %u",
>> +                          __func__, surface.stride, surface.width, 
>> bytes_pp);
>> +        return;
>> +    }
>> +
>>       surface.mouse_mode = true;
>>       surface.group_id   = MEMSLOT_GROUP_GUEST;
>>       if (loadvm) {
> 
> 


