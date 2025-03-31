Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4915EC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDC0-0003vS-At; Mon, 31 Mar 2025 07:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDBq-0003up-R9
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:20:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDBp-0005Tv-8y
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:20:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso29132275e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743420024; x=1744024824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ADiOwvi8t7PtXI2mn1Glpzt7hwB5BN/6QAN5l5+l+No=;
 b=pBjp+x90wTLNpYPoHS4aY9M9Zr/TWk6HmOr6BGaC6/9Mt3tcTQoSD0p9nQysRZolvq
 ZTWYHkoWIbiFpGXDWzkkNcLozwlsPc1rvF2CFssn1nxhpq2pdyYkiJfIdKExybUaS0/5
 7n14TW26/fMeA27Nk0yj2/aaztXo7KBfDwe80ON9ax+3qEzn3pwJHlfDejC9iyJ9/C79
 Fuueg1C14KsPi7UO2CS0OK6BgqCMI3kEmMch1FwEhyQjGekWmy8HdZe/BanmkAL1yF8I
 imgLyFfRovifyaMKBtqA6J296IMan8EQF1dbjR96bMtdcR/kqLoqrl/2lbd/jNptZ/UW
 PA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420024; x=1744024824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ADiOwvi8t7PtXI2mn1Glpzt7hwB5BN/6QAN5l5+l+No=;
 b=X9zbt7ycgOItBPpjTOfZc8VVU5ZiZU/mHvKjoMwGqpQPMhjkXblyPrahBUJRNUQb8l
 5+zqnh+SSBb2zkX0l5WKD2/+hX9Hcf/m0S+oNazjatU9Qmi2ER+KlKOSyQrRaLMkr4Uh
 5ZuLYNWqMtAsAAUBiN5h2FF56Pjgd8CKwoxPa8u50m4ByfFUbhqGTO9xxF/ZhESDbWsR
 Sl/UIZNMmQh2RBsroD0FR2z9+Ng4Pba4HmT4Zt86Zuf/UL6Ad1kZbt9eJFPkmJ43pb60
 YBCb0ENtR/QJZhxAw/v5YNVbyNzVzB6djpLackTcuUO72OWwtpYkaQ6n54/6nS1Cderc
 Y24w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyq4UxIhUZO4Zq4/ocl6bJGDh2fRMt3MMfhKcY70r5WqprBfHXqAUqTrXfhYZWddtIvvlzYZ4zi0YK@nongnu.org
X-Gm-Message-State: AOJu0Yx8SQlHZlmOwP+lv2wsBqfZRwhPNvT7NUcsr3znxVLdAWBOzzLy
 EirFGbEJsdP5lmigmou+pDo9xTfOHOLF7ME2wHN55lziaqGJuNqtCj/lPEltH8g=
X-Gm-Gg: ASbGnctMBsVI8oYFsZWaTEkjJcIp8rcZO6seIlAUqqN5gg0qgstZNyDYc1S/DBVZy/f
 TxiLrB20gFenKdJEkYnSdqXJgJQmtSIQuEq5VqiPE512KSu9EY04m3LrqygF2NqiISBTLQpDhci
 TDoTAgktZF3i0aseJ1ds/7DrVdL2nH86R49wsHZBXVRUo6IG479qt+eePulnomDaGmHLB+/rwDD
 2bEcPGuzf8rM//kWhOMlGcyBH8nWkjPSAzD0dMDX5YRyCBpPblvgBG5xrxpl5D3p1ud+jcA8chl
 EJPSlTq8oa4aLWvLGT6vtaqxdIyRydyt+ALAWT+4IxaY8WgdTXs9jqo/aImSvwevVDlqbZIdQmJ
 w+ZEpDRfTY6yU
X-Google-Smtp-Source: AGHT+IGsJeAPKZz0PR5mHTymId34kuq3Varf4IgqwBjSrHHq8MKpMctT2vzgVPK6HA//hhd6pPtADQ==
X-Received: by 2002:a05:600c:1e23:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-43db61cebecmr84973695e9.7.1743420023683; 
 Mon, 31 Mar 2025 04:20:23 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc12bbsm118587955e9.13.2025.03.31.04.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:20:23 -0700 (PDT)
Message-ID: <a9348ea5-ed0c-4420-89e3-aa9224bfbb68@linaro.org>
Date: Mon, 31 Mar 2025 13:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: free irq on exit
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <43ceb427-87aa-44ee-9007-dbaecc499bba@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <43ceb427-87aa-44ee-9007-dbaecc499bba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 29/3/25 12:47, Zheng Huang wrote:
> Hi,
> 
> This patch fixes a memory leak bug in `ufs_init_pci()`. `u->irq` is
> not freed in `ufs_exit()`.
> 
> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> 
> ---
>   hw/ufs/ufs.c | 3 +++
>   1 file changed, 3 insertions(+)

Queued to hw-misc, thanks!

