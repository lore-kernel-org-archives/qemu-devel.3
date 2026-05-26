Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF1CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRj2G-0001uQ-Is; Tue, 26 May 2026 00:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRj29-0001to-DF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:04:50 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRj26-00022s-I0
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:04:48 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bdbac72ac1fso915714866b.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779768285; cv=none;
 d=google.com; s=arc-20240605;
 b=fNWwtRwCx0vP7kDDX43V4F+ts/zkKxbn1QBYAHGNTVa7Ofyy4FY27Onb7DOx+KAHXP
 4ebL8VgEeD6G1A5DHfHSVJ+b+aqUWsF1ZDKkvEXr2X2hLAwoi3dpL4JvlNjK5+NNx3dQ
 ZYrATdvpBfxzrIs9HtRyKdoLpfq1a+3OLDqgBIQrGsqzg203S3e9cfgTpTqrkJFuZzUt
 V7UXyhEPWjBoWsi2UBx0kRmTk/Hs4B02wYPvaHhc2+OXJhkBwg5x7FmmARViF/ikXPcb
 ds1IPxTU8RlCdGzGHz3mvkx5CjhVui3vffFLTHev+mRhpotz8dd4huyhIfPpAgS1d9S5
 ieYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kBtq3ixjuEP/t+P18ax8i+uWhIFgBbGELwYCqOi3kSY=;
 fh=fficikQgOnaS3OyIm1qgecqAAiuWpxxlfAwnIk0DXQM=;
 b=D3XzizzKS8Srt6cduXRA7Y03L+sc3xccm2TZ+XKh6pRkfH9+YM275/C9ER1ZrCOMPI
 fYpx4Wp2M3gW8oFYInm2JZBHfhkCtx/bbjt5GFz2u3wl8Y2EVYNjjjlxmhDSCXIAnvQe
 RwfoIJ6kttNde06Ou8EvFf9mAyQ2l9ekgCKi8CyDoDwUDNh062sJ/KAX56hgLVsiNPgV
 UvzmXnG81cm/P5ZKJeqWIpMuBYRwuGbJ1lJl9XJhmjanBdENHf8pgv6on7Wmxsj6FN4x
 jqAs0eTG1rfQvGrcaKTp7tHH0OIfiBbtiYk9UsWYX3Y8rcE7GM358uqvAvfUa+uk48T1
 vsLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779768285; x=1780373085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBtq3ixjuEP/t+P18ax8i+uWhIFgBbGELwYCqOi3kSY=;
 b=Jrimaw/+dqE60L4nD3iRiKF/p0mRCMYdusQZdZAsEUm6dkZwATCIT2DPf0YSzG8F3q
 tZrGUm1izGhxgWwz+SY4r6l8zZgsbB2l0+CeEZEDJH1xEE/0as4zweu73RZ24jc+L1hY
 Iqmupe6cUF/nEZUOXaicMCl8T+1rpyuen1IZI4GPFDMHw0etUWQQ9IqFu2spA8YITCfn
 X4gqKmB9m6OFu/CwpRAj6fEIdINZGrTqoqhdzsjJjTxIBayqNYq1TYfPRAllKopKyPqi
 ktSr1HHlr1C6JRs+QoUSJ/ctKvIdPgAKhtUMsjMCFuMjxNfYLaA1jqbbyAkDMDbZbgZ7
 SlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779768285; x=1780373085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kBtq3ixjuEP/t+P18ax8i+uWhIFgBbGELwYCqOi3kSY=;
 b=FPLOMvKwPDAwG77hyM6hqgwmES9arKZF2OdnZ+6JbaG3tiNv+NvhZMx9s39X9djA6t
 JzhHIiBWgDZig5D2gJmFZ1uasNa8uMICTDMLafLpmTnhyX1KmUWHZp9mFTbn7tDH7jb8
 7CSJTg6/pAVwyR+Iy9TN+QiY2e+LitPeJ0OI/6q0HxAdSXRTjphqDPoVwg46tVhmG6ur
 /+uE8P7Lg+Ke27x8fXbt/EjJ4sPEJoYKiHuOlJLSHAd7xqeLkKuDLwr1jnlhq1xAhmVD
 e3QbuCajWPUJfqq7G5rh5x6HfajWjEDXJXhDUswWIpUpJYdMnmJcVnIqkmjzNdSnOhi/
 91Mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+C2JhMRkmJ1D+YJhB6mw/1rRYEGYcQtXk7Xjm6dI0Lq5iojt2KAhOGesAwTM8UZYq3T9Agwsa0tqk3@nongnu.org
