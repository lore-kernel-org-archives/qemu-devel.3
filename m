Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE07C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWh81-0002fq-Kd; Tue, 01 Jul 2025 15:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWh7z-0002fT-R8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 15:58:51 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWh7x-0005hG-Sn
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 15:58:51 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a43d327d6so1900704a34.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751399928; x=1752004728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aDuPHfRrOrczua9WxTSTfCuKO21PLpMF+C6cLzSWBlw=;
 b=e1AQ/s0kHdWoXk+ANzA1n3L458lMaAVldifGgm2Ighod/UL7NgmzApVrEX4XCMqtcl
 7qu/DIo5CBFvqJvaG5zOpCHuvv4Idwbw1hjrvjbaXXJS1/3ZpYoou7LSQv9Z1dc7V9K2
 2sECBcHUN75UyYlZ7WsAGTFmbcI1xWPWKmhWZSD62bmALmcRW0BtplVxiHnyz/fal0N1
 xVXeC+6D21C51C8ErMtsz2KlCL2MGHHxH6OGkyI+SktKhTfXjLh2oqEZQs583PgeYSLw
 wS+QtsJxaB/W42Ozf4PRuOXWN53NY/t+be0ndcy5PE4rPe245jqjsRgV5s0/w3SjalU6
 WZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751399928; x=1752004728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aDuPHfRrOrczua9WxTSTfCuKO21PLpMF+C6cLzSWBlw=;
 b=B2rmpsQhbP+pGkN5wYVUmO5zRH+4tWMpWNCPFCF4u7BuPuLXoaFeT290H3VC5M/ayT
 vqA0fJxekNfMNncNuTh5zhr1oHpvHWCimT0W/pCTfJUnbVJtYUoGjPv1PlE8spY8A3Yb
 Cn0ZfJmp3UySJ3IgXUPuQ3gKQ4Pfx+y0a5yMswSawemc9EAofYcmwzzh4+40kch0rYUE
 WVTMY9QEmFGtu6iOKs/TSA8aznhxhgBme1i4L1MuH/VbQ0CXPSlubrQHqJ68yQwsYQ1S
 eClBSBh5bjTbn0yLJmmNhqIZEBeKrO4WcnGWmWxPcvyhJxDG1xJ7pM5AzsmhTQ4+Urcj
 cjvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DSSa+g+svCAUuTislg3sBwRmFCFPgi1JQauVWXBBBF/8AsEmvaGZ7uzeNWHwCdFdsxAjJH3/PlTH@nongnu.org
X-Gm-Message-State: AOJu0YwTtO+hulUBzqVz/vApLvsR/hd69xDw+cyATMTvH1xsk6A1pOES
 H5vKBpdAIZKcboheKrMOtxQmvJd7Urq/joTgD7X+e7euuYm46JOIFIrGlv8CgGCiyt0=
X-Gm-Gg: ASbGnct3FdKojU2uf0wdoWmF/bWvrn4oQ70zn85/ynsVpq9y7D5TrtW2VKL/rb+KjvF
 eMvW67b6E4qjgIMWosx/DWEihp5Tj4oNpvCwnI4Zwg3IyeMfFNf42MtDsiKjgewmwdB1s38eegE
 Am1s4/ML/OWuLjiRjc9z1TZ/kZ5pzYl1g0C96WrWQ9Pjk6+2i874YQncFcPMoFWVGpZCO22uoJB
 avgAR9WvH01dNZCkLowA79VZmJjIHWzN27lf5aGp2z4gYQSacuSkgF3UzwN+MzbRYPwH/oylrmm
 uhH1opA4MrWKTttiDcpGfpbQrEuTWCmaecPf8y1g2Kf2e0TxYGivpgP8/NBt01WpBC8oMr0RoUX
 MXg==
X-Google-Smtp-Source: AGHT+IGexGhai9jBITFPKVQq2T7EQ2O38BGZQRI5VWCZ7N4sTy31ESfVsIsDFa2RrWEV7JoT61X5HQ==
X-Received: by 2002:a05:6830:8008:b0:738:67aa:b7c1 with SMTP id
 46e09a7af769-73b4d1f1e2dmr127739a34.23.1751399927547; 
 Tue, 01 Jul 2025 12:58:47 -0700 (PDT)
Received: from [10.25.7.201] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff249bsm2239689a34.6.2025.07.01.12.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 12:58:47 -0700 (PDT)
Message-ID: <f4d24737-87c7-4ebe-9bf8-3d5f314589f1@linaro.org>
Date: Tue, 1 Jul 2025 13:58:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 29/29] tcg: Fix constant propagation in tcg_reg_alloc_dup
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250630152855.148018-1-richard.henderson@linaro.org>
 <20250630152855.148018-30-richard.henderson@linaro.org>
 <584130b7-2583-44ce-8501-d5a73583e911@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <584130b7-2583-44ce-8501-d5a73583e911@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 7/1/25 13:04, Michael Tokarev wrote:
> On 30.06.2025 18:28, Richard Henderson wrote:
>> The scalar constant must be replicated for dup.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: bab1671f0fa ("tcg: Manually expand INDEX_op_dup_vec")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3002
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index d714ae2889..50d40b9cbe 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -5154,7 +5154,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
>>       if (its->val_type == TEMP_VAL_CONST) {
>>           /* Propagate constant via movi -> dupi.  */
>> -        tcg_target_ulong val = its->val;
>> +        tcg_target_ulong val = dup_const(vece, its->val);
>>           if (IS_DEAD_ARG(1)) {
>>               temp_dead(s, its);
>>           }
> 
> Hi Richard!
> 
> Does this apply to 7.2.x series, where temps had to be freed
> explicitly?

Yep.

r~

