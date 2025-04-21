Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6679AC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 15:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6sp5-0002vg-TR; Mon, 21 Apr 2025 11:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u6sp4-0002vF-0Q
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:12:38 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u6sp1-000292-Sg
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:12:37 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-47666573242so1371791cf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745248354; x=1745853154; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YN5HqmBZi839J5JH4cbHdkLsmc/cLs6rgwsN33UkJk=;
 b=JfsjGi25lYaMc1ZtmtPqW3WWYvNdBiqCLNowl3e8XFEWdbaiW0HEIm+ZHint0vht3C
 waY3PKYosTGq68qZPnK9jKHtwJrtWA5c5DQ++eOMPUpvFek/YpZ1Z67ECgWp5NBAid4Z
 EFea7SzLczSoGQFhY2Bx5L+7DnNM2zxOEPORhL4XfoMilTGIeaP2Kyrd7setU6fbJzGs
 G2A30qNbS/n4hNbIdvlQzGHxFXSJ0rRD+jsVdOC+Wyh+i7Yh0aBB3qnNRKQZs1kh6KuY
 fTbsVF5/mqbBGNwAHi8J6U5GEw9l4Cf4yKf+9vhRkucBAof8XsunhXl4nVDT0MvYt408
 g/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745248354; x=1745853154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YN5HqmBZi839J5JH4cbHdkLsmc/cLs6rgwsN33UkJk=;
 b=lMJI+angKCq1esluRncSxh0rktshooK9FghOK5SKzMRj4/xB7YHpyZqdMgT2or+xCe
 F+AxhehcatPwF3zxotJS/CVJJ5RWfyo3Od9LAXwFCReXXtk6OA0oUg9GdppEVA+iWVL4
 iYPKqr8flXsQuSPNP6nzN7AdUaMzf11QDuur09U+wWKCb354uo6ggxdyfNz9n2LZ81G8
 rckAuV8dX7uwXIatytAcDmWDLNX3ia1vjE2cPLdIu2+R2vdKyhu8O39nuT/J8g4seMTw
 HHPm8l7fSxrlEefLnFFgs3auuiz3GKo0pP2WFOoSE4ral/xwDqslcfucNS1BFuHUaQUC
 5mLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHjIPfZSHoJ61zbmamZYcF9iEZrrdm6YMYPkBNQ8oaLzwQoxKJ9QV/ubRhBe3SyiwIrwAgOfoXDypy@nongnu.org
X-Gm-Message-State: AOJu0YwEEyZD7P5fbDAuPamFMHFFJAI0I7BCvwPu6jqFKB2HxE/4amNM
 6pXi3PvmcnzCSJ+qZDSS2trDKVtbOYsqPHV+CrzzZhjJz1TDAJkC9tJhqs6lKuebd7DSeqeuy18
 eQDBmgwwdI6M9SSIP+v6FD0Ws7TZvdUjOH4P5
X-Gm-Gg: ASbGncvg4MZoECpXbcmgiBmQ8PIV+oKWX1C54R3n2H0o/b7+piVSqz74+wWfaylfTlO
 7tiOwT4uGIGhLLeVFe/MEkfpI9OcUmqWg8eJZE6IXcB4bj0I2JOC6MdGrRTqjnGfUsIM+VySlIp
 U6sXb0MyPAV3IgNgBK8dg0OlzcZJrVF5GCL940DCy3lrsnDKSMUjuS
X-Google-Smtp-Source: AGHT+IH2UfWOocDYLpBXAtiNPmWNj0XCnlZLImWEqule1H/hsAb+nXTTn97mrjl732yuMUoaqyGRyeLDaw46MeZRw2o=
X-Received: by 2002:ac8:5e13:0:b0:477:1f57:5493 with SMTP id
 d75a77b69052e-47aeb26fa62mr11514771cf.20.1745248353772; Mon, 21 Apr 2025
 08:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-8-jamin_lin@aspeedtech.com>
