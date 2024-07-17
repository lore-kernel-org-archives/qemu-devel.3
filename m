Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F35C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxQU-0001Fi-0B; Wed, 17 Jul 2024 01:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxQP-0001F5-3R
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:42:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxQM-0006yb-Pq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:42:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc4fcbb131so1471805ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721194917; x=1721799717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4t1irZa0ILJmmArTSl3A6BefMGlrRXmzzXKJoYigLaQ=;
 b=CB/ryyvNk0hG8scdXC4BDG3fJvNIdkImm7y0UFSv1qoGV6MjEMIuOaXeVwhC/x3FHF
 QOY1WJHKIdsKH78vdKj6Gvx1Mg0PvZykWBr98GLun8BkPCY1iLEkvAByOjSN2RRg9IAP
 51RAuuZOvdO76MyzqqmD2QlqNuuDjBee0wcqf5kRSOBIwQq4na4tlJTYFCePnX+Tj9tP
 TZebywYjLfaAvwnUpOi4SXq1WNkay2W7Av3QE6LKFUxSlJE8kcYErXcwUeyPZcdJ7del
 0twKtxwwW9wrR+/tQp78986949vaKx9TBqOSIiiSk9l2qjdDu9sX6NhyD8dN/2nWXU0q
 JKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721194917; x=1721799717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4t1irZa0ILJmmArTSl3A6BefMGlrRXmzzXKJoYigLaQ=;
 b=P7lyjsYdzdDd7b36GklVkzdBPY/sZB/RxYp8xba8sA8Oa9liPtMhiK/qdx75DYl10N
 kI6Ybg4nRMWt2fmH7OIFtzfVWYsd6FUhIMgZG0+wZgg25QoJgJYbkklcZ5FMnYgeZ6Io
 JarcmjJqEG9kNzm7W6DSGQNxCcJauqz35e9t1I/Q37ikBRAkcAvGjuVlKak2P+TuhzTS
 mx5wY3rq/yQAKYhdg6rnaoIs1ik1bHFE48olArVexklhVx3syif/fSh0eDadVdLcUARo
 /Kqiye7g4d/8QVic5YDTQ/sgo4pDobNgKf+p/oHy+Fux4THeopjwvBEYyj/UCPwVjG3k
 lUkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIGhGHSXsTduGBdpfAZ2uVTStv8JXGasSeVhpjz1SdQGWHpadGxlycRc92fDnhAQe4Dl7RlgyRHYE8Y6xV5tN5ewkqJvc=
X-Gm-Message-State: AOJu0YyhpRODA4jSEnnwlFDuAZLOem1YCHB/ImclG/uHkGels7thVSHG
 XxoLfRGKMtpH+K2hEHEQvvPja13ouNsgDABldbgcijKtB1BAgrg6ro/+GpgIC1M=
X-Google-Smtp-Source: AGHT+IGZWcnBLkQxsv8J6/t3VHYsY5wxlhb00O16Vlf4ch0Gb/SdnHqnQuPHlkrfe8hRHO9JQ3i+7g==
X-Received: by 2002:a17:902:e552:b0:1fb:8e98:4452 with SMTP id
 d9443c01a7336-1fc4e1692ffmr5028795ad.15.1721194916906; 
 Tue, 16 Jul 2024 22:41:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc285c5sm67614825ad.132.2024.07.16.22.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 22:41:55 -0700 (PDT)
Message-ID: <86262cff-3518-447c-9553-3f213ff74637@linaro.org>
Date: Wed, 17 Jul 2024 15:41:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] Misc HW/UI patches for 2024-07-16
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240716180941.40211-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 7/17/24 04:09, Philippe Mathieu-Daudé wrote:
> The following changes since commit 959269e910944c03bc13f300d65bf08b060d5d0f:
> 
>    Merge tag 'python-pull-request' ofhttps://gitlab.com/jsnow/qemu into staging (2024-07-16 06:45:23 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20240716
> 
> for you to fetch changes up to 644a52778a90581dbda909f38b9eaf71501fd9cd:
> 
>    system/physmem: use return value of ram_block_discard_require() as errno (2024-07-16 20:04:08 +0200)
> 
> Ignored checkpatch error:
> 
>    WARNING: line over 80 characters
>    #30: FILE: system/vl.c:1004:
>    +    if (!ti->class_names[0] || module_object_class_by_name(ti->class_names[0])) {
> 
> Ignored CI failures:
> 
>   - bios-tables-test on cross-i686-tci
>   - qtest-sparc on msys2-64bit
> 
> ----------------------------------------------------------------
> Misc HW & UI patches queue
> 
> - Allow loading safely ROMs larger than 4GiB (Gregor)
> - Convert vt82c686 IRQ as named 'intr' (Bernhard)
> - Clarify QDev GPIO API (Peter)
> - Drop unused load_image_gzipped function (Ani)
> - MakeTCGCPUOps::cpu_exec_interrupt handler mandatory (Peter)
> - Factor cpu_pause() out (Nicholas)
> - Remove transfer size check from ESP DMA DATA IN / OUT transfers (Mark)
> - Add accelerated cursor composition to Cocoa UI (Akihiko)
> - Fix '-vga help' CLI (Marc-André)
> - Fix displayed errno in ram_block_add (Zhenzhong)

Applied, thanks.

r~