X-Gm-Message-State: AOJu0Yzpo9OLONxaYZU2gZkCfF+JN+iLGyCGlWj189pj+RH+aPo0M8V+
 /Hn7QzBSXRJ0Yxhrs1+gcXB6NQLhL8rpY73dpZUXjBBvC77lyQOq+9FnibP6cmMDgW5DuxY6qy7
 ZEFdIQ66Na7yhdVcMs+Wjeh8aR9IFkNQ=
X-Gm-Gg: Acq92OE21hQzUHpTgolzxQrajOfIoyJBWRAE7R8r3tLKO251gTplTPVUROQxDYapfMo
 GPGQftcNYizAB/sWissqzj3Vn5DGhzeMEovTNDgSxshRiy1Y/vPwC8tHhZiiFCi7rFQbhKXHi9j
 UlLEOvz+EXepdbGGfopGiU3/n4sGTqK9yuXbm06nyLACYClgs1TVqgQtHrE1DygxyMQQhu5pd4f
 7CY31IvkV8QHCFuMd4rjhOr1bPb6B/EHvKPhrg8RL7mcsZnvW6VxWsLcpmWqL7rROitBKx/CVwK
 NN0xJPwrE2k9olLHwGTNdLSGZnyuOOznJqUtlA==
X-Received: by 2002:a17:906:8446:b0:bae:d29c:4e28 with SMTP id
 a640c23a62f3a-bdd2330ea37mr796595066b.12.1779768284822; Mon, 25 May 2026
 21:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-5@git.sr.ht>
