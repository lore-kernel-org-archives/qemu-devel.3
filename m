Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoAq-0002UJ-26; Mon, 20 Oct 2025 07:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAn-0002TS-3d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAk-000161-NE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so44970635e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960128; x=1761564928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAkkZcqWQBPqLRoYMt3hCTfFtTwm8REFlMaR8FUYzOw=;
 b=v0raHShWB9tF/43c3qL3sMheg00M9fl5ofmQIjBkQV6WaRuLfStaLiTl/+dSYcc981
 aKxyuiz0Fc3KAoG5hAMFZ+Vp+k8nf4y8BPpcLUSaXbSSSLzq8HwWfcoWEFutP8eIhB/q
 Jhiqm4z3uPm3jRAsdBVpgxfyO/dLEtSMrhu0o8juxTYX86DbylSetCbfui//ptGxydWn
 EnuQ1zPUE8H9tjknsvtLIGK09XwNj4Ue3h16T43W7+2eFOmY5uEGeTKEhrBOt/WR1vVR
 jl3wjh80f9Raq10yTukp97+sV+EaWZWn8jC29+5C0Uv0JoK64t7SyDGKM6XdvlYCwNt9
 kY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960128; x=1761564928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAkkZcqWQBPqLRoYMt3hCTfFtTwm8REFlMaR8FUYzOw=;
 b=tuJ6Oi1uFU31dgAIyi4vJmn94snsYsxPZqgXeG0KVhcsdOihreIC5vAFL4yDKKcRaW
 0Bt7hChZnj1Ex9kBGBnzEPwQ8YIBlpnBYDiiE27XzjihfGFqX5rq7ir1rodO3i0NYNkh
 uygPYG8EOJSxnQh7Qc8qa4jzAZ0HckRjLC660uf/mGu5UULwdRrkRjN27ruZDkigoWBC
 HVl0CyP3gP8LZ0d+83vVs7+xI9EuMfx4IIQWSmvf1uhsvbzZGqluYwn03KfK2UDohMux
 eOyazPWZkHOnbEMnCUB5ipOYWCivJ8OA0O6Qrc4TaUj6lqjW8EVr2kSYGtu4toPg6dT5
 atuQ==
X-Gm-Message-State: AOJu0Yyi7kQRjimnocradchRh6LXUyrZZHg2ZYud72GmYM22WcE+Z4rH
 KmfDgD6/U0G+dWsTjPUqYlrtbWQ0jS9GOpP1MTwgXlMslfGc6M+eng4ilSVjE5cNo8ML/09WI6d
 HB1SOfT8=
X-Gm-Gg: ASbGnct+MS4rJajT7Xl9+LUlconWF6wyi8SXn8iXRv/7XGggHBUwc+L1rTMYyLtgYAo
 DvuMTUyMo0wJhHkIxzc4mW2tVLpDnKddMVP3TBIDUAHSWIlyJWqkwxx61pWA8GGpWPnfjRJyapX
 xTBQThmpEW5Wk3KvDuIeg2DM/7lm3WlvrHX9wifluTHpqXrnGQJK4NBm8uyuDDrGTZKBuYmkUOf
 umidCwiS3kEkQ3k/IUP4f1yl3g88dZ7LMPHghOMaPMowJ9gjUwAlVvosF8HYXXWfqrZIL8Tbpi6
 o7VZ2xKBEGFxHwo+Pbbh2ajJnhC494FtUrfmLBKW40PO4XBODrOCASgy2U+NqP05W4/Wh7JiArI
 evkpVIZSIdRX2rXhhjV1iLSAoLkZMkYFsMjbTN8QwyIy229wyabuELgAEk+KcrkwkAovw4/Unuc
 dciH1OJMExg44L8t9BBZ619Acksta01Ih94Ezc44hViXOM08jCvA==
X-Google-Smtp-Source: AGHT+IF2AFfYUbg6zZHrbdDsDhS2C/ImRRjkdhB/lLsq6EYZa7SyNf2IVzSoyfvyJJ0wStkrODlcEw==
X-Received: by 2002:a05:600c:5029:b0:46e:3686:a2dd with SMTP id
 5b1f17b1804b1-47117879c4dmr86035915e9.11.1760960128118; 
 Mon, 20 Oct 2025 04:35:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm221017245e9.6.2025.10.20.04.35.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 04:35:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/18] hw/ppc/spapr: Remove
 SpaprMachineClass::smp_threads_vsmt field
Date: Mon, 20 Oct 2025 13:35:18 +0200
Message-ID: <20251020113521.81495-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The SpaprMachineClass::smp_threads_vsmt field was only used by the
pseries-4.1 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 82f556f97e1..1629baf12ac 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -144,7 +144,6 @@ struct SpaprMachineClass {
 
     /*< public >*/
     bool linux_pci_probe;
-    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 546e100c9cd..c8558e47db2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2588,7 +2588,6 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *ms = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     Error *local_err = NULL;
     bool vsmt_user = !!spapr->vsmt;
     int kvm_smt = kvmppc_smt_threads();
@@ -2624,15 +2623,6 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
             return;
         }
         /* In this case, spapr->vsmt has been set by the command line */
-    } else if (!smc->smp_threads_vsmt) {
-        /*
-         * Default VSMT value is tricky, because we need it to be as
-         * consistent as possible (for migration), but this requires
-         * changing it for at least some existing cases.  We pick 8 as
-         * the value that we'd get with KVM on POWER8, the
-         * overwhelmingly common case in production systems.
-         */
-        spapr->vsmt = MAX(8, smp_threads);
     } else {
         spapr->vsmt = smp_threads;
     }
@@ -4649,7 +4639,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
     smc->linux_pci_probe = true;
-    smc->smp_threads_vsmt = true;
     xfc->match_nvt = spapr_match_nvt;
     vmc->client_architecture_support = spapr_vof_client_architecture_support;
     vmc->quiesce = spapr_vof_quiesce;
-- 
2.51.0


