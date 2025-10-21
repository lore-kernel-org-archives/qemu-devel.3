Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA7CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7zQ-0000dV-No; Tue, 21 Oct 2025 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7z5-0000Io-DK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7z1-0000yx-Tg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47114a40161so10079185e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036282; x=1761641082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6Urqf2BFQoz6tGL67HiUuAvlfebveNoSUnXOo9Qq+w=;
 b=bQ0/NrlVxXwZf6EQvIUK7VPhTU6wt89GcphafSFpXEZ3uveQXBDt+XbQ3MeoN/wobe
 5JoThl+/QtPswtF56YaVk1uZeOREN3I3YbOYPcx+YBwaXroa4i36u0Pl7AP9FNPMrhiM
 Q8Mtoig4fbXl5mfkrfE5Cie/oHpjnINUA33SQFYAnziaRzfnkgiSgWjfmzOpxOYmV+zD
 KpZLcNpR8owc/ajm4cvERcqQNXWq/v9l+biPehlAPshJX5u/k5ipXKaIBulav8gZcbDx
 DDh3V4USs+C8XjbE/UVFX6j4joAISikzUiMUShbIHGV1fWkHaGSwpxW/Ben3/NbRBoO5
 e1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036282; x=1761641082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6Urqf2BFQoz6tGL67HiUuAvlfebveNoSUnXOo9Qq+w=;
 b=DoF4oUGl6yxk6wMhSlXSJtCDpzEQlkS69eMT453Np7lRCKOJvUEd5OoVydPOsYZRnI
 /5JyCeC4Js9GBLusvNRIXjQT/XOUEjYGiQEKUPSfPEMMpoQCg7WnUqXStczhkN3ojbPZ
 Puy990gmD/lYGhCh+CO2q/lBw7NRRZN11vtc2Edx4lRJyJq4ZR3YPn6VGoWz3zFDIxwC
 0xWZ0L8do5qjuzQxBMNgqNgkBaDh9SSrgaJB26EPgl79fyhO6E+k898PiQWuxR68tKPw
 j4JXWJ1WH66jQvmjGYYEWkLGq8YGMvVnrHtxWQhH8xGQaznUcpaHdz7fXBYSda3HESZp
 w7dA==
X-Gm-Message-State: AOJu0Yyu3mvsNkMsqfbSP4rVI5sY3z2Atukvm4baFlX4DPqj+ZUVj7Cn
 cHWt/aJv3F9c6UGn2tFN1eBySuaDU+DYy7Br75ky298LczXJ8/svu3Vqu9oV5K5EBT9Cdl9UcSb
 hHN0JGMM=
X-Gm-Gg: ASbGncskoaaLoRdSyfHa422ZY5cAJfeZv2jrrimRFZsqrYDEl80x9EMYh/9q9sS2fNt
 gJmWQZUEAuH9TRYm+2AmEmK0YtdvgiB9nIA7thf/tyCezcBg+k077thg8VZTmbNYobt3Fhvinsv
 BgnHHbOfxyQNF3P26mQAVpr/aJutCDTlhOI83QLd54Ul+CV+tc2JrgfzibS/JvDOjwPqfcAOhPH
 A7n4gKSs6+xRupiraT7fIR5oQPkxDmA7d/rX3wT8Cqq3A8MHM7tW22vzoJmfSByXjOVxTqFH7qz
 AHBTpIlqlrC1/26S05b/TjRRfd3xovIFnMZzNXWVPnMQq4xJM1IVVXVIAM2a43ZaiocG35I+33w
 8kucK09BTI59jkayhM24pwWpOwyVj7Ztjsb49H+jz4Qk8bXlqu3i26JdEkTb3bcijOET+0QY5hR
 rH6fArqr96MIYWuU94STKYbNBdhwMdMRavLaGO1RBaT9YIf7bMvQ==
X-Google-Smtp-Source: AGHT+IHH5GeVeaqK1SOYHRnV5hnEGg+hDnGH3BWGPiH6VG3b1oQcncz2qQzO9HI9FYrWzz+B7lIX0Q==
X-Received: by 2002:a05:600c:871a:b0:46f:b43a:aeef with SMTP id
 5b1f17b1804b1-4711791d923mr96345475e9.38.1761036281808; 
 Tue, 21 Oct 2025 01:44:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c43f68sm11891395e9.5.2025.10.21.01.44.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/11] ppc/spapr: remove deprecated machine pseries-4.2
Date: Tue, 21 Oct 2025 10:43:45 +0200
Message-ID: <20251021084346.73671-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Remove the pseries-4.2 machine specific logic as had been deprecated and
due for removal now as per policy.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 27 ---------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60d9a8a0377..b9d884745fe 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,7 +141,6 @@ struct SpaprCapabilities {
 struct SpaprMachineClass {
     MachineClass parent_class;
 
-    hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
     bool pre_6_2_numa_affinity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a06392beff1..b6f151d7468 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2729,7 +2729,6 @@ static PCIHostState *spapr_create_default_phb(void)
 static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr rma_size = machine->ram_size;
     hwaddr node0_size = spapr_node0_size(machine);
 
@@ -2742,15 +2741,6 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
      */
     rma_size = MIN(rma_size, 1 * TiB);
 
-    /*
-     * Clamp the RMA size based on machine type.  This is for
-     * migration compatibility with older qemu versions, which limited
-     * the RMA size for complicated and mostly bad reasons.
-     */
-    if (smc->rma_limit) {
-        rma_size = MIN(rma_size, smc->rma_limit);
-    }
-
     if (rma_size < MIN_RMA_SLOF) {
         error_setg(errp,
                    "pSeries SLOF firmware requires >= %" HWADDR_PRIx
@@ -4913,23 +4903,6 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(5, 0);
 
-/*
- * pseries-4.2
- */
-static void spapr_machine_4_2_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_5_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_OFF;
-    smc->rma_limit = 16 * GiB;
-    mc->nvdimm_supported = false;
-}
-
-DEFINE_SPAPR_MACHINE(4, 2);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


