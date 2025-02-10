Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0AC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXAo-00012r-V4; Mon, 10 Feb 2025 12:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thXAj-0000tP-CJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:02:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thXAd-0001OF-OR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:02:13 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f6f18b474so30405245ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739206924; x=1739811724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PjuWZZvFT/zu6QKoMVm5AKliHld0wKOoOeAep+MSoIY=;
 b=wIR+rHdCiFn0xhAK5YHkwlCNMMplKogP66f1/Y33Xp3iQXJNS2gJ61y9bd98aF3cAc
 IiKuNjHBUdqg5RYdan++5sLhxV8JAIPKBLYbUZ9wAbympSUga9x86Oxy4zDDabtQbh4x
 FJmKhtHfF8oXzmXCyeuo2bH/y8MpDZyis7C+/rTj1G9JMf7cDaF5pg506gPESSbU2yl3
 OY+n4j9u19CyFvtpE0/yHaWNv6CR6YUxOOiqdJXKUGjvOlOoL8LXx2xzHoppM/vQck8s
 CMLbqMaFULFMFlTi/xSVTEZ4aXA/9a0Ea5b/tCY+HBgf8z4UJfNN2xgTxkf1UPTnrgf+
 ep2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206924; x=1739811724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PjuWZZvFT/zu6QKoMVm5AKliHld0wKOoOeAep+MSoIY=;
 b=X6FWbKLG3nvWVYNGBXSI1JgkxC3w4LFYDwOKHsYKLu9wBAWZCWbwovhnGtH0q44ybY
 Qp94JEmbfI7aGzg6F1IlMf5H8d60kPn/EiT0yh3OBals+meFPux2GjorSm6Wx9e6PFkP
 Ie5+o8eAgDAqStclXotSCSxFDHyvNkJ8fLkt+yXkWGZK1x/50WwNFjH0N8YGpUt51i5N
 q6UyvH50uIv8+3b96PqPc8Dxo7bdx7R0q0iNClzQ2D2cz71VZ5BpdDl80uLrIF1qDElE
 9uCtbT+WsbY30PEEIQxKZ++KP/WzCL4cD9UaMlj729MFh4bHfHpHcU1AZKuK+2I8IMeS
 dohg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd/TAZl8bjkOU1JzxmTwX5QAeR4mpJpIQoNeQmbymMnytlaFmyY35R47w+rG9RmRKA/NHLfBemS5+R@nongnu.org
X-Gm-Message-State: AOJu0YwdOQVVB5NA7qvh2TPD+q7+VxL17UySYIA4sud+/X4hBPvHRsH4
 GqgTVu21EruL3CfQYkousDJorU9AgZWOFXHPAvNMjmrUfcuIoEhPBYUbZu3uTks=
X-Gm-Gg: ASbGncs8RAqwEgcoWuCmwtCbaC8qoOcVWQg1AxyKbKQlEItgRMdJQXwpP+wqVb2WZsh
 IHQJ7jtVyAzLgU+mQ/WFkgjbGvLm5hfxrJuJ6rUV5rYgANyrLcNraSY1GWCRkGz9nrfTz+Ng133
 SMtZSMq4Ny6trsJvzaK+g285+EsvQRVkcwU+ikZI4pm1d4QXDlpDjDBr5lYogYu+esaSoODUfKL
 f5omRVUYfXAGt9skuyQk6wN9bQ9MuJHLnJ1HFFtJeWDcpridp6wQcFvczHww95JS6X6HelSOrLN
 k8OMN74BgpP1AQnUFPWRDlc2mCKNvUEZrZG3me2q97ReMwgB5r/GuxA=
X-Google-Smtp-Source: AGHT+IE8d6KmcvevPEpdm8Gq6HYynfOw88u0AR1MAYzdTXUd7+gL2li5j9x5a64czIJvjUXnalWj2A==
X-Received: by 2002:a05:6a00:cc4:b0:732:13fd:3f1f with SMTP id
 d2e1a72fcca58-73213fd3fe1mr818162b3a.24.1739206924047; 
 Mon, 10 Feb 2025 09:02:04 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7307cf77a3asm3897011b3a.68.2025.02.10.09.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:02:03 -0800 (PST)
Message-ID: <443902c7-8697-44d4-9f7d-9bddb93607aa@linaro.org>
Date: Mon, 10 Feb 2025 09:02:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qom: Constify class_data
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <d0c8837f-a47f-45ad-a060-0a2b638932a8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d0c8837f-a47f-45ad-a060-0a2b638932a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/10/25 05:46, Philippe Mathieu-Daudé wrote:
> On 10/2/25 14:31, Philippe Mathieu-Daudé wrote:
>> Since v1:
>> - Make XtensaConfigList::config not const (Max)
>> - Update / test rust (Paolo)
>> - Constify InterfaceInfo[]
>>
>> Following Richard's suggestion [*], make QOM class data *const*.
>>
>> [*] https://lore.kernel.org/qemu-devel/f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org/
> 
> I'm only seeing +3KiB in .rodata for each binary...
> 
>> Philippe Mathieu-Daudé (11):
>>    target/i386: Constify X86CPUModel uses
>>    target/sparc: Constify SPARCCPUClass::cpu_def
>>    target/xtensa: Finalize config in xtensa_register_core()
>>    target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
>>    target/riscv: Convert misa_mxl_max using GLib macros
>>    hw: Declare various const data as 'const'
>>    hw: Make class data 'const'
>>    qom: Have class_base_init() take a const data argument
>>    qom: Have class_init() take a const data argument
>>    qom: Constify TypeInfo::class_data
>>    qom: Constify InterfaceInfo[] interfaces

There is some additional data that can be made const after this [1], though still not 
lots.  But the additional data that Paolo was going to add for 99 riscv bottles of beer on 
the wall would have been quite a bit more than 3k.


r~


[1]

-static M48txxInfo m48txx_isa_info[] = {
+static const M48txxInfo m48txx_isa_info[] = {

-static M48txxInfo m48txx_sysbus_info[] = {
+static const M48txxInfo m48txx_sysbus_info[] = {

-static struct EHCIPCIInfo ehci_pci_info[] = {
+static const struct EHCIPCIInfo ehci_pci_info[] = {

-static UHCIInfo uhci_info[] = {
+static const UHCIInfo uhci_info[] = {

-static UHCIInfo uhci_info[] = {
+static const UHCIInfo uhci_info[] = {

-static StreamSinkClass xilinx_axidma_data_stream_class = {
+static const StreamSinkClass xilinx_axidma_data_stream_class = {

-static StreamSinkClass xilinx_axidma_control_stream_class = {
+static const StreamSinkClass xilinx_axidma_control_stream_class = {


