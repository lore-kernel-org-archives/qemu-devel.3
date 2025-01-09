Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A34E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzd-0004kZ-7T; Thu, 09 Jan 2025 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvza-0004jf-QO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:47 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzY-00070t-NH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:46 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso241074266b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442402; x=1737047202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbdq8PuzmcKgRuOS6aY93DBa464+R41QKxYxX1E5oro=;
 b=qRA0C7Pnvk3CrPfvG/QzWuEmWmTOkfgRfg7E3BjXjo/94RdsMctt2qs1nxzgS1+Jog
 qhhQhpvTuVmSiP8tJBEtHive7Bq27gh4+2XnpzluT+3y3Fi6kuLRlvNmSNuVZsaN0MM1
 Drlbj1f2iEad/1JRWWzz841u+J3v4ne5h6sRa4WyRyNP0Wq3kpT1WwDsybcIaP51aOMo
 0UQ5uXTj1mdpimt5CAHbPxnr64ncrijF71sTpsxA3SnrqUuz1G4UFMBwFYOZucrwVbui
 y4lT80mn0HF65dZZPzfS3Rs0SkeSFYS9THd0I/Bg6ifamU84Eknklefl1KFkER7YrpAB
 YFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442402; x=1737047202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbdq8PuzmcKgRuOS6aY93DBa464+R41QKxYxX1E5oro=;
 b=FleZ6/KJXi8I71HefJdSeZctby8QVG8ZcsQEK81HXy5xhD9TkxMNocCMgcdNOhUQgv
 BqiF+C18kPGA52UxVytzbe62bRamvWMecLZ6Gz7QXY0y9Cu6WUIVjkqZ8ni4/0cNsSIf
 TiuxRuKdLB7r2gNng2XbYjM6oHBpgbrLwVa6Linu1gk7mJM3ckBeA54buCfrNvDUUm7J
 eCmoLtj3ZU0c+fA7lkN0XDiTWYIjIrsLv+ANNrwReHF0KdP9UbSNO+l11fxsvzmOTnC9
 D1y8cNWTni6//sqq+MWkkID2BDrUkVcvECedLAWQGPlbx6UFXOWWj+GYsQ5d2WQ8hjzh
 +/tw==
X-Gm-Message-State: AOJu0YzacUn5LIf6VmtWE5cKTjEEaHIobe/P9cLEvLsFAPKy2m7IuHI6
 WTRAsRuZ0umsgKfoixYAZgjck/M0fKkcbDVUfIhJ3BtyDH1pdceBHubM0yAFY/I=
X-Gm-Gg: ASbGncvdWR4lW2X+yGvbGXV/htEeHO9rGjuuxIiALK+zEA/viH6U+TBP2lS/+4A2eA2
 vK+tlit9KltXJEdi8F1sAN8HIZ1K6yHw4FU5FgK0h0TWNBG13iUFnsY8i6yDI+YCUTkkS6oTt1F
 Y9g3g9jclqG2sf3Ln5CAYebioB60r6IE5rp9fZAL5244CskdXuGyLDQvjhk6bqVUo6sPGhzHoV/
 JvWEWWvCClOIzZhelSR6zu3E3ChElILazZNfVO5j6i804OB5FScOWk=
X-Google-Smtp-Source: AGHT+IH6dT8d2jMmByGgSiYPn+KIYll83lFCU9Zm9sA4wwWr4o0xgsoLPDJlKYrCMx7BNMY5nIWCVA==
X-Received: by 2002:a17:907:3f86:b0:aa6:c169:4e21 with SMTP id
 a640c23a62f3a-ab2ab6a8e8emr619263266b.6.1736442401987; 
 Thu, 09 Jan 2025 09:06:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c956258fsm89110266b.107.2025.01.09.09.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2436260132;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 14/22] tests/tcg/plugins/mem: fix 32-bit build
Date: Thu,  9 Jan 2025 17:06:11 +0000
Message-Id: <20250109170619.2271193-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f27..d87d6628e0 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -135,14 +135,14 @@ static void update_region_info(uint64_t region, uint64_t offset,
     g_assert(offset + size <= region_size);
 
     g_mutex_lock(&lock);
-    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
+    ri = (RegionInfo *) g_hash_table_lookup(regions, &region);
 
     if (!ri) {
         ri = g_new0(RegionInfo, 1);
         ri->region_address = region;
         ri->data = g_malloc0(region_size);
         ri->seen_all = true;
-        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
+        g_hash_table_insert(regions, &ri->region_address, ri);
     }
 
     if (is_store) {
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (do_region_summary) {
         region_mask = (region_size - 1);
-        regions = g_hash_table_new(NULL, g_direct_equal);
+        regions = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
 
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
-- 
2.39.5


