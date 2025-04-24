Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541D4C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83v4-0002OQ-7e; Thu, 24 Apr 2025 17:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83v2-0002Ny-Ej
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:15:40 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83v0-0001zv-Hl
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:15:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227a8cdd241so21002495ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745529337; x=1746134137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YvoZBb0sixkHkBPaiOjwS6QtkDfX0j4MmbvB5dDyFlE=;
 b=g8zpPJGKz3hvAtcrqkpAB1wyPfiyjDzxRbqpBiZrK87m261yvY+0reVPbW2EyWeuUp
 eLvCGbxpyzwEZLzEURcueoZslgo6D1cyAl7OVd+RkuDFHfWDYfCeh9hMB9pQEDpVYCnv
 D6I7SZ4GhVgMm/7rOPb941dyTEhzQUOHqPOkaUpEy1XoGlMmE4uL6NSILDGQ/seaiIx3
 E7GlkRGgoAB+bPVs4exqdrIfpqlReYupW7hRNE1E+8l4jKNMcqs3Ka3eMpPcTmbqGPL0
 DDyFa8YLP2lVEc/mGKbi7nvOOJdj1L1+2eSUXhqHCjiUXHjN2B9FDkgl54adcIejhgqu
 oqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745529337; x=1746134137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvoZBb0sixkHkBPaiOjwS6QtkDfX0j4MmbvB5dDyFlE=;
 b=EL92g6OeNaMAZjYGOVxZ3b2ioG0M2MqpCcCdQzexme+SkUPJvkbig7uBvaL7+kAcdM
 PzhiJdMCEWmkjT0OeXtCgyHO1P8f2nMcfMltRPfLn5r6CjBl4uNO5l+Z2ytERkWkDZfP
 q9gduYZQDvBM9JNCSMDNiFhxxwjPVZFZFwWFMIye9vVvjQSVU520i8VpkQCp/jlQrlZ8
 mGB1MmWQbvBNH6ReApHkwTRDHeY9BVJxylN6OoVBWOph20aiYxSILEQyHLBHmr3MwlnV
 Q9EnJzX2b2VB+3ABtzHJCJv5r0/ZvEQocTDkDfvI431XkWaK0OBHNlXW5ufPANBf8w+n
 Rl7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHRWGyBSIgMHjgv2RtkH1C+pcTO/GAyD0JYCdvUQJsm4fWumblt3rHt7QB8eVAvGZHcxuUEP2906wm@nongnu.org
X-Gm-Message-State: AOJu0YwzOXhEDentnvBx0KUacdPVmu6OW03IZs2gOqjZo0WUq1R7iCEM
 3BKr5/+gZoSS04DApWDXOIcywn6IXHzPkNVA9G+xBZL744CSBKj8b+cDkP+4Zn0=
X-Gm-Gg: ASbGncudc4FjLcRro8y3G+OmiEq3Q4xxnbgF5S8RDFA1eu9nDSnkgYSfxxDi7D4MrNq
 5q2U19T6zd7bBU7ZmgAXi9iF2CM9YVoBBba0+zJVDXtRSAQSiqRndREN1zZ5MYBkxY6gTp3p5xe
 E2eluPffg/5Aw59ZIZ7DTzJEpX3N6T+ajiJyKCIopIbLL+FAKi367mVr5P1WAQ3sLb3iYejcC96
 BqhXObg5/0hHT0+SXQ51/ZOzEDokouIq6t5XJAvujIZFnI5ME6fZjkLqob5wkw3qkKAdB4e58J/
 xLF24sTJJ8+iYV3dm+x7hIps0TTLlUpQ0YOKaT5CppNEPrvoQm+O2kXEDl38qfRUcWcvHPWhdND
 q7ibye6I=
X-Google-Smtp-Source: AGHT+IGCs8yBphGFsoewBDQLt5vM39gtvNtz9sodVxWslrRvlMohH+gseiWxpXR+5Z91wlj+vRMLbQ==
X-Received: by 2002:a17:902:eccc:b0:220:f795:5f14 with SMTP id
 d9443c01a7336-22db3c14b93mr54938995ad.27.1745529336846; 
 Thu, 24 Apr 2025 14:15:36 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51050b8sm18316205ad.202.2025.04.24.14.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 14:15:36 -0700 (PDT)
Message-ID: <3836f6b2-d0be-4a1c-9658-b7a6eb8b821c@linaro.org>
Date: Thu, 24 Apr 2025 14:15:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 thuth@redhat.com, jsnow@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <b0d553d0-be66-40cb-8fde-1b1554720db8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b0d553d0-be66-40cb-8fde-1b1554720db8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/24/25 13:43, Philippe Mathieu-Daudé wrote:
> What about function name clashes? I.e.:
> 
> 389 ##
> 390 # @query-cpu-definitions:
> 391 #
> 392 # Return a list of supported virtual CPU definitions
> 393 #
> 394 # Returns: a list of CpuDefinitionInfo
> 395 #
> 396 # Since: 1.2
> 397 ##
> 398 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> 399   'if': { 'any': [ 'TARGET_PPC',
> 400                    'TARGET_ARM',
> 401                    'TARGET_I386',
> 402                    'TARGET_S390X',
> 403                    'TARGET_MIPS',
> 404                    'TARGET_LOONGARCH64',
> 405                    'TARGET_RISCV' ] } }
> 
> $ git grep qmp.query.cpu.definitions
> target/arm/arm-qmp-cmds.c:238:CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> target/i386/cpu.c:6418:CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> target/loongarch/loongarch-qmp-cmds.c:30:CpuDefinitionInfoList 
> *qmp_query_cpu_definitions(Error **errp)
> target/mips/system/mips-qmp-cmds.c:28:CpuDefinitionInfoList 
> *qmp_query_cpu_definitions(Error **errp)
> target/ppc/ppc-qmp-cmds.c:192:CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> target/riscv/riscv-qmp-cmds.c:56:CpuDefinitionInfoList *qmp_query_cpu_definitions(Error 
> **errp)
> target/s390x/cpu_models_system.c:85:CpuDefinitionInfoList *qmp_query_cpu_definitions(Error 
> **errp)
> 
> Prepend target name to these functions and dispatch generated code?

I expect we'll make this function 100% generic based on the TargetInfo API.


r~

