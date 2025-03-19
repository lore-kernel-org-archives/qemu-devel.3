Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330DBC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 21:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv0il-0001jn-VT; Wed, 19 Mar 2025 17:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv0ij-0001j0-9K
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:13:01 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv0ih-0006w0-8q
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:13:00 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c5aecec8f3so22818585a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742418778; x=1743023578; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ksCoZ4stXzvkpd2v3LVnQ+LDA81qK+FExxdnxBDu70c=;
 b=i3OYlcBMCpF7oOmJMU59KQuF9AI6lT+OUKsyu3zEwrIqqgqDWiWHlS4eBHJTJFBoiJ
 WNIAr27NEoBv4SqzNgjiKZuXwB6zne0GVACZxEEfHg4fV9rwGtOknUYDCJx/Wrn2pbVP
 I8lfg2XQVBVTS+yU8PLrixnm1aEoKwk2MTAm57QAnT3aDDDhMCokwTW5TeAv+DT9y9pQ
 HQ7zIc5Kb2W3dUxqU38nP+wQ2qzLIOEaCG9sUwMdbVr+cXq0o1XY/j/nvqeRM7fZzFvl
 U9l33GTygkte/RUAcqZc9M+7wPGVcYt2q7OEKF14CdDl8nCdqfHyDzy1iBb+YUr1dC4P
 Xkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742418778; x=1743023578;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ksCoZ4stXzvkpd2v3LVnQ+LDA81qK+FExxdnxBDu70c=;
 b=RMD19dkP7Yak9jEFaukSzpvsGAoPca07dwbWBWdWtPUa3vmAfTwXpYi2rjZN7f0ACF
 cw7iXE0DlTLNNQoXhqzfKozPmiiR314LoopKXfaHh5o3bhRd+yWtDQ75mpNsdpV2MjGV
 Q5dEXP3a22uxYJIPFoluDa2l0dyIHisRAFPtvyacn3F08ydexrv+oJZbo7xYUmicGpCQ
 gNYbaHECJrnbwZ/vkmS8+mTLle0DrL1PgF7rarlNZz6AFAaHKyMnETxg15ZupbdiiD1g
 B1wMohdCaGgKCggO93oUfqt7U5SCsFbvpDowaUP46VnSQsIKsB+xu8D5hzzhORcvrflO
 8Gjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz5fmGcFgdQh2bAdQhETfNhnMw2nvk/1kyRRRAO7cv5M0heejWc6tcBA1AVcoN1ncaU1lIHsNz9lD9@nongnu.org
X-Gm-Message-State: AOJu0YznbEQSXtMWcsdD/3YEdkYzA7h03ZfInkbdzdUPl5SQEun2xh9l
 H7eU1bucmXmRHEkpxFwnFSDvRhXgw/vgSWDBCEoxOsRx72F94+EP
X-Gm-Gg: ASbGnctwxt7tGiH9oWcfbWFNBVGDFpW7eTIBrIvyUqpTRAXpVbwPMho9eJ2yGD4wzUp
 8tduvPy+CDaYEiyzxHl4guQ+6WRiTq2CJAbujuDqOf//LSYSGY8Vm0DKDnWMeCmJvYyVjBR3jxj
 PB9E6HVVrRA3b9erQYf9fm8HLyKQiWKsiieeH/LxswOJfBCbNpLhSnSC3YmSWeejBLOK5WBcaMf
 VJsrj/MCAjBoTPmkvJiQYVVvGxqhKWw8OxcI1RZzMI2StajOr5+z955pXz6HBd/w9bVEvnbNqdY
 CpZroHVn9VE4ddgp880csPOIiEkNuXT6bCeQnstgbij1jnG6QgDmtehJfreBLcVs7Ki2yFAY
