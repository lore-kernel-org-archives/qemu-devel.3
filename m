Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006F7C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9iP-0006GQ-8q; Mon, 17 Jun 2024 06:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJ9iN-0006G1-Dk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:35:55 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJ9iL-0001xG-CY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:35:55 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52bc035a7ccso4498955e87.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718620551; x=1719225351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OpocPjb9gqadAYpSkBRkoanu+g/ChaASk4sUnI1LJuU=;
 b=vlyRJt4sC5H89+FWP+IsuzTS7HMk8UmUm6P2dIAjXbjDc3WmnljsJhM97gg4ROVW14
 gRMt76bk7b/mg2+9wzB9ZcK1po4OSik7MWsywwvBfjNgvLwLpYNpYjLO+DzpDhnnOYV0
 5HKG/bU1AjcWlHKUP3Fi7OXikmRFBL3qt+XAXagHbpg0JoSGOwWihfjw3haWHP8uoJqG
 bO2weeLCPE380fv7uxSqqRUQ2K6HEodNIHx6yIDt+YupaCpE/sfoMi5jST2rRQf5OG4T
 iZiarkIh4lryZmWkSuRPYHQ4M6YIZXx8YBndtXtC9bayJ8H6vgdGziAl6qgAgcDLcEaz
 /1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718620551; x=1719225351;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpocPjb9gqadAYpSkBRkoanu+g/ChaASk4sUnI1LJuU=;
 b=MRpJRDfuODh6y0+oasSSR74i4qZ7O53pCl4RqSXy68X7jmHbJ55AbZgJAvT7LfC+aH
 IKndQ404z9fi6S0MJvdY2WqCmUPEkca1B3+hoqDeFSuGXW8Pq9x1NEhF27ajXozzeALx
 EWhu+Im73+R1bbVk9sflM2mVlgoJbMC6wGgUpIYOPglWD7yciD9cFaPSdIS6dJ4ez19L
 VKG1aBwUfPJPlkpytA7cRWnrgam+9+SudN2WuNnO2d/LILE8mNwGNbqsKYAb75i0eOI4
 WTnZlyBfcqJS0fX8ELvZ/XEAOXKz7E0WyHl0ILNG+GcpvHY4rCh2jZT3tin07LSoinuR
 l+sw==
X-Gm-Message-State: AOJu0Yw9PZ1/NTSbdB33KLlq546M5hZTpMgewJBtNdAqY5ScwUbQEBmH
 iG63EW/9+YrCs1JfX4Sg6Z8vElroiWq5zZ8xpyYIXetSXEwr0pGuLJt5djjrDrc=
X-Google-Smtp-Source: AGHT+IFIbviRgHljjMjZRmIfkCWrACLnSj1Vy0drp3Ry3WStr8/sWTYnvsWobFl5yAqkIfwUyzRGOg==
X-Received: by 2002:a05:6512:2309:b0:52c:a723:bda3 with SMTP id
 2adb3069b0e04-52ca723be09mr6332592e87.69.1718620551219; 
 Mon, 17 Jun 2024 03:35:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c8b7sm11520173f8f.26.2024.06.17.03.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 03:35:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D54085F78B;
 Mon, 17 Jun 2024 11:35:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
