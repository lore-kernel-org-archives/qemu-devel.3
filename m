Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CA1E83830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 20:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5TO-0007O0-4P; Mon, 16 Feb 2026 15:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vs5TM-0007Mt-G7
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 15:45:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vs5TJ-0007BM-JR
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 15:45:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48375f10628so20371105e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771274730; x=1771879530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NA154KD38aNvhHzLvJhS6XIR9Dy0bugG6Y4r1fssa4Y=;
 b=EdkLBqc3TC9Zt1cWNTTxguXe6C3MPs6Ae+Aj5uoq7JluroZBuRepzKe5kn0CdC/QrO
 tcnrXZluXPquJ0q3htn/9ahMyimmz1RCQ8eL61S7PU8nLqeFZcNcyhwKvDWeJSIrgXTR
 KWUwXGOXb8Aim8KeCc5Idlyb3GFCFXyAM0OqMyUwAVh3HQS1qFJKVYNiYojmSUGy+00Q
 V4VWS/CmduK8PQi+/IZBftDCWjw2UcEidExiGFVS1+mSZPSp0sgecUI7VB01gYelOqlO
 iN+zYadVebcrNGE/Izf+YMbUd8YQppFeQjYVs6qKpJFwPYjGVYDHAXBBSCIatENk+xqc
 P5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771274730; x=1771879530;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NA154KD38aNvhHzLvJhS6XIR9Dy0bugG6Y4r1fssa4Y=;
 b=eM7rrphmdOwbysa9OytR0+Lkar2uvJOVgJ4BUMX5ZZ9pGv/84OnZldUMRXJtKRvvyl
 +GLCPMBky0YzPFCnoa242odCXC4rkf0wetnn2IGqFRdLryKz5Nk3v5WK/ARx+qq4EmiF
 5xdiVrwHFTJJZVDRAwRwbKGBwreEvV+xXV/OQymy8cc5YL8y2gRT8mT6Iqx1oD0EagI9
 V4Me+sMLaBMvM84HQvliu1yAD5Q9BMTf7mVQQE6UzHxYvWeyNj8sVpgNTCxxKLmZUn6q
 HMRtsh25UUfi9V/70g87keM1lsuVtvCCdxtRYu/ceuEG8SutM8SeOhNdVxXfY2zNUqgx
 WDLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRcgFeV6k71/vkujbXj5Qmbh9G0fhAPyHK6IKeZc9Uz9reQhd+Cn9I/4wwnO8gBZNVTYZ5Xiwnj7+I@nongnu.org
X-Gm-Message-State: AOJu0YwR1Oz/Td1+9Lp+U8d4aAO3nat2koVPRevr+lKuR5Rvgci8Y8KI
 Q/LOQQsP0RCaYsE4T2ImNzMqzFz+MvO0xxaZWDgaONlOtuNlh1nU79dH
X-Gm-Gg: AZuq6aJnhe0cPsmqtsmwXmkjOsTHKXulRcY9Tp5nt1gEO/krDRd6p7sHquQuJHh5q/5
 KfSmZJFTf8hQAjlnAMdxiuiNbO3TdgYsYO19LNe8WA67S4rSNKw6KlOOmXBcVxfArU55yyU+VOR
 3i2m9ztHof+GcfpEPo/i7jD6qV2hICa1r0eK+GZR1Z1iTS3sjr74pG3LKLFMpfoOnpTLODn0qtK
 Tyxzdo4JU5bLfL+INnTegLNjRdJUzMy3yO5/dMyS3Od3kku4pGLGJyRSy1duKtXYSRavChLXsei
 ivOv/sBuB+7AYg28YZhdS7iTfJCpcRIQsSKS9+jSgJmXjVA3WPZW2xdp6tsW9uZxXUohVnlMNgL
 uwjtr713WOLWFc15Yyf/AqgwLS4K5s6d5UDuBUHl11Ouj3ExF/bLSWI17wQ/sTbS2PHSHX3W5xT
 tBwsZB19DiSuFaTDnhwUesniwAA2s7TuluM4JNWugGTqhQHdcwUFRnCh5BWAJVH7aX0GYhekD/I
 K1lAZUo5N0paAZ/mWL6vb1RTmc8mS/F99ZMCGJs8kgfmQ==
X-Received: by 2002:a05:600c:198e:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-48373a38293mr213499215e9.18.1771274730251; 
 Mon, 16 Feb 2026 12:45:30 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2363-0f00-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:2363:f00:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4c4sm755558265e9.10.2026.02.16.12.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 12:45:29 -0800 (PST)
Date: Mon, 16 Feb 2026 18:45:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
CC: Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_08/14=5D_whpx=3A_move_whpx?=
 =?US-ASCII?Q?=5Fget=5Freg/whpx=5Fset=5Freg_to_generic_code?=
In-Reply-To: <20260215052225.22513-9-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
 <20260215052225.22513-9-mohamed@unpredictable.fr>
