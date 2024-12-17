Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2390E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNaUl-0006zV-WC; Tue, 17 Dec 2024 11:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNaUi-0006z3-CI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:32:24 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNaUg-0007QW-8t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:32:24 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5401c68b89eso5966415e87.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734453139; x=1735057939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ei6gfabq0V/lSrW+0XN4aw/hrxQMeGF/X4fmlty3aEQ=;
 b=to1JcdJNXdDtPGVpd5EsARKpPZ6fUcASOJ/NoQ46VGHIccVwf7tbjbNb7qZxzeeqNb
 7+DMyiIE23+hQ66Vgp6uWv3CnNQpWHHqV1WBV+WtAFUpjYJhv8Q8uMC1yr5Ec4xQIcwH
 bt24Rsq4t+6eF8Y5S2lfER1n5+G4CWXtLWzl6Wk1HqaJTU/NSIPTlt2T4N9cIveS++Cp
 RRJhKB2u/Ni+KS5xNcnMWVoP3JA+qrcwam0CzO0ByLDBCL5hhOK8lkT9iNf2uQ5DNtc3
 CDFbZ6WUUoepp1DGPBtg1JJQ2s+yjzyAB0eX3KJV6DyvscVBKtMtXi4+W5TzpKin2tTB
 +SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734453139; x=1735057939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ei6gfabq0V/lSrW+0XN4aw/hrxQMeGF/X4fmlty3aEQ=;
 b=jc/VHTt8gPBmDJGi/7CHcrSiCIJPs7jH7maF3iAvV/9Bo3QI6lhJ6dp9kAUJaSBtAV
 wxKfoWdIZ66spwU1zYqZ2ev2tqe6RSHKmoqa1EGsbuqatRDPkyDB0Hkk9eyw/+zSlweE
 CF81t5e2lErsZQo1HRfPWrhS+v2yUS4C0JtzGcCfHC/x/srPehFDzKhm0xE6P4hz8g6g
 ioXwtltqbfrv3W0ap+BVSK+cWKQZJTIzTjn9bYCsqIY1od7yxEHcTjVRccvSCkZqKw0/
 nOBQO3epvv/koQR5TCxomeBGO9F8uOFPE4XCoL82Hkh1EFcK5y3mhnDrRpgzccUz6P2+
 /dIA==
X-Gm-Message-State: AOJu0YxBqrZ0b/2nKRzQIdCDK8wapU009R7WPTcp+fj+/iJS9vm4VQ8J
 PIi/L1h0zMvvSiQL7tA1XV58tktysxFk/7bcR9+GJBPr3nUuV9dlbyy+NcHV4JiQBKpfDOxbmgo
 KyEYqjgYi
X-Gm-Gg: ASbGncuY0+WumUV27kNJlsDOqIhMpfzDX7cYXPmPUEgGBGJwDwqohuV7Nixl0A5jAPv
 GvStKDGCXAiYilsJxVqqkhKjreqKfG1cvMBXQ/nKpwcsQYnaCEceR5Y3Rh2MbNMuW4mH1uhTFPV
 5ggxpnXvUVJWkcclvFnvbRmMe4mIubdwrNas3xyZlfN32Cz0arJf+RI4Ar2KUxNWW5pHRx4bi3Y
 zemTyAkI4ZkiESSyeUu98hyYwC3ErEoXLqExwYw45OiG0ynQfkTY2l3aN73ENr89C1t9x1Inx8=
X-Google-Smtp-Source: AGHT+IF44ITaRFjWIqDqucfF2rVWVK0UyGjksXSNhtc2oI8wOj26H2+aYoJATo/sYdyLHCnig15ipA==
X-Received: by 2002:a05:6512:1386:b0:540:2abf:7016 with SMTP id
 2adb3069b0e04-5413158aaa9mr1168876e87.17.1734453138871; 
 Tue, 17 Dec 2024 08:32:18 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120b9f4c3sm1194563e87.36.2024.12.17.08.32.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 08:32:17 -0800 (PST)
Message-ID: <f9f83c79-73d7-4831-b0ce-c39204ac3946@linaro.org>
Date: Tue, 17 Dec 2024 10:32:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/32] tests/functional: add execute permission to
 aspeed tests
To: qemu-devel@nongnu.org
References: <20241217155953.3950506-1-berrange@redhat.com>
 <20241217155953.3950506-2-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217155953.3950506-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
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

On 12/17/24 09:59, Daniel P. Berrangé wrote:
> Tests are expected to be directly invoked when debugging so must
> have execute permission.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> ---
>   tests/functional/test_aarch64_aspeed.py      | 0
>   tests/functional/test_arm_aspeed_ast1030.py  | 0
>   tests/functional/test_arm_aspeed_ast2500.py  | 0
>   tests/functional/test_arm_aspeed_ast2600.py  | 0
>   tests/functional/test_arm_aspeed_palmetto.py | 0
>   tests/functional/test_arm_aspeed_rainier.py  | 0
>   tests/functional/test_arm_aspeed_romulus.py  | 0
>   7 files changed, 0 insertions(+), 0 deletions(-)
>   mode change 100644 => 100755 tests/functional/test_aarch64_aspeed.py
>   mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast1030.py
>   mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast2500.py
>   mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast2600.py
>   mode change 100644 => 100755 tests/functional/test_arm_aspeed_palmetto.py
>   mode change 100644 => 100755 tests/functional/test_arm_aspeed_rainier.py
>   mode change 100644 => 100755 tests/functional/test_arm_aspeed_romulus.py

