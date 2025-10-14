Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CB2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJp-0002U8-EL; Tue, 14 Oct 2025 16:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJU-0002Hb-0b
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:05 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIy-0005M8-JH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:01 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so6420654a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472450; x=1761077250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoIw7P/FRkCAcc/MGyohjxSN9UBkA6HviqH2a6+qnc4=;
 b=SQ/1I3aAkaTGSIeHMgbUOAmZxHK3MxI9fZO+2Lo/Nh5NESXMQVDT07FMjptKGtpSuY
 VNceYJsKez+0nOzxpIh/oCAdKbvuBINsXqBqSe8oUxv0yuc5+mK9DN0SLjbM7TNPxMpZ
 XIK9yzrVOj+Srj/A5dZUHu3oSrGJaPtYBi5XOb0JrEr6c4i1706F2RHCcZKoSsB7K5Xe
 iFxRNY3EaOXq6U+myy1VAAiJDXjrALhi6aS5W3Kn5fj+paEmMKIDSQEWwcvIYjMSs9V3
 qMLv6TBQa8Zm/Y+p166aVH6Az6Ce6jaL7uNdEIrr9zcDxgm0pqO+WYssKRrFH8MskEmc
 yncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472450; x=1761077250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoIw7P/FRkCAcc/MGyohjxSN9UBkA6HviqH2a6+qnc4=;
 b=j+7pX8cKjOKyu4tXrrV5/14/nyTVpxaTurGRRNhhx/S9zuxsaEfnCwUkHuE4D3KHAD
 v0Vq5fJ6lt3qFd2gJbsLZswWqMSBLSGm+XZAcx4wZ4UHo6UdAm30nssMDAKrNEV2D5+T
 ktsaQ8IcHni6mfvm/9wc5IGTcX91V5O0SZqwHchDUtwXi1WU7FkmDYI33KFL0aIfwHN1
 iKmO1UMMSTRvVX/jV+INz7mz1GE32e0w7oAcMSbPQnns9MZKSF7C2LM1Qc6OJ/5Eks5q
 3+IhnOaYFlr1wFRSTPccdrD3medJ8pzyewEpge76ZoEpNBc6s/4HyXkXVdvjjSfRRX+F
 +3sA==
X-Gm-Message-State: AOJu0Yz8Ipc6HOh+C01D3wnOOXj4aRCDMiEK4Jm9XmqqQvWkrbQEEHfy
 OrtnrQNORCbgAw6apwHcft5Zm35qF4QHM5tduLZM61QvDtrdzAlRcjV0vxu7mkD1pLiUcyrfHoK
 FYDSDIck=
X-Gm-Gg: ASbGncu5BNOzeTnTlyetp+iSHjPprtDZesECBHcbsTaCqSV0araeRw8iUW69XP2clHj
 +GFHbuU3P4eV4mDzxx/qERjkU2rK0h9o+eF7WgX6U65EuDYrbY86DgyFsiy1aOkDvyTJ0WQxk6j
 ChdCHszFQkBsm9wv5PDwtebVfzf1cGxEqRivsWXljsfL85pws2OTg/jjB/LT48UO2130V+jMXXT
 wiqMBUUWotzCWnvoUgXX5TyYrPJPt1Cm8+t5gNOKFrLNo1wds3fxT5SXm8kWheVYuaRAVquVrV+
 y5wJ514UiS1ex4xtaW8/1wR82d2Oi7PkXlv67F20Rj6QqbrcAD0RPuY0wS6JPbCQu2q2esy8K4C
 TYJ85Syw67f9fNxGpzH7TRsZKSX8bb27LcRTL1OIA4838PulIQEKc7M5x1jFhxA==
X-Google-Smtp-Source: AGHT+IErSK/ywl6oH+m8fAH95IQdH9iiHt6m5DtjFgl3Oan14+G9OSO8Cqw2GeBo6cOJizRcICE+Pw==
X-Received: by 2002:a17:903:1b0b:b0:269:91b2:e9d6 with SMTP id
 d9443c01a7336-29027402c3cmr363496265ad.46.1760472450072; 
 Tue, 14 Oct 2025 13:07:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 15/37] migration: Add vmstate_info_int128
Date: Tue, 14 Oct 2025 13:06:56 -0700
Message-ID: <20251014200718.422022-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
index 63ccaee07a..d8b9e157da 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -237,6 +237,7 @@ extern const VMStateInfo vmstate_info_int8;
 extern const VMStateInfo vmstate_info_int16;
 extern const VMStateInfo vmstate_info_int32;
 extern const VMStateInfo vmstate_info_int64;
+extern const VMStateInfo vmstate_info_int128;
 
 extern const VMStateInfo vmstate_info_uint8_equal;
 extern const VMStateInfo vmstate_info_uint16_equal;
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 4b01dc19c2..d335340e34 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -18,6 +18,7 @@
 #include "migration/client-options.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "qemu/int128.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -194,6 +195,35 @@ const VMStateInfo vmstate_info_int64 = {
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


