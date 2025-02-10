Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B746C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thU7v-0002YO-73; Mon, 10 Feb 2025 08:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thU7X-0002Ut-Ni
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:46:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thU7V-0008CQ-1v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:46:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so10673915e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739195195; x=1739799995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZugZV/n2QaeO/Gh8izQqdgxuPminCeV0l6e+PlwZ7c=;
 b=eeTcnPNQl0w1zVrXF+70u2kg9aq8DnlAwjtGSxNM+9fn2dDX3nbaKfghF8BIMqWlY2
 MpGy/Yin82PWNOiAiZ0wyYlH90s5d0qhp0yL5N/ek55rPo0aOcqlketutiY0kkkLGzPj
 Dx7bOHA3ElqvMvuVnunRZqGiQCRBioIGGQGIioHwkYc1JEmxb8VkxX2ODUEhIan/Lx/w
 cIeUtqNYri2HLPVZ7tJT58zKKPj50vchUH+Lgi2gL+FK6wUJjfwqCzDeGQPoYBuxvcE1
 nyWQL+rOBlrGmQpT2wdksfdcFPKX/WSEHh5LglEmj4pm4kQgXdVDH16F72koWf4SB3WE
 ATPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739195195; x=1739799995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZugZV/n2QaeO/Gh8izQqdgxuPminCeV0l6e+PlwZ7c=;
 b=faYjyQd56CrUnOYuJgjuoTcwyzwRLiGdDLLqxmzU/Ckl6/HO6GO1/q8v+4YKabTMdd
 i/ciu5rJkNWL6WbT7+IAZ9LPTfjsHEpMAAIT6S+qMX5TWe5NvTfNtuI59Wcq2H0zk4QM
 iFjwbozvuArwfEmPgOz8rHUIoIMtjiEi7KAUDnMldnhdqQQjawk+nxop9gaHqPnFGwKO
 xkbB0sP8WQ/wVcxGB9djNRSwL7Mlt92a1+f1RZuW8SAcuN82dPPVYHexDVd0zG8uvp7z
 VInWp4P+iYNRB5to4gEsQsekOHRs3lHB0AiayCoj3rVUQ5Qj7ETIPXbYNDrPHf4Twpo6
 ABZA==
X-Gm-Message-State: AOJu0YyyzDl6XE+IE60v8sKLt4YLaxrpKiscsW1+TWYf59TJP1kK8ros
 yvsfQjz6YX+tlOueYfLf5alk8g3OuunAupWLwHjZLHcaFF+ymX3sA/Yz5kWxeI/QXDKs3nYHIv9
 p92A=
X-Gm-Gg: ASbGncsCebP2G7uvAPsLRX2P/efdGvDsMi41m61YApgrBbgAKahpnv6j8iZIroCmSBV
 TM5a9AWb2fZxTC4QKJlbkK/E4YyEhCu9z5y4q0LD29rQaec0xsaLdxs1SaIdvbkdLp31YRoyDBl
 SsrAEqJjqqaexZ0Q/zj9EK9Wtqe8R1dah33CnmQNJg31fgXIOiXf+qnsEqBix8uXHlOtAadrmFB
 5p1InG1d6OgkwkkChIxyWZ9gk+2XqchijeqVKLgDlaxN/gIhd/kbB/F9pk1xOJicvjrEj7fWpZv
 GHcvoN8gdBM/iZ77fWb3RFH1DHokrVv8w5xF3Ph0jjVXWPJ6sxtKKp3nF5c=
X-Google-Smtp-Source: AGHT+IFgadto2jQamt3FOOHdHWiZT4ya/blXUPbRww//ZXCE2lqTcSs7sYD/3vCwuDEtYRmrMxvDoQ==
X-Received: by 2002:a05:600c:1f81:b0:434:f767:68ea with SMTP id
 5b1f17b1804b1-4392497dbdbmr124622155e9.5.1739195195406; 
 Mon, 10 Feb 2025 05:46:35 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394779a96dsm20781585e9.4.2025.02.10.05.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 05:46:34 -0800 (PST)
Message-ID: <d0c8837f-a47f-45ad-a060-0a2b638932a8@linaro.org>
Date: Mon, 10 Feb 2025 14:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qom: Constify class_data
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/2/25 14:31, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Make XtensaConfigList::config not const (Max)
> - Update / test rust (Paolo)
> - Constify InterfaceInfo[]
> 
> Following Richard's suggestion [*], make QOM class data *const*.
> 
> [*] https://lore.kernel.org/qemu-devel/f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org/

I'm only seeing +3KiB in .rodata for each binary...

> Philippe Mathieu-Daudé (11):
>    target/i386: Constify X86CPUModel uses
>    target/sparc: Constify SPARCCPUClass::cpu_def
>    target/xtensa: Finalize config in xtensa_register_core()
>    target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
>    target/riscv: Convert misa_mxl_max using GLib macros
>    hw: Declare various const data as 'const'
>    hw: Make class data 'const'
>    qom: Have class_base_init() take a const data argument
>    qom: Have class_init() take a const data argument
>    qom: Constify TypeInfo::class_data
>    qom: Constify InterfaceInfo[] interfaces

>   1119 files changed, 2066 insertions(+), 2002 deletions(-)
> 


