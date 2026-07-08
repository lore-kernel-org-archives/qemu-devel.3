Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3116EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUDC-000162-5h; Wed, 08 Jul 2026 11:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUDA-00015Z-9Q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:29:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUD8-0001Yv-GB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:29:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so240543f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524556; cv=none;
 d=google.com; s=arc-20260327;
 b=D4E5j2fqUxoFUuwUZrWr97z2X6a+MbTeNzaVv0A2jiE524WnQv95+UJtvgx27uOTjc
 U31pxamUQrXrDYwaO6XtugwXaNJn2nZtn5pcwlgV2YwCU22Y2MaLQn17TkHYNFYhdzgV
 er/WVX/qRZZJKqoMTDEyQJBcDQtWPmouebcRjkcqqweomHOP28sywMNqadR/18J0nHaL
 d+4l/KEe19e5tSr72X5tNEkNub4PSSw33fW3wYLap37MERpObTH0VMsC7cuKGx5eqSQy
 K1PamDvykHpkIaB1+ubyWLWeMxfb7n/5A2TpBiF/yePUPQdW0gjLScvpxlEB+yCbbR7z
 xBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HoMQvPMP4ny+19fgg1l8RqVDO/Mokzld/gdT8zr+FvU=;
 fh=PgvuDsSrN5tO339qb9tpnPzNGxQ+CWeig4WyWwbLr+Y=;
 b=k3uXo8zf2w+Fm8OoDwKBJM/rFoFyuez/SOg0BXGMrjwnn8gAym8cYHCjjtCy6ZZNoa
 TM/gw9gGKdCXHhVWkbU1OZEbw9V6PIgkp7BZ1+NQIZ9nbbAse7seVo2g3KZewzxP4z6Y
 dNUNopObepKJ3WkoVacM3REZ2U9n/N8ShiJx+8YMFLDOPwrc66onX7DezF9Sl1SF+USY
 Zk1eAF3lXrr5DR3vS3JI0ldAOStZ3MdmcY+wJCbZdl6CrgqJiv3xthmG0ijXt8RLXkGp
 3gph1FiQ914Dpg5NiJAy6OJd9NHB79eoLQfLXW7RHQjcjd1QdT3EUfq0eX+yP1kIzBGa
 ICkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524556; x=1784129356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HoMQvPMP4ny+19fgg1l8RqVDO/Mokzld/gdT8zr+FvU=;
 b=LSdQqt49hzHgwmgRWcSyWnh4uKOe6Zx0pFRFhbI18paaoInAGYNbTEs+/YTYlocryt
 xW6P/fYzRbWao+fGzjol9Pjy6nvtxbCMBim9h5z4ejEcixFRKfn5XkGYtXmnHxxRXlUf
 VEZ+Yeze/f7LH0XGm/ICQA7rL8BziTfOKmytNI/MwSxuWk8zjDhoAjsp+28fokFJ/Iwc
 Yrm74GP6QIJ/jJmfCJi85I9Z9Eis0XANF1ktsLvtUJH3rS3xtkSMksc+JqvQY7GdjlXA
 z9WoZT0JsvYijjhS+ivtrJdQiuPs5xAWUisRa96ospnnCtfpM2jQdGgKE9p3aFfrsxmG
 vZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524556; x=1784129356;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HoMQvPMP4ny+19fgg1l8RqVDO/Mokzld/gdT8zr+FvU=;
 b=soi5eL/5ZCkCoykDh8DvAmwO4AChe+keU7t35bvWLI7hHLaWin5Abu294+W2pxfmOp
 Y21WKKFVOUD3xAtHATuunN2dW1r32K1Ie52hvdIJOmiSY8KnMGklVyTq8ucPiD2P1V5k
 XVD59J+7bdES1h3tttDxIT9yofqmCjxH3iMeljoVaG4sv716Q5nTdKX/wLAHW8vC8P2H
 X8YwIe+HpEeuwnCAfEbMmE8dfMdxOfCXXO3LgtAgX2Ip+T9OwyUBvKCydtPPhn8c1prd
 cLM0YubcvF5Lmk1pPT7KI3IyPyI6rDt/9hTqMMFrCmI6IeHW6VduTAH94eQM6ecujLY0
 gtTw==
X-Gm-Message-State: AOJu0YzfVQ7pqOU4hlcjlIWvnadqzzwx1fGTFcGIrjUwZ6IsCJv8g7fV
 v7P8GZQgQY6clW6W4cyEQP/siIsUYKBSHRMhkuMg5mo34RW98d8jN5gXlgWZdjKYpKV0brGhxv+
 ZPPQytuUCbwL056ytuW2//0k/vTKtTsI=
