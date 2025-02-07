Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A4C0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgKo4-0003TC-1C; Fri, 07 Feb 2025 04:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKo1-0003SM-IW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:37:49 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKnz-0008RD-LL
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:37:49 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f464b9a27so23154455ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1738921066; x=1739525866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mzXxKznU5wkiSSetmU7ldWcCIS+7alLdzy9VWcC7YNk=;
 b=R4Xd7faMkj9Ass8RWsW03smYUszEvdXlBtpit0QayufHjyiXUjYchmjQ/3UaOLrh6E
 bDeFg37jkxyiUSEA0dW6j8r4ml4r/DQOBp3/Bd4PtKUWitkRH+VoblNQrBoGZDG1JIzV
 Xblq50eK73MeFbxeFdnuf391/iq4Olgxsa5aFkgmpX13Y6szC55D87hiCRztW3e6/wwz
 Ihs/viU5f90D8hyNnJc92e/daAnCX9OU3RtKArDqnjwHGAGoyDc61Yz3+dIqyp3jw2H6
 i3qA/+SyVTOT9Mri6kJL6Z6p0whScOx89CrIhLg2mc1zw2B1wJr5balGQn7KQ9uMcatS
 l7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921066; x=1739525866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mzXxKznU5wkiSSetmU7ldWcCIS+7alLdzy9VWcC7YNk=;
 b=QLGokQKfPu5nKFe8gcogY9RF29Nm6l66+Q+SzH4mzxMq4ub2g8N994yTLsaz8/Cgub
 H3/wLvIUL9sZkhtserxFjwcq4NeusY39vNtodJWCa6Lykb3o6M6Jd2gdtR/s9z8y1Bdh
 WGM2RCtT5cgVwjlLceFxY/78Wuwug53sDYgP6mjF1Hm6Et7eEhpLInoE5eVuAQaide7k
 p9YDgElO02HcXOJJUczNgZuf2187sR8oSa/XP/+9zfvt8jC5LGOKoLlNteJXbq1kBzZB
 +PCNUnOkQl1rdSr0U/AvEyn+H/YtokgmDfaA0NfWSSUmYfPa65N0L/hwuBa978Xgcbws
 2nAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIzgBw5sOvXNn1UqjayO5zxzmRL5lvr3jzKVyUwzeVdguNwMq7kOwczPz9SGcpLPRphxU6wmZUeCTv@nongnu.org
X-Gm-Message-State: AOJu0Yw782aF2OLxxelQkpj7fCSSBiGQHcksJDhbwfH3CAJUvgKJwR2E
 QVtKm1C0+sar4f0eD90d89aiRJ4e3vKYkeMpe0jDEzC90fne4Kh+JLQEbCieOb4=
X-Gm-Gg: ASbGncuXgAlg+qwUQEhaSmCsrcXnRu5KStkAJ9JckXoW+C6nSRKeAIwkZ1IGHim7v4n
 NHFPjeJY00hEgcnFEOeVhBvOAFrIXYg7g3cXah16/bzwuESLb6Kl/2uzmq+XlNclJJym6hntKLV
 rAHt0MasCeD7nRfwjkwXGI/XN1D667C7PhdsuzTx9z5cf/+Ru96fEec5WUGJb/jHrNpoWwoppj9
 HX1tjXG/KOKA8Ra7oBU0DdduPey1JbfiLhFGKIFoH0BVwRjfY9iXq10XQSsGaQaKLkm7oQLAKnP
 by3LfuVSIUw+CwzwyxFT5SEXNaRQI/qWcU/bElfQspzNF9h+ixI6Z8P0phjHeu5g60gN
X-Google-Smtp-Source: AGHT+IHXO6mGjLOaINxlIX8kU+Y5BgF7qU3dtVvRcoSWg8B894Djlw/zMw79Y/uvRvfsUsLNUYmNzg==
X-Received: by 2002:a17:903:1a2d:b0:21f:2a2:3c80 with SMTP id
 d9443c01a7336-21f4e1cb924mr37386475ad.8.1738921066005; 
 Fri, 07 Feb 2025 01:37:46 -0800 (PST)
Received: from [100.64.0.1] (218-166-198-8.dynamic-ip.hinet.net.
 [218.166.198.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687e0casm26460375ad.174.2025.02.07.01.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 01:37:45 -0800 (PST)
Message-ID: <3236bb5f-644c-439a-ae20-d65d7938f0c2@sifive.com>
Date: Fri, 7 Feb 2025 17:37:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] target/riscv: handle vadd.vx form mask and source
 overlap
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
 <20250126072056.4004912-4-antonb@tenstorrent.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20250126072056.4004912-4-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
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

Hi Anton,

I think that the commit message could be improved for better clarity.
The vext_check_ss function affects more RVV instructions than the 
vadd.vx instruction alone.
(PS:perhaps using the category (OPIVX/OPFVF/etc.) to describe the 
affected RVV instructions would be more helpful.)
Additionally, the patch 04/07/08/09/10 also have the same issue.

Thanks,
Max


On 2025/1/26 3:20 PM, Anton Blanchard wrote:
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index c66cd95bdb..bc2780497e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -382,6 +382,7 @@ static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
>   static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
>   {
>       return require_vm(vm, vd) &&
> +           require_vm(vm, vs) &&
>              require_align(vd, s->lmul) &&
>              require_align(vs, s->lmul);
>   }


