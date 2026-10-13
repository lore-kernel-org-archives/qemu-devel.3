Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC1CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9c-0002BF-57; Tue, 13 Oct 2026 04:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4Q-000171-63
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4O-0008FB-9b
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso24204825e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880871; x=1792485671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fam63WVG4qIrwWX1AvZPXPDPo354Ibas6nosiQf5fbU=;
 b=bHvsVRoa0mfQO47MydvMHD+1yMo3RptSvZc1mDbbuc36yDB6Sn9U5jqb7qhI+t3rBT
 kmg5KiGdv1HXUunmGLFtU5bmGwyYHJGvDBuM1TQZSQj7STvbx27Yn05oHptTAvEX5JtM
 VsMGP7EoFF6YN/i63ek8kgOj50QBq/TeWo7WBSoAT9Hn46GUWp70CWe5dKK+Qp0OxoBc
 Oq4HLtxcPF1Ait22SQaLKQJBQoacfeJic5mko0pykgd9Tf1Irp6nRWWYLBqiTehVJg76
 l0EEU8u367mHajlSwrKmwa/wwajW7Uf0G+evOlkJuRxOghPZr90O5edW+TG7Vt1bWrr5
 71og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880871; x=1792485671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fam63WVG4qIrwWX1AvZPXPDPo354Ibas6nosiQf5fbU=;
 b=gQhi4razdJ/McJyxbDQmlhyTjg3l8NIAqmno+nQyAPf5vWDgfJO+euOeym9vv7V58Q
 rx4AvCbO3br9Wb3sQ1wUpToWL/oMND9zBv6fC9+48FqCbpObGtKNgSDMAWJOVRbfSqMp
 1GdYftVh1+wsmZ8O+TGMttB1g96waeym5tGu+GKSuf7nTmJkh8GZ94SuPonNyX5f7xKG
 yGt65lv8zWcjH5V8yeSLbXBL5kZ/J9pYwN3DPP84N++t/NrKs0DH5rmKOai+BHqgkOTd
 m7ig3VbqqijgdhJ8M3T6maW6tXxLAOXL6wnehz49lev1/nJYowOT8GWdIayc4jJq+IiI
 LK3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM13y3lbPNU4yz9QuHbcXQhlpox+CWkVDujk+HVqx95nr8MEi6fPUmMbVHhAsYDP4g1av8e5wsrJ2y@nongnu.org
X-Gm-Message-State: AFq9FYLPQm9ZiREVF7ytPLFNAHnHX62jrkYwLomq+JjAwWPIRapz+l4z
 Lnz545Ty43eXrDP5iJ7npcOaaLwa72HiLakrBmc3dom1/3NuHtVdHe4cHMGV6EEMF8gyaiG8pUE
 ndQTuMbQ=
X-Gm-Gg: AYBFou3YGxWEDSCG7lNRs8gnPvpxZLcNsKzvnxR8UDMyxMFJmahBPtjalNq7IIn/AGG
 yIFjpSkJSoYN5SBA3B+DvM7OKApBotfKUhbvMlX1Tx5nBSF0RtRVG6Qoa9eGwU/dIJ3VX7dDvvO
 oaLqw2W+3y8jbvv6PkZ/F8wt9R45CRRDGRrNG4wtqbgMlCn18pllcIIJM6PFeRwBXfa2i5J9wTt
 PcJzEABkRHSCUUUi/sdsBg12jZSCths3mJspNl4dH65sak3atpCZLY4lFXfDeZcVebWWhouedga
 F6VPTBJaQHKA5aGGXFzqUi9wuxpH/9CU2oTGeNXJLxSSPBFKQuG+iR6j/TaoybGNLlzbM1xYTc8
 +FRtdmKCzSj18SMpwKqVenimaS5j4J5276b+tDV5p/DeFMpqvnUmuasKZBTd8pHI81OJE87PCEb
 9Ka9w+iozz/3bZpRJkqRoMx9VlYHrCaeN9+USfEyh/BHi08cIohXT6q76ZEhGpvthcJZqdNoEh/
 Jt7LXWzwgS2cjOVI2o7byj+ggDLeiXrnuutIVE3YHinaiZC2rjl/WPiqEuEJymsGNx7m33ccbMk
 KNQ=
X-Received: by 2002:a05:600c:4f89:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4a1acaa9f79mr22107965e9.25.1791880870738; 
 Tue, 13 Oct 2026 01:41:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 74/86] hw/intc/arm_gicv5: Handle virtual=true in
 gicv5_deactivate()
Date: Tue, 13 Oct 2026 09:39:21 +0100
Message-ID: <20261013083933.1024405-75-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Handle deactivation of a virtual interrupt, using a similar process
to virtual interrupt config updates.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7c68fd6cc2e..5a038fc14e9 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -645,6 +645,7 @@ DEF_SET_FIELD_FOR_IST(enabled, bool, ENABLE)
 DEF_SET_FIELD_FOR_IST(handling, bool, HM)
 DEF_SET_FIELD_FOR_IST(pending, bool, PENDING)
 DEF_SET_FIELD_FOR_IST(target, uint32_t, IAFFID)
+DEF_SET_FIELD_FOR_IST(active, bool, ACTIVE)
 
 void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual,
@@ -1097,8 +1098,12 @@ void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     trace_gicv5_deactivate(domain_name[domain], inttype_name(type), virtual, id);
 
     if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
-                      "deactivate a virtual interrupt\n");
+        const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+
+        if (!set_active_for_ist(cs, cfg, id, false, &iaffid)) {
+            return;
+        }
+        irs_recalc_vhppi(s, s->res_vpe[cpuidx]->vmte, iaffid);
         return;
     }
 
@@ -1106,15 +1111,10 @@ void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     case GICV5_LPI:
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-        L2_ISTE_Handle h;
-        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
 
-        if (!l2_iste_p) {
+        if (!set_active_for_ist(cs, cfg, id, false, &iaffid)) {
             return;
         }
-        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ACTIVE, false);
-        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
-        put_l2_iste(cs, cfg, &h);
         break;
     }
     case GICV5_SPI:
-- 
2.43.0


