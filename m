Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44B7C56207
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzIc-0000Xl-ET; Thu, 06 Aug 2026 10:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrzIY-0000Wd-4f
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:42:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrzIW-0007sB-H4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:42:17 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2538892a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786027335; x=1786632135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qs5R1aUFxgwmeT8+Q2Asst9hHuZgv/4kxC+scSrEHno=;
 b=rq3S9sp2ncGPq8Sebbah0oNTMln0diGt0+5LACYC14J9vRNYO7LWUhhctnEDpa6MJj
 Z/zQnI1hU2RTMzNsiFq9hbVC9mgpth0TrVo4TgUVxQZ1J9AAgNGwTdwo/ga9mktSbMbX
 WNc2tRWzZSMUpuSjV84nhMgoTyR8ySyKCH9u7O5bxe0Oa8rJ05U+qDcA4uTnpzyEAyEw
 yq8Ji4Ovx4zpvJ2YcUAKAJEBeiN6RzsyLuArt9ud9vyNLijYJFGPzrXhQnHIXm308iFC
 vaWS7XRPCpXv+D2HcctmnWV99x+Zo9xGQiCqHrL0N1bqBUoGUT9EXdRlhBPrsrbnMizs
 FC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786027335; x=1786632135;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qs5R1aUFxgwmeT8+Q2Asst9hHuZgv/4kxC+scSrEHno=;
 b=X58oXTM9YdcWz09FTX2uQdSe+/tDs38UDLikueguuJ0YM1afF6QVfCQMSe5dZ9Dlt7
 wlUKKloHwxRRF0Lugtaz/jckmDJQs0ho9D7w21HD+sI1eUAGPo4zRtTwor+xlop82fRM
 pCWUIpqY9ZhY1wjg3U3NrSKF3pOQPR2AFlOAW4hEOhqFYaCgBcHye4rlYD+BioB4VNpI
 SJuvMVagd7GKK3PquExlhxOM6mcizopZw5cFGydV30vPFO8vQZtmPQlHkIHHjebfffaS
 PwvUbP3E5BwvJ+B/fzz45G+GJGxKfDtLyj4lZgD3mYVStdQs3M34oZU8A//jbzlKUSar
 bcpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMLDKd8iGoUkDdHb2DBIfeBcfIE6BBAtE+TtVC/TKT7EENB5uvmACKPLbsXYNvuobX7X7sX7uCmN1Y@nongnu.org
X-Gm-Message-State: AOJu0YzSTBFm7aTkb5ce1RH/SAbKHyLxQTgUxRSZT/T7JNol9bp9mdLd
 Bdz05cRjBx+6baSDKpC4WXcrjZ+Wz8k7rgU18s7URlAhGE5oVF2ZF5MhBOhhbtgBZn2CnznGnf3
 VTI3h
X-Gm-Gg: AR+sD10Pd1f9ybwUdGvwDdDSXirI4D1w01RspcW3IRNkPF7H6iNhqskx0k4mE+8as/5
 vffvMMBaVirkGrIljLAA9PILWqu2bJPVQa3B9Bk0usdIXxIplOA6Ve8Gl8B9rtbySvQMRKAEMU6
 CYV0U63P4AtfaBwMCGhGHjA1OZ6SuNfbyj1hZLGt+HDdSuCN2jOB+ZyQcjOhYtrrPmaW/HdlYmh
 uRofC0NedeKC2NzTi5KLO1JpaY2NiHAj+R74c2Hawtq8Z3RuQ2/CeS6sy+Y77NFJHFVTMlX1qEp
 VW047q53S/91fU8qMTOkcKRqmghRAo9/R30el/PX52INHqQOWTTK23jgbgsQnG2xtuhkZBgbiSQ
 DcY6w2JE8rZt6a2twX2OTa96LTfQnO65V3bK6o2szWaPVumTIgtn1iACkQhklsaUT3x9MDUQLS1
 KikGyM5DLfBJuG/ivqFZ/jkCd1qmrtaHaYx/tpf+6Jk2Ae5XWZ4RN/IvG7XJ4UEIeZTJmGkM7cT
 VhIiUncVa7qtnahMRz7sxN9RDpK
X-Received: by 2002:a17:90b:258c:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-3903c5a70fdmr17145316a91.11.1786027334805; 
 Thu, 06 Aug 2026 07:42:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2b2easm1664468a91.11.2026.08.06.07.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 07:42:14 -0700 (PDT)
Message-ID: <333f3e8c-b005-455b-bf3b-5db7c9b6785b@linaro.org>
Date: Thu, 6 Aug 2026 07:42:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/hexagon: add GVec overrides for HVX
 absolute difference
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
 <20260806043223.3787083-5-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260806043223.3787083-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/5/26 21:32, Brian Cain wrote:
> +#define fGEN_TCG_VEC_ABSDIFF(VECE, MAX_FN, MIN_FN) \
> +    do { \
> +        intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
> +        MAX_FN(VECE, tmpoff, VuV_off, VvV_off, \
> +               VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +        MIN_FN(VECE, VdV_off, VuV_off, VvV_off, \
> +               VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +        tcg_gen_gvec_sub(VECE, VdV_off, tmpoff, VdV_off, \
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +    } while (0)
> +

TCG doesn't expect you to require temporaries like this, and provides for custom 
expanders.  Compare target/arm/tcg/gengvec.c, gen_gvec_sabd.


r~

