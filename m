Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F0AEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so28s-0006wP-4O; Tue, 10 Sep 2024 10:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so28o-0006kH-3n
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:46:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so28l-000300-Fc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:46:49 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d88c5d76eeso3634167a91.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979606; x=1726584406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jA4hGoOryKawSsl9YEqZ2VbZcmPiA2b8I2q5KaEUGFQ=;
 b=IN4PfLwWFNPOgaVonKBzmvVBdwI5brrU62EJ1fffRmchjylbo6Gy4vR0ZHwPtAx/IK
 2nPKHDz/SOGL+aI6agUPva0T5C9vmeYJap3+wDf2Pc+5iSAGsVXk57ka+xpvk7L1ePay
 f/UoTq+G1sfG8QwbqFddDj9ncW6M0i4KO3eYMpakNp7x6qMqTi1ULIFWu4Lc+VN/Ey9A
 DrG4hbLyQnUEv0v3qBJ/tsjSVtxS44xHj/fImW/hhHKq4EumGSvMLC1dMI0n/OUJSsvF
 wm3hOXcdAHiiqP1FE1xRdtuJ1xjzrwBGzsy/h653UY7miBfANUXtK6pWO5dVedzt++db
 8YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979606; x=1726584406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jA4hGoOryKawSsl9YEqZ2VbZcmPiA2b8I2q5KaEUGFQ=;
 b=UFzPbT6K9GnRtkjRrTrMHdsK6jPXMrDb/pKLlDCXYu3XDCIvNfTI9EPPuI07Vu/Mq+
 h8iJuJUaKWaMlbsod12Dsi4oaKOBwHsxX4pV+QXPe0GE677lTeF0asZLf3a7CbjoEtIu
 1MCTuIMH2bKjP5HtR/zsltNZB1HQjh4fUYA/WJgIMTKqGDf/VWY88ACBHsc0aHbH+2s0
 mzA6FpodQfCU+xUyuc5hMXUcpQZ37lWvBX+h/k098L01ODDGoREY2sT+37cFVBX8mZwB
 KTwLlD6psSUB+vf5tByFsPloDwRzhw1YG/eiPlniyPDNro08a2K9IBg2vQVoQfvQ4LjM
 YTLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgrFPZKZIrldEXtb0ooDZqF0FyZKtINEVlagVOJqZ9K4/+hQTNDNTAtCsQJItnc70bSF8Or/RCBnDC@nongnu.org
X-Gm-Message-State: AOJu0YwE0K2CqYqllyJjdh5y3WihjBrBIzy2+s5NQTfmwo6C7wwhOHrd
 qcFtSeEVws5UZo/DIoKlru/BMeVNMeS28ypeIay3VjBHCaUd3kLjeTr0rKYX3Vm6ljQg0d34NDf
 i
X-Google-Smtp-Source: AGHT+IGM0riEyd4HOXpO4q0zUHKEBgzYvvjKRYYvehfd7i0FMebjetAp3lN25spbukRQfHA4JTDltg==
X-Received: by 2002:a17:90b:390f:b0:2d8:94f1:b572 with SMTP id
 98e67ed59e1d1-2dad505d285mr14076296a91.18.1725979605793; 
 Tue, 10 Sep 2024 07:46:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc12a1cesm8575689a91.56.2024.09.10.07.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:46:45 -0700 (PDT)
Message-ID: <c3c21cac-2a8b-4890-9db6-98947eb2d034@linaro.org>
Date: Tue, 10 Sep 2024 07:46:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tcg: Fix iteration step in 32-bit gvec operation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com, qemu-stable@nongnu.org
References: <20240908022632.459477-1-richard.henderson@linaro.org>
 <20240908022632.459477-2-richard.henderson@linaro.org>
 <a831998e-0845-4270-8f76-811c8eec2c4c@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a831998e-0845-4270-8f76-811c8eec2c4c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 9/9/24 23:57, Philippe Mathieu-Daudé wrote:
> On 8/9/24 04:26, Richard Henderson wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> The loop in the 32-bit case of the vector compare operation
>> was incorrectly incrementing by 8 bytes per iteration instead
>> of 4 bytes. This caused the function to process only half of
>> the intended elements.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 9622c697d1 (tcg: Add gvec compare with immediate and scalar operand)
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20240904142739.854-2-zhiwei_liu@linux.alibaba.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg-op-gvec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
>> index 0308732d9b..78ee1ced80 100644
>> --- a/tcg/tcg-op-gvec.c
>> +++ b/tcg/tcg-op-gvec.c
>> @@ -3939,7 +3939,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
>>           uint32_t i;
>>           tcg_gen_extrl_i64_i32(t1, c);
>> -        for (i = 0; i < oprsz; i += 8) {
>> +        for (i = 0; i < oprsz; i += 4) {
> 
> Maybe using memop_size(vece) would have been safer to avoid copy/paste bugs?

No, vece can be smaller than 4 here.

r~

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>               tcg_gen_ld_i32(t0, tcg_env, aofs + i);
>>               tcg_gen_negsetcond_i32(cond, t0, t0, t1);
>>               tcg_gen_st_i32(t0, tcg_env, dofs + i);
> 


