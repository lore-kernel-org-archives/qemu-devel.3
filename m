Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CACD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNX-0001mh-Km; Thu, 21 May 2026 20:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNU-0001mP-K6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:36 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNT-0003Qq-1n
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:36 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so3387734a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408273; x=1780013073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTpzrp3v7OuPZr0RFgUjrkkB38tfHLGg+Gs3ZTn4bD8=;
 b=AuZMVYr/hZW6ZiDzSn+Ei/ZS2PFmt6zPA8F1Yi7Au19+7vr5rzsU9FGqqVjk3O3p+J
 nQbX/xnYs6yyGFPZMpJtNzJW3rxgc13MR690yQ8nvVjWEqa8SiIQWl45oEAgIbv/CqOW
 9jZQzeKwp8xwGtMhoQBPultH5GgqtJlSTWs+1azrCv0+juiONjG7EYD8boTmke0B+m7R
 jrroDRIMeEAX0L05s1yPvBwgYSWO9bS5AOPw/PzX448iA421jaKcm+ri4Xon9HRtAuUm
 pzYM3n8mCc8erzULTlRxVICQTkPGfVNDWNIH6BvcUH28cWf5op0ZDhVXqM4N0/CRDXlv
 tr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408273; x=1780013073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wTpzrp3v7OuPZr0RFgUjrkkB38tfHLGg+Gs3ZTn4bD8=;
 b=d1j189pPr8rhD9eEJdTt9zWvEogpMNMLotG2rn9/12AVfKQBocoA3tcGz7o0jCD/to
 slC5fJ40GYl37bFuKIkn4SScnf8vieuVkQHIgF8jVrooV9vL1TDKJNJQiyfvNGuXUXCz
 XkqsFcYR3BcvyiQEFN8x2V9rNxRrbdU+Fvm9sKczx56EOfjGUIocBXHXjCC4AUUMtfkp
 Rqm5pZyT/WcimXfJF3ie2Eh8htdUUNv1nUgRsUF6GZ/X64bABepGykDR/ibPFCGp24D+
 HSj4brJFcsNfWaIqnwUP6VR/j5YevjhuxAwAOk71GOGd1Vqv/iZF0+9owIO/wwg0u47Y
 VQPg==
X-Gm-Message-State: AOJu0Yx1HH1M6cw8lOKwuwXu0jTvOvZl+XA9UDO9nCmbFVb2kN5h6Ifc
 /CfOLyWcCuw0L7ciEFaY/DAfOeJrsGOateQdthxzRXwjCidUDD3TVMJ6imkJ/DkN
X-Gm-Gg: Acq92OH++VJirRI4zBlfAPcWwoXMnnvxItGa7jwCspWl7zjkTa7Ow5JS+jCajjoIdQ/
 xQig8y761Huo0nZmg9USY4uGhOxYLXZjJaZC5KITIN8e51axG8WobKqJ1rHv6Zx0Q9yoHBEZROz
 mJsj8x1FzG7GKCxDaZbGJQyPK04+0PNXTL2SBpJGV5ffmgOmmD2PFjLfB6GR1IR+OoLqWvM4lHv
 hvbf8km8goBm20/QlUFzAHoKhyaMk02IpZFuli3Y3Uk5ESymdtSh8RgKR/Aw29HJo6Ryl7+Zn5q
 PBPSUAhzIqCBCwxPSL6CidPLpf+suPqKujGHaVrKcdlRkcSLbM80IUrBPxrwiU4qkMzDuvjtL37
 x51CFFCVfVuZGXI8vdC6cWgFXlgLDqCzqaV4c8/+0+y6AdXQnuOnVpAsCIYNDX8CpOB2SutG1BC
 w6XkHrcoDRpJg0FMAcL+wZQldCMD9cqCs2WxkZCmbGbQ==
X-Received: by 2002:a17:903:110c:b0:2b0:4fb3:c771 with SMTP id
 d9443c01a7336-2bea20a161emr48763975ad.6.1779408273464; 
 Thu, 21 May 2026 17:04:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/48] target/riscv: Add mseccfg to VMStateDescription
Date: Fri, 22 May 2026 10:02:54 +1000
Message-ID: <20260522000324.23255-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

From: Zishun Yi <vulab@iscas.ac.cn>

Currently, the Machine Security Configuration Register (mseccfg) was
missing from the live migration state. This omission causes the register
to be reset to zero on the destination host after migration.

Fixed by adding vmstate_mseccfg subsection

This vulnerability was discovered and reported by SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/a22e4459cd026ae970791dfbd9cfe5d110fbd46b/output/riscv-isa-manual/pr-1879/qemu.txt#L121
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260511124828.3210477-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 09c032a879..6776e7bf5a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -423,6 +423,25 @@ static const VMStateDescription vmstate_sstc = {
     }
 };
 
+static bool mseccfg_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_smepmp || cpu->cfg.ext_zkr
+        || cpu->cfg.ext_smmpm || cpu->cfg.ext_zicfilp;
+}
+
+static const VMStateDescription vmstate_mseccfg = {
+    .name = "cpu/mseccfg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mseccfg_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 11,
@@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ssp,
         &vmstate_ctr,
         &vmstate_sstc,
+        &vmstate_mseccfg,
         NULL
     }
 };
-- 
2.53.0


