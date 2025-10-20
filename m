Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDAECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnJD-0002Dl-8C; Mon, 20 Oct 2025 06:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnIF-0000ph-Ow
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnID-0000HL-Sj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso3247573f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956746; x=1761561546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G71RzqW1rRM1q68VyBiXz7BShoBGdhsR1BgR0TIYzSw=;
 b=Jr95HB1wgeORQ5XtMkMzpEoFp6KH+DHjGiLeVdKPTlJD1M6Mal3zYRODQDpT7gQIex
 sBKCdbvH5lIpX1WznFtw6RsttQK3JoAp4drideyJq7YEXjE8PsgnBv8M450AsAfLWkC4
 QMBaND9utm6RbIZPQexRxkSQfyYF/oSXjRCb6MlESDCKKf+IIN5bM/LlUHrOotWfpkFL
 S4k7MVI8oq0c4hUzm2zVpGCB5GbXK0eFlby0SfYxE/3ygoKTUKp5hYj8IR4mvjPR6R7r
 ejY4lj+0ucrHEBDO0VvAgKJD89HZzB6faaykJ+PKwv7aRI4aA3QGe2KLJmtaK249I6ut
 fS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956746; x=1761561546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G71RzqW1rRM1q68VyBiXz7BShoBGdhsR1BgR0TIYzSw=;
 b=OIWpsmCanKpTMjFHgZHNsH111SyUP8/SWSUtxtrQatGYyBWUglD2EmQMHUnOtI9LjU
 N6ElGwovSIlOcq8+xhJTDgSsSlDceAUfi8Q8YZsRWnmlcyFd09OgZmtcA4HPYgFkH8GR
 J+erIVOUF/Hf+hGpZc3dWdGXvwL+e57VvtQcZZ5aXdXILBiDyUh1FGZzA461LWwm4TYb
 lOPktggA/67LnCI/SovlM+JJMTaQfpVBF8apMSEiamROSd0SRd2DyQ49MpRkd9qdMQab
 uOMBDPhDV/r5IQLtDViMXVbf0wiHALuWseXBfpKf+v8MRR9bBjbterFaG24+cIW7y4nD
 VcoA==
X-Gm-Message-State: AOJu0YzkeRzBYZTMLSzKc0wXGaDeQEYkFj6Bi5FvrNYECbqFl4SMNK7Z
 dNgprkEfYa9sm03n1j+DU94l7GEndPckylsyqB6KjuNK0g4VlK8q9nJS17ihpP2MxX5jJ0KEsMa
 JYCxFks4=
X-Gm-Gg: ASbGnctYzCl79cWhCSRLSkqJbtG3jS5QRu/CjqE1ze6bNG0aAJ7UiBnoHaV9lpwGgj7
 +zxbRHjaihI8Of0AXrh8bAyFKURY74LnQJ6l6mv9rQi3YHf5OoFdyJW6UOJDUhJZMfJba/m8s3D
 zlHq7Nelk91t3YNf8lrYS1rsKLYGedAZr98EAuMZDp+ziBqeT/kxDHYjMUWaHsI0bNznjbPP/2L
 LS9lEiDGiWkKLohFnjyJGjogLpuq4LHS65g1FRBFi6JP5J4gsIlSwl33LLH9tjtcph8hWP4T+m/
 npUWACRZrPmrLY96Os+6mmqJISYDu/G1SponjWfUOhujjv1/oRCYaMXfMzVbWTfsgr0KOjsef1P
 l3Y12rYQph18nl7DjIGqyMqLw/Svch1yWlk8aHJG9ERDq0BZqMqUR4ADDQFnfqOWsA1ZGFbGnDX
 rTrxcs3COFqvb6IVE6X+LTZCVVf+Qlv9avK1Cbtl0Oc+e+Q40J8YsLixuRcQZ6hs6yvbWeB3g=
X-Google-Smtp-Source: AGHT+IEA6OS/cJN8d7ANvIfUdQD0HaQc+Ga96+ciiQUpkqRgsXl2JRuNNPFZgrzIZpTMTtzjZnOK/A==
X-Received: by 2002:a05:6000:18a8:b0:427:7f5:2b8 with SMTP id
 ffacd0b85a97d-42707f50382mr6302454f8f.43.1760956746374; 
 Mon, 20 Oct 2025 03:39:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239bdsm270295285e9.3.2025.10.20.03.39.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:39:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/18] hw/ppc/spapr: Remove
 SpaprMachineClass::update_dt_enabled field
Date: Mon, 20 Oct 2025 12:38:06 +0200
Message-ID: <20251020103815.78415-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SpaprMachineClass::update_dt_enabled field was only used by the
pseries-3.1 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 1 -
 hw/ppc/spapr.c         | 9 ---------
 hw/ppc/spapr_hcall.c   | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bc75e29084b..1db67784de8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,7 +143,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b81eb7ffe73..feb1e78b7c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2052,13 +2052,6 @@ static const VMStateDescription vmstate_spapr_irq_map = {
     },
 };
 
-static bool spapr_dtb_needed(void *opaque)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
-
-    return smc->update_dt_enabled;
-}
-
 static int spapr_dtb_pre_load(void *opaque)
 {
     SpaprMachineState *spapr = (SpaprMachineState *)opaque;
@@ -2074,7 +2067,6 @@ static const VMStateDescription vmstate_spapr_dtb = {
     .name = "spapr_dtb",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = spapr_dtb_needed,
     .pre_load = spapr_dtb_pre_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),
@@ -4607,7 +4599,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8c1e0a4817b..8f03b3e7764 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1475,16 +1475,11 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong dt = ppc64_phys_to_real(args[0]);
     struct fdt_header hdr = { 0 };
     unsigned cb;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     void *fdt;
 
     cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
     cb = fdt32_to_cpu(hdr.totalsize);
 
-    if (!smc->update_dt_enabled) {
-        return H_SUCCESS;
-    }
-
     /* Check that the fdt did not grow out of proportion */
     if (cb > spapr->fdt_initial_size * 2) {
         trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
-- 
2.51.0


