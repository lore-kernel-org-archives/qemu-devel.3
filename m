Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298DEC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlnu-0000ls-MW; Sun, 16 Feb 2025 16:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlnf-0000RX-9R
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:03:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlnb-00080r-MV
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:03:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43961c966a8so23151215e9.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739813; x=1740344613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IeocgUDFSCXeJ49cGzVV1VW02kSLwEXMPC8k31YONFc=;
 b=EC9HlprgHYmlu8k4TvLh/IUKV51mcy/oNsFfJJ6QYcWnZxhIBHE03NAqgTHzNO7hCm
 r8hNMUD88qdye2IyRSFA9u+Xjv5/hUJRhd5sUcYIDTP8nUMtlp21HYDxkqjl39G6vRqx
 e+dHNhkH/6en6J7A/e7JTqvzfkblbJZ5FNVyobsOI/6Eu5yDxtSTuApJDhPp1JocSTDl
 lojOBvXrzr4ks1soWFADCX93cAuGaLufInnUSvbvsbVgtbmjxXN0awARRNWALZ2/TLZK
 NB6G2xmYtEz+NkoyPA13KGQ9pEI/10q/VS90BoDk3VhNM7fZGxk0Wh2SCKElS0Re78wV
 smBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739813; x=1740344613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IeocgUDFSCXeJ49cGzVV1VW02kSLwEXMPC8k31YONFc=;
 b=Fco2mv/fjkGF64EFpzk/PYs+xc98DD0SKO0g+YMWMYMUxThLd5MQIoibPuA+0ubGzb
 rJ/H+Hyk6QmHvdp8qc7nd0sX76N1bS8Iw3259E/BhDgIDuA498nUp4AXYV1s+DFhv47k
 tTsT9DxEJZbFknUR0IvAUP34IB8V83TVn7JOZCF5km5jqh/kBbE5fieddB3k1x/7WUwc
 WBelbo/391mc13DZsSuywsPfTlOG5JYz41or9/VXCxlFDRgivjD4I+jJ8hmaxFtZntfm
 N5kA2Ozp7X3+GsurITK38UD6V3hdYIPO2m4utZU9AjSZTZ9sYavV/6ExzNKebfoUdZcc
 r2eA==
X-Gm-Message-State: AOJu0YzkKi5g21qCYsIiPLYabBmrAvWvMUZfjYjwAkZdGYfwXIutUF6R
 olbmdLSCfds0hE/SScSfhmK7wis+ArS1IEStoZ9+OMQHkxIPwmhXUc9eNth8MF/NDre8eNKfZWL
 GTZI=
X-Gm-Gg: ASbGncuv0hXI2+sRdofWp1/Xqri2sNbkmMiV2lXNwo0AdBWTuwwq1PsdUainTMlR7Fw
 vSz3PDpb/wpo4Ekqkg2yYyY5Vk0rmbT4zahTkvfkjhYISGKuK6xAjn70LCXCc0nja24+CZyPYZ+
 0CgbVR3AKnfcrwroDdZ1zYREzQPU0lzFskOn0TkQLUO+npRqnOQZRc/dWaWr4l1DMRPrCibhR8u
 zWICeIlC+Z9jbG3l+7IzN1JP6JhKa4SVCrRL0dmAMeNZCeEL/qcn5b7uWH4Gj0N20eyW2J7A970
 77HZMjfa/AWRGsiyR0/KNhwV4eJP0FCbbgcl4tBy1Wt6rfudVqYLmhRW2fLatU7Y
X-Google-Smtp-Source: AGHT+IGbYs+gAtvvAcLvlJPn9GibLR08+8vmDELjdWpQbq1Q5Chngzn2QsHQSaz/UvD0DsQhtJV42w==
X-Received: by 2002:a05:600c:46cf:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-4396e6b4cb1mr66810445e9.8.1739739813127; 
 Sun, 16 Feb 2025 13:03:33 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06e309sm134006185e9.24.2025.02.16.13.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 13:03:31 -0800 (PST)
Message-ID: <cd6878c1-805e-47ce-a659-64b6bb51c0e2@linaro.org>
Date: Sun, 16 Feb 2025 22:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw: More DEVICE_ [NATIVE -> LITTLE] _ENDIAN
 conversions
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-arm@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20250212113938.38692-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212113938.38692-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/2/25 12:39, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    hw/arm: Mark Allwinner Technology devices as little-endian
>    hw/mips: Mark Boston machine devices as little-endian
>    hw/mips: Mark Loonson3 Virt machine devices as little-endian
>    hw/pci-host: Mark versatile regions as little-endian

Series queued, thanks.

