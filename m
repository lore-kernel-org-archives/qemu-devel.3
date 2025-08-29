Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5F4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiJ-0003MU-9x; Sat, 30 Aug 2025 11:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us75h-000892-LG
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:57:01 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us75d-0004gg-Cm
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:57:01 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-327d47a0e3eso1456717a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756504615; x=1757109415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nGIXDNSVQ5fb683JpUhMRlteIhAQq4YWpd9SbTwCc/o=;
 b=SAjakH8BzuOJb/fLl2Wbnb4vu8MPWkOCWTdzTFF2KaLufZuuZqomTpXjEswDIkhdxJ
 lDPEHEas+/BMtZV5pSQQFLb5wQFgPlUoTQaKK2Z04Q8C46sv8maiNAakhx25jXCoKbmJ
 hKWl5tTJqmwkc190c6JgA21GiTDy0cUHDVWstFmgPFBnSuzbGU3lYgq4hQoaz2fe6g/y
 Tl9xVUtxtNP04c4t8+AiSAA7ii4cAVG9KQa3BeT9eZJg4wfAOtc3/nhxkAElQsmAKSS7
 5BtVPda9+PLfRQGUtSGIo6RFeOYLoGLDy9J0l71xvkbdC59DAdAXJHSlbdYNhd9lKI1F
 nHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756504615; x=1757109415;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGIXDNSVQ5fb683JpUhMRlteIhAQq4YWpd9SbTwCc/o=;
 b=Hgvei43/RwAfMQaQzhHejNYX6gcyzH8/C9ali+RvskvqKTUgP/Afvt/5djkYJcC2vm
 yirejqFw9FG12r14voqE/HY4UCuEJ5c+uCQk42yJCIb8LHqUqc3kNQUVhKd2EIigijcq
 YVoO53DrlfrhW5frPvds+Avqh+WpKBBT38PuAvYbHmn9HuAsVke+h3nI0I/khaly2unI
 WoSz7SeNTA0BSHcqhzNnEzYCFlZYierrrsrQigbY3iyqV0ClwYyRyerpaMDEEwWqlnAz
 BXb/Rr8FY7dPQmaWBV9ZUBwECl/21zoF3QEINdxIIUi58H4bRfKUN/qTpnH/zGtEN7/m
 mjKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnrVoIdvGfLwT0NT9VaD3npA5pQb/VQL001ZLBW5UMoFhpXNjxnGSV/5LZiNi4k9UZ1JVivwN2zcKw@nongnu.org
X-Gm-Message-State: AOJu0Yz5vaP/2DT2CWe50TfI4FAyE4DpO5GjTsKf5MHBun1guhjOoHsJ
 TKew9/nuLjoxh0uyb3y4olIczlZ2GDbfSBYkn4HLvmxWZZK3WdHSMcSNQ47F3BssqCQ=
X-Gm-Gg: ASbGnct+bFs0d2HTJBBBBfkWhl7q5vAjsAU5/uACc3/Ac8I2hus+x8e8vGY1M8s6KnX
 TVU8bFtm7DqXqvIuj5qZY3LLj2zt5IbyBnfCOlVdXkx3nwRwCmXrLiu5a8OBBTczSdG7ILKD7Ei
 BPKU6ygPz5iBKicFqjeDeqCdnY18l4y6YSs9k9JqI++mmhiDujszE+TtyHpPbduyX1rk5Nfl0qW
 UhHuwTtmdugZnE+hUZL3sMzbT8U/x7ULhKT1Sn1QB2qUnr9XkWAuLVxcl0gFIHyW2fknQfRDtLO
 FsS18f/CaYAQxHiCUqjk5BJMksgc8BkdmEasM/MCwe02N9loDfXP+AnZdU4Agzuz34WmKamsaIW
 etJbd77X/5Vu3ftCLjsmEoDlraSWP512SkukwqPhM5BggNG5ChNofowsUxZoZln8ipIhZH0vO12
 DKzlF5MQO2w3Ow4PmQkA==
X-Google-Smtp-Source: AGHT+IHvM9sY4AYkYnz1CV9448wKoEaH2bEHY4WpOWeWrFsjBQLC1de6QFf6OxSN35RZkle3CStjYw==
X-Received: by 2002:a17:90b:1e12:b0:327:7e8b:eba8 with SMTP id
 98e67ed59e1d1-328156e13abmr161663a91.31.1756504615171; 
 Fri, 29 Aug 2025 14:56:55 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276fce1160sm9213646a91.22.2025.08.29.14.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:56:54 -0700 (PDT)
Message-ID: <743782b5-1e3b-4b63-afe2-4ad1da333bde@linaro.org>
Date: Sat, 30 Aug 2025 07:56:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] cpus: properly kick CPUs out of inner execution loop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-10-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> @@ -624,8 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       }
>   
>       cs->exception_index = EXCP_YIELD;
> -    qatomic_set(&cs->exit_request, true);
> -    cpu_loop_exit(cs);
> +    cpu_exit(cs);
>   
>       return H_SUCCESS;
>   }

cpu_loop_exit does a longjmp; cpu_exit does not.

This may be a bug fix, but it's hard to tell.
If it is a bug fix, it should be separated.

I'm also having a hard time with e.g.

> +++ b/system/cpu-timers.c
> @@ -246,14 +246,14 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>  
>      if (qemu_in_vcpu_thread()) {
>          /*
> -         * A CPU is currently running; kick it back out to the
> +         * A CPU is currently running; kick it back out of the
>           * tcg_cpu_exec() loop so it will recalculate its
>           * icount deadline immediately.
>           */
> -        qemu_cpu_kick(current_cpu);
> +        cpu_exit(current_cpu);

where the comment still says kick and we're replacing kick with exit.

I guess the root of this problem is that "kick" isn't a precise term, we ought to name it 
something else, and we should paint the bike shed green.


r~

