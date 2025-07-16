Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F195DC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 05:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubv3S-0007u1-EV; Wed, 16 Jul 2025 01:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubuy7-0002EO-0X
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:46:17 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubuy4-0001cY-K4
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:46:14 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-611f74c1837so8893182a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752644770; x=1753249570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLewxkWgNZ+c/eFkdWePc1JtOWsf1qVmnafs+m2hbjk=;
 b=cRW9fdPqOWyl4ipCUzke2H4oFUYPhdQ76OgI2Gz0VGC/3JNtYTP7BQ6JT6mJ4M4RVB
 G7TL/1DAqM1L3HPRbQmt5ojP4v7BNsZtzY67f49ESHRLP9dDC6XJQHNdpZ8ZVEmV2FEt
 dZanzv8LQI9fXYPydZ/XP+TtZCFnvyteX9jmo03ZYzgBs9ABoZT7SI//LSiaH+I7wOz5
 zGB9vyL1ro1po5p9jKve7CiuMlSiqekZSoEp44I/kurNHSavlhjOggpTo5eoKU/ee8Hs
 LyoT5N+ct5wle0MchYxfJsODpsMShWqvsGAATh/R+6ME3goIf7lO/3vHiBryms0HrPPj
 sK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752644770; x=1753249570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLewxkWgNZ+c/eFkdWePc1JtOWsf1qVmnafs+m2hbjk=;
 b=Y6hPfcRFvawqVt9lhPX4tyzkhNnDufZbtL1Jekjk0vUHcXZg0LXGxjKqTQTFVpeZQ6
 wcbg1O1qhLns1bc3hZj8a2rCsgO/UnL6XKbegyilj4QUnxNTq92C/hDqzrS0RAuLcdl+
 sALqOS64uR4Y/E/YnBaequoinzIaJswmWzI7C9YsU/KgpefPZGeqG7p6dHeZKvxm4xep
 9yFQg3Xx1Wz74gVjFiG0jaS0OyPQAu7xYV4eKgGgTUMA8Yr49fvPLHSJGxi3ygzkUJcv
 QQ7wtbPrkxn9VcnEGmftYDqoO28dKGRx8e3GPoyCLn7M4CLeS/G5AKuwytPUYCJMgibA
 gwCQ==
X-Gm-Message-State: AOJu0YyQdazvutDdSMmZwVexyX5RPFBYs+hYqFiOGway5CvmedEjSHJl
 69xj+NWW6H8mDrLSQbflWI75P1+/Il7S12wbJGwQxSfkcUSiz7B0AbVMFoCa16/j34RBmtY8oKt
 IuaOOcB243eT2mqi8at7ECLe/XfU8ShrwPPSimfQyFQ==
X-Gm-Gg: ASbGncsY4mGxM4Z1bZnr5Za3eh2GUv55mlZ59V7/aq4lAq3XBhs+yyWR5YeYrbKadI9
 6Zm9JLMusxVE7pzfcLi50PF0acPHg3mo/HY8CmnHt9e1bJpK5uOjkLSPUuOuulAohPLeGy5RERo
 2PjwAlpkvQp32FC5ZrDlh6IJkDnLntF3+Oej6MIIFwWzndnkHy8zu6UoE66muwtBXMvz1TN3u3t
 At+0A==
X-Google-Smtp-Source: AGHT+IFkwOurNtpCU7cYXMvcEo/EDLBpeiO9i6U3sbakOiQBWie3k+LVG5RHLGt7bVdMGb7jvtIEYisd4GUv8iM+v5g=
X-Received: by 2002:a17:906:d246:b0:ae2:4630:7de4 with SMTP id
 a640c23a62f3a-ae9c9af2636mr168892466b.34.1752644770287; Tue, 15 Jul 2025
 22:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
 <20250715212335.2215509-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20250715212335.2215509-3-pierrick.bouvier@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 16 Jul 2025 08:45:44 +0300
