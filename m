Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00574C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdC7T-0000El-7M; Thu, 22 Feb 2024 11:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdC7R-0000EW-JW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:40:21 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdC7P-0001QX-Pv
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:40:21 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso8945642a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708620018; x=1709224818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3L7cq6vsvSP1LIVu1g4HAxI8xnMyiSU/yNZI5ASEn9c=;
 b=B8TIeP7LPkN5Rpz9SJU2VVNcq+NlFhTFNgjJCAHfOQ1+Rdt8OFsS37HmonckIeMwo9
 wLlpCt+zbIPNDEjMHNZIvHsS564A9MsZ8TKUmHUbdiHyrxCmbumFPBuKzbcIoW48/0Tn
 fXq5Q01DUpddei900eAHSf9B448PBBpotu1SqKVJAOouwhf3T1pm4k7c36Jc9IEMtmI4
 mhlnuQxT/jj+fPZS4IhCjVn0T3A3q5h7qVW7ljSkQjhtrdTO9aJrn2omfcBwzBhjhiKL
 +AmHlQNhVteGuhFW3bDDC75LyLx+QgaV7XQLQ3J2wzV8DKjhEpHGFLurT1/XTiegI63l
 IlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620018; x=1709224818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3L7cq6vsvSP1LIVu1g4HAxI8xnMyiSU/yNZI5ASEn9c=;
 b=V3HdfuAxl98beHsYnXePq3bmYmR3SGSCwkDofwimN8+H2vuDrDiXqTj8zogH9A1cFv
 D4/TSc8hP8uNU7+hL2fjRkoTC1FM1Rv2ii8qLaCast/KCUE9AncnrYTGl66tP78w3jXj
 HlaUDQcYJJ8QUbrGghhVOIIl2vb1S2uG1X5TnuoDWRgBvMsfN1pq5Kgo72pZCuYlVAJ9
 XHi+0MzYWbLENjsP5A+FWRZTcm/4uLpQRm6V1BEwKVXwlBpvYSRhPPDcIjLBEQhZanhO
 xBq4wdM6fP/7Ba8eXqLSarirMZpDEODRhXAuEb48p3Vtg7NNjFIwwRM0uwUAj8YlP9DC
 zpzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOyJtu2LfU9bDVrENJCDkt9pKgGl6wbkEJ7lSS49OwPVs010Ekd2ifC2lj3zgv7A0dZGZ0bfBvbXGNhc3TiXxTxJLotcY=
X-Gm-Message-State: AOJu0YzEEB3XNsWFPY6wwopAc1++z3ZmjgLsSsuwd9hSk5fLVaOn0ltV
 6rmLgVKlN3FQm4AVYLESKV34Y24CgheKQHDc2MrSmGTao5FFI4w0hI6iSZZguAT1DfVfXia/+7/
 LH4xTXdsPWxcgVDDFPszih8jlNs8Ox0N3zmoG6w==
X-Google-Smtp-Source: AGHT+IHBRGclxNU/wkb6pE0GT2qgiYiYAe/59Aav3qwwG7kyeEo/OfTanRubLWa4z0IFyc37RSOmsL/9uyUXAebGEi8=
X-Received: by 2002:aa7:d4d9:0:b0:564:4f6f:a7ff with SMTP id
 t25-20020aa7d4d9000000b005644f6fa7ffmr8850434edr.20.1708620017940; Thu, 22
 Feb 2024 08:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-1-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-1-0a17a7e534d4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:40:07 +0000
Message-ID: <CAFEAcA-K7q6u6qGu5abgSN_osPfPg=7qanrmbKb07rcAbM-aMw@mail.gmail.com>
Subject: Re: [PATCH v11 1/6] ui/cocoa: Release specific mouse buttons
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 17 Feb 2024 at 11:18, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> ui/cocoa used to release all mouse buttons when it sees
> NSEventTypeLeftMouseUp, NSEventTypeRightMouseUp, or
> NSEventTypeOtherMouseUp, but it can instead release specific one
> according to the delivered event.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 132 ++++++++++++++++++++++++++-----------------------------------
>  1 file changed, 55 insertions(+), 77 deletions(-)

This is a pain to review because it does three things at once:

(1) a no-behaviour change refactoring where various cases
that previously did 'break' now 'return true'
(2) a refactoring so mouse events are handled in a separate
method, rather than by setting the mouse_event = true bool
and handling this at the bottom of the handleEventLocked method
(3) the actual behaviour change that the comment message talks about

If this was three patches that each did one of those things,
two of them would be trivial to review and the code changes
required for 3 would be easy to find rather than buried in
with the changes for the first two.

thanks
-- PMM

