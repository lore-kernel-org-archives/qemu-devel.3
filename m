Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA729C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 22:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdFL6-0000pp-IN; Fri, 26 Jun 2026 18:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wdFL4-0000pO-KW
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 18:47:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wdFL3-0005dU-0s
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 18:47:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c825c88744so6789535ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782514075; x=1783118875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNoPrVlXgnvQFCCzTx9Vr2JquZWaWIwWXQPiTp4QFMs=;
 b=t+Bwq6FspOGbvVLHyyv/033QzVqYQqoirhg7enz6d3S8iMhIrBgSFCxvCc67LJsxJD
 1rf1CWvVHi7b86FMqV521doBTkCFnNxr+fV+olK/weMaIr7JMYeXPMWo//DcM4Uknn4z
 +ok3B6H6O0+3FtX3QNAFfFlOks6iU3u0/zk1YJ9nTECGy6dxK0w2eaGCnPaJU6isob1D
 UAEWPDn0Rcy59w+2zTOvOGTy87oDvg9eo8CejoUzMYlEkR9sVeZ4xsu5ag+gRaKflU6H
 Z+zWgQ5ORcn26aQYyjcPa1/agFS1WZlkk/M1+K4bKqFnzXJst1EI98nKQuBLDwgM9+lI
 TozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782514075; x=1783118875;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dNoPrVlXgnvQFCCzTx9Vr2JquZWaWIwWXQPiTp4QFMs=;
 b=lA1ldlzELlWU8HATt3/TBqUXoNjg7fSNoDoQXPracNB3qxVdnFq8RWkMXUP5PUAajr
 THSPtsO7YkGXM3b5xfcZ/hxxmOM+b+1TRM2ly/Lr6xzaGLpDbjWWMI84PIk3afbjzkN7
 M+7Agn4CoWq4OM6m5poqwzLyCmJe6kJMn1yaDrE/afSWu/0WT2GNO6JKJAQCxVkgFLw/
 1gU/pl/9A5wrhm3tz6yTsywysoAmlzbr2cwa7J2aLtqg0+koB+ILeshooKWxTCpdpxEt
 g0CDtoAgR8vdiyp68z5sDDTM+VXZbazN/2CQmG1YCu8NOMnPIj3QTmiVntT8xew/v5nO
 Pbpg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9UgOrjCocp3nxqe6hpL9pLBsho/ggIj6SMYKKP1AdAXMP+YRMisAiiBwaQM+X91rppKbUcK28Kr48@nongnu.org
X-Gm-Message-State: AOJu0Yy6WsRvmmNHidR3sg8O3SeBxQ9qsanhAKgnO34TL7luK+mp6DdK
 TUwToj8mJS75v7bGXZ+uSy6zG6D4v8k82MRYrwxmFgAH1U9JhCUhKS1XMZCLJiyXfPg=
X-Gm-Gg: AfdE7cmmp2IPLWwIXjfU+cd1Q3iD3vGVOlJEkYYVMJHJFqJld3shxGGJNcj2QyrTirA
 xd76HRofhT2clKf4CIKGmahXhGn4nCA6bw+GpafYmfP/mQQGHorcvAoqU/alJLPg7eb0Jq7tagb
 gQ5l3b/Bb850I8tpCwTOnfTQQCH5qVteTHzbJ9Q4yJPLyQokjT5ccCByYRuttWJdDQnWQTnX7lw
 39U6eNOdxOxZn9XR/1xyJRSUDmTFLYoNyT+r7yXAvL+pp3gxtmSdqssGCxsJQoSTM2IhkO5ajan
 V7eTg/g1XOoAnRuyoJHUIlm4Y8JyLhX3+C6TfBodOyKKYK11b8CdBoCkDe49mWgn/KPnbKURHE2
 SC5FPYEbU/aYAbi3wYjVh2OmbWs2kYnK+/TvyKUgPgDRdRbO66YHHfhzehpcK+pC08zjzXKCo0q
 FzGQEDFdpFAX9AiTI3Ux/hZwyYvTVnFebzv1kIw/MxOXIqlrpxBtP0o+fcxg==
X-Received: by 2002:a17:902:e890:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c7fc9ced36mr92404975ad.37.1782514074929; 
 Fri, 26 Jun 2026 15:47:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f6518bb1sm46555355ad.84.2026.06.26.15.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 15:47:54 -0700 (PDT)
Message-ID: <c25526b6-885f-4c13-b4e2-ef423d2feffe@linaro.org>
Date: Fri, 26 Jun 2026 15:47:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] disas/riscv: Fix 6-bit immediate extraction
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com>
 <20260626-b4-disas-xthead-fix-riscv-next-v1-2-74228a3c1b21@linux.alibaba.com>
 <1d9f53ca-4dbc-4d64-9811-17bf0328cb3a@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1d9f53ca-4dbc-4d64-9811-17bf0328cb3a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/26/26 13:04, Daniel Henrique Barboza wrote:
> 
> 
> On 6/26/2026 12:13 AM, TANG Tiancheng wrote:
>> rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
>> immediate field is encoded in bits 25:20. The old expression
>> left-shifted by 38 and then right-shifted by 60, so it kept only
>> bits 25:22.
>>
>> Shift right by 58 instead, keeping the existing extraction style while
>> retaining the full bits 25:20 field. This fixes the immediate printed
>> for th.srri and th.tst.
>>
>> Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
>> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
>>   disas/riscv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/disas/riscv.c b/disas/riscv.c
>> index 7f1b26277378c225c963d8f435cc7a2fc6e4a0b8..400a57083f90be18ccd12415797bce0df974784b 
>> 100644
>> --- a/disas/riscv.c
>> +++ b/disas/riscv.c
>> @@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
>>   static uint32_t operand_imm6(rv_inst inst)
>>   {
>> -    return (inst << 38) >> 60;
>> +    return (inst << 38) >> 58;
>>   }
>>   static uint32_t operand_imm2(rv_inst inst)
>>
> 
> 

Really, all of these should be using (s)extract32.


r~

