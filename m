Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5471C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHIO-0000AB-C9; Wed, 26 Aug 2026 13:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHIM-00009i-GP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:20:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHIK-0000ph-AL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:20:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e27035206so563513b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787764810; x=1788369610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YI1RurIb7zt7udyFkMZ2uWdFHv0rR3eUYNI6kf1ENLA=;
 b=yE++Suz0MP6VOd/TJLdPRj/dkUrKm6RwOehcyS/SUwkIr6SbvV3wuUMZTPw/Hr06bz
 tOROMU3xoD24QDZ4h4j6F3s9DlRaIT/Trzo1BZLzRSjJxvDr4udVnb8K7CpWcEhRhY4l
 jN5yuIP4OZh5YDPzFSz7aat7fw0embzOdFYVLEDCGU0W1F3JHpivLPgKf46e1yXCwjbj
 8t5N9IGXDG3R8PPBWgBFx7pU/SSwgXqWjGNQ/j87ROall7qfRcbL9YIPiNICmKHdtvqW
 HQa7oMuKj44EaDp1jvG00hwkIsRkUlbd77zF+q37DL9OV7uMlN+UD2kx6r00DVkxpk+o
 Z+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764810; x=1788369610;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YI1RurIb7zt7udyFkMZ2uWdFHv0rR3eUYNI6kf1ENLA=;
 b=TRYyLvwhfN+Sz9p68usK4Cdy3mjH4ypp1lPl3W5tQiNsnsq+N/V9duJIYMrpMHqzU4
 u0sxFOJYUqUKEac2NKn9PDwN3AyGvb1xWSl7JRLPAeuJ6sQIfmLyk4cx3uETHifkLXvJ
 fG1GRpXiG8P2tKhXEkb7xU6sfGTvO7/OdGVTmwufvyzLpGv6ODAE/MXJQ5e6VAYb20DF
 OqU97MIeVyIiVU2CptVT0cnW3wFE2x0JRSg/QwaNdJKUelGK/lqfg864n3yvOUUNmSgK
 NN/tfTBKW0l0KAYrTBXGVVK6nCvyLuXRV0PuZlCnoa77sGhnNGt2j9S09p3g2hfHelz/
 D+uw==
X-Gm-Message-State: AFuF++ngohG/9o5JiW3l1Ep77/RSJzhE+ZVnc/jcCpiAZaNhzXMORQfg
 k+NbDGwIfuoBD7/jjUs5X1dNKHEuOLaI9w2phgnRwpd9IugteBiMYrrQULlHu/jVWRM=
X-Gm-Gg: AR+sD10xHNNYFeYcjZoK4FJS1eolJscvwZiLkZfJ2PywhMefV03c/kGuueyUDZ9r7S4
 RSljbHWGCofDTziv3UzZMT3O3RpDvU+nTszS7sC5ZS5Rz3VAwCapYqSzzNSK98E7Z7Dj8cOQSZF
 wrbfcMmSBGMmKihuIJjLDD/QSuPrFdHy0+fH97SExZA6+R2x83mQxfNytaf0xuqQGADBIQq1B++
 OxyVL6u+isL1/YYctdD/Wd9QkyFRkE2Yt2pu64yhpjutypcUm/Dr55agGgw05CoNl1vn8gviILl
 I3BoBBjqVgBNv5Fluw51oGdpWq79Je56dB0sMTWd8ezNMUVro0eFs+Y92CuzWj+8jTwzHLDWHuk
 /2cQz6HKcJXvT1GA4k4F40kuvsIko3ma1bGYwhEZb3CrsNIwVWVYVGRaiIzIZxj6WdAnLUHtb/O
 ZlJrDT27NnD2UFE7mYRCdXXcmd5/Qlr2n2riIWeaVxXbVtNDFPwaIMV9I1V0DKuspkL7Rt9SWBK
 g5kmjXa33xsI/XjqDWU8+zRPCag
X-Received: by 2002:a05:6a00:21d2:b0:851:c1ba:7aa6 with SMTP id
 d2e1a72fcca58-85373eb1adcmr14519548b3a.11.1787764810238; 
 Wed, 26 Aug 2026 10:20:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf3e982sm1179357b3a.54.2026.08.26.10.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:20:09 -0700 (PDT)
Message-ID: <faecd78d-ae69-4207-95c1-53c3be483437@linaro.org>
Date: Wed, 26 Aug 2026 10:20:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: Replace straggling CS_ARCH_SYSZ
From: Richard Henderson <richard.henderson@linaro.org>
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824143033.306201-1-farman@linux.ibm.com>
 <684092af-4fc9-466b-a185-2ff4ddece732@linaro.org>
Content-Language: en-US
In-Reply-To: <684092af-4fc9-466b-a185-2ff4ddece732@linaro.org>
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

On 8/25/26 08:53, Richard Henderson wrote:
> On 8/24/26 07:30, Eric Farman wrote:
>> When updating to capstone v6, the define CS_ARCH_SYSZ was replaced
>> with CS_ARCH_SYSTEMZ, except here. On systems without capstone-devel
>> installed, this causes a compile error:
>>
>>    ../disas/disas-host.c: In function ‘initialize_debug_host’:
>>    ../disas/disas-host.c:78:24: error: ‘CS_ARCH_SYSZ’ undeclared 
>> (first use in this function); did you mean ‘CS_ARCH_SH’?
>>       78 |     s->info.cap_arch = CS_ARCH_SYSZ;
>>          |                        ^~~~~~~~~~~~
>>          |                        CS_ARCH_SH
>>    ../disas/disas-host.c:78:24: note: each undeclared identifier is 
>> reported only once for each function it appears in
>>
>> Rather than making capstone required, replace the constant
>> with the same one used elsewhere after that change.
>>
>> Fixes: c8220a096f ("target/s390x: Update capstone disassembly to v6")
>> Signed-off-by: Eric Farman<farman@linux.ibm.com>
>> ---
>>   disas/disas-host.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Whoops, sorry about that.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~


Queued.


r~


