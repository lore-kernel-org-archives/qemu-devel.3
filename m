Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5957AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUJn-0002S1-Pu; Wed, 08 Jul 2026 11:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUJm-0002RW-Be
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:36:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUJk-0004II-GJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:36:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-470174001a0so541625f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524967; cv=none;
 d=google.com; s=arc-20260327;
 b=jibtyC4ar13splcIR4oSpHmxbn0sorYZBSqBQvqqCSMI7Fs2Rh+qA9TimL0OB0OUvV
 aVaCPiRT638yRYiCPCwRp2h9Piknas0tCqc+4lZYfF5WDn8ibUDa39258WaSa+4gTNIu
 vRYZGSGvho9dRrXVjz9j8kxCC0BkKOpPHSvv2UhQzNxlyr1b98AAoqWwyt1tQv0lHkr6
 j04kGHW9gMaDUFt+0TqtCybXW/zph2S+yHze/Ic+phMirCFZtbnV84Ickftevx1i63oD
 4fLKyTmT+m6KGjn7bvdo/PJfEccDkYYHvNpFmY52+75zwg2lNXrXh41lFStsd/mDZxC+
 P5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+sWvfpeF/Tu8qwPhqM4Er2p5G5pbyvD4idkjt93/NIc=;
 fh=PgvuDsSrN5tO339qb9tpnPzNGxQ+CWeig4WyWwbLr+Y=;
 b=BoHW+Lj/bAbwXdWMC1SVVMip5vFsKmyZ3n74medMf6C+1hrzk+BVuyOASdAbv6Dotj
 MiH1Wwe/OBhjvYUR72+CPlkwhSHwgFuhE/AnmBFpskvBdkwgbb5kYjFx7xqgl4LI0U+m
 hZQdkMvYgl8Ns3pcjT34B5hszHavxuEv+dmTIbt0yPlUC/DetlMzmAstkPgyGoyXJdA1
 IxfsuRBp7pGCeSlex8GAqaosk98X0ftSCSoBP/vKAVLEUOqoHuQ5KnudNx7D2OsITh2b
 Xs5RnAvI32FYD5WBYhmuRPLstdFkReEvFJxHg6KSGGFK22ygBdG0QypnqH/UWtkSn1Mi
 cl5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524967; x=1784129767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+sWvfpeF/Tu8qwPhqM4Er2p5G5pbyvD4idkjt93/NIc=;
 b=l6ulZJo8l78iX/ehxtW48muTWjtgPSm8pIfNWf2uZCFFxMQh/usJ+RqDuykmeiX3Ju
 /k4CnBczKdSN/yCyANZuaGLG0YTyrcaUaLaTymbRoJUyzeiovEnFU1ylUqfrkoB51RPM
 tyjXh00hOYr7npD1Pb0qS6PheuEaYXYWTlywJ7E/hHTx8pqwWIDDeHpzTRQj4fL05Vr1
 m43oDSaxMb0vhf4VQBPsPkJvU6vHVLhxTjIdv4fF27Q6ADYirqjKhAmb6WYgRs8Pc3aE
 HNEwp1nKmNCTUopWWIq2NdT0K1fh3IHYVHFwJe4JQG8eVLerSlEAjbwjvSy1unJMfzy8
 yDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524967; x=1784129767;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sWvfpeF/Tu8qwPhqM4Er2p5G5pbyvD4idkjt93/NIc=;
 b=SrhMGQm6wEwLNIBEFChiU7zaWOqlXLBG4nIp+iS3P+yBTDJS4wEgMa61qAM4ff+ZDB
 +dTY51az3d13d98mzh6T1Ufx04GZRStYSA9zUj50pIHkolEcq9+oIK1bZ8R+0nEiNBC3
 KtScSfAX1savBqBAyI+AXiZowXKwQ50xk2DQ/gLg4IsHq3DQN7t8EEwLu2edLk+00Jt3
 z98xP3jIBDKl40Cz0hBBSWz1YjNNcfeV6fik+Y487dnG2j7MPV1aEAjDtNMhj3po4ENZ
 PXAIGceMT2v25/pNm2kaRCS9zh8ewBirAfPxNkiT3DaaL6D/zMagN2BZ6XYJ2TydIJ4d
 4fpg==
X-Gm-Message-State: AOJu0YxXBRLL8R/S9P2f554oD5jNQy3IqlHKCRJE/ToLDqUtN6j6IQe6
 iYcIeR29k8Ek4AoCVP4FOJGSG0A1FOzUP5POXQdqSHPlQDSVgf12tQErEi7gh2bb0SxnUfUPLmZ
 3VQmnP3XYcSFJic2LvYItW2ZgSQwHVzM=
