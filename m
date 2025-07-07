Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A088CC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYoQd-0001Q7-Pg; Mon, 07 Jul 2025 12:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYoQF-00018X-DF
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:10:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYoQC-00012d-JG
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:10:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so2772206f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751904623; x=1752509423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bROlhPdCMC1J2R6XdJEy/+mIh9pGdYXh4tGdm0da+fs=;
 b=im6xA73jIDW1VL15XHhkwotE2Fy2/BGDnHHQZeT90LgI5tfFFMECU/Y1KUQVAD3AbT
 jlcdhmzVfxQ/OAqNfqKcK0jdZmWpuGJsjm6+Zwh87NfgaeaLeylC8/aNaN/UjAgdcq9E
 YcRT8zm6PgxqEM8rJty9A8lC0LXdyHXtF5xaYi886HiYVJYPQowI9p4eIgF6f/vhMf0b
 9JQMUh3L5Zm2F5MNkNg2/ZH7YZJ+TFhYzpoB5P4FlFDtQ7+8RScQt8gVXTGkC0m7Vlvs
 TshKHywfRc0yIwfBLeVMJwTGqEQ0bcKW58RAXpmAk/M5fqFA8VwwGex0zP5y+GpqgJeR
 U7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751904623; x=1752509423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bROlhPdCMC1J2R6XdJEy/+mIh9pGdYXh4tGdm0da+fs=;
 b=FSTphhAO81FKW9zrNL8DZAKZc/7Q6Lz95DM41EBW2D7PaUh1kuUkIoc2sYoHpc8Epm
 3KSEImtQxXKef04uXMKA4BbMdCfLhGBtwPDlHw0zZ8Ddbof9yluPYVEtITU091ORb9WH
 j+imqQRyit0eClmjtmtF+NoOv9JXWrUwqS3LmSm3ZvnqQvo0m4+UMR7tcVECuwUr+QZf
 TtdCuxSkkCRua1xFKhPAaMWRVofVANgqeY+HHPBNMyI7jS1jN59hch3V75vmXn4Nyzc5
 oJpgCWAKXDSr6iE4h0YoW6yoWUFjk3Cf1VbfNJHGVRZWWVaOmgGP6kC6lU8EXGzPmDTk
 uSrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkXtreyqq9k+coRM7HRz9oBtX5oq65PUvLoDVW2XQPvimgxp6M/+fdwBAkTYmRqFO+c4+pgXXZBygj@nongnu.org
X-Gm-Message-State: AOJu0YyspdGvpFXeSDdMNM+dWvanf6X0wIMip5mB+l635H7/MAFPerLj
 c3k/ykposaIGK4CloTrxy3qAQav7pgqgj0ZYDa3buKr65TK7Mjiq/wUiEwcIcRI5qpg=
X-Gm-Gg: ASbGncuteDKtQW+ADQfxipkde1cBjsFa0qF2NImUCFuI7H/MXKVf/OQb8cHkJ/yHRSm
 8nyN+uK0/Tm6nVE6nmdLhBsYpMJqacO89Upet7IPX6pPNx7pxIqbfiMHAxipDNBKHwOjy02DtS6
 olpGqBoLLn55aQgYYhDGqNhu844PNxFWcvcfIAaJ/3h3piJSHmKoiMjk4PeauwB4rD6D+QjdQKO
 C4ENiS2WhrL8Lcb2xXu5iF0GhPHY+iTMSymD3x0HbTr083dFfuDTMEH7HqqB6QZjiDT5FNB4Qgl
 /KJUPB6pPxFy6IM9HobuTcj51BvsxeU017XhRcoNBmiBDCRncBbtaQ8syaYLqvn4KVg7
X-Google-Smtp-Source: AGHT+IEBQpgYhQ31Ls+TaF+32rhN5b5PFU63tv5/0YnBAYczfmr9lAXtD4VQMQQrj1Eedp1U8E4jeg==
X-Received: by 2002:a05:6000:41d5:b0:3a5:298a:3207 with SMTP id
 ffacd0b85a97d-3b49661df93mr11022670f8f.48.1751904622337; 
 Mon, 07 Jul 2025 09:10:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0aebsm10842820f8f.37.2025.07.07.09.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 09:10:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/2] hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2
Date: Mon,  7 Jul 2025 17:10:17 +0100
Message-ID: <20250707161018.585469-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707161018.585469-1-peter.maydell@linaro.org>
References: <20250707161018.585469-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The GICD_TYPER2 register is new for GICv4.1.  As an ID register, we
migrate it so that on the destination the kernel can check that the
destination supports the same configuration that the source system
had.  This avoids confusing behaviour if the user tries to migrate a
VM from a GICv3 system to a GICv4.1 system or vice-versa.  (In
practice the inability to migrate between different CPU types
probably already prevented this.)

Note that older kernels pre-dating GICv4.1 support in the KVM GIC
will just ignore whatever userspace writes to GICD_TYPER2, so
migration where the destination is one of those kernels won't have
this safety-check.

(The reporting of a mismatch will be a bit clunky, because this
file currently uses error_abort for all failures to write the
data to the kernel. Ideally we would fix this by making them
propagate the failure information back up to the post_load hook
return value, to cause a migration failure.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h |  6 ++++++
 hw/intc/arm_gicv3_common.c         | 24 ++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a3d6a0e5077..bcbcae1fbe7 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -267,6 +267,12 @@ struct GICv3State {
     GICv3CPUState *gicd_irouter_target[GICV3_MAXIRQ];
     uint32_t gicd_nsacr[DIV_ROUND_UP(GICV3_MAXIRQ, 16)];
 
+    /*
+     * GICv4.1 extended ID information. This is currently only needed
+     * for migration of a KVM GIC.
+     */
+    uint32_t gicd_typer2;
+
     GICv3CPUState *cpu;
     /* List of all ITSes connected to this GIC */
     GPtrArray *itslist;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 1cee68193ca..7b09771310e 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -275,6 +275,29 @@ const VMStateDescription vmstate_gicv3_gicd_nmi = {
     }
 };
 
+static bool gicv3_typer2_needed(void *opaque)
+{
+    /*
+     * GICD_TYPER2 ID register for GICv4.1. Was RES0 for
+     * GICv3 and GICv4.0; don't migrate if zero for backwards
+     * compatibility.
+     */
+    GICv3State *cs = opaque;
+
+    return cs->gicd_typer2 != 0;
+}
+
+const VMStateDescription vmstate_gicv3_gicd_typer2 = {
+    .name = "arm_gicv3/gicd_typer2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gicv3_typer2_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(gicd_typer2, GICv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
@@ -304,6 +327,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gicv3_gicd_no_migration_shift_bug,
         &vmstate_gicv3_gicd_nmi,
+        &vmstate_gicv3_gicd_typer2,
         NULL
     }
 };
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28d..0302beb0c07 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -332,6 +332,9 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
     redist_typer = ((uint64_t)regh << 32) | regl;
 
+    reg = s->gicd_typer2;
+    kvm_gicd_access(s, GICD_TYPER2, &reg, true);
+
     reg = s->gicd_ctlr;
     kvm_gicd_access(s, GICD_CTLR, &reg, true);
 
@@ -519,6 +522,9 @@ static void kvm_arm_gicv3_get(GICv3State *s)
     kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
     redist_typer = ((uint64_t)regh << 32) | regl;
 
+    kvm_gicd_access(s, GICD_TYPER2, &reg, false);
+    s->gicd_typer2 = reg;
+
     kvm_gicd_access(s, GICD_CTLR, &reg, false);
     s->gicd_ctlr = reg;
 
-- 
2.43.0


