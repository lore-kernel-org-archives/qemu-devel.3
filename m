Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2DBC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafrS-0002Ef-7U; Thu, 15 Feb 2024 12:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafrR-0002ED-4q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:49:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafrP-0007nF-L4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:49:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-411f165ef9bso10200885e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019362; x=1708624162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ikpjb8qdCXTGcFU31iQiImVYctFXP5UVWVfUj7TsGi8=;
 b=HNK4ez5HrYS/4VI2fD74g09Y4lECQ9H8d4I0Ijz/PwZoB2dQ7e/hJ+utNMbE2S/B/D
 O9GzfUPWwwPgDK4rx4UvUJyP8AGNzpmydikqOmzWQFe4vF+vTnBK2uOoPiEiAF7ErK7j
 T7ZFTkjFU2nuEZA/ZaIokjm51FtxyUNPLaMzQDR/Dy7bDjtqklEXiUVcedTnGv42cV2Y
 Xh1G5cZrq2fc0B6VCptltDo3DP768PLPWT2UdAhocd/pfcMwumsJGyEsuY15SWEsLC/D
 y/ZuNxsqoeC7vXPoGaTWKPTc6NQ3rGAjiJrwEArho566IcsQT4U+B0VHjPJ7Tekt3pqi
 Id7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019362; x=1708624162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ikpjb8qdCXTGcFU31iQiImVYctFXP5UVWVfUj7TsGi8=;
 b=U/slF43YFaHEZiSejSEyLfJEl11s2H0gz9nSu/F06P3wtYRWTUCGGLqRSgvduqzPGR
 mxeS11naMrX/PchE/WY4br9GHZH/Rkl9J7HJDnvRDZa7MrWu7rHHF+xadufpTCfREZby
 AOrYRKY0+U8AMELe7ssz64CjyrryUbeu3XyAASYvyek7poHGhXpqGmSdjNhI3PjZBSHu
 qi7D72rTiljFgB1gH7gWxBs8WlGYyvISjM2Oi0ts5Srimx8h7jMdAMBtPNoY8oEQA5ny
 3EGrVBs5EZ+sB3S7YflFO9mbfHG3Uu/yTfON9khwM9qKZ5/iGe7KCB3w0TUCznrzK7MP
 pPlA==
X-Gm-Message-State: AOJu0Yz5cBiX7QI872ZWQkXOIo97gEV78AeZkf82GPx6m8FUkbrdnJns
 9l/aRmKsD+UsxHOi3ZqlmC9Lm8iJCui0Uksi/W4/nBUSGDM9Cd5oeCEBwux0PQySXOFd8C2gVm9
 cLk8=
X-Google-Smtp-Source: AGHT+IEK/3eb8J3dIobCIzILD4tp6FITgkNUOJuk4eXwQhdkuCBAbrxjQ5SStmYGRSxGel/PnSXTbw==
X-Received: by 2002:a05:600c:1553:b0:40e:d30b:6129 with SMTP id
 f19-20020a05600c155300b0040ed30b6129mr1942580wmg.13.1708019361888; 
 Thu, 15 Feb 2024 09:49:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ex7-20020a056000248700b0033b8305ffe2sm2546489wrb.87.2024.02.15.09.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:49:21 -0800 (PST)
Message-ID: <fe12ff45-cc8c-449e-a3af-4e4971bd43c8@linaro.org>
Date: Thu, 15 Feb 2024 18:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/sparc/leon3: Trivial cleanups around
 write_bootloader()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>
References: <20240215132824.67363-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215132824.67363-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 14:28, Philippe Mathieu-Daudé wrote:
> Have write_bootloader() take a void* and remove unused 'env' arg.
> 
> Philippe Mathieu-Daudé (2):
>    hw/sparc/leon3: Remove unused 'env' argument of write_bootloader()
>    hw/sparc/leon3: Have write_bootloader() take a void pointer argument

Series queued.


