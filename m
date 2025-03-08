Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13CBC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39W-0005Gy-JV; Sat, 08 Mar 2025 18:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38b-0004f4-Uk
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:23 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38a-0005OM-7D
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:21 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224019ad9edso72454195ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474759; x=1742079559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDCdWZkLjIT6VVlI83+qjJp41u3agVi8F9xK/yxm2ro=;
 b=FPqBDS5a5ECM7YyxAT8ENvZJSjiU7UFA4+RCsJo+nX5/zUgBxIcThlW7gQgerQEuCP
 GG+F98bvfD0eGr6yqPfrMMQuE0QY+CD5NfsBtGxETPSw7+SQ+v87lgk2VpA64IpxgbBV
 d+LaDGhkHWeyMRMS6eK0lV1iHzU0wdXdezMQqVh2ES/C+9Ghd6gxneGGEPvpFun2YCJB
 c9EQaVTDwdilARaOs0lbIL8BNwo3orkQ6GmBUytfnaNOkjevjbXpkcNv4UnnpZhBz2q+
 BGsi9QZgU4qNImklx6221yuZSIh3XdlHiVQEeuFjA1ZPjK9jPDIVWpmktTE/tdEWD9pZ
 SLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474759; x=1742079559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDCdWZkLjIT6VVlI83+qjJp41u3agVi8F9xK/yxm2ro=;
 b=MyaLcT3Js5f4aPKDLOzGI1/r4moI6o3bY0CP8N2uHE4VULf4+cBrM3IdFKJwqxdoRA
 BttP5OJys2/X2IWNiiFnsV1rGjgKQZZGlqfuUhUVGtalSTpDxl0Fq4Kp7kxFUX54IFhG
 keoSQeeuPB62dcEcmgdgT73fSf/Xp7RiPAc6XU1TMV/EJzShGQ48evpjHdPmC7G3o/8S
 M+1s4yQTmf2kxcbQxHCoh+90cxHHBuaZO5ifARtyjY7pJcALPiE18XD1sTpfJV1gB8SJ
 gnqKOK3mHJZqiRFswbP1KRp8slblcieGlJH84V5THuuZWy9LWhk6xngZsHBqzJHX7e8v
 jo7w==
X-Gm-Message-State: AOJu0Yy56sDfpv6sltsBHp6JDCsce5vpIg2Ac7FbdpYFcyWlfGBNgC2v
 K8r80Fg6DcuinIIkRjF++/Xr6gfn+85etfAgNG7a3CgrRl0oLGkdaEaRNjMZZTJZBqbck23cED8
 U
X-Gm-Gg: ASbGncvbnf2Am1gX571XHGPsTh4wHTt3RZ5XAR2zI20NIpwamVRnbEaYDJER+bJd2GX
 cUsf9Ii2k9iBM1HdRK2mt8n5kLAG1WCZY/EmOOwK6z7y4fm/58qlO+8ohmr7IsC78exyauh2BtR
 wOjUmLRyEWinOB29RoP94ocLcJWHJEdObGuiGd4c7TwUeBM8xv2xPMzkcMNEpB4ZfUPog2fbobX
 329jyaNOuL4Jrj228rSqDmwi0kfAR+Rx3HT2PeEUCvFONODY61aw8ecM3BooFD4/V4TRBvP6AQU
 FfrKFKao3cjJE4Z7d/nwNzfADLRptZWZG7f8N8RZDJjL8qreimq7E2XkmJYFvHq1d/ueNK9hmlo
 T
X-Google-Smtp-Source: AGHT+IEd7Vf+G6b+cSwKctez5TubMnm038AOVMZFW7EMiHSSzd03A90BbPPTQeKNHsgmOzTJAwlH4A==
X-Received: by 2002:a17:902:d551:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-22428ad54d8mr129329395ad.51.1741474758707; 
 Sat, 08 Mar 2025 14:59:18 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 22/23] accel/tcg: Build tcg-runtime.c once
Date: Sat,  8 Mar 2025 14:59:01 -0800
Message-ID: <20250308225902.1208237-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.c | 8 ++------
 accel/tcg/meson.build   | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 9fa539ad3d..fa7ed9739c 100644
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
+#include "accel/tcg/getpc.h"
 
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


