Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC1EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNc-00075A-Rc; Tue, 30 Apr 2024 15:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNa-00073u-6B
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:06 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNX-0006kz-KT
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:05 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7dedc577011so62704739f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506181; x=1715110981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oO6lVL+LVK6xULV3eqZmGPXjUDThyU0i78qX8xOIR9w=;
 b=IFcYC42udXyZLO8cURfsKnbyrTtAgg5E9OTLzTxaR7EOhJKmprgazy0APBJ4PE2Isi
 lryanpzj9+nWFsPec9Ajv9Bb41TBVJ1EihbvV4naQtR6Dyd4FMp8WUJXmPCgX9b6vL6c
 Q9s9s/frq9lsmyCCzyyIqMq5QVAH+3eZy1E3VnEg+hoN9dIicAMnibuxt4zwvADAZJJS
 WK884PpxZdKhZ6XGkwNVNwnnVbvW+qis1DD0G1go/usgpF75+eIRKzIkWbSJyE/mEdLG
 TFA7Enw15K8rMYQQX+nKPr9MuUVlCPwDRYmEwjN9Tv4P4lqKMgRy3cW59mqKd1hZ3wFB
 DmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506181; x=1715110981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oO6lVL+LVK6xULV3eqZmGPXjUDThyU0i78qX8xOIR9w=;
 b=mSBLAAerG3t57bJ5Ai3QD4R7PIBheTBz0YKaZpVNJA49PpmOIcltzAgSWPBIEUY0oR
 iIiYzTujVAI1pZBFuO9kRvXUOctox4mBAKZfTICS2mVNouzC5dMS5fjvbqcQDzjaYH+b
 1wSidEbekLPfRB1ewl7m1fb91PsZUhuo6HAgMo0Vs3HIZGHMinMGPGfjUWbwMFTgdVWB
 +/eGoEk48ht/po/QdgNJ97LInel/132oGrtK0Z89oQlXYTgYUBdrfm2uvmvClTFSy16e
 o4E71YTGXQzepHgYFvPV0L96EF5PZRxAyR4Ag8C8yd8utHpegcNa/tQ5JhE1bMPMUqx7
 a4gQ==
X-Gm-Message-State: AOJu0YzohwT5Qr5euf6ZjOHY+1xaiAilxTOLtCZvKXVhXJ/PaTKegDWl
 fcMmfmVdMht4iOnZsFbobQNNY1jc56CCaVqyhhYvkCqy78MRW6LATPEJuknpapP9ci+Zfc/lok3
 1
X-Google-Smtp-Source: AGHT+IG1ktcSOZd74dI8WzrdkbFPn2ORIAtjZzBYt9V/03se4a80N6LIxedt/DS5lEPYHuAmpUNklA==
X-Received: by 2002:a05:6e02:19c7:b0:36a:2a57:9393 with SMTP id
 r7-20020a056e0219c700b0036a2a579393mr950428ill.3.1714506181328; 
 Tue, 30 Apr 2024 12:43:01 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v7 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
Date: Tue, 30 Apr 2024 12:42:50 -0700
Message-Id: <20240430194253.904768-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index c9a7ded016..f9af7841ba 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,7 +26,8 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool (*buffer_is_zero_accel)(const void *, size_t);
+typedef bool (*biz_accel_fn)(const void *, size_t);
+static biz_accel_fn buffer_is_zero_accel;
 
 static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
@@ -184,7 +185,7 @@ select_accel_cpuinfo(unsigned info)
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        bool (*fn)(const void *, size_t);
+        biz_accel_fn fn;
     } all[] = {
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    buffer_zero_avx2 },
@@ -231,7 +232,7 @@ bool test_buffer_is_zero_next_accel(void)
 #define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
-static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
-- 
2.34.1


