Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC773CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQ2-0006w5-UU; Tue, 26 May 2026 00:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRjQ2-0006vn-1u
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:29:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRjQ0-0006uw-3V
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:29:29 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67be41d5eeeso15436145a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779769764; cv=none;
 d=google.com; s=arc-20240605;
 b=GuEwVFgdb7poRIOvjZS2n/dQz/CQG4xMKWc7yaYxjkHPkPu8tKLZsh0Iw9FlGBYZOF
 DQ8ZroihAMnSVdYOIfivlkC0qa6Km84GbXuSxpbTY5Ly7UGzzz+gBKT+WZf+u6iRcc3b
 r6GLs6VEBVIBrRB+9YLLkkqcvnEk434PmcAQUTisKW1YXjQtiX0CuDgnAhNxPCksmSjX
 GBAiR2BIZt68xGE2wlGoZwvjBXp0xQKUsA86gp2iwnPpW2/A/QkoJ/aSi2iAtIdSO9Yg
 ldS4ri/Ya/M0HNS8r4HUjUOAOSF7/yayN6d3pvmAP8JkIHCA2ZStqyNw05QrT3rJgaxz
 NBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DW/avr0pVOCF97kNw1Gt3KqWIfDbQyo4pq9ow7g1mLA=;
 fh=iqex9UdGL3ehkDV5PyNwgn5bga/+qs8i8EynkUyVzzo=;
 b=C3ZlSDg+As4PD0az/kcA5Kx9jPTwi3OeJtnpkTdiZYdXpNKrKr4drvOIoFNAdCulwj
 9i+ooF5myTWNSYRkl3kWuXP/+TWtyS4gYG/2Pv4ApKNIZFMDxNOvaEkANzFyV3jwMl9n
 qHdiP+h0qtXoRMClbl1RA/TbG7xVcYD9b8Lt141E0hplH/KxNhUk+mXkIF/F3goK2fWP
 NakZazgxi8PnhfROJGPCoLLAHYEUgFkLnLt0R/38Qp/KviPxSbj44/GPlHKnWed5i77y
 jslyf4KtOrmSDj5jd8eYRd1cppEeA/65dCB6jeXdTlu6fIqpvFLORGze4esY7AacWT1+
 Jrfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769764; x=1780374564; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DW/avr0pVOCF97kNw1Gt3KqWIfDbQyo4pq9ow7g1mLA=;
 b=HOs8EV5Dtnj7bHb7Oicqw15lozFvoIXOg8XK++zvr9x7pJLohYEPJ1VjtHs6cRXCne
 hAF02eG6T7FxlVcRRtJUYrbhpnKsnxEDjeSZvoCqDjJ1lt6tfNxb3fgVkMqEvzAlvL/d
 pYSvt/8mOXhXAkYMoblVsGUaeFWFlpG56nRy3LMRHWKvDXtCS0inhQpkpXrlL04sGhpk
 I/tiPIIVS9tvdnfYHZ2myGz1lPlrJlM8EHug283M649o9rj2jJpL7lGkSQduUuSmdePp
 ea5oO/pnhzS2S5ILW/IcjE4eLCHIB6e0xZ915/Z6SsjlsI6sxZMF2wc34Gh6LOEDUkpV
 kbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769764; x=1780374564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DW/avr0pVOCF97kNw1Gt3KqWIfDbQyo4pq9ow7g1mLA=;
 b=WhHxRzIdxgbh0q5dU5bi1gPHIRdLIpU2yvzwSXFWtwqvAyA7JvklhCZADbKisHTI5+
 r/WLRhZ6cjU1QUAmmH/KvMZoOgwuQn2gDriOGgvDuq+cW9rQ1tjvYKWgABzVxRz6LA5U
 EhppfZ7zJ1F3/YiF8VbKEdmaRStPLWYG9Mb5IaAnJf7CMCQERlCPiJwt0bKbINO/8zEE
 d2Mq1nQM++eRDD3f1sdSUZ70NB/R8ZsRKpqFQ2SdcGCDM8FRIMJM4Xyj1AvUDvviNnpK
 xDyPwM23WSuIKmbfiuNZBAOjKDYoSpKeD6bCFgBZjmUkM+X3Naf4HDr+P8Lb+NcdLJiP
 2t7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ory7GyQ0Go4f7lrvMdKqLwOz/TkIRu4+9+QuLecU9oesFCt2O/vcu5ZdG2EgHIVcxBYvDFXR8e3sU@nongnu.org
X-Gm-Message-State: AOJu0YyCJCuRZXjPJrC9HyDYkpioF4b8A2ikLWIUFN8DTJRRLPu5eR8/
 To+5062/AzaDAhWGT1v+qX5MTzwxbtlYqemMfWQxLcPJPaLNYW6zdTUQAIkIsOcLPd4WJMSU+ia
 veiIQ2Pv9tI6K9K9h5Oor11Rc8sADPL4=
X-Gm-Gg: Acq92OFFnA8Nd2469cgi9UdzP10cApQ3LOxYu3WRGmRN6U4RasEKJDk01wkVJLqEGmz
 XAqK1FsUx7IaxZukijaOiX4RekRxkf8GAQQ/EEvdpEKBrBSMoaeSyPfguvLl5FtIrT5hYTDbk63
 omYL4Af1C6Gyh3L3kKQylwmpxTwIk6KD1Y7xVwL2zDoN2g43GJlg3sJN6ECaJndQmnEMnxPKs2Q
 ksjsBEGzLCvNESQzd/2OOPyWUw+uQ2knHPZpbIEbZ9fSozyhV4DdnUCGE5LjfQcfn+afv1/JM5S
 ICw7h2NswTN3zKtPDuId4QdUmiuKMqfPa4oaRw==
