Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C5BD5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9fLd-0001Zw-0N; Sat, 09 Nov 2024 01:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t9fLQ-0001Zb-9g
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:53:17 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t9fLO-0003YA-3d
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:53:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731135174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cgEf2OyVpuBL3VFkwk7bXnHH1b/xEO2XC5X7ROULwB9Wgw76u+OwrzJo+5FZkq1xVVeoLpS3IAjI0Bod1uX69iKnShNNZMhkzsmUN4ShGt0SQV4Zjmc1SqaYoxlzmSUC5Q/F7yLA/adnWMb5JRqpBYCagbCchYKVToI0uGpD8YI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731135174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ik46TfqLlY+2EMLpjZRD6NwGxuu5mRhmC7XjRCMNOEw=; 
 b=GJFzDqDSyNnjkMadkRoq6df5wAdlJdG4nF6C8ow0kQlB9YD+T92394fxIh2FjANQHA1kvGnnB2LYv1eAoL/octfcB/akr6wzjFtd3ITME8DdrTDJ+7avxf/7jMqWjt+hesQhUIunMIAFDVcIro1Ntpoo1EbqGmdP1+TBPSXrgcs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731135174; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Ik46TfqLlY+2EMLpjZRD6NwGxuu5mRhmC7XjRCMNOEw=;
 b=djx79HDK2Uv4gpSIQuzJmfQH3yDnHL1HmkREuY3DuRr45NSWACidBS2N8Sokv9lj
 1c0m7jCKOW3GkzIPjqEQ3ID7N8m4MDbbpadiBjbSJX4b2Vq2/+P6iODeLnQuRhqdhDO
 jGmHscdcHBwdtl3ZTXWMRfyug+JqvC6se7Z0adnA=
Received: by mx.zohomail.com with SMTPS id 1731135172288805.5880273171275;
 Fri, 8 Nov 2024 22:52:52 -0800 (PST)
Message-ID: <5494be03-9bdb-4ec4-8c45-2c92f7591ae1@collabora.com>
Date: Sat, 9 Nov 2024 09:52:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ui/sdl2: Implement dpy dmabuf functions
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <d800f856-cdf4-4573-8fd6-6a8e1434090a@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Accidentally missed this email a week ago. Thanks again for all the reviews!

On 10/31/24 10:32, Akihiko Odaki wrote:
...
>>   +# libx11 presents together with SDL or GTK libs on systems that
>> support X11
>> +xlib = dependency('x11', required: false)
> 
> There is a line saying:
> x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
> 
> Please reuse it.

I've seen this option and choose not to use it because despite the brief
'X11' name, it's about X11 support specifically for GTK and not SDL.

Though, we can use this GTK/X11 for now and improve Meson dependencies
later on because in practice GTK is enabled for all distro-built QEMUs.
Will switch to it in v3.

...
>> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>> +                            QemuDmaBuf *dmabuf)
>> +{
>> +    struct sdl2_console *scon = container_of(dcl, struct
>> sdl2_console, dcl);
>> +
>> +    assert(scon->opengl);
>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>> +
>> +    egl_dmabuf_import_texture(dmabuf);
>> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
>> +        error_report("%s: failed fd=%d", __func__,
>> qemu_dmabuf_get_fd(dmabuf));
> 
> It still continues to call sdl2_gl_scanout_texture() and I doubt that's
> what you meant.

Indeed, better to bail out early on a error.

...
>>   +static void sdl2_set_hint_x11_force_egl(void)
>> +{
>> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
>> +    defined(CONFIG_XLIB)
>> +    Display *x_disp = XOpenDisplay(NULL);
>> +    EGLDisplay egl_display;
>> +
>> +    if (!x_disp) {
>> +        return;
>> +    }
>> +
>> +    /* Prefer EGL over GLX to get dma-buf support. */
>> +    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
>> +
>> +    if (egl_display != EGL_NO_DISPLAY) {
>> +        /*
>> +         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer 11 over
> 
> s/prefer 11 over/prefer X11 over/
> 
> Personally, I'm more concerned whether setting that hint will make an
> invalid argument error or something.

There are no known side effects from setting that hint for QEMU and
libsdl code looks sane. AFAICT, EGL is not enabled by default in SDL
only because there are older SDL applications that use GLX features and
they will be broken if SDL will switch to EGL by default.

Technically, should be possible to make SDL use EGL on demand, like only
when QEMU runs with enabled native-context for example. But there is no
point in doing that today since there are no known problems with the EGL
hint, IMO. We will be able to address problems if somebody will report a
bug.

-- 
Best regards,
Dmitry

