Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C5EC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEs50-0000cB-QZ; Wed, 05 Jun 2024 10:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEs4z-0000bj-2R
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:57:33 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEs4x-00087N-0r
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:57:32 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52961b77655so2620905e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717599448; x=1718204248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+AS2jlM7XZxMqpSmSdgE/fNC/SG6FZj5pCt+/jdTVE=;
 b=KLIMAU4RG2rI4CMfCBPkh25Lz2PdmqFTJ2ApnwnEK0WO773SgA7QttuDc/NWbNu60H
 oS0BjtbMCnWw+qvgllVninNopmYpnOqYBdd5Kn7wLhPHBm0J7tBn9bZ/8tTNpdQeJz/b
 uPzlkMr2Eu7uEgpxCRBKhTG1wURXqhzSPRRKYk6zCNxuOJ9VHTEovP8xXYlMEVnz1Ffb
 3BYxNhxZba+kva4JNua6D6kWaN354FzK8q6cYckQ2sGJWAhO6i7EGnc5ZPbXej0HAcV3
 L7jVwmctO/13QIPwMQzEyOyMtqK3kSOOdkOUPG3yRdzgh59IkEaJPuuZBkwxXHfKMSHF
 1JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717599448; x=1718204248;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+AS2jlM7XZxMqpSmSdgE/fNC/SG6FZj5pCt+/jdTVE=;
 b=FbSOdHSS8sp8XpVOJLwRU1emAANaQ5iLJZpyShqwqkKPl8zLxT4m/EhOJmXXC6lP/U
 fZVy/PMTlZadR62LxHUydzDgBBtjO4BMThKjMBpS3WZ02G5aIAR1V5U+PxSwMqFuxBwB
 9AcpRCbxYZg0KeOHWSZ6SBgCu2LM6vNd2RTb/sWg2xfYeVGWPtES+lsunJC9xv3URULD
 uhsb8N/3Bi08Joh48ro+e9sHqTzgkXReddpZOJtEpojYtGQe3NCdURKb3KqyCZopwe9r
 iiGCihGZAIIvqaeanVORrsqW4HzUi84DvRbdMNjNEZ/8Pta9OC4ynS0GRbaEydeW9KUY
 myHQ==
X-Gm-Message-State: AOJu0YxA1ZoPDHTaMQAcD5mnpjboGcmkdkLpQUmOamLJplgZjiopO2T3
 H8psDgaqRc+NHTBa+W5Oy+uGoTf2U1irJA+i0rpt4iYBL1S4jybvqVkeuMkSyFc=
X-Google-Smtp-Source: AGHT+IFOdYJIWYKXUzCz10DgiKSsFJQNWW2t+Aa+PCPqwAIvA12BuhN1yUaelFZ5FwzMyoR3J40QTQ==
X-Received: by 2002:a05:6512:402:b0:529:b712:e6d5 with SMTP id
 2adb3069b0e04-52bab4e7813mr1612004e87.31.1717599448220; 
 Wed, 05 Jun 2024 07:57:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a35e86c36sm9192648a12.54.2024.06.05.07.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:57:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 306155F754;
 Wed,  5 Jun 2024 15:57:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9=20?= <berrange@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
In-Reply-To: <em3eg.b7wu81h9k9h@linaro.org> (Manos Pitsidianakis's message of
 "Wed, 05 Jun 2024 17:32:14 +0300")
References: <20240605133527.529950-1-alex.bennee@linaro.org>
 <em3eg.b7wu81h9k9h@linaro.org>