In-Reply-To: <20250417031209.2647703-8-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 21 Apr 2025 08:12:22 -0700
X-Gm-Features: ATxdqUE38HtO0ZJ680opJUNXzC-WpYrFrPjkQarJYLManNnrnRJioIdHtJWFkzU
Message-ID: <CA+QoejU-EJiyP_nXMpP=n8=5z36fAZRDapb9kB4zt_kaCi8_-A@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] tests/functional/aspeed: Move I2C test into
 shared helper for AST2700 reuse
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 16, 2025 at 8:12=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Move the I2C test case into a common helper function (do_ast2700_i2c_test=
) so it
> can be reused across multiple AST2700-based test cases. This reduces dupl=
ication
> and improves maintainability.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  tests/functional/test_aarch64_aspeed.py | 28 +++++++++++++------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/t=
est_aarch64_aspeed.py
> index c25c966278..441f7f3919 100755
> --- a/tests/functional/test_aarch64_aspeed.py
> +++ b/tests/functional/test_aarch64_aspeed.py
> @@ -18,6 +18,8 @@ class AST2x00MachineSDK(QemuSystemTest):
>      def do_test_aarch64_aspeed_sdk_start(self, image):
>          self.require_netdev('user')
>          self.vm.set_console()
> +        self.vm.add_args('-device',
> +                         'tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,i=
d=3Dtmp-test')
>          self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',
>                           '-net', 'nic', '-net', 'user', '-snapshot')
>
> @@ -35,6 +37,17 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>              'https://github.com/AspeedTech-BMC/openbmc/releases/download=
/v09.05/ast2700-default-obmc.tar.gz',
>              'c1f4496aec06743c812a6e9a1a18d032f34d62f3ddb6956e924fef62aa2=
046a5')
>
> +    def do_ast2700_i2c_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device=
 ',
> +            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', =
'0')
> +        self.vm.cmd('qom-set', path=3D'/machine/peripheral/tmp-test',
> +                    property=3D'temperature', value=3D18000)
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', =
'18000')
> +
>      def start_ast2700_test(self, name):
>          num_cpu =3D 4
>          uboot_size =3D os.path.getsize(self.scratch_file(name,
> @@ -73,8 +86,6 @@ def start_ast2700_test(self, name):
>                               f'loader,addr=3D0x430000000,cpu-num=3D{i}')
>
>          self.vm.add_args('-smp', str(num_cpu))
> -        self.vm.add_args('-device',
> -                         'tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,i=
d=3Dtmp-test')
>          self.do_test_aarch64_aspeed_sdk_start(
>              self.scratch_file(name, 'image-bmc'))
>
> @@ -83,28 +94,19 @@ def start_ast2700_test(self, name):
>          exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>          exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}=
:~#')
>
> -        exec_command_and_wait_for_pattern(self,
> -            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device=
 ',
> -            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
> -        exec_command_and_wait_for_pattern(self,
> -            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', =
'0')
> -        self.vm.cmd('qom-set', path=3D'/machine/peripheral/tmp-test',
> -                    property=3D'temperature', value=3D18000)
> -        exec_command_and_wait_for_pattern(self,
> -            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', =
'18000')
> -
>      def test_aarch64_ast2700_evb_sdk_v09_05(self):
>          self.set_machine('ast2700-evb')
>
>          self.archive_extract(self.ASSET_SDK_V905_AST2700)
>          self.start_ast2700_test('ast2700-a0-default')
> +        self.do_ast2700_i2c_test()
>
>      def test_aarch64_ast2700a1_evb_sdk_v09_05(self):
>          self.set_machine('ast2700a1-evb')
>
>          self.archive_extract(self.ASSET_SDK_V905_AST2700A1)
>          self.start_ast2700_test('ast2700-default')
> -
> +        self.do_ast2700_i2c_test()
>
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()
> --
> 2.43.0
>

