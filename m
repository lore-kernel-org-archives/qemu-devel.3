Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C042E77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 17:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKLR8-0004Rf-F3; Sun, 08 Dec 2024 12:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKLR6-0004RH-Bv
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 12:51:16 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKLR4-000136-N1
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 12:51:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1834379f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733680272; x=1734285072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=71d1mY10sg/LRTcH6FrFAgM2tie7gD68/ik9cYyA/8g=;
 b=F4iIvBNd3GnHPiYYbaoN4jc/hJRdlb6cCN7i03VhWc9YWStcKBHtWCOsfx/miXmumT
 YYp1/pOakdLYO8XAziV5oPo4I/zAFQO9OB9wJTXcpFsE+1QhtasCIlsN9dckuLcGF37K
 ezdUAjkuInbm4z4FPUckBY1nMKkWuzvNSA46AAzBKsbMMwqyrn1c0AQyfGMnRIlV92yp
 OPt7NKkoaO3fIxZEzB0LcdEIbQ2UDtESWGJX8jsxo7azOIW4OA/0UNX+cVloBltA0rbl
 nlCCCUNhuir9k5vP9M+EByP5K5qKwXCnr3ptTiRgGn67P196KIf/xEvk5ixrb7/HsTf8
 3nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733680272; x=1734285072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71d1mY10sg/LRTcH6FrFAgM2tie7gD68/ik9cYyA/8g=;
 b=EHBkvBGLldG8lT6rWoEYjRxG/C+wQOZA4MaJ17ubPvqWRipF8n1xxSWVu8epdBqt2d
 vTdK5bWmackf4N2MJ51dSuBX6uSMKCKM+y961PS6f76Ll59wMkpn9A2YXGatoTf7hpqS
 ymreOoAs0Z8SQ7k4qE+XS1zxmdA2Hm7ZZeKse0KFDcqU0ZH1UfHC7j1B9PJYvufbXZEY
 7J0smajODT88t8AglttlhYDshh2dQCTdlR90BRJ05PUzuZMsuOoMzAcl9R91L5m08D8T
 aPHQdZDH2Mw1m4Y1V48urSSGo6VysoIUOW5k++zE4pEtgeCtWlAzgam6PrupA2Rf1ZsO
 u2MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRliBcW0JyvvMejXfaySwAo8j55NvYuiVG+4jQzTkbZ5qfqR5wh9BykY7JIHTfBKg/Ol2cHZgExzcx@nongnu.org
X-Gm-Message-State: AOJu0YxpcO1PRW/K2M8I5WTbdj51BMeJ3VCAKZ54KtttIinMDClVr2qh
 KTiXf9QRVk8WwkjF0hoFXlZbm824uYgWbiWaJ/FgVWgJ1j0LFkh89jqFzJ44Fb8=
X-Gm-Gg: ASbGncu5U36inlucFi7B4AAkE6A7CwHlcxctzRBgwbP79qzjtpuh6knzgDrPBnQ6XMx
 K5K2XbbRd3sp/l8N7QXMGVcTE4I2VI3FDosIoW4bURELkGZv93F1s1Gtd+Ot7Uz6VE+afvxsclN
 RNQPjvQRLCoySKGdgDXC+cz0wB4TlJ1288I86rFRSApfbejqNfGtyN26FBaP2dgfadunNaQOjP2
 AOBhAE91WRdLtWpXO6PDZgK5GXWZluGBcH5y4o2d0/jmGINWt1K0pMfRWtugD4Od0N2axjHRbSk
 U5tMOBC6FGCtk5FVhlSHr2+DDf4KjdID
X-Google-Smtp-Source: AGHT+IE7T0xgRofUmq2PNTXu28mU9daxrqRsK3NjneeoAHasbzLkOVcmAaPxYUziD4+kaoIFfIBthQ==
X-Received: by 2002:a5d:64ec:0:b0:386:1ab1:ee34 with SMTP id
 ffacd0b85a97d-3862b3351b4mr7488642f8f.9.1733680272310; 
 Sun, 08 Dec 2024 09:51:12 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219095d3sm10764636f8f.71.2024.12.08.09.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 09:51:11 -0800 (PST)
Message-ID: <9dfada41-b04b-40e5-9c9b-0e35b860e507@linaro.org>
Date: Sun, 8 Dec 2024 18:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/arm: Introduce fpst alias for helper.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-2-richard.henderson@linaro.org>
 <79b8fdc6-bbae-4068-ab29-08e32cfcc058@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <79b8fdc6-bbae-4068-ab29-08e32cfcc058@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 7/12/24 22:56, Richard Henderson wrote:
> On 12/5/24 21:12, Richard Henderson wrote:
>> This allows us to declare that the helper requires
>> a float_status pointer and not a generic void pointer.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/helper.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/arm/helper.h b/target/arm/helper.h
>> index 9919b1367b..cb722c491b 100644
>> --- a/target/arm/helper.h
>> +++ b/target/arm/helper.h
>> @@ -1,3 +1,7 @@
>> +#define dh_alias_fpst ptr
>> +#define dh_ctype_fpst float_status *
>> +#define dh_typecode_fpst dh_typecode_ptr
>> +
>>   DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
>>   DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
> 
> This should go into include/exec/helper-head.h for use by all targets.

Oh, indeed. R-b stands.

