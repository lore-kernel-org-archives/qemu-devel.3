Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1493ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmmB-0004sI-2N; Mon, 09 Sep 2024 18:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmm4-0004mw-25
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:22:20 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmm2-0000Vg-Bc
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:22:19 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d3e662791so133986266b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920536; x=1726525336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BhmLtNxKnRykV0PGmm1TkF6YvHoD2/t9qGUTEXRjJ7w=;
 b=gK6GXBRYv9oj+ySlg5v0pHYcWB13I7oz0y9u0ae1g8cPC2MkuXhbtTwu30/dLpfLIB
 osM6TaCjz3hG4eOH1MHIId5x4Tz7Bg1G+cnW2lbr7lB6uKPCPtwEUTzhjPVbyUyf+ADm
 VCji8+DWo9zDobo87L/69Qn2jDhUpCwDqLvTrRRpQhZHlki1p9D2Mv474bnce7S2rK5o
 oiEn8vfa6O4PbAHca+eywACSBU51oqD+ptEgjaibj9Gz6kFe66nGeFOPP9q9owoPD+CK
 ZnPFz/Kg3mp1IlvaM4Cz3yL2hP8goKWAUn1eqZFZu53OypEdmPDPz1nQMQOYlPRFeyPV
 z9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920536; x=1726525336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhmLtNxKnRykV0PGmm1TkF6YvHoD2/t9qGUTEXRjJ7w=;
 b=EsCrVQxq9FjslWx9iNe9y+GxOlDY84opYSAEl5R4ZanjXoXkgNL1AHOJqV5yIk1a3G
 RNGYkwNlF0axEcJF+xyaJ67iOEVX2+MIzvFKeVlmFYXsHT02KHZdYzH11C6CDxiCAWvP
 FjQLUxBZjC2rP8PiWPEH3GmmlgtlnS5IwpSP9fCFtW+zqyUKWDBRiPOAta3cID2cnni0
 2ucRlwpwWdWXCzbDaDJvO7IpD+5X+8oyDYxHBONtBMgUId+2DXRIp0/Q2rllvBjLdteF
 1zihXu+76rjVcjcShmcglaSjuJyhc2xuC/rGW3RN6/qxwF2wsZx4/O6va1VM3yAtK+qR
 QNMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeuBcbuoDlidDJYPjcI0LjrRcOXJ9tVs0zGhUxX1hz404J3dfdJQUEl6BLBDDT8wQptJx7QJ25LnpV@nongnu.org
X-Gm-Message-State: AOJu0YwldlowY32btbCQRuI2l1aPRNdde3h5BAY5RIvhAXqvXeBme5Xl
 L7Fxu22RkfRqql6Kb+P8HzK0ETvu9MtjN0kJhTNLzxLT2O2BsjtCP4itie1cOlk=
X-Google-Smtp-Source: AGHT+IFrLV8IScbEcWmeiiFfJ/cfCH6CGYMxg7dyzZ5NLEYGFBPHXzB6aDqs6FkvU/OFeTIBJEsNtA==
X-Received: by 2002:a05:6402:40d4:b0:5c3:d0e1:9f81 with SMTP id
 4fb4d7f45d1cf-5c3dc77ab97mr13050687a12.7.1725920536454; 
 Mon, 09 Sep 2024 15:22:16 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd424dasm3501807a12.9.2024.09.09.15.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:22:15 -0700 (PDT)
Message-ID: <2a247cb4-2a57-40b5-a65a-b0766caa5c98@linaro.org>
Date: Tue, 10 Sep 2024 00:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] target/arm: Use tcg_gen_extract2_i64 for EXT
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909162240.647173-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 9/9/24 18:22, Richard Henderson wrote:
> The extract2 tcg op performs the same operation
> as the do_ext64 function.

I remember this one:
https://lore.kernel.org/qemu-devel/60f76a76-709a-4f32-974c-c771a724d443@linaro.org/

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)


