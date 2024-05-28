Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF4EC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwix-0001HB-Th; Tue, 28 May 2024 09:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBwit-0001GQ-QA
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:18:40 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBwir-0006Nl-Kc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:18:39 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45dso981217a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716902316; x=1717507116; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KUs431OcOrPSHN5IsKVp6gDCDDBL6vuomJl8eZ18TuM=;
 b=mh8wCY5LIUxout75orzEylB0p7ONsqvhHv5sAeGJ3NPwP0sCYfKmscTfeY1fUS/oSd
 bezYk/ZAwg33BVEiwuyug5brPeo21xDBbGFBpaHUrCTUoLxF7NKZBgnKlAyNa4EwpX0b
 N+mxiqG3Chs54nYVRq5QuRRzgqz+6A0xBLc8Fri0x+INMLH86HdooJYgtXd7LKiFRtrU
 UB81U0ORUOUgSHeF3DX9x5Jz2eezNRj4tjnSGWAXDpzqfdARKgGNGIWuOvJeZKxwM7T/
 qCJIZhG8LuBz72qJFsabuENKm4GkCq1L1uVX/A4lqkj9Gyv1HCY/TsMbIFphW3hwEi0F
 kghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716902316; x=1717507116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KUs431OcOrPSHN5IsKVp6gDCDDBL6vuomJl8eZ18TuM=;
 b=DN21Bg2LbeAz862NalDT01dJ3WU0eWCBK6z5UhGvx0P+PiqM1Y5P607je/DD/kvwB7
 8hXGfs/t6xJE2jq1GaZ4ZPKQf9fE1Gl3oZu66sL3A9IHKUzf7koitBZ9Fe2DfyLbcMwu
 OPH8oSl0L0sr2qYzue9kD/+9MtIYnSM6vMANOgKt6hX9Z7HS01z6AFRR56YynpWHPSsb
 RpTDM6OGGIRPATE6OWHSr+f/fnOsne8aT85aV/QYcqVChkxF1pMfJvBgRqvr3YAf5B9F
 s006jzzpNuu2jr9Ii7bkSbcYtds+rfn6hyQfwEhX/Qm9xpXG6Bfll53t6edoEYnOd58u
 /S+w==
X-Gm-Message-State: AOJu0YwY6FqgnSaJCXUZY2FocY7zwvSlmNpdwlmPsKer6h7Fu3tKI8sy
 ItBv9Bfm0fcOZWBA9BNkELjkc18PjuvApL28u1fln/jfLkj9wqIlWJKUDS9UbJe3DAMWzTlq2Gx
 WBv8SQjM/I1DKnD50TQQlhziR5Kl1u9Vep4Kpy30FXO0bQtL2
X-Google-Smtp-Source: AGHT+IEDOmcSAsx56lDkzNr3EKG2uIGYpxJW+E2Zf4FLeZhMtw4teueB0UFn9tlj4qNgtvO/niDKZX1bYr6F6z8E8J4=
X-Received: by 2002:a50:a683:0:b0:578:55a3:8b52 with SMTP id
 4fb4d7f45d1cf-57855a3a941mr6528516a12.8.1716902316071; Tue, 28 May 2024
 06:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-4-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 14:18:25 +0100
Message-ID: <CAFEAcA89_nWDXhXKds3gezUyXdXfO61bMNgSn=em166ufgQAbQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/67] target/arm: Reject incorrect operands to PLD,
 PLDW, PLI
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sat, 25 May 2024 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For all, rm == 15 is invalid.
> Prior to v8, thumb with rm == 13 is invalid.
> For PLDW, rn == 15 is invalid.

> Fixes a RISU mismatch for the HINTSPACE pattern in t32.risu
> compared to a neoverse-n1 host.

These are UNPREDICTABLE cases, not invalid. In general
we don't try to match a specific implementation's
UNPREDICTABLE choices.

I think we're better off avoiding the mismatch by improving
the risu patterns to avoid the UNPREDICTABLE cases.

thanks
-- PMM

