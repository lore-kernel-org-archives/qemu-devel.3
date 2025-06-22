Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4BBC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9RV-00027w-0L; Sat, 21 Jun 2025 21:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9RS-00027O-Cv
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:24:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9RQ-0007J9-Ok
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:24:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2430767b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555455; x=1751160255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=twP0FJrGc8ShaaFNYgbu6kKgLKzQdk7H6UhZL1Dzgms=;
 b=MBmu6q+KPtKR098tbVXIufcgOLl3ffa9JtcmiHSTwKGdcEDDFT9Ewqq7b2Fnc6WW4G
 +Rh8m9kJqMpQFj592Ygds+nxUb89a+Rip991gUhs9z2vRgbcSysqLcnchClZVEKJUyWf
 XCjNt5xhGnAhiCRwwrJZPue/VFp7ciOKOZkKEBnVlLYIkxuQjoPR5UO3SGYgstrhEykA
 4EOrX/Z5ZGfOyvpeeFIZ4Wrlsxc3Io2PNgrRlzsLSDL7FKQwWM2UMi32aAiJQXlBB3GJ
 tPQm8rjJtw7OzYyoBkM0rmpXOh5dvERMe1IlsHZqAuMapWPcBmngQtaPx1yaHHv/6wgo
 V5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555455; x=1751160255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=twP0FJrGc8ShaaFNYgbu6kKgLKzQdk7H6UhZL1Dzgms=;
 b=RxoRgOYdppni2QON2zZSoLE+JcVsfpYMe6MHbeQS0iz1c9YDNHclR25sQMRyWG1+5g
 L3Ds4qbCifZoL5QEsmNbCbFwJN0eCy65QB373LH9pI5wb1sfu3qzyhULW8ucL1CvIPlP
 S8aGx/4uAWxdH9iAoqStdYUigXmtS6ETw95cQKHz+ZpQNY29TOXnJGSXXdHiyLDyHJLV
 8eeXW+z2YaTt6Q27jniJ1RsdUgOuX5qmhS/b6Wc9CKUW5p2B4MvYEeultm4Ae3djQWkP
 5uKltkC432xGMCcudatCO1HAcxKuozn8CV13v4UShoJ5MOWan9hwrEfm2wqY42mnHtNH
 cHcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeqxVHORvNbyk09q+lUq+cB3kb5wvIgdZRPcVVQEKOORgaphZ2s8HAsBeb5pmHEJRtUgAkPL9Sf5jz@nongnu.org
X-Gm-Message-State: AOJu0YzMUVCetVyNY5Z/k+cqVzufpt9tHrC/4yBUParjas9aSKX077RL
 qSPzq3WHAOjBHufAuxkIAsPA1Yj/BOjpIvd6o9P0dUiG+gqZuqbQy12THX9aPEIQLW4=
X-Gm-Gg: ASbGncuDxd5QrJ4BkTAmBISoRWZA9mzpO3xxCqnRyZZv6sFzZnvYtR8+38ppKYRkdMh
 XyFvJmLEL8GRUpuTmrm9wlC0UQ12LCC9r+VS0fHB7Uz9NAldcwdA/XSBPCm9ewVeNOBxrtTcaee
 H8bBx/gVEuo4F7zDXfFmVcYs6xjVvuu3wPSVlMc8dsfgFH1JyN1COX2MdaZGieoIDpL0XQKoDAU
 H8PN+q8FPBDg/KRK4QewKvdIehHYa4yjZRzGMMP+Gs+yurgCXc9dQTsf84Rqqyq5psV/qSbfSos
 1eMNe/s1TPWiIA6Z9qFXhI0jpyP0P6XvY6/ATvseXh6TseiUFSqP4p1Fx9RSNRqwddTnLaqJjiN
 iQutMjFnuv1xmLSkfqGoZImfYF7oR
X-Google-Smtp-Source: AGHT+IG7t55Bj/BTc8CZ2dDL9BJCW1Taw05bCsw1OTjw6aGH76G6XtJcDvwJyrTLsJ4DG6M3PsyPqw==
X-Received: by 2002:a05:6a20:72a0:b0:21f:568c:712c with SMTP id
 adf61e73a8af0-22026e92e89mr13682363637.14.1750555455344; 
 Sat, 21 Jun 2025 18:24:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64a90csm5051323b3a.119.2025.06.21.18.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:24:14 -0700 (PDT)
Message-ID: <10303643-8084-4848-9955-19c1fbe97492@linaro.org>
Date: Sat, 21 Jun 2025 18:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/48] accel: Move cpu_common_[un]realize()
 declarations to AccelOpsClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> AccelClass is for methods dealing with AccelState.
> When dealing with vCPUs, we want AccelOpsClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h       |  2 --
>   include/system/accel-ops.h |  2 ++
>   accel/accel-common.c       | 10 ++++++----
>   accel/tcg/tcg-accel-ops.c  |  3 +++
>   accel/tcg/tcg-all.c        |  2 --
>   5 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

