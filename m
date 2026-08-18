Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBFBC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwISW-0004dQ-Oe; Tue, 18 Aug 2026 07:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwISV-0004bs-4m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:58:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwISP-0005wJ-36
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:58:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-476a130c138so4692291f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787054295; x=1787659095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LybYRmQ9E3yF+WtyhOLMFZc8lKyl71GzSWY2D255ltI=;
 b=TpbgQP/eoINCYyrWZJBtW/iAYJ3HcwgtE/ajv0PiKF7wLSHD/x6aJknybclP1xYXVy
 lybcy67YaFsDX2UARKl8HVecvJPc4x29oWPBWYnEgxYJhNJ2vYwAcZithxa2J/1IvntS
 PZG9LllYMyTsxrzQTuMn/exqDTAvftX1WBDrjCNd2Ld05MpLhdKmt7fI1hG9LfKFJobo
 bI11oijuo4fbfuQcM/H5ldsowDkNm7Kqw5upHw6CLtGJcdtPnlqFgzEOm/HY8SUmgc40
 09hI/RAwpmmg6CLTGsyZN7B1n4tPHGWxCWviWnvvM5iZufg/6J3oogVgKTAjfxHm5YfC
 VJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787054295; x=1787659095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LybYRmQ9E3yF+WtyhOLMFZc8lKyl71GzSWY2D255ltI=;
 b=GxznGy6gfKfDnnrtuR4nz6Hj1GSg7t4lyP9ioWG2KSqfjrix074C4dxR7uIHNBSh5i
 IbO/wffFh6D09dueQKhAf9sV1zGnHHwJgIoKjNcVoZcMzlIu7cz6vzkvak36QQJVx1uX
 m5zWP07Cv5evONthwE+Yx5P4+tfw/Ei7aFyNyOSSsqwFfBbewRJJwxzzRsc30fBYgBsq
 JOD6kz5vn7fe82d1IlKyTWIW7ii7FmNvLP/qyf6wntN3Smn1rb4OCcl5xdg+H8hNdHqg
 JNgq219WFIOWM1QrjGADH9oi6OSF/OhLQmb8EH1wfYD8BwlPBFSuhuWAb/vNieeyKLux
 0acw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUGXf9REl5PgpuB4QaD7p57zXN7OGaxsUYjUS2+/eH1hGKDEhscgpIJpDr9SW2N/BCaFFsnCsd2hHI@nongnu.org
X-Gm-Message-State: AOJu0YznRzhr+u+X7JV4cwPDe3XEDoF4l/jktb8JaDeUMIexyGHqG0pu
 v7dNj6EWQJiypvfC44FZ5ehbLIdVIzIM7d9TyUM3HNGuxRKdRYSdwiAwbsy7cFzms1o8f4cgIwK
 MCJjv
X-Gm-Gg: AR+sD13924HdfEFlgUnE+glvhLM9G7H9A2Cn4BrbYBZJeRczObgemqez8k0nIYI0ELj
 ahoAwzyAbisaEsxMvSWdUTJyWBcpMlDseLrD0d4FbneFsYv3aDvQp9hd/+t7ouJGTrRI7zv9cvp
 Au8dbX4N+aSspYI6mEpn7G6yjHu69/j3TYSR53jPXCmi9+M8bq1JQEPbes/eZw1C+HB+OyrVpXG
 DZWE08fztNvl1/MRQw7dSVyeIX+k3u2TmDYZbxKWhD8BCwjBZuMfS1/0J/hR8R2NBXd9xkaCUcm
 tjmVXbbMmkdvdzkdCsf45pZI4Y8k5oCJISoAD37NldECbU9Ip0lQ2IhxIV4e7gyYvTfdCuhomkt
 87Zni502FxQWkKM9IrITIkTOlbgj7Q5MNMcdwEzGetUUUx/m8V6PBgDDNSFVzUAWH3E+2KPw+e6
 cIDGYPMNfMLFtPvYRuOcNbqoeP35ryzmBqev5xG0YVFF2Fy1mpgrKgzBpUnWw2+o8MbboR72m79
 pZUF/MIR3Q1C2GUlXjLspEbgSQv9HdFcKuY5YqLJaQ43meKOIoqMyvtJE83mLaT6qGYtVyrtSPg
 DdibaA==
X-Received: by 2002:a5d:5889:0:b0:47f:81c4:36b4 with SMTP id
 ffacd0b85a97d-48160738b9emr45443461f8f.14.1787054295392; 
 Tue, 18 Aug 2026 04:58:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a9f0dec2sm6797298f8f.10.2026.08.18.04.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:58:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Correct reset value of SCTLR for arm926
Date: Tue, 18 Aug 2026 12:58:14 +0100
Message-ID: <20260818115814.2268429-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

For the arm926 CPU we reset the SCTLR to 0x00090078.  This is not the
value specified in the ARM926EJ-S TRM (ARM DDI 0198E), which states
that bits 16 and 18 are SBO, bit 17 is SBZ, and bits [31:19] are SBZ.
It's also not the value seen on real hardware.

This has been wrong in QEMU since 2007 when we first started actively
resetting the SCTLR to some fixed value rather than zero.

This wrong value didn't affect any of QEMU's behaviour, because we
don't implement any handling of the old pre-v6 meanings of these bits
(which were IMPDEF), and their v8 reuse is guarded by appropriate
version checks.

Correct the reset value to 0x00050078 (i.e set bit 18 and not 19).

(We use the same reset value for the arm1020; this might also be
wrong, but as the ARM1020 TRM doesn't seem to be available we can't
check, so leave it as-is.)

Cc: qemu-stable@nongnu.org
Fixes: 610c3c8afd99f4f11 ("Reset ARM cp15.c1_sys to default values. Fix XScale cp15 accesses.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4202
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 8220d785f5..8d85333f4b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -33,7 +33,7 @@ static void arm926_initfn(Object *obj)
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
 
     /*
      * ARMv5 does not have the ID_ISAR registers, but we can still
-- 
2.43.0


