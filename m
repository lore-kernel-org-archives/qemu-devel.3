Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2963D609CE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFFf-0002Zl-4T; Wed, 27 Nov 2024 05:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGFFb-0002WY-2f
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:26:27 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGFFU-0005lR-RJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:26:26 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-514ec8ea37bso1315201e0c.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 02:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732703179; x=1733307979;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vuKBlF6V7bNwE4ZSofSg5cz8HTxAwYcXfuY4VWdAdug=;
 b=dMyXyb8UsA2PJfltRw36gv2p1oVBDBppYwxk7bVuK+fy995bUhYMtOPGB1pvBqFiM4
 dCGCtpX2ExIICnzcuk8n0EQ6tXaD/gqwXBkKB4bkwIw6oXU72PctekoajYjm+W7Ogz9V
 lkSxO6mkVIwAYUOlAeYRdLVHK/Q3MWGR/uRXsJHmygYTehYSmKtbmJW4EhcD/PCpMYj6
 l4frwM2e4Ksvt1yWW43gRQR1AMnfD2fpODc22XU+OG7Xs+faq339UyiVQdOeGobuHEGF
 lYx9H5+dyOcsoYFLCSxYmd9sxTZnAP/pdY0TVYiKYuLXmn2Qo13+cbiZ6l9kb7qwo/4Z
 F72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732703179; x=1733307979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vuKBlF6V7bNwE4ZSofSg5cz8HTxAwYcXfuY4VWdAdug=;
 b=KY4OpteKoyt3ZOGypvjQ0Np7vMqWraUnRC88oYJF++YVLcBGvcv9+G1DNg6WnRdlYC
 8k9IbAqurkkx5p/TxYXqSZ2zQUz4cqq27ca2uJAs+8iqDyNeNgs/GjnnkPy8bhXT2i0L
 9kL9LoQyTl0qMRgLWjfGLXVgKQa2ueh/Vg25d8vjYTlKwsjEU18bxtAkfbuxPJvl7o8Q
 Ms6YbV+bDeh0XbI7Ba3J/BPh/7DHRTf+fNumWnnoGgDrBjmNvZGzdB2mhiiMjQWtS4i6
 Afo7O5E6GlNRWteIt/uUZaKSNFvbb27UK/6VuZ47pV5RiLgYnFFahao9btAsC30O/Flk
 QfpA==
X-Gm-Message-State: AOJu0Yw9M8qdWhufPIddd5NCqvxNxGmHcVLf17yzG/6PdEccWajLniJV
 kvB8gQ4jSN5tujkqQgIiOZmMwvxRJrIwiREpQu0bulpzsZrtT/jpGjOx6R33A7jNkHYn8YDKj9g
 a4A1vrVBRSftvcH1OISsVD/YqF8900en1Qkct
X-Gm-Gg: ASbGncuOBX90wZV2cNoTQ1FIXIduR82ZdbrUJsvuo6Jv7PImsH3C2KQwH9/eEhQti8W
 pnI1i33Lm5EwL2A24z1x2ai2QnePRXIY=
X-Google-Smtp-Source: AGHT+IGzNLg2ddg+vaKJ1U2zOaNZ/PZKaSt9tLgO99pWWNSXbdUez2n5vSh22r/YkNcHwdd0EAaQqMQZ52By4G9QXwA=
X-Received: by 2002:a05:6122:1e0b:b0:515:4fab:301a with SMTP id
 71dfb90a1353d-515569cbcb5mr3130712e0c.5.1732703179231; Wed, 27 Nov 2024
 02:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-3-phil@philjordan.eu>
 <c38d7d73-39f0-4201-bf51-62adbe169458@daynix.com>
