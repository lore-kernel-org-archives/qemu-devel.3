Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B8C35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD1Q-000889-3N; Mon, 17 Mar 2025 12:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuD0v-0007xG-7S
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:08:31 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuD0s-0002oL-OE
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:08:28 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6ddcff5a823so32562146d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742227703; x=1742832503; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IgdEPjlewsmW+2amy1A1G3R6y5MEZyL8GrPsazu3OYE=;
 b=LvrS+e7TvTuke7bh4bA1Sgkem/rAtAaX/zM1y00FkP6c8dOZcdvvF53i0JfxOVyCfj
 lC8uC26HZ1Fz1E/S8TqKQta9YdUsJM7MJ/Lrhdsd9ViX73Op2dj4J96A2aNrf9V268L8
 LQFBqK82FR3WsIbpVviPXLCsIa0pBYFc9yTcdJcEFPjL1Kd0M8Ex49FOKYdT3D8G/HOC
 4yRKvzOK2E6+/cFHZ/LcSEFNxnHFRybTzF221UrjmWYiNAAVLz9V73fNIT8qyCl/Bgfp
 HswkKpI6OGnNdj62FtT1uJM3KRtRNG+jdTgKVaJHkr6DlLrM9ea6WLTk4iwXkOTPiLY0
 9Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742227703; x=1742832503;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgdEPjlewsmW+2amy1A1G3R6y5MEZyL8GrPsazu3OYE=;
 b=ZCjGptMn/WHH5lbvbS6fuoisNCCf9AOkxv6F6fveDlMAYD9C5+Pr88vlw1Q42TRDaf
 xXaQ1U0ECsDG+1g+p6G0vN15yBGL021rrQWwmrpHEobS1UZx6f7mvb5855WRon5WExev
 I7WrwUWaNuMAxQfebmz2SPFJQSuGB1oLx4BTnRvrOOlb3z5BHDByCjD1Va4j94aPFhiL
 NdMlAtP13Ngl4me1SR3100kTQFeJhGezGzxRvAO5Q/P9ugutZoRgkeIjY/qBLYhlIbdW
 KM8wP9vWM8p5yeho74u31k51Y9ZShhTx6NKdrwL9Q4yMNjMrIjuLGIk6OU7IMu8GTIXT
 07bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/OF+x4O8LqWq6O96fB5XgOsgFpdFDQ/LKbb7Kj9vhwHO/0TTVkQFHoZiRN7LvP6C/nTKPm6CYr7K@nongnu.org
X-Gm-Message-State: AOJu0YzcZf1+ic6V5Y4zRwKarpzrsLSmKyfrIxUXpG11PRhu+4XZ/eUk
 sC04mkQ2ZRhkg7291hv+uau/wH200y+XwRlaD0K4I2r33MP6Im+v
X-Gm-Gg: ASbGncuO8kyU9BccjYNwbH9NV5CIRHMP4dUQ4AyoyTgBR0FmEFwvdaFcfAK7GFN6M5A
 dXg4Yij/SoEq283BRXP+Vt/BCAFO0WvOxQQm+z4frlVgFB322DulZ0AV3BRZ1XBAQPcSkLVHlTE
 zQUm2c2XACkNQKrjSiozPi9jmeit0k3j/awzdgtjanW12iwzEfEIDDZrtwjYpAGqNbfxlhRcvez
 EvAloTCxU3xeuNwESZg/Hbo9rfAipnh6iZn3/1heJizQnz6sbkpCqdF13c/wpsxTKNyRvK0zSTY
 JwIk25hw1IRVizLWTUptx/LZjPd/L50DP40z4qzVugp3RpZ99KdVk11k2VtWUPs=
X-Google-Smtp-Source: AGHT+IHF9Xb1jPcLradIx+Ry8ouCds6/t1csBkOWpdPNbNuDeOZqylT5kMSYaRJU8rqJb2dPYmxLGg==
X-Received: by 2002:a05:6214:cc7:b0:6e8:9cd3:80d5 with SMTP id
 6a1803df08f44-6eaea9f6459mr185043366d6.13.1742227703037; 
 Mon, 17 Mar 2025 09:08:23 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade330c73sm56050876d6.89.2025.03.17.09.08.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:08:22 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-2-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 01/39] target/hexagon: Implement ciad helper
Date: Mon, 17 Mar 2025 11:08:21 -0500
Message-ID: <016201db9756$cee11240$6ca336c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQIUXHWhsvFjLiA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-2, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf30.google.com
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
> Subject: [PATCH 01/39] target/hexagon: Implement ciad helper
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> ciad is the clear interrupt auto disable instruction.
>=20
> This instruction is defined in the Qualcomm Hexagon V71 Programmer's
> Reference Manual - https://docs.qualcomm.com/bundle/publicresource/80-
> N2040-51_REV_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf
> See =C2=A711.9.2 SYSTEM MONITOR.

Put this reference in somewhere easier to find.  See prior discussion on =
this.

If it's only in the commit comment, it will be lost quickly.

>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 39 ++++++++++++++++++++++++++++++++-
> -----
>  1 file changed, 33 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index fd9caafefc..b28a18adf6 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -34,6 +34,11 @@
>  #include "op_helper.h"
>  #include "cpu_helper.h"
>  #include "translate.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "hex_mmu.h"
> +#include "hw/intc/l2vic.h"
> +#include "hex_interrupts.h"
> +#endif
>=20
>  #define SF_BIAS        127
>  #define SF_MANTBITS    23
> @@ -1338,9 +1343,36 @@ void HELPER(vwhist128qm)(CPUHexagonState
> *env, int32_t uiV)  }
>=20
>  #ifndef CONFIG_USER_ONLY
> +static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, =
int
> +val) {
> +    g_assert((offset =3D=3D L2VIC_VID_0) || (offset =3D=3D =
L2VIC_VID_1));
> +    CPUState *cs =3D env_cpu(env);
> +    HexagonCPU *cpu =3D HEXAGON_CPU(cs);
> +    const hwaddr pend_mem =3D cpu->l2vic_base_addr + offset;
> +    cpu_physical_memory_write(pend_mem, &val, sizeof(val)); }

Careful here - an int is different sizes on 32-bit and 64-bit hosts.  =
Change the type to int32_t or int64_t.

> +
> +static void hexagon_clear_last_irq(CPUHexagonState *env, uint32_t
> +offset) {
> +    /*
> +     * currently only l2vic is the only attached it uses vid0, remove
> +     * the assert below if anther is added

What assert?

> +     */
> +    hexagon_set_vid(env, offset, L2VIC_CIAD_INSTRUCTION); }
> +
>  void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)  {
> -    g_assert_not_reached();
> +    uint32_t ipendad;
> +    uint32_t iad;
> +
> +    BQL_LOCK_GUARD();
> +    ipendad =3D READ_SREG(HEX_SREG_IPENDAD);
> +    iad =3D fGET_FIELD(ipendad, IPENDAD_IAD);
> +    fSET_FIELD(ipendad, IPENDAD_IAD, iad & ~(mask));
> +    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
> +    hexagon_clear_last_irq(env, L2VIC_VID_0);
> +    hex_interrupt_update(env);
>  }
>=20
>  void HELPER(siad)(CPUHexagonState *env, uint32_t mask) @@ -1416,11
> +1448,6 @@ static void modify_syscfg(CPUHexagonState *env, uint32_t =
val)
>      g_assert_not_reached();
>  }
>=20
> -static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, =
int
> val) -{
> -    g_assert_not_reached();
> -}
> -
>  static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t =
vid)
> {
>      g_assert_not_reached();
> --
> 2.34.1