X-Gm-Gg: AfdE7ckU2jELH0ybk4J8eJPRmi0b4Ayo1uBCo3Hh9L+F3iyAXOTuhzgelP5xBCgB0zq
 J/HozYscOErOPe715ONOVLq0YTOL51vSZYk6hETKUh/yiJAqGl3Nh6kb7vxwtcraXzDgcDqv43R
 UO7FDIGylA8FGXbQdWNBx4TRITFapZgBe2TYX7aV1kH81Qlvs6oJwS38oaOYgzdad0ExirwvxTb
 ZTXUvl2PZpLmHTf0WthSP77qeyUkojpnEe+agQXcS1iExcmegXSQFRl+w+bRN3SLX5veDYfSAvl
 VmHKZoIYig==
X-Received: by 2002:a05:6000:2911:b0:46f:9d18:bd3c with SMTP id
 ffacd0b85a97d-47df07a959bmr3655604f8f.12.1783524555660; Wed, 08 Jul 2026
 08:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260708111544.1440761-1-clg@redhat.com>
 <20260708111544.1440761-3-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-3-clg@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jul 2026 23:29:03 +0800
X-Gm-Features: AVVi8CeikI2FNQGUnCpq9U1LObkJgLcF5AXhFw6GOcBvGK0qomZmNccpaDR6djQ
Message-ID: <CAEUhbmWWmX9BKwS2m12vPk=rN_DxzCKqsm=h9g26QdHcX3gHqw@mail.gmail.com>
Subject: Re: [PATCH 2/4] tests/qtest: aspeed_smc: Add fast-read test coverage
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jul 8, 2026 at 7:17=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> Add read_page_mem_fast_read (CTRL_FREADMODE with dummy byte) and
> write_page_fast_read (user-mode FAST_READ) tests.
>
> Signed-off-by: Cedric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/aspeed-smc-utils.h |  5 ++++
>  tests/qtest/aspeed-smc-utils.c | 49 ++++++++++++++++++++++++++++++++++
>  tests/qtest/aspeed_smc-test.c  | 21 +++++++++++++++
>  tests/qtest/ast2700-smc-test.c |  4 +++
>  4 files changed, 79 insertions(+)
>
> diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-util=
s.h
> index e2fd8ff1bd16..5a86514caf35 100644
> --- a/tests/qtest/aspeed-smc-utils.h
> +++ b/tests/qtest/aspeed-smc-utils.h
> @@ -44,6 +44,8 @@
>  #define   CTRL_FREADMODE       0x1
>  #define   CTRL_WRITEMODE       0x2
>  #define   CTRL_USERMODE        0x3
> +#define   CTRL_DUMMY_LOW_SHIFT   6
> +#define   CTRL_DUMMY_HIGH_SHIFT  14
>  #define SR_WEL BIT(1)
>
>  /*
> @@ -55,6 +57,7 @@ enum {
>      WRDI =3D 0x4,
>      BULK_ERASE =3D 0xc7,
>      READ =3D 0x03,
> +    FAST_READ =3D 0x0b,
>      PP =3D 0x02,
>      WRSR =3D 0x1,
>      WREN =3D 0x6,
> @@ -90,5 +93,7 @@ void aspeed_smc_test_status_reg_write_protection(const =
void *data);
>  void aspeed_smc_test_write_block_protect(const void *data);
>  void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
>  void aspeed_smc_test_write_page_qpi(const void *data);
> +void aspeed_smc_test_read_page_mem_fast_read(const void *data);
> +void aspeed_smc_test_write_page_fast_read(const void *data);
>
>  #endif /* TESTS_ASPEED_SMC_UTILS_H */
> diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-util=
s.c
> index ed125741eb36..9883ade0815c 100644
> --- a/tests/qtest/aspeed-smc-utils.c
> +++ b/tests/qtest/aspeed-smc-utils.c
> @@ -697,3 +697,52 @@ void aspeed_smc_test_write_page_qpi(const void *data=
)
>      flash_reset(test_data);
>  }
>
> +static void read_page_mem_fast_read(const AspeedSMCTestData *data,
> +                                uint32_t addr, uint32_t *page)
> +{
> +    uint32_t ctrl_reg =3D R_CTRL0 + data->cs * 4;
> +    uint32_t ctrl =3D spi_readl(data, ctrl_reg);
> +    int i;
> +
> +    /* Set FREADMODE with FAST_READ command and 1 dummy byte */
> +    ctrl &=3D ~(CTRL_USERMODE | (0xff << 16) |
> +              (0x3 << CTRL_DUMMY_LOW_SHIFT) |
> +              (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
> +              CTRL_IO_MODE_MASK);
> +    ctrl |=3D CTRL_FREADMODE | (FAST_READ << 16) |
> +            (1 << CTRL_DUMMY_LOW_SHIFT);
> +    spi_writel(data, ctrl_reg, ctrl);

Could just call spi_ctrl_set_fast_read()?

> +
> +    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        page[i] =3D make_be32(flash_readl(data, addr + i * 4));
> +    }
> +}
> +
> +void aspeed_smc_test_read_page_mem_fast_read(const void *data)
> +{
> +    test_read_page_mem(data, read_page_mem_fast_read);
> +}
> +
> +static void read_page_fast_read(const AspeedSMCTestData *data,
> +                                uint32_t addr, uint32_t *page)
> +{
> +    int i;
> +
> +    spi_ctrl_start_user(data);
> +
> +    flash_writeb(data, 0, EN_4BYTE_ADDR);
> +    flash_writeb(data, 0, FAST_READ);
> +    flash_writel(data, 0, make_be32(addr));
> +    /* 1 dummy byte for standard SPI fast-read */
> +    flash_writeb(data, 0, 0x00);
> +
> +    for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        page[i] =3D make_be32(flash_readl(data, 0));
> +    }
> +    spi_ctrl_stop_user(data);
> +}
> +
> +void aspeed_smc_test_write_page_fast_read(const void *data)
> +{
> +    test_write_page(data, read_page_fast_read);
> +}
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.=
c
> index 39af1df0ed75..bbda15ad17ea 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -68,6 +68,15 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
>                          data, aspeed_smc_test_read_status_reg);
>      qtest_add_data_func("/ast2400/smc/status_reg_write_protection",
>                          data, aspeed_smc_test_status_reg_write_protectio=
n);
> +    qtest_add_data_func("/ast2400/smc/read_page_mem_fast_read",
> +                        data, aspeed_smc_test_read_page_mem_fast_read);
> +    qtest_add_data_func("/ast2400/smc/write_page_fast_read",
> +                        data, aspeed_smc_test_write_page_fast_read);
> +    /*
> +     * Block protect tests must be run last because the block protect
> +     * state is not cleared by reset_memory() and silently prevents
> +     * subsequent flash writes.
> +     */
>      qtest_add_data_func("/ast2400/smc/write_block_protect",
>                          data, aspeed_smc_test_write_block_protect);
>      qtest_add_data_func("/ast2400/smc/write_block_protect_bottom_bit",
> @@ -115,6 +124,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data=
)
>                          data, aspeed_smc_test_read_status_reg);
>      qtest_add_data_func("/ast2500/smc/write_page_qpi",
>                          data, aspeed_smc_test_write_page_qpi);
> +    qtest_add_data_func("/ast2500/smc/read_page_mem_fast_read",
> +                        data, aspeed_smc_test_read_page_mem_fast_read);
> +    qtest_add_data_func("/ast2500/smc/write_page_fast_read",
> +                        data, aspeed_smc_test_write_page_fast_read);
>  }
>
>  static void test_ast2600_evb(AspeedSMCTestData *data)
> @@ -158,6 +171,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data=
)
>                          data, aspeed_smc_test_read_status_reg);
>      qtest_add_data_func("/ast2600/smc/write_page_qpi",
>                          data, aspeed_smc_test_write_page_qpi);
> +    qtest_add_data_func("/ast2600/smc/read_page_mem_fast_read",
> +                        data, aspeed_smc_test_read_page_mem_fast_read);
> +    qtest_add_data_func("/ast2600/smc/write_page_fast_read",
> +                        data, aspeed_smc_test_write_page_fast_read);
>  }
>
>  static void test_ast1030_evb(AspeedSMCTestData *data)
> @@ -201,6 +218,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data=
)
>                          data, aspeed_smc_test_read_status_reg);
>      qtest_add_data_func("/ast1030/smc/write_page_qpi",
>                          data, aspeed_smc_test_write_page_qpi);
> +    qtest_add_data_func("/ast1030/smc/read_page_mem_fast_read",
> +                        data, aspeed_smc_test_read_page_mem_fast_read);
> +    qtest_add_data_func("/ast1030/smc/write_page_fast_read",
> +                        data, aspeed_smc_test_write_page_fast_read);
>  }
>
>  int main(int argc, char **argv)
> diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-tes=
t.c
> index 33fc47230ee5..9ad04b574c0d 100644
> --- a/tests/qtest/ast2700-smc-test.c
> +++ b/tests/qtest/ast2700-smc-test.c
> @@ -52,6 +52,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
>                          data, aspeed_smc_test_read_status_reg);
>      qtest_add_data_func("/ast2700/smc/write_page_qpi",
>                          data, aspeed_smc_test_write_page_qpi);
> +    qtest_add_data_func("/ast2700/smc/read_page_mem_fast_read",
> +                        data, aspeed_smc_test_read_page_mem_fast_read);
> +    qtest_add_data_func("/ast2700/smc/write_page_fast_read",
> +                        data, aspeed_smc_test_write_page_fast_read);
>  }
>
>  int main(int argc, char **argv)

Regards,
Bin

