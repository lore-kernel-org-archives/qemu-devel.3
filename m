Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486D3CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 19:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP3ko-0005oN-Lt; Mon, 18 May 2026 15:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3kL-0005jo-47
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:35:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3kI-0001X6-Nh
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:35:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so15743545e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779132920; x=1779737720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhePajZcGpCeLD99/y/srf2qfOYcQkuGDsSu0Gk7e1s=;
 b=xqU41RlBOPiUbjmKdpGdwf08AnHFvdMMu1FNDEtjBazK9UPnG/o1LWQUDb4cpyidth
 UE2MpXqHrzfx0y9cJ+SmkU2wi//1rKAourydCchdeeswLWIkLg8QWoOYDx5wa6GG3klE
 o7KGHZ79GAkqK8tzpVin+XuH3bKyz46Yd+dbmUl1n07UPavtZOCjWPV9L1C4ixj6F5Pz
 KipiHBWKmsWEN/VVk7MJyK2WHAgG236mMg0pjh3y0kGMadTj8qbZK9lQJYvT93RXYYL6
 3PX+AhvIMCI/VRyH/DAC8GNfrxl8f7XRQjDG1kja0x2vml0PNME/VxkUiPJITFEztFT/
 Kapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779132920; x=1779737720;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhePajZcGpCeLD99/y/srf2qfOYcQkuGDsSu0Gk7e1s=;
 b=RQP57NUAWLqS3i2yD5QWXF6e6OGmMDDMTHe69przP0ZxUni+LQxM0c+VXTZX6gZ+wJ
 soxDN5pTvOwnEzT3O1pIZ0+gRuUANzaqQcU7RqVunoMo8ySNb/JD97Bkzi9WCzjSJiP5
 MMTyoAw7Ic7rLD+yurebVnp6ZRvsfi1c0sm+BUGjcVvyBfzK0fZXU3BBmsvePfV4jwiG
 VcIf0bAGrajLZfhwJ5oUyGbNhinzwK76KLwY7uQfnJWG7ANnThwxQt7YsI39PGff7mjH
 3iE1oUQClOc8K89GZXiVihtFNzTQO+lOyc8myPvIGeYYWvoaPgGRPj3Wj3Nvt2dwfQdH
 eYMA==
X-Gm-Message-State: AOJu0Yx6rfSJiDUhhwmxSGthIizuVWd6BDXirDpkMoke+Pb6lXG+a2zs
 fLRoWLvp/BZXkFxDGPEy2p9ER7ChtuNa6A3ggte8EyjfRFMYTQqs0cfdpUkCw+lXSaY=
X-Gm-Gg: Acq92OGV8vaGjeTPpABjtlZgIMwcjbw58R8JjGOr4LkGWKLWT5FJsae7q2FdlXEahu2
 GU9IoDQ2w+e/Js4s/6fkZKXxt2a0r7UrvNo9mMMVfD4ef+631C5OZh4/yfYpcskshRmHtY7z/6s
 hdaglrptlSnVSxVgSesNy764NE+sbpUokyYSeylevPjz4xYtOUz+o6vG466mHiekZJKy8jxDszi
 T8qhvLVwbJc60LNSqVWKciuQsxV241GRsqmJzqwQOU78BR7L7SHwg0pevQFiGKMk3ASLhss7R/B
 Y1i5002vdFmkBDkUvWUcAu101/ZQC/33ezje5uX7qxUawPQeo2y0MAO4gOWnXPzhyAdVHSkKpYK
 gUI/FTZmcQgg90mMMrfvdVLuyHYsyW3mJAGkAjl2q5Wo6rUMyAN1AnLkO7YIPvaC5UacfUODM1y
 4V7bvqvHEL6NZ0SAIgyBrgoj0=
X-Received: by 2002:a05:600c:a406:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48fe651487emr202459505e9.23.1779132920392; 
 Mon, 18 May 2026 12:35:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe7dd22sm118359945e9.7.2026.05.18.12.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:35:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8559A5F7B1;
 Mon, 18 May 2026 20:35:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-gpu: Do not wait for the main thread
 during reset
