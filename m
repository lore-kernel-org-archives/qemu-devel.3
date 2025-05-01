Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F106C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANSw-0006Lc-3x; Thu, 01 May 2025 02:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANSi-000634-PJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:32:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANSh-0000Pj-0S
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:32:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso686971b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746081117; x=1746685917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4BOCX4WtuynI+aMCRbKPKnlysGJlpgGvoJQHA63ob/E=;
 b=EJRRFjQDJ1b94bUP/neDMIIc7NOIo8Op1B5n+zhx3+4msovnvC1NjqFABvZMHnoTxE
 ZNJRI0FC4o/Y0KxzAgQKPbslb3OS5e1PMA/6O2di7yZXWlXs57lziDdFCXmbkVHEVM/s
 GRj37qgtTRq+NXwv2WFo2JRe4GZYo6+KSa0OGpD0w0hSKo9ZcKPuvYjE8041P3JHZACA
 G0Ma1ZyWnN56vVcgaUXZnQssJjAA8ppgTa8VVUi7WUSn4wx2/hMYkh7TAh1aNUgjIeZp
 h4dXS3/iC69D8sp2RI225mcf5uCAO3b/aZeO+WFqXHv61yzUkFDay3fAWrITl1DJkjfN
 rZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746081117; x=1746685917;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4BOCX4WtuynI+aMCRbKPKnlysGJlpgGvoJQHA63ob/E=;
 b=kaJFJThP2jGRFZgzcR/1Pl6lkKLj3kltwBpFFZFutI/rwvtPmm0XVGlVFsTLbdOCdv
 l8c4ou2Dlrhp69SLDv6RqD23qTxOn0gq5qboPutAzrDhch3UAIURbNX173Uk9Yo9d+9s
 GcHuWwc6hzanMLbrmPB6Y2RdxwLy8xp5U119CAiveVwMCC+nSSHVrv3d+WquTcw/wpY2
 zUl2O1bMjKJ8rEf0vMnS7DUQmQvT6W8d21rjdhPYwOMsAZRgeGWmaKP7f9qUA/fFWotA
 CrW3W+XN+M7LkADIVWqyyZ6ZP0tK7bnMJoXwStuBKfpZa3Nne8BH817iA9SZih9hD/5b
 JCdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEWzqTCgjQ3orlTkJPgz96JsyLaBdk8ZoIM3jiS3c7uQ0pkuMpUzSRrsxkqCsGFCXdhY++MWYSLcJi@nongnu.org
X-Gm-Message-State: AOJu0YxcbQd9pCAkwUZaJRG8LBPRwByNmBKJjfGuKhCwzosZrQdnpaeY
 KmZ4NlQRDorXnMrLRc4jjTea6jHgby7ER3yJQ6+Nb2j56NKIaxSyhXnQeaaf0Bk=
X-Gm-Gg: ASbGncsd4BrRhTYJKp+KRVDfaOKKlRvB1VMkSqGc0UWBAQ3pO09b1C+x5chzOixl6ry
 6aqf8QyjCUXix6ZLDmbQO3QRWat/nc8K51EANPpZQ2kHiZbv2AX8ntgt9IegwFQI8MGO3r7BBCi
 tpnESPokAF92TXGx9QOGTzXfZJ5nqpopAXAYj1OaDUmU90xPeFtc3tIbj0qUzMvPFMb65YkIRNT
 Rs+vGNbflCcnvwQHRxv8lGGFDCsmPpnbHKE+ShduecqcEOqdIxdUzwLtgtGmL7nSuppUX6/lpwZ
 VKbTMR7P8sSeIUfFErg0BT9MFMeYoeffIto+ofteRfW1bPCWF9N4uw==
X-Google-Smtp-Source: AGHT+IGgi4+zh0g3CSb/Rqz0429WGBGZRICyu0EMyIpedtlUFBR+4OTi1zQJNd8/1k5diiojPu5QvA==
X-Received: by 2002:a05:6a00:1747:b0:736:50d1:fc84 with SMTP id
 d2e1a72fcca58-7404792a753mr2650593b3a.21.1746081117008; 
 Wed, 30 Apr 2025 23:31:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb18b5sm139678b3a.11.2025.04.30.23.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 23:31:56 -0700 (PDT)
Message-ID: <195f877a-6d6b-4a6e-afeb-d97bdc1071f2@linaro.org>
Date: Wed, 30 Apr 2025 23:31:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] accel/tcg: Use target_long_bits() in translate-all.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430230631.2571291-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/30/25 4:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translate-all.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


