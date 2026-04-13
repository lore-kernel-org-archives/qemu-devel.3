Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0B7F34C55
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHwU-0001hy-BU; Mon, 13 Apr 2026 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCHwT-0001hp-DE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:07:09 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCHwS-0006b9-07
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:07:09 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6501418152cso3978383d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 07:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089226; cv=none;
 d=google.com; s=arc-20240605;
 b=i19GGv/zs56lptdmiT1Q4HmWFh4mubI3fIQoOlRLrxX1gbVWv9m6ZlEOlTl6X1gI5b
 AMwy93gEm+HAFzB2WVnJLXtlc55Etc6X6v5BFmWNPRLz1m/zKnXTgwIDsMfR/NPm/PqI
 Li2Jax6LDCZGrrIoNoE47JByN46aor9YWrFoYGWJ2EJwGRakc47Cr45ZzBBVv5CZKdQw
 rvyX+WcoRFDycBwwIwsRgjfFCkDRW4QOXLgI2br370Cgi8++cPfm3k3haJD3bChTaaHN
 Ie+Tnm3CbEe2BQST9fA1pWGfthpGniMErMm9ZNCSPARAUGEipfUUPviO4c5iXQkDR0yo
 cByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XFXf2FhVtHaWPnl8wOCiV9KxNjWSg+uowlhv+eTkq7Y=;
 fh=B178DGCcQA/M53qC5kSjXVIFHa+J5JaXR8jKWiGV6rw=;
 b=dqh6aUl5ggru7H4QfHDE6OQ9qY6NCBg1CqhYMhLFU4bVUkNAl5IodPbNUhEI/aRUKL
 Dr64ldlBZoBKX+vmq4pH9b1M9JgDf09lBg4G3xu2sDWxoeZ5+2J+3vCuw00dFgrpQU+C
 MxJ9PlYPHI4KWnSKHg4DSJSKxDY/2aNH/k2fX61bhamef/pT2SuLLrB82WThbHUez5IX
 E3n8i4UAu4Wu7agsqs2cwBwBVC0wwiur+Tgt1H8UMczcJgUwksPCki+DqMYiIOrIjgmV
 ioRE9MEgBWZubh4KC0KvZqdtaTmKsl6mTQMqBWnLgAAOo4DhPApqYdO0Xrr6ZnAK1uaf
 6crw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776089226; x=1776694026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XFXf2FhVtHaWPnl8wOCiV9KxNjWSg+uowlhv+eTkq7Y=;
 b=dfZfRDR125PD9KbHgqKCMIlTDIMY8FZpuzHCZXAMoVOv8jjWRvrZDgNbTniHQRcGEu
 iS365N4LhKxhOxYJuwlIVsoAUT1ZMNloAAiwV6S6jewTaFKblse3rjB9x83wI/aC+qqy
 cfFIwYyhNS08lwcSnzp8+6/74kjRxwNwrZoEMTk5ZEGxh72ggsSOu1ZqDc64vHZn8N3+
 xohTAO/AdBvnd4EjEZ901POQh8P3f6hjutsIjLpiut8gfEuSV89omXPoYnOv2DaEqrO4
 PNSutwelwL/bWCnaZaaqbG8/xALogZD8wgTd1jadvFSKVX6oqey+veWb7zGdfZiVAqel
 yy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089226; x=1776694026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFXf2FhVtHaWPnl8wOCiV9KxNjWSg+uowlhv+eTkq7Y=;
 b=dPETXwp9kJrpuNCenAVM/1w2vqDNtjy3CclVoUYBuE8DklKhwS2MDfJb3GTSSp/ncS
 liQDdja2vABk66lYGyEvAkCfvSIs1WsqKBNecgIgVwr8Ca2TjygazW5nlAYJpU2TcZex
 +sq2AP43na0hhapaQFMXk0WO8yETYj/IB5Oyp4BcCod0mSGp9ANcPmqeaxV4nGHwoszk
 /afdtzypUJUu+cBIoT6nKmb0gcJ/Zd4DLJ0KIiGwr2MD4wEvi+P2UX4bnkLQs3HOaikz
 9Ua+RrQRn7Dsd0yV4nkucGMm1KHQfsn5P0hFg8eUBlKsuxWttyqHommHZCgDEKn1uGqb
 AAcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cx+F1UNTKTZ7HtkWapMufMnJCEj4ppW9AtcswA7bk4mrk4YMgbV4CTi/AAK5fMSsxJo3v/rinSwyf@nongnu.org
