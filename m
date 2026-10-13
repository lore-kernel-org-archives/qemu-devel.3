Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E9CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8h-00085W-5c; Tue, 13 Oct 2026 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4P-00011k-B3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4N-0008Et-Cx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso22798065e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880870; x=1792485670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/MPD1vW8lp0kAxOSWh/UtStGkkrI/a03RZQPymBCy+4=;
 b=actH3kyTyQKYEJ+wsipulIB/diBA4edL2hJO9wsuwzOuSGMdCBzLEA9idHv8DKwWPE
 Mu4246fIxWSoqTUDYnHPfcJqNA7HNWFs6jXL8yYNKjNLjqfad8EI9G2CEibkkb7nlF9u
 pduXqVz6y1sX7e1U0CLM1wWcBVJeRCI/Xx86abhQenYRtdUXRS4j9jd+wLjc1lGoXqGX
 Pf4scRMnO2OcxlojIrQsqeuHyfKsueqmWJ4clflreXhPdAyZvWJAaEU3l6Tmd5RLvP47
 0Phg2qWe56WhN9cV3QuliHKVdrnkkGDMzE7P+z5/l7dyXwEbBbeuQ4MFIc3Jt/UVCfq9
 YqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880870; x=1792485670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/MPD1vW8lp0kAxOSWh/UtStGkkrI/a03RZQPymBCy+4=;
 b=JdT68kjoaeCqz9Zf/YN79yGgU7eA6Cva7pSMA1Xf3bs158cToVKHoQfUUP3EMB9yi+
 AQOUhMLbkFhvkCMMue3qzGJh+VEMfJxrkxNvn7Jp8vXLnBtAozltzJtfnZhGAq5Nr5B1
 doHnMDFpqtTsG3qJFvu5gv/652N878gNLuhwFAFEX3Yb6kccysQQEbMWS+OJKqRpljva
 sffMrJWv/6LK0bexvC7gKnROGj9f0RIUXAxLLf07XPI0pIqC/Gc4athjFAE5+ALxDhwP
 0TkD0qU8cVV1by92lUe+bds9Lf7p2RQlZE0OLrOtCD97g5J9cWhmv83/o7jkdBXj+tLw
 Y/7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMLvjQyIJ48O/NR0/spikgmAPFTk6tHwKXAcjw47yQ9S9iDgeWcWnWd96FowEoc0hxTUiELvegz08s@nongnu.org
X-Gm-Message-State: AFq9FYKLQh3dn2lVehzjCx3Nxc651dwdMftRc1Rx5yz/xVLPBf1gQzur
 hGL3V9/VF0ehusqvZ/Uim+HX1GbXBL4+d1z7R390ncOev25gvxbeS4xd15VJvWGcgCL9c8LONHA
 b4VlEutg=
X-Gm-Gg: AYBFou38T9zOPuiW69y9/EAD2/olKv51lMIZd29nDfARgolqooqxeSLvllfHpnLZF+U
 uJUgrTTR/AAKIcRyFiEPE7OsTsYG0KJ6hOFrWOf8Ur4iMeWOFZsX8zLO5J3Sh+0SqfXN2aeMlFN
 AN5ELYsOveNsfc9sHffYc4qwp3WyYuZFcApyK1WCgzlYV2RH5HfPVVyzEVMd44Baa+/Pc+N+mDB
 ehm/3KS++id34E8j9P72p1LrdenDIOxplBAMy7KD6SVm37iHlq4C0r8KTL7WUfZ6J5RW2xE9jkr
 g6Vht6KW575qUT0voGz+dqEleAvcKU42nHdt7UXKEoEhvmA4NzUJUznRDuUVwrD/g1YtZJ7R/EA
 k33WKH3Gae4ipE/lQm8YCUs3asK9fYcD9w+/w2r/yfsfCIDe1NW4c2QR5Mgpw+4thl71KNwIcL7
 nfjEvbCkrUICiTl55e82Zn3o14WJY1BtUs/PzpCOdRYQgO4O8Cx8diINupD34jK2bV/RJX8bvuw
 Ku3fB1d1sYHfaChJEwYvjH3n5i7eJAnJiHSa/e72mHDvd0sg2t9Zu8JLjXpnH9r7/If3jTw7aLX
 OQ0=
X-Received: by 2002:a05:600c:4e43:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a18e4b67e1mr211450245e9.22.1791880869818; 
 Tue, 13 Oct 2026 01:41:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 73/86] hw/intc/arm_gicv5: Handle virtual=true in
 gicv5_set_target()
Date: Tue, 13 Oct 2026 09:39:20 +0100
Message-ID: <20261013083933.1024405-74-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Support virtual=true in gicv5_set_target().  This is basically the
same approach as for the other gicv5_set_*() functions, with the
slight wrinkle that we will need to update the vHPPI for both the old
IAFFID and the new one, and that the comments and handling for (lack
of) 1-of-N routing apply equally to virtual interrupts as to physical
ones.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index c07122fe6e4..7c68fd6cc2e 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -644,6 +644,7 @@ DEF_SET_FIELD_FOR_IST(priority, uint8_t, PRIORITY)
 DEF_SET_FIELD_FOR_IST(enabled, bool, ENABLE)
 DEF_SET_FIELD_FOR_IST(handling, bool, HM)
 DEF_SET_FIELD_FOR_IST(pending, bool, PENDING)
+DEF_SET_FIELD_FOR_IST(target, uint32_t, IAFFID)
 
 void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual,
@@ -878,11 +879,6 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
 
     trace_gicv5_set_target(domain_name[domain], inttype_name(type), virtual,
                            id, iaffid, irm);
-    if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
-                      "target of a virtual interrupt\n");
-        return;
-    }
     if (irm != GICV5_TARGETED) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
                       "1-of-N routing\n");
@@ -893,24 +889,32 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
          */
     }
 
+    /*
+     * For QEMU we do not implement 1-of-N routing, and so L2_ISTE.IRM
+     * is RES0.  We never read it, and we can skip explicitly writing
+     * it to zero: it's sufficient to update L2_ISTE.IAFFID alone via
+     * set_target_for_ist().
+     */
+
+    if (virtual) {
+        const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+
+        if (!set_target_for_ist(cs, cfg, id, iaffid, &old_iaffid)) {
+            return;
+        }
+        irs_recalc_vhppi(s, s->res_vpe[cpuidx]->vmte, old_iaffid);
+        irs_recalc_vhppi(s, s->res_vpe[cpuidx]->vmte, iaffid);
+        return;
+    }
+
     switch (type) {
     case GICV5_LPI:
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-        L2_ISTE_Handle h;
-        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
 
-        if (!l2_iste_p) {
+        if (!set_target_for_ist(cs, cfg, id, iaffid, &old_iaffid)) {
             return;
         }
-        /*
-         * For QEMU we do not implement 1-of-N routing, and so
-         * L2_ISTE.IRM is RES0.  We never read it, and we can skip
-         * explicitly writing it to zero here.
-         */
-        old_iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
-        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, IAFFID, iaffid);
-        put_l2_iste(cs, cfg, &h);
         break;
     }
     case GICV5_SPI:
-- 
2.43.0


