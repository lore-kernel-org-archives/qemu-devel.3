Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDA8C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhazM-0000LY-Mi; Thu, 31 Jul 2025 17:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhalu-0002dw-Rm
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:25:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhalq-00070h-Bd
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:25:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so127895b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997093; x=1754601893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Suv6Uzvt+6KqjJHdtQGzIvFcCvmXjx4lEi0/gTE00+g=;
 b=OBbBPHCEGEeazUi+ytrHdhm3jwWmLdZ8+8UBvnUVm3vSCHxA+yvgxPXITVMTKGIEMl
 HjRQ+5s1lgXwh4+5gLUkJ9spNGt6UIRMEvFmvqdxB+eke8FN11pOxct0sz8k+IhNzhEu
 3yjb42y8FjMtjAn7gjECHy5V3Djh/ZDtaFbPYV2IUaGJeTryUWSPgdO1pYGAvKHX44HM
 Bv8x0TwQlYPv2QEx9zrNebJjHi+so4Z5Rifu4x+bBDRYJTMQAqbizeVOWnZsftgyTBaO
 bQWCA4E4lwILPSLy85V2CVHSlphNi0bDt3g2lF4HukNW1nbxbflY7u3knrZ2k8BmLJ6r
 TOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997093; x=1754601893;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Suv6Uzvt+6KqjJHdtQGzIvFcCvmXjx4lEi0/gTE00+g=;
 b=mkyOzfSTjCPaC8RREFtNiVT87Y7OuiaNC6OWFU9bB58u9cMy7Mr2FThc+mi1Kp8mub
 f7M4yTfLo1uoqLa9REy8nzes444+Z6D5fHY+Ic6ISp5CjIQWapGBUXOg/dE2pLRpnsCB
 k4WDKT1Euielv0IFSmML0xhHm5U/teVO/eF0eBDm2KjSWenlRIiHmJ4zXqW4y1egJ/6k
 i70sPLtj/xCfHG8AXqhiGwTvieVL2G2QD3QThAneMzK9B3PiAV7Df10HV+LybbTXy/yc
 H/cBbcTvOQQ9+bS4atCMRVYa3n7O4jGuaZGvO5FwZb7sfp6sidorAjKWD3bUotN229gg
 f6lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDN+tKJnPS+5JGjHe9QeP4eISWNk5pYomBOLbUi0TAupMY4pd5w9bQ/AOFBL2nI7mg7WMD/9FFocAs@nongnu.org
X-Gm-Message-State: AOJu0Yw90wGtMBxFSjIE7TUGdgAJEplSE9/5cyLgZiJOhyvuL5PKSvu6
 m7LQzfQZybo0kSxC7ZtHgAlHkv+/Cau4zzLNIMGgAZJl8pfSQbmABXxdpeFUXR/3D4M=
X-Gm-Gg: ASbGncuF9TvEZnhu1AObQt8ET8HGQsgDFigvu043gYSKaGx0w0oJPL5oLpb2dvexvQA
 iR7yCecEXb32psBWM9AFu9SGilXunTscv2nHnO2QTxvFe7yBAARZiSzvWlliBAOrmapluPZ5rKt
 3GDscKy4QbcSzoj++TA7+TWdnyCOhQV6PbV937f3AkV+2Cq4CSdW3VNkqD1zjKPLR5CL/R02bk+
 tEYMAoXnhZidvrzgq/oKUxqVDN/s+xUqoEhw8HViLgzImNKRRhvUgTfdBkOopO13jooLc9KN/TS
 JZOyhwLaVVxg+jfh9qBzD5k+OzMyY7lPDKoYNKftA0/X+IZxP/cxv/Vu9/JJfmHClVbnNVxX/Vc
 BMba1hOMnyWrwkGusUieBzLdBrqvPCDDJ8M4=
X-Google-Smtp-Source: AGHT+IHwgBiHDB9tLO3aFYxd9+BXzRTGfbM773O6s/OK+tSo7qzSnpTq5IPYo4jHueFpeUbmto7WoQ==
X-Received: by 2002:a05:6a20:734b:b0:232:a762:def with SMTP id
 adf61e73a8af0-23dc0e585c5mr14713607637.30.1753997092740; 
 Thu, 31 Jul 2025 14:24:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b7b9377sm2261626a12.16.2025.07.31.14.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:24:52 -0700 (PDT)
Message-ID: <a8cab893-4859-483a-9b63-e42992ab0c0c@linaro.org>
Date: Thu, 31 Jul 2025 14:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/82] target/arm: Split {arm,core}_user_mem_index
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-51-richard.henderson@linaro.org>
 <7ffd2eeb-ae68-43a7-a45a-ec05ece0b71b@linaro.org>
In-Reply-To: <7ffd2eeb-ae68-43a7-a45a-ec05ece0b71b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/31/25 2:06 PM, Pierrick Bouvier wrote:
> On 7/27/25 1:02 AM, Richard Henderson wrote:
>> Separate current to unpriv and arm to core mmu conversions
>> into two separate functions.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>    target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
>>    1 file changed, 15 insertions(+), 9 deletions(-)
> 
> If I followed correctly, we replaced all calls to get_a64_user_mem_index
> by core_user_mem_index. Thus, why not rename directly the function
> get_a64_user_mem_index in core_user_mem_index?
> 

Patch 54 uses arm_user_mem_index.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 


