Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA13CEB2C5
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 12:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKFEL-0002r1-MQ; Sat, 15 Nov 2025 07:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKFDd-00028U-78
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:17:35 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKFDa-0000z6-7v
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:17:28 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso1564894f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 04:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763209044; x=1763813844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DB3TerYtftLmVlWhV9wTZU9DAFYzYeYMPn6+95ugXBM=;
 b=Ka62CYV7U6zMlGBoN7SnP28N3TNGC4Tr0NfN4tTkEfJgu4Dzd4Me2YWSy1WEFEeRQh
 yxVpBbfAFNpeec/fZ1sQL1Q6/wn8AAL//Dq6wmO9Vd/zCeHc0VuY1nHT4zYxW2HQ1s2K
 V3yXq3tIrHTaJNn0zP0xFGx9srX6JU6IyWd5zwuAMDSwTwZnAUvZaCT/oqc/dXRu+TUz
 Wgaim6jYiE4MPOEbk5goohwlAahCivC2/S8z3cwhN1f2dTVDOUDKsqHHKFkJKsGvlEjo
 O59X3jEjziR+RtzXqcAeD7+qkbH+5d9VJ6eGOYzN6VbTgL/NUiFIMIMeSJOcKCA7ohGF
 ePSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763209044; x=1763813844;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DB3TerYtftLmVlWhV9wTZU9DAFYzYeYMPn6+95ugXBM=;
 b=s+MqsLPPg8kemzQI7rXE1i7xt8NotY4VNItjXr94PRRjEZKVHdpN1k0NLDnsUi2uj1
 1FfMHi53Auohx7kPuj8aMZqMPlBqvD3FxjovO7DfHngoOu+163RMFykRGWHZelkDcMqb
 CIAgJbyRNcgx9mVw3r0L6g04Of7vDkiyLo2oa0k44fLzBM7CNsaNh3a9DGjMI2g7uSmm
 RFixT/gCC5iZGX5N3+UjnDPOlHmtPsQBm/XzjKcrwq13d6ZR+ok9WW0eBsoqVE37IrsI
 A35QHCTJTmsjo3f77tYWTvUkATjvWiCJgrEnWCyZCdLFlkLNtGF8n6SUVhXf93lah1ea
 3yCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF087cQysW9ghlRr5X8Ch9EPBVo0PuXgGzdZ4eOawnYdzmmxyBiUanWHy/HMN8yTudc15qu/Bl24vx@nongnu.org
X-Gm-Message-State: AOJu0Yx06lZLxVNaSjkaF+in4JhAbhL4qdPAD89/AHgZqI7xIuC/nnWq
 CyGOAyDQe6qKeyvQqLMZzj3eolufGSx5Wmtx2MZrbq6VdTcfak5IcXea9LNdHVC3z2o=
X-Gm-Gg: ASbGnctjzquTDH+T8OlZvePv9bFOBoSAwJRGDSbef3JBt4l8TVbLPJ+DUqSt/ZYKU7R
 xYJKckO7aoCP1vh3G2FOwoTNYPT7NMe8NVLjrDfr7lzcRMtDj7h0N8YQMRjiRQ/E1vxopdtrFkn
 dypxy9WpW0J+axGRX7ACiMYWU/y526idQig2pqP4zLFSR/jh+5cutmhpDDY2LMoirmQ0OZnC70k
 HRK1cuwF+JjGy0hqEXWfiNKOIUNkECcuAaJaZEUIpzSf97g/T0Jz+e7KODXpyPL6g8eq3nYrklC
 g01B/EhMZxCpf9EOc+VohpcaIKNZ0GlWquNwVFpa7Ryhrs0JIV4nbqk6dLFWTofpqkW1UUapAPq
 +Lu1dsOlQushTtP2AH0Q70Gpd/Zk3HavR4f5gzzEyv5lVKMa9AZ+gdxKz2rdQTejPFQqVTkPDG1
 qWsedROBkDs4H2Fx3WTKZamxlBmRR7DIrC8pSRM7U1BT5VxlZwc4zAJYNYrOTi
X-Google-Smtp-Source: AGHT+IEAfezl9DJqilzvk5iywkl8kgZkwVfUVDQrvRMxbaTFAw653865bel+YHVqV5pB+0dwX+Hkxg==
X-Received: by 2002:a05:6000:2f81:b0:42b:2c53:3aba with SMTP id
 ffacd0b85a97d-42b59339417mr5875856f8f.10.1763209043868; 
 Sat, 15 Nov 2025 04:17:23 -0800 (PST)
Received: from [192.168.8.105] (115.red-2-141-104.dynamicip.rima-tde.net.
 [2.141.104.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f203afsm15865641f8f.39.2025.11.15.04.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 04:17:23 -0800 (PST)
Message-ID: <4433fb2c-3815-48a2-a74a-0fc38d736dda@linaro.org>
Date: Sat, 15 Nov 2025 13:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Enable ASID2 for cpu_max, allow writes to
 FNG1, FNG0, A2
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251112092048.450090-1-jim.macarthur@linaro.org>
 <20251112092048.450090-3-jim.macarthur@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251112092048.450090-3-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 11/12/25 10:17, Jim MacArthur wrote:
> @@ -6102,6 +6102,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       if (cpu_isar_feature(aa64_aie, cpu)) {
>           valid_mask |= TCR2_AIE;
>       }
> +    if (cpu_isar_feature(aa64_asid2, cpu)) {
> +        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
> +    }
>       value &= valid_mask;
>       raw_write(env, ri, value);
>   }

These same bits also need to be enabled in tcr2_el2_write.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