X-Gm-Gg: AfdE7cnoyWgiCf3leBV4F/LxLKe/Gk9OWeHy3rURO1V4mT3WwhGwD5SZuiNLv20F66r
 HdjVGIwROorkd3kDhoiAN0WWFq/2yrKZE/3hGV5+wM6F05vnW6+4TnGUWg1iNwLm10dobchgmOU
 jPS/e8h9MheSIKQelsY7Dk9mddgdOIYGYP3P9Dcs73ALbAKVP/8YMhPTrzVlwSto9rg8W/innVe
 jXVk8gSK01aF8Bgk4lATQo2TgGVEWWC4kRDPigc0tD5H7ZD9LzHmFlai910cFfAs+WcvQtCN8/b
X-Received: by 2002:a5d:5d0e:0:b0:47b:69a5:7243 with SMTP id
 ffacd0b85a97d-47df07a1e31mr3417178f8f.12.1783524966577; Wed, 08 Jul 2026
 08:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260708111544.1440761-1-clg@redhat.com>
 <20260708111544.1440761-5-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-5-clg@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jul 2026 23:35:52 +0800
X-Gm-Features: AVVi8CfiiIDM7lYQjRVm6dWdFY2ZEn8ChGgtPQrpWVC8djrIHfkGcwEj9kN2pTM
Message-ID: <CAEUhbmVgrnm6HSy4K2zO8bYdX1k+xDEnmo=_GpvNtyb4TKr01Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] tests/qtest: aspeed_smc: Add Quad Output Read (QOR)
 test coverage
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 8, 2026 at 7:17=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> Add read_page_mem_qor (CTRL_FREADMODE with QOR command and quad data
> IO mode) and write_page_qor (user-mode QOR) tests.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/aspeed-smc-utils.h |  4 +++
>  tests/qtest/aspeed-smc-utils.c | 50 ++++++++++++++++++++++++++++++++++
>  tests/qtest/aspeed_smc-test.c  | 16 +++++++++++
>  tests/qtest/ast2700-smc-test.c |  4 +++
>  4 files changed, 74 insertions(+)
>
> diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-util=
s.h
> index fbfb94e831d8..f5720f1becc1 100644
> --- a/tests/qtest/aspeed-smc-utils.h
> +++ b/tests/qtest/aspeed-smc-utils.h
> @@ -44,6 +44,7 @@
>  #define   CTRL_FREADMODE       0x1
>  #define   CTRL_WRITEMODE       0x2
>  #define   CTRL_USERMODE        0x3
> +#define   CTRL_IO_QUAD_DATA     BIT(30)

Already defined in line 42.

