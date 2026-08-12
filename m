Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37F7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9RT-0005gE-Gb; Wed, 12 Aug 2026 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wu9RQ-0005dq-4G
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:56:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wu9RM-0000sy-IT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:56:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1522022b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786542978; x=1787147778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DJuHDWOagMs9ZfLtuuQKvgPLq/WyXyp5HlKuS5YzHis=;
 b=CpNWG8t+4wW9Bw2GE3ujyv0pgWJrpXjrL9xxyxUM0WZEQiuOlUuj3mom7hrb+HQnou
 QjqVfBm+stpLGRMcl+bh4YDzCzNt0EoAgekQh++yJxNBktrvpVe2FPpchHD67DFjASXx
 /btgEPAo05GmcNCIVLKdJ1tap9bdCsVYCYxueS2w9HcyrCWA7C8S0vthiSOTeFOg+SND
 s0ccPOe/V0UUq9vtCdjSkxM46n+E/sdl50ZwgbBSK729pjIO6bOudC8MRfEw3a64mHr0
 SJaufnTyZCMrgKqf9LpL7Ib83GGjCoNz2pvJh186nvdZzXSPz8rt3iPqBYL8m/QE97yU
 Z1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786542978; x=1787147778;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DJuHDWOagMs9ZfLtuuQKvgPLq/WyXyp5HlKuS5YzHis=;
 b=Fb4j/l4LfCO50AOr0MVt1497n6fyENBNaudb5OgwVJp1kCQIQgA92G7THNPte3tSIU
 5b53RxZEmNQgIE4q91KVRV7XxIJknLY25AbsOa4kI45s6XmY5L7jYO3ifSxRJ8jv2FKb
 kvq179CUZYG5lbC16ttXsUC//V42SVWc978Xz8Oq1+VUwwGSGWAk6wS+kmoRQGZ4jpLc
 9quj7tu3NvoDfgT4d5pQ16YN4mV0Gdiq4Py+EtndH7TPfU6lPNq7IgATyNzzyMN0L5l4
 G38K09ZB5TFjh0rQGgOy9qHsHHM1ybyGLjASxugSOfrILEfLUw2lxuM0XyCOzWAE3CK5
 Bt6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rremx+rzRTI8wMMRClGFXig3GhuVP5G+ngyeWe0NubRaw91DuWgDYS4TWBMKW1yZ85v9zC7CfMdsE6z@nongnu.org
X-Gm-Message-State: AOJu0YyzUvFcnL3NeRJS7Lm4vyrz42SO6TI2HGJOLdlKSd+SLDq6yUAG
 6nsxGmm67UgHZueT9BLGzxoZyBbe4MsOYTbDIALAI2TmNFI+sWHpyH/7OFt6tlJ4Pb7lmAwJ0Ti
 FvTtW
X-Gm-Gg: AR+sD10J/0PkNtZCFvJ1bUepuYMFgLGJ7FVINdwPbpwF6KraAg3ZUa4bYGQ9a3qG6Ta
 DVU0jn16ghuwvThejW3VqYuS5b3RZQ0rSnVelg5LbCTFXByoT+t8D1+B//zLB/2Odeen/8/z90O
 6Hy94isE77onINZ7T9FOGX8xvngADCS7dtuc171tO/zAVkiAMEXBGeJ93dTPg3V6z/wzpMhMcWJ
 gljRRcFZY6b441Ytqn7YEMmONLsIOTJKhRKE6CADzZP6E+i4YmnbsIrZBFbSHgyr08pQP9HMwjN
 tE16MrC6ugwrxp+yzPajkkfX3uZPrw0zoZwi18Z3qre+8zuVoVvu9pz4MZkecIvKB/a6oexc9Po
 1mO+kAJlgoIH0kUwhTdxbVgWoXvqykGDee/5R7CDOCxpoEgzrSMeJCLgzOxY1BKqdburusHW2f6
 8hZdRroA0ui5LFuQt/rVuMDEuXpJLeNHokEXNHw5J7NBUTgeOiN6kQz+7grTVcnB/B/6G6gJK+T
 aHhXaOAgIvN8oA92/9W7JcJGp2w
X-Received: by 2002:a05:6a00:6ca7:b0:845:cf86:9469 with SMTP id
 d2e1a72fcca58-84fb5543ef4mr5610765b3a.29.1786542977996; 
 Wed, 12 Aug 2026 06:56:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1d1ff99sm1136654b3a.13.2026.08.12.06.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 06:56:17 -0700 (PDT)
Message-ID: <dd63055d-0770-4dcb-86f4-ce61ba864681@linaro.org>
Date: Wed, 12 Aug 2026 06:56:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] util/cpuinfo-aarch64: Detect FEAT_CSSC
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-4-richard.henderson@linaro.org>
 <8dcd5fde-7d99-441a-86c2-5e293d474e23@comstyle.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8dcd5fde-7d99-441a-86c2-5e293d474e23@comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/11/26 20:35, Brad Smith wrote:
>> @@ -101,6 +103,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>>           }
>>       }
>> +    mib[0] = CTL_MACHDEP;
>> +    mib[1] = CPU_ID_AA64ISAR2;
>> +    len = sizeof(isar2);
>> +    if (sysctl(mib, 2, &isar2, &len, NULL, 0) != -1) {
>> +        if (ID_AA64ISAR2_CSSC(isar2) >= ID_AA64ISAR2_CSSC_IMPL) {
>> +            info |= CPUINFO_CSSC;
>> +        }
>> +    }
>> +
>>       mib[0] = CTL_MACHDEP;
>>       mib[1] = CPU_ID_AA64PFR1;
>>       len = sizeof(pfr1);
> 
> You can remove the bottom chunk. Any OpenBSD release that has the ID_AA64ISAR2_CSSC
> and ID_AA64ISAR2_CSSC_IMPL constants is also covered by elf_aux_info() which is the
> first chunk.

Right-o.  Thanks!

r~

