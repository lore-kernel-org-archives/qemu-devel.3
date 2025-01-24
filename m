Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6C6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNAu-0000iE-AL; Fri, 24 Jan 2025 12:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNAq-0000gq-KH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:08:52 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNAo-0005M1-UU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:08:52 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21661be2c2dso42009995ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738529; x=1738343329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tj/NAv0Ynf2AulVqLQQFTDULGRVSFIkbpyRGfXdGZ4M=;
 b=lfcVyKsQpo1iSB+LPEXfYTntmF5NhuHRFQuwjV3tzqInQpr89+fcNbkduzTJD7Swud
 G6bJF1O2Te3W4v6Y7HscKYLHmadyDoFh4kKVIHpQd8HQC8rD8QeiZrDZtjuvpKbOasIY
 p4j+rJs1HveqV6dup1r4p32KX5UiUfespiBeLV5bkCdVJfoUVUfYPJGRUtor1KuIIpIt
 /U/aRLmWjnY+bobjrrmdNZ9Pdh1Rnk4jeowb5OFO/nEPSTBZX9/1EA+w4WCkcflsD2rP
 Q/0IOZiKoRM+X7sC9FgfzixNTct/8PbywX5ag1bztCuMdVsTdtRM5eYClM+uIAURpK5j
 99Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738529; x=1738343329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tj/NAv0Ynf2AulVqLQQFTDULGRVSFIkbpyRGfXdGZ4M=;
 b=lj0U6odmNC/PW7Q1JOiFmwMmGh+/5Q9svvj8pYVXbEQZFJZhXFLNWu90ViAA4l+3iW
 E6cis4Wc5aknqgOXvHwab76Lv5w+Srr4T1oxZS3VZREMufXwU8jk2rfq3w6aA/JInDiu
 4dy59ZnDhqH3AQs+xCF7bc70qL+6yBkgtW5c5o2Caimszpz0KJHQ3aCvndBEqvvWHd7S
 F5LBeQ4MxH8U0Cyfuj6o15NnnM51oLOtzW6vZpqaysNqeulO5GJNcID+nRPAr0kNVZIy
 +g1/NKssf1MLPVgYEt3m2BUuULpR3KZ3ZzZPDqTtZ/1rGhdK9BGw7eIFCH/ySSJHjNRn
 L7XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXewV96IS2vnT9NhHKfl+zsN8ZWUNPT+Xqk+Mvk/RwfIPgn3E5i/Sj5M6Z0OkWvOAVEVd609BXOdf7u@nongnu.org
X-Gm-Message-State: AOJu0Yx9rA5UDCqC/r1hq3DH2OmU2yNN8Fv3WqMpHeCu12RZT66Y+EKs
 Q27FtM7LuFYcqjQ6Wn2xPvgr0nwDq6GhO14xDpZZ1Uq3dFyqht+KcMn6YzQVu2k=
X-Gm-Gg: ASbGncsyK2MuuWBjITIoQpwEPY/eVZq5dVqzSZxWpjv3eJoIhsnAeHIIp0Qwnj8kpft
 0Nd4UUkYeQaeSTZHt11nznx9gDQPW2fBtrkkODw8+OOOWSyyBh1+YeMBnvMAXmO2NZFWux095qN
 TYmBMl8moZGD8Oj/42AjxrX1gLlmv3EUK1zATBK7FtjggUAmWRqSa2Ejw8Pz3TWaN2o+nTRlPCS
 1a9xjaO675YoxN71gk6JfwJhdSr6bbEt27HRT+HWqTYcugDMPpC0NpGJB0vcpkPuShXO3zLQzqk
 C707UdiyoVRWN/uBy/2rRY4b
X-Google-Smtp-Source: AGHT+IGXPBp8woQvoDTOIR035IDgH/Ypck/+J/RsSS4cOqAFAF+pT4EZrH4/buBSuaDw0QNnL0Z8kw==
X-Received: by 2002:a05:6a00:be0:b0:72f:59d8:43ed with SMTP id
 d2e1a72fcca58-72f59d84743mr18054700b3a.14.1737738527933; 
 Fri, 24 Jan 2025 09:08:47 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a761144sm2173711b3a.101.2025.01.24.09.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:08:47 -0800 (PST)
Message-ID: <579fb936-8d4a-4967-8130-07ff28e529a0@linaro.org>
Date: Fri, 24 Jan 2025 09:08:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/28] target/hppa: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

