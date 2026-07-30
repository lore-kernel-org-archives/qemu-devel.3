Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEADCC55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTRb-0007bR-V0; Thu, 30 Jul 2026 12:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTRX-0007av-0C
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:17:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTRS-0004BQ-Qw
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:17:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so56024b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785428225; x=1786033025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YJCUaCZpPsqcGs3L6CzVi84Lc0EVbnB+sExoMp4lt0k=;
 b=p2mRSrTeKTYAOgH5NFkFS+6oVU8ZE0ecBCbtcVpop2UeGRTST3Agq5x6kr/ezhfViY
 i5aJ5ES9rOF2fByWLYtePRhod1s4K3/7Wm7SqEEBfHc7zNnnOy+AFOV6wlM9nD+NZ0Nh
 YbtjLOcAnfPq4v9cI0+fUN27LPDey7Ga6wFSM9QfUxTAeZ3XRYBk6NW0G1MPLRdCXE4k
 qjikWHODEOV1IEi1wstD8On6nbRnRyWCuh6bJhhGDFOjNPi260M0rGR4g+eDPh/sARxx
 DZHyKYdjV7xOpU7PUinaz+7q4b5EFodL3YFhaXi/0xoxdFYTdoB5v0SoVoEC/ePTQlbk
 JwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785428225; x=1786033025;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YJCUaCZpPsqcGs3L6CzVi84Lc0EVbnB+sExoMp4lt0k=;
 b=pN/s5qjl9UOF/95X7vW09SSmSUyUbGtffUm8/0/a6U+/lv37rjXhzZl0B0iWFVySfP
 v2R0BVdPDACcR2WSIoq6Hg35bNoik4iHvxJAhFeLWgz0xMfFVSJ/E45hIRKY+Key0v/d
 xW6HfEfzesjbVbex1CS29edcuk9qSsM1/jXwMu+sJV63pCdqeKV9l5rf+7vkqUkjstpO
 1rmxxiuR9Tze7TNcEO6nyQNTLrHJs3y1/cCFMV5gE9zIJJOTUnd5+HRhDPbKnxswSF+/
 1fVn95GlNqYAYuAzISkrkwu4Bj6GYkb8Hk7++vwGxrda9mXRyFj2fDUen0zzXUa96dah
 lVpA==
X-Gm-Message-State: AOJu0YwoM9qQQXEJH63xGIxF41eMlw1i65fWn8OW5y4rRW9kW9L0WMUE
 62crmuKKv8uWvxHQhzhz63FNu4R514phr6v6fQur10AleEUYbfB3PrlqnREkMImhBBQnyrLXSbW
 wBHuu
X-Gm-Gg: AR+sD11/EZ6scvEnIvpCOjk/oB3uDu9H0kXbCIgdEG+KI9tE0fS+xNdFaCVvGvJg2fP
 dTcCWU/vUUBzYViSQZV4qpXzNhVfvuB/3CjaSJBjhvvBZhBXCCpU65YA9DANjeXRFjXDkSWsWcR
 gelMSPOcdjqz6KB+DXY15gdxJiIPnK+qkoRBlGiKSsdfmeqTO2eiPW8ieqjBRL8grK03p95m8eW
 BDlm2dqmRG3d6wAf+V33izgGvViEGt8KU49ArB58BEcVZmBqT/JBFQzqq/hmw4wVmlCMh9ZGSRf
 KAVwu2V55E0uxPY5+pe0wDHSLEgxuGzUX8g13VX7g51zbDGp71YLyFqn2IpAdvONfmKJyot1T6E
 5jpqpGHVF1O+/ca6JW53rFc5Y5hLuGa/kKuMISMPPeDu6x4KOIRFd+uGDaU+yavDpciOxX9c8Dg
 hWmk0dEd0BqSUpGvGvcrIUyMPanm3wconZlehCkDaaqOTu1UfEBIjX9HNOHlr3EsvVyLZmD48Z1
 xQQD6hLP/q/3HmqmS4GKeY330U/
X-Received: by 2002:a05:6a20:4aa8:b0:3c3:ad17:eded with SMTP id
 adf61e73a8af0-3c90064943cmr2413678637.36.1785428224958; 
 Thu, 30 Jul 2026 09:17:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb83459f6sm2380634a12.14.2026.07.30.09.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 09:17:04 -0700 (PDT)
Message-ID: <a42c91d2-38f9-4c1d-a2cf-dca538efe470@linaro.org>
Date: Thu, 30 Jul 2026 09:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/50] tcg: Expose tcg_gen_ussub_sat()
To: qemu-devel@nongnu.org
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-6-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-6-anjo@rev.ng>
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

On 7/29/26 20:09, Anton Johansson via qemu development wrote:
> @@ -2399,14 +2399,14 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
>       tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
>   }
>   
> -static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
>   {
>       TCGv_i32 min = tcg_constant_i32(0);
>       tcg_gen_sub_i32(d, a, b);
>       tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
>   }
These aren't quite general purpose.  The existing formulation "knows" that d does not 
overlap a or b -- which is true under the limited invocation here.  If you want to expose 
these for wider use, you need to fix that by allocating a new temporary around this operation.


r~

