Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CEBCEB2DF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 09:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6nvm-0001ap-Tj; Fri, 01 Nov 2024 05:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6nvi-0001aX-Cd
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 05:26:54 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6nvf-0001AU-WA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 05:26:54 -0400
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-37d51055097so1142199f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 02:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730453210; x=1731058010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVpakfrItOHbT9P0ZHauKO7SwRaS0boOL2PWJaMlfjw=;
 b=BMcV0GOGxOTQ5zTAH2qcE0ZNvf2XjuX3tL/hbtWH8nNuWhGrPymFZqw/QJtRtQdFKr
 d7V8n8qfYFi+aH1ccyx6qf9qm2AC+pJsDjP+DEJzb+HyYvO3jUsmYjwjdgXA/5jnckn9
 gwGu5EQwOcMh8+ptlsUNMflDDhALii1JhQMOS/T2bsYQBaaXFp9An/8NirY1xaSWB6/r
 MI+/oH33Kcp9TkA8fXZBwP3Mid7uRRtVNb9iOHZlkI15C4xOlZFcsqh+yJd4CAEtoLg0
 h1KLoJkWZhN1Dz5ZhKzum00Cj4nmACerdMivwaH8AdbaOBOzNXLtsKOCFeqfaoTPUcw8
 Xg2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaS7DxYNOQZxh/b1Se5LqJnF/w6DRfIccZjRNksWuZuUxT7D+lck3+pJJxvYZ7uboKeHOmFxt2zXyY@nongnu.org
X-Gm-Message-State: AOJu0YxKvhKD/HJ5p+rlMaQJaW9J8fCpTNjsvAqifo0q6L/LBoxUkyJx
 hmZl8tEGE8Yb2exHEKVDgLh4/o4gAYOibHnkuQhESjSWuhdxzcHz8u0BsA==
X-Google-Smtp-Source: AGHT+IEeIG1d6N6t6yAuRIEchERnolSNVW8oLh6PFXua4/GSGSJALx8ltHVM31VGAE5yMfhlMg2mEw==
X-Received: by 2002:a5d:64c5:0:b0:37d:5429:9004 with SMTP id
 ffacd0b85a97d-381c7a3a52amr1935468f8f.3.1730453209544; 
 Fri, 01 Nov 2024 02:26:49 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49c9sm4507067f8f.37.2024.11.01.02.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 02:26:49 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:26:47 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] next-kbd: convert to use qemu_input_handler_register()