X-Received: by 2002:a17:907:7245:b0:bd4:8b66:c375 with SMTP id
 a640c23a62f3a-bdd237f3b6bmr923127066b.18.1779769764012; Mon, 25 May 2026
 21:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-9@git.sr.ht>
In-Reply-To: <177756498815.8917.12449488721849651971-9@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 14:28:57 +1000
X-Gm-Features: AVHnY4JwKNnL5HoMFsYwK_bzIilUj9sbjKYEY172RC1aCk-5Qy7-Id-gIXqjArA
Message-ID: <CAKmqyKNLw1sCUcVSMG2GVHuf2bnxBOzZBqpAhvYouSuWAq=nRQ@mail.gmail.com>
Subject: Re: [PATCH qemu v4 9/9] ot_uart: add tracing
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
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Fri, May 1, 2026 at 2:05=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> Added some tracing to the OpenTitan UART for transparency when debugging
>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 19 +++++++++++++++++++
>  hw/char/trace-events      |  8 ++++++++
>  hw/riscv/opentitan.c      |  1 +
>  include/hw/char/ot_uart.h |  1 +
>  4 files changed, 29 insertions(+)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index d00f7bee66..910bef00f2 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/char/ot_uart.h"
>  #include "qemu/fifo8.h"
> +#include "hw/core/cpu.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/qdev-clock.h"
>  #include "hw/core/qdev-properties.h"
> @@ -28,6 +29,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>
>  REG32(INTR_STATE, 0x00)
>      SHARED_FIELD(INTR_TX_WATERMARK, 0, 1)
> @@ -126,6 +128,9 @@ static void ot_uart_update_irqs(OtUARTState *s)
>  {
>      uint32_t state_masked =3D s->regs[R_INTR_STATE] & s->regs[R_INTR_ENA=
BLE];
>
> +    trace_ot_uart_irqs(s->ot_id, s->regs[R_INTR_STATE], s->regs[R_INTR_E=
NABLE],
> +                       state_masked);
> +
>      for (int index =3D 0; index < OT_UART_IRQ_NUM; index++) {
>          bool level =3D (state_masked & (1U << index)) !=3D 0;
>          qemu_set_irq(s->irqs[index], level);
> @@ -402,6 +407,10 @@ static uint64_t ot_uart_get_baud(OtUARTState *s)
>      baud *=3D clock_get_hz(s->f_clk);
>      baud >>=3D 20;
>
> +    if (baud) {
> +        trace_ot_uart_check_baudrate(s->ot_id, baud);
> +    }
> +
>      return baud;
>  }
>
> @@ -503,6 +512,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>          return 0;
>      }
>
> +    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
> +    trace_ot_uart_io_read_out(s->ot_id, (uint32_t)addr, REG_NAME(reg),
> +                              retvalue, pc);
> +
>      return retvalue;
>  }
>
> @@ -514,6 +527,9 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
>
>      hwaddr reg =3D R32_OFF(addr);
>
> +    uint32_t pc =3D current_cpu->cc->get_pc(current_cpu);
> +    trace_ot_uart_io_write(s->ot_id, (uint32_t)addr, REG_NAME(reg), valu=
e, pc);
> +
>      switch (reg) {
>      case R_INTR_STATE:
>          /* Write 1 clear */
> @@ -665,6 +681,7 @@ static const VMStateDescription vmstate_ot_uart =3D {
>  };
>
>  static const Property ot_uart_properties[] =3D {
> +    DEFINE_PROP_STRING("ot-id", OtUARTState, ot_id),

I'm not sure we need this

Alistair

>      DEFINE_PROP_CHR("chardev", OtUARTState, chr),
>      DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, =
false),
>      DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),
> @@ -716,6 +733,8 @@ static void ot_uart_realize(DeviceState *dev, Error *=
*errp)
>  {
>      OtUARTState *s =3D OT_UART(dev);
>
> +    g_assert(s->ot_id);
> +
>      s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                            fifo_trigger_update, s);
>
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index a3fcc77287..17cc9ad2d5 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -141,3 +141,11 @@ stm32f2xx_usart_receive(char *id, uint8_t chr) " %s =
receiving '%c'"
>  # riscv_htif.c
>  htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "=
device: %u cmd: %02u payload: %016" PRIx64
>  htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t p=
ayload) "device: %u cmd: %02u payload: %016" PRIx64
> +
> +# ot_uart.c
> +ot_uart_check_baudrate(const char *id, unsigned baud) "%s: %u bps"
> +ot_uart_connect_input_clock(const char *id, const char * srcname) "%s: %=
s"
> +ot_uart_debug(const char *id, const char *msg) "%s: %s"
> +ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname, =
uint32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
> +ot_uart_io_write(const char *id, uint32_t addr, const char *regname, uin=
t32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x"
> +ot_uart_irqs(const char *id, uint32_t active, uint32_t mask, uint32_t ef=
f) "%s: act:0x%08x msk:0x%08x eff:0x%08x"
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 97c33d1b53..163d3ac3d3 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -133,6 +133,7 @@ static void lowrisc_ibex_soc_init(Object *obj)
>      object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
>
>      object_initialize_child(obj, "uart", &s->uart, TYPE_OT_UART);
> +    object_property_set_str(OBJECT(&s->uart), "ot-id", "uart0", &error_f=
atal);
>
>      object_initialize_child(obj, "timer", &s->timer, TYPE_IBEX_TIMER);
>
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index 4dc51142f7..2f538e1f6f 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -54,6 +54,7 @@ struct OtUARTState {
>      bool in_break;
>      guint watch_tag;
>
> +    char *ot_id;
>      Clock *f_clk;
>
>      CharFrontend chr;
> --
> 2.49.1
>

