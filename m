Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCA7C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx98o-0008MG-A2; Tue, 25 Mar 2025 14:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx98d-0008Lc-FQ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:36:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx98a-0000lj-8E
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:36:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22438c356c8so123534065ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742927790; x=1743532590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ayYF8Chyt5E5TkSBCWrS4suxin+WTsCqhqvzxx71roU=;
 b=DegeIkEqip9ZCEnVobc64TJ20qwWik3COIe3WlHs1r8F/Lf9OFjhXbHWyT+OkDr1al
 WOJ1Nkj8isrTNy1oQHmlY2hh9XxaS2OzjC0cP/oYLRccVUDggRgCqQsb4OwVCJPSF7jL
 rBsU2Ci24w6U0bTrio14jmN756slNRTocQVvF0DVAo29DdJhrbjD1iptSAzW/ATpWm3f
 OqQ/yg/s+GW9vGJBtpQd+wpFNgZXWy579+na58pfL3sW77acIapoNFOe/oI7Rf6UhwTW
 hMV6dHODlYudiHA0zcIC21krD866mqJMzah89bkJuf7GeQrHzfSAwog1GP5+P1hNxhwC
 aDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742927790; x=1743532590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayYF8Chyt5E5TkSBCWrS4suxin+WTsCqhqvzxx71roU=;
 b=lakfXmyxOLNr5lXPMsudSlqu56dJJHWopLMb8V4qS/l5B5pfaq2/TMNgHTjVHilUNd
 P8EaCPZhxR2cN98PYs/zH3oNLqL1oeZcO6iw1Ti5SNxg4HTIAldsqMcZ4ahlPdQ86gJ/
 WQcTAXr5pRqKSl3KD6mgM1cW8GEMYGzwkKOuIYDB9HOXzliCNFOAH74NoWiYc2bdulmB
 XOSgRpeupuBZZW/ii4uRpHNV0H/9DTU5hR3J7jnywruwA7fJiO+G0HOdCy++bHjNbZw8
 aLhUpNRjNmmdyzC1WaUlMp7OwWdIRhmRgsd8D0VgT0dh+WlhXPMnExvJRYkK5I7cmVQu
 RSFg==
X-Gm-Message-State: AOJu0Yw7DfnaljAveuahJNMUY+ePKoGQQ00EtddtBlDhy8fZLlWfv/0u
 8KC8oV/vAjCzvki2QRMhgs58DOZdtt/APKvS3EFUhwfrqv0IEp62ugTSjWfvuYOAstV1n9Tbi9L
 P
X-Gm-Gg: ASbGncv+HnHIlCRRqwf1bWlzzNYo+6sK8b557ae73UDCgBMRP/jC87tD4x/mu5Agkoh
 bHJ7UoHj+p4do3mPpHIQY9HWJPQBHgcoQ5187i3/kfua15fYHfJLeYhaKRHzM2NI0FJwh+Kqw5t
 dxoZgCDPNlAi/z4WYYfTup5/4TWJu7sbsIkBXRghktDisW9mlBixwxRofaKs8LNxEPsfRSqQmNx
 oHV76z6uP4931ug7oi9fGuM21d8kxdJBCcg0DFBa+fr8Qle8A9SZ265VfgtwwoFXTkcIPBWYpr4
 bMeLahj/A2h5fXXEcvINd7UUzYVEbXtSKP6KO7NeFNjoWMjtSXnf5vmhRKrYeD2mA548iMMQabO
 Q3Uwp+HUk
X-Google-Smtp-Source: AGHT+IHjCE1YzopGQYdFIGfwvEXpgWDhX00VwhPqbOhOMzdLVt1RUrb375wgH8rbZq7XaLPTHWgvJg==
X-Received: by 2002:a17:902:d2c9:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-22780e26127mr257445315ad.47.1742927789781; 
 Tue, 25 Mar 2025 11:36:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28059e8sm9441690a12.20.2025.03.25.11.36.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 11:36:29 -0700 (PDT)
Message-ID: <30616e57-6bab-4563-8acf-d5417415e46c@linaro.org>
Date: Tue, 25 Mar 2025 11:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] target/i386/gdbstub: Replace ldtul_p() -> ldq_p()
To: qemu-devel@nongnu.org
References: <20250325154528.93845-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325154528.93845-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/25/25 08:45, Philippe Mathieu-Daudé wrote:
> When TARGET_LONG_BITS == 64, ldtul_p() expand to ldq_p().
> Directly use the expanded form for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/gdbstub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

