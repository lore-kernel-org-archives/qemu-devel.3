Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40483C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLp6-0005Xy-SC; Thu, 20 Mar 2025 15:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvLp4-0005XZ-OF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:44:58 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvLp0-0000hy-4x
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:44:58 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c2303a56d6so144144085a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742499893; x=1743104693; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gpl8VqK2KQgoYukpGs0vpXGXGjbO8JAQg9pdDjx3Puw=;
 b=BF4nA1rljYvGiR15W/ySZRqMAebSt/Lw8A0G793wp9gW67A7nJXw6p4vndk+h2SWM2
 91Z/0NBCU9tK9MqjV8saTFqkIfR4GMlB7oX/D/Bk75nFeX1XuR8LWUHfBcJVQuuZkpCp
 yBlg8Jbo1YTBlIwnmmM3Gz7NiH1xBF2nIVFYqvqbTkzV4vHp1qmk80YgJx2miqz9PdTu
 mjSISp1BQtwKEBBizyV2TaHv+VE3WHYEn2KoqJNJmGwRzMFot4AbJQF0UVV7H+xzIcvE
 pCmkJKxdmTytLgYbFFc8I5sBjuFYa0KGi/XE3SQU5o7tZTjvyEFx0LrpJ35T9MjYO2B4
 mobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499893; x=1743104693;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gpl8VqK2KQgoYukpGs0vpXGXGjbO8JAQg9pdDjx3Puw=;
 b=XKEH8RLpXpr7VJtj3J2h2/YTP31Nh4n/5TBzM/2fwrPYDRO35krXf5qAMacjZGzJ1w
 0sgychf9B4rqUeS50mMTSnjmSkLW1XLk1mHfSjpWHs+QorhRlQX8JcnFP+ZecrSqTENQ
 fYR8ohR+Is4kF+Mvrn+/2BlqoZN0vbjcgJ8Qg3LXx5zHo1e8kEYngoOQupRZwEI6Obc8
 5V+wszfG2LEkSbuF55zYXooJNSeULMmZqD1TL7YF4g4cWXrBoG3Co5q0i0FrPu7NaC6+
 /8PAmR6M9DttjDrGN23yWVrKevDTXreQokbso2GL3EotQzIK+XfUffvI0trZyHfDvtCA
 SClw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaTGhAZpV1RFfD9NF95xXpP2jka60mghPVUnEJfWKgkyCdPKYqWF6f5SQL9FOyWt5/at0dNlAiYfKV@nongnu.org
X-Gm-Message-State: AOJu0YyzmZfbozN5d8jIHO2GntFxJ7o+SObOShENGKELXz5IuNpMPx6y
 cz21aBmXnTY/DsDsCtD8OG8QteottNybIR4OUy7vQ4rJZ7Flm6X2
X-Gm-Gg: ASbGncsMV0e4/P/Zdl7LcyfxVhfX4sOytJxe57s9gqKy19GGhevS9kXw53dtzQjKPTO
 9TZJk1d9d7xzcY/h/Q4oY0HVEQEZFC8nfwtNUfajsiqmuLXfEvw21UmdAbaQh7jjSniEuJN2+8s
 3Tfy/S7l3Jujw2JHfk6+WlW3jHh7FnCNCCr38eVW1cC1FzxSwW4h069mYxeT4BYuqFPZzyVnUSN
 UVJAsvKa/Qo+zi07lnjRNz0nWu6rBsK5daPkGGjS1QYvosH18tSa4m3NMr0gWbnNWcGy91VABjJ
 tftHHRjwKBhA9tRf1b5eaijLHJ1V0kR1ALp9kboymLjntIvYb6LJ1xlPxY7mAZk=
X-Google-Smtp-Source: AGHT+IGSMtuO3P+9Hkop0A4VL9XWuXOFC+3bUbbAKMaaEiFORKX90KLOzKSYyoLokatKEZ4JYGNXtA==
X-Received: by 2002:a05:620a:269b:b0:7c5:96b4:f5e5 with SMTP id
 af79cd13be357-7c5ba16239fmr61466085a.13.1742499892922; 
 Thu, 20 Mar 2025 12:44:52 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:7462:60e4:5895:7c5f])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b9347bd1sm25610485a.70.2025.03.20.12.44.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:44:52 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-23-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-23-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 22/39] target/hexagon: Implement setprio, resched
Date: Thu, 20 Mar 2025 14:44:51 -0500
Message-ID: <03a101db99d0$8c67c5e0$a53751a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQH8eWrXsvcQspA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250320-10, 3/20/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72f.google.com
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
> Subject: [PATCH 22/39] target/hexagon: Implement setprio, resched
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> The hardware-assisted scheduler helps manage tasks on the run queue =
and
> interrupt steering.
>=20
> This instruction is defined in the Qualcomm Hexagon V71 Programmer's
> Reference Manual - https://docs.qualcomm.com/bundle/publicresource/80-
> N2040-51_REV_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf
> See =C2=A711.9.2 SYSTEM MONITOR.

See earlier discussion on references to documents.

>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 65
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 0dce133d3a..d0dc4afac7 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1465,6 +1465,57 @@ void HELPER(stop)(CPUHexagonState *env)
>      hexagon_stop_thread(env);
>  }
>=20
> +static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
> {
> +    uint32_t schedcfg;
> +    uint32_t schedcfg_en;
> +    int int_number;
> +    CPUState *cs;
> +    uint32_t lowest_th_prio =3D 0; /* 0 is highest prio */
> +    uint32_t bestwait_reg;
> +    uint32_t best_prio;
> +
> +    BQL_LOCK_GUARD();
> +    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
> +    schedcfg =3D arch_get_system_reg(env, HEX_SREG_SCHEDCFG);
> +    schedcfg_en =3D GET_FIELD(SCHEDCFG_EN, schedcfg);
> +    int_number =3D GET_FIELD(SCHEDCFG_INTNO, schedcfg);
> +
> +    if (!schedcfg_en) {
> +        return;
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *thread =3D HEXAGON_CPU(cs);
> +        CPUHexagonState *thread_env =3D &(thread->env);
> +        uint32_t th_prio =3D GET_FIELD(
> +            STID_PRIO, arch_get_system_reg(thread_env, =
HEX_SREG_STID));
> +        if (!hexagon_thread_is_enabled(thread_env)) {
> +            continue;
> +        }
> +
> +        lowest_th_prio =3D (lowest_th_prio > th_prio)
> +            ? lowest_th_prio
> +            : th_prio;
> +    }
> +
> +    bestwait_reg =3D arch_get_system_reg(env, HEX_SREG_BESTWAIT);
> +    best_prio =3D GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
> +
> +    /*
> +     * If the lowest priority thread is lower priority than the
> +     * value in the BESTWAIT register, we must raise the reschedule
> +     * interrupt on the lowest priority thread.
> +     */
> +    if (lowest_th_prio > best_prio) {
> +        qemu_log_mask(CPU_LOG_INT,
> +                "%s: raising resched int %d, cur PC 0x" TARGET_FMT_lx =
"\n",
> +                __func__, int_number, arch_get_thread_reg(env, =
HEX_REG_PC));
> +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO,
> 0x1ff);

What is the significance of 0x1ff?  The field is 10 bits, so this isn't =
setting all the bits.
Should this be lowest_th_prio?

> +        hex_raise_interrupts(env, 1 << int_number, =
CPU_INTERRUPT_SWI);
> +    }
> +}
> +



