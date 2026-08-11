Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342AFC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjpJ-0002wX-G2; Tue, 11 Aug 2026 06:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjpG-0002wE-MG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:35:18 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjpE-0006US-Ph
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:35:18 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81ed000b507so24455517b3.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444515; cv=none;
 d=google.com; s=arc-20260327;
 b=lBv7RVn01SzGsda9K6H0miR68ybbPVOgZm7UnFUqHJeWOgC/UtfDmPBHiwq8WDGcm3
 ZDPdwjyxUpMJ+joFSQ3hkF04b0ZSnBMJUoLurU3588l3oCLMB5kVbad5OqJcrdrU3156
 xn95U8vrZMy3Mh5ZL9GNTtuptU3vl4wCzjQJ9QJiASOCC6spszJMkT5r50yzqp3PBLap
 +gTIDoXfSst1mdWtuKKEkq2kvuJ7kD1Yt5lGcl7je6v2OIlz71kTGxfBw/e2PCVXeYDz
 aX7eXPtz79imHp9Xm9n0SeG0Aj+5KvpiozOUpHhQXiS2JmJ7kGK74486JZy8HMUHiSn7
 So4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wzZ5BnBQlzzhTGmSRFzOLOJJUmRxtFMTrrY4OIrwYHg=;
 fh=uCipvFIj4sN0uwdmOmiyhBKwT4MXwunpamAFLeFfu78=;
 b=gjdshVNK6XMqi8FPGU7SO2ve/Ik1B7v3eAzsVgaik+QbUlznRYswmsSIN9UEMIg+9x
 rUxD/MSim1YTWzRSjOR1lgwYPFozmDJ8DBoxBgjieMBxUv5V5w72ZCKPCjzA7y8Jplm2
 MBlqli+6g8gDaM5ypIRnVPHeJvRsCsh+ybbvDlG29BirY13yAO7apE3rIdeQbJOAhRxQ
 YIkVLQSXi3kkZ4FMfiitOCWMqe5zNOghFaMJlrT4/yoyVDaR5okIvu9Ef5pvpcbKc8E3
 /mbLRYS3xQFi/Q7jkqJyocgeZ23lTu6hjtMrnH3ysJb/3ONOD6dr2iV8OIjdGyK3OHRu
 fouw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786444515; x=1787049315; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wzZ5BnBQlzzhTGmSRFzOLOJJUmRxtFMTrrY4OIrwYHg=;
 b=WmchARACP5peqoo5l1mPj9Q0eJtobZQipo18GiG1NAEJmVU5gm4lKZwcgeo+2fmD2X
 ABuoGNopa3tpiuIgqKxd9K+LYKkYKhhtoVJvZTIJE9MmgiVgTAclTCnp184+c6NhR4w9
 Aql/k6R/Gg6rOuhXXXhrqrf2KNdXC3E7YkDBnKoFZleAmGzIsWHwtQyP/ssEqyZn3C4l
 o+ED/O8KtKcqjsspXpnojD6vcJcHCREaca5s1dO6PM3ftA0c2MLOoj2AuYv1WlP5ZvFI
 HXvgl1aAmE+Ge8mox0+8ARjOERqEzmg6v8vK/bH/B3uQfH7Q2oHqS5LHjz5cDaVr3DBS
 hgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786444515; x=1787049315;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wzZ5BnBQlzzhTGmSRFzOLOJJUmRxtFMTrrY4OIrwYHg=;
 b=MF0fExxJN8WYUqkZPRnaecJHQzxngm84u0YaU+YgA3xD/UKjC6OuzvF9RIzAEtU48l
 HhWUmZLYCCYF4cCdLfgwabr/pc1zFVUnm487IJqCGdVA2XlZ6bhGfYlemLgGv6Jvv78O
 pJr/7Spa5NVg8iNe1Kp2+CIQYNVgwhGXgMHbwtGU6uLQxgSGzwZ5EAK4rcfZyPbngomU
 VFuTr1kjCnYdZun3IFjdUXAFjJCv5JKHs4LKjj4AfWb8aHkYUAgxcbdMMek12riuOssp
 Vle9WC715tSX18qqVNh/DyGqKETE5O/3CNvoflACgEabl3FoAhg+L+b3j79ZOKC0h67d
 JmSQ==
X-Gm-Message-State: AOJu0YyxszutmIR3ASk++ZTh0JWBMK0njW5QwS/gY8dZwp7CX/J0mfNB
 JQTMGDJ+ClGGvy/09SCfp3TSKZBIVcqtLBFVzsOp2K35EfFanahrpWVVEC0Gr9jgGM6ci00Daoq
 Ws0LnzD9JzFMDAEjOLa1XCCq9lJkWH+f7E8f3CNJE0Q==
