Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC37CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu8j0-0006fB-K6; Thu, 04 Sep 2025 08:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uu8is-0006e1-1l; Thu, 04 Sep 2025 08:05:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uu8ij-0002G5-IG; Thu, 04 Sep 2025 08:05:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3da4c14a5f9so1300694f8f.0; 
 Thu, 04 Sep 2025 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756987533; x=1757592333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufZsmMFnzrfsnrJ0QfuR5ArbfcZcnQouoWareruaNfg=;
 b=Gx+01y5ET72nTf3OHYkHqPF5nD1R1Ek/IyzjeHHeXKFb0yGS8n33dvpXgwOHVzuzuY
 2TcA6KktC+nNWNugeohShhB3CcO/VmyHH8UlaxJg4yfEaVMWvzZZqYf6U/B9cJjiOrNL
 ZxswRXnwgYrzaMbj3X8/b3Mf+p5fY+9cRD3XCGG2WmBuV+d6MO/d9Kw4rl9rVX+Qtdnk
 J6NafII4YEfXtfCYz1FOHu6hySCwqjP7W6zW3HVkcNts3eVcSkWmQZm4dplq7FfWVioa
 eyvD0UZQQrWwrL+Pm7NQ9pGE4Jtc2rtAsQkXMM7JTtoOtETStKNeD2Wl0+mSOlVz/G/S
 8DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756987533; x=1757592333;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufZsmMFnzrfsnrJ0QfuR5ArbfcZcnQouoWareruaNfg=;
 b=M+IRq7fZVjU4XnsEMY0suSHdBp9hvoBG4ZVbSpqJBGuxmhT/v5R9+EQH73xp4IM3gu
 VogqgDC8hoZT7LEuUe2F7v4JmDrVVKPemhEw3tuY82GKE+NZQLbKmairKrlv49111dbl
 cw7ECIqh77EQakCno6T4uB3/eqrXlJlNg+q/7SL45EkDwoA1Jnp8TCv6FaeElopEoXu8
 t/+WcArfxXUDVP6DQDeOEVpq7JIlISJi/P6gL3QhkSfivF/YN5wvHEXg1zU7+aNmSJMs
 DWPchFkUF5cSDwu7Qd88CmAfn+P+obLgudTY+twW2vN5MfCTnaArKtrNiqfHb2DAVEzZ
 hFzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDxUAu7BgnOkR/dvBc/3I+g5QB4y1uNDkDNm92JsHrG449XKfPgSJsgCngl2vWPtUznjEnpLBBfg==@nongnu.org
X-Gm-Message-State: AOJu0YyFlVVTKSEl/nbj3pXOpPqCWHNa0aplAm0s1iadOODOF7beALUG
 VmdpfjHV59HhgRBlRpD7aex5G2EvGXSYrZAyojiVGc00WEWp8no0VW2AEZFqYg==
X-Gm-Gg: ASbGncvwDARfVuDm/vRtjU2tYyCYcAtXJ1wYbB8EtMHeRogZIsjysmHtBvDd/HZerZF
 jJ3DPcEvosLJ4/+0hYjB7FeDUYfQFmVSri48ZpMcSPEWYySo5hU3gtATXZO/M5Jh5V4bmQHurBZ
 rJLdz7OJ3pDI6B0m24ndgJlCiAXVD+3TqBNR0wObUs+B2cnbYFmAo+Z8UmcvKdGKm0t2i40JpQ3
 jPyukaZvtedRW0p+HzZvXbI6cifrW3sY+F50FybOPtW7vNnLRq3QIX7KKbd6quGrxL0Xwux/Jy0
 cKbZCX6DnX4Da1fWez3xCC2Qp8aYDOzGvsxxUh3uj0t6We9K+dNNNdWj27TdewY+gMItNcz6LIg
 DtyTzVB4v80yo0JeicBOWEp268dKG
X-Google-Smtp-Source: AGHT+IEEVcjWqtv3SltDYk6ZXLD/ziHDak5rA3h4+2eWMcg+y/A4e62bvy0S4ll9I8P1hzGIHdUbkA==
X-Received: by 2002:a05:6000:1ac8:b0:3c7:244:a4be with SMTP id
 ffacd0b85a97d-3d1dd04e24bmr16738549f8f.10.1756987532508; 
 Thu, 04 Sep 2025 05:05:32 -0700 (PDT)
