Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02CFFED3CB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGSk-0003U7-5x; Fri, 24 Apr 2026 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGGSi-0003Tz-9Z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:20:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGGSg-0007qj-QR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:20:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so65144725ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777036849; x=1777641649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=glF7i4xS5rWtEfSzAoku/qak/u11lzjux/NIqvGHG+c=;
 b=FccYf2GrOdGwYeBSL89r3V5tnuj10sd6Y3h5Nvu9TvaOiYLorcOX1jj9zu/I/sEau6
 nE3vNwDKkwZeDJQtLiPmL2406u69jzA3nTM3casOcAARHMl5TwK9/caEwcNcH8adSR69
 ruCZvu/Y9kF6cWG+nhkM4py8lxGMVUL5Hzzf/eGGOXSEYtMFltx0ueYotInsu8IfFP/A
 BRttg/zuMSwjEb79RcoORbyXvEAReRpoGiJHIisXEcrtr82InMuJYGRHxLJTj6V7IJNy
 bUsdL/G0vlvWP31G6HNYM9NJe2bgSJu9KUYi2sI6sLhsBEobG1tNne34IJof/ml5iVTA
 OGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777036849; x=1777641649;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glF7i4xS5rWtEfSzAoku/qak/u11lzjux/NIqvGHG+c=;
 b=dZekqko6gjWDcrXG6QyzBbhEPqBGjTa1nJkUof3czsaYCVpdcTSUZM3S/TWC8atZIt
 q9UcbQEVGYCMQo9+0Z3QttC2oJE1cKCHWKazVMQDWEm1n3IJbSvoyhtLo5QFegM7XJFB
 w0vOyWWgitwSRTDhYWRb6jV7TEJFGCeb/AjorIBpo0IH+8XdLXyHG0dXhV/T8aVJOSer
 Zzd7VO8cibtoRsTegvcJ5Flce20qoUqN2N/RoIC4IkPUI348sjzQKTf9g7jJNV748+U6
 le8b5a0y4RfL6h4Ten6QZcEBPN9XygBJefDJ0dRZnpxY4V6WgxCP9WpO6h1B1tz71m13
 IB/g==
X-Gm-Message-State: AOJu0YxZ8JWXGtt+5tEvMqw+gzJfhH1NdgFQc52uKIRZjS6dQCIbfnnL
 hR6F8Gj88Pb7aZydz7Rv0DsVwb9e2MLPP17f46+RmPJfXAZR1A0AQfZc8Dj5KycqmsvdOWIqAoz
 B1vSvK0g=
X-Gm-Gg: AeBDievkKAUnHc9Da7mGzDHW0M8GBK+HOy60zitkjCQ4y7KlshtQmWQ7bLvxaMKxaMx
 1rgBVUUc5ylNK3PY5Rh8PAbU8JgGcr1ULm+uRfDbCvVEKgJ16SftUjMw9YyC3XL/ZTimNobWbG9
 l9dJi9wfMxaZTbaQuVAAusM4HmPI5W/05pNIazcsn8E8p36RMebXh5W0TT5QAEXbq1pvHnTj4AP
 WPeb9GQwztsC1hzT/5TFwOE2Smub38EKA5BMLkPnLgxlfiIEBy5ULDu87+plIe3a0RpDT+LutYe
 ofGR6ayyMpDBApDTyTmDkAUPMq6ecPtRQ8enBpE16fie33NbpF4FYfi11eci2z5Pa8TPbPiexsF
 RAzytGUGbM3xSEZGtIWsV4BFvs8fHl5y7pea/seQCG7n71jt4jW4n418v/6jXLCXU0EMd4CVNkZ
 Pjh3S6TTcOPoQZWC7wa54pryaCpCPy5YTw1phdVO5fw+x2yPrezx1A
X-Received: by 2002:a17:902:8b87:b0:2b0:a980:367c with SMTP id
 d9443c01a7336-2b5f9eb0513mr246979095ad.2.1777036848850; 
 Fri, 24 Apr 2026 06:20:48 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20e80sm237309875ad.57.2026.04.24.06.20.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:20:48 -0700 (PDT)
Message-ID: <058f177b-b8ab-4fb1-9998-ba21b559a30e@linaro.org>
Date: Fri, 24 Apr 2026 23:20:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
To: qemu-devel@nongnu.org
References: <20260424102800.24022-1-frank.chang@sifive.com>
 <20260424102800.24022-4-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424102800.24022-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/24/26 20:27, frank.chang@sifive.com wrote:
> +static MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
> +{
> +    int mmu_idx = riscv_env_mmu_index(env, false);
> +    MemOp memop;
> +
> +    switch (size) {
> +    case 1:
> +        memop = MO_UB;
> +        break;
> +    case 2:
> +        memop = MO_LEUW;
> +        break;
> +    case 4:
> +        memop = MO_LEUL;
> +        break;
> +    case 8:
> +        memop = MO_LEUQ;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
   memop = size_memop(size) | mo_endian_env(env);


r~

