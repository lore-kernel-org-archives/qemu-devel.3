Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFBAC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 03:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUGYv-0005by-42; Tue, 24 Jun 2025 23:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uUGYr-0005bb-DO
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:12:33 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uUGYp-0007VU-Sp
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:12:33 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-31393526d0dso962531a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 20:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750821150; x=1751425950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmjtJMW9UkUDVXlegkyYkzfojphQ7HQvdC/+D/xoKBw=;
 b=pSNSiXF86UDOeGhgsDWNRznMYp2GezFlfhcZ+TyFBW22OgLQS6Oo+/oqWMWPyr154z
 tKtw2HagKu70Xt7Gmp52ZZhYMLqab3+T7a701NVIpLxrNthAIW2L8KCu9EqOybd0iaci
 3ylTqNRhyxqb/jmBNhbZKysKzuO1ZEbi8Jlsy0PNEcZ6l+BPv5qGW5dJLOID4ZMAgS+6
 vcGrQFO1a0MLAmmpPimDZ+dbS4tyCVMW3t2jga6THkmX8i2VpxAGc/elKM3QPrrGJnXH
 eoy2I2ti79KVE8d0rK+0Q+ol9MI6qI2m32OcXRNv/yHl14qhWXZzQgEPP/U+oHUAIOwK
 WEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750821150; x=1751425950;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BmjtJMW9UkUDVXlegkyYkzfojphQ7HQvdC/+D/xoKBw=;
 b=FT6e5RDqv6flyCVoyZRhNuiQVttikBA0WzcSVRLe5HX9eLS+G70jHNVvdFKe+xihKe
 fhmsayQYLbONcF6lsUAR6bYgGj+9duCe5Ek2nvMegTja4bSHPrPqvUTODGH5hV/2AcWX
 Yaexxe4xKIXx6PYWur8I78ZlfViEQcBGJbYwhVMIldrGl4mOL1mE96hyGbu1OE55LXmD
 bJ0Z4nhxH+EYSUHfQLEcvUQaTB/TIOEUpiT5r5IIjhOpYmB1D4nAMl9+siAn5NAWSSqS
 DAxP5d8QP+YtmB0vvpfhYeAmqwcxLtE15B4xX+KGr0GOFWZWRosHoOmfvm+ADu79E8O8
 j+9A==
X-Gm-Message-State: AOJu0YwZEXZ6eY6LSTXGHfGvcQTOtgw1Tzz65dTf9LpjLAJFBPOSprBH
 wlnKQbiWU4MFmpCt1G+hFFOXdvAh7VNupQTELuGwg3SaI1doG7lt4Wb1k4X/GrwnYMU/ib9sZ0z
 5iYKL0I0=
X-Gm-Gg: ASbGncv8ykkMJrkGhfttmtHHwp/D2z9yqh8IUYFVWJh6WvgIGXKpWNk9a8X04GOeF7J
 foxsfruGqAD2kxIE6sp3007PQh4m1Y3MnyJ/W4Oh1bGRK9y20WW4IQIU05wsZSCtvzEzEiYseSQ
 PJeixwqrMkUsGk/bbz3N+Ah7DuNOJyJiI+Eo3PDEqn9oKKv1oHf63+X2TnEk9yaTyNYy84ohsnX
 BHvWFuOU4k/MVp8+meCM2jpKGRbh1pjRC31I6mj5PiP0F+8sfa0T9qN63dxG2XOYiELrC8IZJnR
 GdodC37lNOC9XC8c7B/H1jSyCInQVrk1gZ0mdm4PYloZYIX8wgpQcnN4gFeIY7s/vNKCmYTgiXS
 1S9SoTvORVyNsgMq1Fl0PcIpH80Y+
X-Google-Smtp-Source: AGHT+IGovGSgypoWEbH49SsPF8ARsuNdFVlPEVCW4WD7t5LgHUSBJY+NsqQIoeMbcZx8PyiskeRt1Q==
X-Received: by 2002:a17:90a:d64b:b0:312:e744:5b76 with SMTP id
 98e67ed59e1d1-315f26c4148mr2148677a91.33.1750821149933; 
 Tue, 24 Jun 2025 20:12:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53c2282sm481725a91.24.2025.06.24.20.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 20:12:29 -0700 (PDT)
Message-ID: <bc7d92c7-96d1-4110-9c4a-22b2043184e2@linaro.org>
Date: Tue, 24 Jun 2025 20:12:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 046/101] target/arm: Implement SME2 SMLALL, SMLSLL,
 UMLALL, UMLSLL
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-47-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 6/21/25 16:49, Richard Henderson wrote:
> +#define DO_MLALL(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
> +{                                                               \
> +    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
> +    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
> +    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
> +    for (intptr_t i = 0; i < elements; ++i) {                   \
> +        TYPEW nn = n[HN(i * 4 + sel)];                          \
> +        TYPEN mm = m[HN(i * 4 + sel)];                          \

	TYPEM mm

Fixes the usmlall cases.

r~

