Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BDFCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrjQ-0002W8-Km; Mon, 03 Nov 2025 05:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrjM-0002VI-O7
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:24:09 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrjC-0004rI-Oy
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:24:08 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c19b5de4so2246067f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165434; x=1762770234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Rs1loIowige+ByKyM7eBpM0czRwX2BCXXvqEDgccqY=;
 b=iL6vV+CNdKDZiVumvffm8UBOLCyGt67exF4VsLI5yBD9oOr6rmdIyVGe9zEMCO+joC
 HVCSMkAcUxh9Qcz1rJhAt2fehMwppTn/TMS8dDNdz4G26A+MdTr8yM4z1w01hKJ8EQMm
 iP8YT3H6+0GG0nsEk2oV6KjOGol3Ki9H7pGgKY2YjUctz10m8059lNfn4qXPBwtM3yab
 IXTxckwZQe+sfBnOP3R7lr59wlIruWtE2duZv78dFL2zcLOn/MaeObldYFF7WlAzdqsL
 vm2z1fh8lDiDmzf25j1yb7ATY2Enk0KJD9x9C0TimjW8ODBWx7oT3jgZUNt+V4752A6O
 P3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165434; x=1762770234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Rs1loIowige+ByKyM7eBpM0czRwX2BCXXvqEDgccqY=;
 b=VUwpJqEnMujlHbr2ibVjQ2l+rY7QzhNKielTDLumPMKhjjDzp9eG59Z0tu1HhJ5N34
 yJ4j7bjmssEbZjnzz1qF1XK2qnMq9H0ccH0qAahtmP2JkoZ7UOXKUItKb14c8GW12RE2
 wiMEutd1XKiCA4/9W2T7GiTHT14VAY19nSqvzu/ZmuPtI8R0MDUGzdwhgdQgGkf3BcU2
 6Obd+Tueac4MHzlwdkEVXWvuIUKrEbRWWs/ixJUxckN62rCkzd48R16j7r8IJAU8xaTF
 zk7JZZ6HAlnzfuAwRhvFjTNpGG+GZDtW0ubB2M4Cfx3J7CmoFsKR5xYI+Feak8uDBfg1
 I11g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS3SPEto1RMWR9nFAFs39I6WbW9m1tSwdzqHhKt5M1jEPIp3SMS7+KrU3YLd2Ygsef0voVFpCyHsrr@nongnu.org
X-Gm-Message-State: AOJu0YyXyKeMfK8ulyu1jwvHAlN0XCUpyEzKVsNVc9cXj6REYyqoDtKp
 CnpCtGcsuoAzNFS0LSjASax+24yHdTdFJWdRszAaensxlOfyH4A3xAeZm+jqQuHXoW8=
X-Gm-Gg: ASbGncsIhuvEJ19bWakNhPrvBoKfBwj6X/LLA3ixi4Ptm7gtZaTsdxyTvjeavsuiRFg
 3nYD/KVvC7GJ1f/hGCd1CVqJbajW/PaRenZXZ30JNYU1WY1l6PypbsBHPqUTVQRwAaDibFB8Ek3
 GfFf5HsAL9eXOyn5wK3Qf3Jk2dFeMzGrz3heQlhwUP8JlsVqfxWvR8tOpdBT+etjdM1gkUFRAZe
 zQSZ/B1NrxcbOqWqt7P6Hn6TKURDrqUrKws04aCfVzNtbUC6xrj792ruJfId+mZL93qkNFvIblg
 3P2A+LKVAW4gPEO0QnDDdapUKmq3l7ANAALZhMsEQErlzKXPCnOt4RhF9qHI4DvoNc+7bx7uc7C
 qf2L1N3YMQUHZuHj/D6XvUVR/PtIrT6ioKmush1/qAk5iatJ4o9l0SO9lyS5LS89Vt3ZBX3+0HM
 oZRz/CbWuGHkcWJMvkcJb14CoD+m2zGX+ICayhCA0cpB/StA2MN0hDONfoXUHHrg==
X-Google-Smtp-Source: AGHT+IF/WhahqqjQpW5bPzmu9S/E+qtRGStZYEwgFGzo321XsrlpcUFet0JFG3ETWPyKonrdy1F2YQ==
X-Received: by 2002:a05:6000:3105:b0:429:d4c2:cae1 with SMTP id
 ffacd0b85a97d-429d4c2ce42mr1540093f8f.63.1762165434360; 
 Mon, 03 Nov 2025 02:23:54 -0800 (PST)
Received: from [172.18.178.65] (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c5e19103sm16429099f8f.28.2025.11.03.02.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:23:53 -0800 (PST)
Message-ID: <4e02d77d-28d5-49a1-a7e6-46888882b339@linaro.org>
Date: Mon, 3 Nov 2025 11:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/riscv: Remove upper_half from
 riscv_pmu_ctr_get_fixed_counters_val
Content-Language: en-US
To: alistair23@gmail.com, qemu-devel@nongnu.org, anjo@rev.ng,
 palmer@dabbelt.com, dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
 <20251103033713.904455-9-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251103033713.904455-9-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/11/25 04:37, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Now that mhpmcounter is always a 64-bit value we can remove the
> upper_half argument from riscv_pmu_ctr_get_fixed_counters_val() and
> always return a 64-bit value.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/csr.c | 40 +++++++++-------------------------------
>   1 file changed, 9 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


