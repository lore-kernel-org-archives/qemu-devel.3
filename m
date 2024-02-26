Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED30C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redmD-0002ov-Jj; Mon, 26 Feb 2024 11:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redm6-0002i3-UW
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:24:19 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redm5-0001FA-Dx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:24:18 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5645960cd56so3739583a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964654; x=1709569454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c/oiTfEwM5McMAoWskm7g0oVmrOwqKEpr0Em5Yj4GeM=;
 b=smZ/EbOGR/Ro56nNfRZTQ1F8fowNaz+45ovYbzFV11pIohaTF6s8H1m5CA0WL3bxqi
 daXGSXz7hrigliKPqFQA1WCVR3FK21+dPVRVW7aweztDEtBWxEPJX9mV8vVFDzUsGlRx
 MPpeoy0fEpUGYkyr5t9mfEUEwOxuUtoSsYGoae8F2kB0gIoXvNLglPKimZi7Q12GmFxi
 +Uxg6KDuY1iKPcRxG6pXk5KA9/YfcI965OX9j+GWuFGAb0Nu7/zFTXJlXsiMEoVBBCth
 7KmcoZVw/d32UFWPZ3OHpCpV9jMsmZib2Xz/yWyPYKDAJ2CaGYlOn59+CP4G/yAY6ij3
 SqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964654; x=1709569454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c/oiTfEwM5McMAoWskm7g0oVmrOwqKEpr0Em5Yj4GeM=;
 b=NDaiqMeXTpwpKhJqA+9kMpUZtRj7hdcV4vpGvU1J8SMRkOARX4gifl/8KrYWbmS22w
 ykg6o1P4ItASy0aL6PRqj6CyxWXRiD50am4ZYqlRZKvDDv9Cx2C7S6c3PuiMiJiC0IbT
 CNrf5FlGNdVN+VKaw4wENhUZ13lpsNxSJXdXH49YiudvW+pZEW8b1++wrrUZdltKhhsD
 EqEp1Clu1VF1vezYFNeXemH0Hu04omEboflxUdH8CDTqhug6yoMrpFAHiX7JCtwQgTaR
 qWbYzaO/+2pnU3qWfmdzflkOeC3O/8f1+MPIyl2OUxaR1Opfa4a88XNMHaX+QB+SEXKY
 NPUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ3lmHnVvDZ8cLYU7Vaj5RmYvJX4shUgY6s5Bmjv0KZEI9EpwRGzR7ljSij6uX3Z8CZ5jCDqQOEMw+wX0V+iwptKLR35M=
X-Gm-Message-State: AOJu0YyZWzaUtks8Hi+i/Fu42Qr1ClMxCQVemTm+c4lsfxd8fGDYGqZg
 rvxhu2OFGmLtHue1UHdyyiunkGhnYabkYrGU8Gko41i26cDMGRgGm7p/cog4Kxn6NUQ3CZdbF+O
 gR1iNJQacs+cmiTaE4y4ySMkWdFsTLUgfcztEFg==
X-Google-Smtp-Source: AGHT+IENjMO1AlQMwen1BHoHLzfPrpxbGH77KcOq72OIxc0s/9DgpGCaOf6ax0Pd5yLBIXD8BxTgKzDHDgsjA5/nniw=
X-Received: by 2002:aa7:d799:0:b0:565:f7b8:6f4f with SMTP id
 s25-20020aa7d799000000b00565f7b86f4fmr1783437edq.2.1708964654319; Mon, 26 Feb
 2024 08:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-36-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-36-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:24:03 +0000
Message-ID: <CAFEAcA_7Z=_aHbTby=z0K8mw3YixX4VhKNeFbVMwsy0+WQwaVw@mail.gmail.com>
Subject: Re: [PATCH v6 35/41] Add mailbox tests tags. Part 3
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:08, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.h | 78 +++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

