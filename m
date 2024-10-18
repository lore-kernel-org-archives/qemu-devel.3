Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973B8D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1k7I-00058U-Gi; Fri, 18 Oct 2024 06:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1k7G-00057Z-5B
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:21:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1k7C-0005uA-Lf
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:21:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so20479645e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729246909; x=1729851709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqlK3DAA4/TwUHchhRRT9ReLmEAxZ1AgMfxWbya0hBI=;
 b=RNlc3FMWvvDUJWHrNh3kCi9s5EJC4SsDLRQ3ZlBpYjWvpQi3cd2+5Fo9bKCG9Rixz0
 4BRdlYj3XkRJpyaP9pT7qEkCdYDtvI0ulEkfv53tIE1BohnlZZxY/kOVTp6ht4z69leg
 +jV4A3BQBP85twNM9F/KCF0+3xNrfp8fHNuYf59AfjP7hAGHTKsad2b29sJyE8P4Gr0f
 a499Sr5NcQM0XATczVMTL0hEGL88QitvjErVSQWrcyXdbAHPp4TPMUuaL5SuM3XYoja+
 a/9S2iwBhQMXcXVj9oRs0p6ifiYVDdFSZJEcEZo4PNsQR7VNO98CG2z6n2dFzZ9dldRi
 6JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729246909; x=1729851709;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cqlK3DAA4/TwUHchhRRT9ReLmEAxZ1AgMfxWbya0hBI=;
 b=I6YN/NujofEDWMkABeGOEEiaefXfSIvZpe6veJUEGGz7D0681gFzsNxZeIw2TgjFaP
 Ij6zU+UWXbuvB6X0ccIqsPn4Lgnx0Te1wgN0nQFXytGSc4UgoL3Pp7Y8fYfTOwIOhjQ1
 dwruYsAIBIaflhRPL/KgzbajBQEFa9QoGDf6koIRa0Y0r5NpIaIq4l/MbMhmw3AAeOWo
 IJxbmpsrn3mNJ3GADlyHmo/sGSbYMfr9g9ML+9MI3MVIEB9oah7QxOZrBosS/+HqZCrS
 e6G3lCcETzC2ZK0qz4RlBt/ZROCeOu5FnVMW4sdCkHpg5As2AIvZ77BJs1Tzcx316yCr
 zjjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp40ZBcjx0026XQfLT1lutBbXrthLKADlSTliGp38H50cxvcwymR98S+rGqybrigqNtxV+dtplHA61@nongnu.org
X-Gm-Message-State: AOJu0YwpRZ1dl0uJyr28daBOc7+v5urc38DfdsfA6UmAJ6mQazmHSMWA
 qIqcJz0uc1u9XAryjyfV73OkiPnJhCNnlOfxbZ+65t9yjNU+om/51zLNAP6eiLM=
X-Google-Smtp-Source: AGHT+IG5CW/fSeqpRUgVPbOZ+sJqcG9+c7heJ8Pv4nPyOwTfYQwxQg92O/WshksBpy/g6Nnkr/w31A==
X-Received: by 2002:adf:f186:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-37eab6ef33amr1408412f8f.31.1729246908761; 
 Fri, 18 Oct 2024 03:21:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf06d487sm1529271f8f.46.2024.10.18.03.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 03:21:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25E205F863;
 Fri, 18 Oct 2024 11:21:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH] target/arm: Don't assert in regime_is_user() for E10
 mmuidx values
In-Reply-To: <20241017172331.822587-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 17 Oct 2024 18:23:31 +0100")
References: <20241017172331.822587-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 11:21:47 +0100
Message-ID: <87plnx90ec.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In regime_is_user() we assert if we're passed an ARMMMUIdx_E10_*
> mmuidx value. This used to make sense because we only used this
> function in ptw.c and would never use it on this kind of stage 1+2
> mmuidx, only for an individual stage 1 or stage 2 mmuidx.
>
> However, when we implemented FEAT_E0PD we added a callsite in
> aa64_va_parameters(), which means this can now be called for
> stage 1+2 mmuidx values if the guest sets the TCG_ELX.{E0PD0,E0PD1}
> bits to enable use of the feature. This will then result in
> an assertion failure later, for instance on a TLBI operation:
>
> #6  0x00007ffff6d0e70f in g_assertion_message_expr
>     (domain=3D0x0, file=3D0x55555676eeba "../../target/arm/internals.h", =
line=3D978, func=3D0x555556771d48 <__func__.5> "regime_is_user", expr=3D<op=
timised out>)
>     at ../../../glib/gtestutils.c:3279
> #7  0x0000555555f286d2 in regime_is_user (env=3D0x555557f2fe00, mmu_idx=
=3DARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
> #8  0x0000555555f3e31c in aa64_va_parameters (env=3D0x555557f2fe00, va=3D=
18446744073709551615, mmu_idx=3DARMMMUIdx_E10_0, data=3Dtrue, el1_is_aa32=
=3Dfalse)
>     at ../../target/arm/helper.c:12048
> #9  0x0000555555f3163b in tlbi_aa64_get_range (env=3D0x555557f2fe00, mmui=
dx=3DARMMMUIdx_E10_0, value=3D106721347371041) at ../../target/arm/helper.c=
:5214
> #10 0x0000555555f317e8 in do_rvae_write (env=3D0x555557f2fe00, value=3D10=
6721347371041, idxmap=3D21, synced=3Dtrue) at ../../target/arm/helper.c:5260
> #11 0x0000555555f31925 in tlbi_aa64_rvae1is_write (env=3D0x555557f2fe00, =
ri=3D0x555557fbeae0, value=3D106721347371041) at ../../target/arm/helper.c:=
5302
> #12 0x0000555556036f8f in helper_set_cp_reg64 (env=3D0x555557f2fe00, rip=
=3D0x555557fbeae0, value=3D106721347371041) at ../../target/arm/tcg/op_help=
er.c:965
>
> Since we do know whether these mmuidx values are for usermode
> or not, we can easily make regime_is_user() handle them:
> ARMMMUIdx_E10_0 is user, and the other two are not.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e4c93e44ab103f ("target/arm: Implement FEAT_E0PD")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 299a96a81a7..fd8f7c82aa3 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -963,6 +963,7 @@ static inline uint32_t regime_el(CPUARMState *env, AR=
MMMUIdx mmu_idx)
>  static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
> +    case ARMMMUIdx_E10_0:
>      case ARMMMUIdx_E20_0:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_MUser:
> @@ -972,10 +973,6 @@ static inline bool regime_is_user(CPUARMState *env, =
ARMMMUIdx mmu_idx)
>          return true;
>      default:
>          return false;
> -    case ARMMMUIdx_E10_0:
> -    case ARMMMUIdx_E10_1:
> -    case ARMMMUIdx_E10_1_PAN:
> -        g_assert_not_reached();
>      }
>  }

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

