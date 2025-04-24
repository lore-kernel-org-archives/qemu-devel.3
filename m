Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B40AC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tOE-0007hL-9U; Thu, 24 Apr 2025 06:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tOB-0007gR-RJ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:01:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tO9-0003zc-TV
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:01:03 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so856275f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488859; x=1746093659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gVcX5wrLiwCRBaFn5KwdbDyDMMG/O5wycuzrNgvqAYg=;
 b=oIL+lwcRhDObqr2Ms2U+psgJpPB2YxlJm0GbCGOUECTZJAcAMDZujH8kjOJkf+w+ug
 N3Q4Hbwagdj/JBXZJ2/bKIPh8WUKO2Z7QvP3fC0UmQA6N4sbjcvV6p9vzkVxZ24JrM49
 CzxWYb9HWtcCwJ6y14dhvXo5htE7HvdqQczptlUC85OziipQcqdlLzJiwt986Q3TnC3O
 zJlIg3KaKPhrYIiWuAHfMGAA78DTKk/ybNAOA6C2OH+W8WQMTSgde4zJ6ArXZiTvzNut
 DYmO1VDE5ZW9Z9Q7Tz8+fvif7ELfcdcPdx7g7y7kSLkAgt+h7TBAOOn34wh7m/KaPz63
 KzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488859; x=1746093659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gVcX5wrLiwCRBaFn5KwdbDyDMMG/O5wycuzrNgvqAYg=;
 b=Pop9SC5D5pFLR5QIqG0JTynpjoiJtkfzxpJCd0XfJpDYJiTew95DjJTI6KWQMniqjO
 4i4MR2LeS4RsbiG+PD2HpiUAE/Ae8XuJxM5OA4T2D/9WJgDjTxe1GKqfWYtVbYfxNkSu
 +pxDTSVG8lHiN27ZJyD02FtmcYEAhWCKQ19lgTlK6JOApG0yz1IBF1+BgNXMAcDTONW+
 KGxGBa2obVCKAT4iaE8CZRCPTv1IEYUvS0Wr+Ty1GjenHPOx/8Bmo4U4MIeBxJ8UwqIG
 g5o0GylszoAD1gcToAWuetp1W6m213Exh3uX2kzGs+Joiq9/b+mSWVECefAbn498X1TL
 pC5A==
X-Gm-Message-State: AOJu0Yy7yUObORvCNvOGA3W7fWl6bZcFGmsea1dl8vPrrW6oiYtuAe11
 yE0kJ7ZbTNmFrGP5AxT3lXDlExYZPSk6Z7bi7ycmCDLFoWDFNME7H8b0yVBB73zxq78LyyE0zEj
 P
X-Gm-Gg: ASbGncvE9fmtOeuVAluQ6VBBsWvKvqL3suSUqgHohgHpUKbTTZeplGiiogyFHlp2Ywm
 UsB1aCRLNSyp6a0Mf3kBHI6S38J/06myUEq1ITW2JP8vsp0xZm3pMP4Ez/0OIwDF5fH61zNMVkO
 cqQ1CwBYprCNrQbymb5mQv6/wQZ/hNbNPuxpMlZagTSFJaCmacR3rtfyw3Qj39nvvYC04VRBt1x
 SaSR7At2+8s1MDf5eFhEYeNRB7DsXbuA9cj2AvL9GsKoMNFOWLPFPq0K1NunYO9M+Pn4wbW8n4R
 MmHyNjyQO1t+px4VBXmCS2Z8ENg6yHaq9vIU4Ds6hkz/KAh+yo+njhn8arinw9Xdvpjf6nXhNwL
 OmFAC815V4hC2hFSFmAfecUrw
X-Google-Smtp-Source: AGHT+IH3mCB78EXIRDy3U54XI91xib7C6CF7lzS/avzgjml/1orsTfg1vO2UQAzAYYMK8cEsl4UWiQ==
X-Received: by 2002:a05:6000:2508:b0:39e:cbe1:8d68 with SMTP id
 ffacd0b85a97d-3a06cf4b79amr1510927f8f.6.1745488859528; 
 Thu, 24 Apr 2025 03:00:59 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2b77f9sm14328295e9.25.2025.04.24.03.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 03:00:58 -0700 (PDT)
Message-ID: <9d2816f1-c4e1-4da0-bcb7-fd2c4f4adec4@linaro.org>
Date: Thu, 24 Apr 2025 12:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: change default CPU to 'max'
To: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <20250404152750.332791-3-dbarboza@ventanamicro.com>
 <debc3677-3282-4064-a34c-0234d0eb7a78@linaro.org>
 <CAKmqyKNMUU3brR++stxae1VmSW2eJLRGpxOBr4+FJWjde3Yt4A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKNMUU3brR++stxae1VmSW2eJLRGpxOBr4+FJWjde3Yt4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 7/4/25 01:31, Alistair Francis wrote:
> On Sat, Apr 5, 2025 at 9:02 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/4/25 08:27, Daniel Henrique Barboza wrote:
>>> Using 'max' as
>>> default CPU is done by other QEMU archs like aarch64 so we'll be more
>>> compatible with everyone else.
>>
>> This isn't true.  qemu-system-aarch64 -M virt defaults to cortex-a15 (for hysterical
>> raisins), which is completely and totally useless.  Which means that one must always pass
>> a -cpu option to qemu-system-aarch64.
>>
>> Moreover, -cpu max has zero migration guarantees, so anyone who wants to be able to
>> reliably migrate is encouraged to use a real cpu model.
>>
>> I suppose, for throwaway VMs, -cpu max is a decent default.  But there's a lot to be said
>> for not specifying a default at all.
> 
> I agree. If we aren't going to specify a default machine, why specify
> a default CPU?
> 
> It probably makes sense to deprecate the default CPU for non-vendor
> machines and then force users to pick their own CPU. That should start
> in 10.1 so it's a release offset from the removal of the default
> machine.

IMHO this is the sanest things to do.

> Then maybe think about even removing rv32/rv64 CPUs and push people to
> the profiles, as it's a lot clearer what they are getting.
> 
> Alistair
> 
>>
>>
>> r~
>>
> 


