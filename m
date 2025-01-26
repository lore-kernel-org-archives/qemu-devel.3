Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D058C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1sz-0004Fo-FB; Sun, 26 Jan 2025 07:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1so-0004DH-1E
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:37:00 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1sm-00061A-LL
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:36:57 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso4730478a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737895015; x=1738499815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MqoYiR6IncRuDDuR8655zRIlYGPAokw5SN1HtUrZGkw=;
 b=qxQNa1PTa1PJl2lGmZ8r/gmpoZvEr+znrf56UR9lFR1ArSMv9UcN9RawBDDwMPd2GF
 F/XRIs4OJ2LnFmXmYAB2DB6aZalEmTAXFNl9MurwdnQRGS7rTCClAVVqS3pkqz5btmcA
 MYZRYdMVW9ucxYDdDp7IZAUOolwyTD1XChgoE2qGFPsVrVPKaxKvxArL+tOIt7DwSYyY
 rAWg4VD3fIrdPttKZ91fp0CJ7xmkC1dleJgRVMzmvD1c6rhXTS6SRVi2+h+sUm5ekGkX
 Dp65NgH2g3oyDz+DNWGb84GoT8O9cXI1A976q9CVutynGNqoojTOR1jclEIuN8PzUqKx
 euhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737895015; x=1738499815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MqoYiR6IncRuDDuR8655zRIlYGPAokw5SN1HtUrZGkw=;
 b=QRmfHFCwGK7xZiynC3Oq/exbY9iBwt0qaiYDB+RPhZ5WDF6E6rt55MI6cT2pHouLqN
 ZGE0Qn4oUDCW9rQMckOgHhouZqJQgnf3Euq0iu0/OBXcHAHKnL0Kd7XocmtsGSIoT+43
 EwHJ/Em9U5vqF6kuC8nGBzASylycXieF44vUojhuNWXIz3oEcVGCgXZTAzZ4Qc4/zw0O
 INQQujJdUn3sfuvssnaaVr/7dgMkEs94gYg5vHleszT2IuA41pW8camDqlgZoEMDWBe4
 8MLLAzZAdWzXxwhMQ7I05TS/dGb8oVKTkUfSDFTeGCJOb//GBs1DE5WW00eCFsimXuRj
 7sYw==
X-Gm-Message-State: AOJu0Yy/LmiuJRO/AWWxRHefonZSFtYwly9WRgmHgfgnLgdLwCr5oDth
 6g3pXYVKdRCa17NMary3rLg4qbm4UxcJExjFZPvyANnjYTvS1kCF/RcCpiA4O0rWIekfxlQZ9DD
 D
X-Gm-Gg: ASbGnctc3EURx7FO4vxERXJWTixR3+Uan7hS9SW/dlhZ63B97Ok5pfhUVtMbKQlbvtV
 BGb6TtlEXxhx8bwh1CW/0h/i2F7idu3m1XVO+fuA+uGuTHXGeA3H1mLOBemP83RRmHkdUm2uvam
 qa3VjoMWzpeUZmYirQURXuMdJOpEwUMUNUDZiGqfj1iZHPWE3J9lcj3v+pXuL/6mcC989lbnXIc
 UuqhF+LMyPhP9LrbXb2aiw4TqSyiYAm46jyfwJK4Yeh/gVx2D6VXTs3LfrmWUlgoVRZc5MtRO7i
 gkYp4qiqihEEd3vAMWXgBZg=
X-Google-Smtp-Source: AGHT+IEtM4n2LR0SXdtGhrPkJWaVNfX7dzdNDxhyHBfuhT+RIAZDrtlI6c5+mRORB2/rOhsogW0QTg==
X-Received: by 2002:a17:90b:38ca:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2f782d3832bmr51372247a91.25.1737895014907; 
 Sun, 26 Jan 2025 04:36:54 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1dc56sm5677994a91.49.2025.01.26.04.36.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:36:54 -0800 (PST)
Message-ID: <3851ea85-5d23-415e-bfbc-15a2618908c6@linaro.org>
Date: Sun, 26 Jan 2025 04:36:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/76] target/arm: Handle FPCR.NEP for NEP for FMUL, FMULX
 scalar by element
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-45-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-45-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> do_fp3_scalar_idx() is used only for the FMUL and FMULX scalar by
> element instructions; these both need to merge the result with the Rn
> register when FPCR.NEP is set.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

