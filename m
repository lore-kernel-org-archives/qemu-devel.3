Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B060CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4Uc-0000O3-27; Tue, 21 Oct 2025 01:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vB4UZ-0000N5-KY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:01:03 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vB4UU-0003MP-W4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:01:01 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57a292a3a4bso5994768e87.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 22:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1761022856; x=1761627656;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8LYrKu4mS2ZMKjSZ+BP7b/um9u4pVHp73bEYw0JekNk=;
 b=WhtFzf28ghb0/UPo6wL70WW5sU6zohjVH9w4TFZRYAP+V8VY8UZ/KSR/7twTgg38Zk
 fZI/ZG2yEtLjGVJLqlemIpAgNKVlN8DRR78DuMYDpUEwEC8r3LRWuZSxE6CDLOUzLuME
 81cjXSUZHqyoMA/P4ZpQ9D8zPclXwDmsO2tCi+/y1iQ2+soO8bFSzk2Ecy/cx5xi2UQ2
 sprGiQ3WeWDXvfxoK/tTRWezy5k5w5FMRE3l04CKTo14InTJJsoLU50UUOHhnWu1IGUf
 lM0fiaaH4AHM2WMeuLt4tUmg8AV8NYty6f273JK7jwTox7ukM95+bIfNhSPK+77mUEjK
 7eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761022856; x=1761627656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8LYrKu4mS2ZMKjSZ+BP7b/um9u4pVHp73bEYw0JekNk=;
 b=lk7x0L4/Q+NkSuJBEhyOfiwrdBmetVA8pubNqriCd86ihqiD3QdwHrjXkGyqM7Mox9
 aXO/Hd8b1a2qNb4gy7KizhjFpy2MnCh8AtjYJrP4/ebSfC/GvVOtVn9pQMF7DSCzrUhh
 WnwlcoQoMhi3CWyxiAtMqUmig06EffTbx7ZWI4cyL9Gub0kVD1cOkDX5vLxRu2o6s7Y6
 4eH9CglUvUG1nNMyEr2rJ+XvInUcanUaFmFZRdA5pGt6Ng4Poyt8kTuCo2CnWROvNZHV
 t7l2RvogAXKeMxC4dOQrb8c84FyaPDuBVYhhHz3T5xZwn9g7Ansx/K1zsasGzuuihGpe
 scTw==
X-Gm-Message-State: AOJu0YzgkCvZ/QBKuLF4S+oNT5FUak+rDuGmgZki7FYatkGzCMcuUKIj
 d0kx/SLMxNPt7+YReGFHIk2sH4H6sRqZpaFlfwoP9+4UFTqXTPQ0nuwM555YfRtXkQEYLXp2IRE
 qMQK46U+LjVw1ImIl2B5OW0IVLQagyFhaUONwO6SUrw==
X-Gm-Gg: ASbGncuFcIw9fkIJMHoS8O3+ITlFu10EsMkPYU/JZeZupKwlCsntSzR7ITif2Yn0M0t
 6zefJVZ2EQ82iYXMsQm/2FbbICCXf9gj8N2wGWO8L7NhxGkJD51I+hAZ9uiftqMImwbkjzNb7Je
 UUQ8ewIV9xxcDAcpZHM5fBmfCtFXgKlygLY3JjLPOocxWMvSfajNvIWUbFRFXEQPRLt7TmTPhko
 bqQ98cA39rrD/T6C5MlJzyjAzqn5CGEBou+wOZcZ7MrLKGVu1JeHumqM1uX6P3pZwNTrfYUQM4h
 ix68Oc27E0D+h6M=
X-Google-Smtp-Source: AGHT+IGsBRlVqrbCFJ9uWEwdCrnMY7fc14UlYH9Js3mqIfQ0iJoHfpFYacPg5gBt6A2AEcn+gze/lP6bSs0op9AdhWU=
X-Received: by 2002:ac2:4c4c:0:b0:591:c8de:4673 with SMTP id
 2adb3069b0e04-591d84fb5e2mr4417895e87.25.1761022855818; Mon, 20 Oct 2025
 22:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251020181435.8242-1-michael@videogpu.com>
 <20251020181435.8242-2-michael@videogpu.com>
 <b2a91079-f6b5-4bb5-89c3-18307481c7a9@linaro.org>
