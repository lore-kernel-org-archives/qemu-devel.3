Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77774C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDWu-0007EE-Tl; Thu, 07 Mar 2024 08:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDWo-00078w-9V
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:11:18 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDWm-0002Vv-Dy
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:11:17 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-567fbbd723cso1027496a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709817075; x=1710421875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i8O/oqpH7QUqOA1QMcdl7GzYfJcBUjyAGIWiEPVQ06A=;
 b=opzMO/mguU4NYaIlXx5cWpfafxHCYIb+3dadcNpYCYQ7HWb8UcVBYdR7C+heVN2znx
 HeZz9PPGvKjQkwiABCss1Dj4/SLLGb74QLiZkE+KvRFAD87hhyQFx+LZMh1oMSP2YSCH
 nPBY7iL7CRqs+5y0jcZNuq3tEuMDWOLDF0KoDz1BnKlAwYMajfg14KQOphHrCHEDTzE+
 WX641xmxpUx6D1xENBcH3dT+m2dIxM6f/3zfhUoKLCHMC5xRuJ6xJ1Bb1HnQ3ex/GnUy
 ZiZppFmG95ledgSePaVmWMhguTM6qH1ziTsPn/0qUE/hs8O6ylP/qiSfAS666xOUphEO
 aZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709817075; x=1710421875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8O/oqpH7QUqOA1QMcdl7GzYfJcBUjyAGIWiEPVQ06A=;
 b=NGuCPZMV3aXC2esQM09pqs6GjYEF2PT8CKRJcR3s5OQPIRiGeZE9aBF7WVo8LfUE8s
 GOJ2o2vxhAsHUWRQwudeXTxpAZyHvp5SRNlPhak18a0a+KLGrJahAf+CtNIfa6JZJdTu
 F0lyCL3Aso/8Z1iShvBiWdMbnreOWrfVhiv2wjw1NlzNh3HOmt/qIJv3/fRxXTxQqPPP
 4ZzVv5S7IxKQ52eUW0VHH3U0obMFcgkmrS8S09Di6uFuIUYGnoYZz8evDDw1XC4PaIbO
 Kllnm0LbGD7QaPywE/yKugVZolqj8FqJcC7NOm42C3+sJCywGL3P9wXRMM6FqZxJ9X2i
 vUCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8wLQcwpMiQgYhLgmt8lU8K+SW2x4ZD6205LGKSPdD9hR2qif+eLwQuJNuvm9/1uCO1beNiT2c5dB3/TDQjbdL5WydPeY=
X-Gm-Message-State: AOJu0YxYElnHVX5DFkT3GMHTXonrpZK3G+eqyq51fOomxI73dnBRK3W4
 Yg9W3fiLpRR5CIFXL25qyvW5cMMN+AXYAgMAnwT1GKjoM53xpXgA+Jcv4n0bTpEmXUpwX83KIA5
 3ER5anrPjqSZzqqmcCOd0JUlHoXaPCXpNpkohNQ==
X-Google-Smtp-Source: AGHT+IEx7dBCUWgiYyrkZAOjsmXl+AB3PYMd0fZbHCfRA8JdSfeVlLH3jhTAifyrji+Jqsj2iMfIvFf+xLDs0KVTtE8=
X-Received: by 2002:a50:9f43:0:b0:568:186a:bc65 with SMTP id
 b61-20020a509f43000000b00568186abc65mr1196198edf.36.1709817074830; Thu, 07
 Mar 2024 05:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-8-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-8-4f324ad4d99d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 13:11:04 +0000
Message-ID: <CAFEAcA9=j0V5e9rMdmFfAYgby4qJEPEGf+RXh+3SyxUkJ75P7w@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] contrib/elf2dmp: Fix error reporting style in
 qemu_elf.c
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 7 Mar 2024 at 10:21, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> include/qapi/error.h says:
> > We recommend
> > * bool-valued functions return true on success / false on failure,
> > ...
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

