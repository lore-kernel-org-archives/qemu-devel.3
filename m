Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEDCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnJg-0007oC-LU; Wed, 03 Sep 2025 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnJf-0007nD-ME
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:14:23 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnJe-00035B-2s
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:14:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b043a33b060so380775566b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756905260; x=1757510060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CL4s1pESMT2zbONuvMqSLYrGYIxSY+xAHFwv0UkQJfE=;
 b=WmsP0hkz4HJad0xSTS2gsgb4e8FkCrpaScBu1TZQcOUrp/0Jlr5Ajqt9fjJmqUEgNY
 hwIo3cAFj0JuI1Epwh3OfAGF/JDQNKNmuF9gJYHa6H/wKt0kowyPH+YuYVRm8uYg6vqQ
 Hb0k8rrVQ/DBSJ3mDueGfqPRP7Xa+dL5E8itTT/wJolC4x2MKyRS6LxUD+Mliom6MZuw
 KowWyTM0d954PfsG3MD2NbeWD0tMHDVAPbG1YcQTM7A5pmGPcVk0/BOOfTeIzaUPXPsz
 L0jnak30GEWyLVyS4h04fkwx4tpJq0WKJ8jvpe6x0jj37xwddfBtHWfueb89clj2JVF1
 g4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756905260; x=1757510060;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CL4s1pESMT2zbONuvMqSLYrGYIxSY+xAHFwv0UkQJfE=;
 b=sPceagyT0wg+aBbFdgzoG0D+89RRt9MiXbpiWGEx8U58VPzRfa0lupFuKu3KAmn7fE
 Hmsgpv3QS/IMiMjctaN8bQSBeCy7flXojHoS+kXZYfYgkuBYtjO1puN8Vu+zRERzzICA
 wY9GlanFQVcnShbv08EamP4yAbqX3/qv7CV3v7sk5aiGA4+KADMHzK4iOghjntw0ukf/
 6Wp5hwYGXcXZ67Jo03vNEmTjJwPVYHQBkYku76426NvkRlOrpgXE/EyIyMpSdno/r/k4
 Z+QtupynY/ON5gVDrsIh2sRldQTTcT3BUsgBOhIUDVCH3S6GxXfhDqtmCFRa3z/D0sBk
 YjEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqhWiL7hBaIMNTLfa0iAGYka9vjKA7wHm5W5/AZv9kAlouRrGmXY7n18Z6Nk6/MNr/ijafmvPuaYuD@nongnu.org
X-Gm-Message-State: AOJu0YziDqxz6SrSb8O9+oYm2GM7JzDc14NInQXtpQThchoC8DvDOqI9
 6jXPwF37WP5S463EFrR99sVi+O2sz9S7PmE3jEMD8kjzGWDACv2D0XUmNjIx6Dg1fik=
X-Gm-Gg: ASbGncvb8cQFoQb6Hy0o2Iip5d3KwmcrmEXQuRPkswRw+fSqqA5vblv5LO6YDijwjVQ
 SRVeFdHSaTDyPfqnavt6TK999EBHGlp6NIaRgDFBrYuJ2iGrZNBszdCL8Q/fR3zwG/Cu6+oto5u
 aWYgKD1y6pBHfR3xISfBygo7MLrimsVeSYLwdHdA9VuGduRyEDrURb3b9aoIqSJNT4Drb5/T23O
 Cq5zPwaj9Vd0a4NoDcIKQcFu6mkk1sCOVOFG/B6s8hHzl7LkMTdpzL6um7OCRQjudJWzisMwXz5
 nnPftT2alzx6kRZEYu/dE1zXQtSg7jrCLOEyQiYerQ6tzfhk5HUtjgO/JwA0xiFYU7uLy5+J71y
 oSTcfMaru0FpPZFK+IisxXHTro0X8tbvDzNjVP5FzCLhLMneLq5gs1g4dKpwl/H2u0BkalC8=
X-Google-Smtp-Source: AGHT+IH2ClOjIvsSZ7lg/O17FD5Xx0+ja7ATztDZK1NiQc29O/JTG8OQbGYTUla+TwKZjy0eLN0DQg==
X-Received: by 2002:a17:907:2d8c:b0:ae3:163a:f69a with SMTP id
 a640c23a62f3a-b01d9731cf9mr1766748366b.33.1756905260257; 
 Wed, 03 Sep 2025 06:14:20 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04190700a4sm910621666b.63.2025.09.03.06.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:14:19 -0700 (PDT)
Message-ID: <58318cbc-05fe-4de5-bc1a-f68bfb30ebaf@linaro.org>
Date: Wed, 3 Sep 2025 15:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/loongarch: Add tlb search callback in
 loongarch_tlb_search()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-7-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> With function loongarch_tlb_search(), it is to search TLB entry with
> speficied virtual address, the difference is selection with asid and
> global bit. Here add selection callback with asid and global bit.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 00422f259d..006fe1b207 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -21,6 +21,17 @@
>   #include "cpu-csr.h"
>   #include "tcg/tcg_loongarch.h"
>   
> +typedef bool (*tlb_match)(int global, int asid, int tlb_asid);

Should global parameter be bool?

> +
> +static bool tlb_match_any(int global, int asid, int tlb_asid)
> +{
> +    if (global == 1 || tlb_asid == asid) {
> +        return true;
> +    }
> +
> +    return false;
> +}

More compact as

     return global || tlb_asid == asid;

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

