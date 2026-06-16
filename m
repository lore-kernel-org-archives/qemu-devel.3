Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FB8CD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZIHA-000532-9T; Mon, 15 Jun 2026 21:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZIH8-0004yA-4h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:07:34 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZIH6-00036g-Fs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:07:33 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so7325722a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781572051; cv=none;
 d=google.com; s=arc-20240605;
 b=IDd4e8F1M3f7OUxrSl+8SkAigB+BuS0oxUJjIVXaLJ5LgUoLxg6DJf0OSgFUYHzH4m
 XukjQtW2AYiTTImC7Cb7wJy936eT9Z3QvfT61nnp+cD5Xw3A4mCPCeUf9hO3cyYuF2XD
 Oqohml7my51ZVgUQUTdazO21qenGJQW66vSef+i8rXtf6OQ/RReFTPlAwjcCG/KVkRZ8
 KO069hCG6HFIO2I3HOrj+a2iV/bV2zRwREDUsFgrRnGwJZROqN7ZoFsu8mR8QPsINQO2
 pBJPFuUSi4jmIDdNDJQ7U8bU/UpNADKuBPXbyw5Nozeo4tyk4lvC0QQBvD+55j/zCDBs
 k/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TBPhuN9NEq+v7SgYwgjQrUGIjGvKiiB7ShYgVjcCrtE=;
 fh=QMl3m49tuLtOusuuXCnCOZCsoZiLfsjUwXG2nLBmcSY=;
 b=drK5QPKMfJbIvjvY/OUXGCcyf5/0oz4jUDrugjIKjxXF0izUbhWaTCuzuUl/1pcS6x
 DlkJyV5zzoOdjNrelqw9y5dXBgS7xm1HoSk5zaJ43KScJ+qzrCPqTchu/O5Ac0n5fgU/
 tDB6LwpJaGEc4FEIE0ExNCNveGDguKwm8kY17nNIFI//DNLvYKA7lAIQXhN3HDmzbNV+
 syS9jovzH3clXN6RJcl7wMDLt2kCr4rSaFB2HqnQQQ/zg103ilQBLBe4uqor/nuei8x1
 qJN6jMgjHCJDWFy7HbUl73jZ9zgyd3cU6FLb3y0K5ZgFnTTP5kOEQjn54MkwotbrJGCX
 lHaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781572051; x=1782176851; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBPhuN9NEq+v7SgYwgjQrUGIjGvKiiB7ShYgVjcCrtE=;
 b=ZslVwC83a86NrIXz16TYHHypON2l3AjEr+AK6kyFV3Tbjqk7Dr3WvZB51VT2Ng1jwe
 WMJ0hrwD6YmHL9wBfKphU0qxfJVlCotFy1VGOObRsHCgng/PoJ0hNmQnZXhFJghHDJQw
 cOmM+6UNx3wHXUeJ2ScpdW8Ii0HaC9zdQ+cWUMo7QnY3HrwPV5/vVhymJ4VHw7cVHmPx
 UfLPoG6XgRHA4rNj30+m+iWKVQtzb4x6BRpsAf0C4HPKFH9IE8gtMC1qTLY2l09L22ya
 dkkG4B6acIn4r2LQPiarrfxAdGAKY0+DIQUTZTt0VBVwr2WRF7scqbTiJmFMqFMVp49e
 cxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781572051; x=1782176851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBPhuN9NEq+v7SgYwgjQrUGIjGvKiiB7ShYgVjcCrtE=;
 b=SmrKyUHMiZhywjEOqWe7agkq+x3ZZiNAVqj83Kopc19MibqtwhYE1MmEgP9cGgNybb
 6Zl8pMpEpzziAOl+7MT8L2eEVoUHuOhrxFJWLw26baJ/j61u6vnRPyAcspv54YaeIsNa
 tLN/oYhuUR7k6YAufnWFt/z9/7xxaLWITAosbDbuUyBy+UOqcn0Rlk6Jf6pVsWbBXMP9
 R0LI1U83PHXH2l6O6kcbmknch44ZJUvdJAPphkETJzjjhLRaz5YnWBtqVFnFjHqTOQdb
 kIIFRZgeOEw9ZhB9jdTPz8u6RiCw6+WAGL+fYaZef8e+VyCqgHgiv5twFyEkSW6e8E5T
 0r1w==
X-Gm-Message-State: AOJu0YzCMWt6uDDw43jwXVtKvNJQ0vxt3N1CmFjOxiETCfPXTRCJPhr9
 lsTilAaWTwxHqHpKrW8V40eEHmy19BaG/nKFf6jLZ+qhrBPAXII239A8Pwc8eJBpoDHR31dvkx8
 fezFxqNYowOB3ImtB5ZSQnpgxgIpR7T8=
