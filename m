Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03384CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 11:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2TJ2-0006xm-VS; Sat, 27 Sep 2025 07:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2TIy-0006xe-SX
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 07:41:33 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2TIp-0001nj-L2
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 07:41:31 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-637dc2292cfso121471d50.3
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758973274; x=1759578074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GMKvrp0MqbLwp8F96ZDIAPIFW2PZrSbwl1gcupYPuEY=;
 b=mOe70+uU/Kl5L1VRzft7UVBdm0AzjWp8Qr/TLKEKnbHIZ80Jo3wx+zmimL0WhINHY3
 SbaVItvndMOS8qhYUxR4I/KMq2KpOLgPDhCjq5F2oup+3KoGFwWEkHStS9F9UxCKhSfF
 RZRfKoB9K0tdONAJa3ArfGH5NohCvzYnC4pPoBCdEIthMYemOiBCsS2K88FfrMGYc/Gw
 UiZid/0lnV0mAzHyQbVn0K5rTi79NJN4cFy9aIEYIoWtiMK2UYtFVEiGBDASaZvGD9wt
 YqPM3G1JVZ8dlpgMkzBLF2DNf6Y+IqHPk4RNTWV7t7eu4eaA0YBFHSXHn1eq8jZC0ftd
 DyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758973274; x=1759578074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMKvrp0MqbLwp8F96ZDIAPIFW2PZrSbwl1gcupYPuEY=;
 b=F149YH9607ypBnjIunZyg+itGqflSb2q7gN27ouNt+bRO199M06wi9BbACiGbZELdy
 iEMfTVG3CuC+rRL7XYYaZFIyxy3SwvbJYCWmtS023qMdcWpF8/o31SNIMxa1ynSGpmCY
 96NRUxL05Pnbjo7uOGw1Tw41Uq1VHrSCPLKVhBawLOsypCVz1/5+6S9JFFo9+uUvnKBg
 wx/CpHohWaGO2fybfOiKnNNqL085RMvaWmhDF/gTNqbCekRkqjEZahXv0WxK3XUNdoEd
 UsZWunBQZ2X7ilvR8SoiRXXc+R+YbzDPwfBjH2mQtFMdUaRiwDBDukjFSQ/xnukCdR7q
 kESQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW00mR8yGfUjaWRFZvnjWNou02njp8HK8TkBrPcESZgRgEU3mN2oSX5iNwbIZFM5Vi2j0XA1ExEhQGZ@nongnu.org
X-Gm-Message-State: AOJu0YzOV/4Y8LkqSq8kgHsfNZtWmY8TBIk0IZQ1tYhD8JxH7WPwXFWi
 z5d7eJ4vVOf5K2AxhbNf6QZ7kWNaKZ/wvqNsycbMHUHxr0Pbvcc/btPH38Nt/JlTBtJtnMTLtgp
 E4HMm9aIjvNaT6IyXeqy0jVHEShCx7mUohgNLEqE9BA==
X-Gm-Gg: ASbGncv2DfsEv5Pn0VgF2XudOlNDiHRJ9FGIMF/xYNJzKn3BIv3iQF8m5+8LqKs87sP
 kwZ1wRUIlFrDKJ2+9exyuX0wH+7UA1OMwT4aYMTqDOI/M9A50YmMGn42h/5qk6hIKeT91OzslmW
 zqqz6UKD87C2weIyqbTc3zM0P1gaq5EOdcINCfnYeDFEcZymXGy0ujbWmfpJBeuA1bGqfOqp7wt
 KyxY9NPMItZDwgECUY=
X-Google-Smtp-Source: AGHT+IHgv0NLn7Tgrf2/uHSVlMJQmm78eJSVA+eXtaksPZEbEoOFl9dI240mnrk9P70qf4mBOsOsZR96S6zfXFOBtTk=
X-Received: by 2002:a05:690e:150b:b0:633:a1c0:9b2e with SMTP id
 956f58d0204a3-6361a5efe8bmr12157922d50.0.1758973274187; Sat, 27 Sep 2025
 04:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250922065714.93081-1-nanliu@redhat.com>
 <CAFEAcA8pLFu6eOK5N+E97qo5PCp3OW3BRfYNSEL7=YQS6+eh2g@mail.gmail.com>
 <fcf01a1c-3503-4397-a41b-d453ca2b7df9@tls.msk.ru>
In-Reply-To: <fcf01a1c-3503-4397-a41b-d453ca2b7df9@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Sep 2025 12:41:02 +0100
X-Gm-Features: AS18NWCl2vmd8McL-LYcfVZGpcCAL51dal_IGyoTd3s7_XBml9fI0fwUz-5_N8g
Message-ID: <CAFEAcA_BR4VEsZrq1eq19E6iguk49W=Fx2OKQvkvTZ7_6Pd0KA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Correct uefi-vars-x64 device name
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: nanliu <nanliu@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, 
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Sat, 27 Sept 2025 at 09:48, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 23.09.2025 14:57, Peter Maydell wrote:
>
> > We could probably also correct the bit of the text in this file
> > that currently reads "depend on SMM emulation on x64" to either
> > say "x86" or "x86_64".
>
> This one will be a bit more than trivial :)  I for one don't know
> if this is related to any x86 or to x86_64 only.

I just mean exactly and specifically the one place in this
file which says "x64" and ought to say either "x86" or
"x86_64". To me a single word change is pretty trivial,
especially since nowhere else in our docs do we use "x64".

-- PMM