In-Reply-To: <177756498815.8917.12449488721849651971-5@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 14:04:17 +1000
X-Gm-Features: AVHnY4LBMn22daOawB-KCE4OFIkcFKKoCmiFFq1wuYnLVP3e-m_Lqboj4NGwy7w
Message-ID: <CAKmqyKNxR6+-pexcx8xzRKcWo3yYFiwQf8Q7EcfvKYEntaJXfw@mail.gmail.com>
Subject: Re: [PATCH qemu v4 5/9] ot_uart: gather similar behaviours togeter in
 register read and write
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, May 1, 2026 at 2:04=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> the register read and write functions are each a large switch statement w=
ith
> many similar behaviours in, this is mostly for enabling the use of specif=
ic
> register names inside of log messages. this commit adds a lookup table fo=
r
> register names and uses that instead, allowing much of the code in the re=
gister
> read and write functions to be deduplicated.
>
> the write function was also missing a switch case for R_ALERT_TEST, so I =
added
> that in this commit since it has a very simple implementation for now
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/ot_uart.c | 103 ++++++++++++++++++++++++----------------------
>  1 file changed, 53 insertions(+), 50 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 62c182cbed..2247db7110 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -109,6 +109,26 @@ REG32(TIMEOUT_CTRL, 0x30)
>  #define R_LAST_REG (R_TIMEOUT_CTRL)
>  #define REGS_COUNT (R_LAST_REG + 1u)
>  #define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
> +#define REG_NAME(_reg_) \
> +    ((((_reg_) < REGS_COUNT) && REG_NAMES[_reg_]) ? REG_NAMES[_reg_] : "=
?")
> +
> +#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)
> +static const char *REG_NAMES[REGS_COUNT] =3D {
> +    REG_NAME_ENTRY(INTR_STATE),
> +    REG_NAME_ENTRY(INTR_ENABLE),
> +    REG_NAME_ENTRY(INTR_TEST),
> +    REG_NAME_ENTRY(ALERT_TEST),
> +    REG_NAME_ENTRY(CTRL),
> +    REG_NAME_ENTRY(STATUS),
> +    REG_NAME_ENTRY(RDATA),
> +    REG_NAME_ENTRY(WDATA),
> +    REG_NAME_ENTRY(FIFO_CTRL),
> +    REG_NAME_ENTRY(FIFO_STATUS),
> +    REG_NAME_ENTRY(OVRD),
> +    REG_NAME_ENTRY(VAL),
> +    REG_NAME_ENTRY(TIMEOUT_CTRL),
> +};
> +#undef REG_NAME_ENTRY
>
>  static void ot_uart_update_irqs(OtUARTState *s)
>  {
> @@ -301,23 +321,14 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>      OtUARTState *s =3D opaque;
>      uint64_t retvalue =3D 0;
>
> -    switch (addr >> 2) {
> +    hwaddr reg =3D R32_OFF(addr);
> +    switch (reg) {
>      case R_INTR_STATE:
> -        retvalue =3D s->regs[R_INTR_STATE];
> -        break;
>      case R_INTR_ENABLE:
> -        retvalue =3D s->regs[R_INTR_ENABLE];
> -        break;
> -    case R_INTR_TEST:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
> -
>      case R_CTRL:
> -        retvalue =3D s->regs[R_CTRL];
> -        break;
> +    case R_FIFO_CTRL:
>      case R_STATUS:
> -        retvalue =3D s->regs[R_STATUS];
> +        retvalue =3D s->regs[reg];
>          break;
>
>      case R_RDATA:
> @@ -333,14 +344,7 @@ static uint64_t ot_uart_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>              }
>          }
>          break;
> -    case R_WDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
>
> -    case R_FIFO_CTRL:
> -        retvalue =3D s->regs[R_FIFO_CTRL];
> -        break;
>      case R_FIFO_STATUS:
>          retvalue =3D s->regs[R_FIFO_STATUS];
>
> @@ -351,21 +355,21 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
>                        "%s: RX fifos are not supported\n", __func__);
>          break;
>
> -    case R_OVRD:
> -        retvalue =3D s->regs[R_OVRD];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: ovrd is not supported\n", __func__);
> -        break;
>      case R_VAL:
> -        retvalue =3D s->regs[R_VAL];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: val is not supported\n", __func__);
> -        break;
> +    case R_OVRD:
>      case R_TIMEOUT_CTRL:
> -        retvalue =3D s->regs[R_TIMEOUT_CTRL];
> +        retvalue =3D s->regs[reg];
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: timeout_ctrl is not supported\n", __func__);
> +                      "%s: %s is not supported\n", __func__, REG_NAME(re=
g));
> +        break;
> +
> +    case R_ALERT_TEST:
> +    case R_INTR_TEST:
> +    case R_WDATA:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s is write only\n", __func__, REG_NAME(reg))=
;
>          break;
> +
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> @@ -381,7 +385,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
>      OtUARTState *s =3D opaque;
>      uint32_t value =3D val64;
>
> -    switch (addr >> 2) {
> +    hwaddr reg =3D R32_OFF(addr);
> +
> +    switch (reg) {
>      case R_INTR_STATE:
>          /* Write 1 clear */
>          value &=3D INTR_MASK;
> @@ -398,7 +404,11 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>          s->regs[R_INTR_STATE] |=3D value;
>          ot_uart_update_irqs(s);
>          break;
> -
> +    case R_ALERT_TEST:
> +        value &=3D R_ALERT_TEST_FATAL_FAULT_MASK;
> +        s->regs[reg] =3D value;
> +        /* This will also set an IRQ once the alert handler is added */
> +        break;
>      case R_CTRL:
>          s->regs[R_CTRL] =3D value;
>
> @@ -434,15 +444,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>              s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
>          }
>          break;
> -    case R_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: status is read only\n", __func__);
> -        break;
> -
> -    case R_RDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: rdata is read only\n", __func__);
> -        break;
>      case R_WDATA:
>          uart_write_tx_fifo(s, value);
>          break;
> @@ -459,10 +460,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
>              s->tx_level =3D 0;
>          }
>          break;
> -    case R_FIFO_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: fifo_status is read only\n", __func__);
> -        break;
>      case R_OVRD:
>          if (value & R_OVRD_TXEN_MASK) {
>              qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n",
> @@ -470,16 +467,22 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
>          }
>          s->regs[R_OVRD] =3D value & R_OVRD_TXVAL_MASK;
>          break;
> -    case R_VAL:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: val is read only\n", __func__);
> -        break;
> +
>      case R_TIMEOUT_CTRL:
>          s->regs[R_TIMEOUT_CTRL] =3D
>              value & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: timeout_ctrl is not supported\n", __func__);
>          break;
> +
> +    case R_STATUS:
> +    case R_RDATA:
> +    case R_FIFO_STATUS:
> +    case R_VAL:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s is read only\n", __func__, REG_NAME(reg));
> +        break;
> +
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> --
> 2.49.1
>
>

