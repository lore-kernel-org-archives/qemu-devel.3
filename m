Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4305ACF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t01ve-00023q-IR; Sun, 13 Oct 2024 12:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01va-00023a-8L
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:58:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01vY-0000Ha-OD
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:58:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso353680b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728838721; x=1729443521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCA/mL/+JBOLlF/iommSkyrvGWdNKpHE/vSRlat4X7A=;
 b=aMEq0lCunpHdRB+xzVT/jc5u4a5AT8SPyFAwCpPV50eReYNHI+HKcQKwDwPFizv6RL
 wVTA+RjO3DhwjXOcx2/JcLf9Pebx8XioAMGdhvvtWX1PIkWODWr9987PCXQW0ZjEacso
 2PzGMSm2dXejXSlgIsFpGyoXpgJMcwbBNtCgyqwwKxTLGpsQuP6SLOkT5TW4wX1tO/c3
 29/Kh+EXWzh4gU9c8ZmVNoovKeNAqawBM3CGAlhO9DiT/9vbs4FzEFadtjtY19lWYWEa
 GU8b+1gUmFz4gdJ6FiS+f7RowyeThgbeQTtdF8ozfbwzEeFmqf+lk0Vz++emuaK20ODU
 k/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728838721; x=1729443521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCA/mL/+JBOLlF/iommSkyrvGWdNKpHE/vSRlat4X7A=;
 b=pD43FrfbCYLBOuO8hZ4cUDlonYen+hOZ8t8D/ga3DGkt5PnLldFzUspbB7BgrS4/r5
 JDTMoNbecYPcMQFOCKWqmK6lvVrtu4yUFXWXjR5pi/s/UVers38mjwbuQIMUAOrs4SLr
 KIaYTU441n1ECyRGywmLdvMKsRJIr3puoFtTIFaCqq7ZJZcGHUpqu7i8W4ivCgx2iIXV
 26Xhk51HliPsXedkTGRs635hgllI4dppW4yk97cRNrdqASEe/26I1o5jTou1e/pjcDbT
 jbCWR3uc3tdUYN250KVDoMZ5AmH8im/WUItbsp58UqdBmbgccQYX6e/9VhGNynG5R3LC
 EycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/SrV4b36yb1qTwR9dRJEmcHH3avZCGtwswiuEvsENr0CS+C3FQjvAMXUVkgkA3yBmU+5RTULqd5hl@nongnu.org
X-Gm-Message-State: AOJu0Ywrw0x179XAw5qwOCo0kSpLlp30s1XlFLshKFxobSSbTcTusXRL
 k/xyyzHsMm9nps8+wFmOlFT/9XmkbAS2lKLCCULaKCRz3IYKxOGfrEM5GhntIuQ=
X-Google-Smtp-Source: AGHT+IFmTL4J3sgCfkIDyOzizEfLFs47VrL9ouksIwFiO2tChFOzYh85wuQrudhh3nHaYySxUIrAEA==
X-Received: by 2002:a05:6a00:1307:b0:71d:fea7:60c5 with SMTP id
 d2e1a72fcca58-71e37f4f00fmr17135376b3a.19.1728838721522; 
 Sun, 13 Oct 2024 09:58:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea448f954dsm5370982a12.25.2024.10.13.09.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:58:41 -0700 (PDT)
Message-ID: <b0fc778f-e922-44ed-9663-bc54c4aae623@linaro.org>
Date: Sun, 13 Oct 2024 09:58:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] hw/mips/cps: Set the vCPU 'cpu-big-endian'
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Have the CPS expose a 'cpu-big-endian' property so it can
> set it to the vCPUs it creates.
> Note, since the number of vCPUs created is dynamic, we can
> not use QOM aliases.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   include/hw/mips/cps.h | 1 +
>   hw/mips/cps.c         | 4 ++++
>   hw/mips/malta.c       | 2 ++
>   3 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

