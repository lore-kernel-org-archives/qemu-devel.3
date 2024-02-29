Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07438C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcqV-000691-QH; Thu, 29 Feb 2024 04:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfcqT-00067U-LW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:36:53 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfcqS-0005kR-37
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:36:53 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso1025984a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709199410; x=1709804210; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MXFc/Yc0HhKQHs6RcZhG+zscJisZ2FmK16xMdrNopRs=;
 b=y6ZU7gm6mnxMhXV/TACv/6a/JkHqb3efAvtgWEmcA4XKrSIgBoIfebsJD3Hf2uq/Fp
 xaGI9XCO81sB1EUlrqIWtBNx5bHuisUypMAKHiCHeXvFpW3WNcCc3pclmfH1UkKJs70N
 2zO4O9C7MaebbJ+TIiPIXAv/6R0T/wRONmDxvQ8BUXngSrc6y1sSbN4y/UMbz167DvXW
 9DU8fDorP136gjCNDil4wRg+2kUR1yu5jvIzRT3vHr4pvflyg3Z6/kG1FBOa9mM5RsXE
 EdcBJCmkSWUqTtA3L7c9lSBY2Mt7cuMwub0naNLlX+PaOSOrgX4o+r7oydCqnZEyNMMf
 YWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709199410; x=1709804210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MXFc/Yc0HhKQHs6RcZhG+zscJisZ2FmK16xMdrNopRs=;
 b=wruqPZ1oW3nM4hoUzgNWXPf2QbenwkymGL2jc5mBp2S9UPqKJB6hI8S3N61Hn0K+a3
 BaMbcay6y8WkRpIB8Go3hCALNgsQhf1K98B4iDfBBVO6vOFM8Yk9BGncaSTX+O5FwErz
 ZkTEgWkFVukjYgfU71c/xRLQH9YEbp8eLALTVJB5TvgwHGUQkqmmGWWrxSMjVntzW9jq
 lAb1UJSDDWWioJ240PVaAw/vI1IbwR/APqOo5wyWaQsTEIzta+LmLS7VpvXs1owF4vXU
 QAfWYOkJjwpsjmArHhqNEIXmZMvQIA6U26mKeHSU1tDabTWbOXyMQTtIzZ/Tynhf9jZQ
 Aj5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPuenFCYehZfHWJZdygzw/e8o/VPpUa3C3TcUOEVTuZrZCS/14+QYDJubx1Mzuo9NmEl6kCywEhqpNDSITHKnAlCgUWnc=
X-Gm-Message-State: AOJu0YyszJp00bmunQV+M39+hdTsuZLUeMN33kLpffq9Y5nbeQTNUKE3
 hrb9Ps6ke9arDl9VhuPik8ZmffbkyFdXft3GR+DxxpLG2Amr2iI5x1sR+8ZVqwAcqtETiR4opQ5
 Jmx+D8Bf5jhuc1rsCi3S/8KN4BnVg2vw7rthIOQ==
X-Google-Smtp-Source: AGHT+IEGeIYi3LCEKJ+rQZZD+y3uPfg9gXim74wTpSZeb+QIHgxKWr9tOcVKwQ+98/UYPpCVru9YJfLP6M3T5dsUyYc=
X-Received: by 2002:a05:6402:348a:b0:564:ae07:e539 with SMTP id
 v10-20020a056402348a00b00564ae07e539mr1170233edc.25.1709199410348; Thu, 29
 Feb 2024 01:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20240228211149.1533426-1-svens@stackframe.org>
In-Reply-To: <20240228211149.1533426-1-svens@stackframe.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 09:36:38 +0000
Message-ID: <CAFEAcA-KioRCJ97dbaiSf0f5uM0=+nAb=oLbFiRg=EPGwd57sw@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add hack to prevent scsi timeouts in
 HP-UX 10.20
To: Sven Schnelle <svens@stackframe.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 21:12, Sven Schnelle <svens@stackframe.org> wrote:
>
> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
> under certain circumstances. As the SCSI controller and CPU are not
> running at the same time this loop will never finish. After some
> time, the check loop interrupts with a unexpected device disconnect.
> This works, but is slow because the kernel resets the scsi controller.
> Instead of signaling UDC, add an option 'hpux-spin-workaround' which
> emulates a INTERRUPT 2 script instruction. This instruction tells the
> kernel that the request was fulfilled. With this change, SCSI speeds
> improves significantly.
>
> The option can be enabled by adding
>
> -global lsi53c895a.hpux-spin-workaround=on
>
> to the qemu commandline.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/scsi/lsi53c895a.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d607a5f9fb..20c353f594 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -304,6 +304,7 @@ struct LSIState {
>      uint32_t adder;
>
>      uint8_t script_ram[2048 * sizeof(uint32_t)];
> +    bool hpux_spin_workaround;
>  };
>
>  #define TYPE_LSI53C810  "lsi53c810"
> @@ -1156,8 +1157,17 @@ again:
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "lsi_scsi: inf. loop with UDC masked");
>          }
> -        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
> -        lsi_disconnect(s);
> +        if (s->hpux_spin_workaround) {
> +            /*
> +             * Workaround for HP-UX 10.20: Instead of disconnecting, which
> +             * causes a long delay, emulate a INTERRUPT 2 instruction.
> +             */
> +            s->dsps = 2;
> +            lsi_script_dma_interrupt(s, LSI_DSTAT_SIR);
> +        } else {
> +            lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
> +            lsi_disconnect(s);
> +        }
>          trace_lsi_execute_script_stop();
>          reentrancy_level--;
>          return;


I see we already have a hacky workaround for other OSes
that do something similar. The ideal fix for both of these
I think would be for lsi_execute_script() to, instead of stopping,
arrange to defer executing more script instructions until
after the guest has had a chance to run a bit more.
I think setting a timer that calls lsi_resume_script() after
a while would have that effect.

-- PMM

