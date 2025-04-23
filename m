Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1175C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 14:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7anb-0005Q0-M5; Wed, 23 Apr 2025 10:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ana-0005PE-58
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:10:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7anY-0008Sf-DQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:10:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso5891595b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745417398; x=1746022198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POMHppeodji9WSw8QMCxTqAPeJ62oD7ORyJFUAh0fcI=;
 b=Hncye54s6YhDHXjv4a9pksjb8fIxSBX+5fMSKXvuwP39zJm5Iqco0gRINRnY6/tMB3
 Qz/ALXSk/gzwEF37AksNcQzf6ZFdvawqwjo/UwxSEMdWMfKhX/0mEPl4+SZZ/2yBi1St
 41X7LY8p8YwF3cgvbD6oR8pUpO6RU3R0cY5f/nQjj7jLXgjx7XWztac5Yd6ebV3h4U82
 TCshUPAi/z0S1cbKpCbJVNuiTLAn13CnJBpf67k+5PXXIX4ek2UdETd6mwXRur5bgsW1
 II3sz+5sSjqyYYxOwdOhEuhCm/oQQjEqyBh/ulD6chycvnE8CkhH02iX4q3Mx7KPJjw/
 4+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745417398; x=1746022198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=POMHppeodji9WSw8QMCxTqAPeJ62oD7ORyJFUAh0fcI=;
 b=BhHymSdGSiHVCHGSWjO5zkg1apw6EFaVtTViVtn4a30lX6GQbk3R8ITScFsgz+hPyI
 iCMS/cSNjpzXHouCLNS9XjaR4nxpvLtzD4AhHHemm1PwtjcVCKGbplgjvcrWQnoPArnF
 njayDc8O/ONxZ4FgciO6cXBMp3l+iZ67J2hhQAa7rHt9xcJ4DFchQXODTl91Y/qpRZJX
 JMqyxGsRZaQVYxYL2k3hiarJIy0pvkrK9K+OtoByA2vSHnU/tMnqsDFLL4eZ7vvMeDUF
 IoZJDVPuSOPc0Wpa4QXk1YsLMzrCJEs1OAotvj+tS1F8tRmdF8+F4lb1IkqCPg3zEUdl
 oACw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMztI3xjXGLdHBH5eCHmT117upu++RIOOEJkwgmxgjq29LUodWBnM8683Jkqr+8QEIUkY2dOqJd9XY@nongnu.org
X-Gm-Message-State: AOJu0YyjBwSFis7WepVEWRpP7YjZhijoVmRvIMC5nHoj6e482doauZNq
 KXHr8LqRq5VO+s4Mqk3yjj5uGgvYv5DgEjBIaXoeX3AaHq0JEXIHHcbHY0WSjU+2BT+cobMskJl
 l
X-Gm-Gg: ASbGncuIjVJqbm5cHgmK/VMNWAEBo5aBRAhICctM9y6Fl5jUu6pSk50Cpqf5H/0Gz/f
 5jcEuzLAQY/F+bz/m8CRHCbCuhzCcrrb/6FbS0WzzC2eOn32f3lyrC3YDCYjkWM6o0tOeuw/SOa
 7CMgkmVshdruhkx5bimJXNugVzZMY6dmoujUC7MVDvQVJrnKBKSjyH/EHUmJQTqmfekXYT9l4ky
 mI0zysJ/9rhcgbW/PsQTutgaJ5vqMsTndRekb7bsvWcBLartqiILAkk0TwoxfV+xg67/b2WW3T0
 vLBSCyz03jnGl8zkuFGBxVoKFYfY1McoCk/3ft8bOBDdkcjutFLVZwDD/Rl/8j/ZCWuR8/oh6R5
 ncMiNq9Pi6+RZqkPP0Q==
X-Google-Smtp-Source: AGHT+IEMUq5cAFP7ZaniCW6ONNdyjrK4hlqMneewegDdhutyQN1KXnt1CQn3ixd38PzImlGVYq6anQ==
X-Received: by 2002:a05:6a20:6f8f:b0:203:becd:f9ce with SMTP id
 adf61e73a8af0-203cbd48c2bmr26533093637.39.1745417398356; 
 Wed, 23 Apr 2025 07:09:58 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c05d1sm10963444b3a.12.2025.04.23.07.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 07:09:58 -0700 (PDT)
Message-ID: <6c10ea75-2a10-4a84-83f3-294e813dc46f@linaro.org>
Date: Wed, 23 Apr 2025 07:09:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: allow tb_flags to be larger than 32bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-devel <qemu-devel@nongnu.org>
References: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/23/25 03:09, Ben Dooks wrote:
> In adding a new feature to the riscv target, it turns out the tb_flags
> had already got to the 32-bit limit. Everyone other target has been
> fine with uint32_t (except perhaps arm which does something strange to
> extend tb_flags, I think).

The cs_base field has another 64 bits for you to use.


r~

