Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA2BC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 19:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJZT-0000kT-99; Tue, 21 Jan 2025 14:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJZN-0000ho-OP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 14:05:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJZD-000863-Br
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 14:05:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso69492295e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737486337; x=1738091137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdf8x++xuyJLfXdRKT6F6X30MO2ggijVYvfSKLyrZtY=;
 b=f2gJzWFPn39GmWKUEK9uX3mW/hLugcY1BeVcLXt2lUsmpBYnOkb2dBimLMsU2G0Tff
 aubmxlGkkFl8+yXnDrVGvNFvqkTw7khRH1GO465m+0tzb0SGxHh4mX16NOydaLSRkpqF
 x8C1NGANziSl2jAJChKQQM1a8L6cgFpsvbDh1YkfNpLGLRNltDEjeoE7WyZhyWRasqJS
 DQZ47ldc2VPY+ipA7zVRIEJd0Ifd9SEB80jywK4/ATP6VkLRMttf9DxQTXUlhyqZKI+t
 5fB2ca8cQZWl4H1nFjI3EnqV0ocn0S2xLlgdzTf4ak2ZvWa2aEVqmNtGt3GkTZcHJedK
 If0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737486337; x=1738091137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdf8x++xuyJLfXdRKT6F6X30MO2ggijVYvfSKLyrZtY=;
 b=hvz7fSWggLvt86nBq+P8GMDUuaD1ibKIj2ktqVvTOTFNYr2xpFttGbOjlOsLkdRueS
 Ag5Bn4bS08YiCbVHgPMbiY7TUQ5IinSRUje7a0+I02pwPkNqXghXNl8ydUxWU8vgPlCc
 oDTdQ4Inc4r2p7Awfa5/2GntRafx/wUSS4mRX+7ghMoMvCQTG8dhR81fFJ0maWaNHTke
 s8MfpGSrIZU2spHhw7OKrMP/DB3FGGGQ9IhXBfzzHFcBGMffkiQXXYBafTxc7T+oF4G1
 BIUaQ3xc3kwARMwQSIvbTrczxZrhcVNNz1q+mokARFwe/W/vORv9pCOlCpYYOnBl5+m5
 4m9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLy+/M0aXwl0F0vF2DilQkkJti4Com1rZpIcPA8LzKN0EmPJ4/paxZGQiVgSb1H5WWkYKXq4NqUv4Y@nongnu.org
X-Gm-Message-State: AOJu0YzpL/3cIQZrHsuDXqMuh5FIHio34W9RWnb5MYIjtfrkp0XLX2Mx
 HEFciapbePUXW+smQqO0CPwc8F8snOaR0gYrQL5UpyxmARiteNXFy6sYcdYtsVw=
X-Gm-Gg: ASbGnctfjfclQXZJTtdQmx0SUFQuyDC2WTen1la8LyRa3BpaIYTUZgW10nSi7AHn4U3
 TJSdUgKykmAHi+yep3pFNgk3CxibM3PCw0+c1LLMBMyI/fmkjSBC1tbHGP1ZBZTV4xF+LZ46q8g
 3uM+YF5CTeBYZ/i7N6Ocojsp2gQDuf6B9plBL1U1Dr//3U/FqGbt8JfzNWVhVZbwAY5tCrQd7Kh
 jf4N3uHkiO9qj8iHB/2gjlk20NS8N2BE1LO8RUzvtj4mZou9fka7T0wlkTWas0mIhmMW86mmPUl
 Q65XS1DY6azmSN5EFTlosMab2jbZGFDfAAvUrA==
X-Google-Smtp-Source: AGHT+IEfCXH0GLt1S08c+WO82u7mbw6LSA4YQl2uhEpfyFALiM0+8wEZCMR8xH5Qxzl+tD3mC6pkcg==
X-Received: by 2002:a05:600c:4f42:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-438913cafacmr193720955e9.11.1737486336923; 
 Tue, 21 Jan 2025 11:05:36 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046226asm186737945e9.31.2025.01.21.11.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 11:05:35 -0800 (PST)
Message-ID: <22d7e41b-925c-4ea8-819f-80936e5c8e71@linaro.org>
Date: Tue, 21 Jan 2025 20:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit
 CPUs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
 <20250120204910.1317013-2-dbarboza@ventanamicro.com>
 <9b2114bb-ed61-42bc-a5fe-f28a6a5319dc@linaro.org>
 <a6f3ed4a-94be-484e-a9ac-9f3b1eb9cf1d@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a6f3ed4a-94be-484e-a9ac-9f3b1eb9cf1d@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 21/1/25 19:47, Daniel Henrique Barboza wrote:
> 
> 
> On 1/21/25 2:40 PM, Philippe Mathieu-Daudé wrote:
>> On 20/1/25 21:49, Daniel Henrique Barboza wrote:
>>> The mcontrol select bit (19) is always zero, meaning our triggers will
>>> always match virtual addresses. In this condition, if the user does not
>>> specify a size for the trigger, the access size defaults to XLEN.
>>>
>>> At this moment we're using def_size = 8 regardless of CPU XLEN. Use
>>> def_size = 4 in case we're running 32 bits.
>>>
>>> Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig 
>>> extension")
>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> ---
>>>   target/riscv/debug.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)


>>> @@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState 
>>> *env, target_ulong index)
>>>               cpu_watchpoint_insert(cs, addr, size, flags,
>>>                                     &env->cpu_watchpoint[index]);
>>>           } else {
>>> -            cpu_watchpoint_insert(cs, addr, 8, flags,
>>> +            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
>>
>> riscv_cpu_mxl() seems bugprone w.r.t. MXL_RV128, better could be
>> some riscv_cpu_mxl_wordsize() helper like riscv_cpu_mxl_bits()
>> (or better named).
> 
> This existing pattern is benign since we don't have a functional RV128 and
> is safe seems to interpret RV64 == RV128.
> 
> However, if/when RV128 becomes a thing, we'll spare a moderate amount of 
> agony

😱

> if we choose to have a little suffering right now. I'll take a note 
> about it
> and perhaps a refactor might be in order.
> 
> 
> Thanks,
> 
> Daniel


