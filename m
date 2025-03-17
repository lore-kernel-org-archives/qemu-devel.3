Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9251C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGDB-0000Jy-PP; Mon, 17 Mar 2025 15:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGD5-0000Ip-Hl
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:33:18 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGD3-00017d-6s
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:33:14 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so49000991cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742239991; x=1742844791; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HeYZIL0ixQ31gfTnjP60azV5e0wS34Gr073he7z+zuU=;
 b=SuH8pCdzBAw4zKoPbEdDPBFGiRThtzK3lG1VEIxgl3sQq/4DY2ex7KNWkA5jolnfld
 74QGXcari0HUhusyUvG8qHmdrlSkUuwrEkgVfynkUabxu3XiRfd7gOv522hPPaicHO4X
 gF/gUOpnsRqO+5ajGzZqedjHhthnUbeKYbmbZzW3UnAlKAb6WMO7e8AnDFHC5+3DDpbo
 ATrQFgGloLtzt8kPM5uPJqwvxAT0o9VOPA3s2EQjAhvcRfbYU013/Ob2qlkehYC/0nAA
 Ufg24VPUMi1jGotRVv/JGz89MwBvIZJnkamKS7UvM/ZS/xf4mUX8ph8eNQo2K26NdBuz
 kBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742239991; x=1742844791;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HeYZIL0ixQ31gfTnjP60azV5e0wS34Gr073he7z+zuU=;
 b=HaNk9AqZH8KgciImUQqgH9GuJRLLW1O4O2WxYrufbtG9+nrcZKLBA0jvqE2IryUs/P
 Q8JAlYhNZLcbAoEA74ZaVk+v+YpkiNRcAzxMfDlTE0gyisYHILyQU8CXGzWIAAwY6xre
 FUA/Up6fUOm/8GHiNxA9erpDx+KVO/AlZnnmmZZnbED1/nIXqGqjdBeN7IuMDLD1C+K7
 q7p9sUNpYRnT8usDntY+rDr+Ou0s6uYBZODEhugy0w4QIlKg8syClyxY+YPi0E4XY2p3
 UywYj3LPsczcDO19amiO/MBNzwSxPLnfJTVeoJ0gARjiC8NlEBb7s1kz95vWfi0IN3Z5
 JGaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/TeIdt1IsqR1lGNbv5BAX9LtDkHKB86S2pJxFPbBR2bRxCQNlcxxJ5aXUVMHnAKnIkAxzr0zqmVYi@nongnu.org
X-Gm-Message-State: AOJu0YwIDRHCPgcEezsPyJsHRT9EdjxLXKPVcGfEcalWNeWnICqT+vOY
 EYwwEXJzk1qvtQpAFh2tYaQW9pX+RJmtdLqxY83IhrdhIRhy2D/Y
X-Gm-Gg: ASbGnctEiZU/8MbIpa0D0lX9hclXrFXu+fg39BWgpqirwm0Xj1hGt76Sqm2gsgbsLW+
 z9C/ssInPEx/rsE1QlQnbiZ5TjjT+jdkENlocnhY9HxZPcBBrxo6wspk/0wG+hAa4INuEQC7fQW
 LrxIpUlcCvPx1jtyXxBaJRmRzuJ+txR5rNYo8Fh3V+82ucZCFggIL6DqGqOBa+i2AcuGovjbdc3
 1FTaNspFyHFMY7arhCMhTHiwxiXvy+IW7UheFbMASRdvks/IPMp7mKolaRNjQJ81nIR9ACjY9hh
 Y5RM7tIxcm48zhlwEpoiJoWGnMsXftqiF4iQVb3THF8H4HB+1749Gi6f9531Rsg=
X-Google-Smtp-Source: AGHT+IHIWPUIYBL5edr07zfRqIexWs8PAAfLkTZVYV0MX/QuqYVx709v6T+KzDJUQ7UNdFrpjSrmkg==
X-Received: by 2002:a05:622a:2507:b0:476:9e82:6515 with SMTP id
 d75a77b69052e-476fc9b46eemr13506881cf.23.1742239991282; 
 Mon, 17 Mar 2025 12:33:11 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb611c83sm57423131cf.2.2025.03.17.12.33.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:33:10 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-12-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-12-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 11/39] target/hexagon: Add representation to count cycles
Date: Mon, 17 Mar 2025 14:33:09 -0500
Message-ID: <017e01db9773$6ac9e0d0$405da270$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQG2Ccj6svSOcwA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x835.google.com
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
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 11/39] target/hexagon: Add representation to count cycles
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> The PCYCLE register can be enabled to indicate accumulated clock cycles.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h     |  3 ++-
>  target/hexagon/cpu.c     |  3 +++
>  target/hexagon/machine.c | 25 ++++++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> 1549c4f1f0..4b9c9873dc 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -113,7 +113,8 @@ typedef struct CPUArchState {
>      target_ulong stack_start;
> 
>      uint8_t slot_cancelled;
> -
> +    uint64_t t_cycle_count;
> +    uint64_t *g_pcycle_base;
>  #ifndef CONFIG_USER_ONLY
>      /* Some system registers are per thread and some are global. */
>      target_ulong t_sreg[NUM_SREGS];
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 84a96a194b..89a051b41d 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -335,6 +335,7 @@ static void hexagon_cpu_reset_hold(Object *obj,
> ResetType type)
> 
>      if (cs->cpu_index == 0) {
>          arch_set_system_reg(env, HEX_SREG_MODECTL, 0x1);
> +        *(env->g_pcycle_base) = 0;

See discussion on shared resources.

>      }
>      mmu_reset(env);
>      arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index); @@ -396,10
> +397,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error
> **errp)  #ifndef CONFIG_USER_ONLY
>      if (cs->cpu_index == 0) {
>          env->g_sreg = g_new0(target_ulong, NUM_SREGS);
> +        env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));

Shared resource ...

>      } else {
>          CPUState *cpu0 = qemu_get_cpu(0);
>          CPUHexagonState *env0 = cpu_env(cpu0);
>          env->g_sreg = env0->g_sreg;
> +        env->g_pcycle_base = env0->g_pcycle_base;

Shared resource ...



