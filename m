Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD5C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCWX-0004QM-Pg; Mon, 17 Jun 2024 09:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris.chenfeiyang@gmail.com>)
 id 1sJC5d-0003ZS-U3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:08:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chris.chenfeiyang@gmail.com>)
 id 1sJC5b-0005W6-Ov
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:08:05 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso2403137a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718629682; x=1719234482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=72X5/3yhGLA4LtRdZgA1t3m8TQab25KcJhLKaM5WnaI=;
 b=fbAWEnM+x/qrrxVeUjsgBgZbM5FAUdvQPoRX/7v07A0XZ24xu/TjAJU+W/irPwgWKu
 8GI0LgWXxsjuj7JGN+5ZfjbFRo93tNy1exUIx9TbcABk68GL57PDRFbSdUQJ0a+FYhv8
 9zKnElq2ToZACCytXV0GVD7jlzgO7EosRkRDbLSWKPEZTqx3ejIoRUA2bT0ajmnQdX+V
 7O8Noo/k1A2+5q9bXjPbf0OizMYYnAavmDtL29r6YDzFXYJD5lVIbXF7/wgSy25IlE7/
 3usYvRrPQyzRxpHVGC05tgWaB63xRIN2fL95/TdegT2V8AR0spBq0ULs5B21jVRdVEtF
 MKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718629682; x=1719234482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72X5/3yhGLA4LtRdZgA1t3m8TQab25KcJhLKaM5WnaI=;
 b=u49ItMTFjTA6lVZAmCqfU42H6k3D0BxO88l7nvSVuPXmnfi+ypfO3U/fu02bEwm/uH
 l42jnpWfo2nqpkRMPZuCl3AQxoD0wty0oyczSm55YKR5h8LZwSc3CuicKEZNQl76Lauc
 wrEMfIxNya297pDoLVJT4ww7kjFI/RTVsXp3gZfhFn98kl4e0ljkFsOoYdK5iF/Y68xM
 +EihTt7phAQc3hOFnCsN2Asf9Z7AKYfBfpCX3WIJK8JSDKvjm5TPGWmqn8UP5s1ANG9u
 xQsbFn/Z+41fhQK2G8TXvZ4oMaVjmDzwjB4xUpZJDLu0OHjc7a3PhoK1pZjrQ6ESUM6h
 0SXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxz1E2EGluGHmJbDVtjzRO+Cr3uvmU85pwvMyiToK71kQuRlJ0J0o3UQbNAAGUOJqkFOSU+TreN1PEVXApxxZrwqzscZU=
X-Gm-Message-State: AOJu0YxyWrEmQupjEsKUs+IeKzy5AD5M51hqrnT+M0ia+s1DkVnVG0xz
 QMtwb1XhcyNQW4S9tis7qHAFmT+/kFfaoRAXVS+CnAYpm3GVoRBK
X-Google-Smtp-Source: AGHT+IGm/3qNyecsSOWeqmgEEVelwlU4M7Wj231Wp6tKTc2Tdu5/xT86vQDqs890EeeJw5TZP7VP9Q==
X-Received: by 2002:a17:90a:4a02:b0:2c3:40b6:293b with SMTP id
 98e67ed59e1d1-2c4db951e74mr8844278a91.39.1718629681667; 
 Mon, 17 Jun 2024 06:08:01 -0700 (PDT)
Received: from localhost.localdomain ([58.164.66.62])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c52f98f0c9sm1376970a91.7.2024.06.17.06.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 06:08:00 -0700 (PDT)
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
To: gaosong@loongson.cn
Cc: Feiyang Chen <chris.chenfeiyang@gmail.com>, c@jia.je, qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Remove avail_64 in trans_srai_w()
Date: Mon, 17 Jun 2024 23:07:32 +1000
Message-Id: <20240617130732.40183-1-chris.chenfeiyang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=chris.chenfeiyang@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jun 2024 09:35:52 -0400
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

Since srai.w is a valid instruction on la32, simply remove the avail_64 check.

Fixes: c0c0461e3a06 ("target/loongarch: Add avail_64 to check la64-only instructions")
Signed-off-by: Feiyang Chen <chris.chenfeiyang@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_shift.c.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
index 2f4bd6ff28..8bcf341b22 100644
--- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
@@ -72,10 +72,6 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
 
-    if (!avail_64(ctx)) {
-        return false;
-    }
-
     tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
-- 
2.34.1


