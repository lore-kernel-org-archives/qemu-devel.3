Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C17CCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF76j-0002jR-Cl; Sat, 01 Nov 2025 04:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF76i-0002jJ-Mc
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:37:08 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF76g-0004Vk-F0
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:37:08 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo650572966b.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761986224; x=1762591024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7F8NicqZfMJl5cSldlPUlBXgM988Pj+TePKd7HRrcuY=;
 b=DAUhxIPkK3/9hkcws8hBsqgc4wtXNDW0/AXZEcRzAvICF9F/M9AO+NM5d2su9bDIj7
 crXZt6uJFrur1q9J+sbHjGzeCSQx1kyKmKQFT4DKl/bndkP1RAb0dKfeuNP9jfq52URR
 OFvgIqNZvAldZmwdxQdpcM0gMMDGImxIzPJ6ywxFWLHLw4XMC6R0acMwj6p+nN1qyJXE
 3AJ/s0tehULA522wdrtUQhVZnabNFJ4IYc+OODPD2hDiGsV+AukcZGTJsFSQ174Zdl4w
 SU7TKMVuHU0ZVMDKNuVmTPTax1c9yEWsXsXe93/6SqShLXn3yn4bTNR1wxhybxq+f87T
 9HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761986224; x=1762591024;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7F8NicqZfMJl5cSldlPUlBXgM988Pj+TePKd7HRrcuY=;
 b=wQttWtAmEZNihpEjcu6aKeol/+FJZkyYnd5MtG5kYtjKgVqs08tczXYVcgkrest+AL
 uRE6Y56T6Pv2LKq7WPYP0LNliMqdLv7M+3fsTtCR3Wv4gqpEd+mIK9yahXGGbfEMXFTh
 /wANGD+ekQFDCrIc16QMF3cUJEQp80BTx+e4jU7rCgdv8fxlXt6qXqsdBs0fctBCQGEV
 2xXfVtKv36rEW99AYwdBQnpTcXyn7OEYbqqcvVebcz5GvM/4YPyCyET7dJvdvmJ3N8Fx
 Yc7lbhsSE0D+t1rMj3DrGZP7TaeBdO4n8Q4did6gjyIOwg21XxTm142b1HlXX/Ks50k6
 KiMg==
X-Gm-Message-State: AOJu0YxLY3hkR+RGLpufy6d71qJrYaep6HZZCHn8FjguYre6vgVBS5jd
 K0kke9iOXVcycmGW1IQQDoRtr2NOL6gVDhZrBgEMXtUAGxD9qJC9S4GIFAull6LRDz3VYrENQpC
 oTHqdCwI=
X-Gm-Gg: ASbGncsCy0WM0u28fygkF5HYjCfLlIEF5CmU2ojYrzPnHXZmCiYOYk8ezB0MraLYFwB
 YdZccsVRphZc36du7dezpcl+nnMG9yK9iY/eRtklBco2ng0zi61li2fgXxInT0iVuzoFeE46icO
 kqoTToavmdj5ytthVa9syO0BlgKXPIH12BaTrOpFd9ve1lAmhBL1qIOGvehXDmCTPwsK5jCbBqw
 5cBh22zGmFCFzmAuelNj2dTymCMlQvTDgW75fD/L0PFiz05PPCl+2/s4AcIjkmrhyipF8IDbyV5
 cfF6zvx5rWRbqil6agQTRH7pldFjYya9gymhHrEVIfeJ58j88UEvEZ/Fl9vVwDZXNgQnFMJDS/2
 HGWJp8w7FypETCVMW+67liJVNJgWCgOt+5Kcw9lpn5YgxcKcfWbEMRsAHG3kEZj7QIb7k82PtB2
 TaIXc2aZk5cVtOl0ilzAZLwUbEUBRisS+2uR9+marYEl7/tYbuqQuAEdf8iZvb3Q==
X-Google-Smtp-Source: AGHT+IH+MCMKX7/j2SOCDK0xk5EmPML3kqqjKVV54S2g3RalIiuBBhxIKY0jY3BnDTx6FWk5JLdkQA==
X-Received: by 2002:a17:907:94c7:b0:b6c:8e24:21f with SMTP id
 a640c23a62f3a-b7070844391mr592059466b.55.1761986224232; 
 Sat, 01 Nov 2025 01:37:04 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c3ea35sm391719966b.34.2025.11.01.01.37.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 01:37:03 -0700 (PDT)
Message-ID: <4ad5c914-1f02-4270-8eac-3e4e0baa620f@linaro.org>
Date: Sat, 1 Nov 2025 09:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/23] Misc single binary patches for 2025-10-29
To: qemu-devel@nongnu.org
References: <20251030135139.20433-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030135139.20433-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 10/30/25 14:51, Philippe Mathieu-Daudé wrote:
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/single-binary-20251030
> 
> for you to fetch changes up to dfbf7775403db6fdd3e298bf7664b6149d7d6f77:
> 
>    hw/riscv: Replace target_ulong uses (2025-10-30 14:48:26 +0100)
> 
> ----------------------------------------------------------------
> Various patches related to single binary work:
> 
> - Make hw/arm/ common by adding a QOM type to machines to
>    tag in which binary (32 or 64-bit) they can be used.
>    Convert the Virt and SBSA-Ref machines.
> - Build Xen files once


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

