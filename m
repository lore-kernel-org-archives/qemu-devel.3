Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB8CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmou-0001wb-DG; Fri, 31 Oct 2025 06:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vEmor-0001so-Sp
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:57:22 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vEmon-0003Nw-Kh
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:57:21 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b704db3686cso473319866b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761908232; x=1762513032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8BLP/6nlWzf2bgCy+zBH7NR7KzIv706aW28HAk4MsU=;
 b=kx/VcI8SvAqYtYsa22hpuFWuOJMD0lFqz3xhzffFa1BMZjhkAN76Mm9maTM3TUMljd
 JkZR7ZggGDJ+Z2LsRbK5EW6oaBaGjytUDheq81MFaKmN1qgrlfr77NwfjT2FM3PTGzIm
 oru74qkF+1bfHXR4Z7J4ImvvRPNxgDbw2PNeewDpjw0QwRGJA4gAQ9J63gA6jbhHn+tu
 wzKqFv6EqycBdZoiLuIMi3GdmMgMQlS8VW8k8C/E/x4/mw99w81PRdVNWv3KrmR30gwM
 MA0faOQfrMbOLJ7s+r8sH2mDTnnxmZZuIlBz7HjucYkkYXMhP+4Ut6I2O6iv21cEYZjU
 uoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761908232; x=1762513032;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8BLP/6nlWzf2bgCy+zBH7NR7KzIv706aW28HAk4MsU=;
 b=Fbhxtsx+v845wa6UG4uFQI+/h3xZ4YOL3oH+ZPyBLtVMSPEWER+i/FD0jhNMkdjgjB
 H6zcsI3l1sQDJLlAu7bpzFSZOwSEzManX3tySCF9gHvTCN0bf+QfU11zeTBd99iPzEsv
 kmG9Al9dpfUK/+omdixupkpXJ/UNtLrRplIsvxplxx3a/q+by4wMaZvyP62KJvOgzTUn
 of++SbjughiOpB+Wo46AONSTcm7/LcKcWcqzJApNKOgXOBFAMypv5LKXbETDr98Y3zDk
 7TbeYlfKniCSNKsvLR13cmkHk6c3fV7SP8wc4MjLt1c/Ab0NAoI1wqJ4xXKE58+h4Gmh
 nyKg==
X-Gm-Message-State: AOJu0Yztck18lnIb7jr0dNgD4y0A2yLjSnBQ2TtnEGRAU4I4+h73ZM+Y
 gLD9osFMop0Cp9WuHsYXi+7+Rg0TJacZkzbd4hNaxd/t59/TMxdwL9zot+w9GA==
X-Gm-Gg: ASbGnctGzvm4eTbr35AhImKfle9c9lW43Ciu9oe2DC9jYWEPcHQuNhYaYm8NnT4ao2S
 NuLnglguhvNUdigKuZSGAEnvOAH4DhYOOWAnYtAuykM+yi0zPOmo4vAI0GbQH4LP9i3rUwhtjRt
 yWUaBcyRNHfu6IShO0Jy88bS9Q8MTiLz8l8tbUPab9SxCBdrfRB9NkQKbbWzx7/0GY2QYDyxyxy
 PGWIMfiMp2sHJ1lZ2cICgZlZPgd/fHxFSwA0NpUkNEGrYJqaVF4X+siGPRbpAHshRGPX/BpDLAF
 sqQTBfxRzI+nu5Ow9vUZQX0laDgJ28mNCsifCGMtiec2XhKSSy00jOShNfD5cZ55xlgJEeFv5E7
 Ghni4nB0ecW20PRw5yT/wH91rI62fr7XqnRkL9+PKHDU0cd0Hjo9s6p+7tzRPJJ8IA92Japbw/u
 j1r8jfUXD4iEH/TPE+pffiPcygDLpm7rePeWHz2t0DMnXlyGmG7Vb4ox8skOTFsjkOIsXWtXrn
X-Google-Smtp-Source: AGHT+IHHF5KmrKdHIuugym5H5soLeEpzcu2424601R3/yh5IGHQAV2hKTibYNy5qYHF20WeO22XdpQ==
X-Received: by 2002:a17:907:972a:b0:b41:2fd0:2dd4 with SMTP id
 a640c23a62f3a-b70708738f7mr288534266b.61.1761908232042; 
 Fri, 31 Oct 2025 03:57:12 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400e42d34416465d6be.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:e42d:3441:6465:d6be])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077ce927csm143498366b.63.2025.10.31.03.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:57:04 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:54:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 mohamed@unpredictable.fr
CC: Pedro Barbuda <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v10_26/28=5D_whpx=3A_apic=3A_use_non-depre?=
 =?US-ASCII?Q?cated_APIs_to_control_interrupt_controller_state?=
In-Reply-To: <20251029165510.45824-27-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
 <20251029165510.45824-27-mohamed@unpredictable.fr>
