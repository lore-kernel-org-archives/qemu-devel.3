Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D2EC0480
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMQ0-0002ec-BI; Tue, 03 Mar 2026 04:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMPv-0002dp-GQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:51:52 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMPr-00018R-HX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:51:50 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so5181092d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:51:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531506; cv=none;
 d=google.com; s=arc-20240605;
 b=Qzj1zvA7cbr6vW6zUWqOObkQg5fgRDKU7KfYbm2x8u6Z+DGeZEWrhnEjUeKRUrciko
 7YREWv8tx1PBzpFq1cDJvThgbWzA14BNKODgIS3mpnxc0uovcUDdUl9TtRyXpZlrvcry
 Fbp2hmiVTC+FBL+OH959l22qw25r5XaKMlpPP1TeUYwOncJD7Q/qp//VGMmmYwy60X+e
 NlxSly7QvZAfGg3HA4NErxR8hNfbvJ0cqXxF0eZn2L1DBL+TmDbCks7tnwjLzWvDYOpl
 A1gP9lx6P1H+2SdD2zf4+7koL1enmbu4Yry9wG6RGzwhAcBKyRpXbEp7aDdYkvOS+P0b
 sv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F7xqTP17SS14XOE8tGEW73G1PeKHZQGpDhV/aZTCqkI=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=IM83FzOmjjThNnR22Dc9O4czsgwqhan58Wpat6tGjlMGJ7kz73IxBBKwgijn7qSsu2
 OugfUdI666LDDkY9BIQx49g4iNNQjgdz2RXEmf4tkBXi/HlfHfFUEpSFkaA5zuKiafmx
 i9uIQ8sHg4dmFR8io9FzUSjuDC5gbVQLg4hDJf21IXY9pgUE3mZKi7Xf4OtamajfwC78
 uc0pP/x16Vph0teMD3wMMr8N5UREbIt07LggmmSZTloN4uIbFKe/DcBpE1OmcciTrfBV
 QFLxEjvqjfB1vqOjw6RfAVnn2bYWt6ql9lKHEum/w9by1i95t0Iu+hWGQiTU1usQ56Mw
 JbUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531506; x=1773136306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F7xqTP17SS14XOE8tGEW73G1PeKHZQGpDhV/aZTCqkI=;
 b=Udn2HQ2gsm3hzkCVql+fS6JARgAe1CV3BmOUUZH811AGqKjPPuBmBxkmYTliwk2uou
 WF49IyLgbTnqCnQEalGSmMr+ClcuYKtlq2TYhNqaE+xsMzJlj5hr1VAa3MYN+gXtShVs
 8PsL+i1nqLNn+/8hiU75QQln08GRrz2+dhTQwGQWqbIrga01iTMSLpDN2w5tURPjiahZ
 rrWwTArQ5C+J0g9Z8Io6mkOXAIRi2fQLh6OhEA9nY2wUYC/FVwODgF5gBbNIkwEdG3Th
 CxY1ct6XYPlloww6M5wabGulec6hrJbSerWZ+uF+KqEFn7h+xWjn3a70UcsCjgW/T7+B
 1CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531506; x=1773136306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7xqTP17SS14XOE8tGEW73G1PeKHZQGpDhV/aZTCqkI=;
 b=mRV80vxdNa0i+NUpijpkABJpNAAmZv/DLgmEQ2xIYBXMJnQ2nok3awXBQcjzW7PlLw
 0s2uj+3ITKysWVceZrvAOukir1xSJtJEt9+cxFMHD4WKKpeuxARt2v9UIOo5DpWPq+Q6
 cDFLRzy24y7JyScCdH3Qryg1wygQ7/l42y3C8VCyVfiEVqTfU/zkdWRsEy/gMwdLEBNy
 p5xNNxlD+L6vks7iQjjKUSaRutdACtp2SGiN39R22DMG1MQvNnNu10JQmMceYUHVDcv1
 MInvpXSaxarbahcM4LflhhZMGgEQ4+P6uIvxtF16B3HkcV3q6itlVeO72Zmf2EDw4D12
 TKMA==
X-Gm-Message-State: AOJu0YySZSD+MTnmQB+8xmqjghnyZeuCB7e2gI01tm8iS9PT271EfK3Z
 zMDuQT3HeTO7SXTXwByIcYrwvKwe1euRXs+uu2dRNin+z+PkxhLFs+a380Yx+xsVUhZQXn/wX1b
 AINFMCzdABIF23IOYVLnSjLmLDKfIw59HvC5AeGnaUQ==
X-Gm-Gg: ATEYQzzJd3ojuBx+9TsoWHuLjBdoCeyV3/yKqp4uKxySxWxklznpkrzgFpCm5x6T1y0
 2FoUMp3AV5T6hG6CkS8gY+eAoVg7NUzs2Eh+G7sDExUf2qPF89FP1eVaYIZ6FU55uR5Wd8uhye+
 OVwCoJzwWOoF5WBVEuWdFEQhfTKXXY82Kw6fYVFnwJKFCEUuL+GVOHXMaoxGn1LnfkJRkSPsass
 sEGbXFhxWehhX4Ab4dZaLoHyZrRLLTQ6iKczISOJnu5cZvBTsxXCOHAvPnBKgPDNKQIQzp6kFpm
 TLzIUT7dPVSK4hdlduO1mNkKWB+QY6H7WARTWJRLcBqEuZYaIHKgsoqUFE/OT0mnmos=
X-Received: by 2002:a05:690e:259b:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-64cc204a0b6mr8744302d50.7.1772531506101; Tue, 03 Mar 2026
 01:51:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <816075b4a7fe7d4234744b7bd29c03139e4c2f38.1772397447.git.balaton@eik.bme.hu>
In-Reply-To: <816075b4a7fe7d4234744b7bd29c03139e4c2f38.1772397447.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:51:34 +0000
X-Gm-Features: AaiRm52_9YIXMYBndJmhY-xcyfMgSybKD0Xo6W77SVrZHrw7r-tlhYuBdB22cCY
Message-ID: <CAFEAcA9tiLag6NHMajPH=caqECRw7DT5vmtX4EraTG8Xp5re3w@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Sun, 1 Mar 2026 at 21:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Use memory_region_init_rom() instead which is what other devices do.
> This is breaks migration but these devices are only used on sparc Sun
> machines which have no migration compatibility guarantee.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/cg3.c | 5 ++---
>  hw/display/tcx.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I think the compat break on these machines is worth it
to make progress on the cleanup of these functions.


thanks
-- PMM

