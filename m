Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58821C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSTh-0006hg-I6; Mon, 29 Jul 2024 11:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSTf-0006VW-MN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:39:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSTe-0003d4-4n
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:39:59 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so5614855a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722267595; x=1722872395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAdGHqsVAshOCFETQ2/r5quQ4ndeF0viqEh+dfcB/T8=;
 b=ClZ85Ej2AG+AVf+rgLSPPk85sGEPnUEDpHRqlCUvH+RFbKVJdyoFL1YdHMZqUFI2hg
 tiPbGXzu7ThGgl0N+oGIFg44C/hq6CvcZ1Of4Auv0UiBNPobsZOYDpdeSwhdukDSsL9D
 9xQMPyaPV0159yB7z8Gr8pBwlPQvmOfI3ZYpsiOypHSMYyH36q8rl6HoGc/othhoWMaA
 DzbtfrWddJiQ6xrUfBQ9Wdk78sBMyLjWFmGBjYT/D1lZULTFTtOhza2V0ZFhmZkV6qjP
 AVt88ynZkq/jVpptE6f3hqFtR+dEfuDK3qLFXn4JJbUsIRNQw2Wt4IG5BPaRB4Qh2YgP
 9P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722267595; x=1722872395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAdGHqsVAshOCFETQ2/r5quQ4ndeF0viqEh+dfcB/T8=;
 b=G/0fhJFQFoEthuvW3stzIieuiCjBqYSNi/MpFGWHLKY8jOEP/WUlPCUdLY4Gc54Ilf
 9tlfbW8bMQnI4JU0GEsXx9aeN7g6FZKiLgr+BoPCDIwislsy5d4HJIA16ZWgis+cDeRH
 0g7hNLrqPvGOlcU84Tf40DAG0p0KLeQxiyU/iDIoECCQVlSPMcTxnUBoRvk/F3PZQ/1M
 MiiXDa1VAtSi2YknvB55gWms27XjX2iPUMo/5a+YtF4wb4nqTixi0A11R/GS6uYKoabu
 wfuthQ2iblSOp/vBEWCwsfK0LwRfpcBCJOo8/tajB/lSD3A3VbnCaq6wrQYkfu9Sb6Fk
 G6mg==
X-Gm-Message-State: AOJu0YxLFolkguUsitZM9tm8TUwhuJbetX68iVE0FUG7V3Y7uBKl7Vkx
 b1YDOZZ8+rGWyCU2CwwH0yz0uwORXMFj5p9IuCjRBNRvhYu2sMDUTRKcmQFSTv9JFJ0CiYjoc0i
 vRwvZoE9swbzKuGKz/a2ezaoEgQwKAUBNdSqyuw==
X-Google-Smtp-Source: AGHT+IGwgXYkNsLNgKY+zkoJbWl72pV5+RaeWhw0/2JcieMLWzPORdWnn77Du4KpKhFYDsy0GwtM1lZAt0CH0Xfk/jc=
X-Received: by 2002:a50:d7c5:0:b0:5a2:1f7b:dffa with SMTP id
 4fb4d7f45d1cf-5b020101f53mr5057488a12.3.1722267595584; Mon, 29 Jul 2024
 08:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-4-philmd@linaro.org>
In-Reply-To: <20240719181041.49545-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:39:44 +0100
Message-ID: <CAFEAcA_95CjgS89OJynBwqv7=dNCNip_YuAKq5YWG=tPp4hLgw@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] hw/char/pl011: Move pl011_put_fifo() earlier
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 19 Jul 2024 at 19:11, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Avoid forward-declaring pl011_put_fifo() by moving it earlier.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

