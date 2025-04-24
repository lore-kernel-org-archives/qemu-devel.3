Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A565C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83Pm-0004zb-LI; Thu, 24 Apr 2025 16:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83Pj-0004z1-G5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:43:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83Ph-0007DE-P7
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:43:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so14492585e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745527395; x=1746132195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JwNfpFIMMv04LQz3ITV9jvGo6Ng5eoMmoon3Ime06f8=;
 b=Z7jz3ngNWgJ3giOoLuxtsCNKdtE0MbZb3BM4k8G/axjhBDZLtS27PhpypuyMQGjGDt
 0f5YRB0hIWSOxExwNJgKr1+uh7bsiRkv2JNHN1L+AzsstUrst3epykzXK+GkI6gF54jG
 5ZgwraG2N6gBxB2bpkt573A4t2cuJ/lg5LL/8epDoPBeIcKI0eo9C9NeVgkIVmiaqlms
 MXOlrJJNw3mdLaXtLsiHp6z8xGAQ5rs6o5m21ZgUsJYBibjgtdqHD21b7rLkc3ffx7ke
 71itqJunWrCg0FnT5IVjQuEXrR0bhgOY0vC4sRago1n6rOpwBAUsQ5clcr34uU/Ul/HK
 O8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745527395; x=1746132195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JwNfpFIMMv04LQz3ITV9jvGo6Ng5eoMmoon3Ime06f8=;
 b=cQkV8wNZsvZ7VfrrNDhsxZpnSkdE44r80XdDbCj34+Ldkul0ZpYgpCUD2A1+HZHL1W
 yu23OtOaJy2gICQhGgvFNMl2pu/fb5M1Fw6pdqbcfnfhN8DQR4DE/yhYWuw+E6DBMZpN
 9GUGYLvAggKsTeuItUQZPsTDrLtidaiZ3F/cbKM/LxHmQwyN4vBI7Vi3kNrvKWtHhfK8
 kS5C6xp/v5pO0JQVXo9S3IGZUQsvCkasFnL8aSnZmIpZGbC+ZqDKKXBdMDgz5RHRD1Qc
 VvAeP/0L4ltwerkOlz79+AWe7/df6zJjBUBjzUSCydPRkrziJkGy9z0xcgptym6ilYkj
 pNgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUExXlRcJIqVJDfdcqSToS/r3Z6HoPivXEib3HlcgY1X4XddHB433XXeGNw9hXkaHC63evqoGPQIGXJ@nongnu.org
X-Gm-Message-State: AOJu0Yw76wIY0ECT2Jdd3Tjr8M3LmoQLNmGaimNOdnqjKbzzTnoTYJdO
 ptGE1AAp1P3r6m3SBlzlUz0ea2WdLWegj1pDrOaliC3Cnk3wR1E477yMg7W05lw=
X-Gm-Gg: ASbGncsKcjc4LqzG6I9zO7d6c5kTkJsJcBIJr2ln66E+j6hcn6OCt7SkdXKGPR0w/hc
 0Yh200tcDsGALvyUIorx/r0j7/H9LOzzMw1dFT248JNbXTD3GNFIB4P48GoEfsfc0WRJo4Gv0tC
 E7cF6i5zZOs+g8qsQuFRaDo36swCF4M33PIW49egtPETe6AGEEqXhaUmzuFTJJe3mRk9NagDNtg
 y55+pRBeVrbSxFQJB7Ed6PTi6RaBbSdl9mzFRan9QckzV1pXH2R5M8QSbaAIvsQEEIePWHbDLk+
 o4NkRlIwIXvZ2lSKXtdcYkIZsGa0IXVabIT5QvhFqYz98nAZ2m6Cf0Y3R27y3KD8Gy8jTK/pa+c
 VtxEKrvKs
X-Google-Smtp-Source: AGHT+IGY1T8zvWf6iuBfSWOXYhOkreR6lphGYtZSMGCQuWKAJT1XdNXVy+m4bSO150OmheWYhuWLNQ==
X-Received: by 2002:a05:600c:548c:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-440a30df650mr7573275e9.6.1745527394848; 
 Thu, 24 Apr 2025 13:43:14 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d0a7802sm59362515e9.1.2025.04.24.13.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:43:13 -0700 (PDT)
Message-ID: <b0d553d0-be66-40cb-8fde-1b1554720db8@linaro.org>
Date: Thu, 24 Apr 2025 22:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 24/4/25 20:33, Pierrick Bouvier wrote:

> QAPI
> ====
> 
> QAPI generated files contain conditional clauses to define various structures,
> enums, and commands only for specific targets. This forces files to be
> compiled for every target. What we try to do here is to build them only once
> instead.
> 
> In the past, we identied that the best approach to solve this is to expose code
> for all targets (thus removing all #if clauses), and stub missing
> symbols for concerned targets.
> 
> This series build QAPI generated code once, by removing all TARGET_{arch} and
> CONFIG_KVM clauses. What it does *not* at the moment is:
> - prevent target specific commands to be visible for all targets
>    (see TODO comment on patch 2 explaining how to address this)

+   # "#if TARGET_S390X && CONFIG_KVM" will become:
+   # "if (target_s390x() || kvm_enabled()) {"

I like it.

> - nothing was done to hide all this from generated documentation
> 
>  From what I understood, the only thing that matters is to limit qmp commands
> visible. Exposing enums, structure, or events is not a problem, since they
> won't be used/triggered for non concerned targets. Please correct me if this is
> wrong, and if there are unexpected consequences for libvirt or other consumers.

What about function name clashes? I.e.:

389 ##
390 # @query-cpu-definitions:
391 #
392 # Return a list of supported virtual CPU definitions
393 #
394 # Returns: a list of CpuDefinitionInfo
395 #
396 # Since: 1.2
397 ##
398 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
399   'if': { 'any': [ 'TARGET_PPC',
400                    'TARGET_ARM',
401                    'TARGET_I386',
402                    'TARGET_S390X',
403                    'TARGET_MIPS',
404                    'TARGET_LOONGARCH64',
405                    'TARGET_RISCV' ] } }

$ git grep qmp.query.cpu.definitions
target/arm/arm-qmp-cmds.c:238:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)
target/i386/cpu.c:6418:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)
target/loongarch/loongarch-qmp-cmds.c:30:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)
target/mips/system/mips-qmp-cmds.c:28:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)
target/ppc/ppc-qmp-cmds.c:192:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)
target/riscv/riscv-qmp-cmds.c:56:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)
target/s390x/cpu_models_system.c:85:CpuDefinitionInfoList 
*qmp_query_cpu_definitions(Error **errp)

Prepend target name to these functions and dispatch generated code?

