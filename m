Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EF6CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8f-0007yz-Mn; Tue, 13 Oct 2026 04:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4M-0000oY-7s
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4K-0008Dh-DT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30884115e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880867; x=1792485667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X1axBU9YVOc4OpWrfbsWGttQLcfYQsseD9BVWGvayPE=;
 b=JbCNEkoDsQmB3y8wkn6GUT2iaZVUDabKb1nrTeB+hm4jQzMFWN6sE9XLs/VKQMLDgx
 JhHu9KkqsSxW4xjPkBleCXE3yk3lC9impc50EARm6qhb4SG29bW3xkgp+1PDKQ6+npEm
 YiuEGfXu4P0jgPzsCAK1a1aKcU18CLkO9Ex/+JGBNQGS+booUr3mFDyQSsTJ11XhV0w+
 ghaOwZVMNYoyyieXMxU0DJCUmMfcw79xuTz1W5bKmarMHECYLZvzPff/hjLQx1oPlolT
 SC36GhGIciyMbFMQ4cR4r7v6IDOAx16geAp9djkuzVewaC8PAHFcjDTrFWz/qLSbdeH1
 lySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880867; x=1792485667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X1axBU9YVOc4OpWrfbsWGttQLcfYQsseD9BVWGvayPE=;
 b=KdRZPWIBIJWoxOghSDubNxoez1p96OZYI6SkdsaYPJ9gFQJcRjNWTos005Mn2a54Le
 kJwPtz+C2hrUyjwygkI7dhMXcDn4d7A1zRaKkxEXxAd2aLqjxvxM64Jc/FBUUNYiJuKn
 a26ElWht/wBgYpSEqmjo9gqKL/Ssgo3XDh/gbfqOd28q1j0qF1IwRCX2Z6ZTIztOQdGJ
 DyhfUfGTx50QUAIrdYyO38EuraojzMk8YAP5K4T3mh+kSazbROxVNrhTgJMxh9/4StF8
 T/1s4J8U3aVO9NiqF4h3UWmCgeJDFMiTbboLAD4UHSgHdvEkXSuAkfZmIX0Jw2alU9mh
 W8iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYHdpVEXi0v8zQcCsDDJy7KXOpzvziJ+JaoiqEU8jFl30cZE52Yp3dGEh8ZdTH9xdhRwoyhXJKOy4g@nongnu.org
X-Gm-Message-State: AFq9FYKRTh4RtwbGpv1NPqJWbmDG4kJBSn1SPoqECbld20DFFxbdm+rT
 bV3wIxI6bVVvcmWoKgE+uEgu0gz23ODuU87qT7mHhb5EUXFtkfGST4oHn42p6NqPw9E=
X-Gm-Gg: AYBFou0ZKlEaJabI7SEEYWreeJ1gAv9VjXSryzTknTbqWA/CCuoYcl7Rrf+hML/ZBal
 AUDKMn5CpdyF9T3zhpZsQDziINyIML5rr7jrNk1mbJe2RxDubOX0T5wbohJPiQQa1QvO+PilaR6
 qimRC8wTPSEtzgncHDJ2lQdFjZT/5UwVJDHKNdL9w/YOwehuQv+7I85aCwx2O8aXlKyBjZ9u5rc
 e7E8fquAKCEq48xwYUDySZSan/jEZkhQBkjaLUg/obG7u8ttCUacPHFS6HNkHbY3f9zdTka7TuO
 PbP1I4UlJkcmOpd5gjoSjxX+W4MR9M/irVneVhjor95B2hRrz8TRxa4R3c03uKAPPH5igkt0sPG
 yXuPZA8IeGHHEcuHVLmIW1bPGrnUfUyaietw9l28o/Hle/EX7uHLZRJaFiGVIwr/1gBuRgAu6Xz
 nxvgICpB8XvnprIv54Y6hbvNAvR5RtnkhEfvGkIzHrIxXuHNyKqQ4vuZVrP23zT5DJ0KcQFt3Zu
 RtvtYLV8fMtSz0e7ZKyxLu2OliSqYYqN6QA4Cq0FofF9iPBoyNXWBxARwXZrAp311bhztMc1s+Q
 a1U=
X-Received: by 2002:a05:600c:8708:b0:4a1:7b05:3a6d with SMTP id
 5b1f17b1804b1-4a18e49881amr215760495e9.8.1791880866972; 
 Tue, 13 Oct 2026 01:41:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 71/86] hw/intc/arm_gicv5: Handle virtual=true for setting
 enabled, pending, handling
Date: Tue, 13 Oct 2026 09:39:18 +0100
Message-ID: <20261013083933.1024405-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Add virtual=true support to gicv5_set_enabled() and
gicv5_set_handling(), in the same way we already did for
gicv5_set_priority().

Note that changing the handling mode doesn't affect interrupt
prioritization, so we don't need to recalculate the vHPPI for that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index e460d7957fb..1bb649cf4f1 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -641,6 +641,8 @@ static const GICv5ISTConfig *ist_for_vint(GICv5 *s,
     }
 
 DEF_SET_FIELD_FOR_IST(priority, uint8_t, PRIORITY)
+DEF_SET_FIELD_FOR_IST(enabled, bool, ENABLE)
+DEF_SET_FIELD_FOR_IST(handling, bool, HM)
 
 void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual,
@@ -707,8 +709,12 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
     trace_gicv5_set_enabled(domain_name[domain], inttype_name(type), virtual,
                             id, enabled);
     if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
-                      "enable state of a virtual interrupt\n");
+        const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+
+        if (!set_enabled_for_ist(cs, cfg, id, enabled, &iaffid)) {
+            return;
+        }
+        irs_recalc_vhppi(s, s->res_vpe[cpuidx]->vmte, iaffid);
         return;
     }
 
@@ -716,15 +722,10 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
     case GICV5_LPI:
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-        L2_ISTE_Handle h;
-        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
 
-        if (!l2_iste_p) {
+        if (!set_enabled_for_ist(cs, cfg, id, enabled, &iaffid)) {
             return;
         }
-        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ENABLE, enabled);
-        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
-        put_l2_iste(cs, cfg, &h);
         break;
     }
     case GICV5_SPI:
@@ -812,8 +813,11 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
     trace_gicv5_set_handling(domain_name[domain], inttype_name(type), virtual,
                             id, handling);
     if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
-                      "handling mode of a virtual interrupt\n");
+        const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+
+        if (!set_handling_for_ist(cs, cfg, id, handling, NULL)) {
+            return;
+        }
         return;
     }
 
@@ -821,14 +825,10 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
     case GICV5_LPI:
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-        L2_ISTE_Handle h;
-        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
 
-        if (!l2_iste_p) {
+        if (!set_handling_for_ist(cs, cfg, id, handling, NULL)) {
             return;
         }
-        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, HM, handling);
-        put_l2_iste(cs, cfg, &h);
         break;
     }
     case GICV5_SPI:
-- 
2.43.0