In-Reply-To: <c38d7d73-39f0-4201-bf51-62adbe169458@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 27 Nov 2024 11:26:08 +0100
Message-ID: <CAAibmn3_ewsk_WG4=FVC6H0LKzmu6s4zBtW1=+XTzCK8LH4F2Q@mail.gmail.com>
Subject: Re: [PATCH v10 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="0000000000007fe85f0627e26579"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000007fe85f0627e26579
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2024 at 07:18, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/13 23:23, Phil Dennis-Jordan wrote:
> [=E2=80=A6]
> > +static void apple_gfx_render_new_frame(AppleGFXState *s)
> > +{
> > +    bool managed_texture =3D s->using_managed_texture_storage;
> > +    uint32_t width =3D surface_width(s->surface);
> > +    uint32_t height =3D surface_height(s->surface);
> > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> > +    id<MTLCommandBuffer> command_buffer =3D [s->mtl_queue commandBuffe=
r];
>
> The documentation says:
>  > Create a command encoder from an MTLCommandQueue instance by calling
>  > its commandBuffer method. Typically, you create one or more command
>  > queues when your app launches and then keep them throughout your app=
=E2=80=99s
>  > lifetime.
>
> https://developer.apple.com/documentation/metal/mtlcommandbuffer?language=
=3Dobjc
>
> So let's do so.
>

This is already what we do - we have only one MTLCommandQueue,
s->mtl_queue, which is long-lived and created during _realize().

The documentation phrasing is a little awkward because it inserts the bit
about command encoders and commandBuffers in between the discussion of
command queues. To be clear, it is only the command *queue* which can be
long-lived. Command *buffers* are explicitly short-lived, once you call the
commit method on them, you cannot use them again for anything else:

https://developer.apple.com/documentation/metal/mtlcommandbuffer/1443003-co=
mmit?language=3Dobjc

Similarly, the command *encoders* are even shorter-lived, because they are
(a) tied to a particular command buffer instance, which is already
short-lived in itself, and (b) you must call endEncoding on the current
encoder (and thus make it unusable) before using another kind of command
encoder on the same command buffer.

So I don't see any meaningful change we can make here.

> +    id<MTLTexture> texture =3D s->texture;
> > +
> > +    assert(bql_locked());
> > +    [texture retain];
> > +
> > +    s->rendering_frame_width =3D width;
> > +    s->rendering_frame_height =3D height;
> > +
> > +    dispatch_async(s->render_queue, ^{
> > +        /*
> > +         * This is not safe to call from the BQL due to PVG-internal
> locks
> > +         * causing deadlocks.
> > +         */
> > +        bool r =3D [s->pgdisp
> encodeCurrentFrameToCommandBuffer:command_buffer
> > +                                                 texture:texture
> > +                                                  region:region];
> > +        if (!r) {
> > +            [texture release];
> > +            bql_lock();
> > +            --s->pending_frames;
> > +            bql_unlock();
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s:
> encodeCurrentFrameToCommandBuffer:texture:region: "
> > +                          "failed\n", __func__);
> > +            return;
> > +        }
> > +
> > +        if (managed_texture) {
> > +            /* "Managed" textures exist in both VRAM and RAM and must
> be synced. */
> > +            id<MTLBlitCommandEncoder> blit =3D [command_buffer
> blitCommandEncoder];
> > +            [blit synchronizeResource:texture];
> > +            [blit endEncoding];
> > +        }
> > +        [texture release];
> > +        [command_buffer addCompletedHandler:
> > +            ^(id<MTLCommandBuffer> cb)
> > +            {
> > +                aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +
> apple_gfx_render_frame_completed_bh, s);
> > +
> > +            }];
> > +        [command_buffer commit];
> > +    });
> > +}
> > +
> > +static void copy_mtl_texture_to_surface_mem(id<MTLTexture> texture,
> void *vram)
> > +{
> > +    /*
> > +     * TODO: Skip this entirely on a pure Metal or headless/guest-only
> > +     * rendering path, else use a blit command encoder? Needs careful
> > +     * (double?) buffering design.
> > +     */
> > +    size_t width =3D texture.width, height =3D texture.height;
> > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> > +    [texture getBytes:vram
> > +          bytesPerRow:(width * 4)
> > +        bytesPerImage:(width * height * 4)
> > +           fromRegion:region
> > +          mipmapLevel:0
> > +                slice:0];
> > +}
> > +
> > +static void apple_gfx_render_frame_completed_bh(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +
> > +    --s->pending_frames;
> > +    assert(s->pending_frames >=3D 0);
> > +
> > +    /* Only update display if mode hasn't changed since we started
> rendering. */
> > +    if (s->rendering_frame_width =3D=3D surface_width(s->surface) &&
> > +        s->rendering_frame_height =3D=3D surface_height(s->surface)) {
> > +        copy_mtl_texture_to_surface_mem(s->texture,
> surface_data(s->surface));
> > +        if (s->gfx_update_requested) {
> > +            s->gfx_update_requested =3D false;
> > +            dpy_gfx_update_full(s->con);
> > +            graphic_hw_update_done(s->con);
> > +            s->new_frame_ready =3D false;
> > +        } else {
> > +            s->new_frame_ready =3D true;
> > +        }
> > +    }
> > +    if (s->pending_frames > 0) {
> > +        apple_gfx_render_new_frame(s);
> > +    }
> > +}
> > +
> > +static void apple_gfx_fb_update_display(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +
> > +    assert(bql_locked());
> > +    if (s->new_frame_ready) {
> > +        dpy_gfx_update_full(s->con);
> > +        s->new_frame_ready =3D false;
> > +        graphic_hw_update_done(s->con);
> > +    } else if (s->pending_frames > 0) {
> > +        s->gfx_update_requested =3D true;
> > +    } else {
> > +        graphic_hw_update_done(s->con);
> > +    }
> > +}
> > +
> > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> > +    .gfx_update =3D apple_gfx_fb_update_display,
> > +    .gfx_update_async =3D true,
> > +};
> > +
> > +/* ------ Mouse cursor and display mode setting ------ */
> > +
> > +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height=
)
> > +{
> > +    MTLTextureDescriptor *textureDescriptor;
> > +
> > +    if (s->surface &&
> > +        width =3D=3D surface_width(s->surface) &&
> > +        height =3D=3D surface_height(s->surface)) {
> > +        return;
> > +    }
> > +
> > +    [s->texture release];
> > +
> > +    s->surface =3D qemu_create_displaysurface(width, height);
> > +
> > +    @autoreleasepool {
> > +        textureDescriptor =3D
> > +            [MTLTextureDescriptor
> > +
> texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> > +                                             width:width
> > +                                            height:height
> > +                                         mipmapped:NO];
> > +        textureDescriptor.usage =3D s->pgdisp.minimumTextureUsage;
> > +        s->texture =3D [s->mtl
> newTextureWithDescriptor:textureDescriptor];
> > +    }
> > +
> > +    s->using_managed_texture_storage =3D
> > +        (s->texture.storageMode =3D=3D MTLStorageModeManaged);
> > +    dpy_gfx_replace_surface(s->con, s->surface);
> > +}
> > +
> > +static void update_cursor(AppleGFXState *s)
> > +{
> > +    assert(bql_locked());
> > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> > +                  s->pgdisp.cursorPosition.y,
> qatomic_read(&s->cursor_show));
> > +}
> > +
> > +static void update_cursor_bh(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +    update_cursor(s);
> > +}
> > +
> > +typedef struct AppleGFXSetCursorGlyphJob {
> > +    AppleGFXState *s;
> > +    NSBitmapImageRep *glyph;
> > +    PGDisplayCoord_t hotspot;
> > +} AppleGFXSetCursorGlyphJob;
> > +
> > +static void set_cursor_glyph(void *opaque)
> > +{
> > +    AppleGFXSetCursorGlyphJob *job =3D opaque;
> > +    AppleGFXState *s =3D job->s;
> > +    NSBitmapImageRep *glyph =3D job->glyph;
> > +    uint32_t bpp =3D glyph.bitsPerPixel;
> > +    size_t width =3D glyph.pixelsWide;
> > +    size_t height =3D glyph.pixelsHigh;
> > +    size_t padding_bytes_per_row =3D glyph.bytesPerRow - width * 4;
> > +    const uint8_t* px_data =3D glyph.bitmapData;
> > +
> > +    trace_apple_gfx_cursor_set(bpp, width, height);
> > +
> > +    if (s->cursor) {
> > +        cursor_unref(s->cursor);
> > +        s->cursor =3D NULL;
> > +    }
> > +
> > +    if (bpp =3D=3D 32) { /* Shouldn't be anything else, but just to be
> safe...*/
> > +        s->cursor =3D cursor_alloc(width, height);
> > +        s->cursor->hot_x =3D job->hotspot.x;
> > +        s->cursor->hot_y =3D job->hotspot.y;
> > +
> > +        uint32_t *dest_px =3D s->cursor->data;
> > +
> > +        for (size_t y =3D 0; y < height; ++y) {
> > +            for (size_t x =3D 0; x < width; ++x) {
> > +                /*
> > +                 * NSBitmapImageRep's red & blue channels are swapped
> > +                 * compared to QEMUCursor's.
> > +                 */
> > +                *dest_px =3D
> > +                    (px_data[0] << 16u) |
> > +                    (px_data[1] <<  8u) |
> > +                    (px_data[2] <<  0u) |
> > +                    (px_data[3] << 24u);
> > +                ++dest_px;
> > +                px_data +=3D 4;
> > +            }
> > +            px_data +=3D padding_bytes_per_row;
> > +        }
> > +        dpy_cursor_define(s->con, s->cursor);
> > +        update_cursor(s);
> > +    }
> > +    [glyph release];
> > +
> > +    g_free(job);
> > +}
> > +
> > +/* ------ DMA (device reading system memory) ------ */
> > +
> > +typedef struct AppleGFXReadMemoryJob {
> > +    QemuSemaphore sem;
> > +    hwaddr physical_address;
> > +    uint64_t length;
> > +    void *dst;
> > +    bool success;
> > +} AppleGFXReadMemoryJob;
> > +
> > +static void apple_gfx_do_read_memory(void *opaque)
> > +{
> > +    AppleGFXReadMemoryJob *job =3D opaque;
> > +    MemTxResult r;
> > +
> > +    r =3D dma_memory_read(&address_space_memory, job->physical_address=
,
> > +                        job->dst, job->length, MEMTXATTRS_UNSPECIFIED)=
;
> > +    job->success =3D r =3D=3D MEMTX_OK;
> > +
> > +    qemu_sem_post(&job->sem);
> > +}
> > +
> > +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr
> physical_address,
> > +                                  uint64_t length, void *dst)
> > +{
> > +    AppleGFXReadMemoryJob job =3D {
> > +        .physical_address =3D physical_address, .length =3D length, .d=
st =3D
> dst
> > +    };
> > +
> > +    trace_apple_gfx_read_memory(physical_address, length, dst);
> > +
> > +    /* Performing DMA requires BQL, so do it in a BH. */
> > +    qemu_sem_init(&job.sem, 0);
> > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                            apple_gfx_do_read_memory, &job);
> > +    qemu_sem_wait(&job.sem);
> > +    qemu_sem_destroy(&job.sem);
> > +    return job.success;
> > +}
> > +
> > +/* ------ Memory-mapped device I/O operations ------ */
> > +
> > +static dispatch_queue_t get_background_queue(void)
> > +{
> > +    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
> 0);
> > +}
> > +
> > +typedef struct AppleGFXIOJob {
> > +    AppleGFXState *state;
> > +    uint64_t offset;
> > +    uint64_t value;
> > +    bool completed;
> > +} AppleGFXIOJob;
> > +
> > +static void apple_gfx_do_read(void *opaque)
> > +{
> > +    AppleGFXIOJob *job =3D opaque;
> > +    job->value =3D [job->state->pgdev mmioReadAtOffset:job->offset];
> > +    qatomic_set(&job->completed, true);
> > +    aio_wait_kick();
> > +}
> > +
> > +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned
> size)
> > +{
> > +    AppleGFXIOJob job =3D {
> > +        .state =3D opaque,
> > +        .offset =3D offset,
> > +        .completed =3D false,
> > +    };
> > +    dispatch_queue_t queue =3D get_background_queue();
> > +
> > +    dispatch_async_f(queue, &job, apple_gfx_do_read);
> > +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
> > +
> > +    trace_apple_gfx_read(offset, job.value);
> > +    return job.value;
> > +}
> > +
> > +static void apple_gfx_do_write(void *opaque)
> > +{
> > +    AppleGFXIOJob *job =3D opaque;
> > +    [job->state->pgdev mmioWriteAtOffset:job->offset value:job->value]=
;
> > +    qatomic_set(&job->completed, true);
> > +    aio_wait_kick();
> > +}
> > +
> > +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
> > +                            unsigned size)
> > +{
> > +    /*
> > +     * The methods mmioReadAtOffset: and especially mmioWriteAtOffset:
> can
> > +     * trigger synchronous operations on other dispatch queues, which
> in turn
> > +     * may call back out on one or more of the callback blocks. For
> this reason,
> > +     * and as we are holding the BQL, we invoke the I/O methods on a
> pool
> > +     * thread and handle AIO tasks while we wait. Any work in the
> callbacks
> > +     * requiring the BQL will in turn schedule BHs which this thread
> will
> > +     * process while waiting.
> > +     */
> > +    AppleGFXIOJob job =3D {
> > +        .state =3D opaque,
> > +        .offset =3D offset,
> > +        .value =3D val,
> > +        .completed =3D false,
> > +    };
> > +    dispatch_queue_t queue =3D get_background_queue();
> > +
> > +    dispatch_async_f(queue, &job, apple_gfx_do_write);
> > +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
> > +
> > +    trace_apple_gfx_write(offset, val);
> > +}
> > +
> > +static const MemoryRegionOps apple_gfx_ops =3D {
> > +    .read =3D apple_gfx_read,
> > +    .write =3D apple_gfx_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static size_t apple_gfx_get_default_mmio_range_size(void)
> > +{
> > +    size_t mmio_range_size;
> > +    @autoreleasepool {
> > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> > +        mmio_range_size =3D desc.mmioLength;
> > +        [desc release];
> > +    }
> > +    return mmio_range_size;
> > +}
> > +
> > +/* ------ Initialisation and startup ------ */
> > +
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*
> obj_name)
> > +{
> > +    size_t mmio_range_size =3D apple_gfx_get_default_mmio_range_size()=
;
> > +
> > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s,
> obj_name,
> > +                          mmio_range_size);
> > +
> > +    /* TODO: PVG framework supports serialising device state: integrat=
e
> it! */
> > +}
> > +
> > +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> > +                                                     PGDeviceDescripto=
r
> *desc)
> > +{
> > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable * _Nonnull
> baseAddress) {
> > +        PGTask_t *task =3D apple_gfx_new_task(s, vmSize);
> > +        *baseAddress =3D (void *)task->address;
> > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> > +        return task;
> > +    };
> > +
> > +    desc.destroyTask =3D ^(PGTask_t * _Nonnull task) {
> > +        trace_apple_gfx_destroy_task(task, task->mapped_regions->len);
> > +
> > +        apple_gfx_destroy_task(s, task);
> > +    };
> > +
> > +    desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint32_t
> range_count,
> > +                           uint64_t virtual_offset, bool read_only,
> > +                           PGPhysicalMemoryRange_t * _Nonnull ranges) =
{
> > +        return apple_gfx_task_map_memory(s, task, virtual_offset,
> > +                                         ranges, range_count,
> read_only);
> > +    };
> > +
> > +    desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, uint64_t
> virtual_offset,
> > +                             uint64_t length) {
> > +        apple_gfx_task_unmap_memory(s, task, virtual_offset, length);
> > +        return true;
> > +    };
> > +
> > +    desc.readMemory =3D ^bool(uint64_t physical_address, uint64_t leng=
th,
> > +                            void * _Nonnull dst) {
> > +        return apple_gfx_read_memory(s, physical_address, length, dst)=
;
> > +    };
> > +}
> > +
> > +static void new_frame_handler_bh(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +
> > +    /* Drop frames if we get too far ahead. */
> > +    if (s->pending_frames >=3D 2) {
> > +        return;
> > +    }
> > +    ++s->pending_frames;
> > +    if (s->pending_frames > 1) {
> > +        return;
> > +    }
> > +    apple_gfx_render_new_frame(s);
> > +}
> > +
> > +static PGDisplayDescriptor
> *apple_gfx_prepare_display_descriptor(AppleGFXState *s)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new];
> > +
> > +    disp_desc.name =3D @"QEMU display";
> > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* A 20"
> display */
> > +    disp_desc.queue =3D dispatch_get_main_queue();
> > +    disp_desc.newFrameEventHandler =3D ^(void) {
> > +        trace_apple_gfx_new_frame();
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> new_frame_handler_bh, s);
> > +    };
> > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t sizeInPixels,
> > +                                    OSType pixelFormat) {
> > +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
> > +
> > +        BQL_LOCK_GUARD();
> > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> > +    };
> > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
> > +                                     PGDisplayCoord_t hotspot) {
> > +        AppleGFXSetCursorGlyphJob *job =3D g_malloc0(sizeof(*job));
> > +        job->s =3D s;
> > +        job->glyph =3D glyph;
> > +        job->hotspot =3D hotspot;
> > +        [glyph retain];
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                set_cursor_glyph, job);
> > +    };
> > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> > +        trace_apple_gfx_cursor_show(show);
> > +        qatomic_set(&s->cursor_show, show);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                update_cursor_bh, s);
> > +    };
> > +    disp_desc.cursorMoveHandler =3D ^(void) {
> > +        trace_apple_gfx_cursor_move();
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                update_cursor_bh, s);
> > +    };
> > +
> > +    return disp_desc;
> > +}
> > +
> > +static NSArray<PGDisplayMode*>*
> apple_gfx_prepare_display_mode_array(void)
> > +{
> > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
>
> Don't initialize mode_array here; it will suppress an uniniailized
> variable warning in case you forget assigning a real value later.
>

OK


> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        modes[i] =3D
> > +            [[PGDisplayMode alloc]
> initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> > +    }
> > +
> > +    mode_array =3D [NSArray arrayWithObjects:modes
> count:ARRAY_SIZE(apple_gfx_modes)];
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        [modes[i] release];
> > +        modes[i] =3D nil;
> > +    }
> > +
> > +    return mode_array;
> > +}
> > +
> > +static id<MTLDevice> copy_suitable_metal_device(void)
> > +{
> > +    id<MTLDevice> dev =3D nil;
> > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices();
> > +
> > +    /* Prefer a unified memory GPU. Failing that, pick a non-removable
> GPU. */
> > +    for (size_t i =3D 0; i < devs.count; ++i) {
> > +        if (devs[i].hasUnifiedMemory) {
> > +            dev =3D devs[i];
> > +            break;
> > +        }
> > +        if (!devs[i].removable) {
> > +            dev =3D devs[i];
> > +        }
> > +    }
> > +
> > +    if (dev !=3D nil) {
> > +        [dev retain];
> > +    } else {
> > +        dev =3D MTLCreateSystemDefaultDevice();
> > +    }
> > +    [devs release];
> > +
> > +    return dev;
> > +}
> > +
> > +bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
> > +                              PGDeviceDescriptor *desc, Error **errp)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D nil;
> > +
> > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> > +        error_setg(&apple_gfx_mig_blocker,
> > +                  "Migration state blocked by apple-gfx display
> device");
> > +        if (migrate_add_blocker(&apple_gfx_mig_blocker, errp) < 0) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    qemu_mutex_init(&s->task_mutex);
> > +    QTAILQ_INIT(&s->tasks);
> > +    s->render_queue =3D dispatch_queue_create("apple-gfx.render",
> > +                                            DISPATCH_QUEUE_SERIAL);
> > +    s->mtl =3D copy_suitable_metal_device();
> > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> > +
> > +    desc.device =3D s->mtl;
> > +
> > +    apple_gfx_register_task_mapping_handlers(s, desc);
> > +
> > +    s->cursor_show =3D true;
> > +
> > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> > +
> > +    disp_desc =3D apple_gfx_prepare_display_descriptor(s);
> > +    s->pgdisp =3D [s->pgdev newDisplayWithDescriptor:disp_desc
> > +                                              port:0 serialNum:1234];
> > +    [disp_desc release];
> > +    s->pgdisp.modeList =3D apple_gfx_prepare_display_mode_array();
> > +
> > +    s->con =3D graphic_console_init(dev, 0, &apple_gfx_fb_ops, s);
> > +    return true;
> > +}
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 20a94973fa2..cf9e6dd35d2 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -61,6 +61,12 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
> files('artist.c'))
> >
> >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> 'ati_2d.c', 'ati_dbg.c'), pixman])
> >
> > +if host_os =3D=3D 'darwin'
> > +  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> [files('apple-gfx.m'), pvg, metal])
> > +  if cpu =3D=3D 'aarch64'
> > +    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
> [files('apple-gfx-mmio.m'), pvg, metal])
> > +  endif
> > +endif
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >     virtio_gpu_ss =3D ss.source_set()
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index d26d663f963..a50e4eea0c0 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) "dest_width :
> %u"
> >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> > +
> > +# apple-gfx.m
> > +apple_gfx_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64"
> res=3D0x%"PRIx64
> > +apple_gfx_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=3D0x%x
> base_addr=3D%p"
> > +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions)
> "task=3D%p, task->mapped_regions->len=3D%u"
> > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
> virtual_offset, uint32_t read_only) "task=3D%p range_count=3D0x%x
> virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t
> phys_len) "[%d] phys_addr=3D0x%"PRIx64" phys_len=3D0x%"PRIx64
> > +apple_gfx_remap(uint64_t retval, void *source_ptr, uint64_t target)
> "retval=3D%"PRId64" source=3D%p target=3D0x%"PRIx64
> > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t
> length) "task=3D%p virtual_offset=3D0x%"PRIx64" length=3D0x%"PRIx64
> > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void
> *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" dest=3D%p"
> > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +apple_gfx_new_frame(void) ""
> > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRId64" y=3D%"PRI=
d64
> > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height)
> "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> > +apple_gfx_cursor_move(void) ""
> > +apple_gfx_common_init(const char *device_name, size_t mmio_size)
> "device: %s; MMIO size: %zu bytes"
> > +
> > +# apple-gfx-mmio.m
> > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res)
> "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val)
> "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro,
> void *va, void *e, void *f, void* va_result) "phys=3D0x%"PRIx64"
> len=3D0x%"PRIx64" ro=3D%d va=3D%p e=3D%p f=3D%p -> *va=3D%p"
> > +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_t
> start, uint64_t end) "index=3D%zu, region=3D%p, 0x%"PRIx64"-0x%"PRIx64
> > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void
> *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> > +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) "unmappin=
g
> @ %p from memory region %p"
> > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +
> > diff --git a/meson.build b/meson.build
> > index e0b880e4e13..3c61238bc77 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -794,6 +794,8 @@ socket =3D []
> >   version_res =3D []
> >   coref =3D []
> >   iokit =3D []
> > +pvg =3D not_found
> > +metal =3D []
> >   emulator_link_args =3D []
> >   midl =3D not_found
> >   widl =3D not_found
> > @@ -815,6 +817,8 @@ elif host_os =3D=3D 'darwin'
> >     coref =3D dependency('appleframeworks', modules: 'CoreFoundation')
> >     iokit =3D dependency('appleframeworks', modules: 'IOKit', required:
> false)
> >     host_dsosuf =3D '.dylib'
> > +  pvg =3D dependency('appleframeworks', modules:
> 'ParavirtualizedGraphics')
> > +  metal =3D dependency('appleframeworks', modules: 'Metal')
> >   elif host_os =3D=3D 'sunos'
> >     socket =3D [cc.find_library('socket'),
> >               cc.find_library('nsl'),
>
>

--0000000000007fe85f0627e26579
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, 27 Nov 2024 at 07:18, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/11/13 23:23, Phil Dennis-Jordan wrote:<br>[=E2=80=A6]<br>
&gt; +static void apple_gfx_render_new_frame(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool managed_texture =3D s-&gt;using_managed_texture_st=
orage;<br>
&gt; +=C2=A0 =C2=A0 uint32_t width =3D surface_width(s-&gt;surface);<br>
&gt; +=C2=A0 =C2=A0 uint32_t height =3D surface_height(s-&gt;surface);<br>
&gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegionMake2D(0, 0, width, heigh=
t);<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLCommandBuffer&gt; command_buffer =3D [s-&gt;mt=
l_queue commandBuffer];<br>
<br>
The documentation says:<br>
=C2=A0&gt; Create a command encoder from an MTLCommandQueue instance by cal=
ling<br>
=C2=A0&gt; its commandBuffer method. Typically, you create one or more comm=
and<br>
=C2=A0&gt; queues when your app launches and then keep them throughout your=
 app=E2=80=99s<br>
=C2=A0&gt; lifetime.<br>
<a href=3D"https://developer.apple.com/documentation/metal/mtlcommandbuffer=
?language=3Dobjc" rel=3D"noreferrer" target=3D"_blank">https://developer.ap=
ple.com/documentation/metal/mtlcommandbuffer?language=3Dobjc</a><br>
<br>
So let&#39;s do so.<br></blockquote><div><br></div><div>This is already wha=
t we do - we have only one MTLCommandQueue, s-&gt;mtl_queue, which is long-=
lived and created during _realize().</div><div><br></div><div>The documenta=
tion phrasing is a little awkward because it inserts the bit about command =
encoders and commandBuffers in between the discussion of command queues. To=
 be clear, it is only the command *queue* which can be long-lived. Command =
*buffers* are explicitly short-lived, once you call the commit method on th=
em, you cannot use them again for anything else:</div><div><br></div><div><=
a href=3D"https://developer.apple.com/documentation/metal/mtlcommandbuffer/=
1443003-commit?language=3Dobjc">https://developer.apple.com/documentation/m=
etal/mtlcommandbuffer/1443003-commit?language=3Dobjc</a></div><div><br></di=
v><div>Similarly, the command *encoders* are even shorter-lived, because th=
ey are (a) tied to a particular command buffer instance, which is already s=
hort-lived in itself, and (b) you must call endEncoding on the current enco=
der (and thus make it unusable) before using another kind of command encode=
r on the same command buffer.</div><div><br></div><div>So I don&#39;t see a=
ny meaningful change we can make here.<br></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture =3D s-&gt;texture;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 [texture retain];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rendering_frame_width =3D width;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rendering_frame_height =3D height;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async(s-&gt;render_queue, ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is not safe to call from the=
 BQL due to PVG-internal locks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* causing deadlocks.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool r =3D [s-&gt;pgdisp encodeCurrentFra=
meToCommandBuffer:command_buffer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0texture:texture<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region:region];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [texture release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: encodeCurrentFrameToCommandBuffer:texture:r=
egion: &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;failed\n&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (managed_texture) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* &quot;Managed&quot; text=
ures exist in both VRAM and RAM and must be synced. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id&lt;MTLBlitCommandEncoder=
&gt; blit =3D [command_buffer blitCommandEncoder];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit synchronizeResource:t=
exture];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit endEncoding];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [texture release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [command_buffer addCompletedHandler:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(id&lt;MTLCommandBuffer&gt=
; cb)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedu=
le_oneshot(qemu_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 appl=
e_gfx_render_frame_completed_bh, s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [command_buffer commit];<br>
&gt; +=C2=A0 =C2=A0 });<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void copy_mtl_texture_to_surface_mem(id&lt;MTLTexture&gt; text=
ure, void *vram)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* TODO: Skip this entirely on a pure Metal or hea=
dless/guest-only<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* rendering path, else use a blit command encoder=
? Needs careful<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (double?) buffering design.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 size_t width =3D texture.width, height =3D texture.heig=
ht;<br>
&gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegionMake2D(0, 0, width, heigh=
t);<br>
&gt; +=C2=A0 =C2=A0 [texture getBytes:vram<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytesPerRow:(width * 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytesPerImage:(width * height * 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fromRegion:region<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mipmapLevel:0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slice:0];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_render_frame_completed_bh(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 assert(s-&gt;pending_frames &gt;=3D 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Only update display if mode hasn&#39;t changed since=
 we started rendering. */<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;rendering_frame_width =3D=3D surface_width(s-=
&gt;surface) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rendering_frame_height =3D=3D surfa=
ce_height(s-&gt;surface)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_mtl_texture_to_surface_mem(s-&gt;tex=
ture, surface_data(s-&gt;surface));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;gfx_update_requested) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =
=3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;c=
on);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&g=
t;con);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D f=
alse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D t=
rue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_render_new_frame(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_fb_update_display(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;new_frame_ready) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 } else if (s-&gt;pending_frames &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =3D true;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const GraphicHwOps apple_gfx_fb_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .gfx_update =3D apple_gfx_fb_update_display,<br>
&gt; +=C2=A0 =C2=A0 .gfx_update_async =3D true,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* ------ Mouse cursor and display mode setting ------ */<br>
&gt; +<br>
&gt; +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t heigh=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MTLTextureDescriptor *textureDescriptor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;surface &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D=3D surface_width(s-&gt;surface)=
 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D surface_height(s-&gt;surfac=
e)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 [s-&gt;texture release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;surface =3D qemu_create_displaysurface(width, hei=
ght);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescriptor =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [MTLTextureDescriptor<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 texture2DDesc=
riptorWithPixelFormat:MTLPixelFormatBGRA8Unorm<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0width:width<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 height:height<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mipmapped:NO];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescriptor.usage =3D s-&gt;pgdisp.=
minimumTextureUsage;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;texture =3D [s-&gt;mtl newTextureWi=
thDescriptor:textureDescriptor];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;using_managed_texture_storage =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;texture.storageMode =3D=3D MTLStor=
ageModeManaged);<br>
&gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(s-&gt;con, s-&gt;surface);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void update_cursor(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, s-&gt;pgdisp.cursorPosition.x,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;=
pgdisp.cursorPosition.y, qatomic_read(&amp;s-&gt;cursor_show));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void update_cursor_bh(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXSetCursorGlyphJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s;<br>
&gt; +=C2=A0 =C2=A0 NSBitmapImageRep *glyph;<br>
&gt; +=C2=A0 =C2=A0 PGDisplayCoord_t hotspot;<br>
&gt; +} AppleGFXSetCursorGlyphJob;<br>
&gt; +<br>
&gt; +static void set_cursor_glyph(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXSetCursorGlyphJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D job-&gt;s;<br>
&gt; +=C2=A0 =C2=A0 NSBitmapImageRep *glyph =3D job-&gt;glyph;<br>
&gt; +=C2=A0 =C2=A0 uint32_t bpp =3D glyph.bitsPerPixel;<br>
&gt; +=C2=A0 =C2=A0 size_t width =3D glyph.pixelsWide;<br>
&gt; +=C2=A0 =C2=A0 size_t height =3D glyph.pixelsHigh;<br>
&gt; +=C2=A0 =C2=A0 size_t padding_bytes_per_row =3D glyph.bytesPerRow - wi=
dth * 4;<br>
&gt; +=C2=A0 =C2=A0 const uint8_t* px_data =3D glyph.bitmapData;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_cursor_set(bpp, width, height);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;cursor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(s-&gt;cursor);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (bpp =3D=3D 32) { /* Shouldn&#39;t be anything else,=
 but just to be safe...*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D cursor_alloc(width, heig=
ht);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_x =3D job-&gt;hotspo=
t.x;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_y =3D job-&gt;hotspo=
t.y;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *dest_px =3D s-&gt;cursor-&gt;da=
ta;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t y =3D 0; y &lt; height; ++y) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t x =3D 0; x &lt;=
 width; ++x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* NSBit=
mapImageRep&#39;s red &amp; blue channels are swapped<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* compa=
red to QEMUCursor&#39;s.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dest_px =3D<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[0] &lt;&lt; 16u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[1] &lt;&lt;=C2=A0 8u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[2] &lt;&lt;=C2=A0 0u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[3] &lt;&lt; 24u);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++dest_px;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D =
4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D padding_bytes_=
per_row;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_cursor_define(s-&gt;con, s-&gt;cursor=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [glyph release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(job);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ------ DMA (device reading system memory) ------ */<br>
&gt; +<br>
&gt; +typedef struct AppleGFXReadMemoryJob {<br>
&gt; +=C2=A0 =C2=A0 QemuSemaphore sem;<br>
&gt; +=C2=A0 =C2=A0 hwaddr physical_address;<br>
&gt; +=C2=A0 =C2=A0 uint64_t length;<br>
&gt; +=C2=A0 =C2=A0 void *dst;<br>
&gt; +=C2=A0 =C2=A0 bool success;<br>
&gt; +} AppleGFXReadMemoryJob;<br>
&gt; +<br>
&gt; +static void apple_gfx_do_read_memory(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 MemTxResult r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 r =3D dma_memory_read(&amp;address_space_memory, job-&g=
t;physical_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 job-&gt;dst, job-&gt;length, MEMTXATTRS_UNSPECIFIED);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;success =3D r =3D=3D MEMTX_OK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_post(&amp;job-&gt;sem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_a=
ddress,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t length, void *ds=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .physical_address =3D physical_address, .=
length =3D length, .dst =3D dst<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_read_memory(physical_address, length, d=
st);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Performing DMA requires BQL, so do it in a BH. */<br=
>
&gt; +=C2=A0 =C2=A0 qemu_sem_init(&amp;job.sem, 0);<br>
&gt; +=C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_do_read_memory, &amp;job);<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_wait(&amp;job.sem);<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_destroy(&amp;job.sem);<br>
&gt; +=C2=A0 =C2=A0 return job.success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ------ Memory-mapped device I/O operations ------ */<br>
&gt; +<br>
&gt; +static dispatch_queue_t get_background_queue(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORIT=
Y_DEFAULT, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXIOJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *state;<br>
&gt; +=C2=A0 =C2=A0 uint64_t offset;<br>
&gt; +=C2=A0 =C2=A0 uint64_t value;<br>
&gt; +=C2=A0 =C2=A0 bool completed;<br>
&gt; +} AppleGFXIOJob;<br>
&gt; +<br>
&gt; +static void apple_gfx_do_read(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 job-&gt;value =3D [job-&gt;state-&gt;pgdev mmioReadAtOf=
fset:job-&gt;offset];<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;completed, true);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned =
size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D false,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D get_background_queue();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;job, apple_gfx_do_read);<b=
r>
&gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(NULL, !qatomic_read(&amp;job.completed))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_read(offset, job.value);<br>
&gt; +=C2=A0 =C2=A0 return job.value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_do_write(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 [job-&gt;state-&gt;pgdev mmioWriteAtOffset:job-&gt;offs=
et value:job-&gt;value];<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;completed, true);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The methods mmioReadAtOffset: and especially mm=
ioWriteAtOffset: can<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* trigger synchronous operations on other dispatc=
h queues, which in turn<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* may call back out on one or more of the callbac=
k blocks. For this reason,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and as we are holding the BQL, we invoke the I/=
O methods on a pool<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* thread and handle AIO tasks while we wait. Any =
work in the callbacks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* requiring the BQL will in turn schedule BHs whi=
ch this thread will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* process while waiting.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D false,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D get_background_queue();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;job, apple_gfx_do_write);<=
br>
&gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(NULL, !qatomic_read(&amp;job.completed))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_write(offset, val);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps apple_gfx_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D apple_gfx_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D apple_gfx_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static size_t apple_gfx_get_default_mmio_range_size(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t mmio_range_size;<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDes=
criptor new];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size =3D desc.mmioLength;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return mmio_range_size;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ------ Initialisation and startup ------ */<br>
&gt; +<br>
&gt; +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*=
 obj_name)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t mmio_range_size =3D apple_gfx_get_default_mmio_r=
ange_size();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_common_init(obj_name, mmio_range_size);=
<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem_gfx, obj, &amp;a=
pple_gfx_ops, s, obj_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mmio_range_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* TODO: PVG framework supports serialising device stat=
e: integrate it! */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 desc.createTask =3D ^(uint64_t vmSize, void * _Nullable=
 * _Nonnull baseAddress) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGTask_t *task =3D apple_gfx_new_task(s, =
vmSize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *baseAddress =3D (void *)task-&gt;address=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_create_task(vmSize, *base=
Address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return task;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.destroyTask =3D ^(PGTask_t * _Nonnull task) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_destroy_task(task, task-&=
gt;mapped_regions-&gt;len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_destroy_task(s, task);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint=
32_t range_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t virtual_offset, bool read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGPhysicalMemoryRange_t * _Nonnull ranges) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return apple_gfx_task_map_memory(s, task,=
 virtual_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ranges, range_count, read_only);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, ui=
nt64_t virtual_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_task_unmap_memory(s, task, virt=
ual_offset, length);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.readMemory =3D ^bool(uint64_t physical_address, ui=
nt64_t length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void * _Nonnull dst) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return apple_gfx_read_memory(s, physical_=
address, length, dst);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void new_frame_handler_bh(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Drop frames if we get too far ahead. */<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt;=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ++s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_render_new_frame(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static PGDisplayDescriptor *apple_gfx_prepare_display_descriptor(Appl=
eGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor=
 new];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://disp_desc.name" rel=3D"noreferrer" ta=
rget=3D"_blank">disp_desc.name</a> =3D @&quot;QEMU display&quot;;<br>
&gt; +=C2=A0 =C2=A0 disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.);=
 /* A 20&quot; display */<br>
&gt; +=C2=A0 =C2=A0 disp_desc.queue =3D dispatch_get_main_queue();<br>
&gt; +=C2=A0 =C2=A0 disp_desc.newFrameEventHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_new_frame();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(), new_frame_handler_bh, s);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t size=
InPixels,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSType pixelFormat=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_mode_change(sizeInPixels.=
x, sizeInPixels.y);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mode(s, sizeInPixels.x, sizeInPixels.=
y);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *gl=
yph,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDisplayCoo=
rd_t hotspot) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXSetCursorGlyphJob *job =3D g_mall=
oc0(sizeof(*job));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 job-&gt;s =3D s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 job-&gt;glyph =3D glyph;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 job-&gt;hotspot =3D hotspot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [glyph retain];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_cursor_glyph, job);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorShowHandler =3D ^(BOOL show) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_show(show);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;s-&gt;cursor_show, show)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor_bh, s);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorMoveHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_move();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor_bh, s);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return disp_desc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static NSArray&lt;PGDisplayMode*&gt;* apple_gfx_prepare_display_mode_=
array(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];<br>
&gt; +=C2=A0 =C2=A0 NSArray&lt;PGDisplayMode*&gt;* mode_array =3D nil;<br>
<br>
Don&#39;t initialize mode_array here; it will suppress an uniniailized <br>
variable warning in case you forget assigning a real value later.<br></bloc=
kquote><div><br></div><div>OK<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGDisplayMode alloc] init=
WithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mode_array =3D [NSArray arrayWithObjects:modes count:AR=
RAY_SIZE(apple_gfx_modes)];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [modes[i] release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D nil;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return mode_array;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static id&lt;MTLDevice&gt; copy_suitable_metal_device(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLDevice&gt; dev =3D nil;<br>
&gt; +=C2=A0 =C2=A0 NSArray&lt;id&lt;MTLDevice&gt;&gt; *devs =3D MTLCopyAll=
Devices();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Prefer a unified memory GPU. Failing that, pick a no=
n-removable GPU. */<br>
&gt; +=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; devs.count; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devs[i].hasUnifiedMemory) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!devs[i].removable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dev !=3D nil) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dev retain];<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D MTLCreateSystemDefaultDevice();<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [devs release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return dev;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc, Error **errp)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc =3D nil;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (apple_gfx_mig_blocker =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;apple_gfx_mig_blocker,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
Migration state blocked by apple-gfx display device&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_add_blocker(&amp;apple_gfx_mi=
g_blocker, errp) &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_init(&amp;s-&gt;task_mutex);<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;s-&gt;tasks);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;render_queue =3D dispatch_queue_create(&quot;appl=
e-gfx.render&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DISPATCH_QUEUE_SERIAL);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mtl =3D copy_suitable_metal_device();<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mtl_queue =3D [s-&gt;mtl newCommandQueue];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.device =3D s-&gt;mtl;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_register_task_mapping_handlers(s, desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;cursor_show =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdev =3D PGNewDeviceWithDescriptor(desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 disp_desc =3D apple_gfx_prepare_display_descriptor(s);<=
br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp =3D [s-&gt;pgdev newDisplayWithDescriptor:=
disp_desc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 port:0 serialNum:1234];<br>
&gt; +=C2=A0 =C2=A0 [disp_desc release];<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D apple_gfx_prepare_display_mod=
e_array();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_init(dev, 0, &amp;apple_g=
fx_fb_ops, s);<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index 20a94973fa2..cf9e6dd35d2 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -61,6 +61,12 @@ system_ss.add(when: &#39;CONFIG_ARTIST&#39;, if_tru=
e: files(&#39;artist.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ATI_VGA&#39;, if_true: [fi=
les(&#39;ati.c&#39;, &#39;ati_2d.c&#39;, &#39;ati_dbg.c&#39;), pixman])<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +if host_os =3D=3D &#39;darwin&#39;<br>
&gt; +=C2=A0 system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if_true: [files(&#39;apple-gfx.m&#39;), pvg, metal])<br>
&gt; +=C2=A0 if cpu =3D=3D &#39;aarch64&#39;<br>
&gt; +=C2=A0 =C2=A0 system_ss.add(when: &#39;CONFIG_MAC_PVG_MMIO&#39;,=C2=
=A0 if_true: [files(&#39;apple-gfx-mmio.m&#39;), pvg, metal])<br>
&gt; +=C2=A0 endif<br>
&gt; +endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.source_set()<br>
&gt; diff --git a/hw/display/trace-events b/hw/display/trace-events<br>
&gt; index d26d663f963..a50e4eea0c0 100644<br>
&gt; --- a/hw/display/trace-events<br>
&gt; +++ b/hw/display/trace-events<br>
&gt; @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) &quot;dest_wi=
dth : %u&quot;<br>
&gt;=C2=A0 =C2=A0dm163_leds(int led, uint32_t value) &quot;led %d: 0x%x&quo=
t;<br>
&gt;=C2=A0 =C2=A0dm163_channels(int channel, uint8_t value) &quot;channel %=
d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0dm163_refresh_rate(uint32_t rr) &quot;refresh rate %d&quot=
;<br>
&gt; +<br>
&gt; +# apple-gfx.m<br>
&gt; +apple_gfx_read(uint64_t offset, uint64_t res) &quot;offset=3D0x%&quot=
;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_write(uint64_t offset, uint64_t val) &quot;offset=3D0x%&quo=
t;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_create_task(uint32_t vm_size, void *va) &quot;vm_size=3D0x%=
x base_addr=3D%p&quot;<br>
&gt; +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions) &=
quot;task=3D%p, task-&gt;mapped_regions-&gt;len=3D%u&quot;<br>
&gt; +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtu=
al_offset, uint32_t read_only) &quot;task=3D%p range_count=3D0x%x virtual_o=
ffset=3D0x%&quot;PRIx64&quot; read_only=3D%d&quot;<br>
&gt; +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t p=
hys_len) &quot;[%d] phys_addr=3D0x%&quot;PRIx64&quot; phys_len=3D0x%&quot;P=
RIx64<br>
&gt; +apple_gfx_remap(uint64_t retval, void *source_ptr, uint64_t target) &=
quot;retval=3D%&quot;PRId64&quot; source=3D%p target=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t =
length) &quot;task=3D%p virtual_offset=3D0x%&quot;PRIx64&quot; length=3D0x%=
&quot;PRIx64<br>
&gt; +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *d=
st) &quot;phys_addr=3D0x%&quot;PRIx64&quot; length=3D0x%&quot;PRIx64&quot; =
dest=3D%p&quot;<br>
&gt; +apple_gfx_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<br>
&gt; +apple_gfx_new_frame(void) &quot;&quot;<br>
&gt; +apple_gfx_mode_change(uint64_t x, uint64_t y) &quot;x=3D%&quot;PRId64=
&quot; y=3D%&quot;PRId64<br>
&gt; +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) &=
quot;bpp=3D%d width=3D%&quot;PRId64&quot; height=3D0x%&quot;PRId64<br>
&gt; +apple_gfx_cursor_show(uint32_t show) &quot;show=3D%d&quot;<br>
&gt; +apple_gfx_cursor_move(void) &quot;&quot;<br>
&gt; +apple_gfx_common_init(const char *device_name, size_t mmio_size) &quo=
t;device: %s; MMIO size: %zu bytes&quot;<br>
&gt; +<br>
&gt; +# apple-gfx-mmio.m<br>
&gt; +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) &quot;offset=
=3D0x%&quot;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val) &quot;offse=
t=3D0x%&quot;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, =
void *va, void *e, void *f, void* va_result) &quot;phys=3D0x%&quot;PRIx64&q=
uot; len=3D0x%&quot;PRIx64&quot; ro=3D%d va=3D%p e=3D%p f=3D%p -&gt; *va=3D=
%p&quot;<br>
&gt; +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_=
t start, uint64_t end) &quot;index=3D%zu, region=3D%p, 0x%&quot;PRIx64&quot=
;-0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void=
 *e, void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p&quot;<br>
