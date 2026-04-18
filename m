Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82601F99C6D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtLA-0001sF-N8; Fri, 17 Apr 2026 20:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtL8-0001rn-W6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:15:15 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtL7-0007DJ-BF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:15:14 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36146ae9dd4so610459a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776471311; x=1777076111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ef3Y1vcO0G9MXunz1uI42GlsTDK2/kdBHcaH2ZJosvk=;
 b=E611qYlt2scsUNW434PZUqeiy5KJMVKiU/RA52GioGp6G8ktMK5WWVxZ9rNmhQSOg3
 HchcFYgDf4U9Or4Fsfx8mEbuWi0tFolc83hZUyOqSun+vjFLK+kV4kCDyij3JagayKEI
 rfr+EaVMdv3nj1Nr2vKQxJS8QV5XXIinJBppnNDJYvrWL+MWm4gmI4H9VoupfgqY1Ev2
 fwoqJtBM810wFj8eesloLmsVllGus9Zo9jaugMHep/Y3nTf3Rl+usE3zBfdI5SeAYqQ1
 8gqGmTrSht/SdHbWlRJrm3lPjPg0+zQhcDak7nKwH6ABIFVNTlMG8wrdzg2nuFN9LPP5
 ZReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776471311; x=1777076111;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ef3Y1vcO0G9MXunz1uI42GlsTDK2/kdBHcaH2ZJosvk=;
 b=JkBOwLqElS/dZjwo08ar4/JqdKnPo0L9aGmZjeBwgSi2p7iAEIiG8aK4uI2u36ohfr
 KZLOhLWcaT7lX/TuHZ5C23cuxdvwCJ5LQoDY0To+agp+cJlRCCksRbonFx4HOD6qMA44
 tkH1Lb6yCJgYrpeLhqPndaifZEvLNKiW9EhpefDhjB93lsiD5t6fOoQA50kVH5QAMLoj
 UJ0nIn2YY8M1KhtnIQWVeyY4ASF8uYMVsvUhr8BBd8JG0WEuMCQjw329ZPY2so2qlOHS
 Yah8WoDd+sOmQjgbMt1jtbzObnqL6hLwkocwvcSjxNh5PJCbYD8HE7MrOalU6kSmOnEC
 H4BA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jcY0F25zqCV+bLlUylI3Bnxd9DESFWE7EEtNUe3h5xY/Awx3CPEKSFYHYQ+2+ES4dDBxY6sY8/ntY@nongnu.org
X-Gm-Message-State: AOJu0YxB09t1EKsEa0Tcex8JAz+faliUsySfmryCPIwu8BbjwEBb7eMe
 C627u4Np4pSebLmxf5HxzJVvjc/VBSkZwvo3DXq1LnSHFO5Pe3+gE2mJaL8Do28lISo=
X-Gm-Gg: AeBDieudWalTLFwOgAohCLxvdyZRloC/7R0nw2VByAaln3Q7Qt9tcsP16fJ5dadIxOz
 1/fcgegeXgxjHc9mC7XBbJgZv/OsMlAbW49R5oU5+j8+n+SHvFHIJh3CJxIyVB/qEHEZlF+NrAv
 caVwWo+XteV/9sohOqn7dmAe2p3U3TRxI1DF/4S8hhXJCrAjGIuPWASlVPcLorCjO9EN3B+t0ZU
 HsgxQWvoKjM799f9q4Y31V+uVkT3ovSShqbHEaA3HK3/tGmLDDxz8hsU6uJAB6/17panGrIHnCF
 /4m6choND2ao+KLuFygaLTmOTY+2lw8BCXov+ZMOgioHv2OJ9+Bgg9pKjbvqrIfCPGxPQUlvURL
 mCjcFH8kZY4zmK2JEEghLyY7pJwUB4MLYG9r76m/5YLJeC+AtTBGTIsCUcYCrAPkoDKLuoWu9xO
 W6jsx8MlKdUOY+h4NK4jP8HrOSeuewUm2rASEYu5nfEQ/B0hooXehtqOgZKKZhVrQ+uotK+pPQl
 uwwu4+OnXTy6utoO5tYejewBO0la2OGdhNJQHtopAcAGdWt0G3z438EObNgc4Qp7Q==
X-Received: by 2002:a17:90b:3d01:b0:35f:b75e:fff5 with SMTP id
 98e67ed59e1d1-3614048b7admr5679270a91.22.1776471311212; 
 Fri, 17 Apr 2026 17:15:11 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141975515sm3097813a91.15.2026.04.17.17.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:15:10 -0700 (PDT)
Message-ID: <ecee1f9a-606f-4b03-ac79-e7ed1de4e481@linaro.org>
Date: Sat, 18 Apr 2026 10:15:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/tcg/aarch64/system/rme_gdi.c: Very basic
 test of GDI
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
 <20260417-jmac-feat_rme_gdi-v2-4-7cf5131aeb60@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-4-7cf5131aeb60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 4/17/26 21:02, Jim MacArthur wrote:
> +    rmegdi_status = ((mmfr4 >> 28) & 0xF);
> +
> +    switch (rmegdi_status) {
> +    case 0:
> +        ml_printf("SKIP: GDI not implemented\n");
> +        return 0;
> +    case 1:
> +        /* GDI is implemented, so continue testing */
> +        break;
> +    default:
> +        ml_printf("FAIL: GDI status is %d, only values 0 and 1 are defined\n",
> +                  rmegdi_status);
> +        return 1;
> +    }

This goes against

   D24.1.3 Principles of the ID scheme for fields in ID registers

and will fail with the next update to this ID register field.


r~