X-Google-Smtp-Source: AGHT+IFaozbBdzucXF7Xhojt8ER/wYvZaPJqinVmY5HAW7WfTQtoGH4EP0r/A5jVvCc885o6Wk78Ew==
X-Received: by 2002:a05:620a:578:b0:7c5:5fa0:460c with SMTP id
 af79cd13be357-7c5a83d3f62mr540127985a.31.1742418777567; 
 Wed, 19 Mar 2025 14:12:57 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c73273sm905160385a.27.2025.03.19.14.12.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 14:12:57 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-14-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-14-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 13/39] target/hexagon: Implement modify_syscfg()
Date: Wed, 19 Mar 2025 16:12:55 -0500
Message-ID: <02db01db9913$afa44b90$0eece2b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQFIT0Lusvs6OBA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x732.google.com
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
> Subject: [PATCH 13/39] target/hexagon: Implement modify_syscfg()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 51
> +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 03bed11f6e..42805d0f1d 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1522,7 +1522,56 @@ static bool
> handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
> 
>  static void modify_syscfg(CPUHexagonState *env, uint32_t val)  {
> -    g_assert_not_reached();
> +    g_assert(bql_locked());
> +
> +    uint32_t old;
> +    uint32_t syscfg_read_only_mask = 0x80001c00;
> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +
> +    /* clear read-only bits if they are set in the new value. */
> +    val &= ~syscfg_read_only_mask;
> +    /* if read-only are currently set in syscfg keep them set. */
> +    val |= (syscfg & syscfg_read_only_mask);
> +
> +    uint32_t tmp = val;
> +    old = arch_get_system_reg(env, HEX_SREG_SYSCFG);

This is the same as syscfg declared above

> +    arch_set_system_reg(env, HEX_SREG_SYSCFG, tmp);

Why is tmp needed?  Just use val here.

> +
> +    /* Check for change in MMU enable */
> +    target_ulong old_mmu_enable = GET_SYSCFG_FIELD(SYSCFG_MMUEN,
> old);
> +    uint8_t old_en = GET_SYSCFG_FIELD(SYSCFG_PCYCLEEN, old);
> +    uint8_t old_gie = GET_SYSCFG_FIELD(SYSCFG_GIE, old);
> +    target_ulong new_mmu_enable =
> +        GET_SYSCFG_FIELD(SYSCFG_MMUEN, val);

Move these declarations to the beginning of the function.

> +    if (new_mmu_enable && !old_mmu_enable) {
> +        hex_mmu_on(env);
> +    } else if (!new_mmu_enable && old_mmu_enable) {
> +        hex_mmu_off(env);
> +    }
> +
> +    /* Changing pcycle enable from 0 to 1 resets the counters */
> +    uint8_t new_en = GET_SYSCFG_FIELD(SYSCFG_PCYCLEEN, val);
> +    CPUState *cs;

Move the declarations to the beginning of the function

> +    if (old_en == 0 && new_en == 1) {

You could put declaration of cs here if you prefer

> +        CPU_FOREACH(cs) {
> +            CPUHexagonState *_env = cpu_env(cs);
> +            _env->t_cycle_count = 0;

I'm not a fan of _env as a variable name.  Just do
    cpu_env(cs)->t_cycle_count = 0

> +        }
> +    }
> +
> +    /* See if global interrupts are turned on */
> +    uint8_t new_gie = GET_SYSCFG_FIELD(SYSCFG_GIE, val);

Move the declaration to the beginning

> +    if (!old_gie && new_gie) {
> +        qemu_log_mask(CPU_LOG_INT, "%s: global interrupts enabled\n",
> __func__);
> +        hex_interrupt_update(env);
> +    }
> +
> +    if (qemu_loglevel_mask(LOG_UNIMP)) {
> +        int new_v2x = GET_SYSCFG_FIELD(SYSCFG_V2X, val);
> +        if (!new_v2x) {
> +            qemu_log("HVX: 64 byte vector length is unsupported\n");
> +        }
> +    }
>  }
> 
>  static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
> --
> 2.34.1