Date: Wed, 05 Jun 2024 15:57:27 +0100
Message-ID: <87zfrze8tk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Wed, 05 Jun 2024 16:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>>As the latest features for virtio-gpu need a pretty recent version of
>>libvirglrenderer. When it is not available on the system we can use a
>>meson wrapper and provide it when --download is specified in
>>configure.
>>
>>We have to take some additional care as currently QEMU will hang
>>libvirglrenderer fails to exec the render server. As the error isn't
>>back propagated we make sure we at least test we have a path to an
>>executable before tweaking the environment.
>>
>>Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>---
>> meson.build                    |  7 ++++++-
>> hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
>> subprojects/virglrenderer.wrap |  6 ++++++
>> 3 files changed, 36 insertions(+), 1 deletion(-)
>> create mode 100644 subprojects/virglrenderer.wrap
>>
>>diff --git a/meson.build b/meson.build
>>index 1d7346b703..e4e270df78 100644
>>--- a/meson.build
>>+++ b/meson.build
>>@@ -1203,7 +1203,8 @@ have_vhost_user_gpu =3D have_tools and host_os =3D=
=3D 'linux' and pixman.found()
>> if not get_option('virglrenderer').auto() or have_system or have_vhost_u=
ser_gpu
>>   virgl =3D dependency('virglrenderer',
>>                      method: 'pkg-config',
>>-                     required: get_option('virglrenderer'))
>>+                     required: get_option('virglrenderer'),
>>+                     default_options: ['default_library=3Dstatic', 'rend=
er-server=3Dtrue', 'venus=3Dtrue'])
>> endif
>> rutabaga =3D not_found
>> if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_us=
er_gpu
>>@@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=3D1.0.0')
>>   config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>>   config_host_data.set('HAVE_VIRGL_VENUS', 1)
>> endif
>>+if virgl.type_name().contains('internal')
>>+  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
>>+endif
>>+
>> config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>> config_host_data.set('CONFIG_VTE', vte.found())
>> config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
>>diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>index c9d20a8a60..53d6742e79 100644
>>--- a/hw/display/virtio-gpu-virgl.c
>>+++ b/hw/display/virtio-gpu-virgl.c
>>@@ -14,6 +14,7 @@
>> #include "qemu/osdep.h"
>> #include "qemu/error-report.h"
>> #include "qemu/iov.h"
>>+#include "qemu/cutils.h"
>> #include "trace.h"
>> #include "hw/virtio/virtio.h"
>> #include "hw/virtio/virtio-gpu.h"
>>@@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>>     virgl_renderer_reset();
>> }
>> +/*
>>+ * If we fail to spawn the render server things tend to hang so it is
>>+ * important to do our due diligence before then. If QEMU has bundled
>>+ * the virgl server we want to ensure we can run it from the build
>>+ * directory and if installed.
>>+ *
>>+ * The principle way we can override the libvirglrenders behaviour is
>>+ * by setting environment variables.
>>+ */
>>+static void virgl_set_render_env(void)
>>+{
>
> Since it's a few lines we could also inline this in
> virtio_gpu_virgl_init()

I mainly put it in a helper function to avoid putting a big comment
block inline ;-)

>
>>+#ifdef HAVE_BUNDLED_VIRGL_SERVER
>>+    g_autofree char *file =3D get_relocated_path(CONFIG_QEMU_HELPERDIR "=
/virgl_render_server");
>>+    if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EXECUTABLE=
)) {
>>+        g_setenv("RENDER_SERVER_EXEC_PATH", file, false);
>
>
>  Return value
>
>  Type: gboolean
>
>  FALSE if the environment variable couldn=E2=80=99t be set.
>
> Worth adding a check here.

ok.

> Offtopic, but it feels weird to set our environment without creating
> the process ourselves.

yeah I'm not overly happy with the way the proxy server stuff works
because its a bit spooky action at a distance (as noted by the failure
to detect it not working). Not sure if we want to replicate all the
proxy login in QEMU though.

> There's also an option to launch the server in threads, so that if it
> crashes it pulls qemu down with it. Would that work with our thread
> setup?

Hmm not sure. We could try but I suspect we want to insulate the main
process from the vagaries of the helper.

>
>
>>+    }
>>+#endif
>>+}
>>+
>>+
>> int virtio_gpu_virgl_init(VirtIOGPU *g)
>> {
>>     int ret;
>>@@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>     }
>> #endif
>> +    /* Ensure we can find the render server */
>>+    virgl_set_render_env();
>>+
>>     ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>>     if (ret !=3D 0) {
>>         error_report("virgl could not be initialized: %d", ret);
>>diff --git a/subprojects/virglrenderer.wrap b/subprojects/virglrenderer.w=
rap
>>new file mode 100644
>>index 0000000000..3656a478c4
>>--- /dev/null
>>+++ b/subprojects/virglrenderer.wrap
>>@@ -0,0 +1,6 @@
>>+[wrap-git]
>>+url =3D https://gitlab.freedesktop.org/virgl/virglrenderer.git
>>+revision =3D virglrenderer-1.0.1
>
>
> Can we say "at least 1.0.1" here? Should we? Dunno.
>
>>+
>>+[provide]
>>+virglrenderer =3D libvirglrenderer_dep
>> -- 2.39.2
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

