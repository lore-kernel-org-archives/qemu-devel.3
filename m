Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C762D5E362
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9iNO-0002Y7-Vl; Sat, 09 Nov 2024 05:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t9iNN-0002Xo-Kp
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:07:29 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t9iNK-0006ZN-VT
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:07:28 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso2392051a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731146844; x=1731751644;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gl3oZT0Kai3WVYoIroV8igmNHXu+iVO+E8vhp0DQBKQ=;
 b=iU4wixF3xawzZZnwzIamkM1UhT6zmqz1kIR8Bkg8129B58oxVxAAqlraFrXiBpVTLP
 LKzMu3PS3buI690nR1oX5yd7m6v8Co0feuK92Iqb4ipyo94M/rFBTHSOl6kmGiF4JYmT
 bQ47eKKsKK0mqZE+KwS5mKHQgIM7GXekAODMNJz111DiynN2xu+/BWMUqd26ZS4Fcb5c
 I4oETJq5qs0mPWlysTDmijQJ3hM6SYz1BsUsCTpiI+vIwwdOpn94Qv/V5abI3Upa0J6P
 xz9ASH1+cIPJTfZ9fUrN8sVDUIHnZLeu0KbLQdFB5AO2B1TSMO1aTMQ4yTqpTCW5+2i6
 va8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731146844; x=1731751644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gl3oZT0Kai3WVYoIroV8igmNHXu+iVO+E8vhp0DQBKQ=;
 b=aiKQ86fC76/6UdkpV5zDjB0F1x8BRG3xTmI1xoszxbzUfJ1ZZ9lER/7tk2UoaNDNEp
 ToVhEYWlBcJPv0bspneReXs/cXcVE0q08noFXcscXGgHy9xJL6Or3HkbFB09BVACkNoF
 ytnNkNVPF4vY9pV/iypKfNCB/zlxI35gYHD8lGcBeVa5tp7d7oRFAwom9Rl4wRnkd1Sx
 OANP6NFxohzIeVeqzJEtwA41cG1+67Ak0jovUzisnQt6E1c0Tt2x/n3Dm+ZX4hzwKNfR
 nMjjmVB631IYqpGwD0Kr7ogqA+SkXQB3+2ZkWGDhk4aziIYEeFpQkqXj/DVUsnkGW8wS
 eq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6FrxP+HA5Z0OEkzj4NWvdC81EHfK7KRSMuRgpm0qRcntXLTnSSdbLvqT2wAIZ22AYAWZM71qpS7K3@nongnu.org
X-Gm-Message-State: AOJu0YzVEh7BPdZWKI1/4cBGVuDHjYghgIj7ivPG08uCiNrqg4A8SeJl
 EaAzPTm33foIUdKijDQ8+QGxUqqmxJ5R0GYYLBuThEqTfYMRNaeKIr33m5JFx6o=
X-Google-Smtp-Source: AGHT+IEyERSgVCB4BQguLGap0D6ZshcozxKivWoVPChYV2gOXYy0/oqIQQ19+Ljaj/cJGILpnYw9wg==
X-Received: by 2002:a17:902:cf02:b0:20c:af07:a816 with SMTP id
 d9443c01a7336-21183d087c7mr72021335ad.31.1731146844602; 
 Sat, 09 Nov 2024 02:07:24 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e41717sm42723455ad.122.2024.11.09.02.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 02:07:24 -0800 (PST)
Message-ID: <3d027b41-f0c7-4807-934c-395bfe507e09@daynix.com>
Date: Sat, 9 Nov 2024 19:07:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ui/sdl2: Implement dpy dmabuf functions
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-3-dmitry.osipenko@collabora.com>
 <d800f856-cdf4-4573-8fd6-6a8e1434090a@daynix.com>
 <5494be03-9bdb-4ec4-8c45-2c92f7591ae1@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5494be03-9bdb-4ec4-8c45-2c92f7591ae1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

On 2024/11/09 15:52, Dmitry Osipenko wrote:
> Accidentally missed this email a week ago. Thanks again for all the reviews!
> 
> On 10/31/24 10:32, Akihiko Odaki wrote:
> ...
>>>    +# libx11 presents together with SDL or GTK libs on systems that
>>> support X11
>>> +xlib = dependency('x11', required: false)
>>
>> There is a line saying:
>> x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
>>
>> Please reuse it.
> 
> I've seen this option and choose not to use it because despite the brief
> 'X11' name, it's about X11 support specifically for GTK and not SDL.
> 
> Though, we can use this GTK/X11 for now and improve Meson dependencies
> later on because in practice GTK is enabled for all distro-built QEMUs.
> Will switch to it in v3.

I think you can just remove "if gtkx11.found()" to use it for SDL.

> 
> ...
>>> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>>> +                            QemuDmaBuf *dmabuf)
>>> +{
>>> +    struct sdl2_console *scon = container_of(dcl, struct
>>> sdl2_console, dcl);
>>> +
>>> +    assert(scon->opengl);
>>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>> +
>>> +    egl_dmabuf_import_texture(dmabuf);
>>> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
>>> +        error_report("%s: failed fd=%d", __func__,
>>> qemu_dmabuf_get_fd(dmabuf));
>>
>> It still continues to call sdl2_gl_scanout_texture() and I doubt that's
>> what you meant.
> 
> Indeed, better to bail out early on a error.
> 
> ...
>>>    +static void sdl2_set_hint_x11_force_egl(void)
>>> +{
>>> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
>>> +    defined(CONFIG_XLIB)
>>> +    Display *x_disp = XOpenDisplay(NULL);
>>> +    EGLDisplay egl_display;
>>> +
>>> +    if (!x_disp) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Prefer EGL over GLX to get dma-buf support. */
>>> +    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
>>> +
>>> +    if (egl_display != EGL_NO_DISPLAY) {
>>> +        /*
>>> +         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer 11 over
>>
>> s/prefer 11 over/prefer X11 over/
>>
>> Personally, I'm more concerned whether setting that hint will make an
>> invalid argument error or something.
> 
> There are no known side effects from setting that hint for QEMU and
> libsdl code looks sane. AFAICT, EGL is not enabled by default in SDL
> only because there are older SDL applications that use GLX features and
> they will be broken if SDL will switch to EGL by default.
 > > Technically, should be possible to make SDL use EGL on demand, like 
only
> when QEMU runs with enabled native-context for example. But there is no
> point in doing that today since there are no known problems with the EGL
> hint, IMO. We will be able to address problems if somebody will report a
> bug.
> 

I was thinking of scenarios where X11 is not used. A convincing scenario 
  of failure is that SDL emits an error for the flag and stops working. 
The fact that this code just works implies it is not the case, but it's 
worth noting if you leave a comment anyway.

Regards,
Akihiko Odaki


