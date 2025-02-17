Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A7BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6mh-0007p0-EF; Mon, 17 Feb 2025 14:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6mW-0007oQ-Dw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:27:53 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6mS-0007jZ-8Y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:27:49 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so7079100a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820466; x=1740425266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VrIIXg1ENbhhbE4V+Bq2ik9SLeHQ8ntKF7iF9SRG2Xs=;
 b=MP/PamprF9CFbLK0O0Xf/0rCCHJnkApbSuF9TAyVhySPz6xIdCZZpYPgd00g937OYk
 KPIkboGo9AydZRwOqkRE0vYP9kbqxH19FFCrNes0Lr5oqqx07Nix4+hxw3YWiO8GfNoS
 gwdasztxxKMHrRkuc1EVICWMdTcKqTqxBCUnz+wj1dxO+PaLFcZPDWBS9Bt+rSBr6YQK
 cEnNTf0pa0dV4WV7AddZbvRlRd9fbXbCk2l+H8KZ8zjo6FPw3vBSBxDwO9KJ1GnUlqXT
 DBM9uW+5bgd2QjvZcD0DHdb7LDJLXZtW+cBRPgdxBxAd7WkBKsgBX+lI8ZnyqSYMEMPK
 R2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820466; x=1740425266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VrIIXg1ENbhhbE4V+Bq2ik9SLeHQ8ntKF7iF9SRG2Xs=;
 b=dQCCgaIBYzoXNQGZ8zpJnMDLJaNBRgNCPzNtXM5sTxmrbks1QDyFsF6X36yMgU4QUd
 VuoyEQD0xBpQGirebU+83fow0CA9k9GDVCrmfHiAYIrbFCtl7cUlTfsaKlSihDsRdrUz
 TfmudTPTdwNtd2BA2EGlG4iyaiPit3F93dB2wXgCoL9S8abqvaBNKlyjU7oKvHhz8CPc
 AORvAMaywe/AFm78e2dXJTnKCxEm1M0vbPgTfAgmPDHs7eXjyTMDAr2YDdikaZwLVaxk
 jvX4iuGX5GgPqPGN769/5bO9J90XrqYxumdmKqoHia+iO5biqlNtb8bRx380jWJjApcs
 s0bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvF1OoN5v91yGq1+IbtfNImShleLk6ol2YbC2s4dE6ij9Hbvm9+UItOCx+mGwEqpUQlrnZv/AgGY3p@nongnu.org
X-Gm-Message-State: AOJu0YwY9THHa2leZylILDvMYebjagDZ1ye+C2QBT2WR7VIpgktb80fI
 UKZuYJEhafMA16QfqJH0ESt5ETlMlo/8ehhPA3Oe4AQGr/gpEWPaCczDg8qwECw=
X-Gm-Gg: ASbGncv5kLr+Nir6DAvhiAsMiDLxATvtK1MSnMQZtViyyWQ3zZ1BelEGRGivJ+e1z1y
 8m9UM7+PaV8DjCzmHzZ/en7faVY+PC+7IsHBtyXPkfj3TYlBecEeTcssaaHjF+KjAv1aWhJV8R1
 3MPyDwlezVDTNulEIvEf/AFyCRL2qzrQABEhdWrQ9FgSYRmnzL+MegdoVBlRFY9qRiXtNqy+Aqt
 TcnFavcxI7NLlsjbGrRUaeYEQ9QpPvbtpV1bKiJfRILO+DBRR86fMv832rZwTf51zaogdSAaBor
 vQ3pfQrIeS2Gkj5ruvCyRZi7wzU4rNOTV2GlSIYUHtxoH4T5Q9/Hlqk=
X-Google-Smtp-Source: AGHT+IF2bzGawDGee5vRznWwBRW29YzR4PxJVnbqB6JL/ALUoP0d5p9vrJQtdWlKx6btFWdU3owDbA==
X-Received: by 2002:a17:90b:3e8a:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2fc41045178mr17967181a91.24.1739820466254; 
 Mon, 17 Feb 2025 11:27:46 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348f1esm75186385ad.51.2025.02.17.11.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:27:45 -0800 (PST)
Message-ID: <a59d809b-da1c-4a9d-ac19-7eae75f918af@linaro.org>
Date: Mon, 17 Feb 2025 11:27:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] fpu: Don't compile-time disable hardfloat for PPC
 targets
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> We happen to know that for the PPC target the FP status flags (and in
> particular float_flag_inexact) will always be cleared before a
> floating point operation, and so can_use_fpu() will always return
> false.  So we speed things up a little by forcing QEMU_NO_HARDFLOAT
> to true on that target.
> 
> We would like to build softfloat once for all targets; that means
> removing target-specific ifdefs.  Remove the check for TARGET_PPC;
> this won't change behaviour because can_use_fpu() will see that
> float_flag_inexact is clear and take the softfloat path anyway.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This makes ppc no different from the many other targets which clear out softfloat 
exception flags after every operation.


r~