Message-ID: <20241101102647.75bedfe2@tpx1>
In-Reply-To: <20241030091803.1315752-1-mark.cave-ayland@ilande.co.uk>
References: <20241030091803.1315752-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.221.51; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f51.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 30 Oct 2024 09:18:03 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
> function to use qemu_input_handler_register().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-kbd.c | 158 +++++++++++++++++++++++++++++----------------
>  1 file changed, 103 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> index bc67810f31..85ef784491 100644
> --- a/hw/m68k/next-kbd.c
> +++ b/hw/m68k/next-kbd.c
> @@ -68,7 +68,6 @@ struct NextKBDState {
>      uint16_t shift;
>  };
>  
> -static void queue_code(void *opaque, int code);
>  
>  /* lots of magic numbers here */
>  static uint32_t kbd_read_byte(void *opaque, hwaddr addr)
> @@ -166,68 +165,79 @@ static const MemoryRegionOps kbd_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -static void nextkbd_event(void *opaque, int ch)
> -{
> -    /*
> -     * Will want to set vars for caps/num lock
> -     * if (ch & 0x80) -> key release
> -     * there's also e0 escaped scancodes that might need to be handled
> -     */
> -    queue_code(opaque, ch);
> -}
> -
> -static const unsigned char next_keycodes[128] = {
> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
> +#define NEXTKDB_NO_KEY 0xff
> +
> +static const int qcode_to_nextkbd_keycode[] = {
> +    /* Make sure future additions are automatically set to NEXTKDB_NO_KEY */
> +    [0 ... 0xff]               = NEXTKDB_NO_KEY,

I think it would be better to use Q_KEY_CODE__MAX here instead of 0xff ?

> +    [Q_KEY_CODE_ESC]           = 0x49,
> +    [Q_KEY_CODE_1]             = 0x4a,
> +    [Q_KEY_CODE_2]             = 0x4b,
> +    [Q_KEY_CODE_3]             = 0x4c,
> +    [Q_KEY_CODE_4]             = 0x4d,
> +    [Q_KEY_CODE_5]             = 0x50,
> +    [Q_KEY_CODE_6]             = 0x4f,
> +    [Q_KEY_CODE_7]             = 0x4e,
> +    [Q_KEY_CODE_8]             = 0x1e,
> +    [Q_KEY_CODE_9]             = 0x1f,
> +    [Q_KEY_CODE_0]             = 0x20,
> +    [Q_KEY_CODE_MINUS]         = 0x1d,
> +    [Q_KEY_CODE_EQUAL]         = 0x1c,
> +    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
> +    [Q_KEY_CODE_TAB]           = 0x00,
> +
> +    [Q_KEY_CODE_Q]             = 0x42,
> +    [Q_KEY_CODE_W]             = 0x43,
> +    [Q_KEY_CODE_E]             = 0x44,
> +    [Q_KEY_CODE_R]             = 0x45,
> +    [Q_KEY_CODE_T]             = 0x48,
> +    [Q_KEY_CODE_Y]             = 0x47,
> +    [Q_KEY_CODE_U]             = 0x46,
> +    [Q_KEY_CODE_I]             = 0x06,
> +    [Q_KEY_CODE_O]             = 0x07,
> +    [Q_KEY_CODE_P]             = 0x08,
> +    [Q_KEY_CODE_RET]           = 0x2a,
> +    [Q_KEY_CODE_A]             = 0x39,
> +    [Q_KEY_CODE_S]             = 0x3a,
> +
> +    [Q_KEY_CODE_D]             = 0x3b,
> +    [Q_KEY_CODE_F]             = 0x3c,
> +    [Q_KEY_CODE_G]             = 0x3d,
> +    [Q_KEY_CODE_H]             = 0x40,
> +    [Q_KEY_CODE_J]             = 0x3f,
> +    [Q_KEY_CODE_K]             = 0x3e,
> +    [Q_KEY_CODE_L]             = 0x2d,
> +    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
> +    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
> +    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
> +    [Q_KEY_CODE_SHIFT]         = 0x00,
> +    [Q_KEY_CODE_BACKSLASH]     = 0x00,
> +    [Q_KEY_CODE_Z]             = 0x31,
> +    [Q_KEY_CODE_X]             = 0x32,
> +    [Q_KEY_CODE_C]             = 0x33,
> +    [Q_KEY_CODE_V]             = 0x34,
> +
> +    [Q_KEY_CODE_B]             = 0x35,
> +    [Q_KEY_CODE_N]             = 0x37,
> +    [Q_KEY_CODE_M]             = 0x36,
> +    [Q_KEY_CODE_COMMA]         = 0x2e,
> +    [Q_KEY_CODE_DOT]           = 0x2f,
> +    [Q_KEY_CODE_SLASH]         = 0x30,
> +    [Q_KEY_CODE_SHIFT_R]       = 0x00,
> +
> +    [Q_KEY_CODE_SPC]           = 0x38,
>  };
>  
> -static void queue_code(void *opaque, int code)
> +static void nextkbd_put_keycode(NextKBDState *s, int keycode)
>  {
> -    NextKBDState *s = NEXTKBD(opaque);
>      KBDQueue *q = &s->queue;
> -    int key = code & KD_KEYMASK;
> -    int release = code & 0x80;
> -    static int ext;
> -
> -    if (code == 0xE0) {
> -        ext = 1;
> -    }
> -
> -    if (code == 0x2A || code == 0x1D || code == 0x36) {
> -        if (code == 0x2A) {
> -            s->shift = KD_LSHIFT;
> -        } else if (code == 0x36) {
> -            s->shift = KD_RSHIFT;
> -            ext = 0;
> -        } else if (code == 0x1D && !ext) {
> -            s->shift = KD_LCOMM;
> -        } else if (code == 0x1D && ext) {
> -            ext = 0;
> -            s->shift = KD_RCOMM;
> -        }
> -        return;
> -    } else if (code == (0x2A | 0x80) || code == (0x1D | 0x80) ||
> -               code == (0x36 | 0x80)) {
> -        s->shift = 0;
> -        return;
> -    }
>  
>      if (q->count >= KBD_QUEUE_SIZE) {
>          return;
>      }
>  
> -    q->data[q->wptr] = next_keycodes[key] | release;
> -
> +    q->data[q->wptr] = keycode;
>      if (++q->wptr == KBD_QUEUE_SIZE) {
>          q->wptr = 0;
>      }
> @@ -241,6 +251,44 @@ static void queue_code(void *opaque, int code)
>      /* s->update_irq(s->update_arg, 1); */
>  }
>  
> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
> +{
> +    NextKBDState *s = NEXTKBD(dev);
> +    int qcode, keycode;
> +    bool key_down = evt->u.key.data->down;
> +
> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
> +        return;
> +    }
> +
> +    keycode = qcode_to_nextkbd_keycode[qcode];
> +    if (keycode == NEXTKDB_NO_KEY) {
> +        return;
> +    }
> +
> +    if (qcode == Q_KEY_CODE_SHIFT) {
> +        s->shift = key_down ? KD_LSHIFT : 0;
> +    }
> +
> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
> +        s->shift = key_down ? KD_RSHIFT : 0;
> +    }

This does not work properly when you press both shift keys together, e.g.
press the left shift key first and keep it pressed, then shortly press the
right shift key and release it, then type some letters while you still hold
down the left shift key.

I think you should rather treat the shift value like a bitfield here, e.g.:

    if (qcode == Q_KEY_CODE_SHIFT) {
        if (key_down) {
            s->shift |= KD_LSHIFT;
        } else {
            s->shift &= ~KD_LSHIFT;
        }
    }

    if (qcode == Q_KEY_CODE_SHIFT_R) {
        if (key_down) {
            s->shift |= KD_RSHIFT;
        } else {
            s->shift &= ~KD_RSHIFT;
        }
    }

 Thomas

> +    /* If key release event, create keyboard break code */
> +    if (!key_down) {
> +        keycode = keycode | 0x80;
> +    }
> +
> +    nextkbd_put_keycode(s, keycode);
> +}
> +
> +static const QemuInputHandler nextkbd_handler = {
> +    .name  = "QEMU NeXT Keyboard",
> +    .mask  = INPUT_EVENT_MASK_KEY,
> +    .event = nextkbd_event,
> +};
> +
>  static void nextkbd_reset(DeviceState *dev)
>  {
>      NextKBDState *nks = NEXTKBD(dev);
> @@ -256,7 +304,7 @@ static void nextkbd_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>  
> -    qemu_add_kbd_event_handler(nextkbd_event, s);
> +    qemu_input_handler_register(dev, &nextkbd_handler);
>  }
>  
>  static const VMStateDescription nextkbd_vmstate = {