In-Reply-To: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Fri, 24 Apr 2026 23:06:40 +0900")
References: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 18 May 2026 20:35:18 +0100
Message-ID: <87mrxwcxzd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> This fixes a deadlock I previously observed with the test in [1].
>
> However, I can no longer reproduce the issue reliably with that test, so
> I used Codex, a coding agent, to write a more reliable local test case,
> shown below. I applied to Codex for Open Source to get access. The test
> case is not intended for merge: current policy prohibits that, and it is
> probably not worth carrying anyway because race-condition tests are
> inherently fragile.

What sort of hit rate where you getting with the race? So far they have
both been rock solid without the additional patches for me.


> The remaining patches were written by me.
>
> [1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.benn=
ee@linaro.org/
>
> To: qemu-devel@nongnu.org
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Below is the Codex-written test case:
>
> diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/functional=
/aarch64/test_gpu_blob.py
> index a913d3b29c84..52627b4541f9 100755
> --- a/tests/functional/aarch64/test_gpu_blob.py
> +++ b/tests/functional/aarch64/test_gpu_blob.py
> @@ -13,7 +13,9 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>=20=20
> -from qemu.machine.machine import VMLaunchFailure
> +import subprocess
> +
> +from qemu.machine.machine import AbnormalShutdown, VMLaunchFailure
>=20=20
>  from qemu_test import Asset
>  from qemu_test import wait_for_console_pattern
> @@ -25,8 +27,7 @@ class Aarch64VirtBlobTest(LinuxKernelTest):
>                         'download?path=3D%2Fblob-test&files=3Dqemu-880.bi=
n',
>                         '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e=
2d569ea2e34e42eb')
>=20=20
> -    def test_virtio_gpu_blob(self):
> -
> +    def launch_blob_test(self):
>          self.set_machine('virt')
>          self.require_accelerator("tcg")
>=20=20
> @@ -65,9 +66,27 @@ def test_virtio_gpu_blob(self):
>                  self.log.info("unhandled launch failure: %s", excp.outpu=
t)
>                  raise excp
>=20=20
> +    def test_virtio_gpu_blob(self):
> +        self.launch_blob_test()
> +
>          self.wait_for_console_pattern('[INFO] virtio-gpu test finished')
>          # the test should cleanly exit
>=20=20
> +    def test_virtio_gpu_blob_shutdown_race(self):
> +        self.launch_blob_test()
> +
> +        self.wait_for_console_pattern('[INFO] unmapping blob object reso=
urce')
> +
> +        try:
> +            self.vm.shutdown(timeout=3D10)
> +        except AbnormalShutdown as excp:
> +            if isinstance(excp.__cause__, subprocess.TimeoutExpired):
> +                raise AssertionError(
> +                    "QEMU failed to exit while virtio-gpu reset was raci=
ng "
> +                    "with shutdown") from excp
> +            self.log.info("QEMU exited before the shutdown request compl=
eted: %s",
> +                          excp)
> +
>=20=20
>  if __name__ =3D=3D '__main__':
>      LinuxKernelTest.main()
>
> ---
> Changes in v2:
> - Added the patch "virtio-gpu: Run reset cleanup in the same BH".
> - My assumption about the ordering was incorrect, so I changed the patch
>   to follow the approach used by virtio-gpu-gl.
> - Link to v1: https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-e3e3c7=
eebc9e@rsg.ci.i.u-tokyo.ac.jp
>
> ---
> Akihiko Odaki (2):
>       virtio-gpu: Run reset cleanup in the same BH
>       virtio-gpu: Do not wait for the main thread during reset
>
>  include/hw/virtio/virtio-gpu.h |  4 +--
>  hw/display/virtio-gpu.c        | 60 ++++++++++++++++++++----------------=
------
>  2 files changed, 30 insertions(+), 34 deletions(-)
> ---
> base-commit: 14f38a63b9adc02c0ebe3b5ada1f1208abaf21ea
> change-id: 20251029-gpu-c3f45747f7ba
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

