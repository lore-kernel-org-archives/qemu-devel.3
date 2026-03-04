Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9600AEB7ED7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkax-0005cQ-U8; Wed, 04 Mar 2026 06:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxkav-0005bv-Gb
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:40:49 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxkas-0006LC-Vi
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:40:49 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65f980cea07so9888894a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772624445; x=1773229245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQvZ4gBS3W/9k90NG+g/VmG33dbO61dpSaaraS91Vn8=;
 b=xevhjJkli0spE0k7RaEA810D2ojSe08GHK6GiYIv0TfxvylDVX5YagComdwIwvVQwR
 MUcCzLKU5ybrDFpWTytCU/dRW1GNMzKgLOSyxOOb5JNV0QKO7QFvPliy4nWhiaoqJ1JB
 sX9dbx6X0vuN6PW6aR/VbtmWwiIKBzGF0opmNwardpWubKXrtKGwZ0p7lg/0P3utESjh
 2cQAm5w9DkAoJJbDxUiT6NeQzmuqe+ESuDz1jJSz48Z69cGy8UTK/OugF6VKBbeJ643f
 qMbdsWLrYK1uyeV1Rk6VPvmSyQPNcqlWlS0eJfVrYKFT+J82De9YmUZg9RWrhwHagqxO
 diNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772624445; x=1773229245;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQvZ4gBS3W/9k90NG+g/VmG33dbO61dpSaaraS91Vn8=;
 b=YJJ7xSXoZmdUjhtNFs66iCkXbjwB3OCi50PvorIqlaX4pXkoPFSfi+E/bhhKrN5Tht
 VRVlPZUI/0dyGvJLri8salL2nG87plEG9+UvYthuzQcaMDJGdOGgaqoF0SuzrAkMKtAM
 PbDteJcDjhvwTBLCwDHoKoqdEyH2u/dO91upNxIVODVx3lwpJHuCeJJ1u7PGFPjwk2Rz
 x0x5gjuK6QiEYaPgYUd/jcAmuC6fhX5nKsoxOpIGsoFo/wiu2ZzcJJ0ytvGH/+pJJcnA
 kEdGBO6QIHX99G73Fj0/C+9L16NCpTWuluGQO5bV8PFqhKNa1P352U7JZ5kN3xX4jdIo
 +76Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDEJGMe9Q+96BLNhODi89L9h/P+s5/IVMEqCz3hnDKTvcA3cuxRKUNWw/86/X1YKM2/0e85pcYTBRU@nongnu.org
X-Gm-Message-State: AOJu0YwEQDunIQtZ2UWOpOD18fQiWAuTCWaoZ2RdTugG7iXwNS0OaiwP
 WfFCm++6/LJZX4FGSjd7YCXhyqghoLsTZHEQMS61F5Kq6fGqBOdJowvnMriAkxennj8=
X-Gm-Gg: ATEYQzyBJ6L+xE6kkhcC4WrOXEwMMxrDbrFl7/Ef9GlZFbyJ5mxqyNQfkrpZVNxo9us
 CTd0lUI9zx3moBLNSZ2cRZYVqeUQr6qQiAWRML0J1xw8I5/oewyELcNulY64iSKuwmbt98nTqpj
 tjjVspCoHtiM84TJk6jFsmuYCfNdAuTm/pk/NwexACb6y04HacqMoPdmmIC5lV9lyjtaK8C1bnR
 y3l2MeGshw72GbDl9ymPShl7QQkgd9jUF8bVAMofetAVznApkIlMlz3Gauj8VoF9l0HwIhiIzD9
 yrE3ZNGyFSZx2z0gAxjj1qcb3CUpCbRKgXrX003mne9v1u2EFbZU3RojmwqH3ot4Q7wfPWCsRt+
 kvadiXlzm4hUZtGyJjqaaJf9dbF4sd/7PCpgXd3YdZf0iYqov3VfgnZMSxKN2auRykRbX1uZaez
 7OPCCoQen0Akb4ix5vhR+4lh0=
X-Received: by 2002:a17:907:a4e:b0:b8f:8ff5:439 with SMTP id
 a640c23a62f3a-b93f147bcb8mr114724866b.43.1772624443431; 
 Wed, 04 Mar 2026 03:40:43 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae666d6sm725272266b.37.2026.03.04.03.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 03:40:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0644E5F7F5;
 Wed, 04 Mar 2026 11:40:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [PATCH v22 06/18] ui/sdl2: Implement dpy dmabuf functions
In-Reply-To: <feff43ef-1618-4a09-aba4-e4e9c2d07e2c@collabora.com> (Dmitry
 Osipenko's message of "Wed, 4 Mar 2026 13:33:34 +0300")
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <20260303151422.977399-7-dmitry.osipenko@collabora.com>
 <874imwq8rj.fsf@draig.linaro.org>
 <feff43ef-1618-4a09-aba4-e4e9c2d07e2c@collabora.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 11:40:41 +0000
Message-ID: <87y0k7q0ue.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 3/4/26 11:49, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>
<snip>
>>> @@ -120,6 +124,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>>>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is di=
sabled */
>>>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, =
-1, 0);
>>>      }
>>> +
>>> +    qemu_egl_display =3D eglGetCurrentDisplay();
>>> +
>>=20
>> This fails on MacOS for some reason:
>>=20
>>   o libsystem.a.p/ui_sdl2.c.o -c ../ui/sdl2.c
>>   ../ui/sdl2.c:128:5: error: use of undeclared identifier 'qemu_egl_disp=
lay'
>>     128 |     qemu_egl_display =3D eglGetCurrentDisplay();
>>         |     ^
>>   ../ui/sdl2.c:128:24: error: call to undeclared function 'eglGetCurrent=
Display'; ISO C99 and later do not support implicit function declarations [=
-Wimplicit-function-declaration]
>>     128 |     qemu_egl_display =3D eglGetCurrentDisplay();
>>         |                        ^
>>   2 errors generated.
>>=20
>> See: https://gitlab.com/stsquad/qemu/-/jobs/13340079105
>>=20
>> Not sure what the include differences are because --enable-sdl builds
>> fine on Linux.
>
> Please try with this change and let me know if you could squash it or I
> need to send a patch:
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 3bb2676f847b..2603b0c2bdd8 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -125,7 +125,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
, 0);
>      }
>
> +#ifdef CONFIG_OPENGL
>      qemu_egl_display =3D eglGetCurrentDisplay();
> +#endif
>
>      sdl_update_caption(scon);
>  }

heh, I had got to something similar but then ran into a link failure at
the end:

  Undefined symbols for architecture arm64:
    "_sdl2_gl_console_init", referenced from:
        _sdl2_display_init in ui_sdl2.c.o
  ld: symbol(s) not found for architecture arm64
  clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
  ninja: build stopped: subcommand failed.
  make: *** [run-ninja] Error 1

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