&gt; +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) &quot;un=
mapping @ %p from memory region %p&quot;<br>
&gt; +apple_gfx_iosfc_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<=
br>
&gt; +<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index e0b880e4e13..3c61238bc77 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -794,6 +794,8 @@ socket =3D []<br>
&gt;=C2=A0 =C2=A0version_res =3D []<br>
&gt;=C2=A0 =C2=A0coref =3D []<br>
&gt;=C2=A0 =C2=A0iokit =3D []<br>
&gt; +pvg =3D not_found<br>
&gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0emulator_link_args =3D []<br>
&gt;=C2=A0 =C2=A0midl =3D not_found<br>
&gt;=C2=A0 =C2=A0widl =3D not_found<br>
&gt; @@ -815,6 +817,8 @@ elif host_os =3D=3D &#39;darwin&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0coref =3D dependency(&#39;appleframeworks&#39;, mod=
ules: &#39;CoreFoundation&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0iokit =3D dependency(&#39;appleframeworks&#39;, mod=
ules: &#39;IOKit&#39;, required: false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0host_dsosuf =3D &#39;.dylib&#39;<br>
&gt; +=C2=A0 pvg =3D dependency(&#39;appleframeworks&#39;, modules: &#39;Pa=
ravirtualizedGraphics&#39;)<br>
&gt; +=C2=A0 metal =3D dependency(&#39;appleframeworks&#39;, modules: &#39;=
Metal&#39;)<br>
&gt;=C2=A0 =C2=A0elif host_os =3D=3D &#39;sunos&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket =3D [cc.find_library(&#39;socket&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.find_library(=
&#39;nsl&#39;),<br>
<br>
</blockquote></div></div>

--0000000000007fe85f0627e26579--

