Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E083C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojqh-000182-12; Tue, 28 Jul 2026 11:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojqY-00015H-RJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:36:00 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojqX-0002Gy-81
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:35:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so5954464a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252955; cv=none;
 d=google.com; s=arc-20260327;
 b=L+tSJmEWaiRi4WBfevyf07mIUrR9Q0yBUuZYvG0gPpqQTk0/Y+NiU1iMnjIF0+xz0T
 bhS0jLTzd8AhKN+FLOsVKIvpsvorbitTVBfQStBB2kSB5Ho9UjXlEzitklLznduJMKA/
 dKvzDxsu4W9xBbCqu+50YDVvuYnQojXIO0iZboKbLs5lTPFsudcGIt4KbrVpUsZ2ATeH
 nsZ+oNgr+yo3KVTMST/Kt9HRYarvPoXL+JGLQg0z2c7t66skVd9AG4ZvooxTrHU7PJEM
 HyQsviMuHGx4iEWA0FXCHEpfq0Ay6px5WurUWZLcCi7bKNqkvUpY4m8RqBeoGDA8Fk7c
 wvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9Az08cN4p5zTkZ9k8ldu1orMamIIQtwJyBx6lq5S8R0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Ysu9io2BDtbxuupdRnuytiaCAlCREzw9QDHZ9yhDP47qhT0If6bKJhMrPLoqwygQ2c
 p4bqeQEJhkK1XM48fXCUvTVwFgGDiA1x2r4Vy3HOkofvHEBEkEctTJqsLD/8fSdyxsK4
 kRzqnzoCSHyLv9l13gLnvd5896MEc7JdHPikAWUrF+6J2EDUF1BU/CJd7KhXgQlZRs1y
 GL82G/liqzaxYUUynFgj5OKbzWv6mySs+YyZJ+89ZEqmOXICNvUK9YQtN18cWhECsqFQ
 DF2Lu1lVxBNzU7A9qmLS3S0J0TJZsF9D74AQz4X4G/NUMun43z1ktZY6FV3c4GIFyVlA
 q/tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252955; x=1785857755; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9Az08cN4p5zTkZ9k8ldu1orMamIIQtwJyBx6lq5S8R0=;
 b=OJ63dj7O5K+bKqjHT19TYHsXmye5oGsJsVbRFymkSoK25fBOlGFNxfCYwMVv6PSeF8
 l3MIjJhmgEPLGmpn+1m0bX1s6j95pIv3mmpjCkX13+0Zwiwkqtg6ZO5GzKUvSq/3uaze
 BLUhwOpPsCZUefkvqojSYDhTCuDJhYUFIrer0jPhHtFaLfyptJVxbCoZF0GEv414Tvf2
 z+itbgSsDLGq4yyOLVLmy/56lETDutC3p1afWmpqyb6Qrm9RXJv5YUKtp+YmlPmsLlwW
 t4jyIRLw8AsITanr/XPDMXmNtI+tx5wnmWgOWqOR1wzn5NXb0uCYwjsWJnDTox8TdN3/
 kX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252955; x=1785857755;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9Az08cN4p5zTkZ9k8ldu1orMamIIQtwJyBx6lq5S8R0=;
 b=nrXyrAnoFwY1zmHcYj74Q51pc0W9hhawrsNdTTUEGfH2UTW3NUlB+qO5YKe1kKOGTB
 /B8hv+5DI5mxaXdHVvgDJowMLFPRZg/Shwbt3uFmiNRW9WKrQa9MfhAgT698Fzbhcz1s
 rKxZhzl6p6kHwrIMVncY0O7buK/8MQLcQaYm+3M2ZFnFqTqRfTgnooVwQ0yxLrTahWP6
 YuWsXc1Pq3ZzlVskxN4ujkIF/Fj4h+r0Q/0bDJvTt8SUwIP3IhMaf3WCc6bvGJ5z0DVm
 D2T6R7t3uG3K33+IUe8c0mTrb3VTv7cbIMsj5XaDtDVS/0pQ+CmJXUDgNFLJDHt33v3Y
 Ewnw==
X-Gm-Message-State: AOJu0Yw5PfJsUg92LWv2dEHmANAbTeR82MfjbJyIbDRnwSNNyprgVFAS
 If64WxjC6ttJ8Ce2XL7eQu7GiKBm/MMK4xy5WyXHCf38zddl+Gk8QqXOMsG5pLeUNvaXuOJ1ZnL
 ILR4uMxo8JxuRlTXJwJ0cm0O5AyZfcwQePGFS/mr8QQ==
X-Gm-Gg: AR+sD13GaWNAhgtudHoXDBDZEUXQJVF9x4WjX/qBFb+9weUkGYgArvIXKCUsyhc1EQF
 xS578RRgxVJRxiyZptKNUt2ZtDhjfqtYWWUDgIdpza8uRmNN0DONu+RuJMwZj7lMSgoH7EMRDoH
 xlDsiG5uiLEHKM8Bzws9flw1X/B9eKaqoTdoJlbwRngJ2rQvi5kVRPuU/NTrdsoaE0PcL0PBQSM
 b4uSodBn9lADTEM7+0AKuctFKVewm7oy8zTdMbg1+hn+7voH9X78p0iZ8tVzJM7U/bWK4t+oGyo
 WTKaQYuWXNN54Uw66Uaqi3auwl0yW6onzyTlQKsfn1Y51w==
X-Received: by 2002:a17:907:8b87:b0:c1f:304a:9a45 with SMTP id
 a640c23a62f3a-c1f72222977mr161321466b.38.1785252955657; Tue, 28 Jul 2026
 08:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-11-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:35:32 +0100
X-Gm-Features: AUfX_mztmS6OXeHW72L5oaoYZ95WMDb4bGZ6FougjdJZCofj15NDtIyzUYq9c4U
Message-ID: <CAFEAcA98J6gMG9_2UtYq8Xc=qM_sQF5XCa+a1DRKYDqdS-9KJw@mail.gmail.com>
Subject: Re: [PATCH 10/20] target/arm: Rename isar_feature_aa64_sve_pmull128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from isar_feature_aa64_sve2_pmull128 to match
> the feature name: FEAT_SVE_PMULL128.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

