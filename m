Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04276D16275
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Ltu-00024Y-Lb; Mon, 14 Oct 2024 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Ltp-000240-Lf
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:18:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Ltn-0000oS-Qg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:18:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so7268103a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728915494; x=1729520294; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8lpZS89dbV6Rm2YfqOiFZtdzz1XdHaAYDs6QXhGZ2E=;
 b=fGN5UL1IdLkZYV1rkZHSnNCGQp5/euuPFBVKdPN9JNxLuwGUhmzcpI/04EqKuakQer
 h/q3BhXVB6q8ffB20i7h8Gvyejqg6TuFj+Igf3Hvy3/QFD6jczm4kX2WHWzBQezvYUvl
 Wzadysm8Kr3UyAMjC0HKoZozwD9x7OY26Q76ALV7UOR42Uaa2cgdEI1SxY+/b3b7HcNa
 Mp5Bj24aoWHq6QPLO/ioZ0tsxQm6Sdlux1phSAqBUg+qfCO4AczLiW4v/xLuedI59ORk
 wdPoDIdQgLuLEzjAlEmuF1cQTz/6aqfXwwYCkQY8a5mCKlpANqD0QwdDGThhd/9/eumg
 mWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728915494; x=1729520294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y8lpZS89dbV6Rm2YfqOiFZtdzz1XdHaAYDs6QXhGZ2E=;
 b=h+osZRAZrcgyDcBv75kDr5h6hxS32XRNYmd4apiWd2jc2+QbVBAujDypqHdfeY2vO4
 YjZQxaUBoxkKBgQq3AXujYae69xpzGrSWn5wQpf6cxsO8oVD+OFI5fhzKFh6HWnwm51i
 GuUZoQDdbsKcIJpAsMRo20sg3y766ztwP2SIdDEAeULIM7ELRzcofaXnFnYBTBgo/gRa
 NZaJxV8kWcfl9OyK6KyrKelvlY2pxsquqSWlbtPnHi1AuYoY0PqMhsBX03tW3NWgMfn3
 h7K1JgfuZlu9AxdCCbJW921Aku8tg8c9TlBokskLboG7pudSc+IcwkteSYPLwnD7ABRg
 2QLg==
X-Gm-Message-State: AOJu0YzAy0zL7/CDVdw4UgbWhHUrBxxQwVRVdrTR921tuv66HGx6pZOI
 lYP1JUUUvUa0cNY9PHCspEoZYmN2Bybst6BCN8fhsD0C8AGXMFiO41QffyLM1TayICPpS2pLoK6
 AoWNN6AuV/G5QdIbBu6zsgBZUn8XR6tEY+1WXgw==
X-Google-Smtp-Source: AGHT+IExVm2Z9bZ9gyi0jgfslqxLfBCzzzUpVp6F5kMftLkv3tSL01l0x7oXuVh7xbKqH/dccg+99/tPzQ2W2EwPskM=
X-Received: by 2002:a05:6402:434b:b0:5c9:4548:eb32 with SMTP id
 4fb4d7f45d1cf-5c94548ec76mr11302975a12.3.1728915493815; Mon, 14 Oct 2024
 07:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728232526.git.balaton@eik.bme.hu>
 <0f5949d8ece522e30f990d25981f79965bf05bbf.1728232526.git.balaton@eik.bme.hu>
In-Reply-To: <0f5949d8ece522e30f990d25981f79965bf05bbf.1728232526.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 15:18:02 +0100
Message-ID: <CAFEAcA_1ejDprH6H=EPoP59jweUkuaZR_mcuNhhGFmDiQBNKMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] log: Suggest using -d guest_error,memaccess instead
 of guest_errors
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 6 Oct 2024 at 17:49, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Rename guest_errors to guest_error to match the log constant

I don't think this is a good reason to change the user-facing
behaviour. Also, I don't think the existing names are so bad:

 -d guest_errors
   this is plural because we are asking to log all guest errors
 qemu_log_mask(LOG_GUEST_ERROR, ...)
   this is singular because we are logging a single error here.

If we do want to change things for consistency, we should decide
on what the user-facing option name ought to be (and I think
plural is fine), and then change the internal define to match
that, not vice versa.

> and print
> a warning for -d guest_errors to remind using guest_error,memaccess
> instead but preserve previous behaviour for convenience.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

thanks
-- PMM

