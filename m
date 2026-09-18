Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10920C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7NIT-000625-AS; Thu, 17 Sep 2026 21:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7NIP-00061O-PG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:21:45 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7NIO-0006RG-3g
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:21:45 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fdc579daso2369725ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789694502; x=1790299302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=64bkQ+YgT1+9HX8cq10KUYJY7H5Knck7zkIpHGPCJDs=;
 b=jO9xbjuH8eK+hEDZNQDw5i9mK27X7CVLzAjbyRZLDSrdCC2YaCjdzHEfWTRTAULc4D
 nWgiUzZftCoLQC1Hz/PHlWPj6NJvvYaNBXL3j7tTkbz9mVzvABp9is80V6Kl4m8o7T4M
 aVs1Rw2HidDxhgYxCFHMxlxdqvQWL3KqA6qUw/cw7Ve/UhyZ/WY8ejW1YTl7h44ttzVB
 Ux71M741YDcOSeohcOr/1EjZL8enllDqkVUciO/O56ExuZ79Mv6BbCRJIqfJ1teTxLl0
 uK2VbQ65q7TdGOfPIXFP8cJFrrczfcYH0czvXmQcsE3jjua0PTlH1v7TdDYtkxQWICv9
 LJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789694502; x=1790299302;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=64bkQ+YgT1+9HX8cq10KUYJY7H5Knck7zkIpHGPCJDs=;
 b=XAGQSWCXrJbB3FA5is9a7rl3R15uaqi9yoGLq3ATUCpmmX2i0NntigYGtmzqMh6VQ7
 7dBcwKKv+AstTFjyQeWN4Wk2TIGll+/ke8qgFnYIU3E+L5YSEyFQw7I3EXFV4znIwwzX
 ByP7GOhdCZSY/LqPgGCnBX8mqJD4Xc5CXfDFtQ4hByl9ENoKQ6bbZNixWbTXbplUW8Nz
 dq8BlHZcwVnw5jNMEgPrGe4bwtLSJxy/VApUf2e53GF0kmAUArm+ko0xxk55jmy5ZAPT
 Ex3ot3PPFcJ7mr6FsXhifjhj0qGWCAvWYz6NG4Xzvsxv2SDQAPubi20ebbNz5l+36xIC
 HL9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMDCM96PK4fzLAd+9mmJp1ygjiFr8o4hWF+O+RLdgmj/knfRJVSWwecU8pBtXSHc1I1l+EYgNXyWuW@nongnu.org
X-Gm-Message-State: AFuF++nq+e4SQq9HYYF+bKFuGr+vvJACPUvbSg5mN+LjKeMeG7N6ql09
 S0Dl66GHXflf0bQluPIiEPSDBG55uuTv2qHsHE3zLt+Qc3rJqGEBWf4271VFwkDR+jQ=
X-Gm-Gg: AYBFou23M9fF1MQniV4nsAbzObPRmyrNU/wMKdApm+ROQHTTxL+/ZcqQnrazo11plOT
 vb9DGUX0U/toI7Fn0KhYI6OXNzPsr4E9TAl184W8ULCBhxAQWonQ9C2tCPDjoQyHeB3t5DtQRC4
 bJ5Yan6P9PVv7EzLBlWjKolk7BqpojPNqOG7aB90pbBLaAxHrIFOrvfsXEfGSAAHFS1gfIjcG7v
 nE3CYZ1VDRSkp/AkmP241EMuBz2BQI30villjEgkd0ZniFz+iP0ZkKp9Y704z9+44zKMhYBiW9c
 nk4nyM3XBFQ5MlsWXN0v0ZMtANfH1Q75GI923oQ+A9UJ3iILhPPxX368ydzxLsUJwXN0nBbPjrF
 I3WMVzGiiFbBadoLrn+IA6LnvErSwIiHauzBfNmImUD+q0ZF53uLTmjVTRHo4EYX7eexjSPH68S
 qpGtEhAmb/IqoTVo7P3KiXeNDowYg4gYxoIHPDBAbEtYpPJv+ALKaasJq/91ryQkIRuq8Q7nMqw
 w+U9Hx3qY53dtWr7ymv+WCWIuSyZiWJBdamTsDDe6BouVdN76aUtH54brHFDA==
X-Received: by 2002:a17:902:da89:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2ddb1adf98cmr20598765ad.10.1789694502259; 
 Thu, 17 Sep 2026 18:21:42 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:83aa:9d68:3956:350a?
 ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c284ac724sm30384eec.2.2026.09.17.18.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 18:21:41 -0700 (PDT)
Message-ID: <94fbf653-0eea-4e76-9b80-37a3f0455657@linaro.org>
Date: Thu, 17 Sep 2026 15:21:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] target/mips: convert raise_exception to raise_excp
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-20-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918004225.827-20-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/17/26 14:42, Yonggang Luo wrote:
> @@ -8683,7 +8688,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
>           ctx->base.pc_next += 4;
>           save_cpu_state(ctx, 1);
>           ctx->base.pc_next -= 4;
> -        gen_helper_wait(tcg_env);
> +        gen_helper_mips_wait(tcg_env);

This is unrelated to $SUBJECT.


r~

