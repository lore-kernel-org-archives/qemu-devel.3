Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0543EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodjN-0000qv-JL; Thu, 12 Sep 2024 02:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodjJ-0000Xe-E1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:55:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodjH-0003Zl-Is
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:55:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so434231f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124098; x=1726728898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jCvXOJb3M0UmkUBLMSdgaYUO7s0+K5lztCSk4YluA/o=;
 b=ifAOaWaonelBdCmsyM0NuOrnSJ5qXY6FJ9hNKMtMmvfab6SRFg9BshuwBJU4aLrkwb
 B703UEKOJGFzSsVe8GJRj7nZeAywDEjTd/gd1aA3yfo3hDvaPkO24TMcym3fXh9A8622
 /u5R+bLPXya20KqEAF32WvXCGBJ0BNwLL2A5cmo0kSnCyq0VQnFbyT9k+tHp5vG/S7nY
 PHN0krrLHU8qw/AoQbaOfDsyxMNc82JjzdLos9WPj27pXVXTG9JyJNWWSFxPL/UxnTja
 XxlxwVHg4c8L1EAp9CTECGbXIhtyojc7WDykK6+Io+v6zaiz0QYkEUYvbXkv5dHVfChL
 ZuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124098; x=1726728898;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCvXOJb3M0UmkUBLMSdgaYUO7s0+K5lztCSk4YluA/o=;
 b=E1rUCOGkbP0VAuSo4GQMSGhiAD1A8+wDZRXTCf6KVBMrypuj6CZG2LGFeEIcdaXE0j
 UKPQM0T+s5g4HDi1MjXKAg3Z9HbZRvtDIsVoagicA51RmNEa2AEo5XQ+n/GfVHTbGiML
 sj2xCVGjYxv4EMDref+XHFtXZUKnykfobaqhYywR7ILfNWHfC7Cq6GJOtfvkUss9al1q
 jqLWTRO5/tDCp8NbRWHeqm+CuzxwNt9BWM7F51B4VmBV4HZwX5Aw+2yqpxOVX41GxRHa
 lC0bVlXBdc1HrNyL/7XOoCIwHPn7BuARG/hkJavM7MlN3R+wr4mPFcnARrLnR0AzcKgG
 nm7Q==
X-Gm-Message-State: AOJu0YzFiiBITFLr0a15rgWtEaUHtXe1JQmmWJmU8G7RvYY/dqpiqeoJ
 pFR6gy1t/d/uLCXyzEUFplqx99P61pD06RS3bacQ7Ss5nmqchsw7zwFH0DlHbfc=
X-Google-Smtp-Source: AGHT+IF25n7Sa6TfJZUDzd53iQPcZpqE+4Xyhb+Rkk3OlRpJDDENF57nMsrRIboWoIlVu8+ZeV6gbQ==
X-Received: by 2002:adf:ebc6:0:b0:377:6073:48df with SMTP id
 ffacd0b85a97d-378c2d5b42emr757111f8f.58.1726124097757; 
 Wed, 11 Sep 2024 23:54:57 -0700 (PDT)
Received: from [192.168.69.100] (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3796sm13419498f8f.80.2024.09.11.23.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 23:54:57 -0700 (PDT)
Message-ID: <d832e49f-478b-4b7f-93a4-a3d00d5439fb@linaro.org>
Date: Thu, 12 Sep 2024 08:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/56] Misc HW & UI patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
Content-Language: en-US
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Peter,

On 11/9/24 14:13, Philippe Mathieu-Daudé wrote:
> The following changes since commit a66f28df650166ae8b50c992eea45e7b247f4143:
> 
>    Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-09-10 11:19:22 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20240911
> 
> for you to fetch changes up to d6bda15a00b46778e577c95c77f066f95ed58e07:
> 
>    ui: remove break after g_assert_not_reached() (2024-09-11 13:54:06 +0200)
> 
> ----------------------------------------------------------------
> Misc HW & UI patches
> 
> - Remove deprecated SH4 SHIX machine TC58128 NAND EEPROM (Phil)
> - Remove deprecated CRIS target (Phil)
> - Remove deprecated RISC-V 'any' CPU type (Phil)
> - Add fifo8_peek_buf() to correctly handle FIFO wraparound (Mark)
> - Minor cleanups in Designware PCIe, PL011 and loongson IPI models (Phil)
> - Convert Sun ESCC and ADB mouses to QemuInputHandler (Mark)
> - Prevent heap overflow in VIRTIO sound device (Volker)
> - Cleanups around g_assert_not_reached() call (Pierrick)
> - Add Clément as VT-d reviewer (Clément)
> - Prevent stuck modifier keys and unexpected text input on Windows (Volker)
> - Explicitly set SDL2 swap interval when OpenGL is enabled (Gert)
> 
> ----------------------------------------------------------------

FYI I posted a v2 updating Pierrick's commit descriptions:
https://lore.kernel.org/qemu-devel/20240912065227.67848-1-philmd@linaro.org/

Regards,

Phil.

