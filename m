Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF03C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 17:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ued34-0000i0-Ho; Wed, 23 Jul 2025 13:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ued2u-0000gI-Hv
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:14:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ued2t-0005xF-51
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:14:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23602481460so647475ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753290861; x=1753895661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e885qokl/Dj5nbKl/OsX10/+RB/c22InHOgrvFRoTQE=;
 b=t1AiNPHauxqyqTI1M1aUBGb6F1nYGcCa6b3TJtIMTbqKHw+t3ZxyJvcujzwlUZGiqo
 s6eRzR2eHsCwbBl0oDFX7w8PqCvz5JWLx7MbaaW7U2TJrQ3kUbB229SKVWJxLlqJb2yc
 5TMDqJ8StO3uEsoyEnRgY29nqOYTmGA4C8By6F2LpnMPKXIGYSxlFUDMwKLbHz1DcA6r
 bfqZ7dBM9jOvIehS6EaKgGftraDjNapwoT9EQFC6mIJQ7Ac2wODtHjWabT6ZiQxjDoM3
 gOXnILJfPNFc1+MQN5xk/rviX/rUUIlUP7mCmYG/+AsJKrGWLRrcVqcXBszSqgrdWkQ7
 hDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753290861; x=1753895661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e885qokl/Dj5nbKl/OsX10/+RB/c22InHOgrvFRoTQE=;
 b=Pe3ynFWuheW6nk470fLXZcENWjHlY3OzmZzt11ffvCjWI7ubV+jChjcJwOSbNwon6Z
 4h0EoTQFVAG5be9hTwXcgfnOCJR4MI5tnA73O4u6dFlwakC1pYEToECuDkOwD+tdgVNa
 6SQWOjKZ/FWCtpQDdwPtOBtvoFxukIlo/nVxDfduaAqHgHwgB6+5fbfgtGhCfxdSfGA3
 TFCSW21Jm9J9ePVQGLKxKL7YQVw0wXF9S9Ur0KRYx3OxtYJ+l8/34eBlLw4mLmiNP39Q
 iA6w6VZ0u3ucxJmzt/MeKKrFjrE6UG5cDpZuTv9YcxWGw4cUTOrX5A2sUv2u0/TJRbdW
 ZM1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRne8rW+Q73HpfO1ba0/0FVkkGSxoKyPw2fTm5eZWh5SsV1GrtQ7BhlrsuhygweMTXSd3U7v/GUuS5@nongnu.org
X-Gm-Message-State: AOJu0YyBF/Rw6wTaeiIKQmRtg6H/pvamJ5nc9/OabmqLC+NEGX449f0j
 u2ozElniABZKMsFfETN6atEfHFDAcQ2zFIFySKrFsqZyYMagzetc7gCOziyxLuY5t7w=
X-Gm-Gg: ASbGncv3xrAxZyRvzenkR3jaUSK1xGmFqiS9OHrQUJVdQvFlvr9/Kz10IkC6I/NPE6R
 xct6hFVfQh3s54DTaRxS6zEbp5dBO0lwS+tpyHUra3utfCWitIUWFhQc0Kt53GPcYKx+VgXPePm
 s6uU4uQFNKtcs3mOzqLEq8hgGttNMe0TU+UhL+Su+qZD7hDHmBtNOuVlYbKA4oBQ0UqalnwQesV
 R84J6tu6D/ijb5H31zu177rNWoIg719CLbYOQSzk0XcsGTwA6R7sQHq3lJHoyI7520c0j3E0+OT
 Pm8nATiUace95pQvfNlNeQFSlTsKHnVdX6Mvy5MaLfiZwymS2qW29o8JjkCv6MmwoG1ipjDm158
 QxO1BtYzFYWzdT+/Yi08q1JCneJfYJz1JhodR
X-Google-Smtp-Source: AGHT+IEBWmhyBzoe395q2/+evgAb/inFstpQzHziCz6yunVelrQGjZYFK8EOCpeAqYcI2s823Hsjhw==
X-Received: by 2002:a17:903:230c:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-23f9823502fmr54125655ad.48.1753290860764; 
 Wed, 23 Jul 2025 10:14:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6d723dsm99793845ad.166.2025.07.23.10.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 10:14:20 -0700 (PDT)
Message-ID: <4a887ef2-6ecb-4311-9aa7-45002dfe2fe8@linaro.org>
Date: Wed, 23 Jul 2025 10:14:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 4/6] target/arm: LD1Q, ST1Q are vector + scalar, 
 not scalar + vector
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
 <20250723165458.3509150-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250723165458.3509150-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/23/25 09:54, Peter Maydell wrote:
> Unlike the "LD1D (scalar + vector)" etc instructions, LD1Q is
> vector + scalar. This means that:
>   * the vector and the scalar register are in opposite fields
>     in the encoding
>   * 31 in the scalar register field is XZR, not XSP
> 
> The same applies for ST1Q.
> 
> This means we can't reuse the trans_LD1_zprz() and trans_ST1_zprz()
> functions for LD1Q and ST1Q. Split them out to use their own
> trans functions.
> 
> Note that the change made here to sve.decode requires the decodetree
> bugfix "decodetree: Infer argument set before inferring format" to
> avoid a spurious compile-time error about "dtype".
> 
> Fixes: d2aa9a804ee678f ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve.decode      | 12 +++----
>   target/arm/tcg/translate-sve.c | 65 ++++++++++++++++++++++++++--------
>   2 files changed, 57 insertions(+), 20 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