Received: from ehlo.thunderbird.net ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d92d51982bsm12187594f8f.21.2025.09.04.05.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 05:05:32 -0700 (PDT)
Date: Thu, 04 Sep 2025 12:05:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v5 05/18] whpx: ifdef out winhvemulation on non-x86_64
In-Reply-To: <20250808065419.47415-6-mohamed@unpredictable.fr>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-6-mohamed@unpredictable.fr>
Message-ID: <CE7E1531-FEAA-4E85-9CE9-2F5D8E3ABCB2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 8=2E August 2025 06:54:06 UTC schrieb Mohamed Mediouni <mohamed@unpredi=
ctable=2Efr>:
>winhvemulation is x86_64 only=2E
>
>In the future, we might want to get rid of winhvemulation usage
>entirely=2E
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>
>Reviewed-by: Pierrick Bouvier <pierrick=2Ebouvier@linaro=2Eorg>
>---
> accel/whpx/whpx-common=2Ec       | 14 ++++++++++++--
> include/system/whpx-common=2Eh   |  2 ++
> include/system/whpx-internal=2Eh |  7 ++++++-
> 3 files changed, 20 insertions(+), 3 deletions(-)
>
>diff --git a/accel/whpx/whpx-common=2Ec b/accel/whpx/whpx-common=2Ec
>index 66c9238586=2E=2Ee2d692126a 100644
>--- a/accel/whpx/whpx-common=2Ec
>+++ b/accel/whpx/whpx-common=2Ec
>@@ -41,7 +41,9 @@
> bool whpx_allowed;
> static bool whp_dispatch_initialized;
> static HMODULE hWinHvPlatform;
>+#ifdef __x86_64__
> static HMODULE hWinHvEmulation;
>+#endif
>=20
> struct whpx_state whpx_global;
> struct WHPDispatch whp_dispatch;
>@@ -236,8 +238,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
>     struct whpx_state *whpx =3D &whpx_global;
>=20
>     whp_dispatch=2EWHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_i=
ndex);
>+#ifdef __x86_64__
>     AccelCPUState *vcpu =3D cpu->accel;
>     whp_dispatch=2EWHvEmulatorDestroyEmulator(vcpu->emulator);
>+#endif
>     g_free(cpu->accel);
> }
>=20
>@@ -412,8 +416,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
>         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
>         break;
>     case WINHV_EMULATION_FNS_DEFAULT:
>+#ifdef __x86_64__
>         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
>         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
>+#else
>+        abort();

In the sense of g_assert_not_reached()? Then it is preferred=2E

>+#endif
>         break;
>     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
>         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
>@@ -539,11 +547,11 @@ bool init_whp_dispatch(void)
>     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAU=
LT)) {
>         goto error;
>     }
>-
>+#ifdef __x86_64__
>     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEF=
AULT)) {
>         goto error;
>     }
>-
>+#endif
>     assert(load_whp_dispatch_fns(&hWinHvPlatform,
>         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
>     whp_dispatch_initialized =3D true;
>@@ -553,9 +561,11 @@ error:
>     if (hWinHvPlatform) {
>         FreeLibrary(hWinHvPlatform);
>     }
>+#ifdef __x86_64__
>     if (hWinHvEmulation) {
>         FreeLibrary(hWinHvEmulation);
>     }
>+#endif
>     return false;
> }
>=20
>diff --git a/include/system/whpx-common=2Eh b/include/system/whpx-common=
=2Eh
>index e549c7539c=2E=2E7a7c607e0a 100644
>--- a/include/system/whpx-common=2Eh
>+++ b/include/system/whpx-common=2Eh
>@@ -3,7 +3,9 @@
> #define SYSTEM_WHPX_COMMON_H
>=20
> struct AccelCPUState {
>+#ifdef __x86_64__
>     WHV_EMULATOR_HANDLE emulator;
>+#endif
>     bool window_registered;
>     bool interruptable;
>     bool ready_for_pic_interrupt;
>diff --git a/include/system/whpx-internal=2Eh b/include/system/whpx-inter=
nal=2Eh
>index e61375d554=2E=2Ee57d2c8526 100644
>--- a/include/system/whpx-internal=2Eh
>+++ b/include/system/whpx-internal=2Eh
>@@ -4,8 +4,9 @@
>=20
> #include <windows=2Eh>
> #include <winhvplatform=2Eh>
>+#ifdef __x86_64__
> #include <winhvemulation=2Eh>
>-
>+#endif
> typedef enum WhpxBreakpointState {
>     WHPX_BP_CLEARED =3D 0,
>     WHPX_BP_SET_PENDING,
>@@ -98,12 +99,16 @@ void whpx_apic_get(DeviceState *s);
>=20
> /* Define function typedef */
> LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
>+#ifdef __x86_64__
> LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
>+#endif
> LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
>=20
> struct WHPDispatch {
>     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
>+#ifdef __x86_64__
>     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
>+#endif
>     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
> };
>=20

