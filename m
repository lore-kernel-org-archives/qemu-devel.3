Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA935C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpejF-0006fS-M3; Tue, 04 Mar 2025 21:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpejD-0006eF-Nu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:43:23 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpejB-0005Np-CC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:43:22 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22382657540so73060455ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 18:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741142599; x=1741747399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUEuJdK4JXBGfbHkdk6cCjwrE9S0Iadxua/QAQa0NKQ=;
 b=zKzvCcGEJ30CizKyQ1xyoD0QZB0IJiAxcSQ+yRWO4D89RJt0wteWEkrioIpm715+bO
 UFQh5OnwLU6UAYDwSoyikTkDzoZjNdh4bM19UW8XhOCIeOA4O1f/ta63D2MADCUueWbT
 OS7f2OtKuc0x9UhLXwWKGcoTTqF57ZcaMkmkPT3mYbPQ513vekHtwQ+Fp9UjIQEO7S5F
 oD6xiIScdk/WOfIXAZP5m0iWcpqGvsueN/0EiakkEy93yoCfc79yDDfp+Yuqz8PZMmim
 8XMZvQG7IYy9UGWHK9fXLRXQVKA0pF2q1zHg55fTGxyqpDYCUoRyg7NmqBszaX4WcSPJ
 WICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741142599; x=1741747399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUEuJdK4JXBGfbHkdk6cCjwrE9S0Iadxua/QAQa0NKQ=;
 b=ADCuM90x65UTq3tEGrUcpYJ77Ckb2RnnH4sVZ5koqNMi4CnlKqAaDKBhrXsj2Kmb4/
 E7Jg6uCWvDdqYXVE2Mi4vhODIEgnHeCZJw09SVTmWyO05hL/hLdPLRJPe/eCa2ZS1aGs
 tOrjkonQkY6Ae7cz4VZWAPGvt4XNdLvMwLv6hiBCaG497Torx46Es5/w6/x3nBGiZbB3
 ve6yzWyzX/9qyrEHSAfqxPkQLhsoBcKb7MZfGwr5qOEXHxHtQP9A9h4QAFPLrI0V/29L
 9yGmCWsf/VfIQYydTnGv+i3JmwFRRsNq/QFIEdDvQgWDUzqkPnUHFaJcIGXjoBC/ttLd
 1XrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8+gaFl5CT+vs18vaJukIekpjRVZrmBem6Tjq6v+tqfT7x8UkfpGC75rNMOSFf7yQX/frl5i2ayIbp@nongnu.org
X-Gm-Message-State: AOJu0Yw37roT85hcfBsAHJNUBgP1Ha3+6OVpxEOeepIYTXx2fXT3YFMX
 wOnOqJ0625x/UEl7cWMv6J7kIxn8EDGXmltwlI7jAE2GY85qY+9YepdJYk+nV2g=
X-Gm-Gg: ASbGncuLYAPljKx2TORB456R1GiwTVV59z3a+7znjvQ/RW3V+f4728fC1e64g0w4rcY
 2d0rKE3eZOwESQ90b2GXBZw56K5CoIauZ06U4UF7ClLyTiTpRabbEPTXNMtpb4OmJoOICub3V0b
 tdjjUqRGxLZcgjpG3cfPkG+B5mRsgnZCYdB1F8W8xSyxSv6NwTpjzMOeERHk8QgJQrnJqKa+J85
 15z8cCPTLZssO1pmrzGp3ZqnqnSLjxU4tDH835lOo9JpfL/OwiANrrxkkTz6JxbNOBOwSNP7ZHT
 jVGTt27LomQxqNCnw1Rif919kkHFGnuYmlTnuwLGFHwel/K8n21SlToSmepdkXV+Cfp8xsq5Pd5
 MjIrTcSXF
X-Google-Smtp-Source: AGHT+IFIPU3+l11NONZRrt9drybQJShkCQrTH7Ja+WQ5q18LnMBnKicW5QAap2ued/x/0eP2RSVxMg==
X-Received: by 2002:a05:6a00:2e92:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-73682b6c1b8mr2233261b3a.3.1741142599365; 
 Tue, 04 Mar 2025 18:43:19 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de3ad9esm9151581a12.39.2025.03.04.18.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 18:43:19 -0800 (PST)
Message-ID: <332b2988-93b2-4811-8626-37fa18cd2444@linaro.org>
Date: Tue, 4 Mar 2025 18:43:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] include: Expose QemuArchBit enum to user
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> QemuArchBit isn't really specific to system emulation,
> move the "system/arch_init.h" header to "qemu/arch_info.h",
> a more generic include path.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   meson.build                                      | 2 +-
>   include/{system/arch_init.h => qemu/arch_info.h} | 4 ++--
>   system/arch_init.c => arch_info-target.c         | 2 +-
>   hw/scsi/scsi-disk.c                              | 2 +-
>   system/qdev-monitor.c                            | 2 +-
>   system/vl.c                                      | 2 +-
>   system/meson.build                               | 1 -
>   7 files changed, 7 insertions(+), 8 deletions(-)
>   rename include/{system/arch_init.h => qemu/arch_info.h} (97%)
>   rename system/arch_init.c => arch_info-target.c (97%)

I can't think of a reason to use QemuArch(Bit) in user-mode.
But I can't really justify splitting the header either.
It's certainly not "init" related anyway.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

