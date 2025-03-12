Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD5DC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOvY-0005vh-4Q; Wed, 12 Mar 2025 12:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsOvK-0005uc-87
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:27:16 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsOvI-0003BY-EB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:27:13 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c3bf231660so718159185a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741796830; x=1742401630; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ih08SUSqfG8YzitLeTARkIF9NlGsr61cZET7DD3SbB0=;
 b=CVEARmtKAMJg7vyHId9UXhK0kZmHivmJT2QpyTFd0zl+CVsXPKpECWwcRqyoh3UlOC
 BCF8oMlB8L/PaYQNVBfVdweR8tIIbS1c3YxGejNu/dq8hLfICvc2HhAPcAzwgEWrb/yR
 W9662MxaIRyR7EIBDa8U9BhCAqSRULmWo8JtS4VS2FypveJLkSvkoaxhP+0R91DmBtZA
 d3AR+qrRGFzA2AZL3+Rv3TJGr59Q1ncfOCJi5nvYqpOxy5BvI/wvZyrUcq7t0a8vG0VX
 otTQ/z0Z7J2QEJokzScf+Un18rWlpsrmP3NwjWtRcIfeVeojj5wmwBCkilRcpDi3mC4+
 kM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796830; x=1742401630;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ih08SUSqfG8YzitLeTARkIF9NlGsr61cZET7DD3SbB0=;
 b=kgGIuvt8wj8wPVT+GYaKveUgBX+5sli+sRzqOBQGNPjgnMrBq9KLR2b36avKd57LYP
 HYe87KdteEcJQhwggPV1HGE4Yw/X9hmC584YrwiXjjXMGfEEl6g8UMgan48KBvKjgr5y
 kHLFIf7F2UCQeT8h/ZJwlFunXFG4EZ7n2TLYAKSFOVmGOwWdazUWNXGxcZd6ZaOiJFFi
 TFn0v+U0NaY8QpNzE32eV9fmY8PmmTmiLMYlHv5v79fNqTyrPIrMp4szbDSh5Yl6vxu5
 23uM76lgRjPGZh9xFaqzaR8JfvyBCoFWNZFVlqtglyh38obIL0GRb08jTjsE5V0QVD0R
 C1Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlvOst+xgz+dKJp4CT50eLAcGcgKC/fm+3SEyh8iK7RQOFJEttQRFlJfKwfE7CZwvp88V+TWfYw6Jy@nongnu.org
X-Gm-Message-State: AOJu0Yw+/6tvkz1DMZ9AULwFekysvmb7tPEdPf55GCQfdC3xueY2KyiG
 xMPb98Ghv6JZLUFR3rur7+Uv/geI5icKmZswCz/wNqkzDutAmvtl
X-Gm-Gg: ASbGncsri+4leoP1tlSaDJirzOwFy9izymw1CDCUv9F/2duVGLkenLZwO/W19K0q5AG
 ELhIMLELElODCIhMy1t7Ar+osT+okxeIcbxT/7GdKbsWRTdxatS4aWjFqDGJwaeOb/jlavBRDU3
 B52CX1ViUXnDK2I+6ky9r4tlKm+/sR8acIb2xKBxunirmafRE1Tlmhz48eNawSqpSdyTAsi3QHl
 6gxrqWzTNgKxcDr692N2v4c2QNkFKPQL375HprSJyHsB10ciRZ/sXCLSlAaujB2DdzhEGTMjJR6
 JUnKofOpRy99yUck3Z7Zu3k2MH44Ktji7b5u+IUCtrKJyx7/oqKghs2abVMwl7P7XtpjW6Urfg=
 =
X-Google-Smtp-Source: AGHT+IGv6LcyYIQpMOjV82ATrobnbh0MX94M2PyZJspP3t5MHDz/XuL1W8Enha/WnsDs3vtousMW/g==
X-Received: by 2002:a05:620a:2694:b0:7c5:56c0:a8 with SMTP id
 af79cd13be357-7c556c002e4mr1778294385a.1.1741796830379; 
 Wed, 12 Mar 2025 09:27:10 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:9cc3:cdb3:7013:e1db])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c553c14c37sm490134285a.112.2025.03.12.09.27.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:27:09 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-34-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-34-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
Date: Wed, 12 Mar 2025 11:27:08 -0500
Message-ID: <010a01db936b$9a862d30$cf928790$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgHz2SB/tPRyruA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250312-2, 3/12/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x736.google.com
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Co-authored-by: Matheus Tavares Bernardino
> <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>


> +int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, =
int
> +n) {
> +    CPUHexagonState *env =3D cpu_env(cs);
> +
> +    if (n < NUM_SREGS) {
> +        hexagon_gdb_sreg_write(env, n, ldtul_p(mem_buf));
> +        return sizeof(target_ulong);
> +    }
> +    n -=3D NUM_SREGS;
> +
> +    if (n < NUM_GREGS) {
> +        return env->greg[n] =3D ldtul_p(mem_buf);

Are all of these writable directly without any checks?

> +    }
> +    n -=3D NUM_GREGS;
> +
> +    g_assert_not_reached();
> +}
> +#endif
>  static int gdb_get_vreg(CPUHexagonState *env, GByteArray *mem_buf, =
int
> n)  {
>      int total =3D 0;
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 76b2475d88..fd9caafefc 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1465,6 +1465,17 @@ void HELPER(sreg_write)(CPUHexagonState *env,
> uint32_t reg, uint32_t val)
>      sreg_write(env, reg, val);
>  }
>=20
> +void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg,
> +uint32_t val) {
> +    BQL_LOCK_GUARD();
> +    sreg_write(env, reg, val);
> +    /*
> +     * The above is needed to run special logic for regs like syscfg, =
but it
> +     * won't set read-only bits. This will:
> +     */
> +    arch_set_system_reg(env, reg, val); }

Does the hardware allow the debugger to do this?

> +
>  void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg,
> uint64_t val)  {
>      BQL_LOCK_GUARD();
> @@ -1508,6 +1519,11 @@ uint32_t HELPER(sreg_read)(CPUHexagonState
> *env, uint32_t reg)
>      return sreg_read(env, reg);
>  }
>=20
> +uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg) {
> +    return sreg_read(env, reg);
> +}
> +

Why not just use sreg_read?



