Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136B8FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUR-0007Ua-J0; Mon, 27 Apr 2026 08:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-00087D-QD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNp-0005gv-KS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ad135063so93525355e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294093; x=1777898893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mCeEgVnnw2NoZfiNYPPKxzrAmF2FxXpUQF4UmPnKyWU=;
 b=GdSubmyJuBpGlKDsynr7THtmRIZB/ERVOTihBXEHh3JWzjCSK5g5f7trU5viPs0VV3
 PpjkX42CvS6wE3/v+eY8l0/TKUz2qKzbLr1hL/x6n3QRzZg9H3xt6Z89OxKe/ceE9nEa
 QydOp3sOjeIMaTrD1ToDPtYWHZ2SGbT6no5Vp1xUR0VwyZ43ufJhRwL3dh/vILDkdwK/
 vxSRZEG7mwxLzC1qGT3Yp03dIHzx2HlShmKLMeyye5sgzHAJqK1NusfbTjpArcriwJkU
 jM+/uJ2Kmq6NTCfRoMA2uB3HPgDp7YOFZBoz2L1i0kKWhUrpIs9TEjhDr7+OlAA4Wvpk
 LGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294093; x=1777898893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mCeEgVnnw2NoZfiNYPPKxzrAmF2FxXpUQF4UmPnKyWU=;
 b=Xl3aQCCk0ycp/VSmsQcjNbz6DbInzXyeuuznaFpSU9MwwyZ8oAvcXM3+N+BhnFO37+
 GM1h9KTG4iakH5AW4CFFeSxboxt//oX8OOIG5QA4NMPB8d+8XDPKX/QhMMd8Nd/uT+JC
 Wwb+csnegy/6u/UdXFeLV7YvnisIGItDxdZR0SMPMDNN59HLmnnONKcy+rzGoUW0aziz
 QHqsY4X2I+8n8gqRv6Rsi5w/KodXG1TMTVfGUKDVmeII8B9tyP81Wc7442WoZb26xMuz
 arKEMYyU9xk3sxt0MCr2VF6KbMO/rtO0gZ7Z9NSrHDKaTodalrq6ENh5YlnO/BXw6bRm
 cOnA==
X-Gm-Message-State: AOJu0Yy1TsWEbXpIMm7nrbfJEnJSgcqmg0L+YII/i8HHTNrBbyawzQZj
 S9cAo7CvpdFuMSv0O73jO7JvLQpsjsyDJ3JtMxulBecsMzpXYL+IRtl09sdA11/JLLEhlHNyBlB
 FKkzL
X-Gm-Gg: AeBDiettLSp+2wxPtoGg2sl1SbeKupUp4z/xHpzpah8gZcHHBpOFWBTD19BCASE9lZ9
 uTFdnuA987jTWgvDXq3DZ0r1BBV8TjfXuHDJqHGhFKelJls/UIsgyO8loKb/iCY123gZmTumcCv
 U6Pysrg3vaD5QoA0haC+VPYnCVTGVENHi3OMTtw5eGEhiGOPkA/WYRLGVqXu4ZRO3iaxCt8D7o0
 /TA0XBXGHxv/M/IrkkEQCPXwKgiFWIvhLYvRL/zCXDOTTrWw1WKVxBJ85sFIgZGZEOA5DzrmD8s
 BLjf04iyvsJCkTOdJr81pneyOOYMS5SGsxmrjCplfwFaL+skQx2BrSCGH/Jhpp6VYllJVIx8x3z
 5a1AvRc6L03goyJy6k7tGyysRNQ2A91ZEjuhUB96CCQ5Uy2eoq/9GlGW5q+OUJPIA6xHoa98hOA
 IhOyWnJzxk9hz8+4+NnYaKtq7n+FZpYByhQTMb4415aeLfcHrkICjVpZn6sm5FzsX5OuCqu3yh8
 4isMGO09QFCYwxP4ygH6Na6ZG3k95CbIunllM8tCQ==
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-4891c1f38c8mr512857775e9.6.1777294093277; 
 Mon, 27 Apr 2026 05:48:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/63] target/arm/helper: Define cpreg migration tolerance for
 DGBDTR_EL0
Date: Mon, 27 Apr 2026 13:47:10 +0100
Message-ID: <20260427124738.966578-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Eric Auger <eric.auger@redhat.com>

We want to remove AArch32 DBGDTRTX which was erroneously exposed.
This was attempted by 655659a74a36b ("target/arm: Correct encoding
of Debug Communications Channel registers") but it was discovered
that the removal of this debug register broke forward migration on
TCG. Now we have the cpreg migration tolerance infrastructure, we
can declare one for the DBGDTRTX. This allow to revert the reinstate
patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260420140552.104369-7-eric.auger@redhat.com
[PMM: revised comment, included note about when we can drop
 the workaround]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3ac88078aa..ccd6353190 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6349,9 +6349,32 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .fgt = FGT_CLIDR_EL1,
             .resetvalue = GET_IDREG(isar, CLIDR)
         };
+        uint64_t dbgtr_el0_kvmidx =
+            cpreg_to_kvm_id(ENCODE_CP_REG(14, 0, 1, 0, 5, 3, 0));
+
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
         define_debug_regs(cpu);
+        /*
+         * We used to incorrectly expose a non-existent AArch32 "DBGDTRTX"
+         * register with this encoding. This has been fixed by commit
+         * 655659a74a36 ("target/arm: Correct encoding of Debug
+         * Communications Channel registers") by the introduction of correct
+         * separate cpreg definitions for AA64 and AA32 versions. However,
+         * the old cpreg definition couldn't be removed without breaking
+         * migration, so commit 4f2b82f604 reinstated the bogus encoding
+         * for migration data only.
+         *
+         * Now that we have migration tolerance infrastructure, we can use
+         * this to allow forward migration from the buggy QEMU versions,
+         * accepting and ignoring the bogus register if it is in the
+         * source data. QEMU 11.0 was the last version that sent the
+         * bogus encoding, so this workaround can be removed at the point
+         * where we no longer care about migration from that version
+         * (i.e. when we remove the "virt-11.0" machine type).
+         */
+        arm_register_cpreg_mig_tolerance(cpu, dbgtr_el0_kvmidx,
+                                         0, 0, ToleranceNotOnBothEnds);
     } else {
         define_arm_cp_regs(cpu, not_v7_cp_reginfo);
     }
-- 
2.43.0


