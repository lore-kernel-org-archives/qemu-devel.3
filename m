Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F237C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WdY-0007e8-6K; Mon, 28 Apr 2025 18:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9WdS-0007cI-1C
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:07:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9WdP-0007QE-4J
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:07:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c3407a87aso79155195ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745878049; x=1746482849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PAhZ4VeefkdK+6x6fna4wXiqVEHI7f+eeYeY3Peg70Q=;
 b=wyGgiFPH7NRB7Eu1mGeWOxDZegm2R1QX38laYZW1OExC8JBT8D4tobzP2ih2fbEn7c
 +23NG8gB03Qy0OUuVhnDoIyiRuEEXM/5WKrXWqGzEubTDpJmMRiIPyXMbWvJXDEiWo38
 HgKHYgtQUhcDnW1kfL1tyYb/q45NbRpZ1x7I7G5qav5NUQPQmtI4/bI5Ro7GsdjJ5efZ
 AYBThDFYI1gLpTPkUOdlCT7/h2NGB4ZO7qOQr8pUBti6Af/XZMxp8KBtkDnnuullvBd2
 xf/RWXPbkXBS2cMpk2uJPG6bFlFENyhIRErLpsfn0os/6F6UZNMBwg/gzN5buOFSJrnh
 L1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745878049; x=1746482849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAhZ4VeefkdK+6x6fna4wXiqVEHI7f+eeYeY3Peg70Q=;
 b=FO5jOevhhoGr9vSVuLZaKjF+UPO3bZ+9SvqWNnwpVdH/cheuccCuBbza44dtt9uDcK
 HhHU0HMWn3dx2ssLmg/zx+RaOmvWTCDlPANcyujCmDZ3vCRBbpw1kyYoiSxMBF0x8hCe
 WW32nv/NyA8VmBSogAUj0yUVSANplbP5j5uw7W1StpPEbsSIX1CrHoc4apG1mcklu71o
 lMxPW9mooIIUY8awAVjM4tDwQrDVpJ9KO159X4wCVX8hGNCJo3LJlMMc+SASHYN56GHz
 +CPixzB/YWF+aEduN5/IJKn46lsOYDhhQy64dbrIDv+1aQ9tRfEMjDbSDdQt4g1rtHrP
 xdwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdq/9kQATjyXk60wByFKXJ0W1e0twFijYL0gZwmkTW1/6EerXxcmBSeGo8XOK/4Aiaye7ZNrjmJ7PT@nongnu.org
X-Gm-Message-State: AOJu0Yz1Ro+WZaDJtUpT4pnbP4CQOo1/nVjW/h+6IOH6t+12+W1GUB+h
 WJo6QkooalMGsvCiyybt1JOolTXADDRskBLsrNSZ1928bxu5G+wDHcLIephjO4s=
X-Gm-Gg: ASbGncugmEk2gXK2vdyzPkjqfdCERARf+YCEnSStPHjEPKMSnYNLjmkMXEQL5HNekQG
 sABC2r//x7/ZkZoEx5kzGH2Ex9JyrXmiK9sLze0kthEzAyECkluJm3ZcCqZeierZKuFLTBfkjFO
 LY83lMb/fiRxdnzRhoMBZoYJST4CWoUKSB3DENeK8OuZr0roNp4uG6z5OSdkviEPvEWFBR8528B
 epP66YijIWSzTvFatE90vMIqzM4JYGf1JsjulPShNoZNcHG8yDNvSQhf+Os+NSDEaVGw49IFbYi
 Oe3Uh5J4QSYp2wIrQU79VIjGIk6dBmk1wDeJ1agMXzTA/84dIXdGd8thiBLcQK9CTeOUpkSDqXu
 LgprsgkM=
X-Google-Smtp-Source: AGHT+IEgRl85lWlL801pX1uoC8K38ulWLe7OM8X0bhPE/8mZN3JIozB7ndjajHO1bV14gjckScpgQA==
X-Received: by 2002:a17:903:1c7:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22de6059383mr17524525ad.39.1745878049274; 
 Mon, 28 Apr 2025 15:07:29 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5100aa7sm88101595ad.161.2025.04.28.15.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 15:07:28 -0700 (PDT)
Message-ID: <31ec7f6c-e5fe-401e-96f4-74bc7b0dee36@linaro.org>
Date: Mon, 28 Apr 2025 15:07:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-8-richard.henderson@linaro.org>
 <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/28/25 15:00, Pierrick Bouvier wrote:
> On 4/28/25 1:10 PM, Richard Henderson wrote:
>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>> index f5e5746976..8dbe79ea7c 100644
>> --- a/include/accel/tcg/cpu-ops.h
>> +++ b/include/accel/tcg/cpu-ops.h
>> @@ -18,8 +18,13 @@
>>   #include "exec/vaddr.h"
>>   #include "tcg/tcg-mo.h"
>> -void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
>> -                          uint64_t *cs_base, uint32_t *flags);
>> +struct TCGTBCPUState {
>> +    vaddr pc;
>> +    uint32_t flags;
>> +    uint64_t flags2;
> 
> Could it be named cs_base instead?
> flags2 is a little bit generic.

Of course flags2 is generic -- it's only cs_base for x86.


r~

