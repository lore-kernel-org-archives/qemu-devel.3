Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FEACD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZC7h-00014k-UW; Mon, 15 Jun 2026 14:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZC7c-00014Y-Lm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:33:22 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZC7Z-0001B6-Bp
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:33:18 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36b900f350fso3365841a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781548396; x=1782153196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PA/2tGdrns4nOu24xttae4aE1Nq5sxLr6EQnlFU0fv8=;
 b=ZTHYUbLnY3USIY3m/RtzaZBBOEAtga/cnP5yeK+yD5v4O7uf3aKfqEeaaMiDCHPjQM
 O3hIIcRGCWGoZx7eSChzpmunueZJbpgjyN3A6FC3ds5HnXr0pM3DI4pM6X+zkztFkffv
 TXg26lwphgful8WTtX/ywu/60si0QWmsgjJ+UfQ/ZLJ29D0+kxruAdgRrXJOPuMphpJ7
 KF7N2Xbxd9KwEMxnzlnipmZYI1qIiTY94c0S6ToJQmbvygSm4GY+S8AaQ63smQ1rOiKO
 +1UcABpZEiOqFv7TOaIqCtsddB4MLWlZwrbz4BwVphQmo8EpqRBunoctJb0SzHGn+mnQ
 WL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548396; x=1782153196;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PA/2tGdrns4nOu24xttae4aE1Nq5sxLr6EQnlFU0fv8=;
 b=gvf+PpcUBU58BH/LINjzxcDZw1+m9xOt+PrHfUXKv1S2Yl0NqZqfzrtzfHmyS+etSV
 3NDarbqQTv0ZuE0ZXtg6CbIiGCjgOd4xoveCDS6YFwi50Ck39h7D46efeq7TGChcolh+
 EuCtz1Ve2NtYSC1Rp4Ns5vOA3k92a/OB+RN0yjorEoIFcDIn/8hyxHB4Umv47IZecx6p
 R1JiJ1GfpwOKW/bMlvKHevo1q45S0eCnMkRfUeDuNYDjlTqtoAy776RUkXaKvABBy+IN
 Mv8d/lehSpym4MCAlPq+/1t1PvfOI0zACH1blAoqGCHr7CiACknxgcH9vwAu3x8dBjQu
 yTPQ==
X-Gm-Message-State: AOJu0Yy4UXLAhy5+jslq6uRBIUuvgm/ZMO7eGaGaRPZEkBYKfQNu4fgs
 uzHskB5N3YKXXk3HY/tLyJueiQo6VWYjPoO1K0lZoo6dehxohWvq1fIvQYOJz7SFBRI=
X-Gm-Gg: Acq92OHE9Xf1E7KlleZ+3fQDKcbazUKJTn3NFKmjvvP2g//dX2GNFlYd/6/SL/AquI1
 XToKDWCWcR74qFFa1jaEW0hhaboU+scR2+73wtIzdtve4idXUTP85mlQt5iWjyD8FYS1dnbj/QR
 WFPbgk3J6RHPkCJtTwRpgctelQ9ZP1kOAiL3muiROSwOpMSAr0/x4PPedQLHLEwcUYoaXO8iZ6V
 rJrBQ0C0p4wWzUy/jUNkDQ99/Hn6FPVwn8CcfvL28g2INIvqlLoHi/qrYedTKesaWOjtnOuXMOO
 tRTabwU+u0KXdArSHiE4tdgliBce6TUUMTAe7KwKKHB/Jzq3jtldXOaVRatWTnl8p4R1xfxudxr
 WGKIxyjHbiFuLcI9xJOjayv9zNh/NEx5OnGzRyZhz9nHmxYHOS6cBDiHdCHC9BCbmP59wLJtu56
 WTp1wHsyhzV6szLaY2JNpbZmxy/4TQSQaSu5fxfb3weK9y7A2XZv/5JUZe78uLcgEX6WH4m1hgB
 FIhU4Q=
X-Received: by 2002:a17:90b:4c86:b0:35c:30a8:330 with SMTP id
 98e67ed59e1d1-37c2bb41db4mr12330939a91.0.1781548395684; 
 Mon, 15 Jun 2026 11:33:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522a251dsm289131a91.16.2026.06.15.11.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:33:15 -0700 (PDT)
Message-ID: <53ef3e8f-c421-4744-bd8f-c67390f31639@linaro.org>
Date: Mon, 15 Jun 2026 11:33:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com,
 alex@shazbot.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
 <d0d18a5b-1178-416d-81aa-d6d5f56ae3a7@redhat.com>
 <fc1213f4-1500-4282-8c98-8ddf10d4955a@linaro.org>
 <32c4a353-1cbc-4d3e-b05c-a4324e985426@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <32c4a353-1cbc-4d3e-b05c-a4324e985426@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 6/15/26 11:09, Gavin Shan wrote:
>> I guess it's also worth asking if this copy is also used for copying *from* device 
>> memory.  The commit that added memmove (4a73aee8814) suggests that dma from the device 
>> uses these paths.  In which case you'll either want a separate function for that, or 
>> both source and destination must be aligned.
>>
> 
> I think it's a valid case. Lets handle this by limiting the 'step' based on
> src/dest/n, something like below. atomic_read() instead of ldxxx_he_p() is
> used for loads. Please take a look if there are anything we can improve
> further.
> 
> // Not compiled and tested yet
> static void qemu_ram_copy_unaligned(void *dest, const void *src, size_t n)
> {
>      uintptr_t test, step;
> 
>      while (n != 0) {
>          test = (uintptr_t)src | n;       /* alignment enforced by source */
>          step = test & -test;
>          test = (uintptr_t)dest | n;      /* alignment enforced by destination */
>          step = MIN(step, test & -test);

     while (n) {
         uintptr_t test = (uintptr_t)src | (uintptr_t)dst | n;
         uintptr_t step = test & -test;

Otherwise it looks good.


r~