>  #define   CTRL_IO_DUAL_DATA     BIT(29)
>  #define   CTRL_DUMMY_LOW_SHIFT   6
>  #define   CTRL_DUMMY_HIGH_SHIFT  14
> @@ -60,6 +61,7 @@ enum {
>      READ =3D 0x03,
>      FAST_READ =3D 0x0b,
>      DOR =3D 0x3b,
> +    QOR =3D 0x6b,
>      PP =3D 0x02,
>      WRSR =3D 0x1,
>      WREN =3D 0x6,
> @@ -99,5 +101,7 @@ void aspeed_smc_test_read_page_mem_fast_read(const voi=
d *data);
>  void aspeed_smc_test_write_page_fast_read(const void *data);
>  void aspeed_smc_test_read_page_mem_dor(const void *data);
>  void aspeed_smc_test_write_page_dor(const void *data);
> +void aspeed_smc_test_read_page_mem_qor(const void *data);
> +void aspeed_smc_test_write_page_qor(const void *data);
>
>  #endif /* TESTS_ASPEED_SMC_UTILS_H */
> diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-util=
s.c
> index 25e3d28ec646..bc64a3eb9477 100644
> --- a/tests/qtest/aspeed-smc-utils.c
> +++ b/tests/qtest/aspeed-smc-utils.c
> @@ -796,3 +796,53 @@ void aspeed_smc_test_write_page_dor(const void *data=
)
>  {
>      test_write_page(data, read_page_dor);
>  }
> +
> +static void read_page_mem_qor(const AspeedSMCTestData *data,
> +                              uint32_t addr, uint32_t *page)
> +{
> +    uint32_t ctrl_reg =3D R_CTRL0 + data->cs * 4;
> +    uint32_t ctrl =3D spi_readl(data, ctrl_reg);
> +    int i;
> +
> +    ctrl &=3D ~(CTRL_USERMODE | (0xff << 16) |
> +              (0x3 << CTRL_DUMMY_LOW_SHIFT) |
> +              (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
> +              CTRL_IO_MODE_MASK);
> +    ctrl |=3D CTRL_FREADMODE | (QOR << 16) |
> +            (1 << CTRL_DUMMY_LOW_SHIFT) |
> +            CTRL_IO_QUAD_DATA;
> +    spi_writel(data, ctrl_reg, ctrl);

Just call spi_ctrl_set_fast_read()?

> +
> +    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        page[i] =3D make_be32(flash_readl(data, addr + i * 4));
> +    }
> +}
> +
> +void aspeed_smc_test_read_page_mem_qor(const void *data)
> +{
> +    test_read_page_mem(data, read_page_mem_qor);
> +}
> +
> +static void read_page_qor(const AspeedSMCTestData *data,
> +                          uint32_t addr, uint32_t *page)
> +{
> +    int i;
> +
> +    spi_ctrl_start_user(data);
> +
> +    flash_writeb(data, 0, EN_4BYTE_ADDR);
> +    flash_writeb(data, 0, QOR);
> +    flash_writel(data, 0, make_be32(addr));
> +    /* 1 dummy byte for standard SPI QOR */
> +    flash_writeb(data, 0, 0x00);
> +
> +    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        page[i] =3D make_be32(flash_readl(data, 0));
> +    }
> +    spi_ctrl_stop_user(data);
> +}
> +
> +void aspeed_smc_test_write_page_qor(const void *data)
> +{
> +    test_write_page(data, read_page_qor);
> +}
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.=
c
> index 6d48444fd71b..004951380e9e 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -76,6 +76,10 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
>                          data, aspeed_smc_test_read_page_mem_dor);
>      qtest_add_data_func("/ast2400/smc/write_page_dor",
>                          data, aspeed_smc_test_write_page_dor);
> +    qtest_add_data_func("/ast2400/smc/read_page_mem_qor",
> +                        data, aspeed_smc_test_read_page_mem_qor);
> +    qtest_add_data_func("/ast2400/smc/write_page_qor",
> +                        data, aspeed_smc_test_write_page_qor);
>      /*
>       * Block protect tests must be run last because the block protect
>       * state is not cleared by reset_memory() and silently prevents
> @@ -136,6 +140,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data=
)
>                          data, aspeed_smc_test_read_page_mem_dor);
>      qtest_add_data_func("/ast2500/smc/write_page_dor",
>                          data, aspeed_smc_test_write_page_dor);
> +    qtest_add_data_func("/ast2500/smc/read_page_mem_qor",
> +                        data, aspeed_smc_test_read_page_mem_qor);
> +    qtest_add_data_func("/ast2500/smc/write_page_qor",
> +                        data, aspeed_smc_test_write_page_qor);
>  }
>
>  static void test_ast2600_evb(AspeedSMCTestData *data)
> @@ -187,6 +195,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data=
)
>                          data, aspeed_smc_test_read_page_mem_dor);
>      qtest_add_data_func("/ast2600/smc/write_page_dor",
>                          data, aspeed_smc_test_write_page_dor);
> +    qtest_add_data_func("/ast2600/smc/read_page_mem_qor",
> +                        data, aspeed_smc_test_read_page_mem_qor);
> +    qtest_add_data_func("/ast2600/smc/write_page_qor",
> +                        data, aspeed_smc_test_write_page_qor);
>  }
>
>  static void test_ast1030_evb(AspeedSMCTestData *data)
> @@ -238,6 +250,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data=
)
>                          data, aspeed_smc_test_read_page_mem_dor);
>      qtest_add_data_func("/ast1030/smc/write_page_dor",
>                          data, aspeed_smc_test_write_page_dor);
> +    qtest_add_data_func("/ast1030/smc/read_page_mem_qor",
> +                        data, aspeed_smc_test_read_page_mem_qor);
> +    qtest_add_data_func("/ast1030/smc/write_page_qor",
> +                        data, aspeed_smc_test_write_page_qor);
>  }
>
>  int main(int argc, char **argv)
> diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-tes=
t.c
> index bd9d3f7905b3..f85077e04ff4 100644
> --- a/tests/qtest/ast2700-smc-test.c
> +++ b/tests/qtest/ast2700-smc-test.c
> @@ -60,6 +60,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
>                          data, aspeed_smc_test_read_page_mem_dor);
>      qtest_add_data_func("/ast2700/smc/write_page_dor",
>                          data, aspeed_smc_test_write_page_dor);
> +    qtest_add_data_func("/ast2700/smc/read_page_mem_qor",
> +                        data, aspeed_smc_test_read_page_mem_qor);
> +    qtest_add_data_func("/ast2700/smc/write_page_qor",
> +                        data, aspeed_smc_test_write_page_qor);
>  }
>
>  int main(int argc, char **argv)
> --

Regards,
Bin

