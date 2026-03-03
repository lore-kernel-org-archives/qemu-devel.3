Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C471AEC142E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNfT-0001ay-Dp; Tue, 03 Mar 2026 06:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxNfO-0001ac-OY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:11:54 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxNfL-0002xy-F6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:11:54 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-660bdba9390so259126a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772536307; x=1773141107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlC8cihEtMBMhsYP5dx/K1Gjzx/3WI5KRIFT1PqIs9E=;
 b=g+FxgzJpJ1ZaLz9Rw2gJUwQztaG06zT9ZEGQdobdfA820R0xzr/vvlrrwoI7QIt4wm
 H0x0iYfnXd69HcBw2dnzNVyXBMDkYVQe0QGaSxXk4oiACwUNWi38BSM+gyCrUpLhMgg+
 MBtGG544KhkuYL1OYeRC3kxUetyj28VTSVU/fEx3dRCnMm7cSZMC/Z5hmOX3ROOMjKGx
 pBiO9VUAgoh4buVDiUJOoubwtIn7zRoj31OsZzWP6GvQd8fXjnvkoKn7B3QbA0NKkGOW
 2byY/+NFOmuETrp0uL5xWZUkiGXjMyDNN8sIwiJJW6mzk71axbgBLjDoqfI5r6xjiOH4
 PG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772536307; x=1773141107;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TlC8cihEtMBMhsYP5dx/K1Gjzx/3WI5KRIFT1PqIs9E=;
 b=Ya8c+Z6Imudp+RYU2BQ3Zn/rvnX0VqcLbofx66jfEuQR3Csc+jPUgmEg5CI2foG0Vr
 5Coh6UHNJskq7mNfs7A8OQlHER8G3gxj59Y7/LJ9FQU1eXvEssou/frLcPCO8wJV0aY/
 DDdZh4+VKkwmycku/sRiATixLU0ExIC9xehgDujIECo+Z3A9y4RtvuN8CvdFa8xEEVm7
 2pbaJaYrYc7oshYnkJXIBlJE6HTcfZAATq/qhd/+JVq1uxKCMAE0baxG2t/t/ovl0JMT
 YGirVfy/9kE0tLiDc4cnL1fvu78/wGCbc2idFqQAUXE2K2XKZ/ZNx6OYaFhHS5UgMxWn
 Ssgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeQqrmAV3GVJfgaQL22/ESEPNAFz+EBAeCz4HQM1s8UsLICMPh4smXgnum2B3a6tUnBVSX5Tj9q13r@nongnu.org
X-Gm-Message-State: AOJu0YxKAWzTcqqex3V0YOV9REekAl7iYmri58ewQFtEBd0PIUWU7QIc
 PiHYqm9GKp80aGIxLTWT2J2DAmw15T/YmjnBY6Joa6v9/R8U0S7XlA8R1Q9tM8Z7veA=
X-Gm-Gg: ATEYQzzFrTVM9s/JTVEju5VGYzAUIV+ff7O1Jlh/470l+DUfWdNzLkVd4YrtNRnVxz0
 lILdEOOic10+7+PQXKSswitVSVJjx3GjL3WkUoY3EHhrKvjLpmQX4hHssEXDjZVefc1irC7OlFY
 t3SQVUrD1GAAxoBcfqvtnNtUuxy8MVZyYiWozpzUiOWUAaE+coj/DsZJ2OWgxBnw05Xerlu9Mi6
 PDj7wJ48rzr5qBEDaQepcuIpCJl/NxJwY9HrLd/faSMPlJHSQGW7cKaLJxq0JFjXaLWxvvjpzQ1
 l7XH9AK1RqHe2uI8Z0Eq4+R2Atvc9XKRwSdgl4EwMP8NvaEVtaML777kukWddKU61A403nMj4QB
 pdQeffut+4j9rS2rXfn+RfVHBYyufL0FZQtX0clrv/fdgjOZxJsTvDwI6uLOkD1YrzfHBXW/fcw
 M0hPYKNJ5gL+H4/SmcxslPcRg=
X-Received: by 2002:a17:907:3e91:b0:b93:5521:b57a with SMTP id
 a640c23a62f3a-b93764b5f90mr1040808266b.31.1772536307518; 
 Tue, 03 Mar 2026 03:11:47 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab13d57sm579824766b.12.2026.03.03.03.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 03:11:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1CD1F5F7C1;
 Tue, 03 Mar 2026 11:11:46 +0000 (GMT)
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
Subject: Re: [PATCH v21 00/18] Support virtio-gpu DRM native context and
 MAP_FIXED API
In-Reply-To: <20260302145920.735423-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 2 Mar 2026 17:59:02 +0300")
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 11:11:46 +0000
Message-ID: <87y0k9b219.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

> Hello,
>
> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
> virtio-gpu patches that has been reviewed previously and were waiting for
> a new release of libvirglrenderer 1.3.0.
>
> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-dmitry.os=
ipenko@collabora.com/
> [2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-dmitry.osi=
penko@collabora.com/
>
> Changelog:
>
> v21:- Moved virtio-gpu to use iohandler_get_aio_context() as was
>       suggested by Akihiko Odaki.

Akihiko,

Are you happy with the aio changes?

I've provisionally pulled this into to virtio-gpu/next for a 11.0 PR
this week but I see there are a few patches left to be reviewed.

I shall see if I can test it.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

