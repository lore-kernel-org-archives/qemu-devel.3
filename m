Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117BCE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMiN-0005Rl-6L; Thu, 02 Jan 2025 10:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTMiL-0005RW-1d
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:02:21 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTMiJ-0004RA-Av
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:02:20 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216728b1836so137897095ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830137; x=1736434937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCZ6wvwDsafiWjGpOZvFNPgmDkdDQDuENmwqU8kwNlE=;
 b=vLh2scetRos1tsSpObGqdinTdQhYvjAxsZOvfVi4O+2Y57iCH5pDTbsrWSz2C7tRtx
 ZUhSldj3Wtf8g8EcgJ4IbBV1Om628eaOwnVWhZiVWGxxTwYa9mVEmCuI3u1p0L8akTZK
 z3sCkpoqaHe/ZgYNvfh6j49KuK3CFlWJIn1sMuXxCNEbMcqlY+DuOVPDgGYJhTbkH9GG
 IJEitmEkaYj+zgPWS9bBrW3tB7ps++tS6VBeqeMgiGqmQc4FxMUpNh03qBynJXHyp1/A
 AOTR0k1qZa4rP5t4zhjdEhAwM5t10+0A3+Is7PTlLOPyIkvmR7edtQvq3rX8zvwFrnXs
 9Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830137; x=1736434937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MCZ6wvwDsafiWjGpOZvFNPgmDkdDQDuENmwqU8kwNlE=;
 b=gXOvQij0Wr/ICmU4ZiExG/AlYM0Vm1aa8+pZ467jfHsZBop1ZOlxTChnGL9FzchrsD
 1ApSOzaCCuTbdptU7Fbm18luOH6XnsVv5L70yYwU+pY42lMJB8ZfiOS2Na6/nr3V60gx
 R8wDSGlYbp6ic9aasVu+B9Klk+EABLGvOPfpPyHJmg/Y71MmPpD/Mytp3uMveCaMVzr/
 DTuCrPgOWGS7GLm8+j6oP7dNMep2lbQdcbHrXMXM1D9l/UAp9EOTRpKbaykBDTeAYKrA
 FgTaKVW7khXkoj2eKIFsDNE1sa7H/2XJv31QmREnghJLXfm6x3KyEiz1P9PxoohPWrS5
 0iYg==
X-Gm-Message-State: AOJu0YwJUvcZFSuu3x7S6IWTGYYgam9XUuesVJ6hdK89772YJ6ETqg/h
 OQqcarWyI/YOmvDZHiGM7P8sfSClLgyg+1L1AgBxH6BvTj3i8+o4Xt0i7bXBKol+N1oRuePpSEY
 I
X-Gm-Gg: ASbGnct2El7O51ufdgl2gzJvK4VrX1Rqy7/5ko2nc6xERxzCBW8R9y9MDz0VfD00AOX
 euReikkU+wuhug42INpw971Z+odQmy9uHM+6mIquwhpRGXLkDwnmQ7LQ7KOWPDEInjmTSpo4J5v
 a/lxmZ9NKb35w6vXG/Y9xLqg0h80xxZ6L2KXHtqFHVlABDPRaxYAQF+GacaFqU8x9unMOEWvyWs
 ABpHkIcWPwzd4v+dei4RRulyE+/8dmLv3FrRG/B7DKWf+SeSbfCITombz0JuoT1NjuQOiU=
X-Google-Smtp-Source: AGHT+IGWuY9EXKocqSGgDJ2lLBg9u7T+CyOgcaICK0rhnHaTRMjFsB1pUhFQ/3ig4L2MD4nf2dF93Q==
X-Received: by 2002:a05:6a21:789a:b0:1e0:c50c:9838 with SMTP id
 adf61e73a8af0-1e5e04464dbmr69568960637.6.1735830137322; 
 Thu, 02 Jan 2025 07:02:17 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e36c9e3fsm18952771a12.73.2025.01.02.07.02.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 07:02:16 -0800 (PST)
Message-ID: <3269bd12-5fff-45b8-95c5-96523fb53e25@linaro.org>
Date: Thu, 2 Jan 2025 07:02:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] tests/qtest: Update tests using PL011 UART
To: qemu-devel@nongnu.org
References: <20250102105822.43532-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102105822.43532-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/2/25 02:58, Philippe Mathieu-Daudé wrote:
> This series split a patch [*] which was previously posted
> too compact in multiple trivial steps. The last patch
> initializes the PL011 Control register, enabling the
> UART and its transmit channel, before using it to send
> the 'T' character in the boot-serial-test.
> 
> [*] https://lore.kernel.org/qemu-devel/20240719181041.49545-10-philmd@linaro.org/
> 
> Supersedes: <20240719181041.49545-10-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (4):
>    tests/qtest/boot-serial-test: Improve ASM comments of PL011 tests
>    tests/qtest/boot-serial-test: Reduce for() loop in PL011 tests
>    tests/qtest/boot-serial-test: Reorder pair of instructions in PL011
>      test
>    tests/qtest/boot-serial-test: Initialize PL011 Control register
> 
>   tests/qtest/boot-serial-test.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