Message-ID: <8423E1CF-83F9-478E-99C6-DF38C689F43F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 15=2E Februar 2026 05:22:19 UTC schrieb Mohamed Mediouni <mohamed@unpre=
dictable=2Efr>:
>These will be used in the next commit on the x86_64 backend too=2E
>Also move flush_cpu_state as it's used by get_reg/set_reg and the arm64 c=
ode=2E
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>---
> accel/whpx/whpx-common=2Ec     | 35 +++++++++++++++++++++++++++++++++++
> include/system/whpx-common=2Eh |  3 +++
> target/arm/whpx/whpx-all=2Ec   | 35 -----------------------------------
> 3 files changed, 38 insertions(+), 35 deletions(-)
>
>diff --git a/accel/whpx/whpx-common=2Ec b/accel/whpx/whpx-common=2Ec
>index c57a0d3f0f=2E=2Ec2263c2496 100644
>--- a/accel/whpx/whpx-common=2Ec
>+++ b/accel/whpx/whpx-common=2Ec
>@@ -46,6 +46,41 @@ static HMODULE hWinHvEmulation;
> struct whpx_state whpx_global;
> struct WHPDispatch whp_dispatch;
>=20
>+void flush_cpu_state(CPUState *cpu)
>+{
>+    if (cpu->vcpu_dirty) {
>+        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>+        cpu->vcpu_dirty =3D false;
>+    }
>+}
>+
>+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VAL=
UE* val)
>+{
>+    struct whpx_state *whpx =3D &whpx_global;
>+    HRESULT hr;
>+
>+    flush_cpu_state(cpu);
>+
>+    hr =3D whp_dispatch=2EWHvGetVirtualProcessorRegisters(whpx->partitio=
n, cpu->cpu_index,
>+         &reg, 1, val);
>+
>+    if (FAILED(hr)) {
>+        error_report("WHPX: Failed to get register %08x, hr=3D%08lx", re=
g, hr);
>+    }
>+}
>+
>+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VAL=
UE val)
>+{
>+    struct whpx_state *whpx =3D &whpx_global;
>+    HRESULT hr;
>+    hr =3D whp_dispatch=2EWHvSetVirtualProcessorRegisters(whpx->partitio=
n, cpu->cpu_index,
>+         &reg, 1, &val);
>+
>+    if (FAILED(hr)) {
>+        error_report("WHPX: Failed to set register %08x, hr=3D%08lx", re=
g, hr);
>+    }
>+}
>+
> /* Tries to find a breakpoint at the specified address=2E */
> struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address)
> {
>diff --git a/include/system/whpx-common=2Eh b/include/system/whpx-common=
=2Eh
>index b86fe9db6e=2E=2E5bce33e336 100644
>--- a/include/system/whpx-common=2Eh
>+++ b/include/system/whpx-common=2Eh
>@@ -20,6 +20,9 @@ int whpx_first_vcpu_starting(CPUState *cpu);
> int whpx_last_vcpu_stopping(CPUState *cpu);
> void whpx_memory_init(void);
> struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address)=
;
>+void flush_cpu_state(CPUState *cpu);

Now that flush_cpu_state() is exported we should better prefix it with "wh=
px_" to avoid name clashes=2E

With this fixed:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VAL=
UE* val);
>+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VAL=
UE val);
>=20
> /* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
> #define WHPX_INTERCEPT_DEBUG_TRAPS 1
>diff --git a/target/arm/whpx/whpx-all=2Ec b/target/arm/whpx/whpx-all=2Ec
>index d52580a082=2E=2Ec8d71a252e 100644
>--- a/target/arm/whpx/whpx-all=2Ec
>+++ b/target/arm/whpx/whpx-all=2Ec
>@@ -274,14 +274,6 @@ static struct whpx_sreg_match whpx_sreg_match[] =3D =
{
>     { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
> };
>=20
>-static void flush_cpu_state(CPUState *cpu)
>-{
>-    if (cpu->vcpu_dirty) {
>-        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>-        cpu->vcpu_dirty =3D false;
>-    }
>-}
>-
> HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
> {
>     if (exceptions !=3D 0) {
>@@ -314,33 +306,6 @@ void whpx_arch_destroy_vcpu(CPUState *cpu)
>     /* currently empty on Arm */
> }
>=20
>-static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGIS=
TER_VALUE* val)
>-{
>-    struct whpx_state *whpx =3D &whpx_global;
>-    HRESULT hr;
>-
>-    flush_cpu_state(cpu);
>-
>-    hr =3D whp_dispatch=2EWHvGetVirtualProcessorRegisters(whpx->partitio=
n, cpu->cpu_index,
>-         &reg, 1, val);
>-
>-    if (FAILED(hr)) {
>-        error_report("WHPX: Failed to get register %08x, hr=3D%08lx", re=
g, hr);
>-    }
>-}
>-
>-static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGIS=
TER_VALUE val)
>-{
>-    struct whpx_state *whpx =3D &whpx_global;
>-    HRESULT hr;
>-    hr =3D whp_dispatch=2EWHvSetVirtualProcessorRegisters(whpx->partitio=
n, cpu->cpu_index,
>-         &reg, 1, &val);
>-
>-    if (FAILED(hr)) {
>-        error_report("WHPX: Failed to set register %08x, hr=3D%08lx", re=
g, hr);
>-    }
>-}
>-
> static void whpx_get_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALU=
E *val)
> {
>     struct whpx_state *whpx =3D &whpx_global;

