Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025B1D609D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfh1-0008Pb-Ev; Tue, 16 Dec 2025 19:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfgx-0008OZ-PI
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:46:59 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfgw-0001gH-88
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:46:59 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso39322675ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932417; x=1766537217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MZcJyI8Vk/wJcwv/qnKe5EJkzJAcXcDBn7htb0LJzoM=;
 b=Lnim5+NwrEIm6GZZLuaxPAd42+H86glZRndMZ41ofKgFZsZPSIL8D3N2y50nDPbDmN
 xZuLShJfrm5cIYNAcv+rLTYjVppTmopYhSbUDXPmE7Qb8aZmBBlAVXmah9fZSUsLpTu1
 +fS3h4fE4rNfSsSB7pV6WL9Hn9Oy3NfPETAYZiR97Sfuulo+nW7KtX7HAPhjbi6nKCgq
 2uscUiZZ4NrlUUld7VT0Cwze3/w+VLypnIrJKxOZqjNezsKrOAQyUF7JknyqQBJZcjbw
 FdRg+WzdmojIUtjrOX6pIbWESwpC6JMF5QY7VRd1Vqm1dsadjmAtHigKZgfkoUB0Fw+G
 EuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932417; x=1766537217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MZcJyI8Vk/wJcwv/qnKe5EJkzJAcXcDBn7htb0LJzoM=;
 b=gm7zjMUduRm7AuLgKMfRQrM2dTwqlSyqAK6RVLUtSNWexDzTen+jxtU3IBKeQfJ6rX
 aN5jcNjkxObVU/qOJOMUksmvnFka/d2mVmj0NhUCwU+L57FQlDWgQ10HeVB/MD+oxRk7
 adEcJJtZM1HtssTk/FvJswF0lRfJ+hCDqlX9zZPlZqIC3siQxVaLsNW4G0Iy3UuhE65O
 okR5UDAKGZ+wCZdTTxKIyrD6DnaHc2FRGv5kuDjzQVhv7JavPDGLIYTxhNflOqBrWUsd
 S2WugawIHdlU7QA61kxMqKnAU4mewftAUSS5tG8gMC0UI3A01/FzvF95jya05r/LW3HZ
 eVVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnIzCHnb022HqDzTd8kF9eEWC81IZu6CrccbPXLDScCok7bO39VZ1nre1IZgdM8O4HIX3iKcOw8xH1@nongnu.org
X-Gm-Message-State: AOJu0Yz+VB4Z/4Ud1ynGtOCnSdErfJ7AW2pOB/XlY1LUaq1Xzmo25iU7
 0ef/y2Zt1yQBwixi4oZBAZyhcphT+K5wcgRCLh7C9jDHShmHfie/Imi6ka1DRKb7/xM=
X-Gm-Gg: AY/fxX72S1hAAuLUzi8aP4Y1sJiX7ad7wJbkz6xsPFAShlO6gRBlZFhSa+r4lE1Tg/b
 Ol7O858HNeZQz/AIm89Op1AM/LaEBrwwZv/fc6+JHBiz2IZ22Blz0Hhz9GRbI54taiJrcETHX3w
 rZRUkX5imGM6ziS5NzaW0mtYLd75qRKpj/6BFDY/ZflfXXvn5V/P0yM1oQQlq76KHO/PPE+VTyD
 MJHJZnsupXzUhgPhy0PsleSN/4KUFaZH9+MzACh+DsKDoOkwQ+Gcy+wUC0JS5rlQTRNz+jmwSk6
 6vmtiiHtmcpPbuPw+VSE9qJsV2fHQuJdOSpQGuKEjYQV9IY093WhoyDoJ/CA/W2IGnegEbeS6v8
 KYS+hWbnpLxvHuDa/afk2N97R0yNK9Gje/zrt6JHbQwR9sVkkH9/UX+iBQValFMlO7IWkzmsd95
 pO/PGQfrIe7fzrtYIJDUVZdPErUXOcDINZd44DPTLKdbuCD7J3oXoAaxz0L6aZNT77pg==
X-Google-Smtp-Source: AGHT+IHbu9oNIZ3FgIsEABanASlqsMU4ko34EulNPvT39FAHZo017ANQNkKYCmfeOlTSGjdgRYau4A==
X-Received: by 2002:a17:902:cf0a:b0:2a0:9d0f:b1ed with SMTP id
 d9443c01a7336-2a09d0fb39dmr108328085ad.24.1765932416709; 
 Tue, 16 Dec 2025 16:46:56 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29ee9d50f9fsm175072995ad.44.2025.12.16.16.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:46:56 -0800 (PST)
Message-ID: <30e9201e-28e4-4ab3-bea3-a43870bdb106@linaro.org>
Date: Tue, 16 Dec 2025 16:46:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/riscv: Stub out kvm functions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-12-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-12-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Functions used externally by hw/riscv are stubbed out for non-kvm
> configurations, allowing a single compilation of hw/riscv.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
>   target/riscv/kvm/meson.build |  1 +
>   2 files changed, 24 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