In-Reply-To: <b2a91079-f6b5-4bb5-89c3-18307481c7a9@linaro.org>
From: Michael Levit <michael@videogpu.com>
Date: Tue, 21 Oct 2025 08:00:44 +0300
X-Gm-Features: AS18NWBxUQbDogGvigcmh2OXf4i4YBefxwZHk23_fPhWgoI0xh9ObZuEYct3QaU
Message-ID: <CA+KCYkvimD8_-X9k=AyubP1vNh162XCuRatemd6AL8NhzY7U-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/riscv: adding support for NeoRV32 RiscV MCU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c33e790641a415da"
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=michael@videogpu.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000c33e790641a415da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phil,

Thank you for review and suggestions, I will split the patch and re-send it=
.
Yes, change in .gitignore is a mistake.

Best regards,
Michael

On Mon, Oct 20, 2025 at 10:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> Hi Michael,
>
> On 20/10/25 20:14, Michael Levit wrote:
> > From: Michael <michael@videogpu.com>
> >
> > 1) Initial support for Neorv32 soft-core MCU
> > 2) IMEM, DMEM memory regions, bootloader ROM
> > 3) Basic support for UART0 (no interrupts yet)
> > 4) Basic support for SPI
> > 5) Added SPI flash memory for loading firmware following  bootloader
> > 6) Based on Neorv32 RTL implementation repo
> >     https://github.com/stnolting/neorv32
> >     commit id 7d0ef6b2
> >
> > Signed-off-by: Michael Levit <michael@videogpu.com>
> > ---
> >   .gitignore                                  |   1 +
> >   configs/devices/riscv32-softmmu/default.mak |   1 +
> >   docs/system/riscv/neorv32.rst               | 110 +++++
> >   hw/char/Kconfig                             |   3 +
> >   hw/char/meson.build                         |   1 +
> >   hw/char/neorv32_uart.c                      | 311 ++++++++++++
> >   hw/misc/Kconfig                             |   2 +
> >   hw/misc/meson.build                         |   1 +
> >   hw/misc/neorv32_sysinfo.c                   | 183 +++++++
> >   hw/misc/neorv32_sysinfo.h                   |  79 +++
> >   hw/misc/neorv32_sysinfo_rtl.h               | 134 ++++++
> >   hw/riscv/Kconfig                            |   8 +
> >   hw/riscv/meson.build                        |   1 +
> >   hw/riscv/neorv32.c                          | 219 +++++++++
> >   hw/ssi/Kconfig                              |   4 +
> >   hw/ssi/meson.build                          |   1 +
> >   hw/ssi/neorv32_spi.c                        | 504 +++++++++++++++++++=
+
> >   include/hw/char/neorv32_uart.h              |  68 +++
> >   include/hw/riscv/neorv32.h                  |  60 +++
> >   include/hw/ssi/neorv32_spi.h                |  70 +++
> >   target/riscv/cpu-qom.h                      |   2 +
> >   target/riscv/cpu.c                          |  18 +
> >   target/riscv/cpu.h                          |   3 +
> >   target/riscv/cpu_cfg.h                      |   1 +
> >   target/riscv/cpu_cfg_fields.h.inc           |   1 +
> >   target/riscv/cpu_vendorid.h                 |   2 +
> >   target/riscv/meson.build                    |   1 +
> >   target/riscv/neorv32_csr.c                  |  54 +++
> >   28 files changed, 1843 insertions(+)
>
> Thanks for your contribution! However I'm afraid this patch is too big
> to be reviewed without missing something. I'd suggest splitting like
> the 6 bullets you enumerated.
>
> > diff --git a/.gitignore b/.gitignore
> > index 61fa39967b..b53806de50 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -9,6 +9,7 @@
> >   .clang-format
> >   .gdb_history
> >   cscope.*
> > +phases.hold
>
> Not sure from where this file comes; maybe a shell typo?
> Regards,
>
> Phil.
>
>

