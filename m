Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA82C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXTk-0004WM-T7; Mon, 10 Feb 2025 12:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thXTi-0004Uh-NJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:21:50 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thXTe-0007Lb-CO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:21:48 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso783056466b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739208104; x=1739812904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=duGXbvA0hjBfTk7OhJrVu/9zBhz4Li2GRi+3aPRPIFM=;
 b=VDROrh6L3eZVJ/hLlmtimal0H4betbiJTGcvQJbZG53w8fvlhslRdDYgyNuXZ7ov/m
 3QH9yPaTfaMgFS96FTNPz1sJ5O24eg8Gh1Mw4pQtKf2pW4Im6C48KDqe0LPrAla7QCbr
 wv7vEyys9bIqBNPDBeVn1kFNpSpUIR26dv/veN/Th9CPvMkx5zlUSPNGPEOX5+xVdPJf
 PVExxxsSX9+wP0y687L4ziq7/UsFh7xK/Eq27F00zz5+4tRrB5svm3UjnIe7icjs/6kh
 KqoZTSEHkbFZZK+Dzq97KooF6myGNo5Q/VUrPAlD9Lx9A5Oczm+5HkMHcs4806ZcSYgH
 sdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739208104; x=1739812904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duGXbvA0hjBfTk7OhJrVu/9zBhz4Li2GRi+3aPRPIFM=;
 b=xFHEoAvgyPJgyu0bhonC9C5TKhkXzQkD8E++/gDS5gVCncdqbv4/2MTGo4gDnifd/r
 ZW1VFHqCRoOEbdl1EDLiL6Pj3yFBzFjIPQOo0PhWB0+npTkmhrV4YwdSlaxJlgIUJsdZ
 6lJoxR/NMZdKmd5rf80OYYhQxOqkeh6OWyQhkVqGH05BM45QDXwHLJDceQUQ/IFCWJXN
 bN3Mp/dxe5bbu7DVlAs046HKB+5a2JkM1qVfwt+Bw2GTZ4idhaY/R6xa+Yy4W+0eGSIb
 oVmrnMQqvXCtS/0SEZBxEqXHCTPPqmdl430eMC/HFtYdS4rkbA7VVUjCux30Pd82I7xI
 leqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5NNWjjEYIjHlLZTEkW3XUEFzoYhN6hqG72TM3xhobSLyx6Z5Vv0wIuaPTvw0qIwjcIQQTe38CMlwz@nongnu.org
X-Gm-Message-State: AOJu0YxQxRoV/kYNCcMOCxvl/Fp/mshWgGp8ckdk+Jl4UWwj1eg7L0EG
 SXpx71jQIxYYy11NgG9rlP0xDPxfTBGDwat01sVuFitYk+KF2zuDqu8KSHzNC00=
X-Gm-Gg: ASbGnctcRqBtC4w331FbMGgx+rlP9pJg0PoHgoJ0NJ/NRZP1eTA7Ejbpk2pAOHP8DIQ
 w1EA+cXX3ChIUM4/Q5v+qRUoV6IsssJoe3aWyho+QlICE9tqT50jSk9UiWKHPa+pKyf+rnpZ4rL
 KQH1t1nRX7vS/DNtLwiKvId/YyOK2Iqt3Gs8I97M7Xg5kgw+RQ8fqQK6W9YMCjv85ejG1a2XfD4
 cxWAT/MYtiDy+wLewvnVEgH/uJy0nT7+sy7Gqv63/5dFp7HB+S3f5mEetqcukrBj9JCF7LD0Gqo
 OhLmpoLJM5XJNkaTOCaYehasm+GsSRtcKMzdU6e5+NFBzrsPlMoDlDWS0WI=
X-Google-Smtp-Source: AGHT+IGJ8PEeNK91ASTgw3auwFAxaUK0F8OverbQHigtkZXr7d7OUa2R7ehntOr9m7cxTdxZZ2jcHw==
X-Received: by 2002:a17:907:1c24:b0:aa5:225f:47d9 with SMTP id
 a640c23a62f3a-ab789aeb5demr1461294166b.29.1739208103888; 
 Mon, 10 Feb 2025 09:21:43 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab78c219740sm760973366b.61.2025.02.10.09.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:21:43 -0800 (PST)
Message-ID: <58008d22-a006-4e42-aed0-1cad51458a8a@linaro.org>
Date: Mon, 10 Feb 2025 18:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qom: Constify class_data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <d0c8837f-a47f-45ad-a060-0a2b638932a8@linaro.org>
 <443902c7-8697-44d4-9f7d-9bddb93607aa@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <443902c7-8697-44d4-9f7d-9bddb93607aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/2/25 18:02, Richard Henderson wrote:
> On 2/10/25 05:46, Philippe Mathieu-Daudé wrote:
>> On 10/2/25 14:31, Philippe Mathieu-Daudé wrote:
>>> Since v1:
>>> - Make XtensaConfigList::config not const (Max)
>>> - Update / test rust (Paolo)
>>> - Constify InterfaceInfo[]
>>>
>>> Following Richard's suggestion [*], make QOM class data *const*.
>>>
>>> [*] https://lore.kernel.org/qemu-devel/f4ec871d-e759-44bc- 
>>> a10b-872322330a3f@linaro.org/
>>
>> I'm only seeing +3KiB in .rodata for each binary...
>>
>>> Philippe Mathieu-Daudé (11):
>>>    target/i386: Constify X86CPUModel uses
>>>    target/sparc: Constify SPARCCPUClass::cpu_def
>>>    target/xtensa: Finalize config in xtensa_register_core()
>>>    target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
>>>    target/riscv: Convert misa_mxl_max using GLib macros
>>>    hw: Declare various const data as 'const'
>>>    hw: Make class data 'const'
>>>    qom: Have class_base_init() take a const data argument
>>>    qom: Have class_init() take a const data argument
>>>    qom: Constify TypeInfo::class_data
>>>    qom: Constify InterfaceInfo[] interfaces
> 
> There is some additional data that can be made const after this [1], 
> though still not lots.  But the additional data that Paolo was going to 
> add for 99 riscv bottles of beer on the wall would have been quite a bit 
> more than 3k.
> 
> 
> r~
> 
> 
> [1]
> 
> -static M48txxInfo m48txx_isa_info[] = {
> +static const M48txxInfo m48txx_isa_info[] = {
> 
> -static M48txxInfo m48txx_sysbus_info[] = {
> +static const M48txxInfo m48txx_sysbus_info[] = {
> 
> -static struct EHCIPCIInfo ehci_pci_info[] = {
> +static const struct EHCIPCIInfo ehci_pci_info[] = {
> 
> -static UHCIInfo uhci_info[] = {
> +static const UHCIInfo uhci_info[] = {
> 
> -static UHCIInfo uhci_info[] = {
> +static const UHCIInfo uhci_info[] = {

Doh, I took not for these but forgot 🤦🏻

> -static StreamSinkClass xilinx_axidma_data_stream_class = {
> +static const StreamSinkClass xilinx_axidma_data_stream_class = {
> 
> -static StreamSinkClass xilinx_axidma_control_stream_class = {
> +static const StreamSinkClass xilinx_axidma_control_stream_class = {
> 


