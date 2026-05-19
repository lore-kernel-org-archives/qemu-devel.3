Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF670CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 11:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPIwH-0008MS-CR; Tue, 19 May 2026 07:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPIw4-0008LM-Cv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 07:48:34 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPIw2-0003Im-Pc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 07:48:32 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c5d525f6so3451779d50.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 04:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779191307; cv=none;
 d=google.com; s=arc-20240605;
 b=ilBsBYo8ptKl0qd550IVQpcuzlRcwuYKrfvwkgcvC4DGS//TYj/nDT1+vDpghmHr8G
 ALgxxG4lBLN07JPWbqelVLZ+BxE/vd6yfGchfgD2WaektOfMqiplBu8dgtIqe0z/DgS2
 HvXjLV3ClTJ1JZW55oprTualRca84YfyzYMZNlfO6M4v4G3h5793EBDkNinIx1lvY3sV
 1b8ChBJepkN9zZZHhaYOVNB7slEO6rwJXOqBsr6mpss1A96W0H1pLiOX0GkR7Jpuhw8i
 /sazUCLQs3EkJicthovDYXf3kTmvCDf4CfZjXKRw6wdpdkLT1ghZBOptFr9+jjsAMIa2
 xlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ro2CqTwsznCgwhHdriIsTvxbARkqkKEYYmfW8L+elBk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ids4h8Tf0DUtHfQjSXOCj6g+BExxWIyhndhX+Yk7qF5lFq7sQZP7kE+ATWaUCbbV+6
 DXtqJRDG3yASiiC7+jO3+FroYuh9zAmp351Q3JLhir0AenW4LdQOi+RXbjFRAd23HyQA
 Z0pba806vL8oJX9FGB6VRYOyRgvQUEbEj48rY7l/TLiqQeyAjqrQzR7tBfG34yKguYKI
 nxcwVdPdfIB6RpaipCNGxqlJSX90TDDEkaQC3dBBsKQDcBmRIbJqhQThnstoh5W3KMz4
 r0/8SwF6ylWkYsbE6iW0yoK59ZYXRwICKKW9kQItE4aMh2p5JjaFFwA4GvkaEOgyerO8
 eumA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779191307; x=1779796107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ro2CqTwsznCgwhHdriIsTvxbARkqkKEYYmfW8L+elBk=;
 b=UjDK3ToAr/4dBpAjCu84tVyjpmL1IZBq+rzbp7rDiE63VhpeLWHLgVMwK2NpkAS2so
 sMqU4UniSnmvfnNr1xkrBvhkGLjf1lYsF6F370+xXkqvFR9VPUcTzRJtuyp/9lUqBjKd
 0HE0zE5AeCoZRHkxNonVSgDktyVfIluK9NQao4f6hyrQB2vVillompRDDy4kWi0Je1gz
 EE2bGKeZklOAQr5PAIM4EawtEYKrjZNwAV0LTmo3eVriJl6X9s1jqMmrqHB7DD+QPLqA
 cHWDtj7Hds6rIMDafjJDjUxV0zzouBKH82lAOYntfIUmWZFPoe5o6p/wxUPD0o8qguLW
 GoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779191307; x=1779796107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro2CqTwsznCgwhHdriIsTvxbARkqkKEYYmfW8L+elBk=;
 b=gYmz1/8ny+1iFEuixNS9DHbbeXJhIXkEySwRD1+jNGJ8lItpOpwDFbAdwBP9wL5cHT
 Dmb97lTmD6O3Xe1J0AKH6NU49cQnIZ3XCed1YCV4ostA7Hzjx+MFDBjRjkE1Ysi9JXJk
 nk0rOGlGSTBLEAmF1O8JHo/1IIITQp7j/6CJ2plEXX5ehwt4oW6MrKYEbaYWWT+i1XHC
 Fdfb9MscPK1Fr4QPKWXJx6nFwcM2pwkH1X1zqoYFTpbpjXkWqHX4jGorQoKoac3k33Ku
 vp6laZbouCqC3b9kXHd+bS9UVox7gcwPw9eRgHvXTuviUN5KRBCLxwhqKbraUpw6EBmR
 uEpw==
X-Gm-Message-State: AOJu0Yw03WTVgLPH/ezG/QkDL+YtoUnTglrJBF013QrGOImoXq/cI/W/
 /UEcvQle3xF3QgnoXO3yrHN0Kr6nBFdTK4+q1okA8LFlS0Dbyhv1c9TFsE391un8yr4SMdkNHEj
 jUHDq7ByqxeY5vhrd8HbpaBzkCGYJdr8gUSlTX+aHVw==
X-Gm-Gg: Acq92OHAkjnII6dRM/eJfK91/owyuK1m/PWE0FpEQZez9CCIOV7L/shv+Ec6rTpsqbG
 kAEwFK2HAYcZ3v0eWthyY/+/8Dzoqfsm0nx1p5h5H99ICYXi7sWxI+UbIby2LnyyR1LWBfCM7UT
 vaZKviFe6uqWEp2XmgVim3+NvyVG1rZL+90YE9jdQkV3c6cZfAb5sacamPqmfkcwZwy7pUpd0rW
 Ojm4Pfe5qi2klklXKdEkouC9mhMTEOxYK1TBn3JnsoikxUFjAVFesbVSKJgzzIuqWUOktRP/bkD
 cpkR8rvTsAyGwW6hl647/5YLPgkHAfvLLA9+/yfOvgXIc5eq29rUO3eMP4ySzpZ1wFdWSxsPtAM
 cRg==
X-Received: by 2002:a05:690e:158b:20b0:65b:123:1b00 with SMTP id
 956f58d0204a3-65e2272305emr15774851d50.26.1779191307469; Tue, 19 May 2026
 04:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-10-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 12:48:15 +0100
X-Gm-Features: AVHnY4LqTiVpC8bZlw9hx-XTLJ_ABMok0OvLfdSmRzO_gS0vMdD95NTStJsS4pA
Message-ID: <CAFEAcA8C446_o=NnvX874JWKf4XGVdfoEOkhJaz6jgqxxwPDxA@mail.gmail.com>
Subject: Re: [PATCH v5 09/63] target/arm: Introduce FPMR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 17 May 2026 at 01:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce the special register FPMR and its fields.
> Migrate it when present.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Is it worth printing FPMR with FPSR and FPCR in
aarch64_cpu_dump_state() ? It would have been helpful
to me for debugging this series but maybe it's a bit niche
to include in the stock debug output.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

