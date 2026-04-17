Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A1F43697
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDi6E-0008Eh-Nu; Fri, 17 Apr 2026 08:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDi6D-0008EV-Vg
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:15:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDi6C-0000VP-BM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:15:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488c2690057so6213375e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776428103; x=1777032903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHzyBJIYkM0m+T1utJFmm9KC9vWVVMjXr4jnfo3Grqk=;
 b=kdjqwGHd00SmZR7CYKtKFUwtD3caENZiJmZSQjcFVy+o37gOzJ0tRX8N0fM1z6R1LD
 Y/mn2FySeN3fF0DogeOTf7ys8dCoSLxEV2ybWBX7ENI2SEmD3jUhlsKzuvQOZA14Z11s
 C7BZtcTdLKDFwghNahgfkfB5X7n/Y9sFGB5kkCz4Mt7jR3yuipKB7EbbuGjZKHNeiUkn
 36SCcVw6PaUo3Fsj16Oc06X8HIdlrc3lURW1l7NIfAbswtes0qj+0c7cM1HRPEj6McY/
 WOuJmri0Jeod6iWmhguND7HAwCFCnyW48k5cNVGidjs6dDtj+VAh6K4mC6ETcHDgFQga
 jP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776428103; x=1777032903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHzyBJIYkM0m+T1utJFmm9KC9vWVVMjXr4jnfo3Grqk=;
 b=NDLwRVhHNMEBlRnbMIEnS7gPnmoE1DgTC4vIFqOmtvOGluApsV/LRpAkiBQYQJwIF5
 xOPRY60DTMd0xznxes3pSko+ZiezNzc8CHwl3Yn68uNiT/VhhFX3R81sefGJgE//LaiL
 seurO1plMO6bafKHpwMYhNWEEyCMom+jb1T4udAoM/InKtqOOf8P22oprCfdotblYJY3
 ughyBdmHN0/G1zKPl+UmnC8eaolgYNraLIVpHgcSU3XEWwuizjU1HIZk+1mYOK61l/5H
 +DOtwODYzAw5j6tK+m8hGw3sVtq0YCVY/CR/5M/9HZvlHgjn1WAi/BctKSIU7ePbVfNe
 81Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8duOL4h2e7irp5dP1U6tD3eNJpFqmmEezcryyodcyykdIDvBXxhPGcQLiN56FmJFaF+xtYM+d+bnzQ@nongnu.org
X-Gm-Message-State: AOJu0Yx9Mj/gqjBC0qDNbunH8xJAL2yvMcwvA2Zvc5VwZJQxm1tQ7IOK
 Lw9aX2hCsscBHpWXCInjGy5nUecmfMK4pAgJXF3LD91Q4WbJ1L0t3BMYon4/5Ewg/mg=
X-Gm-Gg: AeBDietSg4FKdVSygrxElouYf1Z6ojN+kc1MCk4quWMNz50Hrrq715J/bN9r7vLyP9o
 Bn+q0QOZVepDFygwRwXmdZXRQYhtC48TGgn88g2TB26pq4qOSoq2sbxvTFUdc5BNFndD0u2o9iA
 t1G9e03ZFOKXuZlXHecrPk/marS/mfzFAwr/fqB1seZn68NJfsODkYpk9fdNGZ6CQ7hqu072auJ
 qUD++OVRKHJ9ij241BA8sGMShngF3dquGzMkuw86mI6QoQOWk3B149Na3L/UZ3UjFaB9vW+NYsp
 bYyaz8wKHI9uG2IWR6pfcJbVNO+wL+jmbmru7TIHxvrXirt3J3Br5GHhuQlfoGAZzDl4IAmPEG8
 LKSxbNaXhgTqbSSw3qhauHCjNQ2L9EUNkXBEhkeLPfOPmMDJPsyQOqcelCKVV1nzNP4RAH4pnik
 RyrIa5NGBw1gZAkFCkCH+uIsLoff/Wew/totO8gpSjYbOZ+V0yA0MZe8i4C6GNgIOwcdQrznCXi
 6TL
X-Received: by 2002:a05:600c:48a3:b0:488:caed:5ccf with SMTP id
 5b1f17b1804b1-488fb8d1865mr18551555e9.16.1776428102473; 
 Fri, 17 Apr 2026 05:15:02 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7ac6aasm15659555e9.25.2026.04.17.05.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 05:15:01 -0700 (PDT)
Message-ID: <93c4ecbf-2a46-437f-bbc6-24faa4170142@linaro.org>
Date: Fri, 17 Apr 2026 14:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] hw/sd: Update trace events for buf+len data
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-7-119e66be10c2@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417-sdcard-performance-b4-v4-7-119e66be10c2@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/4/26 11:51, Christian Speich wrote:
> After switching sdbuf and sdcard over to use buf+len instead of single
> byte operation, the trace events need to be updated.
> 
> This patch updates sdbus_{read,write} and sdcard_write_data to output the
> buffer that is worked on.
> 
> sdcard_read_data is left unchanged, as it did not print the read byte
> before anyways.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/core.c       | 27 +++++++++++++++++++++++++--
>   hw/sd/sd.c         | 19 +++++++++++++++----
>   hw/sd/trace-events |  6 +++---
>   3 files changed, 43 insertions(+), 9 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

