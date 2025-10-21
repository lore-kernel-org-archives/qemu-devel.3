Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD1BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7zU-0000nV-7s; Tue, 21 Oct 2025 04:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yq-00009Y-GZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:39 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yo-0000xq-He
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso3636691f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036267; x=1761641067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=da9rOiPMCykHVjkJsbrqebc9pkYcny2T2/SQshegPgk=;
 b=dSP+7oAtRFSbR7i0WgqS0ztVqZvziNY7ohwWsI+j+InECt+lJ90dWsqTC7O7JTQFVi
 4Ikj+tCB/e/XN406GPwBa0zCS+BsiUhBXCjh/qwhldKTa1qkmQjEr8XG2qKBGgGe11dU
 kbFXd6moofBIO7vaS5TjsQuSAnFGh7J6v8jrXzCOw88vGNxYRRWeaeKwFcssMEmSmXku
 ZPE9Y65Yt+lOLweVm+HWRuJnGzfpgSbyj5nh7crLx3vkKRiYt2BJiDS7dJKUW7/UkBpA
 QmvXAd63my5cguXzZJfqZ9DFyvQ4TsNVqhWnupLw5SWw4P53KJRn4rzXh2nRfHKFaXGq
 xfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036267; x=1761641067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=da9rOiPMCykHVjkJsbrqebc9pkYcny2T2/SQshegPgk=;
 b=SWR+eBG4hyCBGOl2zEhf82lBfVFLxscAbJqLnaTDwa4TkzRfqmK8Be0nHljFYy0ZMs
 sZ+XQmX1ycLxdPX7pkD5XVK6UedNedW1D3ptDzgQwju9wBshwPtFw8MTGDZgdsgKAovC
 T/LZ62a8SXtc/uh99NTaDzmv5OGlvt82luoRAMf2u00GEVdKEl9KQAJBWT6owPTvDs2f
 +WuT2cgC0vAmILVOuURT2qX471ouXpIjfsyt73I8jHZKnWOodcuE/eJ9BTLOfNEnoTbM
 blf++SoXyxnwjAZK/nsqFinLbMvwt/LcAweAoHLdY0lLu7XNKuXkPHpM9genVUd6T/8a
 U17w==
X-Gm-Message-State: AOJu0Yx+PX1Uzn5S/kVKpBbK7VH1mdTlYNxMT+amuIFa+Nl+jrNYkGUX
 1wIh9qLDf/MJNTGu95tX+XOjcA0s4ANEYc9ONWGecBhvH9FLKe4wK68inI/5rNxTg2vfhDFsgju
 Z5l434Fs=
X-Gm-Gg: ASbGncsXyLirn+1CldiA9MInoP6bXMkK29ElgLouHzdEcLOwxcUh79z8Pu5nrY+8UdC
 dQfNOUeYFWPx5wRqQ+kwk5JG0AF0Bw+KMnj0ODQiZNSmc/gXLErNpA+Qwqpgq1/QW15pmUwW5gr
 tyGul9ffT9cTNtREWOMZOuV+/wc32eEwajK3B2s3WDjiGGCfWfbWULJyY6u8a5+gSKpFwtEBxOX
 bas7Dg8iA28Il0rCCa/qOtb/I5aca1qZQN3OD9FIrj7DBDijHOwfI2GgRKGuXtqlmYMepRuI9ig
 Xiz/OjwrvBwTAdS6d5CWzh53qzWXbnyxlWq9+oG5zrGwHguJMAZcNLH7r9aM56qr+qv0NYp5w9Z
 ZHo+N+pSG154OdlzzTgCzUkwpECRnkBJWFvLayOWSm2WdvkHcVHQSAQndmQXYlwVHdOMRzyIt1d
 IUkZtlLrGU6ZC3KNMgpc6RTt8CYwCd3sCv+5ek4XFyNPQcFHFwwA==
X-Google-Smtp-Source: AGHT+IGdNU6grxDa0fovZHVQYjLk03VGAqM6vVuoTYaGlfenMJOg7eXSZCsDKxqPUFu1TflYXqOl4A==
X-Received: by 2002:a5d:5849:0:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-42704b3db46mr13625580f8f.6.1761036267320; 
 Tue, 21 Oct 2025 01:44:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3dabsm20200098f8f.16.2025.10.21.01.44.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/11] ppc/spapr: remove deprecated machine pseries-4.0
Date: Tue, 21 Oct 2025 10:43:42 +0200
Message-ID: <20251021084346.73671-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

pseries-4.0 had been deprecated and due for removal now as per policy.
Also remove pre-4.1 migration hacks which were introduced for backward
compatibility.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
[PMD: Remove SpaprMachineClass::pre_4_1_migration field]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  3 ---
 hw/ppc/spapr.c         | 27 ---------------------------
 hw/ppc/spapr_caps.c    | 12 +-----------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1db67784de8..58d31b096cd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -139,11 +139,8 @@ struct SpaprCapabilities {
  * SpaprMachineClass:
  */
 struct SpaprMachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
-    /*< public >*/
-    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ad9fc61c299..deab613e070 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4969,33 +4969,6 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 1);
 
-/*
- * pseries-4.0
- */
-static bool phb_placement_4_0(SpaprMachineState *spapr, uint32_t index,
-                              uint64_t *buid, hwaddr *pio,
-                              hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    if (!spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma,
-                             liobns, errp)) {
-        return false;
-    }
-    return true;
-}
-static void spapr_machine_4_0_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_4_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    smc->phb_placement = phb_placement_4_0;
-    smc->irq = &spapr_irq_xics;
-    smc->pre_4_1_migration = true;
-}
-
-DEFINE_SPAPR_MACHINE(4, 0);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0f94c192fd4..170795ad6ad 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -66,7 +66,6 @@ typedef struct SpaprCapabilityInfo {
     void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
     void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                       uint8_t val, Error **errp);
-    bool (*migrate_needed)(void *opaque);
 } SpaprCapabilityInfo;
 
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
@@ -336,11 +335,6 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
     spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
 
-static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
-{
-    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_1_migration;
-}
-
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
                               uint32_t pshift)
 {
@@ -793,7 +787,6 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "int",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
-        .migrate_needed = cap_hpt_maxpagesize_migrate_needed,
     },
     [SPAPR_CAP_NESTED_KVM_HV] = {
         .name = "nested-hv",
@@ -982,11 +975,8 @@ int spapr_caps_post_migration(SpaprMachineState *spapr)
 static bool spapr_cap_##sname##_needed(void *opaque)    \
 {                                                       \
     SpaprMachineState *spapr = opaque;                  \
-    bool (*needed)(void *opaque) =                      \
-        capability_table[cap].migrate_needed;           \
                                                         \
-    return needed ? needed(opaque) : true &&            \
-           spapr->cmd_line_caps[cap] &&                 \
+    return spapr->cmd_line_caps[cap] &&                 \
            (spapr->eff.caps[cap] !=                     \
             spapr->def.caps[cap]);                      \
 }                                                       \
-- 
2.51.0


