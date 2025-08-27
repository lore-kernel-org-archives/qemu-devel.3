Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF45CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jF-0003br-PK; Tue, 26 Aug 2025 21:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hX-0001Fq-RR
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hL-00009q-MY
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso5482559b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257093; x=1756861893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9UF9kwXsCF9XPGfLIekiKxdaKcYyBFch6OZM4B4BRw=;
 b=xwRGYWv7WQvWnmTf56qyvWEkGlDYhgiX/mnn9pyZRsfdEnd0E+qB8G7NXeEzIn11n0
 7iN2vVuWIVBOQhr4E30qQAMDBwhvBu+vG7dcgh9AL8E4UujIb80ATQJSEhkan1WrRv0v
 YtdKjm4IQ3WxREzZ+msPQe2Ij5WLwTglZ6i/4fUlCVmpP2pM0drbUrupz15AxOt/Xfhk
 bNw14CLP/e6JgwS/E97ll0udphhoiqzszLnOIQqfMiDq7CEloKBIznNFpF6rHN3gjIaG
 zNNDOoa5Za/vzz1bWontdzaiOOkc6Zr+aOsLJD+UVU+rw1MHSMVwLCKjxRTDTIoDLLm+
 41pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257093; x=1756861893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9UF9kwXsCF9XPGfLIekiKxdaKcYyBFch6OZM4B4BRw=;
 b=wmtTE5WoMXC7n2g1j2RDNBdKUiDJis6AId7YQa5QyxgGRwN+qg44nUa55QaIryYIYi
 zqz/tRZeaWp+KTf4z2fSOVLuTivmdknRuotPfZ/x6ICyZOAGwWT2+q75YlIRu/i9CdWw
 JwgyG6JGgxF3V7FHOK3igXl+NNPX/+5y598Rc7d1PRlsiMhqIWpW2+OT7Dod14uoRAkC
 btviAgt7bxywueEwQ3RU2jsWI2xtRlXYS0MEnE+YTe37D/uQxObfazyQLRZEM7LfALH6
 nnq1lVpGRsTpVQ88MVWTR/y1EC4bs0RjZ3HK21AgLdkkIpRIGdw2w3n8f//lrISZnwdu
 cKkQ==
X-Gm-Message-State: AOJu0Yxqi9AJqxF4X0a6X4cNbV9hWjs7gpRYSnSGNwsNILzgCZAEPdgg
 3F/NJFNcYPtBNog/qZUdX2U6MwaFd4Lp6uDYgIB0Wat/1+G7gPUW6XnBLsgX90BAb9PQU1ddr2i
 zHCJVP9I=
X-Gm-Gg: ASbGncvsrOx2nIv6f1TZLJckomhh+/8WkA3Mmd46YUFxNsgvTDegYQZoYfZPQsIE+P+
 msu7hcjrjuXda3yD+SKl0hGM8w2kYWl5fhIPuCchh8nwbJpqh+m2ZpcTQFGxlxuvu0lcUoDdXvk
 SbANUy+EPw8vVmZjgRatNrHEniJxbujF9/louA/a3u/R35duebxHhC+SbrwaaYrstWvSCk8fp0s
 8N3QeNLUOR2hKI7fjvCl4uVvkD8JwZleHClXB/WpmBVeIP5uYVm2d34vHMEG+PufHBhaeaKSlKq
 vc2w5SNCG9s1vIVKO+VqK5fXvM+N3cXjyCJJ3Meqjc/YHGfe94Pijxgq9dxar5+J+CPjLpK8e3M
 5VIUNo2PKxIqzIhuFJSthWdsDqw==
X-Google-Smtp-Source: AGHT+IF/mzYod4qjdc8jh/cuhqmtw6VGdJ9fnFM/FRHRUt5DojyjaDdxsRaJ55ygP+nmSAO1U+e7iA==
X-Received: by 2002:a05:6a21:99aa:b0:21a:ecf5:ea71 with SMTP id
 adf61e73a8af0-24340b5b4cemr26504217637.15.1756257092735; 
 Tue, 26 Aug 2025 18:11:32 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 47/61] migration: Add vmstate_info_int128
Date: Wed, 27 Aug 2025 11:04:38 +1000
Message-ID: <20250827010453.4059782-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 include/migration/vmstate.h |  1 +
 migration/vmstate-types.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac4..3b3416c2c9 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -222,6 +222,7 @@ extern const VMStateInfo vmstate_info_int8;
 extern const VMStateInfo vmstate_info_int16;
 extern const VMStateInfo vmstate_info_int32;
 extern const VMStateInfo vmstate_info_int64;
+extern const VMStateInfo vmstate_info_int128;
 
 extern const VMStateInfo vmstate_info_uint8_equal;
 extern const VMStateInfo vmstate_info_uint16_equal;
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 741a588b7e..1476c278e1 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -18,6 +18,7 @@
 #include "migration/client-options.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "qemu/int128.h"
 #include "trace.h"
 
 /* bool */
@@ -193,6 +194,35 @@ const VMStateInfo vmstate_info_int64 = {
     .put  = put_int64,
 };
 
+/* 128 bit int */
+
+static int get_int128(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field)
+{
+    Int128 *v = pv;
+    uint64_t hi, lo;
+
+    qemu_get_be64s(f, &hi);
+    qemu_get_be64s(f, &lo);
+    *v = int128_make128(lo, hi);
+    return 0;
+}
+
+static int put_int128(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, JSONWriter *vmdesc)
+{
+    Int128 *v = pv;
+    qemu_put_be64(f, int128_gethi(*v));
+    qemu_put_be64(f, int128_getlo(*v));
+    return 0;
+}
+
+const VMStateInfo vmstate_info_int128 = {
+    .name = "int128",
+    .get  = get_int128,
+    .put  = put_int128,
+};
+
 /* 8 bit unsigned int */
 
 static int get_uint8(QEMUFile *f, void *pv, size_t size,
-- 
2.43.0


