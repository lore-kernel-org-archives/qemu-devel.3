Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204ECE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgZ5-00023O-2d; Tue, 14 Jan 2025 08:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgYy-00021m-0D
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:02:33 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgYv-00005n-L9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:02:31 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e22b2387cso3660579a34.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736859747; x=1737464547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUmYZjbKWifUgCqnJjjOKcesi76UgUVZ4zkWYA6FKGQ=;
 b=UvzFbHyGk0vcmRD7GUrSen0oVETZfPaC3DnEQHLs+rUrIN42u8xXXOSKH61kAup4Ju
 Dyovh6+68owjoUXC6aW7Tmfg4z0yNLmqetQnl1/ny4oqVdm6a+6qBiJCW++avWHj8cok
 l6jnILj2NfFMxWfkyz7JVErI7LHykzBjs1hJrtGLr+EJyN5nMF5/49ZsG3pYoSzctRsm
 z5//RDVzWu/wNgnERgeNfDvbEU+FhIM7+Itxjyx8PmkKX4RH8KWVGH8T+GhqBRivSTNd
 15MrIIHCKuzFy4t7LXfJMvhMGCzJGgY455Rgp9w+YPtUPEYQ32x3tbuE5JtlKswplKdg
 8zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736859747; x=1737464547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUmYZjbKWifUgCqnJjjOKcesi76UgUVZ4zkWYA6FKGQ=;
 b=tF0lQrccWIOmRcApiRhcrDKdlF0dpNNMuVZ4Sh2Cmk4/j8X8b+XkaHJ7VKvwE3c7sn
 ZqfjcdaDsB8l5sLjtwHG/xwnqkSKkyGNaFayXqJX317a15eL43m6gj3auCAKXFGh5kax
 jbBWwUJn6JXNjIPgGMbZOjMO9mLPKPJpqjkY6p0os9U94NRNNq/WbX7GiDdijwYmt8VB
 l1+vG6K9SfuNbiLUxYNHydQfR8KOvie6gOkJ4soCXjfHmY6PZeT/iNpqv/YN+PTkDp0g
 fZ2xN9bwrrJP80rlhGhrlvcU+UAYgYNKpRNSxnnIXqUqXQ6+ucQiyVfZtpHqNXHKNRhv
 S0MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTHLAP54JXSv/saxz/prpWfPBq9NstPs/AQIO52/67rnHCJ7OpCZNMCnkOD8VtvNilRx/d8LG8Ey/B@nongnu.org
X-Gm-Message-State: AOJu0YyTrw0Cg9ODcRLWKbbFs/JmQ+XNJWl6ZqbLvN/ibRZ5/XvUYJ6f
 EnlGZuxq+Oaf6be5MVzTSGrg/w1p5MCjus8hW9P06UMBtDlOXvsr1qJuqJKdPiE=
X-Gm-Gg: ASbGncvqoeZmHAcJduLe7AHYWaL3IaDVqx8mIzycTTSrGAuoZBq5SXMSgtxHhpOdoiN
 SUgpgOOWttZbnj6G6wFeGLO9RQlutADdEL1RzG5ia5tWUoylA0e0HDRl+1VkuUvRjM2bkkkws5s
 KUtIOQYKugmPCU7PeEUGN2/e89/BxvMmNLkSAGolhGqZu4rI4b+TgZtFq66a1nHGWlzlLOwViwP
 DxbT/i9LG/KfDk7HYjKtY3pRxNVxKO82YR44NSdUbGgL2x74bjKtlALdmXnRCCzNK1KFOoD
X-Google-Smtp-Source: AGHT+IHmGlZO9jTpnzTgb2wTSeID/WOlMMlEM368+LcvUpm6IMlbut6ToYypeaJRTD98a4NsqY4MoQ==
X-Received: by 2002:a05:6830:d0c:b0:71d:f97a:7b with SMTP id
 46e09a7af769-721e2ecd2c3mr14488016a34.20.1736859746886; 
 Tue, 14 Jan 2025 05:02:26 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f882756dd0sm4085108eaf.32.2025.01.14.05.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 05:02:25 -0800 (PST)
Message-ID: <4326cc98-a280-4a47-9c9d-42709f5b8080@ventanamicro.com>
Date: Tue, 14 Jan 2025 10:02:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/csr.c: Turn off mstatus.vs when misa.v is
 turned off
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>, palmer@dabbelt.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/14/25 6:20 AM, Evgenii Prokopiev wrote:
> A behavior of misa.v must be similar as misa.f.
> So when this bit's field is turned off, mstatus.vs must be turned off
> too. It follows from the privileged manual of RISC-V, paragraph 3.1.1.
> "Machine ISA (misa) Register".
> 
> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index eab8e50012..fca2b1b40f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1537,6 +1537,10 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>           env->mstatus &= ~MSTATUS_FS;
>       }
>   
> +    if (!(env->misa_ext & RVV)) {
> +        env->mstatus &= ~MSTATUS_VS;
> +    }
> +
>       /* flush translation cache */
>       tb_flush(env_cpu(env));
>       env->xl = riscv_cpu_mxl(env);


