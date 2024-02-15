Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F144C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racSx-0000C1-7y; Thu, 15 Feb 2024 09:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1racSv-00009p-Km
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:11:53 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1racSt-0006iT-54
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:11:53 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563c2b2bddbso459987a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006309; x=1708611109; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0u+e37cggCORrx6LlAXbJ+0LxvkIGLaj9c5/4Ego+Q=;
 b=JfRESuF5alJeIDjQD7RxFgbCHJcdES1/bGXHN103H95xRpOPd65+A6+tWmk68uvvc4
 N55PzO0+m3QJj4ZB+9YvO+1DX0OJ3FqoTzQ+ZM1y+OlNnDmfhn34mpEM2sWKu6nCpRld
 xdHzyHIPBzb7EpIIpYZirZq+zYZAgTwY40DIa1rsiXiqn80BhFHnCYLUiy4/IVcZpVHN
 hyUqOLuYYe4unFWLQl+zoZBd7LvtIPBwWxA3XKJAqyCueinBAdIfb+IlrbLpsAsuw1uW
 emddo6rSVADyAZbvcLTPwX0cIxBJMI5VhR79IwMsnWp4EDDE/Sol7WFirD/18F/VDAaZ
 IVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006309; x=1708611109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0u+e37cggCORrx6LlAXbJ+0LxvkIGLaj9c5/4Ego+Q=;
 b=ZKxkxYcFUEjK+aTvADGWoQvntYQ6LloStCsokvyrLUMsyuDf91bRLhA6WVlpo5Zjp5
 o4MFuwoAF3G+QAkIRNrtwbgzfieiVzyFzKg9a7GiSHBVVwBhO05kZ8pEkSMCWMz1ApU+
 SF9J4aKQlsx68LIAvA/u5JDc5yg6M4cghfRyShGqRHxElzIFaUaSYmHhXL9GeuZxVcqP
 hWThuGjM5OHLKrA4moLrk2vu8+nhbfjIZsETqEDtW+5op2VdKao6sKVaSRC//pTVdSan
 B9dVmAFE+IKqmOCpL3GVPHCQr3lUrgg66qlTcaGh0tdGNmV5GTBGXt28UKJC3D14IxOB
 EAsQ==
X-Gm-Message-State: AOJu0Yx20BtGBMtsO1ieT9uU9xlR00M6X021w5ELUo/M65gHt7Ex8OEl
 vlegVGxosFpcJ5J/GLLvFq2OT5d47zWSsOBbdIzLeqjT6LwQX+Y/vAHB73R5pbRXg4/+wm0s+hO
 HZ6ecjju0syBizxxOhm+L58uAtvr59+YHN9bG2w==
X-Google-Smtp-Source: AGHT+IFjaxAhDTvbxLGMy7MtefUiiLBCzbjIDPoVqlXXjU8OazVLrj+t9Icvwn0shvrbgbn6PuP8JzumWcqqF/ABThM=
X-Received: by 2002:aa7:c90e:0:b0:561:199a:3304 with SMTP id
 b14-20020aa7c90e000000b00561199a3304mr1307197edt.39.1708006309531; Thu, 15
 Feb 2024 06:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20240215132824.67363-1-philmd@linaro.org>
 <20240215132824.67363-2-philmd@linaro.org>
In-Reply-To: <20240215132824.67363-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 14:11:38 +0000
Message-ID: <CAFEAcA-m3d2HSi3NU6V4hfZ-jw=3Mnj-3Hv_1sSr+FhXR_DpAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/sparc/leon3: Remove unused 'env' argument of
 write_bootloader()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-trivial@nongnu.org, 
 Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 15 Feb 2024 at 13:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> 'CPUSPARCState *env' argument is unused, remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/leon3.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

