Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D223C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pxG-0001lE-Dh; Fri, 18 Apr 2025 13:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pxD-0001kk-GR
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:56:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pxB-0003bu-Uc
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:56:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so1756050b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744999000; x=1745603800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w8HeFz+4p4wizGEU7VZlex1k/mjfTN/Hf/zR6aUdrQo=;
 b=oTU2EY62ehAiKe3YXgp4LPDWzA9cC3bcgVEhGvjnTzCW2l4y0bFeLvH8vKU42jk81/
 LGCH+Hm6YAN5rmY1+tBPBfAgR5H8N1+9tyuooAHzJpHyXnj6J9jlt3iZYh8S5iUiKTb0
 3kPrxZSc6glEkcOz9EGPkQPMJ3b9oD4dndPMCDpDRpmkIOUU7ltUkfgLlJVfHxRfbSkp
 gbbjojf4p3VcIArc6T/zytbdQ4SToQrOCHkyno1jvLyR+Epu/ZQl+ElcEoafCSRP+/BD
 PEZkK07BlwJ+PIpjC/8dEzarzZBCFSzu9dHDPLunQ6IkIXSw9DmIowGLz/sYTzikkTBM
 CxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744999000; x=1745603800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w8HeFz+4p4wizGEU7VZlex1k/mjfTN/Hf/zR6aUdrQo=;
 b=SrKh/2Te+BLPhonRY+R9ZmLWmgouNmI1f9/y0ZcbCtp2jnmQVzQoySHiTuuePZOemX
 UNAK/1u1VJTPj9OR7UF3JsRBGcRxWbQ4YM92kzS18+O26h9JKRAv2+Ytq0aEbpshnwjb
 9f8wxZsaRl9aUbZ0uwxZFJOH7xEDTSIhP2YgIg0O0gYeM1Nw9y3kVZbhkSPBUgnxLNSb
 tJtp+PcKn9aR9E8xOc9+5lweN8+tAxMKJRzGccu7RP0K0qbLtuVAagZUunLGKVyCTzzk
 4WA+APTuiYYtqtEutj1WOeeP3LOiBDgzBCpECy1eDlM75xrsDX4Kjs66T++9sVWWoa49
 Rc2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXpizvs3fHWfGSP5v7PfeaXYRNs9lJpEx4sgQhWY/dTeOcJbF6JpExu1U8PSZGZ4SyV4Zjeqsky6RX@nongnu.org
X-Gm-Message-State: AOJu0YzbJGofrx+QDcPCPES0cO2vYhe4PvrPi6dm6tdpnpbn+YgCo/X1
 r5SL1PhsXLwOMyK5Uxkv7Xg13N37teXEaopavwnUSSbGsIuAyEevJb6hfU9YuqQczF3N9rpifoZ
 d
X-Gm-Gg: ASbGnctHIqq0fJVHeeMLYBWna2uOV9fPK7O9BdrTGEeGCURm9CnULSdmpmOwt9wCeuF
 mS8qLp0ml3OQDmsYS6GeUU3joX4pJrU1ylTKjGdSpFUGnfE/qROLTh4OmRvrLp0K8W88cEGiCHx
 81cWG6FecNGhXewMRp57gqwuBHxMNM2GAsbJbYrICK7HuHe3Kv0lzibT9DfZ8kcaUwbwic54fdi
 xfbqU9n2ffFFSfE5syLJtkNx31SZd9KM7g5LonO2sWxiYKeH7J3jwARA4iNVCJaDa7/rD5/olqb
 M9Lg8uVNo30g8gsxF0nG3zdu8OV92uoULk++ujbmpqjfjAaCpgF639NK/rFiRUuFSgi+yCu49I5
 Vw0dgG9IjhUm4ZKg/Zg==
X-Google-Smtp-Source: AGHT+IFs0tpq/3BKuSzmr9YFV4isLZt9MYn7tkDMSZmg40ChiyUAYZGm5kX4JOXhR6PElIlv0Sl3Lg==
X-Received: by 2002:a05:6a21:3389:b0:1f5:93b1:6a58 with SMTP id
 adf61e73a8af0-203cbc0a3c3mr5533286637.8.1744999000549; 
 Fri, 18 Apr 2025 10:56:40 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13ad7d5sm1677410a12.31.2025.04.18.10.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:56:40 -0700 (PDT)
Message-ID: <899a9aee-92b3-4cd3-b6b1-920da0c59580@linaro.org>
Date: Fri, 18 Apr 2025 10:56:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/xtensa: Evaluate TARGET_BIG_ENDIAN at compile
 time
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/17/25 06:10, Philippe Mathieu-Daudé wrote:
> Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
> time via #ifdef'ry, do it in C at compile time
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/xtensa/translate.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

