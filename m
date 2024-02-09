Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A996C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYP3x-0008RO-OC; Fri, 09 Feb 2024 06:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP3p-0008NC-Qh
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:28:50 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP3m-0005c3-Ss
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:28:48 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5610c233b95so981075a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478124; x=1708082924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAnjnts3vUcMA6kS7zf+h8jJ1lrsBEV8I38sAazGz1w=;
 b=FC/vonusAYEpHJ1M4hMm0CEQW6i+bIB+0DvaROft4AbR1SUJblb2T4IYQvsn3QoLza
 IflPC7Z0H04PZ/DWjJ7j+S5JLlurtl7KWM82wf63F4p9F1IHSFJ3gGOw9UYJtv1oK4Zq
 oQmOtcA1HHGTCUzVaUjGOgacqJKGmtlNyKwk0dfEiTum1vaax8Dc/DsG/Onx2z41XCV2
 bhlePHyqaN5kjbYDUun4feWqIspD8d+IEqzU2jtO6KgQL7gZz+pBW2jKweAAaQwchor1
 whCLjXvp8QESXdKp7nSLKQS+GdFi+a6UKNrtRtV/1oZof/wWx05VncktXwyy9VQBuTY1
 ts7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478124; x=1708082924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAnjnts3vUcMA6kS7zf+h8jJ1lrsBEV8I38sAazGz1w=;
 b=Ey58A5NCEVc3rhGPm2cEPWLP3rGgDRl8U9JVkjixNHzu87A3KnbS8j1r7mapFY7uBs
 XHRTm4wsSYklDbx3GYSgcsXW3DebpGLGY/y/6X0kxS3XJ5c+iPojCk+RdEbhtg3BCrQj
 Iga+jcqRcR5dlZStrsaBYc+8HVQpT7EwN4k1CUTb+XlFE/WI552/nMbpgb72BITldV15
 EgKO/o96720/fZvB3TrOFS59Py5PUNG7m5s2cH68iQoWe3PqhdiOfsNSP9b6vqzYeRDr
 URwoXNcxFgeD8wHI6OqgtcxHeWUaMZO25oX46eX0mL3jTGj7qME1F2gUxui3OTCUM0qP
 LsYQ==
X-Gm-Message-State: AOJu0YxbJyu1TdRlIJhg1FjEJeZySAfnI9ZLyUN/zofsmWUEkXx7WNfV
 FNy2LIV/KSR6qVbSbmRDUJ85aYZJ3Smetb84Fl8bx533KqNjf/sQv7tzzyDPsZvzB5iG9bn8E6y
 eq6I5fgYmh1jdjgtKfuAgI2SBz+HCaEjueXdEgA==
X-Google-Smtp-Source: AGHT+IHKrl21jK9CqaG/bbAq0Mi38FDcFsnNffODP3CsnMJK7EcDR3kwyoKCf6TXEXOd6Re5cBpZCTQj4hz6dmuZWqE=
X-Received: by 2002:aa7:d957:0:b0:560:590:10b9 with SMTP id
 l23-20020aa7d957000000b00560059010b9mr1133516eds.2.1707478124041; Fri, 09 Feb
 2024 03:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-3-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:28:33 +0000
Message-ID: <CAFEAcA9jp_B3BY03BT4qFqgAfreG9s=yjLahOGm_g=5gDrRAYQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 8 Feb 2024 at 18:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> "qemu/units.h" is not used in the "hw/rx/rx62n.h"
> header, include it in the source where it is.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

