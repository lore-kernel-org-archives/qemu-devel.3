Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B64FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUj-00010i-J7; Mon, 27 Apr 2026 08:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BN-SJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNy-0005jy-Oz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so73665755e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294104; x=1777898904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J6tijMHIxJGc5BneowlUtLI/eP+/lcFF2Xg0pH6aryw=;
 b=C1hznD0E+2xEUgzbzGycRywWYSapMnyVZYSMWk2CCoYn584OoO4MF3BRTKQgVKOgk+
 xLRJofzw8/n82TyCQFBeGa5WuWY8otNe/4bgi7VG5bWZhNKxRw1BFJt3CuN8N5d7Z9z/
 H3MS12FmRPqREU97qrA8JuhgkIMeJFd9Ui/RUOF6ucJG9dLoNag+eTNWGtn3nMpXdqmR
 xt1AN+sYDl5tlhJPWL0g1iJQkjnupg4Z6pIYcUlTyh0UP7CvUe1cS5UgyxNs9uYjGbqs
 acC8X6KMRdzPMPf8HlRvQKalSU5DE4OGCdSTx1rFY7NWLQzogmhsFan4jYvy+PzHJR1j
 Ut9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294104; x=1777898904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J6tijMHIxJGc5BneowlUtLI/eP+/lcFF2Xg0pH6aryw=;
 b=YlvuUIJtJlh2dk/9f9G/pUDdz6HGiiqUEH8nCPXq6XZyg5IH1xatz7/PevbldlU2xi
 LYIkj2F7MW178ZWhwJkkkPSZLWx3UJBUalqQLLqul+nFg4Wn+uguGa3Gi2jRJXxREcIR
 vgxBt4c9HeToYSX67iVukm3yr1qNQYukK/P9EI+r4eJasAll+b6IpjDlX5kfRbNu7vIe
 WmxI3VUlOX3uR3N9a6gZuOJUSPaPjpGYmqgZ18rybbMA8/pqM3Es1P023nFUNtOy22ew
 HHOE368RZq0dB1lDX3l8HNQheMEWJF2eEyHy0Vz+QTAjTLtrz2hGmuz6mntmCrGyGBEK
 irig==
X-Gm-Message-State: AOJu0Yy3FHK6TpKm+kRO66w8QhDZFX/fUoBE5YYjirtAzHufbYyZxAUX
 vIUNnu86RIOUZ0p1fOFhhKND73/ncXnTTR+IzqBY0hcmfiuT3OYrGv2Mj+riFR860R2xtw9SXYf
 W7DvE
X-Gm-Gg: AeBDietQ0IygTn0Ymq9uU+DIaOz4vIvOpg5Zv805gkWbwevzm26zFXoQFVp/UgHGFyg
 Mt/OA/SQBy3+o1HaVlYl7fVzQCC268Je3gdMvhaPurg2r5KgVWOQFxXTAx9nSUzR0MHV7Y9l15Y
 c2EVt43N/nMp3xAGeYEeuANYuQNEERnZ64weMQ6mOD4DIbOGoBs+eOKs5u41J6Usnwq037XSYYR
 3O/6t8cV4gkA6vvAo367T/MkKem+zC5rYVaBMiWCDw9c3MVNhjfmzyfuOZU7SwghnFqb7SfE7/+
 diLhmk5HqmivLL7gH6Mxj+OJhOUotQx7xIFebhl1i/XW49jfqNlPl9YR+BWazPq+F+P29jdTnOG
 BeThFFpwE0kfRftJH3bZ79sGougHF7aBtX6XN916Oeq1TtKUSlryNNpARH5Zlgrd34EKeWvLq1s
 iiATHLXr8p54Xoyzz3u5P9MbZPnQNDZusGq6WgBD5idUlgTe007QhcOmljEsryVgAVziud1I92a
 /je5a7AhbmezpUvhu7q4IhCnfsakA68X5XnuHsV6w==
X-Received: by 2002:a05:600c:a30a:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48a581c113cmr272110295e9.10.1777294103639; 
 Mon, 27 Apr 2026 05:48:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/63] target/arm: migrate BXJ trap syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:22 +0100
Message-ID: <20260427124738.966578-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is an Armv7 specific syndrome for chips with Jazelle
functionality.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-9-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 52a6745cb2..6fcf0ac757 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -440,10 +440,26 @@ static inline uint32_t syn_btitrap(int btype)
     return res;
 }
 
+/*
+ * ISS encoding for trapped BXJ execution
+ *
+ * This is an Armv7 encoding.
+ */
+FIELD(BXJ_ISS, RM, 0, 4)
+/* bits 4:19 are Reserved, UNK/SBZP */
+FIELD(BXJ_ISS, COND, 20, 4)
+FIELD(BXJ_ISS, CV, 24, 1)
+
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
 {
-    return (EC_BXJTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (cv << 24) | (cond << 20) | rm;
+    uint32_t res = syn_set_ec(0, EC_BXJTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, BXJ_ISS, CV, cv);
+    res = FIELD_DP32(res, BXJ_ISS, COND, cond);
+    res = FIELD_DP32(res, BXJ_ISS, RM, rm);
+
+    return res;
 }
 
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
-- 
2.43.0


