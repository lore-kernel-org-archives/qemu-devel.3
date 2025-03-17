Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C61FC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGgS-0000zu-HD; Mon, 17 Mar 2025 16:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGgL-0000yw-4c
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:03:30 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGgF-0006qu-Bc
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:03:26 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6e41e17645dso43936826d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742241802; x=1742846602; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Egtsc0sFWRwVmD3JK/DbKozIlUE4CHq8bdS+EkTyx+o=;
 b=OVkzNk7tv7guHy/sfD1oFMFWjOWqMiyeYFe1iLoumuEmSkDsy+g590ibj+kSyh+LY0
 pvqIiulQsKCOYMIlyBziGy/fdkNmpOLMrJ3XudVPZcS7l5wJxG6E3z0M1QQZUcL5OQaY
 b8MDT6McKaT/WXCy5JRyFC2wrNd5n+7+r2im6hZVfeoKyktmpqdcck/cbWdCHQ85maCq
 zgGYItm7Koeuw4jxyKnaXnpV+s+XoKGhafdLhaive59fn4XJxmf58/iYOd1TAwLQz32H
 gLtYXqWCEi80S1UjWLL1+FNS4QCJT37F62CuGie+eRx3XoOeBwkwFtFzhM/uWrIu6/EG
 Qcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742241802; x=1742846602;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Egtsc0sFWRwVmD3JK/DbKozIlUE4CHq8bdS+EkTyx+o=;
 b=EQ5yB8Bccc7DFA6SA4ChB81GjF+i0LCglc5y7Mk07flVU0GIdKYyRWJvBmwQIsZEyp
 Uu4C9PHxuiUjJj5XMOntvjwlDo396aq38nqrRFm5yJGOJiPMGi9vWtnKv7Eb7iTKMnk7
 1OwcPNmyYWSFYT8vTxPsNdvCxmRkgL2z1wKtLQVt+ePtP3u2r2viKrEw0Nr3yvytZzy3
 9jh4WS9ENyC9eGtavhNOOEODvLQwOWJYZol60Fjl7kX5YlaP9SbkglzY7fvy5fIP+iqD
 /CbteSXMFnwj7fwi0Hj/Emxxk6Cl9nRyq07mllJ4vu6JMwKqx8A3YOinSHRB0e8NinMA
 nWWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Xl0MbLFMOX0uN7NDhh0/4MqGDoikOK+ncTFJAJln4g1CReVhXrnSql/7wBuKicv8UGvr0QExM5iE@nongnu.org
X-Gm-Message-State: AOJu0YwFWhiv3kcuWdhkd19siPeIoH/r7G7pSlLbghsDxBiBA5bs8n9t
 DtK9btJ+PYbGl1CyHwr+6AUndiWfIS7eEmYl+w5xxDSy4tcwLHScC9ATuglIkGE=
X-Gm-Gg: ASbGncte6TuxYn//P2uVjGqxe6X2fAKGmY1os/AMjT/FjDTkt7CfyB9CY/2EUMXkLrg
 q9Ha2+KetbzwV9sjh+ej4RSIFBeZThhaebjmEadgLK3OfPbG1QX2yUhCg3xPaWAIGUoOIutzDlb
 0hI3dDfcnxh5hnwXGQaOlRPfl5qTIjLf9hNZ7tHTxeit37v0Amz4zDeobv6gFOifcHXep/k3M/T
 kMs+uf8raKLV7P2RL7XhiYAV8gNKoEgJa6rF3oec1l+JWPfZtdP3S3AwOHHC9w2YDxuxWnVWrrh
 E3qxJSdCuNbiWgXoomGpx68gI6ZpLsmN6YLzvl0YnCcRO8wSd1BRS4E0nRrUnfKDQpagJD0goA=
 =
X-Google-Smtp-Source: AGHT+IEPOKVVTK3W/SzFs4dgy9atWjiiGb+yhnHLaOdkizajMsTfNp/SbDw+ev5eIM5UOVo6G75Ahw==
X-Received: by 2002:a05:6214:5097:b0:6e2:497f:1ec7 with SMTP id
 6a1803df08f44-6eaeaafff86mr195103816d6.41.1742241801973; 
 Mon, 17 Mar 2025 13:03:21 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb60aac8sm57649321cf.15.2025.03.17.13.03.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:03:21 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-25-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-25-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 24/39] target/hexagon: Add exec-start-addr prop
Date: Mon, 17 Mar 2025 15:03:20 -0500
Message-ID: <018601db9777$a2080aa0$e6181fe0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQIiIcu7svE3inA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2f.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 24/39] target/hexagon: Add exec-start-addr prop
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h | 1 +
>  target/hexagon/cpu.c | 7 ++-----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> baa48ec051..4667a1f748 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -194,6 +194,7 @@ struct ArchCPU {
>      uint32_t num_tlbs;
>      uint32_t l2vic_base_addr;
>      uint32_t hvx_contexts;
> +    uint32_t boot_addr;
>  #endif
>  };
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 9f4cfd03c4..7afdcbf9d0 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -66,6 +66,7 @@ static const Property hexagon_cpu_properties[] = {
>      DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
>          0xffffffffULL),
>      DEFINE_PROP_UINT32("hvx-contexts", HexagonCPU, hvx_contexts, 0),
> +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr,
> + 0xffffffffULL),

Don't put a ULL value for a UINT32 property.

Ditto for l2vic-base-addr above (must've missed it when it came in).

>  #endif
>      DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>      DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU,
> lldb_stack_adjust, 0, @@ -362,8 +363,6 @@ static void
> hexagon_cpu_reset_hold(Object *obj, ResetType type)
>      mmu_reset(env);
>      arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
>      hexagon_cpu_soft_reset(env);
> -    memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
> -    memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);

Why are you removing these here?

>      env->threadId = cs->cpu_index;
>      env->tlb_lock_state = HEX_LOCK_UNLOCKED;
>      env->k0_lock_state = HEX_LOCK_UNLOCKED; @@ -372,6 +371,7 @@ static
> void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>      env->next_PC = 0;
>      env->wait_next_pc = 0;
>      env->cause_code = -1;
> +    arch_set_thread_reg(env, HEX_REG_PC, cpu->boot_addr);
>  #endif
>  }
> 
> @@ -414,9 +414,6 @@ static void hexagon_cpu_realize(DeviceState *dev,
> Error **errp)  #ifndef CONFIG_USER_ONLY
>      CPUHexagonState *env = cpu_env(cs);
>      hex_mmu_realize(env);
> -#endif
> -    cpu_reset(cs);
> -#ifndef CONFIG_USER_ONLY

Why are you removing these here?

>      if (cs->cpu_index == 0) {
>          env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>          env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
> --
> 2.34.1