X-Gm-Message-State: AOJu0YziH5bKRmP8vST6+Do66pUniWuzmZPlE0hXSMieQpIRG1ANjvIL
 P+7Qot5jReFlIA7xpTJt9wRG9jWIY0j0M/lQ9uYk4qDe7B4drbvxp+Hy60UQYSwW0dGMS0bMaec
 8zfnCZ3MrB/EF+eF9d+tXV89EkVul4tsQvp6QsjAsYA==
X-Gm-Gg: AeBDievB5O7pJSK7tn2c83adPSDLadUzN5tnbjV5y7TFFsm/lnaH1tKKtrjilVW8Vki
 jMdBhr3tFO6TtsuN0B17+yPz3FbaENJLdeJsNki9YUAH3DpUCaOrAECjHaS5vdF/rQqajYPTaWJ
 hze9Qpx76Yti1DfhO6kERR6tCWsXefchGpLNoy0V3aHPFGKUb1An8WXKMN8yHGydLjo76XaXrbb
 cYIM2DOlOi+rTWxvVOnT6YVcsZhxI3D3UBXya1e4XKqzIY+9nrzV8auZRPOgt+7ZLnv5coHAcq7
 14NjBouMqYZLXa1S8o1qdBYShh1nuoS2JyN6GYnrZfM8hfCFhsg7/Yb1O+965D9muWg=
X-Received: by 2002:a53:d246:0:b0:64a:f3fa:af4a with SMTP id
 956f58d0204a3-65198a395ccmr9854933d50.5.1776089226013; Mon, 13 Apr 2026
 07:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
 <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
 <CAFEAcA-dTkoKs0tgF+VV0PayFbDcmH_t64P6AOT18ShwEKTW_g@mail.gmail.com>
 <adyZm41cp_nZHPYj@sirius.home.kraxel.org>
 <CAFEAcA-pZCrti_==m2u-Kq55dmqBcs8S=Ztns8moBxSe2fV+ug@mail.gmail.com>
 <adzucwBFU3u1HWnm@sirius.home.kraxel.org>
In-Reply-To: <adzucwBFU3u1HWnm@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 15:06:54 +0100
X-Gm-Features: AQROBzA5uKN3vnFalUKhTZJeNzYEHjIjYnSl5TipUQYPhru3tXHuRYQdvKaIVPE
Message-ID: <CAFEAcA8sdXNSsMHyepvqK1m6BzgzYzfZYCOL23TOdAG3gk1UCA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>, 
 qemu-devel@nongnu.org, Oliver Steffen <osteffen@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 13 Apr 2026 at 15:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > I'd very much prefer to use device tree.  A device property is maybe
> > > not the best choice.  There is this /chosen node though which is
> > > already used to pass around guest configuration information (kernel
> > > command line for example).  Maybe we can add properties there?
> >
> > Sure, if you can get consensus on a device tree binding for
> > it and get that documented in the kernel's Documentation/devicetree
> > then we can implement something.
>
> Documentation/devicetree/usage-model.rst (which documents 'bootargs' +
> 'initrd-*' properties in '/chosen' too) says:
>
>    The chosen node may also optionally contain an arbitrary number
>    of additional properties for platform-specific configuration data.
>
> > But fw-cfg seems to me to be a much better fit, and it has
> > the advantage that it requires no changes to QEMU at all.
>
> On the firmware side fdt is easier because that needs to be parsed
> anyway to find the serial ports, and the firmware also checks
> whenever stdout-path exists in /chosen.
>
> Adding a -chosen name=${property},string=${value} command line arg
> to qemu should not be too much of a problem, no?

But we already have a mechanism for telling the firmware
config information. I don't really want to implement a second
one just because it would be easier for you to not use the
one we already implement.

-- PMM

