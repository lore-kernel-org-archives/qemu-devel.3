Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C7D78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7AT-0007QJ-SX; Mon, 02 Dec 2024 09:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI7AR-0007Px-AT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:12:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI7AP-00062n-R3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:12:51 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385df8815fcso1840178f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733148768; x=1733753568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IvdTaGkelmY0IEVR7fsxRrmAClGwINqYQ/rxeg7ayYU=;
 b=u6OjmIzYL2lY5oWJRnd42OUS815IxrPpQ0LTlaLa7DgVTfm+EENjYaGDC04rP/hah9
 SNoYiWTVYgLQfDU4W7TVa1TODlxlxYCISbjmM34suqvHYa3COoqcCK+PHgdf/OlwqG3A
 X+5U1fLYX2W4dyLsOM/S1m74MceNmxQdPg/R2IhdHRWelAgqhxKdsdQrN1MK4kWRePti
 XGDsNOXbHqiGou/l/fOkoHZ8O6Y2zZU3m/3MKGX+wUSRtIsijZJTzN0PU6QyGsTCjFQY
 +es139z841U6Da1wtTkgI5QnJftuSWr6GR5X5rEOt6cxGi9xlJbQGY2RpTp2pMxdNEZK
 TDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148768; x=1733753568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IvdTaGkelmY0IEVR7fsxRrmAClGwINqYQ/rxeg7ayYU=;
 b=Kca6Uw4P+X196pCkeSOuwPoCq96bCOPiir/suOJuxn4uaPRmxjmw2Dcpp4bpQEVWor
 pAj5f90I0J/mn73VGeCt1Y2EJlnTn37Sl30/IUCB8X6/yh5IEQvw9h+GbRysnhDXcaPx
 yG9vn+oU/Nd2UnuxBloUwGouWuI7s4fS3Yc7eiRZ/0mSmosdfvdyRTOp0x//OKXTH1ZY
 aQrGDT/ltaM8+EhJjL639FbxGj2FrRiskrbYMkLUZYdK4ji38v69Yurx8m+VuVM5SMDO
 HnvzRKLR4s/9SjQYrc1/8m7CgQcMUw7lP5FyK3mvJ+uHGoqwx5PCJcDnrKfuvdHb8/Bc
 ky/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSk3oAjl3Vq0k/CtY4KWhspdf2Qmt3yqaV26hDdWNZrB4TQK/hTiMz6V1wh2kDhoabdWSmGqw79t1@nongnu.org
X-Gm-Message-State: AOJu0Yz1UidnLDzFQ4pIKHi6h3J/MeUxdDR6n6bWxIjp3Vwj5AXuxbPy
 1OJFAFtV1BM4eOdH0n6vpBdKQFV2QVLRsat0O+XSb/D/UjTyBymIBXXfDEeRAr0=
X-Gm-Gg: ASbGncvKnw0jBUWnc3KZWDJ7V30Xh//TktMGYqKdxGHMg+QLinCRb0oRz4O3DbKaSGD
 qZ1WX0/vRxuYf6uT/xf6ZcYvPpRzZbzLqeMJKq+NpaIXl/7/ZixPg9O5xSyl6YxUCrs6riWSBD8
 VHWPuTaEFepbm9804q3jPcuueK21jLPR46PcVmO+Wf+3b8mLf8DeyiGzWvQFWRsNDsmN9+r7FcB
 Jd39OnuXDcIR6+OwnLHz+r2q0o3mwm6DnILtGeDMuuNhzjO9fL9ZIjyz0xCkplgyGisRiklMODi
 cIQf11KIIsTqnoHtLRFI+d7OyF/ikA==
X-Google-Smtp-Source: AGHT+IGkLFRgn5S57ug2NpKdbC1TVh8IaWVBQQo/ingtKmOkji3/1ykoAbISPv3kBGlyiYijDBYLHw==
X-Received: by 2002:a5d:6d86:0:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-385f69a81c2mr2240001f8f.38.1733148766652; 
 Mon, 02 Dec 2024 06:12:46 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dc169d79sm10717623f8f.92.2024.12.02.06.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 06:12:45 -0800 (PST)
Message-ID: <c808724c-8024-4c65-9c15-0f6a733a4319@linaro.org>
Date: Mon, 2 Dec 2024 15:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/67] target/arm: Use ### to separate 3rd-level sections
 in a64.decode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> We already use ### for 4.1.92 Data Processing (immediate),
> but not the two following two third-level sections:
> 4.1.93 Branches, and 4.1.94 Loads and stores.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/a64.decode | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 331a8e180c..197437ba8e 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -161,7 +161,7 @@ UBFM            . 10 100110 . ...... ...... ..... ..... @bitfield_32
>   EXTR            1 00 100111 1 0 rm:5 imm:6 rn:5 rd:5     &extract sf=1
>   EXTR            0 00 100111 0 0 rm:5 0 imm:5 rn:5 rd:5   &extract sf=0
>   
> -# Branches
> +### Branches
>   
>   %imm26   0:s26 !function=times_4
>   @branch         . ..... .......................... &i imm=%imm26
> @@ -291,7 +291,7 @@ HLT             1101 0100 010 ................ 000 00 @i16
>   # DCPS2         1101 0100 101 ................ 000 10 @i16
>   # DCPS3         1101 0100 101 ................ 000 11 @i16
>   
> -# Loads and stores
> +### Loads and stores
>   
>   &stxr           rn rt rt2 rs sz lasr
>   &stlr           rn rt sz lasr

I'd include in this patch (from next one):

+### Data Processing (register)
+
+# Data Processing (2-source)
+# Data Processing (1-source)
+# Logical (shifted reg)
+# Add/subtract (shifted reg)
+# Add/subtract (extended reg)
+# Add/subtract (carry)
+# Rotate right into flags
+# Evaluate into flags
+# Conditional compare (regster)
+# Conditional compare (immediate)
+# Conditional select
+# Data Processing (3-source)

Because it looks (to me) out of context in in the next one.
Anyway,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


