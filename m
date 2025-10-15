Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5268CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 22:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99c1-00051W-1I; Wed, 15 Oct 2025 18:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99bz-00051G-TG
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 18:04:47 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99bx-00086B-G9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 18:04:47 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b5526b7c54eso17888a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760565883; x=1761170683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1z96bIywR5shVlPsJ7peuCpTcPlxu2HcCRYSeliNuLw=;
 b=Iiq6HiIirjWwGocn6hMN68mX596M91df1hXtTIwNhXZVzZwnhaQNbq+8uTImarTBsl
 7VN0kl8LkscJxtx++6NpZO2rzd+lVp+d9dLOJYID16qFv2Nyao0hjF3aaatiRVYy4ikI
 l8W+JfzWT2Hk65+bmRs0jUGWI8dbMUvovP0zfJSSLe9mI87raC2aM4t/vIb9O/OaCzi3
 Jnfb6bBIe5Ki9ovZ8hKeUuGF7DT1vLP/jeMEWzX2uwMH0YEx/9qF3uJUmnnll5j4m6Oq
 BOv3vD4gRfg0qKwO/cdsCPv9TnIXFDy2ZEq0pYDUxqiY2ycltJ8ooeXV1v47ZBPq0JC3
 lHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760565883; x=1761170683;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1z96bIywR5shVlPsJ7peuCpTcPlxu2HcCRYSeliNuLw=;
 b=w5ZN4eorekr2wx8sD0Ubce3c0yYTr3qIbxZtkyIXK7qLo0XUu24YF6CwRkkzCjB0nn
 OnzVnaiTbYrwYQOCxNUYIw0K7gG1zfuO4InLl50Ldfn7pSjKc3LT1MPr25bAX6n/hECk
 P2UsJn2e7fMJKt9YbZVWV4Z2cstyCadUn0NzIbi65WL+6Fizv+K+Kq4deDJpdpputXlq
 Mw0sMUulwaFe6hGsWiuiI4XwPEC03g+6vjSQcxMxDGvhIivy7hqv+snFXeONDueGyZh9
 Hs2ozYLEWQEEoJfkZXyXgDJQfHjBUB29D54v5+Ba0bdpOWDuZG0HMtUYu9W1Mm3N7s0Z
 j/PA==
X-Gm-Message-State: AOJu0YyLZvyTWSfroXB+DJReg65oxxL1+nrgF1glwWoelU1hgH0zkwZs
 okq3aBn+Wmx7Bb5zsStEHZxx5aMCd3Kfmh6XVxKq2dwOdp39LahhCcN7nYDJiOryBWYuKW4Ao4u
 5Q062M6Q=
X-Gm-Gg: ASbGncvMr8r/YBTrlW/mH+wGqgBN6/NCO1qz54S2RiQhBJPFRAi4Mpqm6mTRwQ8FbRv
 QVkJZ42sWmqbq8UiPCgEWT/P/S/xs/glIClucHLIAqVH96fYjP6u0mfgvQsxVRGoqNRlzP+wMR+
 MNfhAXMzncUHOuBhITrngi6tNXfmU0LHoV6Q6Bl7f4ip2ut4HkqUVpS2HXqrcCj5FO1DM+O6U1f
 5fI3SF22SNobOmEbdNc7x1yDFgNEsNyEShFOzRJmgelfe/K8KL0qjO1hjW30qWo/lWt/vplOwT/
 bP3DB8AsMO+7kPAEB0+ch6SNhKGiks1fC2sp6l5wRZhBIQ2J667/ZkPOCl1dT/M1XEIPhfP6/jk
 jsQpg88Ybwm6wPfAes3lZlZKt4dBMNIpuyc3dap3bqPuZ4m7GMNArAMCduQ+4bUMMU1iXh7iUNJ
 vfXKZ99CrnZayxeVuNavA79D5lYqcK
X-Google-Smtp-Source: AGHT+IH/Uq1QbXjBDfuBYou2JkzCDeDAD3nzsQo8s873vWaOtK+FGa54l2Q+GgpK7KMRGlkgp4v/LQ==
X-Received: by 2002:a17:902:e841:b0:273:59ef:4c30 with SMTP id
 d9443c01a7336-2902723a7ffmr431655335ad.15.1760565883032; 
 Wed, 15 Oct 2025 15:04:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099343065sm6845935ad.26.2025.10.15.15.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 15:04:42 -0700 (PDT)
Message-ID: <7d438479-d30d-44f5-8124-29bb56b1fb11@linaro.org>
Date: Wed, 15 Oct 2025 15:04:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] tcg/ppc: Remove support for 32-bit hosts
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-9-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015213843.14277-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/15/25 14:38, Richard Henderson wrote:
> @@ -4278,14 +4056,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           tcg_out_bitsel_vec(s, a0, a1, a2, args[3]);
>           return;
>   
> -    case INDEX_op_dup2_vec:
> -        assert(TCG_TARGET_REG_BITS == 32);
> -        /* With inputs a1 = xLxx, a2 = xHxx  */
> -        tcg_out32(s, VMRGHW | VRT(a0) | VRA(a2) | VRB(a1));  /* a0  = xxHL */
> -        tcg_out_vsldoi(s, TCG_VEC_TMP1, a0, a0, 8);          /* tmp = HLxx */
> -        tcg_out_vsldoi(s, a0, a0, TCG_VEC_TMP1, 8);          /* a0  = HLHL */
> -        return;
> -
>       case INDEX_op_ppc_mrgh_vec:
>           insn = mrgh_op[vece];
>           break;

There's another instance of dup2_vec that should be removed.


r~

