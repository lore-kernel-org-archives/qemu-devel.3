Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F424C369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 15:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6spP-0002yW-KF; Mon, 21 Apr 2025 11:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u6spN-0002xU-Er
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:12:57 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u6spL-0002A0-Q0
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:12:57 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-47666573242so1372011cf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745248374; x=1745853174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2siGaNZA3m7KEfcP9wuRQIGyyQ5CAfoMOdKSBhg9nQ=;
 b=WDIibDCkNsy69uiqh9z1yLDdrrJTXYrCl+yPWVbrEokPAvSysZ2UdwKCBug0HmOkQZ
 OcEYY1Y5vTfn47VuMztwBMSG/OBsbVqDzqwgygFqQz/4U4/xI1N7LCNCEBquqgeUMFND
 DpHlcLjnDYP4d7MxwQJ0LcNd5w3u/92hoG1eIDepj031u5MJcENeM7vK1ncdxBqVjV1H
 aO/RVpzVuQldu89qvMYNUQ2jfK7a+2ODGA4LE1YmVgnumeNYeEgtzGlzcuf9V7Opw1V/
 NXjSA6MyrCf2llVnwUjrtLuDRoRkRMqGKD/Vb/dsRPQCr9zIgsgAJ8jwKqoUN0yQMH/1
 m4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745248374; x=1745853174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2siGaNZA3m7KEfcP9wuRQIGyyQ5CAfoMOdKSBhg9nQ=;
 b=oVe623rXGGR0idsRlaaWRf9OzC9dQKLnfvKGLSfvqhgIpfX0tk5xsT8B5zj6Vvwc5I
 aI/w6hKVulVyhcIB+elIgILWLTgza/zJKkadmQKAxdRAcH3DvtvO6dZKdM4DaIfIsQ+E
 x+Naw1I8r70z1oTk3QbM8TrcPRzcJmtgyd2Aei9p6SKcQIJPErqd2J3VDkz0RLLxKtQ9
 hzltImdT7pW+zm85rKmOEYr0necy7Gc7crATd4mkr7CIPfNK+xN27TSx2wN1X4r0S7Jp
 xwnZFihTTL35DsDPOz0N7zxVqb3eoJZSC9WRbMP87kdFDkb+CcZqXg9wkfTxLncMqzP9
 1YSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvriw9IaCmNj8fTPQ4nvq0vfKaw95Yz9wazpXMuggFT42ehwb/pG+mWndGJWjr4KX8ydg6u2euclsO@nongnu.org
X-Gm-Message-State: AOJu0YwNFWIo7bND6RAG24WDfcPh6vUxZW7urqn0z2zEijINxI6QSZw/
 gzSjtQZtzzMmjWKOijeGSFFJ8yRdybStzJMHJpy20rnKEegBqeKxOpmn+FEqhP+3ATiK7WNK03V
 x9y6aHsjxa0qK02V8wBrvSjqZfdIbBso9Iecn
X-Gm-Gg: ASbGncumkRgPS+ZtTiADQ6AdYH4PpGTxVU7WWgOGmRkD7u5zDduJCjAz2q35B+YaQfX
 suEsAE5MMovEusvoyX/NEwtbMXkcq07KM2o80WGuU/SfLozvYIAP7aHhKPxVOjGG4NWSSTWmGlq
 f0+owUsv+R+b3JsKxSH+i51znrs/Ju+i/YPp1Jo1Wb4K1DwUObGZa3
X-Google-Smtp-Source: AGHT+IEXd33hriR6eKmaH3gpCW9u+xzsJx08Nd7lq9NY+IGsiRJ2rUacqMA8lfgBhoQtohMQjUaZIxM0xjUNIcSo6FA=
X-Received: by 2002:ac8:5f4d:0:b0:472:538:b795 with SMTP id
 d75a77b69052e-47aeb26e1c6mr11530251cf.22.1745248374225; Mon, 21 Apr 2025
 08:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-10-jamin_lin@aspeedtech.com>
In-Reply-To: <20250417031209.2647703-10-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 21 Apr 2025 08:12:42 -0700
X-Gm-Features: ATxdqUHkMdLliaJZAT7-TYzw0KMtnMb1i3AVJ75U_tZJZxq9XpGa_15xJuZ02es
Message-ID: <CA+QoejUkzbPZ1bELUB-g9L1GLFnX5EyTCrvcAfPkCjgXxpB4TQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tests/functional/aspeed: Add to test vbootrom
 for AST2700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
> Add the AST2700 functional test to boot using the vbootrom image
> instead of manually loading boot components with -device loader.
> The boot ROM binary is now passed via the
> -bios option, using the image located in pc-bios/ast27x0_bootrom.bin.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  tests/functional/test_aarch64_aspeed.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/t=
est_aarch64_aspeed.py
> index 337d701917..85789c1b1d 100755
> --- a/tests/functional/test_aarch64_aspeed.py
> +++ b/tests/functional/test_aarch64_aspeed.py
> @@ -94,6 +94,14 @@ def start_ast2700_test(self, name):
>          exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>          exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}=
:~#')
>
> +    def start_ast2700_test_vbootrom(self, name):
> +        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
> +        self.do_test_aarch64_aspeed_sdk_start(
> +                self.scratch_file(name, 'image-bmc'))
> +        wait_for_console_pattern(self, f'{name} login:')
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}=
:~#')
> +
>      def test_aarch64_ast2700_evb_sdk_v09_06(self):
>          self.set_machine('ast2700-evb')
>
> @@ -108,5 +116,12 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
>          self.start_ast2700_test('ast2700-default')
>          self.do_ast2700_i2c_test()
>
> +    def test_aarch64_ast2700a1_evb_sdk_vboottom_v09_06(self):
> +        self.set_machine('ast2700a1-evb')
> +
> +        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
> +        self.start_ast2700_test_vbootrom('ast2700-default')
> +        self.do_ast2700_i2c_test()
> +
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()
> --
> 2.43.0
>

