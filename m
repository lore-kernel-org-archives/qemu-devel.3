Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59B7C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDBb-0005g9-Ld; Fri, 28 Jun 2024 11:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDBa-0005fi-EX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:06:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDBY-0001EE-Je
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:06:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d044aa5beso983297a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719587206; x=1720192006; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hMmUo23z59UUFgPPnP96YGHZACAOnKlYWHEdFZZW8/E=;
 b=cKIGj5OfrZtfW9DUa+x9zuxeQKA5/8+IkNnk0ufNvg3gNnsjFNZ8bFxGeW+qPe7Ve+
 mn6ndTCyU7YZU90FNaJNUkcThvSeQYsNniWEqUelBMVvz5+OptKaQiXJXV4fgtRLFcPh
 dMh0ynWtIt9AVU8ni2Vw5hODw5E/by44td0JAy1OMklKLbE6P/zuQFtnMFrpqiD5TZz7
 zelNxiSehQx5i/RCJjw1HIBs/yKPvd1EjlxOvHgta+MXPacZmnteweNud1jGCU91Gq5B
 1LA7F2ETjQ05lOOn3Vh+pEqcBGG5IoeVY+uYn8TsHy7FokPJWb+JqElOkca2HGWjmx/7
 vdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719587206; x=1720192006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMmUo23z59UUFgPPnP96YGHZACAOnKlYWHEdFZZW8/E=;
 b=TmunEx8aVkwvHUbNMkgdvu8NaJObqUCH2e5wc1PVdqi1C8AJm7SxTV1cly05CfATpR
 eR47KbVoAMp5BbCp1ZM5fRIpce1on04IXNCoSqqNmZfP1znW247yNBDGoiakb8AEAHQu
 Vf8EvkSL5K03iowG7NrcPByUova76Ij/aSTVO1DyQQRVNBJ6Fh4cy6RHHqJilUHSt3o5
 KPfO5+iHs/lOMiTsINb1zSPgRw4epFnkEssRDxIb2nnow4EYyIf2687ioOBE7Yuwy21d
 6/6dCyjePKKYTTkl0lUwjE9u32hytY83y4q0EHRoEwLqheDUSHa7/kuQHbX4A7VBcLDY
 tWQg==
X-Gm-Message-State: AOJu0YyMnhlfS/lfNO4ttp97F+wbNRbfHBbAyYDFJ0O5PPHthDoJNcOb
 T5NArg0DZ2YCl8VQrnJFMqvPT1UyoLilQaM8eoM7Sz0No7ku8z6xPXVtJP6Tyf7HbZy2iZl7Do+
 iHCy2wJRou/LGz35B1/T5tfB+WNrNCUAvCErqM8l8xapypwTj
X-Google-Smtp-Source: AGHT+IHg/pPe+G9Ur/GWlCWS6YADrnpJDQ3Hd8Ou70Sqxm2aqPJjuXZ7nUBfxwiTU2/SSoRUjIyKYEWGQVY5rns2QSk=
X-Received: by 2002:a05:6402:1e95:b0:586:e6e3:ea18 with SMTP id
 4fb4d7f45d1cf-586e6e3eaa5mr955299a12.23.1719587206243; Fri, 28 Jun 2024
 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <LV3P220MB18680A6716082003FEC1846386CA2@LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM>
In-Reply-To: <LV3P220MB18680A6716082003FEC1846386CA2@LV3P220MB1868.NAMP220.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 16:06:34 +0100
Message-ID: <CAFEAcA-rtwr+W_hkNpQ_atfjWQJaO0+sCQdChhvrxixqRfAT5A@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Set transfer error code with no dev
To: Ryan Wendland <wendland@live.com.au>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 22 Jun 2024 at 13:57, Ryan Wendland <wendland@live.com.au> wrote:
>
> When a usb device is disconnected the transfer service functions bails
> before appropraite transfer error flags are set.

(typo: "appropriate")

> This patch sets the appropriate condition code OHCI_CC_DEVICENOTRESPONDING
> when a device is disconnected and consequently has no response on the USB bus.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2081
>
> Signed-off-by: Ryan Wendland <wendland@live.com.au>
> ---
>  hw/usb/hcd-ohci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index acd6016980..8cd25d74af 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -980,7 +980,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
>          dev = ohci_find_device(ohci, OHCI_BM(ed->flags, ED_FA));
>          if (dev == NULL) {
>              trace_usb_ohci_td_dev_error();
> -            return 1;
> +            OHCI_SET_BM(td.flags, TD_CC, OHCI_CC_DEVICENOTRESPONDING);
> +            goto exit_and_retire;
>          }
>          ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
>          if (ohci->async_td) {
> @@ -1087,6 +1088,7 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
>          ed->head |= OHCI_ED_H;
>      }
>
> +exit_and_retire:
>      /* Retire this TD */
>      ed->head &= ~OHCI_DPTR_MASK;
>      ed->head |= td.next & OHCI_DPTR_MASK;

Thanks for this patch; I have a couple of questions:

(1) Do we also need to do something similar for the call in
ohci_service_iso_td() ?

(2) The error handling path for the other way we can
set the DEVICENOTRESPONDING flag also does:
 * set done_count to 0
 * OR in OCHI_ED_H into ed->head

Do we need to do those things here ? (My guess is "yes".)

thanks
-- PMM