In-Reply-To: <43f3ae5f-4bb8-4330-a79d-b0a50d2e397a@daynix.com> (Akihiko
 Odaki's message of "Thu, 6 Jun 2024 05:05:46 +0900")
References: <20240605133527.529950-1-alex.bennee@linaro.org>
 <43f3ae5f-4bb8-4330-a79d-b0a50d2e397a@daynix.com>
Date: Mon, 17 Jun 2024 11:35:49 +0100
Message-ID: <87cyofeu0q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/06/05 22:35, Alex Benn=C3=A9e wrote:
>> As the latest features for virtio-gpu need a pretty recent version of
>> libvirglrenderer. When it is not available on the system we can use a
>> meson wrapper and provide it when --download is specified in
>> configure.
>> We have to take some additional care as currently QEMU will hang
>> libvirglrenderer fails to exec the render server. As the error isn't
>> back propagated we make sure we at least test we have a path to an
>> executable before tweaking the environment.
>
> Hi,
>
> The intent of this patch sounds good to me. It is the responsibility
> of users to set up virglrenderer in principle, but we can just be kind
> for them.
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   meson.build                    |  7 ++++++-
>>   hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
>>   subprojects/virglrenderer.wrap |  6 ++++++
>>   3 files changed, 36 insertions(+), 1 deletion(-)
>>   create mode 100644 subprojects/virglrenderer.wrap
>> diff --git a/meson.build b/meson.build
>> index 1d7346b703..e4e270df78 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1203,7 +1203,8 @@ have_vhost_user_gpu =3D have_tools and host_os =3D=
=3D 'linux' and pixman.found()
>>   if not get_option('virglrenderer').auto() or have_system or have_vhost=
_user_gpu
>>     virgl =3D dependency('virglrenderer',
>>                        method: 'pkg-config',
>> -                     required: get_option('virglrenderer'))
>> +                     required: get_option('virglrenderer'),
>> +                     default_options: ['default_library=3Dstatic', 'ren=
der-server=3Dtrue', 'venus=3Dtrue'])
>
> meson_options.txt of virglrenderer says:
>> DEPRECATED: render server is enabled by venus automatically
>
> I'm also a bit concerned to enable Venus by default when the upstream
> virglrenderer doesn't. Why is it disabled by the upstream? Perhaps is
> it time for upstream to enable it by default?
>
>>   endif
>>   rutabaga =3D not_found
>>   if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_=
user_gpu
>> @@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=3D1.0.0')
>>     config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>>     config_host_data.set('HAVE_VIRGL_VENUS', 1)
>>   endif
>> +if virgl.type_name().contains('internal')
>> +  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
>> +endif
>> +
>>   config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>>   config_host_data.set('CONFIG_VTE', vte.found())
>>   config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl=
.c
>> index c9d20a8a60..53d6742e79 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -14,6 +14,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/iov.h"
>> +#include "qemu/cutils.h"
>>   #include "trace.h"
>>   #include "hw/virtio/virtio.h"
>>   #include "hw/virtio/virtio-gpu.h"
>> @@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>>       virgl_renderer_reset();
>>   }
>>   +/*
>> + * If we fail to spawn the render server things tend to hang so it is
>> + * important to do our due diligence before then. If QEMU has bundled
>> + * the virgl server we want to ensure we can run it from the build
>> + * directory and if installed.
>
> This comment sounds a bit misleading. The following code does not
> ensure the render server exists; it just opportunistically sets the
> path to the bundled render server or let it fail otherwise.
>
> It also sounds like virgl_set_render_env() does an extra step to
> prevent hangs, but it is actually mandatory for relocated scenarios;
> the lack of render server always results in a non-functional Venus
> setup even if the hang is fixed.
>
> The hang is better to be noted in subprojects/virglrenderer.wrap since
> that is the reason we would want to wrap the project.
>
>> + *
>> + * The principle way we can override the libvirglrenders behaviour is
>> + * by setting environment variables.
>> + */
>> +static void virgl_set_render_env(void)
>> +{
>> +#ifdef HAVE_BUNDLED_VIRGL_SERVER
>> +    g_autofree char *file =3D get_relocated_path(CONFIG_QEMU_HELPERDIR =
"/virgl_render_server");
>> +    if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EXECUTABL=
E)) {
>
> I think this g_file_test() should be removed; we would not want to let
> virglrenderer pick a random render server when the bundled server
> exists since the ABI between them can be different in theory.

I was thinking mainly of validating it was built, maybe that should be
an assert instead because if we failed to build the server we got the
bundling wrong?

>
>> +        g_setenv("RENDER_SERVER_EXEC_PATH", file, false);
>> +    }
>> +#endif
>> +}
>> +
>> +
>>   int virtio_gpu_virgl_init(VirtIOGPU *g)
>>   {
>>       int ret;
>> @@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>       }
>>   #endif
>>   +    /* Ensure we can find the render server */
>> +    virgl_set_render_env();
>> +
>>       ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>>       if (ret !=3D 0) {
>>           error_report("virgl could not be initialized: %d", ret);
>> diff --git a/subprojects/virglrenderer.wrap b/subprojects/virglrenderer.=
wrap
>> new file mode 100644
>> index 0000000000..3656a478c4
>> --- /dev/null
>> +++ b/subprojects/virglrenderer.wrap
>> @@ -0,0 +1,6 @@
>> +[wrap-git]
>> +url =3D https://gitlab.freedesktop.org/virgl/virglrenderer.git
>> +revision =3D virglrenderer-1.0.1
>> +
>> +[provide]
>> +virglrenderer =3D libvirglrenderer_dep

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

