Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E5C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hyU-0004cV-MN; Mon, 07 Apr 2025 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u1hxm-0004S5-Pc
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:36:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u1hxe-0004HD-2p
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:36:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so3093454b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744014963; x=1744619763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BrfYv8OftQlnJaSRIqHYeWiP7rp0AlNYCMGatk2Up0s=;
 b=VrvUc5O7rfalkTtZ4d5WRCc7u4oBJZQz6kC2PSlnUfTHc6Ry5yU6KN2Uv3UCmcm43Y
 8K8ICpPXIVO4tqHeI3bnfofjK6bLYNWWznnQRdW7Dr7QE5shrXH7Y32Z+yGTuCeoeD2W
 lz3wkS8Cp4DkmDJlSPJHhDlFo6iAOtS8y2Kih2g+uU4GXof7dlxSITOayWtQqx4kGNjd
 5Yjnp82304EEwB8NOab+PL/ISsv4T8czEUUBqXBtwDavLDPwqIk0INxglTKUadopGmIM
 qzlPTap18ZOaNq9SCR5FXHcLuYVMqZbP3Zy2VtmqR+R8lsUhv8PLmoIFuyif9H/8SqKW
 eMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744014963; x=1744619763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BrfYv8OftQlnJaSRIqHYeWiP7rp0AlNYCMGatk2Up0s=;
 b=q/tafWaAhyfT2Wgu3mjtP3kE9vKz8AzeX3aprnXFPwIjhCydtjWqKDubEiziVnH2jO
 Xb0np4FxwZbnx96cduuJd8WjKGMJVt411Cz3lulIpVNQiMOOdm2jBa34ZqFcdxyMgE3e
 a+WyZbMW27Y3RuqPbgCCRH1pFaHBjseSDvzA8f2ZVqrHjNgFRpCaPNTf9DIc4Lroh9wY
 svm2Z9vEYbZVTTi0Iso1IbTybyReC3Sx7ltWfDTqSY0oje0fZEFqtWKL2EHcWn0Nq+6n
 dVuszvcEMxVrzHjwbXxM7oyAdi5Ti7FMfd4a1//f7O+tq+0vMVgSoG/gafX5Wbo7F1o+
 ZKsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTM15R2QSE4vurKPDfI8IXBivoSnwFlGIAIv/pmCXiPIJfyTJhvWVQKiHvynHJugTghP6Kk/uLlr1d@nongnu.org
X-Gm-Message-State: AOJu0YxeCvrLaHIMiUM7tG8zx0lEyGT3cF0DEtUTc2At6i/ghWl9pLCc
 F2SoIJayNQNErNHz7lYDOKM8ZJjYZ96AWzKZYzcIMn5cDOVkvAr8u8bFiBz6H1A=
X-Gm-Gg: ASbGncu8znWBzHlZ5Itaalmk88oAdcehnBdsy9EiNtpt44+BPJzzyctLj4vQdcPKJGO
 nNdiD4+kSzGwiExnzMPBvF+xpzK2RS1abvJHQrFWPPIVK5DmwYzHtuqq9yQS8Ioc6QtDRKMofNw
 xb42LLjUUEbsb8OR+I73fkaF/SgPHWOGG8PP233NtNCoaMvF18/yoKFh+6MwLt/CHo8t1v6dZYY
 N4adQ1yEb4i9yKWnPBt7feFHk7wDvar7nuLz63hYKlaVhw6FN+biPbT7894ldlOVL0+/BNr+X4S
 1cQ7SuXIrY0xzLCCf9aiAa0TcGNuc3tMZxg=
X-Google-Smtp-Source: AGHT+IEm6R+fQFuTH3r15sFPxQXmmIpZk5we0ZsWJryQJoiFNCjU0ssNXXvK4RIxqxXRhXJ0WkXotA==
X-Received: by 2002:a05:6a00:1701:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-739e46ba78cmr13573439b3a.0.1744014963284; 
 Mon, 07 Apr 2025 01:36:03 -0700 (PDT)
Received: from [100.64.0.1] ([147.161.192.170])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9ea093asm8211881b3a.102.2025.04.07.01.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 01:36:03 -0700 (PDT)
Message-ID: <0a4e0938-b7f3-4c49-907e-b6298e7c84c5@sifive.com>
Date: Mon, 7 Apr 2025 16:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] target/riscv: rvv: Apply vext_check_input_eew to
 OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-6-max.chou@sifive.com>
 <6e6e4b9a-337b-4d5f-8aca-567cdc362f03@ventanamicro.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <6e6e4b9a-337b-4d5f-8aca-567cdc362f03@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

On 2025/4/5 5:17 PM, Daniel Henrique Barboza wrote:
>
>
> On 3/29/25 11:44 AM, Max Chou wrote:
>> Handle the overlap of source registers with different EEWs.
>>
>> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
>> Co-authored-by: Max Chou <max.chou@sifive.com>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc 
>> b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 4a0c9fbeff3..3d02a2f9ec8 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -412,7 +412,9 @@ static bool vext_check_ss(DisasContext *s, int 
>> vd, int vs, int vm)
>>   {
>>       return require_vm(vm, vd) &&
>>              require_align(vd, s->lmul) &&
>> -           require_align(vs, s->lmul);
>> +           require_align(vs, s->lmul) &&
>> +           vext_check_input_eew(s, vs, s->sew, -1, s->sew, vm);
>> +
>
> Please remove the extra blank line. And with your co-authored-by removed:
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
Thanks for the suggestion. Will fix the issues at v3.

Max

>>   }
>>     /*
>


