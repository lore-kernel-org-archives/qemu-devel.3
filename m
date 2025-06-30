Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A254C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 10:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWBvt-0000sn-NI; Mon, 30 Jun 2025 06:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWBvr-0000s0-W7
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 06:40:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWBvp-0004c4-TN
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 06:40:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so2367488f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751280011; x=1751884811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mom5LQxUjm35pzhcz/l3E4aQZsPfuxy5sbnIVHuSxIs=;
 b=FGfQQv7Old8qAQgJfWFpQLkIzA3ljK+tv0kMPa98sCA11EojKzZTvQiVSPZqq+7K7C
 de7Akh6savSfes9pK0IdqfHnLoVyrfC9MnX2zUW/H7+w0uGPwIiOXUsUkiQAtOhe15Vi
 mF/c2psBr224nm1x8rZq4i74Bck3WTQtVg6QdzcVuqb2qWQ+LmLgIKje6ILt9ASUbzK3
 sM8VIwJFZEYo2JaCC6EufF+m3VZBaga+I9oSAjIMBAxEMA9WPsWPPmJ/H76qG/WpjWFL
 c4UjbgwRSuaPHYRpQ4r1dwlhdWGie2x6s6usuhLAWcKhFqMasirLS9aW/fI1UAEJAWIV
 qJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751280011; x=1751884811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mom5LQxUjm35pzhcz/l3E4aQZsPfuxy5sbnIVHuSxIs=;
 b=TJptQh0l6i/nvjfbAs6o812xIwESBZKcI1VtMWOKdPbuxzD8NJuzRHOsVrk/fbHCxh
 Iz7iKZX6JgqN4vhi0swS5Ak5+5riufzoEklFtXhqcs4+uTwdp86j+ADvYt6VDwUuQxhv
 H0u+2hgToF7f0f1+wFxOZzG4+Q+j03/J3zrFl9owifGo8uH1Y2hiwH9wAA016S2qIqho
 hyZuttIILDTlaw94YSBPTBhyqoNVMOoSH0EurfgDVySFu4TqYnTV6sFIAfTXV24fC690
 VMMqH1Ag40H7JvrLDZ8ibEAwD8MTN/AG5RPic7jLKwBkzW+Khkdgbw6jdxlblIVLwUKd
 5YCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/ECBaXc31dYnSpTrRc//FvostbK/JHGiimaSVwGTp/FUEMSfLc8FUhtYnxsAaN3vEXtAl5IWxf6YF@nongnu.org
X-Gm-Message-State: AOJu0Yz3gdRu5Z61wT0xCI/9J8jlearfw4igvZHYNDLamlABQ4xU1Hep
 vVdCD0DfYvo7r0kCczgZwTEP1cisNDZuDIFEXw7xfqOjLWCp3Yp2c57RlSXdQtMcDzk=
X-Gm-Gg: ASbGncuEEbmY4ioUWxkCjSfnaDH7UFfOqgLAzuHXRPXr12duE5aj/EecCYM1US62ZX4
 zE7BCrGYda08+aM3zqs1URpeu0+FsGa1N0tgt6rc7x4YKAbbacTo8QPv655+2E7OvB+B7krcTyL
 8/+8ujbVRDP7HdHL7yp/FwYeugZxDUnRNKeGqY0Xu5Oj5lUf0yeio20TVRwJscBz5uVotUBOath
 eoGNhXYzdj7aqJclm9slYZCYmARj389N3oIpOH6jX5rKXknNaVd/o6q0ZmvfpS132SzxM9h3Ht1
 U8M0p9gz49rrN7mk3fXIIXlQJ7dRIO3uniUswiSDo8O69MZ4qxKyf+CmMWc9KW8WPioM1/fCH0w
 OpX6Pf4RfeJeonvPCP8jnoNykI4pyQw==
X-Google-Smtp-Source: AGHT+IFwLtX83S5RDfeqOTSfwGUoY0JFIWPDczVGzUfZ7RHaXVITfp2HkYWocniowMZRZ49hb/L5tw==
X-Received: by 2002:a05:6000:4009:b0:3a8:2f65:373f with SMTP id
 ffacd0b85a97d-3aa9fc2002dmr9305882f8f.16.1751280010773; 
 Mon, 30 Jun 2025 03:40:10 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e76e1sm10240009f8f.16.2025.06.30.03.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 03:40:09 -0700 (PDT)
Message-ID: <128b814f-ca25-471a-a31e-b37df46ff8f2@linaro.org>
Date: Mon, 30 Jun 2025 12:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] i386/cpu: Use CPUID_MODEL_ID_SZ instead of hardcoded
 48
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250630080610.3151956-1-xiaoyao.li@intel.com>
 <20250630080610.3151956-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250630080610.3151956-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 30/6/25 10:06, Xiaoyao Li wrote:
> There is already the MACRO CPUID_MODEL_ID_SZ defined in QEMU. Use it to
> replace all the hardcoded 48.
> 
> Opportunistically fix the indentation of CPUID_VENDOR_SZ.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/cpu.c      | 8 ++++----
>   target/i386/cpu.h      | 3 ++-
>   target/i386/host-cpu.c | 1 -
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


