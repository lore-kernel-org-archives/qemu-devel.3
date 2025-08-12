Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD253C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliIx-0007qB-48; Tue, 12 Aug 2025 02:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliIP-0007JK-EO
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:15:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliID-0004sh-IO
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:15:37 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b79bddd604so2958193f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979325; x=1755584125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iAEMNR4UKt9hMxT0tjClDsiUUMNdqUhcMcchVHFleWE=;
 b=M0iiiYXE/Xck8zfN1B2gPOvDWLD2RTjdxMd1C2UrqFc4sIomlJTabJWSXwzdz/ufQw
 tfHtxsqeYgy5Gf4xur1486lRlld6ba+OoMu4aXrjlMdf6G4v+ROqV+S1LUhFGX5piR5g
 UrRyTX0CjKjw/ppJVkGfvxpIboUSjihBIMNMWSjIeNNGKVgD/8owO8ieIzoM5hIidZMa
 pAblmqHnnw2u3iRGqUqzZ9ZP+fu4nhNuQjp2KRRSvcciC3SlCfZoV6tgZ27pURMsoxm2
 JvSW3p+kPCbycu0UuRtn0sYFe3JgkM98Eufobr7+N1F2Y17GsenA8O49+KNdsMWEABVY
 SGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979325; x=1755584125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iAEMNR4UKt9hMxT0tjClDsiUUMNdqUhcMcchVHFleWE=;
 b=dy7oMd/tUac1/3ZW9y1o4p5U+HcfqWL+SjY4UaMv71Mpgi/9nSz2vboWLZ2nXZITcG
 imF8N2EQ2r+pMQuwbJ3grR8/xGPPnA1Q2Kn33ivnST96w6MvmOJ/b8ZO1wQX2lN4ozgB
 Hsc4wPiKoZWAuvUVGZDoznDW4FcUMTvH8RCMXu3NBxMLeLj60DmTQhaA4F9PiGerrdue
 BkxLN1SayRcTvLXwyFvuCVCQj5Ro8lNR4MOhg9DHYmPaEm4NR+boWf2go21xUBVMfXGo
 HpjAD0SaPzAlqvTxo9HwTTh7abw9n7CKRTTI0t65gMannjVtD7cOkTrR1x03CahtGuof
 TqFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmrBGUbiDHF662TAGYzsll+Nb8J916IeGOHBz1DHbhKy688M/g34Tv/L46R0r3+EB7Y4d+3WbrptSN@nongnu.org
X-Gm-Message-State: AOJu0YzI/UukW4fu+lWdXy7rFeiNludjuOFIfVlnEkUosWjBf+Eciafk
 /cXvYEtdoFg7ZY3q0qeAEZrcTgWUyBWCADc2tRdpgZhboLf7f5zqFYeRBIuaEZKurFphN8YppUc
 JzYux
X-Gm-Gg: ASbGncujEpcPeIejWP980RhQEjN6gC3NYE9mh548RVz61gdPsV+Wd0F0d0SNoHsdm/E
 p1PnaTJTITvCWhqVYkjN41occDeRhgnlw2DYHEXMGci4qaCcSd6QDJ2KzO0hXQUcmgbLTdZwLxp
 Gu1y2A6wgTU5MqtXkv0B5AuxyGzC1T8BRmbXfppEDo016tpWHJMuuhLi3p5dKYiHukWNAJREWMN
 5H8jXUqd09mg6TDJnw7Y49AI+M3Krp5MQmUmKxI6vxXA4EqcILvBVjpdR+gdh5emwRNNouyQ3Xu
 vY8D+WSIpzOhAz6ge0A9u1v9vWf46+vweMRb6G34psoeS25OeWwRpiRi8iJv5NQVa2uE81lbnCg
 /KxDseH1adBQBVOhY/hneb70Tgz+hKYKLzBRn3jGpQP6P/AEiOeGfVRDkJf2HfoGUeQ==
X-Google-Smtp-Source: AGHT+IGXGRVTMoRaLoZrnK1hSDxHKmnt1OBDhYL1ZJs2OpgTk5sc+Q1nc/j3e6R+oNc98cpqtDzmwA==
X-Received: by 2002:a5d:5f86:0:b0:3b4:9b82:d42c with SMTP id
 ffacd0b85a97d-3b910fdb252mr1777167f8f.17.1754979324721; 
 Mon, 11 Aug 2025 23:15:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de91ea4csm337087345e9.10.2025.08.11.23.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:15:24 -0700 (PDT)
Message-ID: <812e4a05-e143-4858-8c14-eac40368499b@linaro.org>
Date: Tue, 12 Aug 2025 08:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/85] target/arm: Remove unused env argument from
 regime_is_pan
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-38-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/8/25 01:29, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   target/arm/ptw.c       | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


