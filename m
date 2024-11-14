Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AFAD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcQB-0003wB-64; Thu, 14 Nov 2024 11:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcQ0-0003T2-Nn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:10:06 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcPy-0004IW-Tm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:10:04 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so618287a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600601; x=1732205401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWAtYvj47Ix5qNW4Emo3QWM6YHTQcss4zfN1Zjyrw/Y=;
 b=qD3CRLj0jGADxbiOrKZUjwZ+T9pH1EUMJcwdnS8Db0+a6QHCfKfh9YN3G+w7L0PQNg
 wF9oLNftWlxM8TPhxbWAoIyy5tc9SWLwtcX58y6yueZtucjV/uijtfpU1rhIYSMN6H95
 RJkZM65i9r+sq2HnFtvsh1cLiBtSCb49kIwort45OTWKagjYSGw0rXZubMgIAElVbr4l
 Fgw0gJSiWo3AYB2PGKbbWXRfoKNrQ/tp5ogPwoimTB6jai+eKaVpYApn6OpGKGGVGo0w
 i2NGhqOYeo1/4wxrJ8tiWiLxlb7ZztQVKm/2V9n7rmP0j9JvvRzmiCezj51ntTdGF1Xt
 rt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600601; x=1732205401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWAtYvj47Ix5qNW4Emo3QWM6YHTQcss4zfN1Zjyrw/Y=;
 b=eCnJn1rLDJ1oWJabjoofbbEASxZK3gOAQRs+MPPIb7epuEDW2XMnY31UYcYF9cbifT
 XwigqDowiziIrjXEnH04GCNo51Y8Gz5r7KkOvpWBMKam4aUTj73HwLeA0Nev5UNQdtje
 d+XLuI/kdlZWxkoeTXQlttivLKBziQjtiDzW/t5a2qDbW3WniKkiostc1z0akWpo5Ww/
 dxbDYk6cu2OD2InMZrJgiPaHU8yHrCcKDpo6Du8TKWjPekg/faHnZC406BPlfXiHYi1z
 u0XcbigQ9tJPKZA6ZSK5D8/doiCWO1Zlk1AhGD5Cv3u5EP7rx7NW7er/Bk0RoJq65duJ
 hmfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW/mSBuz98L8yRsQmUvCzVs7TXzhDy9ydA0ynfITHfG3W3DTbqcZlJxTj3cUNaQU/O0FvYF5Wgc/Dd@nongnu.org
X-Gm-Message-State: AOJu0YylqmOP+uCHP5t3oV0XGLSICHTuIR/bmHKCfQlXdkhOBx3t879D
 +DWg8+C8BRCC8iAQNPGQ5D8At2UHgT8rYisG9JDqsPZvNrRD/jnVPHG1ZXcGG10=
X-Google-Smtp-Source: AGHT+IHB9SPUKGaSd0XdWLK4+NjQXRX+88CX4E8NZGxkiAEFobpzf2gaA1L0QO121XQ0zhB5eWOkYQ==
X-Received: by 2002:a17:90b:4c49:b0:2e2:9522:278f with SMTP id
 98e67ed59e1d1-2e9f2d793b8mr7844483a91.32.1731600601110; 
 Thu, 14 Nov 2024 08:10:01 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea02495969sm1483293a91.19.2024.11.14.08.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:10:00 -0800 (PST)
Message-ID: <bee4999b-902b-43b8-ad12-c8394712b91b@linaro.org>
Date: Thu, 14 Nov 2024 08:09:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/2] target/riscv: rvv: improve performance of RISC-V
 vector loads and stores on large amounts of data.
To: Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
 <20241029194348.59574-3-paolo.savini@embecosm.com>
 <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
 <96e7601d-14aa-4741-8f6a-ae4a1c397a44@embecosm.com>
 <54c99505-21ef-422c-a7fe-a2d7dabc3d6c@linaro.org>
 <6b06b532-c53f-4b5b-b65d-d54d7c746ffc@ventanamicro.com>
 <230f448b-07f4-413c-9be6-e10a8e55be73@linaro.org>
 <a9f51b76-1cd7-405f-b4a7-384c7447ff88@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a9f51b76-1cd7-405f-b4a7-384c7447ff88@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 11/11/24 08:04, Paolo Savini wrote:
> Hi Richard, Daniel,
> 
> This might be a silly question, but why do we need to ensure atomicity when emulating 
> these guest instructions? I might be wrong but I didn't see an explicit requirement for 
> the vector instructions to be atomic in the documentation of the RISC-V V extension.

So that it works with threads?

The rvv extension talks about loads and stores to individual elements.  The risc-v integer 
spec talks about the atomicity of loads and stores.  The rvv extension does not talk about 
*lowering* atomicity requirements.


> Anyway the patches from Max have landed and since one of them already uses memcpy() where 
> this patch does and achieves a similar performance improvement we should probably drop 
> this particular patch. I'm wondering whether we should be concerned about atomicity there 
> too?
> 
> https://github.com/qemu/qemu/blob/134b443512825bed401b6e141447b8cdc22d2efe/target/riscv/ 
> vector_helper.c#L224

It *did* go through review for exactly this. You'll notice that the memcpy path is 
restricted to esz == 1, i.e. bytes.


r~


