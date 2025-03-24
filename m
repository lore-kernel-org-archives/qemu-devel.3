Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A17BC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmXB-0004sh-RJ; Mon, 24 Mar 2025 14:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twmX8-0004qz-6v
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:28:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twmX5-00063u-Nv
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:28:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225477548e1so88342495ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840898; x=1743445698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FW+P+KmJAHBmglYRWoVPylz5k0iBKQBwwS8egCK1yuE=;
 b=UqVjw4gGWcu55cawTT9jp2bG0L/TbqSbQrrgTXZc7ACNNRAP/lG1dVvByGHrygpMBX
 RUnWfaSkP8LKOl44X18tj/+RekmB60Sf6qEgNTgAoRsL/5sab5kXMiOWxfZSmfL53dxm
 UWXYFUhETWZzkvLZqkmgo6drW/9yTBwetWPlS387LTF558L+0319qBCLnvHs2gekfPBd
 i0gIVa4kBFtZCpxp79jGkRfraa2MZMzR2KPDf3YKEBdsrJdJdrBy07abRS8bdSU/CqXg
 mEKEK0RgqDHEb/N9YLoZDKhmWYnRvD1Hqop/H3C+8QOsumNjbk0FXqQhnXMr04RlE7Ur
 k/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840898; x=1743445698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FW+P+KmJAHBmglYRWoVPylz5k0iBKQBwwS8egCK1yuE=;
 b=HOkwCVzApcwciEzUOpKYofj0ipwqMfZwYXIZ1uqUfyHGXkvq9IQ2dnrhyWVRi2taXW
 IrV5bd/RnIfsq+YZ4BZ7zMw1TzS377b3dfF2ITnDHMJpCieTLU8ojsNys7Mt5cs/2k6L
 P3a13EvyGWRpRdNwHcJTK5WUIeHuIFv7P3OeT6sRhnXzsIU10J2tgVcbrw4E5XsUkXzH
 RZWsAw3N1Ev9nE9ObMwkdXKKmiL0MXULMuJWg4xSIDFLfbXcnSztNmNzDKk0MkdwnbEg
 jSori8mu5Ll8W0DkxWi/MxyU/d+isThBcnFjiI+HugGfOJoKHemHpNbkGednUZyjh5z7
 yksQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4dPFFDcIY57qZDrzrBB08c2s1hC4cqyF7vkvJLLZ6KnnC9k/4veQv0LmWMGAZisGx9GTVEQmEkJv7@nongnu.org
X-Gm-Message-State: AOJu0YwYL40kVDMYWVgEJtIz8MPFR6itq3rnBNAG4VoH7zi9ToKFI9II
 nlNsZFIplt1VvnTH4Xng3z70XS/yziokP1t9g42Zrx2cYOQCko7npxJS5lUwoH0=
X-Gm-Gg: ASbGncuuaok3zGzZwVGZdfaCqp8BUEPu1lEyo+apH2Zs/4Ry68yyF/s1pohZvggPjh/
 tGl3wT1CKDYVNbmtQoRx5qwMhV/TVG1Kfu7wBt9RzwCnsHbT+WsOuCEIAEn0Q5IzulXIOmSwLVq
 slSBFaowvh1iJ4Rz8BC+aqMfrmJ8Aeb5jRoR4wHzJI642eXRMIDXG/UPUPsVp6i/sRXQzDeKDsv
 3/4nKrhhSIhHfR+uzGpro7XEEOBNdvkYJ++GZzS1b7QERl8BvCUDcrEZ0opXGrMTglkpX72Qt5x
 YwJP+SGEfsZ5McMnw9PkO5rg9y4bjn8cq8RRN/0PxkdF3Vz9pjKhVuW+gOdbVi/FSGDxnmbMqPV
 haP8SrxHe
X-Google-Smtp-Source: AGHT+IGdgWKWjwZpByro2ssN63XugXkhO6cYBe3N6+jgzS4RmZazZkZdgPCNQvTUx/YamU9ZG2VHWg==
X-Received: by 2002:a17:902:d4c5:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-22780c7a32dmr222295215ad.12.1742840897809; 
 Mon, 24 Mar 2025 11:28:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b80b7sm74280905ad.110.2025.03.24.11.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 11:28:17 -0700 (PDT)
Message-ID: <d3d564b8-1b74-4569-afc3-23c0a7d3bf25@linaro.org>
Date: Mon, 24 Mar 2025 11:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 0/6] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250323224035.34698-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/23/25 15:40, Philippe Mathieu-Daudé wrote:
> 'cpu_list' might be defined per target, and force code to be
> built per-target. We can avoid that by introducing a CPUClass
> callback.
> 
> This series combined with another which converts CPU_RESOLVING_TYPE
> to a runtime helper, allows to move most of cpu-target to common.
> 
> Philippe Mathieu-Daudé (6):
>    cpus: Introduce CPUClass::list_cpus() callback
>    target/i386: Register CPUClass:list_cpus
>    target/ppc: Register CPUClass:list_cpus
>    target/sparc: Register CPUClass:list_cpus
>    target/sparc: Register CPUClass:list_cpus
>    cpus: Remove #ifdef check on cpu_list definition

Modulo the s390x niggles Thomas pointed out,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

