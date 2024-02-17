Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3691C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jw-00068R-BH; Fri, 16 Feb 2024 19:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jt-00066S-O5
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:33 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8js-0008Gz-4d
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:33 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d72f71f222so10656755ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130371; x=1708735171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijJGORoBUm3OaIKDGyVcLAHo3HCT5x1FLS32130PX9o=;
 b=mseDhCwhM9L63/KctK9w/i8kVh/CYQU7pea2pQewzp2IIhgK0f2Z0NjBHOvPpVaAEM
 yrKydpx+Z24fV0o741+oZBPiOdY1QrCc4HgbTKV4q5BrcIBa6P54JrARznQuPMgSzvTS
 nVNSMJc95xV1Ro1oUKfB+nS3sMrXYaDn7W6ce146lQgDYPJ5Ukywo5unwe4OJ9SZ7t2Q
 5wMI2jpXZqnkh8LdaZmv9XxnoTIBMbArqgfq0XC8pyGOjLFUBvLVvyQj28rLovkRrNBQ
 MwjzQGQtqWi5Rc/LADW6H2iGcgy1YnWc2V+uQb02gE8mdmfjS6fJ22TlbITysmSFYQuB
 JcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130371; x=1708735171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijJGORoBUm3OaIKDGyVcLAHo3HCT5x1FLS32130PX9o=;
 b=ZjhdQwUSPnWHT6TLk6OMtyuGfyp669g/gkW2idVWL5b1UE8yksru+fXvioVd+aQq3X
 xC4v5i3xN3gPDlvhsWh07Gw4YxyG0tGYfvG69I6PMGQzfm8UBtXceLcqQAJE8PmmdLNm
 keMg5kd8qd7ubyQTGQUUcfNsXtFCcl6gaeiu8ASDQuoPZyZrFRD0eZkXUlkz/OZB0s1Z
 0LRsoSfqeS0kQDB4/WDbErMM9eisrtAPmtqTuzzGY1I5J2sDfhtc0I+M51438L5rDS2M
 i3DHGnVXAQqu0558Xsc8s23gX1RcunRlgt9IInSdkGxLxEmWsODejX3ldBa8DPMhYQ8O
 Q6jw==
X-Gm-Message-State: AOJu0YwqW7uqfbLHFuiCwEezYICGy1P4b93BD+AAPDIyRA+HXbgr5nm/
 3WYn0CN8Ja3tS3eFzOxWyvJfcAfadlkB7jpgrl3dCUdGWtUYTRj6aipm6BP2MYiPTK0FNWeQQhc
 z
X-Google-Smtp-Source: AGHT+IHA2J/GbNajTIDFzWu1ua6eHvMgBQoiSzoKOrfmqPE5pwB4rnUzdjfSfILrEiUjr7BJ1XfDvw==
X-Received: by 2002:a17:902:650c:b0:1db:875b:efb2 with SMTP id
 b12-20020a170902650c00b001db875befb2mr5946519plk.10.1708130370896; 
 Fri, 16 Feb 2024 16:39:30 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
Date: Fri, 16 Feb 2024 14:39:15 -1000
Message-Id: <20240217003918.52229-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 util/bufferiszero.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index a904b747c7..61ea59d2e0 100644
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
@@ -179,13 +180,15 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
+
+
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
 {
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        bool (*fn)(const void *, size_t);
+        biz_accel_fn fn;
     } all[] = {
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    buffer_zero_avx2 },
@@ -232,7 +235,7 @@ bool test_buffer_is_zero_next_accel(void)
 #define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
-static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
-- 
2.34.1


