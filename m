Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D203E937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 18:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBzVm-0000ET-FU; Sun, 12 Apr 2026 14:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzVk-0000EH-0e
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:26:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzVi-0000o7-57
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:26:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso3642178f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776018375; x=1776623175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q2STWrBjyI0uMcuI8S75R3FdSr2T81T/Hp0NQXzg38o=;
 b=OMnuWoxqFIjlmqYgSLozEPVbx44uPdPXvVgk1uerc9sHG82faY6XuCBNc3Nv8XkoWl
 6PPM2hVpW+iHKyC7tbrVYWwwwxkE5PZufhlZ8YlEs6qIyQYaPzrIc0yIYJasN4m9sli8
 RzYTZ+ycWesvqL/MR1F4SDEL2ds33ucs/yR7D/OBsAv99UoobjsKBEi0sDrCAGhMxCJ0
 0Nb2rIh51Yfl0k/63V7+aFX1art77cUbuF041IvSsiu+DIHo2bVvdYmqYgfGvRWEakyV
 jgOrEcD31/7Acw3H5mg5TDcu8twIImDCBiLzXeNz8559SGXJBOrw1GHxsurbLCHkameC
 xZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776018375; x=1776623175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2STWrBjyI0uMcuI8S75R3FdSr2T81T/Hp0NQXzg38o=;
 b=MMXjz9oQ+jNrkvJ8tDrN2H47pbOsNweT2mIJb6Yrzb9RZaCoMPNPNO0jTBRm2/CHHr
 HYQdyLT+gIPrEl1OpybyK9HI4vczATCWKFCAxzWVhzU41Eys8tip3EoptGRiXMlV3oAH
 CSHLs1gwAc33LPYPYLeFZ+XytfE/hRZRqxkiMh+pr/OiiMV0jpcDK8n1kuhoOsXvtU8a
 8Ns/LqfLyTsi6Gna65t5Z9zldx2SkTwcZq7wqlV+qZzJy0zmgbaDKNWP8T3jGMkuwkXC
 2S5OZP2AxkpSFSEn6vpsErH4U/AXluu3JgjMR6DkuNnUFJMQdOBJnadZA/uuNNLCItt9
 xSPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bSuCI2e2IXeDE3l2Fzt7oFxmBa3QthymFMpLej8XVSbP9j2mIp8AQwDb/jCxpZQm2ECAoXY89yDU8@nongnu.org
X-Gm-Message-State: AOJu0Yzg21RvRXiSHzTGuvcm6mpW/7LZMNNYBHC+/l6Dv34nnHX5/Ljc
 kQuKDVeUeW05KP5dqRvtOJUeNXVE81mjZXlq2fWXl5PC51OcUsy3VJOM9BOZb7kouDg=
X-Gm-Gg: AeBDiesps0U2YZHyBAPDJZ8MIHFzIOyATEu3f0j+HzxdZHxhsryZeDDoHEpS4vgd3/I
 O/BDRKM4MscFDo7WGnGZhhHMJ/Tz1KG3AfF31xnD7PLOEa4IDnjdHgHfTPZsKx0R7Eewy95gjTf
 GIQmSZmehIws9PYM+egUQi1yWZHoixJIoeZGZOCkd2A6grie2dVzuIbCvUaGmXuaPOA34tSR1RO
 sirLJGK5EgmRTSP5/fWS+gQOcjwgiJ0oKjFXn+61t5gNoGq+Mkd4xNxEt6NX+JyYx5Ih6+FLMM/
 pEFQo7+H9OHF6Qex0ATfcEazKquilOhCfAn8hbR6oPIvP8fFPAVW/uCmx/fmIS4PRp01GEad+Ne
 49a/EpGFNXN13bPXyJNLNLo3tQxoSFZZkeHSdwOs5UsIJIFFiLXNyYYuRDW7HptUa7AB7/kQXmU
 WddW6zT0QBqlR3eWUxyGJsm9FwIq6CfsMY/i8gT9TpqYBuN0nJes0mFydN9pSPvZpmWg==
X-Received: by 2002:a05:6000:230a:b0:43b:6a55:e26a with SMTP id
 ffacd0b85a97d-43d642dd77fmr15656389f8f.51.1776018375423; 
 Sun, 12 Apr 2026 11:26:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e51600sm21981240f8f.32.2026.04.12.11.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 11:26:14 -0700 (PDT)
Message-ID: <5fad83a8-216e-4be4-9e7f-63517cab9474@linaro.org>
Date: Sun, 12 Apr 2026 20:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/mips: add Octeon COP2 crypto core support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-4-james.hilliard1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260411070637.72421-4-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 11/4/26 09:06, James Hilliard wrote:
> Octeon processors expose their crypto engines through selector-driven
> DMFC2/DMTC2 accesses rather than architected standalone opcodes. Add
> the common COP2 state, selector decode, and helper plumbing for the base
> engine set.
> 
> This covers the initial hash, AES, CRC, GFM, 3DES, KASUMI, and SNOW3G
> engines and moves the implementation into octeon_crypto.c to keep the
> MIPS helper layer manageable.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.h                  |  165 +++
>   target/mips/helper.h               |    3 +
>   target/mips/tcg/meson.build        |    1 +
>   target/mips/tcg/octeon.decode      |    2 +
>   target/mips/tcg/octeon_crypto.c    | 1628 ++++++++++++++++++++++++++++
>   target/mips/tcg/octeon_translate.c |    6 +
>   target/mips/tcg/op_helper.c        |   14 +
>   target/mips/tcg/translate.c        |  196 ++++
>   8 files changed, 2015 insertions(+)
>   create mode 100644 target/mips/tcg/octeon_crypto.c

Typical patch I'd feel safer to review with something to test
in parallel.

No particular comment except s/target_ulong/uint64_t/ mentioned
previously.

