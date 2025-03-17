Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE013C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFRH-0001JK-Lw; Mon, 17 Mar 2025 14:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuFR0-00013W-3U
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:43:36 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuFQx-0008H8-N0
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:43:33 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6e904f53151so39153196d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742237010; x=1742841810; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ESVwkCDkXCOxYN2pQSqilpiWCXJX8zShpE2xzWXb6Zw=;
 b=NdStp9Z77Hq737g870rKitRCq5Os3YeffmH+44obyjycpP8AMsroJhXxc5N6llN/A/
 9SP2spqN1oJQ7aZuSo9qtAm3H5ZSZ6dPJ4Z9eASYz+/H80DEiqQntYJkAashtsVAJ1jC
 qtqWzy7af+B8B3cjLcDFZofBqGc+w4ViipuKsXZd8vWUayRLadg/uqtRbR6L94XMCYIT
 zTWQlevjPRkRcZgajnoqR8ihvgWw7YGz1SYJfPHjJTvI3Cb8dUoduayvltA9eXnx2kv1
 2Q8BlPtkzHSxgDb+q9tB58YL4tRn167DEMFpnC19o9Gl4eaAyqt3UvCBDTLTyprddsj8
 lujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742237010; x=1742841810;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESVwkCDkXCOxYN2pQSqilpiWCXJX8zShpE2xzWXb6Zw=;
 b=K+8KHHUeQFleVa1DNr7RkGoaV9bRIf4gDyfuxc1I604YSxz5y5fuQhQ6Y4GHE0jsdi
 uBXSswZ/ybhFTGdwYDoR5CPEU59yeDHKl5WUmkC8FfRR+VKzCrV6fR0uRTgb5VQB2XlO
 HxJSUcoxTyvf6/UQoX6GKzmudjWAPMS2Q4GMYltUCUb6w6sQDCLlY9xjdyUWa3O51gpl
 CwaS8/uyPL18inz0BftbqGu6RcJ0UKX5I7kZu1c8UoIvKlCmvJoMkOKKgVQSuggte4z2
 vEYknT/CJVjDOPngpgIhyB/P5JNHUo3yWsTPS6hJlP7HKW1DgM+s4F5SxTyWYhrs3ZvL
 b9Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTE1I3Ef8nMyLpp6OHGYegPVagAupB7Nnna1cqTP9Ey0kRpYx05M3PpDHINxhkAx0Ox5oOho2gQNdz@nongnu.org
X-Gm-Message-State: AOJu0YzjJS85QP+xW0yjF1IPImY5oMlnkHeIVhkLzvyqSh6il/zG/LrB
 nqFyAxAa0B35Z+xJAW1BiVTCPy7CZx3zXk3wze8Q220Y6RZabWLU
X-Gm-Gg: ASbGnctco4wU4fqnXxv/8D6bLS6ru8zDSvEMJLvQ1EwrpnJwwg2ewWCXQEIafmwKqBF
 CT//PkhWKU7xTMLbMPm+M2g2HpfUzYG3bpWdgIQ7DWX7h2KnK8TiLyeQjQxientSRt9t8oOvaYZ
 LO/bY+QyPzq7Sik+IPRbUZPdWTDWMndTvx5liNXHFBHfx7G1+4D0X01SyMZfP3BzTm8rd8gx4SR
 gtDOydGNp2/mboi72X2Ufi9VvZjOfReMIO0LrM9AgfOay8GMOR7HiE6phDTJ43sFqv3Z1T4CRjT
 ssKEMbJiJC/uQtpQx+hgLAvDiYpWWNtCspFIeCufv1QbsPrD/lkgj1auRbXheyg=
X-Google-Smtp-Source: AGHT+IF3mubNsUQuEIedrC1/hUNlMPhzWKXTlJpos0itxZfQKbbd0tFWF8CijBqa0A7XxH+l076l3g==
X-Received: by 2002:a05:6214:dab:b0:6d8:ab7e:e554 with SMTP id
 6a1803df08f44-6eaeaabea08mr228216496d6.34.1742237010521; 
 Mon, 17 Mar 2025 11:43:30 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade20e1dcsm57897546d6.3.2025.03.17.11.43.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 11:43:30 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-9-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 08/39] target/hexagon: Implement get_exe_mode()
Date: Mon, 17 Mar 2025 13:43:28 -0500
Message-ID: <017501db976c$7a2181c0$6e648540$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQJd1rijsu9Cp2A=
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
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 08/39] target/hexagon: Implement get_exe_mode()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index e64568b9fc..e0dd120cd4 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -237,6 +237,30 @@ void hexagon_ssr_set_cause(CPUHexagonState
> *env, uint32_t cause)
> 
>  int get_exe_mode(CPUHexagonState *env)
>  {
> +    g_assert(bql_locked());
> +
> +    target_ulong modectl = arch_get_system_reg(env,
> HEX_SREG_MODECTL);
> +    uint32_t thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
> +    bool E_bit = thread_enabled_mask & (0x1 << env->threadId);
> +    uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
> +    bool W_bit = thread_wait_mask & (0x1 << env->threadId);
> +    target_ulong isdbst = arch_get_system_reg(env, HEX_SREG_ISDBST);
> +    uint32_t debugmode = GET_FIELD(ISDBST_DEBUGMODE, isdbst);
> +    bool D_bit = debugmode & (0x1 << env->threadId);
> +
> +    /* Figure 4-2 */

Figure 4-2 in which document?

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



