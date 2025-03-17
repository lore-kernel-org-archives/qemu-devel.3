Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AE0C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFLW-0007c0-Cb; Mon, 17 Mar 2025 14:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuFKy-0006Eq-Np
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:37:23 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuFKt-0006tS-F5
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:37:20 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c53b9d66fdso623672885a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742236630; x=1742841430; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LwCjJvkgRJFGc24hnK4Dgr+1pa7PjvK5Tje+snkwCdQ=;
 b=YyJs5qda5SdYCH9/X/P463ywgAxiw4aBG6jHnzsKDmnEkySY7Bqi9oN9IH38haCm/2
 hG83VaV3gXLR2LNr/8KcB7UvUe0UcM1vdUTcti8T9sha3u9Mhi9pQSMWTYzuipIFBByK
 Sr8HNdB6B1Tj3q/gnWhTGne3itu3hrntyUOR61mlTQShBG//O9awa2hfBQyQsN3uwvhv
 aw9zJicHWbTV+NJGjq+vPsCO32j30qpYnCOVw4TN1DmpYXIY8XrfvSMltNrW06ygwLf5
 6p4Fv1F/whsnSRMRaDwAdLi83WX+pYpQoHTJdM/fHotZ9kNhYpZDfsl4DhSJoM5EdO31
 R3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236630; x=1742841430;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwCjJvkgRJFGc24hnK4Dgr+1pa7PjvK5Tje+snkwCdQ=;
 b=LKtt9QU7iuIx7kSS/55MKM9wXtvUmQRm8aumOJ7cvW2H3b6AwQw5FjodQOjVL+o1at
 uOcfCIAlx3XN3phhm0p2qwWFjJS/natcOISgGWbICWVxoanb03eDga68ltWz7XLSFdrh
 gGgp8iy/haVQkK9bJ8mcZ7i0sqhv6YKsjTm30iYYLzVZo7fO9E04RODiy/rI62Qnmf1M
 h1nuBRxAsdXZa6nzrHGIAUQVu3dcU2akiCDoOn8lDyExV/vFIOIPXiB0aMHy7EJr2TEp
 SFDCmvH+p5atoH6xiL6q8EppjWezmzhyL902uW3fKEl5Suxh+0Ay9O3IB+zJC4DFt6l6
 +Cyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViZmx9UCHQTWbALIqq+U9mR7gTDWyfHaTioTZPvP6aMYTxOjBW69p3RISTBburAcROgwGkuH6+ytNl@nongnu.org
X-Gm-Message-State: AOJu0YwUfGcl7S4/6ShnQt8Zuf4RHydqyO2Y4urEtPpJeH2nm+kZegwW
 lGqNGTcv3BZpNZEQvstnmJTd1JGj9xFhd29RIsUnYWVdzDSP5ELQ
X-Gm-Gg: ASbGnctA4bd6HQoLelgni7GLHQdm6qc9vraN/X46+oA2bJ60UbBizvLqcxgpmE39M1u
 pvFQNJJHlPZslsDcHoyo6PSnMEG7f3oR/PrmaWRc0+Inu94Wg2cO6zSqpzlrOSaRcXeIzlA8Vbu
 f2C6aqjCEWGwtJtJU+6c7du2r3hxBCO+uUd2hPp1g15cq8pqPgyZv9aFLKs5GRj3tYyUkXZIuiT
 0Mshqb03EJN9u2s4kIgQx6x5kidzKULLIJtONfVWDsNYj+DywMJe78ocoHTKHPf/SGOzmhAQpyl
 VCj7LPutt472qA6wn2L3G1idNSi8MAHCOyjsy56mGwMLTQZluPVsTkyHeJ67mCE=
X-Google-Smtp-Source: AGHT+IFOEulDApozyk2gWmaRMpPaTRXrgWbZpIncSYCd5DvKBjDNT94qjC4dwZ4RSJnCBj2mAD+5+A==
X-Received: by 2002:a05:620a:45ac:b0:7c5:5883:8fb3 with SMTP id
 af79cd13be357-7c57c79bb70mr2469347885a.8.1742236630221; 
 Mon, 17 Mar 2025 11:37:10 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c714c0sm617302385a.40.2025.03.17.11.37.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 11:37:08 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-8-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 07/39] target/hexagon: Implement wait helper
Date: Mon, 17 Mar 2025 13:37:07 -0500
Message-ID: <017401db976b$96f4c4c0$c4de4e40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQJPbEjNsu+yZ0A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x731.google.com
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
> Subject: [PATCH 07/39] target/hexagon: Implement wait helper
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h |  1 +
>  target/hexagon/cpu_helper.c | 40
> +++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  |  6 +++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> index 95a0cc0788..e8d89d8526 100644
> --- a/target/hexagon/cpu_helper.h
> +++ b/target/hexagon/cpu_helper.h
> @@ -20,6 +20,7 @@ void clear_wait_mode(CPUHexagonState *env);  void
> hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);  void
> hexagon_start_threads(CPUHexagonState *env, uint32_t mask);  void
> hexagon_stop_thread(CPUHexagonState *env);
> +void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC);
>=20
>  static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t =
reg,
>                                         uint32_t val) diff --git =
a/target/hexagon/cpu_helper.c
> b/target/hexagon/cpu_helper.c index 3e2364a7b0..e64568b9fc 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -71,6 +71,46 @@ void
> hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
>      g_assert_not_reached();
>  }
>=20
> +static void set_wait_mode(CPUHexagonState *env) {
> +    g_assert(bql_locked());
> +
> +    const uint32_t modectl =3D arch_get_system_reg(env,
> HEX_SREG_MODECTL);
> +    uint32_t thread_wait_mask =3D GET_FIELD(MODECTL_W, modectl);
> +    thread_wait_mask |=3D 0x1 << env->threadId;
> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W,
> +thread_wait_mask); }
> +
> +void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC) {
> +    g_assert(bql_locked());
> +
> +    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
> +        (env->k0_lock_state !=3D HEX_LOCK_UNLOCKED ||
> +         env->tlb_lock_state !=3D HEX_LOCK_UNLOCKED)) {
> +        qemu_log("WARNING: executing wait() with acquired lock"
> +                 "may lead to deadlock\n");
> +    }
> +    g_assert(get_exe_mode(env) !=3D HEX_EXE_MODE_WAIT);
> +
> +    CPUState *cs =3D env_cpu(env);
> +    /*
> +     * The addtion of cpu_has_work is borrowed from arm's wfi helper
> +     * and is critical for our stability
> +     */
> +    if ((cs->exception_index !=3D HEX_EVENT_NONE) ||
> +        (cpu_has_work(cs))) {
> +        qemu_log_mask(CPU_LOG_INT,
> +            "%s: thread %d skipping WAIT mode, have some work\n",
> +            __func__, env->threadId);
> +        return;
> +    }
> +    set_wait_mode(env);
> +    env->wait_next_pc =3D PC + 4;
> +
> +    cpu_interrupt(cs, CPU_INTERRUPT_HALT); }
> +

Why not put this in op_helper.c?

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