--000000000000c33e790641a415da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5IaSBQaGlsLDxicj48YnI+PC9kaXY+
VGhhbmsgeW91IGZvciByZXZpZXcgYW5kIHN1Z2dlc3Rpb25zLCBJIHdpbGwgc3BsaXQgdGhlIHBh
dGNoIGFuZCByZS1zZW5kIGl0Ljxicj48L2Rpdj5ZZXMsIGNoYW5nZSBpbiAuZ2l0aWdub3JlIGlz
IGEgbWlzdGFrZS48YnI+PGJyPjwvZGl2PkJlc3QgcmVnYXJkcyw8YnI+PC9kaXY+TWljaGFlbDxi
cj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVy
Ij48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gTW9uLCBPY3QgMjAsIDIwMjUg
YXQgMTA6MjHigK9QTSBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAmbHQ7PGEgaHJlZj0ibWFpbHRv
OnBoaWxtZEBsaW5hcm8ub3JnIj5waGlsbWRAbGluYXJvLm9yZzwvYT4mZ3Q7IHdyb3RlOjxicj48
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+SGkgTWljaGFlbCw8YnI+DQo8YnI+DQpPbiAyMC8xMC8yNSAyMDoxNCwgTWlj
aGFlbCBMZXZpdCB3cm90ZTo8YnI+DQomZ3Q7IEZyb206IE1pY2hhZWwgJmx0OzxhIGhyZWY9Im1h
aWx0bzptaWNoYWVsQHZpZGVvZ3B1LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1pY2hhZWxAdmlkZW9n
cHUuY29tPC9hPiZndDs8YnI+DQomZ3Q7IDxicj4NCiZndDsgMSkgSW5pdGlhbCBzdXBwb3J0IGZv
ciBOZW9ydjMyIHNvZnQtY29yZSBNQ1U8YnI+DQomZ3Q7IDIpIElNRU0sIERNRU0gbWVtb3J5IHJl
Z2lvbnMsIGJvb3Rsb2FkZXIgUk9NPGJyPg0KJmd0OyAzKSBCYXNpYyBzdXBwb3J0IGZvciBVQVJU
MCAobm8gaW50ZXJydXB0cyB5ZXQpPGJyPg0KJmd0OyA0KSBCYXNpYyBzdXBwb3J0IGZvciBTUEk8
YnI+DQomZ3Q7IDUpIEFkZGVkIFNQSSBmbGFzaCBtZW1vcnkgZm9yIGxvYWRpbmcgZmlybXdhcmUg
Zm9sbG93aW5nwqAgYm9vdGxvYWRlcjxicj4NCiZndDsgNikgQmFzZWQgb24gTmVvcnYzMiBSVEwg
aW1wbGVtZW50YXRpb24gcmVwbzxicj4NCiZndDvCoCDCoCDCoDxhIGhyZWY9Imh0dHBzOi8vZ2l0
aHViLmNvbS9zdG5vbHRpbmcvbmVvcnYzMiIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cHM6Ly9naXRodWIuY29tL3N0bm9sdGluZy9uZW9ydjMyPC9hPjxicj4NCiZndDvCoCDC
oCDCoGNvbW1pdCBpZCA3ZDBlZjZiMjxicj4NCiZndDsgPGJyPg0KJmd0OyBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWVsIExldml0ICZsdDs8YSBocmVmPSJtYWlsdG86bWljaGFlbEB2aWRlb2dwdS5jb20i
IHRhcmdldD0iX2JsYW5rIj5taWNoYWVsQHZpZGVvZ3B1LmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyAt
LS08YnI+DQomZ3Q7wqAgwqAuZ2l0aWdub3JlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgY29uZmlncy9kZXZp
Y2VzL3Jpc2N2MzItc29mdG1tdS9kZWZhdWx0Lm1hayB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBk
b2NzL3N5c3RlbS9yaXNjdi9uZW9ydjMyLnJzdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCAxMTAg
KysrKys8YnI+DQomZ3Q7wqAgwqBody9jaGFyL0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKzxicj4NCiZndDvCoCDCoGh3L2NoYXIvbWVz
b24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxi
cj4NCiZndDvCoCDCoGh3L2NoYXIvbmVvcnYzMl91YXJ0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8IDMxMSArKysrKysrKysrKys8YnI+DQomZ3Q7wqAgwqBody9taXNjL0tjb25m
aWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKzxi
cj4NCiZndDvCoCDCoGh3L21pc2MvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L21pc2MvbmVvcnYzMl9zeXNp
bmZvLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTgzICsrKysrKys8YnI+DQomZ3Q7
wqAgwqBody9taXNjL25lb3J2MzJfc3lzaW5mby5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB8wqAgNzkgKysrPGJyPg0KJmd0O8KgIMKgaHcvbWlzYy9uZW9ydjMyX3N5c2luZm9fcnRsLmjC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTM0ICsrKysrKzxicj4NCiZndDvCoCDCoGh3L3Jpc2N2
L0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA4
ICs8YnI+DQomZ3Q7wqAgwqBody9yaXNjdi9tZXNvbi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3Jpc2N2L25lb3J2MzIu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMjE5ICsrKysrKysrKzxi
cj4NCiZndDvCoCDCoGh3L3NzaS9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIMKgNCArPGJyPg0KJmd0O8KgIMKgaHcvc3NpL21lc29uLmJ1aWxk
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0
O8KgIMKgaHcvc3NpL25lb3J2MzJfc3BpLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8IDUwNCArKysrKysrKysrKysrKysrKysrKzxicj4NCiZndDvCoCDCoGluY2x1ZGUvaHcv
Y2hhci9uZW9ydjMyX3VhcnQuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA2OCArKys8YnI+DQom
Z3Q7wqAgwqBpbmNsdWRlL2h3L3Jpc2N2L25lb3J2MzIuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHzCoCA2MCArKys8YnI+DQomZ3Q7wqAgwqBpbmNsdWRlL2h3L3NzaS9uZW9ydjMyX3NwaS5o
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDcwICsrKzxicj4NCiZndDvCoCDCoHRhcmdldC9y
aXNjdi9jcHUtcW9tLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICs8
YnI+DQomZ3Q7wqAgwqB0YXJnZXQvcmlzY3YvY3B1LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8wqAgMTggKzxicj4NCiZndDvCoCDCoHRhcmdldC9yaXNjdi9jcHUuaMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDMgKzxicj4NCiZndDvC
oCDCoHRhcmdldC9yaXNjdi9jcHVfY2ZnLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5p
bmPCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoHRhcmdldC9yaXNjdi9j
cHVfdmVuZG9yaWQuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArPGJyPg0KJmd0
O8KgIMKgdGFyZ2V0L3Jpc2N2L21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgdGFyZ2V0L3Jpc2N2L25lb3J2MzJfY3NyLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNTQgKysrPGJyPg0KJmd0O8KgIMKgMjggZmlsZXMg
Y2hhbmdlZCwgMTg0MyBpbnNlcnRpb25zKCspPGJyPg0KPGJyPg0KVGhhbmtzIGZvciB5b3VyIGNv
bnRyaWJ1dGlvbiEgSG93ZXZlciBJJiMzOTttIGFmcmFpZCB0aGlzIHBhdGNoIGlzIHRvbyBiaWc8
YnI+DQp0byBiZSByZXZpZXdlZCB3aXRob3V0IG1pc3Npbmcgc29tZXRoaW5nLiBJJiMzOTtkIHN1
Z2dlc3Qgc3BsaXR0aW5nIGxpa2U8YnI+DQp0aGUgNiBidWxsZXRzIHlvdSBlbnVtZXJhdGVkLjxi
cj4NCjxicj4NCiZndDsgZGlmZiAtLWdpdCBhLy5naXRpZ25vcmUgYi8uZ2l0aWdub3JlPGJyPg0K
Jmd0OyBpbmRleCA2MWZhMzk5NjdiLi5iNTM4MDZkZTUwIDEwMDY0NDxicj4NCiZndDsgLS0tIGEv
LmdpdGlnbm9yZTxicj4NCiZndDsgKysrIGIvLmdpdGlnbm9yZTxicj4NCiZndDsgQEAgLTksNiAr
OSw3IEBAPGJyPg0KJmd0O8KgIMKgLmNsYW5nLWZvcm1hdDxicj4NCiZndDvCoCDCoC5nZGJfaGlz
dG9yeTxicj4NCiZndDvCoCDCoGNzY29wZS4qPGJyPg0KJmd0OyArcGhhc2VzLmhvbGQ8YnI+DQo8
YnI+DQpOb3Qgc3VyZSBmcm9tIHdoZXJlIHRoaXMgZmlsZSBjb21lczsgbWF5YmUgYSBzaGVsbCB0
eXBvPzxicj4NClJlZ2FyZHMsPGJyPg0KPGJyPg0KUGhpbC48YnI+DQo8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+DQo=
--000000000000c33e790641a415da--

