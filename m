Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3016D14893
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 04:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdhRQ-0006Lk-1n; Wed, 07 Jan 2026 23:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdhRO-0006Kx-2e
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 23:16:06 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdhRL-0002vx-9m
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 23:16:05 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so573913a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 20:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767845761; x=1768450561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=okHBr9RCrk54qnEKOp1eWuBaR7NgAz7iUu5BQAD/6OQ=;
 b=h6g8fqtGQ9q4EuTxQDXhZK5pIVLl+5RT/dJTA4HvcJbYEmu9rdxpo6IQEndZ3vVEi0
 GX7h8SHPExo0aQWJZ8V7r4oiDKaMeLVT6O7uBXgcGYdjSVH7JeRzZsc5n4bwOxTdhgrH
 TF9wLw4z8fUiRP+Zv+80lbpAFsezpwlmqCgMob7TXRQyYmxyZpbHmQXBAtPCvIou6q3p
 S6TMYcWma8Dm+VnM3eH3XgdXo9OniV5fWnei0ZzMxEVtNccEpwPtXKAviRX418njzaMi
 BwA0LDdLx+wqVn5a+pNKIX546YVN9yCnjPU4p6bjMQ+iKSbSj5wYYigOByEy2FiZTTMM
 qKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767845761; x=1768450561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okHBr9RCrk54qnEKOp1eWuBaR7NgAz7iUu5BQAD/6OQ=;
 b=gugbqAOStwiIDE6RAiaOEgXRcFl3xA3R/jchjpATJgCUJdrWxPxhUP3apmwMQucIum
 f3vh8ZJ+/+AdtvhgWx+E85pPVmizBXxQJsh8FbhKS0EE7pM/6pfPmDwQZuVVwUARokE5
 4BCBkFrTji4hxRsX+WQlCXoRAbeHzaMqojwiv6GIOJ0zrRsbPGib9XuyrTh98dOiNDoz
 /dJy81gBS2dHFCiaOQGmk2/q2QhRfH2rbV+Gh05HQ7/cGyCT39eLjAZEMrn7xslP9SGp
 9qSDemcOfPUZBbR9G0pMrnuPztl/pLdmo+dGlVkZwMCZ3i7w5QGku9tZfeqLJxBUt625
 Z+dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV53IMJ/KXjglqYUNzeMliK3JPzb73O2ICnOf3I3SuTYVv8xGBiXCAlUccOr/zIFXO+09mrDKZg+Vod@nongnu.org
X-Gm-Message-State: AOJu0Yyfr6dhx/1OyB3zlPa3w4C4cyKMiwDZAqiev5orOTECaJZJBn4G
 wCm9JuDQaxT808wDevfaerQS1dpS8KRatOSyMMRuRbe6DVTljJKONw6NCkfpdXsgPb0=
X-Gm-Gg: AY/fxX51V4vwReC6s7P3LjkbnJCKkcHlUFhtYQYeK+kIyvSwLX49Fd7R+E4U3WwkDe0
 LGDVgnjUFu3NJVHnzDu8lLBmmIfO170DTcHjl+9zy6CGRZ54bCVBKoWrhF/aISBqmYNlWqH7ESr
 smIwFAw9ovCnGnclAIlAKr+Sgbc5FFwyjmW92qL4YdKokQ3r2QuErXIktWu1aA9VbJLfuDmeAsx
 9bjddkTcc3lPS78ByyH0E1AUCkXxjT6DhNaZw2PvoRS52gIgY45tnbEKtb8NeAaYWbmBBHjNPxD
 OqyyDXWHOFoT7E5G1Nw8mA+O6v9CmK5hTaZmPYoRCu4zS84Knng2R5yeNCggNoDl/DwENE8Mu41
 Qv44qEB4ZGgeiwzFKjtE6Dr3eJuo7L2GTEilZFgmbtlRctENgWKcLwNWFJVOumI77GT7H+6IeQl
 RvwcFO2JGnPBgblJJ7DAmUwskraxWdU9K7Mk/16cEV
X-Google-Smtp-Source: AGHT+IHGdoE4gW24l36tdfZNHGV6OsNl0JiwCHKPXjIeIOmda3U92B6P3p3AdFP9P74bfNa1R7sxqQ==
X-Received: by 2002:a05:6a21:3281:b0:371:7666:648c with SMTP id
 adf61e73a8af0-3898eaae00dmr4813913637.24.1767845761375; 
 Wed, 07 Jan 2026 20:16:01 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc95d5c66sm6411640a12.24.2026.01.07.20.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 20:16:00 -0800 (PST)
Message-ID: <4e1b7b58-9598-4914-9a21-de71c465d5ca@linaro.org>
Date: Thu, 8 Jan 2026 15:15:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/17] error: Use error_setg_errno() to improve error
 messages
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260107124341.1093312-1-armbru@redhat.com>
 <20260107124341.1093312-15-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107124341.1093312-15-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 1/7/26 23:43, Markus Armbruster wrote:
> @@ -2032,7 +2032,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>           reg.addr = (uint64_t)&val;
>           ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
>           if (ret != 0) {
> -            error_setg(errp, "Unable to read cbom_blocksize, error %d", errno);
> +            error_setg(errp, errno,
> +                       "Unable to read cbom_blocksize");
>               return;
>           }
>   

Missed changing the function.

../target/riscv/kvm/kvm-cpu.c:2035:13: error: passing argument 5 of ‘error_setg_internal’ 
makes pointer from integer without a cast [-Wint-conversion]
  2035 |             error_setg(errp, errno,
       |             ^~~~~~~~~~
       |             |
       |             int
In file included from ../target/riscv/kvm/kvm-cpu.c:26:
../include/qapi/error.h:322:38: note: expected ‘const char *’ but argument is of type ‘int’
   322 |                          const char *fmt, ...)
       |                          ~~~~~~~~~~~~^~~

https://gitlab.com/qemu-project/qemu/-/jobs/12639739827


r~

