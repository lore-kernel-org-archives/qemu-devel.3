Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5AAD68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByR5-0002NT-Jx; Fri, 15 Nov 2024 10:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tByR1-0002MS-5k
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:36 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tByQy-0000Cf-Fn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:34 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cf92052dccso1002095a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685227; x=1732290027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mDbxKG9heg1SePpfiLMdDpajFYeoy59bRJBORPtyr20=;
 b=TroWIH7CiJznri6ynEwzLGVquCxV0V+sAKD5omNGZQMD/5J3guiULyprOpSJc4TZ+U
 V4VQLRqRa5R3dNF8jPl/C5/SZOSkboqldqAOoZwb/YUq132VrMn7xPyf9SKBvGtCBDhd
 uj9xHHtucGXQKppUAojgCSqkVUWGUoVxlX9ZZjglLs84PSQzDIMjUzfYYmwVsV8aKyAX
 4DJ5JqgIaaphFAVskGWjLA20b5eM/bJml+uhDrmsLSdRYTU3B707gUc3t/2MwgTNW4Rk
 vX3/HsXsGxDVKYUdbEryjwKJ2Dfbp8sfWMT8QMlP8jREsjWn6i7/1DEjD0jx3UhOCebe
 CZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685227; x=1732290027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDbxKG9heg1SePpfiLMdDpajFYeoy59bRJBORPtyr20=;
 b=ZhXqspjv57evZ/1a4tm1JURXPFu3O1EraW/3488rsIlERXRokuPBRYsbIHpi8xNTOz
 HlKF2BJs0YaMfOaG4DBIcd+RUPqmSw+aKPlaPUv6+VZYvJMTPXmJNOXz+GPTDXlBphUS
 xEMygpHHRp2YIwy5Guo6+VQkJ/zU/Lpibk/IrTm6Hc3H8u4miXbaGscrV04+jY8vT47p
 JFEHslxUBJOsa3Ebj+cw/7bS3W+QTY9UXyD5Wgs0Uyhhh1bKzTRfiH1g5W+7MkqD9KDU
 qMVoiqRzSOCX5SEdEh0hbzm9ARM4XVk+jHi0vCD+OE8hLfpwsMhA1cBj7MbUVvGXgwQc
 Ku8g==
X-Gm-Message-State: AOJu0YwcjwOE0q6tcWIzVFYnWn+XN1KX2yPC3SMIsjZQ42XpbtSPfM5S
 Hn0qP5gGzx8hrOTcoycx/p/MIZoNxH2FIFz8LTKqxFjblWmYGUmgilVBUq9hDSXgTd4M3LbzUxL
 Q
X-Google-Smtp-Source: AGHT+IENVFrbT/hNLS+37mAoRPm8H7YwxWugOhtFDF6IrFLLiWZPvPM3/ah7LlIu1tar12sm+d8qeQ==
X-Received: by 2002:a05:6402:84f:b0:5cf:66d2:103b with SMTP id
 4fb4d7f45d1cf-5cf8fd3f6f6mr2382158a12.30.1731685227072; 
 Fri, 15 Nov 2024 07:40:27 -0800 (PST)
Received: from [192.168.69.174] ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79b9e718sm1735967a12.25.2024.11.15.07.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 07:40:26 -0800 (PST)
Message-ID: <fe0ddeab-321a-4873-a232-e86d47f8fe6e@linaro.org>
Date: Fri, 15 Nov 2024 16:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] target/mips: Convert nanoMIPS LSA opcode to
 decodetree
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241112172022.88348-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112172022.88348-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 12/11/24 17:20, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):
>    target/mips: Introduce decode tree bindings for microMIPS ISA
>    target/mips: Introduce decode tree bindings for nanoMIPS ISA
>    target/mips: Have gen_[d]lsa() callers add 1 to shift amount argument
>    target/mips: Decode LSA shift amount using decodetree function
>    target/mips: Convert microMIPS LSA opcode to decodetree
>    target/mips: Convert nanoMIPS LSA opcode to decodetree
Thanks, series queued to mips-next tree.