X-Gm-Gg: AR+sD107HvEJsaPaWdVzg1kIy+0UecVpyVVxW8OHv+T5v7shnpWCDk6nS0X9eRiCPYK
 Mft34mp8sjGB5stzt5FyDjtBSWXyC4jDK5CAlCOViG4x3z+KDC/XTyecT/LQtHGQhrR6N1s4Dfk
 6796/q+hBFYfNk0vFLAXRUwS+NkarGdzkbnKXDhuOJ3PnQ4nFyhShSvtYWuj8ynYf3FhuUi7inH
 MhxtDzLWCrU2oXDmoZCbtscaaQE0UFJ9/cYNSP3yvwMOSmfZ577EDRweKlsPcQx8JLrTM7kvHUB
 GnSC8AxKRXhijuq42F1ByfvAbXDqWlCE11AuciOMBwv2Uk+nyKDE8jIrDMPL0ANa/rCs3c6AwQO
 YmW1aUrkgrUbUQwTfahMbUKWsIUSy
X-Received: by 2002:a05:690c:688a:b0:81e:5a57:b8ad with SMTP id
 00721157ae682-82f2bb8b28fmr14783717b3.21.1786444515262; Tue, 11 Aug 2026
 03:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260727135329.97190-1-marcelomanzo@gmail.com>
 <20260727135329.97190-3-marcelomanzo@gmail.com>
In-Reply-To: <20260727135329.97190-3-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:35:03 +0100
X-Gm-Features: AUfX_mxnqskE1kn5ZAj6RU9ZfIgUBgU4GL6FRAmpgjUwSeXNeLFowhXp6o0DSwY
Message-ID: <CAFEAcA-9-2N0Vqi13zhMerKcx+mZFSeCYj4mfjuyGsRz7_UwnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests/functional/aarch64: add raspi4b full-RAM
 regression test
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 27 Jul 2026 at 14:53, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Guards against the bug fixed in the previous commit: boots raspi4b's
> default 2 GiB configuration and checks that the guest actually sees
> close to that (>1.9M kB), not the ~921 MiB the bug left it capped at.
> Deliberately checks a threshold rather than the exact byte count of
> either figure, since the precise number depends on how this specific
> pinned kernel accounts for its own early reservations; the threshold
> is comfortably between the two (943524 kB broken, 1905824 kB fixed,
> confirmed by hand against this exact kernel/initrd).
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  tests/functional/aarch64/test_raspi4.py | 51 +++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
> index 35ba6c24f7..55903e93d3 100755
> --- a/tests/functional/aarch64/test_raspi4.py
> +++ b/tests/functional/aarch64/test_raspi4.py
> @@ -154,6 +154,57 @@ def test_arm_raspi4_rng_thermal(self):
>          exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
>
>
> +    def test_arm_raspi4_full_ram(self):
> +        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
> +                                           member='boot/kernel8.img')
> +        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
> +                                        member='boot/bcm2711-rpi-4-b.dtb')
> +        initrd_path = self.uncompress(self.ASSET_INITRD)
> +
> +        self.set_machine('raspi4b')
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=pl011,mmio32,0xfe201000 ' +
> +                               'console=ttyAMA0,115200 ' +
> +                               'panic=-1 noreboot ' +
> +                               'dwc_otg.fiq_fsm_enable=0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')

This is an identical kernel/initrd boot to the existing
test_arm_raspi4_initrd() test, right? I think it would be
preferable to add the "check the RAM figure" to the existing
test, after e.g. the checks on cpuinfo and iomem. That way we
save the time it takes to do the full kernel boot. Our
functional test suite is already quite slow because of how
many "boot a guest" tests it needs to run, so I'm keen on
keeping the runtime down where we can do that.

> +        # raspi4b's default machine RAM is 2 GiB, but raspi4_modify_dtb()
> +        # used to compare the wrong field when deciding whether to add a
> +        # second memory node above the 1 GiB peripheral hole (it checked
> +        # the boot-loader's kernel/initrd-loading RAM budget, which is
> +        # itself always capped to at most 1 GiB, rather than the board's
> +        # actual total RAM) -- so that second node was never added for any
> +        # raspi4b configuration, and the guest never saw more than ~1 GiB
> +        # regardless of the machine's nominal RAM size. With the bug,
> +        # MemTotal here is 943524 kB; fixed, it is 1905824 kB. Guard
> +        # against a regression back to the ~1 GiB figure without hardcoding
> +        # the exact byte count of either, which depends on how this
> +        # specific pinned kernel accounts for its own reservations.

I think this comment is a bit more verbose than we need -- we can
just say that we used to get the RAM size wrong and we're guarding
against a regression; anybody interested in the exact details of the
old bug can look in the git history for it.

> +        mem_total_kb = None
> +        cmd_output = exec_command_and_wait_for_pattern(
> +            self, 'cat /proc/meminfo', 'MemAvailable')
> +        for line in cmd_output.decode('ascii', errors='replace').splitlines():
> +            if line.startswith('MemTotal:'):
> +                mem_total_kb = int(line.split()[1])
> +                break
> +        self.assertIsNotNone(mem_total_kb, 'MemTotal line not found')
> +        self.assertGreater(mem_total_kb, 1900000,
> +                           'guest RAM (%d kB) is far below the ~1.9 GiB '
> +                           'expected for a 2 GiB raspi4b -- the second '
> +                           'memory node above the 1 GiB peripheral hole '
> +                           'is probably not being added' % mem_total_kb)
> +
> +        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
> +
> +
>      def test_arm_raspi4_pcie(self):
>          kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
>                                             member='boot/kernel8.img')

thanks
-- PMM

