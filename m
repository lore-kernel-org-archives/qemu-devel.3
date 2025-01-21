Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD66C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGZY-0002Zn-3C; Tue, 21 Jan 2025 10:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGZW-0002ZO-JJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:53:46 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGZV-0001Zs-8F
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:53:46 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so8974503a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474823; x=1738079623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZbfiC/E9KmgsPWktLeqcvcd7LTuzIburYx/aC0JZfc4=;
 b=J29RkYpphJhEBJ1Dsm7PV+w7qdCgE+XXfN/OfioCugNHv11kKr+oa0Saoxl1IBRKbN
 KPx+H+3+qofqOwTdMbO1Xwapb8vDeAnKXeOOrHaVsGCtyj8YMjNdLMPeRoJfordk24tK
 cB1i3YVT+eQUm6l/29pycuiVIAL1vVhmafqC5IBhCORElraoKPy70mG1I7mUFpSD1MF8
 +Kvvp8oPA5Nkvf1TKYp0x62VLsH0uFu9hxryepFEbKQ+FD3itsnoYId6LD99jRqGSyzg
 +6290NASbYPLt5Y3SPS93HwVgCfC0wWhnfXeZ2xXmKleTBw500z9zKrsAJPic+OuzBVG
 0teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474823; x=1738079623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbfiC/E9KmgsPWktLeqcvcd7LTuzIburYx/aC0JZfc4=;
 b=pl6r21Mq1kPuXelO1eVHbyxsJWIC9Xq1/ssa4dIqBSkl71h80lVJXux46RYKLDI1aw
 v0JP6yxJlABou1zZZlEcXDGJCwdI3VV/s/pCVptYunG03JfnpNEISbRhK3TTzaH3gaUr
 Puo/6Ul/r77Mh9uYG9pmQPnKi1pVCWOd6Aq8vSE0gW/FTBvNYDk7b8jOHeDEi7hRN/XP
 9HlXBTwZMwOLCwwmBLLoSzO7p8rfL5UtDyo3tS60gwuJA03F1Tj4TdTeVjfYXDy3L8mL
 4UEo7uOSVmPTBErXS6pon5jkf3M365U5VzYmL1IxUllGWBTdm9L1/kcAIY0swRBdKkSy
 m/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvnqe09eFdIPPStazeyalzQDWBiC/gUc6DOcMW8C72Ueu4kQuUhwNPsPs7FW+g1piHUWUBCb8fNVgt@nongnu.org
X-Gm-Message-State: AOJu0Yw+IR+RYSc452iiprbyOQNR3sw6BlN/Bh1YRplPARFdPNVfLSbP
 cOUxfM2EmDSxPCf2MRCwiAzPDEOtqFr2n5g6Aqv/enwL6GJOee5AdhyZXPMk6Jk=
X-Gm-Gg: ASbGnct8QdoqHplQBF8i8xYB/zCbGQWsM8SiK8jk86O4njI8Dx7xWYFGiqDFvB1MCUV
 NQaK8uuM+iKFC12COzOzVw+DJNdSgne+3sW/RtcAPBfyi2/hFu0T8BXARZhB80/+IkKmBT5xhXq
 5unXvqx2N1f5LCs9JgpAgbtMbM8HmqVAWlaZ5jIwFiJLXJtOs9MXbRsrVS3UVYtmQuhVZsyccMr
 f9naHcpgkIs/7AEz3jmha3ZCXiUDzqtWe0mqkogZ2Ml1sOIUryb6fq5ypGN3k/BawFht/O5STzu
 7Mukpe2W53z5usFliKRhLiUiKoPWm5f0GWX2
X-Google-Smtp-Source: AGHT+IEC+EUdICEsqFlt9scRw/hnwGSTZj9aBF0ZRHjyAOsyI6jy3q34xE2LnsWSVcR25R1h9SakUQ==
X-Received: by 2002:a17:90b:3eca:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2f728e48411mr39138179a91.11.1737474823559; 
 Tue, 21 Jan 2025 07:53:43 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77616117bsm9819532a91.20.2025.01.21.07.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:53:43 -0800 (PST)
Message-ID: <22fc1044-9e23-4ed8-a11a-2393903c6af4@linaro.org>
Date: Tue, 21 Jan 2025 07:53:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Pass const CPUX86State to
 x86_cpu_pending_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
References: <20250120061544.81623-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250120061544.81623-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 1/19/25 22:15, Philippe Mathieu-Daudé wrote:
> Directly pass CPUX86State to x86_cpu_pending_interrupt().
> Since it doesn't modify the dereferenced fields, make the
> argument const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/cpu.h                   | 2 +-
>   target/i386/cpu.c                   | 8 +++-----
>   target/i386/tcg/system/seg_helper.c | 2 +-
>   3 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

