Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580C5C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1Y-0001N0-IR; Wed, 26 Feb 2025 09:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI10-00012b-Pp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0y-0005iC-5Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4398738217aso59941905e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578634; x=1741183434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQHi+iUIglkFs/MGd8Ifst4Un0l2N6GX9nCWbfT0OV8=;
 b=nj/5/nSRzht0aCvrPODiMekvs5VcZATNJ583WYAKG/CwpMLFeZdBhmqZenVAEDXsHO
 cQAXf+cx7m6DA5PbIjIsjYnOQNn3cSDrgJyyjflrZPBs32PsIm2wCNGu5bfPUAD++gMU
 mglXK7P/3Kxe2Hl8VINyYtO7QwzQ1H1rDumk1T1mVuFWohnnheqGxNGpd1HsmOxEcK1j
 5lcx2eXD3LjWF2bcAGB2ru/BIDV2COJ54WWT2veg+mJmqHA2oTp7XSdUwecu56Yhs0Hn
 fQ/l7kYLhEgAVXub0RALJzZ2IZa+HMHxo/VjIJtrKsZTJGwI99ub14jLkcdpOYC398Nv
 j70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578634; x=1741183434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQHi+iUIglkFs/MGd8Ifst4Un0l2N6GX9nCWbfT0OV8=;
 b=g1gIJea+c6132XI62/dtSKi7ee3BTMPDJTLr3U1bECluqPRA7E5Hwks+7x5KYZdiF0
 sHVGTDvtjoRGLQoqzsXx0rmm3TM9gmx8nGg9TQiMPfCr+lc0kNuqXkUxTYI1ItDftyW9
 SXWIuC8U2eube58Xw+BekIQif6V98pwoglWtRh9j2kD7ESE5YXoeoKSPm7SEDrq+to5T
 nTcXwMtcgd2d2nRwCbYk//hQDxzNwPJWPbpi6DA3n7wieybQMj3OSx5ewquxljSMx5Ia
 bNk5p0WOSuTFRRsDhchTLv5klAZw73tzqywMn/E11/zD3EJUt3UDac4xmmMJ0mxVHyG7
 +NBw==
X-Gm-Message-State: AOJu0YyCD92gthtg+3wD3fSyYqUeZEd2tkEykRQgZH/g4T3ytAAWQG/6
 Frih8w/Il6vdguXX6nOrTFeJvwIimNsfaDTQdII3XXxZGqHKu/z8TFzy+2dPa94=
X-Gm-Gg: ASbGncvJ1gihoLSO1x3Sp7JGCyPJ4sRjq+x1uYDar8aKICJQsliLShbnb0WBhQL+d4x
 ZkDj5710b2bD+ZW3FVkjWxBJ8YIuPSI+85SzAHXL/S039KRkzGDS8I/pQnKzwBZcKLjW9ndcFHK
 nghcuiok3nMP8Xa44c5nkKnX3Uy73Br6jzGa/5hoNPiZD0nQk2yPYmJypzniWQLGbCyiMuhFKTZ
 ob0Vo1x7n+yCpsTZujKlJ9kNM6kNTHpxIGCQK/EOK2WSOx1dZXDBbWM2g33VWW79p2f5AuPZQ79
 jlU2voS9Zgo673Xd9LndU/+q4Cur
X-Google-Smtp-Source: AGHT+IFPg/9aSNPq2Mz2ikmYiTTmX+v28SQH7KdZrf5AKkoHNFfHuSnr/eYRn16ezdoesGdpvlZycw==
X-Received: by 2002:a05:600c:3b93:b0:439:84f8:60d7 with SMTP id
 5b1f17b1804b1-43ab8fd8647mr33502655e9.10.1740578634004; 
 Wed, 26 Feb 2025 06:03:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b591sm23363995e9.6.2025.02.26.06.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6417560593;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 15/25] plugins/api: use qemu_target_page_mask() to get value
Date: Wed, 26 Feb 2025 14:03:33 +0000
Message-Id: <20250226140343.3907080-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Requiring TARGET_PAGE_MASK to be defined gets in the way of building
this unit once. qemu_target_page_mask() will tell us what it is.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-2-alex.bennee@linaro.org>

---
v2
  - use the proper qemu_target_page_mask() api
---
 plugins/api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index cf8cdf076a..fa4d495277 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -43,6 +43,7 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
+#include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "exec/translator.h"
 #include "disas/disas.h"
@@ -287,7 +288,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
     const DisasContextBase *db = tcg_ctx->plugin_db;
-    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
+    vaddr page0_last = db->pc_first | ~qemu_target_page_mask();
 
     if (db->fake_insn) {
         return NULL;
-- 
2.39.5


