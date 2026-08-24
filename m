Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5B7C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRus-00037e-UG; Mon, 24 Aug 2026 06:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRud-00034q-G5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRua-0001qB-HU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so22068615e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567294; x=1788172094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aQngANFmgRclvGCJWhrJN0pPqpqgEwxPZ5cj+oiSFi0=;
 b=bgm/NRjY+/0TABiyVSpsW6K52jUXhd584aa7tHW9lblCUFMhTj9L0VyPKtpV5e0AFD
 igEw/0mREjlr+vPO319Vc+quERylWqjlfR0iN6GAUo/eymbpk7CtQUDy/VkH8LopqwWc
 qh4vnuPv8eWFG3UfNRjtP1tGKyEO+1qjG1vWd3dgGB42TrcH76ngCeQn3sIzqRT74+eS
 gZN1WwydyGGxQrTPQNrrdFE+pwQDcVd4HVCWTjQgWihF11ffSI2LfrP0hfs4d1g7jJM2
 Hp5Ar2wyL+kAIfHDL1Qc0dBTjtJ+HMBjgGGF4PsCTEmb54TOOQy3VqJ3zLmpV5Vnfdcv
 aUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567294; x=1788172094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aQngANFmgRclvGCJWhrJN0pPqpqgEwxPZ5cj+oiSFi0=;
 b=a91/XzZ5j7UR9sVTFdbkpLBKJMDwab4oMejzwTBhFQc3hrajX4INEzhxvN9QoBJ8vX
 U1hgR98YtmHj6HJlK6U6HgnY2Saejp5GqNb8++1LNy1ukJNXZJJZm9igmc495j7mvNa9
 CYOCsOHTB/j2hjv05trk+R1q5leH/4cMOJu0EsKqinWqFinqStrX3HrjKP2bJj05AjqO
 53QRdLwdJvK7ne+RVCEFnfTmFdr0NMr8e7XqPKvHOa1XY0Yyb6FrnAjPWocSf/yUX/Xh
 nqgbyYG+itCymT1zbAaa5EL2MriRq2N7NwRBX+apMpkP3jt8ddoCxRRKMsW4GXvanlS6
 u0KA==
X-Forwarded-Encrypted: i=1;
 AHgh+RooJ2PyqvXuQRvPI8VJJBQaihifMHRjc9S+NedAYfNSaW5EJebqyqGXCYFXWaB7OPwrGg5fB2o1GqaH@nongnu.org
X-Gm-Message-State: AFuF++kQxkeT6Fzr9sHAG5QiywQMsi4WgK8JfoO62dnCo+NpvrLaLVSX
 gbh3vkAtcLzx6KmU2jKNo3ISGfa4efO7lb3XljUUVKMNmdQS8ENH7hDgXIAU9bqiIOz69V8tU+A
 V0wsU4h4=
X-Gm-Gg: AR+sD13NsvtapPSsOGUYTpMpe0RYzhTiJ0R+iAp4FMn5/GlfglSP+zv5Ni8vrIzKHPY
 vlUcYIxhdS6gXM4gTNmwSg5PYfan6RMLvRTFuf1tE0Fmna6w8Ldq5ztwKC2D/tlf8TpMUOax93f
 GK8+Y4eqp7cRIX0J3AV50mrAyGg9T0WNkWgJ+9jwVv4LxBOW533ZzIg4fAlWPVh0/imR5P0sGbx
 GWxp0bLutWp8yHG1Lv/6sAW9pUIL29nGnOJ85zOh2RuVVul/1swyPqaZSPTijQ/7QoaZmCVqhEW
 I2uTBlmn+75vQhQmjNy80vgRpqSUbC+zqkGrgJ12eEHcyA/Rp8GORePHQSTrAqOBX+OxTu9eUYQ
 yFSYYxDnEmkj+mohyjXqQbi/NODlcXhjskq/HvfPaz51QLz7G7xqkOxuPwxE0GNfE+QNrrWlig/
 2wO6JPEffMb6p+ac8LZT5Av1XVrVpHGSmuLsBdc1ZK0wQY5J+qpvjSW3lgEG5Wd0W1v+T/UHPu0
 lUmoRv0ekV/HONu8V+UDvilnlbSnaVvafwrPMXCuG5mjRdhZ5R2wo3hVIbtfnQApxj/cg==
X-Received: by 2002:a05:600c:5394:b0:499:516b:83d5 with SMTP id
 5b1f17b1804b1-499c19e9734mr180882725e9.11.1787567294006; 
 Mon, 24 Aug 2026 03:28:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c355e6d1sm77730095e9.6.2026.08.24.03.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:28:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
Date: Mon, 24 Aug 2026 11:28:03 +0100
Message-ID: <20260824102805.639072-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102805.639072-1-peter.maydell@linaro.org>
References: <20260824102805.639072-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the guest writes to IRS_IST_BASER we effectively cache the value
of the VALID bit in the GICv5ISTConfig valid field entry.  In a few
places we check whether the IST is valid by doing a bit extract on
the register value; switch those to look at cfg->structure instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7480c12413b..8ffb2a49020 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1223,8 +1223,7 @@ static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     uint64_t l1_iste;
     MemTxResult res;
 
-    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
-        !cfg->structure) {
+    if (!cfg->valid || !cfg->structure) {
         /* WI if no IST set up or it is not 2-level */
         return;
     }
@@ -1294,7 +1293,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
 
-    if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+    if (s->phys_lpi_config[domain].valid) {
         /* If VALID is set, ADDR is RO and we can only update VALID */
         bool valid = FIELD_EX64(value, IRS_IST_BASER, VALID);
         if (valid) {
@@ -1604,7 +1603,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                             deposit64(cs->irs_ist_baser[domain], 32, 32, data));
         return true;
     case A_IRS_IST_CFGR:
-        if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+        if (s->phys_lpi_config[domain].valid) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "guest tried to write IRS_IST_CFGR for %s config frame "
                           "while IST_BASER.VALID set\n", domain_name[domain]);
-- 
2.43.0


