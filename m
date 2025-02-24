Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A537C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmf3G-0003en-UQ; Mon, 24 Feb 2025 15:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmf3B-0003eI-Kv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:27:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmf39-00008T-VH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:27:37 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22128b7d587so93940005ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740428854; x=1741033654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6kQ4fP6I7W8y+aobU7UbgCaxlk1JveuMEMhxoAelzGY=;
 b=RhHYwLhNxDH6aYkwHYwMNkU4g+BWUtwpxnUUAW8hhNEajNw7yHVRAOPvliIVo4uZoN
 NDrBM+WtiNnE5G1YYqA+rbaX2Hfww3jdO+HIOq+JVykAG6XvMPPxAOQRmZb1nY+oduxc
 6t3KgybRiDDeYa5oopcJIM6z9asgFowaCEahNoxUd2++iPGnACLrv4gmhfr7uJTfpQ9T
 vITKYihELiPkJKySUdIsyMmyQDaNnOQlhYGCTjqHMLzGHBFO8IJLuDamrt+nXwuinqx/
 bdDbE812SO0joLQe/5rA6xV5JQS4Jz75QgLqNIyJOYo6cRV1wA8Op3aZW0T7vQ8ERWSD
 toZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740428854; x=1741033654;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6kQ4fP6I7W8y+aobU7UbgCaxlk1JveuMEMhxoAelzGY=;
 b=aoilI9tpKD+8QpHi8wauXCjDp40OaBR0CWF4aRmhA/Crjcyira2tAZ2ZLjJvMbZid2
 f04nlUFHttXZ79S8sw99SiDRbGOHd2cCVy+19x93j1/RLtUMmtbUndojihWuGg77qwTy
 Y05CCvCSaqAdlgvrL4BSmHRWnY8VooteUdyPus7fQfAHH2y54IYzTtttaPw3tST/EXxy
 yUemhvnoC84rnW7ZP9Hw5FtjmjZYhKmDIT1n8Tvw5F2VX5KPKbBXeLxONxV1GN/56mwV
 FxpD/+HJUswhXcPivewU8+NPHrFa9DkKMV3LdgPsfCnhAFLrxL9f2s0yLE5qqd49RAfo
 dpkg==
X-Gm-Message-State: AOJu0YxqorMpPi88GkXIxTxppD9UZRRSD5bbNAuhRN3DkYOi6R/9UORX
 VUioeeQ9NQO+0y4qtANe5Mckj66Bqhpz1blLniMU2J6dB8SXYTgQLm1G6flk6ug7ClpQlowoznn
 K
X-Gm-Gg: ASbGncvGoc0pIjF/FqFVEg/YYd/oUbvi7UPVozhfU9aZqQBHMw5WZqLOjrNz5xfYNNQ
 kJf2mw6EAAHXko8QcDpsFiuPmkQG+/E+GrHHv7M4i5kd7UlFbynS56crM6jsMPZIqYwiovqUgHt
 5jD9iNzFNNjJwX1CNI3IqezmKw8Id3mzAaR2CO3iwMT6Xh0V/pixxnXRBrwo00Nb3TPmlpTLVoe
 qVnKBhP+7xjM9nys51yARvwCgjmOskwph6EjUZn2reqn6VBJbOYRaN0i5qu/28tPfnVxhjsIpdX
 F+7TYqz97uq7NLcC4N8gi3XEYoibCmYy2+1XrPyHlNPMr4av4SwQ4CULzUlQIkLswDCnjz4jnxv
 2ibmY8FU=
X-Google-Smtp-Source: AGHT+IEUtVVq+lHRBZo8yidrKN9wdBqSv2K3HgFifdSFkkqp0v8db0BvQM+cUHc/F4+tI9qNL1V/fQ==
X-Received: by 2002:a05:6a20:9184:b0:1ee:ce5b:853d with SMTP id
 adf61e73a8af0-1eef3dcc063mr25751423637.39.1740428853830; 
 Mon, 24 Feb 2025 12:27:33 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aedaab2e9casm46566a12.67.2025.02.24.12.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 12:27:33 -0800 (PST)
Message-ID: <9e0853e9-b590-4a84-8214-fbb543bd4359@linaro.org>
Date: Mon, 24 Feb 2025 12:27:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/61] target/arm: Implement FEAT_SME2
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/6/25 11:56, Richard Henderson wrote:
> Based-on:20250201164012.1660228-1-peter.maydell@linaro.org
> ("[PATCH v2 00/69] target/arm: FEAT_AFP and FEAT_RPRES")
> 
> This implements the Scalar Matrix Extensions, version 2, plus two
> trivial extensions for float16 and bfloat16.
> 
> This hasn't been tested much at all; I need to either get FVP up and
> running for RISU comparison, or write some stand-alone test cases.
> But in the meantime this could use some eyes.
> 
> SME2 is the first vector-like extension we've had that has dynamic
> indexing of registers: ZArray[(rv + offset) % svl], where RV is a
> general register.  So the first thing I do is extend TCG's gvec
> support to handle TCGv_ptr base + offset addressing.  I only changed
> enough to handle what I needed within SME2; changing it all would be
> a big job, and it would (at least for the moment) remain unused.
> 
> Still to-do are few more extensions for SME2p1.

Ho hum.  I've missed the entire set of counted predicate insns.
Hooray for Arm sample code!


r~

