Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EE3C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYl73-00032u-QF; Tue, 30 Jul 2024 07:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYl72-00031U-Pi
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:33:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYl71-0003Yv-2A
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:33:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc52394c92so36209275ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722339229; x=1722944029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YNB0aAcuCiZi0xjooF9GaiE5hnT1Sw4aBSA8wLWdHYM=;
 b=BzA0ARq0ID0SQ2/WYfUIWSObjvBbQu8zA8eiEycsy7YzoG3Nz3aNcUMXHHw9yQBT37
 J0+XIPJ0Pc4XNLjcU1s24zRgW1sOgaj4HtPQy+DketuldGOitgTxanCb7yYfvstI2Qvb
 gxUn+kX0LQRvPfDozapXQc3W1oAlzLKXbDizsBPS8sGHL2rwkB4T1kBeoaBDN5HIhqzO
 U89zfLGPFe7rvmH06dJta8xZvf4Ngyj1z7pIgX3iO2oQ+XJ0V9VaI5kFYlxK8PC9ls1Z
 ifKGTyRYpwTM9oDU0EU4p2GBpkP5qBKu4nv0THckYWc5KBgfiLFmKpvTWlzp4tHZLIg2
 GJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722339229; x=1722944029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YNB0aAcuCiZi0xjooF9GaiE5hnT1Sw4aBSA8wLWdHYM=;
 b=KOAMOAQZC45FcY382rlGgY0x0/foGzIK976vDm1PxZYVIl1nRb8g0OJx2CLWBoAvHi
 VQ1RSRA85bhbXQb163xL0UC8Xw/qGHo+Zp23AmgbCMLiBKDHoCiSJRrsAjxWBayCSSqs
 kDVArtAwA6vc5bzB0+JKEKtkgQGusPVuDdzqKDsK18DTD4qBQodnNGOKMtTdZ6QMKLes
 rPmLIPGI2T4sB9bi8TT9FUJQvK2r8uavujpFxGIYs1exfRRLRRLlL4lld/mrBBTZZZ2k
 9aNAyju3RGFPjsr2KwdgjkIpHwxAqV7Gv2upsTNE2EykAAgtJOu9+MvPmCw1J0/dQdSE
 QsPQ==
X-Gm-Message-State: AOJu0YzsL7OmOVhta8ihxalJ0WmQcAoMigVpMQrW4oYnxur4UA3FXxv1
 DaZ+H+FlEtRMhEDAxirQ/TTmDRbQEckBpeKZFguXUnltZ+wENoRt/CZRSarPRe8=
X-Google-Smtp-Source: AGHT+IH/LE0pczjoBiwHKxCDHdXuDowTpdXdAlmH3WfVuPPhNmghwWAUCmYnLhMcA9xZrLjssAp3Dw==
X-Received: by 2002:a17:902:e741:b0:1fd:acd1:b642 with SMTP id
 d9443c01a7336-1ff04926567mr130384925ad.64.1722339229143; 
 Tue, 30 Jul 2024 04:33:49 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee1482sm100187485ad.155.2024.07.30.04.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 04:33:48 -0700 (PDT)
Message-ID: <a71e9e79-6f26-4cab-b39c-b5f2fdc4c206@linaro.org>
Date: Tue, 30 Jul 2024 21:33:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix BTI versus CF_PCREL
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240730013922.540523-1-richard.henderson@linaro.org>
 <CAFEAcA-yuy54nnuoa_B32UpKPtfhRmo9sd1N7eYKSz4O0PC7qg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-yuy54nnuoa_B32UpKPtfhRmo9sd1N7eYKSz4O0PC7qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/30/24 19:30, Peter Maydell wrote:
>> +static bool is_guarded_page(CPUARMState *env, target_ulong addr)
>> +{
>> +#ifdef CONFIG_USER_ONLY
>> +    return page_get_flags(addr) & PAGE_BTI;
>> +#else
>> +    CPUTLBEntryFull *full;
>> +    void *host;
>> +    int mmu_idx = cpu_mmu_index(env_cpu(env), true);
>> +    int flags = probe_access_full(env, addr, 0, MMU_INST_FETCH, mmu_idx,
>> +                                  false, &host, &full, 0);
>> +
>> +    assert(!(flags & TLB_INVALID_MASK));
> 
> Is there a race condition here where some other vCPU
> knocks this entry out of the TLB between the point when
> we started executing the TB and when we made this helper
> function call ?

I don't think so, because cross-cpu flushes use async_safe_run_on_cpu, which will wait 
until this cpu returns to the main loop.  But it's just as easy to allow this probe to 
fault and unwind, Just In Case.


r~