Message-ID: <D7E4B026-EF2F-4075-B424-06427346E97B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 29=2E Oktober 2025 16:55:08 UTC schrieb Mohamed Mediouni <mohamed@unpre=
dictable=2Efr>:
>WHvGetVirtualProcessorInterruptControllerState2 and
>WHvSetVirtualProcessorInterruptControllerState2 are
>deprecated since Windows 10 version 2004=2E
>
>Use the non-deprecated WHvGetVirtualProcessorState and
>WHvSetVirtualProcessorState when available=2E

I still have to revert this patch to avoid termination of the VM=2E

Best regards,
Bernhard

>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>
>Reviewed-by: Pierrick Bouvier <pierrick=2Ebouvier@linaro=2Eorg>
>---
> include/system/whpx-internal=2Eh |  9 +++++++
> target/i386/whpx/whpx-apic=2Ec   | 46 +++++++++++++++++++++++++---------
> 2 files changed, 43 insertions(+), 12 deletions(-)
>
>diff --git a/include/system/whpx-internal=2Eh b/include/system/whpx-inter=
nal=2Eh
>index 81c0c1819f=2E=2E90b4077b76 100644
>--- a/include/system/whpx-internal=2Eh
>+++ b/include/system/whpx-internal=2Eh
>@@ -86,6 +86,15 @@ void whpx_apic_get(APICCommonState *s);
>   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
>         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
>          UINT32 StateSize)) \
>+  X(HRESULT, WHvGetVirtualProcessorState, \
>+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
>+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
>+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
>+  X(HRESULT, WHvSetVirtualProcessorState, \
>+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
>+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
>+        UINT32 BufferSizeInBytes)) \
>+
>=20
> #define LIST_WINHVEMULATION_FUNCTIONS(X) \
>   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* C=
allbacks, WHV_EMULATOR_HANDLE* Emulator)) \
>diff --git a/target/i386/whpx/whpx-apic=2Ec b/target/i386/whpx/whpx-apic=
=2Ec
>index b934fdcbe1=2E=2Efa45a64b21 100644
>--- a/target/i386/whpx/whpx-apic=2Ec
>+++ b/target/i386/whpx/whpx-apic=2Ec
>@@ -137,11 +137,21 @@ static void whpx_apic_put(CPUState *cs, run_on_cpu_=
data data)
>     whpx_put_apic_base(CPU(s->cpu), s->apicbase);
>     whpx_put_apic_state(s, &kapic);
>=20
>-    hr =3D whp_dispatch=2EWHvSetVirtualProcessorInterruptControllerState=
2(
>-        whpx_global=2Epartition,
>-        cs->cpu_index,
>-        &kapic,
>-        sizeof(kapic));
>+    if (whp_dispatch=2EWHvSetVirtualProcessorState) {
>+        hr =3D whp_dispatch=2EWHvSetVirtualProcessorState(
>+            whpx_global=2Epartition,
>+            cs->cpu_index,
>+            WHvVirtualProcessorStateTypeInterruptControllerState2,
>+            &kapic,
>+            sizeof(kapic));
>+    } else {
>+        hr =3D whp_dispatch=2EWHvSetVirtualProcessorInterruptControllerS=
tate2(
>+            whpx_global=2Epartition,
>+            cs->cpu_index,
>+            &kapic,
>+            sizeof(kapic));
>+    }
>+
>     if (FAILED(hr)) {
>         fprintf(stderr,
>             "WHvSetVirtualProcessorInterruptControllerState failed: %08l=
x\n",
>@@ -155,16 +165,28 @@ void whpx_apic_get(APICCommonState *s)
> {
>     CPUState *cpu =3D CPU(s->cpu);
>     struct whpx_lapic_state kapic;
>+    HRESULT hr;
>+
>+    if (whp_dispatch=2EWHvGetVirtualProcessorState) {
>+        hr =3D whp_dispatch=2EWHvGetVirtualProcessorState(
>+            whpx_global=2Epartition,
>+            cpu->cpu_index,
>+            WHvVirtualProcessorStateTypeInterruptControllerState2,
>+            &kapic,
>+            sizeof(kapic),
>+            NULL);
>+    } else {
>+        hr =3D whp_dispatch=2EWHvGetVirtualProcessorInterruptControllerS=
tate2(
>+            whpx_global=2Epartition,
>+            cpu->cpu_index,
>+            &kapic,
>+            sizeof(kapic),
>+            NULL);
>+    }
>=20
>-    HRESULT hr =3D whp_dispatch=2EWHvGetVirtualProcessorInterruptControl=
lerState2(
>-        whpx_global=2Epartition,
>-        cpu->cpu_index,
>-        &kapic,
>-        sizeof(kapic),
>-        NULL);
>     if (FAILED(hr)) {
>         fprintf(stderr,
>-            "WHvSetVirtualProcessorInterruptControllerState failed: %08l=
x\n",
>+            "WHvGetVirtualProcessorInterruptControllerState failed: %08l=
x\n",
>             hr);
>=20
>         abort();

