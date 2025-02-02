Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19642C02190
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 17:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tedbE-0007S8-4O; Sun, 02 Feb 2025 12:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tedbC-0007Rt-Ma
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 12:17:34 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tedbB-00026P-6l
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 12:17:34 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so67856695ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738516651; x=1739121451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmv2kD/e59NDsf8Ka78HSOPcycVyc5ffIZlOrlAJH38=;
 b=bbegqnIOwSxWLl0EfzHQhYMFMT/TiX+FRAHzeowLBx+r9w46JqiVtzqp47ggsGTvRj
 ML/IUoRYrlUFpDi/gwonDtzfrLm7HOU1MwM3mtGo5/24j/7HHvfs8ozrRD4W5mEZF2O0
 k2bPwWJd0uSprxOh6n6ioCNdUuKA4ZqrGLGsqEeIiGhmTUz03bKxm6mv/3j2cp2iLtTR
 LOz2dip/tgMnNf2jf+lxjGE9JJvvmPaVXXeF0K5ROJx2CRcNO9euBAFeQIHTo0JMEbs5
 7ol2M9Oafiogi/Rp8L8QSb6eIRxRZHLFHvRfLWI/5vUXk7qliY//cf6xs6xaYKknwZFP
 vZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738516651; x=1739121451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mmv2kD/e59NDsf8Ka78HSOPcycVyc5ffIZlOrlAJH38=;
 b=q6VQtYQLe6Xg1xzdD+3B7EsJA62373b5G7FWi6GXgOZFXfGPH0doc/cgTeJhxgnXWE
 F07ZfWI1MNbVLk74ad3qRW3vHV57v4UXPL9orpdehxU/OlZ3xl1zqSBWWqFAj/26jEB6
 TIGY4o7QTlr69NW5yuW+PMx65wGEylh7XRj0FCzyHdei7mQWaJe4rXRtCxisOfWJ9EIb
 lfnKPQHfMJFl/LHRSIji27Lq/UMri+kqSFk+8fSw7yOnHYGa4fJbPm4vxI8Lv8M7sBVS
 RdUubkZyvJPn2nJUeGTQ7sAYAgMA3KNCqJHoLRz8x6ZjTiVaCN5oQpxK5P84sope6dUX
 WkNQ==
X-Gm-Message-State: AOJu0YzyrXeKoqfn6H8Ma4YqSQx5z9I2w3bQTbQUgKw3qCVQr+kvM6rK
 t/ssaKMRjLL2VE6wHxTg0kSL6bpC0IPvVcgYRhMO+6B291YeVjDM1AUFzicSv5bgvdDOdmfsm0Y
 v
X-Gm-Gg: ASbGncvTRP0pbISdAUfPGTdjq/Z31B9k5I/m5PK8EQ26bq4JEtOPiANHrXJI26j7DcI
 6EI+bRT39GrGiS2Kv8kQLCVrWZePdyIwuexZ3zSeFrmcFTnzF2VW97YrmF+xR+HvlMmxYGAkjgV
 ImQ0T/y2VZmx+Ac6X2v7ZzMj3kmLhdaEiaZjZcf9bQBf/Wpp26M6X0z+qcuNKRbbN6ORc+/GqYa
 /LlWI4KrgeCPoTR4YqubSmetzdzPVC9IbkmNAXTfabYy8x16c4UYgpX2lONS7rWBXZfFcm5dqDg
 5Mrym0+SBm1QgKURYfS9Pvn7HWllRBKeNuEhuZYDi06YVGZwTcNarR0=
X-Google-Smtp-Source: AGHT+IEn4VMQxKoE+BllIIiyTNJ81AFx0WWsyvCLdzt3FDNEuuYVfKoHZ5K4MwbPosr28KKryHr90A==
X-Received: by 2002:a17:902:f547:b0:216:31aa:12fc with SMTP id
 d9443c01a7336-21dd7d78f90mr326497815ad.24.1738516651468; 
 Sun, 02 Feb 2025 09:17:31 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de31ee753sm60673685ad.3.2025.02.02.09.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 09:17:30 -0800 (PST)
Message-ID: <f5855412-571e-4138-a7f2-53d8b3517c82@linaro.org>
Date: Sun, 2 Feb 2025 09:17:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/69] target/arm: Handle FPCR.AH in negation steps in
 SVE FCADD
To: qemu-devel@nongnu.org
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
 <20250201164012.1660228-38-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250201164012.1660228-38-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/1/25 08:39, Peter Maydell wrote:
> The negation steps in FCADD must honour FPCR.AH's "don't change the
> sign of a NaN" semantics.  Implement this in the same way we did for
> the base ASIMD FCADD, by encoding FPCR.AH into the SIMD data field
> passed to the helper and using that to decide whether to negate the
> values.
> 
> The construction of neg_imag and neg_real were done to make it easy
> to apply both in parallel with two simple logical operations.  This
> changed with FPCR.AH, which is more complex than that. Switch to
> an approach that follows the pseudocode more closely, by extracting
> the 'rot=1' parameter from the SIMD data field and changing the
> sign of the appropriate input value.
> 
> Note that there was a naming issue with neg_imag and neg_real.
> They were named backward, with neg_imag being non-zero for rot=1,
> and vice versa.  This was combined with reversed usage within the
> loop, so that the negation in the end turned out correct.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> v2: Squashed in changes from RTH's patchset
> ---
>   target/arm/tcg/vec_internal.h  | 17 ++++++++++++++
>   target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++----------
>   target/arm/tcg/translate-sve.c |  2 +-
>   3 files changed, 48 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

