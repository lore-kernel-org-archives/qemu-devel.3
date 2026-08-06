Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E765C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wroc4-0002LS-DL; Wed, 05 Aug 2026 23:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wroby-0002L7-Ku
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:17:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wrobu-0004YA-Kr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:17:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cf452def93so3901265ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785986252; x=1786591052; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbH+0Fhd+wH7wzNXEzv2L0k2Fb2kYsTWq1qtZw/sO2I=;
 b=K/aiWGLoIGhB2F6ndgAE5LjVDyXmBplIBV5Zdl088Rd6OEDVKtzGZAGX7WO7Kvs5qR
 QQnOchb3wEJUX872uehgErNPBEDtNoVjVgez+xlOC6k1gJbJYR9uAd/NYYJElZKaikVC
 Ei6vXXR1NhVr/Xy4Q5+4mvzfaN1wgKGql2GRIUT/kfJXD8bWXvSy/RJI48vyWXapg14D
 djSsEXnmdbMUUVRUqisR6hGzJytXEtyU8SbIXtUTs8BkhnnvIcPeA42hNhruFWcOEa7I
 7Mmp5/RDksB1gAeUfT49gCXZhuiiXsHUSXksOAKDAcjWpT2op6eN6wxWVW8FXHQukAo3
 xKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986252; x=1786591052;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DbH+0Fhd+wH7wzNXEzv2L0k2Fb2kYsTWq1qtZw/sO2I=;
 b=ddzdH0EjwNS7nVySIg0LdX26cjSvffmEotsXNhsb/M0UGwdVC1i04X0rD1Zmt0s3Zt
 ZclJjTvRYLx96FqwAlodYxzJVzGe/axwPYaEPB/l0VSyG4p1pdgluoU1atB8RpBT9hN7
 yzOzUOLsAu3lAB9wTfWQ8MRFmiWmKn4CtPCWTfiEz4gHR6v9oA4q5QTYeKiC5i+dP3Ur
 VbDNOFZDTrIPMivgWanKXWb+8/UbOC78DPBPk6GSf6o9SaRrQBKo0znfHpNjrPsUY9cT
 ywkoSJeFz6NBJ4Fg2AvjvIlJ98nYcnwXwKGfOinfE0MoWVkAQM811ymO+r3oQKUA8Oaq
 ZBQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8hhD11IWo40V5jTnYb1U1nxP46MTMay6SlQME/egIscyRsc/zBMcF3IMJnnvdTKOCSP+RFbTph2hx@nongnu.org
X-Gm-Message-State: AOJu0Yxr9LAWrGO2A4Cx5fBMT3u0Ksa3ADWkprtAgbq93qUDi/eAFk5H
 T9yiTPMSGXhG9g9aoSBGwJpvrK304O3PzzHWj4kkQ8lEheDevT1h3hYX
X-Gm-Gg: AR+sD13+YRWDBxSuygRg61/cVoF2t5caddOvXbJIjD45tkv4NxWyBzf8HGzhDfgj5f5
 tXu0c3v7qJdgNFTIJwYKlK8QppJmSicMqiRu61H+b30QHeFsmotUOaH5nLR6dgTC+fpk5zmw4H+
 waDmd6A2uaW3YdeP/aWub4RLPIu7t7ZqKJhc8nxgxQMAF0sLEtHfs8BZG9ZRmFofV+KaDxZ1At4
 gTCF9qCKuZUH3oBEx7O4dPnMmvB+FqBjQgJIZw5XJyHg66tDzcQHm5APDu/OHhI+/r5+xmtVKMF
 hkrRoIHpUamx2H7wffq5EUdIAhWdDTFEDuBWmgbz8sW4/Rvoc2VAwHB5Ctx+AxJwTclloTs1Fyj
 nAzJHXDh/qG5xYl8W+s6f0XKN3Iqt8e2n1Gh0M4nKsuwagiM0iU2N6tmdrFFgNWXHjJIJDXijwc
 64EfKkjTE7S1voelu22NpPwCc9qSIn6+2E3bmJp5K81vMir6z1nhSiAmDw7eBoG7hw8LNB+Wouu
 Xnzmny0gVPQP0UyIFJ5HcW6NTI=
X-Received: by 2002:a17:90b:4d0a:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-3908972cd26mr578868a91.2.1785986251980; 
 Wed, 05 Aug 2026 20:17:31 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2b2fdsm554421a91.12.2026.08.05.20.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 20:17:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@gmail.com>
X-Google-Original-From: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <c7994cf1-dce2-4017-acff-bdd54c6ee658@daynix.com>
Date: Thu, 6 Aug 2026 12:17:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dump: add crash_occurred flag to QEMUCPUState
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: viktor.prutyanov@phystech.edu
References: <178592075881.15274.7510279315190894277@linux.alibaba.com>
 <178592075881.15274.5708870107372539268@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <178592075881.15274.5708870107372539268@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2026/08/05 18:05, Zhengrong Li wrote:
> Add is_crash_occurred_cpu field to QEMUCPUState so that
> dump-guest-memory can record which CPU triggered the guest
> panic.
> 
> The new field is appended after kernel_gs_base, so existing
> tools that check the 'size' field can safely ignore it when
> reading older dumps.
> 
> Changes since v1:
>    - Revert QEMUCPUSTATE_VERSION bump (not needed, tools check size)
>    - Move crash_occurred check outside #ifdef TARGET_X86_64 to fix
>      -Werror=unused-variable on i386 builds (reported by Akihiko Odaki)
>    - Use linux.alibaba.com identity
> 
> Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
> ---
>   contrib/elf2dmp/qemu_elf.h | 2 ++
>   target/i386/arch_dump.c    | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
> index adc50238b4..3b28332e67 100644
> --- a/contrib/elf2dmp/qemu_elf.h
> +++ b/contrib/elf2dmp/qemu_elf.h
> @@ -27,6 +27,8 @@ typedef struct QEMUCPUState {
>       QEMUCPUSegment ldt, tr, gdt, idt;
>       uint64_t cr[5];
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];

Growing QEMUCPUState from 440 to 448 bytes confuses init_states() in 
contrib/elf2dmp/qemu_elf.c and makes valid version-1 notes appear to 
lack kernel_gs_base, despite that field occupying bytes 432–439.

Patch 3 fixes homogeneous old dumps, but that field-specific size 
detection belongs in this patch for bisectability and to support its 
compatibility claim. Please see docs/devel/submitting-a-patch.rst for 
the bisect requirement.

Regards,
Akihiko Odaki

>   } QEMUCPUState;
>   
>   int is_system(QEMUCPUState *s);
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 16e47c4747..8ce2c7e9bb 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -264,6 +264,8 @@ struct QEMUCPUState {
>        * by checking 'size' field.
>        */
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];
>   };
>   
>   typedef struct QEMUCPUState QEMUCPUState;
> @@ -279,6 +281,7 @@ static void copy_segment(QEMUCPUSegment *d, SegmentCache *s)
>   
>   static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   {
> +    CPUState *cs = env_cpu(env);
>       memset(s, 0, sizeof(QEMUCPUState));
>   
>       s->version = QEMUCPUSTATE_VERSION;
> @@ -325,6 +328,9 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   #ifdef TARGET_X86_64
>       s->kernel_gs_base = env->kernelgsbase;
>   #endif
> +    if (cs->crash_occurred) {
> +        s->is_crash_occurred_cpu = 1;
> +    }
>   }
>   
>   static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,


