Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5BFC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weujE-0005wm-VB; Wed, 01 Jul 2026 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1weujD-0005w0-1O
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:11:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1weuj9-0005IO-NW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:11:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-847921eed4aso509965b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782911485; x=1783516285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9tiKavyIaytNH9UYWA1lU/SV0F1gVF5Yxs59w8qlmE=;
 b=egX2d4FfvglPt8aYXVfAA+DJiSLPU2i3aNt0lv1HFe6bSkEgdlUiEm5x4iyqhj98j0
 T9q6AxIC80olrw+QMQRC93RhYVxdV1DKTgt3+D+Ge1lJT0S57vqVxo1BhdVYrOHAJGfr
 CsFmG45V2XP4NqDVpqpLsuV97Zcc8Uq02qZXE5le2zIy36+4Ocdu5pDMOCvwXDLwVAnM
 lZuqtOZDkfiEq0HziMNhBj7sr8cQ9xKumHBXlOgFND4JnVvPvFnTIkX8AWnnN76lUyFB
 Wk3ax4G4tJxz7pZORM9yADQZQKkMLrp4MYPqhponKDToBA8xai8kzC1j5nqdtqZduXMG
 KV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782911485; x=1783516285;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9tiKavyIaytNH9UYWA1lU/SV0F1gVF5Yxs59w8qlmE=;
 b=oZAXFxQ262i3INNd8YhlxMiK9eF4fEb9Yd1JSWW/okW7VnDuKEE4wPs6sDbipcX/PR
 sMsHAhI/rBfReWsguBcNRoNs63+bmcwxURQKTmL5CNk72EbsW8ud0d9nm7NJ0vj2mIOA
 2+lVTj1P8C06s4gJEPjDK5PO1+GX23MPrs8gwTmom9Tx6c+P3+Fw+lS3PmqmMHpXuNig
 1H+lp2ZIOABYHw9NPAwQHramw4s0SDaVPFpZogktblOdyfRgQq7N0VemZbZeBxbptLsL
 0qa26uulWh/qdqW92jmjkOuDIsDqSICxVw53A6IXxXcyYPk6lTXlzUoFymOYFlnzvKxE
 3ZOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqM/e3pY1hc+bsRaj6z0+oZKGDkRfW5+8MZ1MDVXNDl8WtEAy7HCg2MG4+NMil5IxczrfH9gpc85my0@nongnu.org
X-Gm-Message-State: AOJu0YxNcZ6Pw6pSzks9kaOjGQ8lz9Ukc63Cd1LeFkRWgf1xlirbUP7f
 +X2dgYrNUvVqstdkQCwnNhADSs4hGxmWtBgJup9TGplbGGlYyDotAHZS+pueaDIDkfw=
X-Gm-Gg: AfdE7cljTvejUa2MkqksKs+gy5zTNO4iK6X9xsQfs+Nb2/J3OGDz7lI5bG/ygHnykr4
 OWyTlIwDlM/Nzec4W4rNcFkmoKipq6Ug0H7HLuc7Da4J5Nzj93YcEp78oBjk/8gRxzWr0cCTW0N
 QGJIIyjVmTuo+PFN5tmcEC3KguVLEgS3ySf7PPJjVzyy72ZeCNWOYvDzw+qtoWcypPIg27AzXzq
 G0WaQs6KYJ20Wkn4V23vAA7xNmixAgILYi4mpzGEf+MkkGaKRLLK9hShh/J84zFoZYhdZgbf4lN
 NQaJdc1fqW7ZpSi2P6+pHPaBtwJ6MLx3KV57W7ZWJBOeDA9HZqy5/O2S6TMdBCAbEjOhBoHk5f4
 oyqDYZwKO+6D3fp+0gNIo+sFBhD5q42vHfp6C1JBn12WohRAtvVBL8FWXLKSIsD0FUIj6mZJ26D
 MT9siXx0w32UVcA6YmVzHXlSG+L8ivZoQ2zJFgb2Tj8q7LaKAWW77RXD70YQ==
X-Received: by 2002:a05:6a00:181b:b0:846:1698:638b with SMTP id
 d2e1a72fcca58-847c504d207mr659969b3a.27.1782911485241; 
 Wed, 01 Jul 2026 06:11:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847a033a883sm3981477b3a.47.2026.07.01.06.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 06:11:24 -0700 (PDT)
Message-ID: <58d000af-4213-4600-83ec-e418ac8682b8@linaro.org>
Date: Wed, 1 Jul 2026 06:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/34] target/arm: Update contiguous first-fault and
 no-fault loads
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
 <20200511133405.5275-22-peter.maydell@linaro.org>
 <e9cdc625-7ded-4678-965a-a98f18150ade@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e9cdc625-7ded-4678-965a-a98f18150ade@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 7/1/26 00:37, Philippe Mathieu-Daudé wrote:
> (this is commit c647673ce4d72a8789703c62a7f3cbc732cb1ea8)
...
>> +    /* Probe the page(s). */
>> +    if (!sve_cont_ldst_pages(&info, fault, env, addr, MMU_DATA_LOAD, retaddr)) {
>> +        /* Fault on first element. */
>> +        tcg_debug_assert(fault == FAULT_NO);
>> +        memset(vd, 0, reg_max);
>> +        goto do_fault;
>> +    }
>> +
>> +    mem_off = info.mem_off_first[0];
>> +    flags = info.page[0].flags;
>> +
>> +    if (fault == FAULT_FIRST) {
>> +        /*
>> +         * Special handling of the first active element,
>> +         * if it crosses a page boundary or is MMIO.
>> +         */
>> +        bool is_split = mem_off == info.mem_off_split;
>> +        /* TODO: MTE check. */
>> +        if (unlikely(flags != 0) || unlikely(is_split)) {
>> +            /*
>> +             * Use the slow path for cross-page handling.
>> +             * Might trap for MMIO or watchpoints.
>> +             */
>> +            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
>> +
>> +            /* After any fault, zero the other elements. */
>>               swap_memzero(vd, reg_off);
>> -            return;
>> +            reg_off += 1 << esz;
>> +            mem_off += 1 << msz;
>> +            swap_memzero(vd + reg_off, reg_max - reg_off);
>> +
>> +            if (is_split) {
>> +                goto second_page;
>> +            }
>> +        } else {
>> +            memset(vd, 0, reg_max);
>> +        }
>> +    } else {
>> +        memset(vd, 0, reg_max);
>> +        if (unlikely(mem_off == info.mem_off_split)) {
> 
> Is this code reachable on user emulation? The changes are
> quite complex, previously code was guarded with CONFIG_USER_ONLY.

Yes, if you mean this line specifically.  This merely requires an unaligned vector load 
that crosses pages.


r~

