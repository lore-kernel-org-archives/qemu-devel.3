Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B872D31762
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MD2-0006Yz-N3; Tue, 05 Nov 2024 11:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8MCw-0006PW-Sa
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:15:08 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8MCu-0000oY-QV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:15:06 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso7086722a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730823303; x=1731428103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/F6khqFVm3o2NzLzzy4Lwer2MDCHx9zC71RAhU07XQ=;
 b=dFIym84l8J+ksfKFfiBMECjpkg15jFFPx7iRG4xrEp15h0ZqPE0UYWu8f/O18W/vK7
 0W9blUkATUd+vPPcKRZfk83TP9C1KJGVvcdWW1nIs8XpNXZahD9CCxpCk3i3Ixzs43oa
 rMeO7+VswqT/MBU4Sr2xzDD0E6sZ3XsFp+eJuAX2rkJrvv4IfEWZemCC3foQRElpITf4
 NtGsVVkLl+/MQ9cJPtS/1I8RJGp2lGWjFEJdJI7uatdFYMVEdPkZ9sYCUlSFZoti0Qd5
 xmY3FHBtQJ9NnzXGV6/jsv29dLBMvQBcAtJLayCHHjGqnSd4TzLaZw4ecdz/5+BMEfAQ
 Y+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730823303; x=1731428103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/F6khqFVm3o2NzLzzy4Lwer2MDCHx9zC71RAhU07XQ=;
 b=mgsoLzOOCHqBtlu6OFTeiYKF5NgSfUkZShBBdAPMxKtMzYC6Lv/jHvgwK6jGGHByhx
 ajkI8JocxAKEXwu3G8XkNL0YIXQw3cBeksrpVwIVCWHCy1SHPwQhcPSYSPANvSoVDvw5
 hmdBPpAoRyPtvl8tFsY49uM0pYzloR25TcdeAhlUW8lFc8socMXBbKiKiylQfO3witrD
 jV3jlALw75dCDzMlWY/7fcE8yYRZXaPHhPtAslYhaHU37/8Q3/WJ0PrTH9EqEc9kmmWe
 0uAhIMibkQ2w90929ojG+Z/IUrSaURApGgvL5BHb7V8zBgsZT/+Bhe96EzEdlovAeONX
 JiDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfA0Tzvwb1RU5Td/6m5dC1rjet0njDJDtTQRVbKX95nvMxbnEKAL5yhHJ/KSupNQvf4qD6G28K4iWg@nongnu.org
X-Gm-Message-State: AOJu0YwbmXV5xx7sXglbQIkC+3T1ZV6xscggAzIvX7JymlsVvbSaQ9rB
 +qrUMLpm5UeXAx96bLr9qqVHtqYF7DFVmJeX414TepP/zYM0dTf1KVaURgr3LoLrRCzBzxp6//a
 EAqLEE1v1uWu9riJYcfTAUYy1Z8/t9si7bdYZ2g==
X-Google-Smtp-Source: AGHT+IGU3lR2jeWr77cyb9AKZk47WvyE9QmUXwsJ4US0bjO0+VD71GVzHzn5czFp46TiypccMc66z/0MEZVgrZqJZ4M=
X-Received: by 2002:a05:6402:234a:b0:5c9:625c:f82a with SMTP id
 4fb4d7f45d1cf-5cbbf8765c6mr28077757a12.1.1730823301094; Tue, 05 Nov 2024
 08:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
In-Reply-To: <20241024063507.1585765-11-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 16:14:49 +0000
Message-ID: <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 24 Oct 2024 at 07:39, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> This is a simple conversion of the tests with some cleanups and
> adjustments to match the new test framework. Replace the zephyr image
> MD5 hashes with SHA256 hashes while at it.

(ccing Stefan Berger for possible insight into swtpm)

Hi; I find that this swtpm-using test fails for me on my
local system due to an apparmor/swtpm problem...

> +    @skipUnless(*has_cmd('swtpm'))
> +    def test_arm_ast2600_evb_buildroot_tpm(self):
> +        self.set_machine('ast2600-evb')
> +
> +        image_path =3D self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
> +
> +        socket_dir =3D tempfile.TemporaryDirectory(prefix=3D"qemu_")
> +        socket =3D os.path.join(socket_dir.name, 'swtpm-socket')
> +
> +        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> +                        '--tpmstate', f'dir=3D{self.vm.temp_dir}',
> +                        '--ctrl', f'type=3Dunixio,path=3D{socket}'])
> +
> +        self.vm.add_args('-chardev', f'socket,id=3Dchrtpm,path=3D{socket=
}')
> +        self.vm.add_args('-tpmdev', 'emulator,id=3Dtpm0,chardev=3Dchrtpm=
')
> +        self.vm.add_args('-device',
> +                         'tpm-tis-i2c,tpmdev=3Dtpm0,bus=3Daspeed.i2c.bus=
.12,address=3D0x2e')
> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'As=
peed AST2600 EVB')
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_dev=
ice',
> +            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
> +            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431=
688E0');
> +
> +        self.do_test_arm_aspeed_buildroot_poweroff()

The test fails like this:

qemu-system-arm: tpm-emulator: TPM result for CMD_INIT: 0x9 operation faile=
d

Adding extra logging to swtpm (--log file=3D/tmp/swtpm.log,level=3D20)
reveals:

SWTPM_NVRAM_Lock_Lockfile: Could not open lockfile: Permission denied
Error: Could not initialize libtpms.
Error: Could not initialize the TPM

Checking the system logs, this is because apparmor has denied it:

Nov  5 16:01:14 e104462 kernel: [946406.489088] audit: type=3D1400
audit(1730822474.384:446): apparmor=3D"DENIED" operation=3D"mknod"
profile=3D"swtpm"
name=3D"/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/tests/functional/a=
rm/test_arm_aspeed.AST2x00Machine.test_arm_ast2600_evb_buildroot_tpm/qemu-m=
achine-hhuvwytc/.lock"
pid=3D2820156 comm=3D"swtpm" requested_mask=3D"c" denied_mask=3D"c" fsuid=
=3D1000
ouid=3D1000



Q1: why is apparmor forbidding swtpm from doing something that
it needs to do to work?

Q2: is there a way to run swtpm such that it is not
confined by apparmor, for purposes of running it in a test case?

Q3: if not, is there a way to at least detect that swtpm is
broken on this system so we can skip the test case?

(I note that there is a thing in the apparmor config
"owner @{HOME}/** rwk" which I think means you only run into
this if you happen to be building/testing QEMU somewhere other
than your own home directory -- but that's hardly an
unreasonable configuration...)

thanks
-- PMM

