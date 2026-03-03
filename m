Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05410EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOW8-0006yL-OD; Tue, 03 Mar 2026 07:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxOW4-0006xg-MX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:06:21 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxOW1-00080e-Uc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:06:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772539554; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=APgESCVAMv38EbqqmckuWdkOnc9HDQDA6gZWpcSZf20ikdbNAlDdJlHPj5+No1YPGnL8nMaMBYY1sURIcTZ3fexQrQDX6gMshjudTK/26Vtm4a6n8w5zRrKgHsyMKy9uKKsIYxUrUnpzMLoL7zthTp+Hc7Z+9QgHMeu8gSc0ca0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772539554;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=v8+0Z1dLC+8WT0Kbryv8L0E9QUV4jVGCudDKkuMhjrw=; 
 b=YGYDFN/CKe7yaXBmy6P85ineTILOmW0mDSGtKI0kDW64DpDGz7C48MdAqZQDq/Ry74TwAkGRpuvjMKDlkLhcfuA73ATQx8pqxt4h16W3XOOPfy8PuClFIe8l+AT8Kk0Ngg3x8loLVIjRB7sm0qc8hZfJUHTkzOSjfp5/OV8qi0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772539554; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=v8+0Z1dLC+8WT0Kbryv8L0E9QUV4jVGCudDKkuMhjrw=;
 b=agNs9OKrOyyB4UDqfhlvT4xV66xJyz5IwJE30ZcjTSlT9WYKE48OdJefEhoiF8QQ
 rXOo83xBpDbe8toLDDsHKn8DgiFcG9/IiWpRc9UzdWlowAMkJLJc7xOaXl/MMEkVcU+
 SePjYM/CMZSUVhPJWd2kMee3VyEltdbw7T8rfp6c=
Received: by mx.zohomail.com with SMTPS id 1772539552932311.3245586633793;
 Tue, 3 Mar 2026 04:05:52 -0800 (PST)
Message-ID: <5e2c78c2-eb48-47a8-84dc-7a0e19306dd4@collabora.com>
Date: Tue, 3 Mar 2026 15:05:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 03/18] ui/egl: Don't change bound GL context when
 creating new context
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
 <20260302145920.735423-4-dmitry.osipenko@collabora.com>
 <88f3150c-277d-403c-8a64-0d91d61980be@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <88f3150c-277d-403c-8a64-0d91d61980be@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/3/26 06:49, Akihiko Odaki wrote:
> On 2026/03/02 23:59, Dmitry Osipenko wrote:
>> Don't change bound GL context when creating new GL context for
>> consistency
>> with behavior expected by virglrenderer that assumes context-creation
>> doesn't
>> switch context. eglCreateContext() doesn't require GL context to be bound
>> when it's invoked. Update qemu_egl_create_context() to spawn GL sub-
>> contexts
>> from a common parent GL context instead of a currently-bound context.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   ui/dbus.c          | 2 --
>>   ui/egl-context.c   | 3 +--
>>   ui/egl-headless.c  | 2 --
>>   ui/gtk-egl.c       | 4 ----
>>   ui/spice-display.c | 2 --
>>   5 files changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/ui/dbus.c b/ui/dbus.c
>> index 905ee6fea71b..750a064e3fbf 100644
>> --- a/ui/dbus.c
>> +++ b/ui/dbus.c
>> @@ -47,8 +47,6 @@ static DBusDisplay *dbus_display;
>>   static QEMUGLContext dbus_create_context(DisplayGLCtx *dgc,
>>                                            QEMUGLParams *params)
>>   {
>> -    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
>> -                   qemu_egl_rn_ctx);
>>       return qemu_egl_create_context(dgc, params);
>>   }
>>   diff --git a/ui/egl-context.c b/ui/egl-context.c
>> index aed3e3ba1f3f..f9a998768beb 100644
>> --- a/ui/egl-context.c
>> +++ b/ui/egl-context.c
>> @@ -19,8 +19,7 @@ QEMUGLContext qemu_egl_create_context(DisplayGLCtx
>> *dgc,
>>      };
>>      bool gles = (qemu_egl_mode == DISPLAY_GL_MODE_ES);
>>   -   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
>> -                          eglGetCurrentContext(),
>> +   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
>> qemu_egl_rn_ctx,
>>                             gles ? ctx_att_gles : ctx_att_core);
>>      return ctx;
>>   }
>> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
>> index 1f6b845500dd..19955792ac95 100644
>> --- a/ui/egl-headless.c
>> +++ b/ui/egl-headless.c
>> @@ -42,8 +42,6 @@ static void egl_gfx_switch(DisplayChangeListener *dcl,
>>   static QEMUGLContext egl_create_context(DisplayGLCtx *dgc,
>>                                           QEMUGLParams *params)
>>   {
>> -    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
>> -                   qemu_egl_rn_ctx);
>>       return qemu_egl_create_context(dgc, params);
>>   }
>>   diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>> index 0dbb429958e5..6b3519419039 100644
>> --- a/ui/gtk-egl.c
>> +++ b/ui/gtk-egl.c
>> @@ -217,10 +217,6 @@ void gd_egl_switch(DisplayChangeListener *dcl,
>>   QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
>>                                       QEMUGLParams *params)
>>   {
>> -    VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
>> -
>> -    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>> -                   vc->gfx.esurface, vc->gfx.ectx);
> 
> This uses vc->gfx.ectx instead of qemu_egl_rn_ctx so it should be passed
> to qemu_egl_create_context().

Good catch. AFAICS, the vc->gfx.ectx is initialized only once in the
code. Will double check.

One problem with gtk-egl display is that this is the only display type I
haven't tested because it's not obvious how to do it, The gdk-area is
what always get used on my machine with both x11 and wayland, and
forcing gtk-egl in the code instead of gdk-area results in a crash. I'd
appreciate if anyone could clarify how to make QEMU use gtk-egl or
whether it has been obsoleted and doesn't work with modern GTK.

-- 
Best regards,
Dmitry

