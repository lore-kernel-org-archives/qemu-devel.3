Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D633C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ghc-0002yX-91; Tue, 22 Apr 2025 12:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GhZ-0002yC-18
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:42:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GhX-0001Ct-97
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:42:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso40792305e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745340145; x=1745944945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I21TOI7gIJa0hjXmFS/44hwgj3br6ssziwzPH+VG4hc=;
 b=fGjIiEJyrTl1PBIxhC6qM3z+9tqhledZl3e0YSPAr49A6gfNniHY2XNFQD4HxA3Mc6
 TQ0WGyX4kMxT2twBZ9udHtz6kxtGaSnTZBoGo0Zs/h4V7RdaM1DsEoKysuv4djOxIyOL
 XioC/hgbFpAIekznQ2jJSplhvzcjPb0Nil6lGcD7O9XrIiHAp+YJwPad+HNapWhR0zRo
 nX7TkVQRbHm5Q8/Bl52VdEhL7qJEsV8XIaWyUz+fW5RB7492Bwp4/b48QcxPEvAT1oLT
 dEQLjk9HmzGa+KlZZlUE/boLLU05Ml8ZeajUPF3Yc1MVUaKboa5axv8ZfxjpnFIFWOMr
 5VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745340145; x=1745944945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I21TOI7gIJa0hjXmFS/44hwgj3br6ssziwzPH+VG4hc=;
 b=jxmG2jF4lv8cBCRp5jat0FFOUzQtLZGxUiWSp3tbfBVniLTYfYjzUtTvRFY3LKGC81
 DHB8asMVArnqvQFAEE41BlV4n+BKvucheQX/sIoHVnzAz1zAWhWSxvVcPB6yCYGJ4cFD
 dI8QMFS2geckC1BchMYz4RFLrldWvRNgk0d+QKnJvx4Qq2ojuN/i0LhAQsXJutxCSSEo
 KYse2MTML5kJB98gyuksJ15fUaA7mx+HgaRABHdgvhA+imd+liRonv0I3j1+3GSLMFrC
 WPDz/ci684o5JzpkCv2umcjR3H0ISWSfn2YItidAMCOMxO5iQzv4qrgivmp2ev0hWYf7
 4ROw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSOC3UmH0lk7RSgTVQGulMJDaFJ1gjq16WEwGvIvrNzk1jXB75Xq1jvpmLK8RHyFHo07IVg69FCXOB@nongnu.org
X-Gm-Message-State: AOJu0YwHSXsGgWa8L608Dq41CZTNhnqUo/s/93J5jq2SAX7lf8rHjas8
 58loRsqrdpDDvoEitZsOK+1dhWVGKaMA62nANTexlHfj8L/O8HwazM7sOabwwHSga3vRid0ml3L
 T
X-Gm-Gg: ASbGncuxd0lzaDfi2QNgklq1/G54cZBnXMR7U3a6AWI1cCvI57hTbNsg578k9T/tzCh
 VPKUV1ZlHtbcPH54mbCga0fqmxKTN46DOEvxWOBMdCSM6ocmzpwa1fAo2nmxFYgdubdpzcOf+Fy
 wN1gfN1CprkAaol3D0c9xCd80EUVl/PpcTCYtgj4xaBdE/lfPdKB9J0pCZL0w+4c0UPG3Z+b91p
 JBOVoWHkO421xvpKcZ535f+fPV/ir4Qt9ehKk6QvBiZHhekvwH1DNFRIQSvcOHEkDSEoqScbUVZ
 DYJcm9XSMzLQxt8sHFZfr/fEqWdFIjJax5cNNGeuEuNAwjEPy2A9eoPcpNnSkLte7cu4RFDKvHz
 uC5ZEz1eB
X-Google-Smtp-Source: AGHT+IEpPDAa/eCLtFKn1JlKv9UGTSN1c0HY1WBLWd86ZkoCPI8dlr31jaCDdlK2RgV+sXslHsV1QA==
X-Received: by 2002:a05:600c:3555:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-4406ab7efd0mr156016425e9.2.1745340145491; 
 Tue, 22 Apr 2025 09:42:25 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db131sm179446685e9.28.2025.04.22.09.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:42:25 -0700 (PDT)
Message-ID: <1d6adf81-15fe-43c5-87a4-45974e6a8a68@linaro.org>
Date: Tue, 22 Apr 2025 18:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 149/163] tcg: Remove add2/sub2 opcodes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-150-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-150-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/4/25 21:25, Richard Henderson wrote:
> All uses have been replaced by add/sub carry opcodes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  5 --
>   tcg/aarch64/tcg-target-has.h     |  5 --
>   tcg/arm/tcg-target-has.h         |  4 --
>   tcg/i386/tcg-target-has.h        |  5 --
>   tcg/loongarch64/tcg-target-has.h |  4 --
>   tcg/mips/tcg-target-has.h        |  5 --
>   tcg/ppc/tcg-target-has.h         |  4 --
>   tcg/riscv/tcg-target-has.h       |  5 --
>   tcg/s390x/tcg-target-has.h       |  7 ---
>   tcg/sparc64/tcg-target-has.h     |  7 ---
>   tcg/tcg-has.h                    |  2 -
>   tcg/tci/tcg-target-has.h         |  4 --
>   tcg/optimize.c                   | 87 --------------------------------
>   tcg/tcg-op.c                     | 26 ----------
>   tcg/tcg.c                        | 36 -------------
>   15 files changed, 206 deletions(-)

Missing doc removal:

-- >8 --
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 93bcc706399..bef00ad835a 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -654,14 +654,6 @@ Multiword arithmetic support
           code generator will use ``tcg_out_set_borrow`` and then
           the output routine for *subbio*.

-   * - add2_i32/i64 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *t2_low*, 
*t2_high*
-
-       sub2_i32/i64 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *t2_low*, 
*t2_high*
-
-     - | Similar to add/sub, except that the double-word inputs *t1* 
and *t2* are
-         formed from two single-word arguments, and the double-word 
output *t0*
-         is returned in two single-word outputs.
-
     * - mulu2 *t0_low*, *t0_high*, *t1*, *t2*

       - | Similar to mul, except two unsigned inputs *t1* and *t2* 
yielding the full
@@ -953,8 +945,7 @@ The target word size (``TCG_TARGET_REG_BITS``) is 
expected to be 32 bit or
  64 bit. It is expected that the pointer has the same size as the word.

  On a 32 bit target, all 64 bit operations are converted to 32 bits. A
-few specific operations must be implemented to allow it (see add2_i32,
-sub2_i32, brcond2_i32).
+few specific operations must be implemented to allow it (see brcond2_i32).

  On a 64 bit target, the values are transferred between 32 and 64-bit
  registers using the following ops:

---

Updating docs/devel/tcg-ops.rst:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


