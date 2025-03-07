Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C0FC28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfhb-0007wG-BG; Fri, 07 Mar 2025 16:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfhZ-0007j2-4b
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:57:53 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfhX-0001pb-Fm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:57:52 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso1292706f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384669; x=1741989469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=udZR0bEZL05fApsZ+msNN/hCamSF6IiF7qAKzKTFWl8=;
 b=c/XVI0O9g26UWKSaMcMYUCdtyLQxlHcTCDcH8dQHDurE2Yg+wW+X/+GHTrZM4i+dOI
 YbsftyU+Z8zV3LYWgGQf20zk1PW0PqX1DVVtzPLD0v06OTKYiUq0Vi+0XjBTD8cLSgGD
 vXtSIdpBzpDynKNnRjXOtnFLu7j+Uh8b6dP77IzjFFWMddJiaNRc8gCbk3UfqrUxcj0M
 l7yFoaoeG9ShGBnVGzDSvAMWy/p/ZzFLgPeH18Rz+fF5cPKbk6JhdgFGVnUjfZ1D15w1
 PAMhqSN+rQQcfoncPDsFITovuY3nMk6vhniOn+LThgzC9WgMIL8TIX2CcqripLFrqoh+
 y0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384669; x=1741989469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udZR0bEZL05fApsZ+msNN/hCamSF6IiF7qAKzKTFWl8=;
 b=SzTMoByg7ULdb+sPnmauGYbfnkZCHfDglcnaPs9uGrP7AoLE+kVsd6W98GsTdjhPJi
 AQVjByEcr2Ij+d3To9y3GObp887gGcvY/t6pNLT2MmAuk3yn/ilnAvZbdDUPcGhBXeph
 iqS3yPPz2rUT0sS3AxBnRXOqBqJCxzd/6LJVqhAXQGTnEugX5Ss/gDuOAxOjn+AzMlc/
 eTSWC1FRTdzxEL6172ofSEOZojaQMJ7MHhU1maytB70GtMcxmLkkCf4dzaRlhULUiwIl
 +v8HgPYZtuKLCWblIWnou/UBhYCeaMhAwjTBHyI7/2a3hRWgbeGzk2QawZCeFQR5yqJl
 6Fvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+gIyma1dHuul7zFjQ/OBGeiku92VEYjlZGxw2zt6ec8FH9xYCoLtmpPj2puly630SHxx12Y/otdeq@nongnu.org
X-Gm-Message-State: AOJu0YxIOihILtnQ3ic/PW3XvW962+XgHwFn/FuvsZdJY+6hO3hWZXGo
 AJrHX5Zi7lIm8gMDMOBBiK4MwGpdAd8WT8fl36bVMcq7BwTT+deHu4WjOX0Aj3N/WQ+XTK5m4ZH
 S7l8=
X-Gm-Gg: ASbGnct5l7TCyBOIbkjWs/xPmwlgeNspRapUDLLzQDZvbiNyLRmIo/2Y9M/Q5evWSUz
 je5fZVndelbmPqvY96JgudXDSjj9yDoeKxT3tJNWCjofhcCVkVyxFaLDFpmLbvpQoIJqLS1BU2m
 45lRr4EJ4st8fEfoxIbaxtuh9Z8JvjAdlR8SG7m4Tt5dTceQzoJ4CNewwqlcb0rKqjVwbxb0UoE
 Bk5Et/uDRJlsi20J8whvpdmcCXfVi1/HVaGhV91/qG4Z1DWji++qB0Am0sPicajKblGA1egnUSF
 kL4zA69EV+QycIwmPJXlAzbCpHOD8gNvXeZJvzS1buLg57IHE3CCo4fPxmVQ0WxTt3keLgiOK5l
 3ZjpeaEB6oemj
X-Google-Smtp-Source: AGHT+IHNVdz/o8FyPRL75okMWUdSdUeFe0CKKtCPbYmzyZMggP1ui0m9EfsgP6OykmwuU7Pr0coL+A==
X-Received: by 2002:a05:6000:1844:b0:391:8a3:d964 with SMTP id
 ffacd0b85a97d-39132da10e0mr3421476f8f.41.1741384669643; 
 Fri, 07 Mar 2025 13:57:49 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b04edsm63263125e9.1.2025.03.07.13.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:57:49 -0800 (PST)
Message-ID: <32cb5c3b-5129-41f9-87f6-23c9c6763f65@linaro.org>
Date: Fri, 7 Mar 2025 22:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] system: Build watchpoint.c once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307185645.970034-11-richard.henderson@linaro.org>
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

On 7/3/25 19:56, Richard Henderson wrote:
> Now that watchpoint.c uses cputlb.h instead of exec-all.h,
> it can be built once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

❤️‍🩹

