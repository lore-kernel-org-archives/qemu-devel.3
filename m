Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CB2C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 06:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZkzl-0003ux-FS; Thu, 10 Jul 2025 02:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZkzZ-0003t0-I6
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 02:42:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZkzW-0003vV-71
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 02:42:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so373533f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 23:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752129762; x=1752734562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XfwlktBF2xTGDVAo0FUUWvgXS/vYnmeKx3ohXP3wJwo=;
 b=SYjh5uwIvScg+xfoem0Gf1P8N+OOGS3Z6ITB5RgkTbUCJm4h4EGd6rp9Aj/rfHFj6p
 gc0js9i0a5/u8QgNT5yHckkaT6yHpHJgCxmQZdGuNR56H3LFDXeldI6PEHx1ugCBKIPs
 EdSUcocbOP2Cvznyow5sqlrQshHnX54b3uclMaertRM8lIyiDK+g+bgThdX1sIRiPnoM
 rdRJ5E9/Qnlw3xKvDYPOsaQJ3dFdnOYHxAlR1tcbENMn2Rndqp/dLsTcLCYIYYkFGvJP
 nSmp3AvBQ4vAFf0xvoCJ8bzt9s51PWE5Mp5/FuZZ4siXlFnY1O+nlOGGMB4CEhsaEEvM
 CCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752129762; x=1752734562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfwlktBF2xTGDVAo0FUUWvgXS/vYnmeKx3ohXP3wJwo=;
 b=M2W+C4uj4NzweUsOyGjBND/B+xRuhTCCEEqQe2guX6sYVYW3djiaJVFliYXHDRyP3A
 YITr8dzj4cgatlziqskZJZLA9rWWtyfDipRTK7cc7TAQGMQ/W+RjXyt563yFikF0Fm3m
 fMl6mv3fDKqqKSeUsRXXqPCl1Nds4xVNfz+EdfNeZ8wtF4Pvji5qnYQC54qO0xpEs2a3
 ZQcVzmmykCTFTJ2D74SOtrwcRckWV5tjewlMGnBqjJJJblgovxYcHCiCdFi93tgxreCu
 0ebpT8kBOCkNwYRxoJC6DD6ka9L6sE6NuQfwO6KWFm19LzGD4t/BS4SIePZpbMB9Za09
 WlLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC59YIjd+fJdh/BuDJ8x36s6kol8iTj8FTD1N3iWywkwTABV/5sdYu9p+PXXiN4G3kmwd9D67GiSIv@nongnu.org
X-Gm-Message-State: AOJu0YxeBzWCOtHEZpuukLcSvVhaNEDfoVZLu0zgUHQoUQnCSk1sU3qs
 O6GDaZTUoYPDGMWI5wa623ZhBrEdj+CRCdsUmWuxvdLDYUVug1JX3pRnIc24y09vUTI=
X-Gm-Gg: ASbGncuAtgGfx028B/K7aXrrmlSeYYyIuMBB1Rmz4QJKINDtv+4k8hCYkN5n5BLNz+v
 YAneu+RuUqn9JJXFV4jxssI+1xF1AwuvUXKqDzU3IMQCcgHG+wAAYYjj5b2fKXq74UbLrIPgQXj
 uedB8TL8bB9AvOR/aNE0NXyhBThY4PvIF7EHtpR8pQte4+7rI90JgZOwIqqPkzE3wBonO8MKcVh
 9S8853sTr23aTl4SncGZB0pGEqdlfuojSr3CIqKfb4nhY0HmjGAaIf7MWX53YqhUZC9kvvKpRE2
 FNX9sU5kg39h5Vi/c7cyoB91uUmxWuFazyBiDxjyyrlYKVVyR64d1MyB7ipujFkCWu7DkYJDM+6
 dlkwlAowoDkLCmjxu5cA34xcjSgb6O3/mV9vPenvdSw==
X-Google-Smtp-Source: AGHT+IECdlLmr952QponGcn8taiIeV1MDLZLQIv8E10ctGSf4hV2YDAcPLECYyRT6HZ6UQZU1NqMXg==
X-Received: by 2002:a05:6000:23c7:b0:3b4:9721:2b32 with SMTP id
 ffacd0b85a97d-3b5e866c90emr934435f8f.10.1752129761753; 
 Wed, 09 Jul 2025 23:42:41 -0700 (PDT)
Received: from [10.132.103.213] (150.red-88-28-29.dynamicip.rima-tde.net.
 [88.28.29.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd464011sm9610025e9.10.2025.07.09.23.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 23:42:41 -0700 (PDT)
Message-ID: <8324270e-8de2-4012-99a1-af879acdb71f@linaro.org>
Date: Thu, 10 Jul 2025 08:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/mips/o32: Drop sa_restorer functionality
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>, Willy Tarreau <w@1wt.eu>
References: <20250709-mips-sa-restorer-v1-1-fc17120e4afe@t-8ch.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250709-mips-sa-restorer-v1-1-fc17120e4afe@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 9/7/25 22:57, Thomas Weißschuh wrote:
> The Linux kernel dropped support for sa_restorer on O32 MIPS in the
> release 2.5.48 because it was unused. See the comment in
> arch/mips/include/uapi/asm/signal.h.
> 
> Applications using the kernels UAPI headers will not reserve enough
> space for qemu-user to copy the sigaction.sa_restorer field to.
> Unrelated data may be overwritten.
> 
> Align qemu-user with the kernel by also dropping sa_restorer support.
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   linux-user/mips/target_signal.h | 1 -
>   linux-user/syscall_defs.h       | 4 ----
>   2 files changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


