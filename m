Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0428C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLP-0007Tb-PJ; Sun, 04 May 2025 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLN-0007SM-Su
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLM-0005Bw-EG
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2264aefc45dso58852805ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395870; x=1747000670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zwc13b8kC9Z5he0z0xvhp1yrhhR7Vt1vlSABNOYVc1M=;
 b=LGQzhjBgt2ttE9oJZgT7ocBsB0XIUL8ipEyqdR4Z1JNyf9vZI0sdwavhYBSpqwJTRc
 D2C4sz7FkFFvssT7mKatxvoa8iVVetQV+gV0TX6wvmrhwLUIs3Ux3/gFlo2bmYH5G8L0
 fyWZuycALRVIKvleHBrdrRxHSuhGLQanxiVKFN3SbVCatkG8V8sZI94deCc7pmBni4BK
 +/oJcOOMgDjQcTFkTgg6Gr7YmFsuct9gh4A+d98YgKkpSeSned1+KZtOaU+eKFiRZiE8
 phlDSf1toMTqljM+rdDb9NLa/i69xwk0Rgu28zG3byM8XhzlkMb2+V0B/kk8H/7AgHnj
 l3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395870; x=1747000670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zwc13b8kC9Z5he0z0xvhp1yrhhR7Vt1vlSABNOYVc1M=;
 b=j229XyAZy9fim0yRA7B/V59i9fc89pfUxtt4CjKKTztKrs7LlCd0EHV41ZkJvCKD8W
 +cJ5gfUOAzUsORI7pg2PcrVmHyuRQHdNalu6JadaNUXnen7XfSb2tpVcIK1+q1mYyXs+
 4ya/bwNBCD9OKs8IOdgsnZJ0Zd7QsEJd8dbYoeOHVIa9OBa/ft05VTwCUCMudrJHMB6p
 gHgW08/gRCEDYs66v9xjkT3fYt5JxnSEttfTApNN3LUal5Wm7vsvxwXSkPzPgm1eYElZ
 c0csqq8KI0Rxdvw9Ere4w5kaH28KR2HSazSCDJwc15hIGTK0FDpK5PNDtaz3zWOx0KDU
 EwCw==
X-Gm-Message-State: AOJu0Yw5ZTfKCr/ffj7v6/0AlPgbLjSsHnW0FB4m6Ox39HLdodYM9pR7
 jSbpCztQRG9lBTpzvzugg2Lp6JO+pe3pKoF33Ig1h6YGTewcOIOdzZemogFh3bLOFrTrkVqAxLc
 YClQ=
X-Gm-Gg: ASbGncsb8F0TLadHLy4uSUOv/i/Ksv8tUvCEpBi/E2VgwnOZx10y1lJ4uylYAJ2laLe
 fbEp3EEureORqxw5j5q4fY2NnPURe4hrn7FYcz3B88hRhxSXnKvAYImgmxpRezocZEe3Pk2mZEJ
 /a+hYgr3l+2OBfiTyORGA+QI9Kt6iFaHH5F+68KUEFk5qJDZtmidJNOw4gc7T6TzahFP6gHO6GF
 v5Vz9fSyu2j6Aj6lV7FwwAON0giQ9y7nPknZ/RHrWzIaT2XJ7fc7My0/b0E6yIXMbdP2nXrR/Pw
 CGgitLC1hLD+7R4ShvX3MVx275lOIwBxSULgSfYxpdCkBBQ8
X-Google-Smtp-Source: AGHT+IECbiCHIB9yXeZyP/73ydQgOkmKcL7fDhfifpt8nRB3vdpLxi/bJq0+dAIeGnkTNsGzJmDT0w==
X-Received: by 2002:a17:902:dacf:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-22e1eaeecf4mr93104875ad.48.1746395870493; 
 Sun, 04 May 2025 14:57:50 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:50 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] qom/object: Fix typo in comment
Date: Sun,  4 May 2025 21:56:33 +0000
Message-Id: <20250504215639.54860-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Fix duplicate preposition in comment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 664f0f24ae..7b013f40a0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -485,7 +485,7 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
  * Slot 0: accelerator's global property defaults
  * Slot 1: machine's global property defaults
  * Slot 2: global properties from legacy command line option
- * Each is a GPtrArray of of GlobalProperty.
+ * Each is a GPtrArray of GlobalProperty.
  * Applied in order, later entries override earlier ones.
  */
 static GPtrArray *object_compat_props[3];
-- 
2.34.1