X-Gm-Gg: Acq92OFrlBjq4slThtb7XU93pK0W+QwNHhLW+m5DEWP+7gZGKeKZtbozUAtLmt3dXYG
 t7DnUIu8eILnhjqPr407ko22JHjhazYRlBKlcM5njjtR2MsvRzskfoZZKmO2DWGoxKwvZpmeqHr
 uGiBwOKxGkEfZ+YnSKJAgapwD882dpoZpIrA6ahbsvFV2iOqK/XV70xVDZlbOm02986BrnbaA0R
 Jtu0R7H+hk2P2OiJceA/wKZGyfyJigsUEcRdHeIALj5rT24gMURfQthkSPQcT9iE3oKwfj+Y/rc
 3UhrRHVYgQpUfCYu2aL/k1kzGRVaJ2F0Yq4Hpw==
X-Received: by 2002:a05:6402:4014:b0:692:4759:ac57 with SMTP id
 4fb4d7f45d1cf-693c6a10b82mr5104898a12.2.1781572051025; Mon, 15 Jun 2026
 18:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 11:07:04 +1000
X-Gm-Features: AVVi8CfpvrPAedNGaTwfl_W9jmYjznTpopZIdlpqcBwt1N7BxoDTQG480rk-5cE
Message-ID: <CAKmqyKPh0XGqrENq-G9aFFE18iwmMW3GeOK2JPuNs3zCXfNOmQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] tests/functional/riscv64: add riscv-server-ref TPM
 selftest
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 11, 2026 at 7:44=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add a TPM specific selftest for the riscv-server-ref board.  The test
> will be skipped if there's no 'swtpm' in the host.
>
> The test has been basically cloned from our Aspeed ast2600 friends.
> Shoutout to monsieur C=C3=A9dric Le Goater for the code.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/functional/riscv64/test_server_ref.py | 31 ++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/function=
al/riscv64/test_server_ref.py
> index 2ecfcf60ad..9b120628dc 100755
> --- a/tests/functional/riscv64/test_server_ref.py
> +++ b/tests/functional/riscv64/test_server_ref.py
> @@ -8,8 +8,13 @@
>  riscv-server-ref board test
>  """
>
> +import os
> +import tempfile
> +import subprocess
> +
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import wait_for_console_pattern
> +from qemu_test import skipIfMissingCommands
>
>  class RiscvServerRefTest(QemuSystemTest):
>      """
> @@ -26,7 +31,7 @@ class RiscvServerRefTest(QemuSystemTest):
>           'master/riscv/images/virt64/buildroot/rootfs.ext2'),
>          'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a=
8')
>
> -    def test_boot_linux_test(self):
> +    def _test_boot_linux_test(self, tpmstate_dir=3DNone):
>          self.set_machine('riscv-server-ref')
>          kernel_path =3D self.ASSET_KERNEL.fetch()
>          rootfs_path =3D self.ASSET_ROOTFS.fetch()
> @@ -38,6 +43,22 @@ def test_boot_linux_test(self):
>          self.vm.add_args('-device', 'ahci,id=3Dahci')
>          self.vm.add_args('-device', 'ide-hd,drive=3Dhd0,bus=3Dahci.0')
>
> +        if tpmstate_dir is not None:
> +            # Note: code taken verbatim from
> +            # tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
> +
> +            # We must put the TPM state dir in /tmp/, not the build dir,
> +            # because some distros use AppArmor to lock down swtpm and
> +            # restrict the set of locations it can access files in.
> +            socket =3D os.path.join(tpmstate_dir, 'swtpm-socket')
> +            subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> +                            '--tpmstate', f'dir=3D{tpmstate_dir}',
> +                            '--ctrl', f'type=3Dunixio,path=3D{socket}'],
> +                           check=3DTrue)
> +            self.vm.add_args('-chardev', f'socket,id=3Dchrtpm,path=3D{so=
cket}')
> +            self.vm.add_args('-tpmdev', 'emulator,id=3Dtpm0,chardev=3Dch=
rtpm')
> +            self.vm.add_args('-device', 'tpm-tis-device,tpmdev=3Dtpm0')
> +
>          self.vm.set_console()
>          self.vm.launch()
>
> @@ -55,5 +76,13 @@ def test_boot_linux_test(self):
>          # Wait for boot to complete - system reaches login prompt
>          wait_for_console_pattern(self, 'Run /sbin/init as init process')
>
> +    def test_boot_linux_test(self):
> +        self._test_boot_linux_test()
> +
> +    @skipIfMissingCommands('swtpm')
> +    def test_boot_linux_test_tpm(self):
> +        with tempfile.TemporaryDirectory(prefix=3D"qemu_") as tpmstate_d=
ir:
> +            self._test_boot_linux_test(tpmstate_dir)
> +
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()
> --
> 2.43.0
>
>

