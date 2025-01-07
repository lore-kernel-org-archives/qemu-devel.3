Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335FFE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 06:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3Rf-0005qQ-NP; Tue, 07 Jan 2025 01:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3Rd-0005pu-It
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 01:52:05 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3Rb-0003vn-Io
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 01:52:04 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso11297894f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 22:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736232721; x=1736837521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JHJXvWkOPDWpmq79f8zCj+vmrRIwZUYfHfzuEHPF5x8=;
 b=i9LOLzQy+9bdamS+0/nL5prj+VAaO8s/a2DgxUCOZryGwb35oZlTBzVaQBue5n++TQ
 PMw6Qr/YA78IsalRrUH6E+ZtXxUXepmRqjZnRCHJXWrERzXLAriSBn3eMqRv8KeU5trR
 uWazzh6FD1V17IJY5u07DXEPEBdHgPbSpf6000P5PFxnZ4c/YfUOD1uD59B1APZCMz7o
 7fP4rpVPhOL7YYovKGgKLJ5wq3tvrcSiu1IEdcc5/aWk7E2GyEBSyoKYfNBX08wS29CU
 IrcFuqD7rY4bKRUdUcYh65MTblNaPuftZe1lYmcoJk4D3DCtCYjV64Uin4U5I/SWGwFJ
 slhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736232721; x=1736837521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JHJXvWkOPDWpmq79f8zCj+vmrRIwZUYfHfzuEHPF5x8=;
 b=So+MpPMXi3N1Sqlt+uCwh1Mpmp3U2HqziM3I6uVIuBjq6/bHVzSw/YLsvjOVad4Qvy
 vtbeYznhDF2XMGtR+bLMmKrL1nwlsMHZciDXYGIBTSElAUlzAcVw0lv24ZBarXgAR0z5
 2J9rvGNaFJja+h5n6dMOTLTyAb83+V0c65SH0xebF9kL4NK9zV709iGS+YHi8eR8AfAC
 n4gwLEfITNkK55xr+uyaRJryo0jyjMzQuWQGzV7Klr+TplGLF+ia0xWgS9PF2RLYMr6s
 ReTmSl0Lsalyn2tOUcXMp8gnj37jZTM591bVkTjLXSmiehh3tLk24w8B7HhSFkEaOcan
 grcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOK7S/NfZUcs7w2NDYnORXTY+Nodu5ZtCamzUPrz2wdU12e5s25mvUl4DugnT/tni+G38Rbyn2OG3l@nongnu.org
X-Gm-Message-State: AOJu0Yz7OaHGsCVA6uxMPSRA5CJAErkwbBog/wBGPAlVMgNTFIetR8YE
 oKoacxcAQ5qJCFHtYXnI+Z+NCtQf3IWjIT0fcX3RO5FDc1q2pitYJYyZYW7UDpw=
X-Gm-Gg: ASbGncuD14y0o+4xhXfCodQpfvL1iIV5He4WOiwSjVqwL3xnR3se1lrJ/CH4X2Wt8Sl
 jT6bmOgbOVQRKLuOaMG6dqtz7aC77+dsd2C+YwT03XuC57CoP5xbBrsmIq0wr803gu+91XW2bu6
 hfZMKDaGmTC3fTXNy+W3FbZL+55P1bgzI59hhUAU9wUW+bx5lVS0IEio6knPz7Jt8FgPbms2uuA
 qlJoTV/DhwDBcZB+9bPGxif0eVHNjJzwoF5DeWkMWEOi9r9Wef6g7lv2IuAhJtv4d63WdPSigs5
 D7G1VZ4FR/tCaWxCZpKBOBmt
X-Google-Smtp-Source: AGHT+IEB2vbfM5aTlgSLQikXUasZcCiDDJ3wYOzNYZfuR+75YRsc8+Sq6wDQhXpMAI0nD31X9pdMlA==
X-Received: by 2002:a5d:5f83:0:b0:385:ec6e:e87a with SMTP id
 ffacd0b85a97d-38a223ffaf7mr45383775f8f.43.1736232721099; 
 Mon, 06 Jan 2025 22:52:01 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1a1sm49011413f8f.69.2025.01.06.22.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 22:52:00 -0800 (PST)
Message-ID: <a4fa3adb-ce6b-4eae-a91d-b26b5c173986@linaro.org>
Date: Tue, 7 Jan 2025 07:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add me as the maintainer for ivshmem-flat
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20250107015639.27648-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107015639.27648-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/1/25 02:56, Gustavo Romero wrote:
> Add me as the maintainer for the ivshmem-flat device.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