X-Gm-Features: Ac12FXzYt2pP0VXDey-qJk-TUSzOtKHjfZt4avYSUlqTui_pdFqLgjltZ9YRGJ8
Message-ID: <CAAjaMXYVVL-_wC2yqcYveb4dgCvcYr02GrTP21EmMAzohQ7=XA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/functional/test_aarch64_rme: update image
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org, 
 Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, Jul 16, 2025 at 12:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> TF-A needs to be patched to enable support for FEAT_TCR2 and
> FEAT_SCTLR2. This new image contains updated firmware.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/functional/test_aarch64_rme_sbsaref.py | 9 +++++----
>  tests/functional/test_aarch64_rme_virt.py    | 9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functio=
nal/test_aarch64_rme_sbsaref.py
> index 746770e776d..70737d3d599 100755
> --- a/tests/functional/test_aarch64_rme_sbsaref.py
> +++ b/tests/functional/test_aarch64_rme_sbsaref.py
> @@ -21,10 +21,11 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
>      # Stack is built with OP-TEE build environment from those instructio=
ns:
>      # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
>      # https://github.com/pbo-linaro/qemu-rme-stack
> +    # ./container.sh ./build_sbsa.sh && ./archive_artifacts.sh sbsa sbsa=
.tar.xz
>      ASSET_RME_STACK_SBSA =3D Asset(
> -        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
> -         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
> -         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c10499=
9e')
> +        ('https://fileserver.linaro.org/s/gW3mmtC4ZQaxNJ2/'
> +         'download/sbsa_cca_v10.tar.xz'),
> +         'b6ec3435a459eb298f221beb5073e485f290d38055d0aafbcff7d8e7c334aa=
73')
>
>      # This tests the FEAT_RME cpu implementation, by booting a VM suppor=
ting it,
>      # and launching a nested VM using it.
> @@ -38,7 +39,7 @@ def test_aarch64_rme_sbsaref(self):
>          stack_path_tar_gz =3D self.ASSET_RME_STACK_SBSA.fetch()
>          self.archive_extract(stack_path_tar_gz, format=3D"tar")
>
> -        rme_stack =3D self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-s=
bsa')
> +        rme_stack =3D self.scratch_file('.')
>          pflash0 =3D os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
>          pflash1 =3D os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
>          virtual =3D os.path.join(rme_stack, 'images', 'disks', 'virtual'=
)
> diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional=
/test_aarch64_rme_virt.py
> index 8452d27928f..fcc321b6006 100755
> --- a/tests/functional/test_aarch64_rme_virt.py
> +++ b/tests/functional/test_aarch64_rme_virt.py
> @@ -49,10 +49,11 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
>      # Stack is built with OP-TEE build environment from those instructio=
ns:
>      # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
>      # https://github.com/pbo-linaro/qemu-rme-stack
> +    # ./container.sh ./build_virt.sh && ./archive_artifacts.sh virt virt=
.tar.xz
>      ASSET_RME_STACK_VIRT =3D Asset(
> -        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
> -         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
> -         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7=
ad')
> +        ('https://fileserver.linaro.org/s/YpLmzLNL6BAxYL8/'
> +         'download/virt_cca_v10.tar.xz'),
> +         'bc432c92d62f3cd3542a943cd5a6329b2464c986f8f5dc48f727a0e5386a0e=
95')
>
>      # This tests the FEAT_RME cpu implementation, by booting a VM suppor=
ting it,
>      # and launching a nested VM using it.
> @@ -66,7 +67,7 @@ def test_aarch64_rme_virt(self):
>          stack_path_tar_gz =3D self.ASSET_RME_STACK_VIRT.fetch()
>          self.archive_extract(stack_path_tar_gz, format=3D"tar")
>
> -        rme_stack =3D self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-q=
emu_v8')
> +        rme_stack =3D self.scratch_file('.')
>          kernel =3D os.path.join(rme_stack, 'out', 'bin', 'Image')
>          bios =3D os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
>          drive =3D os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ex=
t4')
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

