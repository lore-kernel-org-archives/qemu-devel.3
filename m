Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C626EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOC-0007DJ-Q0; Fri, 04 Jul 2025 07:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeN4-0004s4-7f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeN2-0004N6-Jy
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:21 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23602481460so9202225ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627659; x=1752232459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMIRFy2ZY+UY2CacoD0sGAV9f6QXxycDwNFK+DT/I54=;
 b=QZls6nDE3crjl9cqr9EgKmG86uVckYT6LV+DefaRB6Ukn5Hk6qFAGkCx17uSqXspk5
 beRP6IIZ6i4AA7GSGpNYMkwizFTkLOo301QKdxe3opZGLaa2/6XMBY/vyNlYhAyoiVvy
 phUoOHcmEXvrbWYzlpeCiSDuYpK1bTZ308g5Z077VWNkr56uKWzfWrxpapKF3gG/+iDG
 Pzj4XwMWNnv/aHkxkLVc5CVpxkwJ1uv6RkcZSXqiiSDnZaG/kGi+bhtnv5N5F+mEXmbw
 7loskQCkQ8u3T9OLIKeZmkXK/uDuQmc7rrgS345nwhkEQQ55Qe2QkY352rK1ClrOu1Fl
 pDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627659; x=1752232459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMIRFy2ZY+UY2CacoD0sGAV9f6QXxycDwNFK+DT/I54=;
 b=ZFQaVmSesBGpyNqT6QvLQJ6QnKZcRRP8HG0N0tf2ary6ZrEOkFIAf7yZF3aMB5W/j1
 c4J1UWj9OrPmbIO/e1+7R8AhqLL8SzawrIYE0nR0NbgMgx6mLuBMMJobF3Fmmlm8YVAW
 LUNBmgXofl3xkaie2bNdJpOIEU7whuefwoTosCFpL+MQddyY5DS36Whc46xL2YwuQf/r
 hlxMee9eSel2XVwt1KI7TZh3fJwxkIKRVJ8SAyYpekCUEKyCko3o4nzO8gRK+e3DkVsP
 Ag/W6vOBIcHRouoaDTaCr0MbGiFX+Ycbki//h8fTdW+FZ/TloDIM7cjwBGEOttSm6CV7
 UflQ==
X-Gm-Message-State: AOJu0YyyHaCF/APWisL12rc6KJ6cUHSHVA6OklYL/kRPTmgsswNlv4r3
 NeAZcvAKz22HCQfuYcdLpr1ir+wpwJTV/svwMwMX7c0s1CFxGE8DFjpFrK5UuQ==
X-Gm-Gg: ASbGncsrOLXaKm7Nfhjok5tIcf2UDv1ZUkTLQQfGG0w00Ia4tXWoDBOXEwRZFMtSueY
 yrWlhJof9Wot4C21EL8YW9UXMe0suzNlOrhGMBmfuJMAnPDHdukbpWdVfJTMn5BPNP33cYZsOO3
 y+FD4ISbnIMMJhlzmIBADycOI0UnOwWr02DA/AtaM1bDhMpK1RztCip9Vpt1S0paK8fQgkUh839
 wu8mqzdcUt85QajfHc6DsFyjgbfgDn5KY36N+kCnX4ssxXASmppl99KWU/69HOyirES7/Yjf4RM
 vYwTH8ZvqaNtxc3mR52V6NwdwbcfD8y5awLwW47S4q26BlrzlJDt3MLZBfnt8lO1ZXSj5i4ufKX
 hLKnKxTqRuvrq1eCZoMNX/MOneOBdsMcJunwCjBafVUbm1lOCLIDOGNdOprwO3NUBDU4=
X-Google-Smtp-Source: AGHT+IHgoow+t+Al5xoxGSf71BTSkDQgpsc+gNRlmPCV85sDkZbAgtpjufpNEd4CnjwK4fmGI9AmNA==
X-Received: by 2002:a17:903:950:b0:234:a139:1210 with SMTP id
 d9443c01a7336-23c86320912mr39829545ad.53.1751627659018; 
 Fri, 04 Jul 2025 04:14:19 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "liu.xuemei1@zte.com.cn" <liu.xuemei1@zte.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/40] migration: Fix migration failure when aia is configured
 as aplic-imsic
Date: Fri,  4 Jul 2025 21:12:03 +1000
Message-ID: <20250704111207.591994-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: "liu.xuemei1@zte.com.cn" <liu.xuemei1@zte.com.cn>

Address an error in migration when aia is configured as 'aplic-imsic' in
riscv kvm vm by adding riscv_aplic_state_needed() and
riscv_imsic_state_needed() to determine whether the corresponding sates are
needed.

Previously, the fields in the vmsds of 'riscv_aplic' and 'riscv_imsic' can
only be initialized under certain special conditions in commit 95a97b3fd2.
However, the corresponding ses of these vmsds are inserted into the
savevm_state.handlers unconditionally. This led to migration failure
characterized by uninitialized fields when save vm state:
qemu-system-riscv64: ../migration/vmstate.c:433: vmstate_save_state_v:
Assertion 'first_elem || !n_elems || !size' failed.

Fixes: 95a97b3fd2 ("target/riscv: update APLIC and IMSIC to support KVM AIA")

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250616150034827wuHs_ffe3Qm8cqFXT7HeW@zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 12 ++++++++++--
 hw/intc/riscv_imsic.c | 10 ++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..4fa5f7597b 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -962,10 +962,18 @@ static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
 };
 
+static bool riscv_aplic_state_needed(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    return riscv_use_emulated_aplic(aplic->msimode);
+}
+
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .needed = riscv_aplic_state_needed,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 2169988167..6174e1a05d 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -398,10 +398,16 @@ static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
 };
 
+static bool riscv_imsic_state_needed(void *opaque)
+{
+    return !kvm_irqchip_in_kernel();
+}
+
 static const VMStateDescription vmstate_riscv_imsic = {
     .name = "riscv_imsic",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .needed = riscv_imsic_state_needed,
     .fields = (const VMStateField[]) {
             VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
                                   num_pages, 0,
-- 
2.50.0


