Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0E9CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8n-0000Ck-LB; Tue, 13 Oct 2026 04:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4V-0001Tt-A5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4T-0008Ge-7s
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso24467425e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880876; x=1792485676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=paR4cyu9/UC5Kuni++Tg3b64V5PivixNJ34pK01k3sw=;
 b=Bm54QZGo6r0vNmS73OZXjMQF1PPmn6RIkfPjgm3Lwkg49SuWDdoksCKwNuK0MWIvZn
 r7RfFLxeG9j8fxO0lMZW4sHson2yk2xajwrNnX+a8LcDoUdIVuS6pNsz1haUJqLOVnd3
 kPzmAtzWsGJM0PR0twrN19Ddp4hyaWF4nnVCl+DkwgkBr96J9QnZRKwEKbL4k8yWXwEO
 7KWCueh9DOKol0JDNPyAAucFLzrs4wuJkrlMLf+h+FQX9EthL62EYBm5XStgJshjdvX4
 FUziDM5JdWi6YUEgohasjndnTM8jJNpVIkuH6EjuQRFy/1mLRK9x6R/uSDWAe1kVSPt4
 mk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880876; x=1792485676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=paR4cyu9/UC5Kuni++Tg3b64V5PivixNJ34pK01k3sw=;
 b=fA6ifRqjaVUglHdaLXSaPux2oH11uqQo6IPn8kNO01mANrCBQN8xAl6rOrLGPBbxKb
 OQc9XxUYDPtewk26GSORxHBpEpiTYCGU6L0JLWhIOnRCGCQjP8/Q1kQ4xlMALe7Scov6
 YKmBBvD+xqlL01d51SQVE9XH7jYP0MY6YdfxSuzY0SNQvlx75kPpZ5agJWttT9VwsXMj
 LhvZOFRNpUROblxpmpkTpa9mmjzdnGre/mNL1C1ybd7n718e+LXMacsy19RfRMugrSWw
 quOA+uqSeCklheFwkJd7ZeKKrHjUqUe123OuyCmVO98V+R4TTseie5Ylzr70UOGSVO0v
 1wDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnBkOazTNAEMAYrGuiLvJ5YphoQ0l8Aw9dOs2nu5OoXlCQj3BPHlb5wShDl/foiTi9ZUjdjZz0JZMi@nongnu.org
X-Gm-Message-State: AFq9FYIqWmDxvqTgRJNCC8FMmJ7DcggoAVyTQ9d6k7voQGGRN6/hIRzd
 tb0Kjhz8R/DDBdpScjFvdJABWqFF4SvTQe24Rq+rH7px6CVoplmZNhkcWMN0by8c89A=
X-Gm-Gg: AYBFou3wLKIzcuAEQ9HfqDpECRajwutu6Rr3eyKoH8xPzQBOvtOuyrR4KXkHn+tLilz
 ZH8equVu5c29/GDRqRkXdqOb/AaSKYDsavPRpdGOyQZMWfZhDLCygK3cJlIey9OtRc8o8d7JX8Z
 eu0MT4Og9LT+epkRP3ecK9LFLFd4NmjZxWfaj244n5N3zUGZUZbF2z051xRPuA1gdJ9MSlMeuHy
 HZgazPGqvNGu3cjark2DpCp/qGAccemcGi1ZzjgiN84LJtsaKjJbVlTRXVvSX5xnyL5ZLrBiAWT
 A5SP1goQZihuEEBjPTIx06/gf8CNcWlNOgeKAl++EAKGOxUzE5PuuHKRLp8tuAXJ9IzBb8qC0b1
 bSUL7TDm/bdh2NBlgiRTL1kxanFXJjJoUypfY0N1ltCY78NZ2GCQLe2uMTgVeLBMG1kWkuvBGQQ
 HiV0HsU0DRswdP80fd58Sv79fS4RG2OvErE85uL9+bR3uQwgf9+GwsDLhHKWs2pRfItKUVG68sg
 qARarciFgTeaHQfIJgS2SMuZgC4TCdHN5QRrzCe5E7nBJ1H20AAk6S9c4w3LFbhecB6ZtbqAEuM
 nrA=
X-Received: by 2002:a05:600c:6099:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a18e4e7a85mr223917615e9.30.1791880875728; 
 Tue, 13 Oct 2026 01:41:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 78/86] hw/intc/arm_gicv5: Recalculate vHPPIs on VIST and VPE
 mapping
Date: Tue, 13 Oct 2026 09:39:25 +0100
Message-ID: <20261013083933.1024405-79-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

If the guest maps or unmaps the vLPI or vSPI for a VM via
IRS_VMAP_VISTR, this affects the vHPPI for every VPE in that VM, so
we need to recalculate it.  Similarly, if the guest maps a VPE for a
VM via IRS_VMAP_VPER_WRITE, we need to calculate the initial vHPPI
for that VPE.

Add the calls to recalculate the vHPPI for these register writes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index b4dbe7ce3e7..199547abaed 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -613,6 +613,19 @@ static void irs_recalc_vhppi(GICv5 *s, VMTE *vmte, uint32_t iaffid)
     /* TODO: we may need to generate a doorbell interrupt. */
 }
 
+static void irs_recalc_all_vhppi_for_vm(GICv5 *s, VMTE *vmte)
+{
+    /* Recalculate the vHPPI for all VPEs in this VM */
+
+    for (uint32_t i = 0; i < (1 << vmte->vpe_id_bits); i++) {
+        VPE *vpe = &vmte->vpet[i];
+
+        if (vpe->valid) {
+            irs_recalc_vhppi(s, vmte, i);
+        }
+    }
+}
+
 static const GICv5ISTConfig *ist_for_vint(GICv5 *s,
                                           GICv5Common *cs,
                                           GICv5Domain domain,
@@ -2131,6 +2144,8 @@ static void irs_vmap_vistr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
     return;
 
+    irs_recalc_all_vhppi_for_vm(s, vmte);
+
 txfail:
     /* Reportable with EC=0x0 if sw error reporting implemented */
     qemu_log_mask(LOG_GUEST_ERROR, "L2 VMTE update failed for VMID 0x%x at "
@@ -2228,6 +2243,8 @@ static void irs_vmap_vper_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     init_vpe_from_vpete(&vmte->vpet[vpeid], vmte, vpete);
     trace_gicv5_irs_vmap_vper_write(domain_name[domain], vmte->vmid, vpeid);
 
+    irs_recalc_vhppi(s, vmte, vpeid);
+
     return;
 
 txfail:
-- 
2.43.0


