Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD8CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcwO-0003qw-Mv; Mon, 08 Jun 2026 12:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcwN-0003qS-8H
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:35:07 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcwL-0000w8-FJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:35:06 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bed2b9bfa02so615393066b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936503; cv=none;
 d=google.com; s=arc-20240605;
 b=dCcYVywVkwpmwvCWy55GnyPvwH1Y8qduKwPKfnCrOHp/x5KI4QlytqKsnhSpt8T0hh
 04FaLwAjULMT2ZkjZGqHW3Dhbf8nOP3wmN70USbi7PJUb7yNeU8tIlos3Lrj8dpQeU3d
 MQmdIO26l/q6NkmmisWS92BG1ff/Don939gkwaVgKQJPttIJa3Igq5+Z6dlApoO381/U
 zfrwl7O9nz9J9T0rZcIXv6ZzP+lX44X8ckapGY3Yl7eQjzs4tS3JLrbxIDN1eMdtbqnC
 /lsgtpyuflprVyRiEV35a7+CSrujp8yQ6WPWMAiSE+S3H2LyIRWGQiAo+oAVbMS+BuoL
 UOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h9ViwVnTJv7S2FuxhT2/rxwtOAzaa1wdajcnLd0l9DI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=RX6iYDtjIoh5KeRJbBICMwuV0Bc/bpA3MS4s6vMvs4mxQnw4NhfC0qTGimhMHpNtIp
 BVWZc0FCwk46dL5q/nroqu9AtvHW614U0a7BaGkfgo4l7lVQKAu72YLnI8JVnPY7CBhO
 g0bwrLn3DebzaSxvcxYJisKqDg5rv2FDTE8dYBNdF+LS06RbSWu75BtpGEvqwR7LWg0a
 F7UmZQjVYJ5USqZcIRD5WCfaoDhyk+zTaRlBBnN0hfI7lsXBG1nIsKJuMurArRNy4bSn
 VUPRU9bN2G/Xo5Lsj7IDhX6Mjze/o4qjZO/aDSray3uvP+oBYhMB98Zz3zPdqKIovaAP
 7Gzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780936503; x=1781541303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h9ViwVnTJv7S2FuxhT2/rxwtOAzaa1wdajcnLd0l9DI=;
 b=O3JX7k2B9tSAHifDuD9QymsLhDhTadfZa/2/uaVoiZDNm2LNidQ3WTEpzcgtUaXp40
 6tVbD2UvU4wiCR18xPLDGKKxOQFPfdiURqSRC6WpYp1WqRxTzpD0qyNNq1E+sVhOwXOS
 OdyydL6dFguWY4L7Jo4kU5EFbQF+QzsudB0KYiSxBK5FvUSVb7KcVh97oAF5iqF4W/GA
 la2P5/PbsKO+afo4QtDPmdLHqApwYoyvBEKgziQdkgRizEanykFUCWSkVpPlz4fFq/r2
 T4cKirN1vBRK+RYKo/PkvOY/ANmIijbB0dRgUXOKFKPFNT9TjN1ARSiwKi3ZYOtLka/t
 vPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936503; x=1781541303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9ViwVnTJv7S2FuxhT2/rxwtOAzaa1wdajcnLd0l9DI=;
 b=g3D64EOV6DyVmu9Vk7AZIAZaE8yUxWqBLAHHQ9d3lqX4zzqUqNVrDcqok1JaVYl1O2
 W0husN13Fuw8JFYBXJaTJuM/qrKPaowmccxtgEyxrkpVA6j0ezlGdg+ApTPxcNcTvprP
 VDfyuC5LJtbstKYKYvvsUMFIlnmc4MmkIuH4G0zCLFJvPzHGJhs3xAcfslGMBVF/MBV2
 54vXjxo69iuQwgBDIHaanD3HNfissbQpqJg6ZAqnaj/cQgacWm5KnuLQnKvN7h+1s8zQ
 uY38ooGrW38IXhZ2BsAATWDmVvMaKuV5LxfA990YwBK3WqOZa8GF4tXt+LuWJhrn4MF7
 CBOg==
X-Gm-Message-State: AOJu0Yz7s9TvQ62fRDR0lv4PFeGoQJ2eipdM4Qofet/DjBB6gvKCT1Ub
 96x+NY60p4cVZBL7OENnTRGio/FBo+B4bpZ8+OgmNAawzw808qMpMl7rMP4udjBWSt9dnjhPbu7
 UQ8N38AeW0lOGxlfm2OTwzWHkwMp87EjEilo3+8OCqg==
X-Gm-Gg: Acq92OHO8UPvS/oYU+AicB1RFbj3ePvIQPt6c2EzLPpbJgHSj1hvFX+2Ywntc4T3iqI
 cuRDe3RUHfi2XDcX0rNGUX9/w1xRJykkGeuhTGkKtL4lrGlMNTWhGaiOsK9ZoqMyGftLTPjFKrL
 3X/Ea6NEeKMRcMQUxntcbSVFOTo1NrHr4YLawzv6bqoMusu+DeSK9cjlEyOQ55N3pwI22S/q/67
 DyJUCnec49SoDlq8PtMF9ca10cH30POQQN+JZ73YZKB2WFhRzvV1bSiwCZu2RudI24AEfaUFZSw
 a5T2MuLKoqN9ev0vtULV01EIcDu/ZSyvPNtvUnYVu2wVdr82X1hUsGVR+czzMYFL0P7W2Jry7Y5
 yiw==
X-Received: by 2002:a17:907:8b97:b0:bec:929b:cee6 with SMTP id
 a640c23a62f3a-bf37253fd8amr795583966b.20.1780936503083; Mon, 08 Jun 2026
 09:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-5-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:34:49 +0100
X-Gm-Features: AVVi8CeeEC7pjcpK0CZWsSTf9ganbGmBMOCFW4pf9x8Z0pvO4baKT0pa6pavCSo
Message-ID: <CAFEAcA8-UYHuSBP0p6UPfMM7EXE4VoNWFuHh8nqGE3KvnoU6rw@mail.gmail.com>
Subject: Re: [PATCH v9 04/45] target/arm: Generalize TRANS_FEAT_STREAMING_SME2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename to TRANS_FEAT_STREAMING_IF and add a new parameter.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

