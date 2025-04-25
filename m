Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GXu-0007iJ-V6; Fri, 25 Apr 2025 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GXd-0007cE-KQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:44:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GXb-0000cI-TR
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:44:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso9768955e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577858; x=1746182658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p1M4irVS3HeLry0/DulTzjRS9zD5QDBTdbuUwtRXiss=;
 b=FoEwar+9CfUZOvtJasn6qwGw8v356tiT1yAygiZ1pe7wnVkBbSoAgIl36OSuH0voiw
 A/UgI3l7xsqZdik6PSqQy9SAH5OIjP6xOpSDQ07k8+0GvbpB5TbuAQR1D3fSNuP+ppF2
 j5FZCIPHbFOF6oKK7P1TU2D+F6xwAHVrt+MTIJcf/3mazpdC5wpR9Kg/4V2CExEFOVMS
 uobYpnB9AdTb1KpI2+87p3819VrrtfMFCoiZkIfR5GRlVcQ/mRHyp4LNE4LuFkISSH2/
 3FauyKbUk2f1xYXCKdk4Va5fr+54IGYmeQEMMK+N+rUS+YV2pwHehsDNTPlh8Gc6BdHa
 SY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577858; x=1746182658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1M4irVS3HeLry0/DulTzjRS9zD5QDBTdbuUwtRXiss=;
 b=XdLcHzyGijqbFyMjqwPYFeVLM2y+LO0Di/X6tkZAXJahvqcCUSEnm6hB1FCX3BIrTS
 J4qjKQTXU9oVt+ayPGigPPubPiyvH2dY/OdZrxAghpemtJXMNo3g/oSkLNLR+wgXeAL3
 O0bLdhjZB4e96Bcm8WW4Cic+k6FDezmJI9H8chHQs1sOkmLE5SKBGUcccIUk0AVC7D6u
 0giMN9Y3OvLyfzn0L/aSqN2vMk5j6CVZ6RQjtDEkgaXgkGZxzTv8gKMMbmcayJF/CEQD
 GeV0eJ+l9vjVftXhEn/P1C5mYQudR0/ULW39MwPdTKzvv0A57/bFIFW/pDmBDl0ImZd0
 mNNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdCUpx3wHqd79Zr2Ws08ddRZkqO2cDLlY0JBpdo/uhdXrmEybqbs/I0/TLPexVrtv1d3d48Du9iit+@nongnu.org
X-Gm-Message-State: AOJu0Yz+AFH2IWeQ9ioVYnv1gkL5LU8a6u0JDE+DEzdHI2oGQpT9sSYi
 iNYmuLqduFiq6WD69O7WPNjZOSVIdCxEe68isLTZbGTJylkYObp5/CMJx5qHMfM=
X-Gm-Gg: ASbGncvianhNEaUz63uvuz3Awl4LZ+opadt1l1sIyoTZlrr1Za/dWNXQfB7JJpGcFFo
 um80H3Wu0GyM4qg9slKxrkVeGszYteTsUWm0piYGNhoj8TnxasnY8dFXIOrNrtLW5Y3xnuJbuwe
 /KJXlazGsM921yr1dCMwrRpOMIsa6dZVEDfXjftZR5J/aj8mR9NQ+S2ZUnW5TEevbZpjM3eraiU
 mS5cgaoX3VgdMViYYSzrt6ozQwtSCYW+bw+his4He27WOuTanVJ4Af2PTyw09XxbVreJbEaSUOI
 fuUdOJA8QOJ4DcCCStsYt/3UTp8DZD4hmOVpACYRBTPCUt4TKbYxRjkZByEZF5NOGEz5qAua5eU
 gWDxnKbbJ
X-Google-Smtp-Source: AGHT+IEEKsdcWiBfgQmjS/XBJBPq8Ys9/M2dGU4oLUf0cExazB786hlfHFfSUBexxEOFBd99sWcqgg==
X-Received: by 2002:a05:600c:a402:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-440a6f73b73mr14309655e9.9.1745577858168; 
 Fri, 25 Apr 2025 03:44:18 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29ba34sm54945445e9.5.2025.04.25.03.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:44:17 -0700 (PDT)
Message-ID: <4f0fc9bf-d7d8-4daa-8a49-4664f000ec3d@linaro.org>
Date: Fri, 25 Apr 2025 12:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: target/mips: Fix MIPS16e translation
To: Hauke Mehrtens <hauke@hauke-m.de>, qemu-devel@nongnu.org
Cc: arikalo@gmail.com, jiaxun.yang@flygoat.com, aurelien@aurel32.net,
 qemu-stable@nongnu.org
References: <20250412194003.181411-1-hauke@hauke-m.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250412194003.181411-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/4/25 21:40, Hauke Mehrtens wrote:
> Fix a wrong conversion to gen_op_addr_addi(). The framesize should be
> added like it was done before.
> 
> This bug broke booting OpenWrt MIPS32 BE malta Linux system images
> generated by OpenWrt.
> 
> Fixes: d0b24b7f50e1 ("target/mips: Use gen_op_addr_addi() when possible")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   target/mips/tcg/mips16e_translate.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks.

