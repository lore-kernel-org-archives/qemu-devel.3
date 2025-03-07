Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD94C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsk-0007Z5-Cl; Fri, 07 Mar 2025 13:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsX-0007UU-LE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:01 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsW-0007pA-1o
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:01 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22359001f1aso56337425ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373819; x=1741978619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/kc5PC1uGwC95AZ8XXvOvpXwja1rKXIUn6SjN0F6p4=;
 b=HdBxbeRAoE34JBBO99JjyTNLboG8xe3MAYCaH1xMBnZi+dPKwtkEU4mQTV6zZ04Wur
 mb0uUEWZNeOo8Fe3QJNvkJxjEerSZFIBDyW0TG5PSRZA0MnWoScMfxgrm5KxVYdaaaXW
 AD8VSqNS1czF0rlRWwgRBWl208QKP6XZ+meTSUSE/i/qVf6NB7sEFg07Q65NmSUp7R0w
 gysuUFgp2EsdG0PTjkwyifIOx7Dgd9D88XVvqbDduh3uCzW0oglKcb7GvZj/b/s1fJDN
 Xwu0FsIAT1EwzTBGPibtul2/Dk5otzBpNq0fbOcqXPyNbtsv9Tbvt8JlQlAemgQVXIPQ
 ah5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373819; x=1741978619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/kc5PC1uGwC95AZ8XXvOvpXwja1rKXIUn6SjN0F6p4=;
 b=ui1+biN3Z44coHa0YC1hGbd8y6blxKNjUubMpXtiY8x1b3OfZ7RXdhACYBxi8lM9hG
 50WsqEW9a63KOCVx7t4YlXGNMITrBeTah4UWI3ngx7TtZ8q9LIID9BWkUq+tNRtuOK2f
 9EQWxiNU8dwdt8JMpcY5wfZgaLrMc3Ryw0Ca8IvhN0yzyZ5fDomSXFw/RJQdZvKjVG9v
 S8DhdIMW2EgXLw3r1Sf1baZq6IESiXUpMQhyWlZptPHM10G7xman1TJBeYFzsSukKANo
 DmRBjx2qPJnBKoAVUN+x48Wv5cijIv9VMe7qlJyjjD2Mhu1CCqZXBswvZzFMCdT203e4
 B/1w==
X-Gm-Message-State: AOJu0YySCoEwKxdzZop2zsdYaInoT6ixqqWnwX0Os4WwsMyX86ritFXC
 zMMCwT6I1LOp56CorlorPSjlWPb+xjaJAHNjoN09jAxqo3ZXi7H1A4LWm4IOD2JewAwH0UBdkNP
 8
X-Gm-Gg: ASbGncuA+A/ERAXENv1MvLod8AkCiruXiD3m6LbBhpUU9c3x30Z6cpZkqo7GHKrntVx
 6S2Jv2VByfhgFFqGdFG4gE1YszKEqkFvmQm3JlCWW0LGOGSNDQ8NsF07Q2h6tmcFwJJBHsrNQpw
 /qWUobHis1Qp643W5mAQCN4+iQvYWWMMQiVO4PFcJEBnJtRdDIcOUPRniXfKpm+N4gPPOrOgPFS
 t/FHoRADC9s6UvC4gSOEMwJsAYKSIJa0sP4zONCHaMBC9X83Hp3+aY9QAnEhh2yUL2PkTCJaHZO
 uUeqAEPcyX+LCKOCI3o7GrNwWkSWZf3zHSvw2EQ2BS7RANLF8eM8cLI7vFkbtRXnRCsnCoFCeKc
 D
X-Google-Smtp-Source: AGHT+IFmxTlJESQ7qxX4DXnJtmxhjTfPxFs5NX5AIqnHgqBl8jmPGHzAibA8jkKYEEbhsNIkiJcZCw==
X-Received: by 2002:a17:902:e5cb:b0:224:ff0:4360 with SMTP id
 d9443c01a7336-22428bdb52emr80324215ad.53.1741373818689; 
 Fri, 07 Mar 2025 10:56:58 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 15/16] accel/tcg: Build tcg-runtime.c once
Date: Fri,  7 Mar 2025 10:56:44 -0800
Message-ID: <20250307185645.970034-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.c | 8 ++------
 accel/tcg/meson.build   | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 9fa539ad3d..72c4c6bd31 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -23,13 +23,9 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "cpu.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto-common.h"
-#include "exec/cpu_ldst.h"
-#include "exec/exec-all.h"
-#include "disas/disas.h"
-#include "exec/log.h"
-#include "tcg/tcg.h"
+#include "exec/helper-getpc.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
 #include "exec/helper-info.c.inc"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 81fb25da5c..411fe28dea 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,5 +1,6 @@
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
+  'tcg-runtime.c',
 ))
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
@@ -7,7 +8,6 @@ tcg_specific_ss.add(files(
   'cpu-exec.c',
   'tb-maint.c',
   'tcg-runtime-gvec.c',
-  'tcg-runtime.c',
   'translate-all.c',
   'translator.c',
 ))
-- 
2.43.0


