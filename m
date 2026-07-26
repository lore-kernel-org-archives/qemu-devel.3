Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE88C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 18:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo3TM-0001YZ-RD; Sun, 26 Jul 2026 14:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wo3TK-0001Y8-Sa
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 14:21:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wo3TI-0005cK-5Z
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 14:21:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so1080494b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785090063; x=1785694863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QDU+ZHNO7rWwr1cOhbdM2Jjjk98f1gVA6Xi2z07i7yo=;
 b=kHc1DeM9Y+Z5J5int+Aw/AgI58WRaPfk4kkIXiniOsSd3Jjf7XW4FxkejBGcvgD4nk
 G/RYtTHTfEavAW3VZpnz09EBqNiNa6amFZCBE/H/t8gpy0gbsj3CdoibkDgou4H+rRiO
 l5H7Y1T1QHtqQJtdYlOJjr0Xs9aPsf2Pb5DU3/V2Qs0gq5oJUEzl/QP1RxEg0qSS+jPS
 F/gzNS4Tmr56n+EAm+yGs4hqQI6v9zoQIPKS/OAZb61xfQ2i6fYbKogRZl4Meukrt5qq
 SOsJ9RmfCa8fwzfIUglrVWotu0qnORKuMu+xI7l0+LSFUmenX3fvAMx8WbIuOUVPJPU/
 Zb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785090063; x=1785694863;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QDU+ZHNO7rWwr1cOhbdM2Jjjk98f1gVA6Xi2z07i7yo=;
 b=lbx1oyeLzq63rj0XP1/39XpDWQtBI40kimvpyf3BO1CIq90MmkN7CrjdPRs//xq5tE
 iSdSpWknk+z1tc0xFN93vf+ZChPzmmNvcjwH1WX7ngFU5Xa+kiJXzD8m7OeCJqRqR4Sx
 M/+8cMrj5UIQZooXSnVJ6OnCVSsY6Z8qjKK3eUlEpzrRkctKlWmbdSo45HT0XK5oMT8g
 LhkpgE5+qeD4lxbhUWVhCPX2eWtsgoUqZqTdyZf134WbyWLWp5Q7caMqf6ysaGLovu0l
 7w8xKMlJSnyj9r66iHf5GK0m9KX7nvwENP+PrortgmNRG+NSOVSOiI1AI+W974HhtS94
 BAnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RppNdUGJfM9e8/8hx6Lx6AQueBGbBlMi03Czy1/oJP0rBO0KFwSnYBuANvP2lGN3kbIwjBbKtEGwT1m@nongnu.org
X-Gm-Message-State: AOJu0YxBaooY3t4GGb89XY0IgIU8DNu2V+bkzH92PanYUjInlmYFoIy1
 /xnzvh3lZb8T+u6+2AnJkYBuz/marlpTZ9KKcd9Zq8ZA6OVQgLucMZ3g2GOGC5e5A/s=
X-Gm-Gg: AR+sD10DRbAgGdzs5dD23Gr8VPl1txvioL1aTaC4DbzoXpxcs1+ubo7JDckW5SYDE5g
 LgMJW8lQr68RWHVve03OAyFGBJkRAYWuJ8fghv3XOfIo1k1CINhjUc2q17mXFqqsC0qplGxE3Lj
 4kjwE8yxAc8XCprx2AqD7oFTdOvB65GaTVz77VlezqTVVvmsIkhwhJNkgbSuSLQJXz1g3vHcHbN
 dVQXIMWy1vKKD/s74WPLJr86+9JVHXEHpWGlxFjK4Q8Hqh24VOYc9xOfksK8Qe2ECWpxRAzRcRl
 KSG5BnDDiuz+o6bi4nvOX/oCUQAJ1IwYAMOhRAr0Nnz6J6efteE7iN5pCdexjq9Hm5qoiOJkIT9
 rrHR9LPVluR1kfm9TUqmiDfm/dsTENZWc7UulszG6u5B05mz40fnyv1KtXlec5Jn1T2lruL2eFQ
 Kdw5BvWVoMXK/3+GCh7hJhiQX1zI/b0gn+Sx6Ke29TTQ==
X-Received: by 2002:a05:6a00:852:b0:848:2c6c:dfc0 with SMTP id
 d2e1a72fcca58-84e59443916mr4435550b3a.24.1785090062991; 
 Sun, 26 Jul 2026 11:21:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5327f54esm1987311b3a.20.2026.07.26.11.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 11:21:02 -0700 (PDT)
Message-ID: <484d9db5-7602-4f1f-b323-0ba0e5c86219@linaro.org>
Date: Sun, 26 Jul 2026 11:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: do not trap on Inf inputs to bare FP
 arithmetic
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260726005601.2513662-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260726005601.2513662-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/25/26 17:56, Matt Turner wrote:
> helper_ieee_input is called for each operand of bare (non-/S) T-floating
> arithmetic instructions.  It was raising EXC_M_INV for any value with
> exp == 0x7ff, which covers both NaN and Infinity.
> 
> This is wrong for Infinity.  Infinity is a valid arithmetic operand;
> operations like Inf + finite, Inf + Inf, or Inf * finite produce well-
> defined IEEE results with no invalid-operation exception.  Only NaN
> inputs and indeterminate forms (Inf - Inf, 0 * Inf) are invalid.

No, this is modeling actual Alpha floating-point, not IEEE arithmetic.
Only normal finites are handled in hardware; everything else needs software assitance.


r~


> 
> Indeterminate forms are already handled: the softfloat helpers set
> float_flag_invalid in those cases, which soft_to_fpcr_exc converts to
> FPCR_INV in env->error_code, and helper_fp_exc_raise then raises the
> trap.  No pre-operation check for Inf is needed.
> 
> Change the exp == 0x7ff check to also require frac != 0, matching the
> existing behavior of helper_ieee_input_cmp.
> 
> Fixes: b99e80694cc6 ("target-alpha: Raise EXC_M_INV properly for fp inputs")
> Signed-off-by: Matt Turner <mattst88@gmail.com>

