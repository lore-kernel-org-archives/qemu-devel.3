Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B26CFC616A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4r-00070F-Mi; Fri, 13 Sep 2024 13:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4l-0006Zo-W2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4b-0005wt-SX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c4226a5af8so1034710a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248428; x=1726853228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKDdDxN3APIqbfrXr39czdsb/f5XxemGM9ivAMoMPDg=;
 b=fPBx9TEIQb3ACTGpLP9oYdwHqCVs4seMfMKYpSOhyjeo2+HN1x8FFdxZvc/L1z1tZD
 ogwnA5rdxIVmcY7nqbhR2H6oSCJvAu5eVQfj9JJlo5ilKhzuNTm+RzixJHT673G02XGU
 +bE7D9Gv9PM/WZqfm1NYJTSfqpfyt1EMdBfJsbejiGfRc5z7YRzDyxIVtu8wdwK3UArE
 OM2I6JflhWcVqZtMzheE32bgdhLoDRlkvaivv1gmRAPDgOBxkRD+8ZdOoly0M4MELPn3
 H6oFBjm33Q5u7pel/Ld+/vYc2mTGWtNpgYkorGncdWFAbCNB4wUvf6wOVOesRWqEU8sk
 LS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248428; x=1726853228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKDdDxN3APIqbfrXr39czdsb/f5XxemGM9ivAMoMPDg=;
 b=W3aQGyjgdZTPLmQ9wDk+MtOI47ktZWx/Epwf70XrKuWBhPY3yd9G6VYf3s1zUqAZ0m
 oue5DOfbqw4N0Pc0kY6v9PUEcOfmgbIRkpra33kXvGxBqPnRwMAe2+5vnYflZ30//owk
 pIfLYNWA+4xTNci+R5sS8VCqKzF+/hBuFPTRYIxTrf6KzfVs+i+qcM65WwU9qlDspkDA
 IH/ngVNkrbnt0EBPqcIlw8lwLhdcLEu/KiR55cTcXDWpFf6G+hXKWlCow3LbLe+Pqf2U
 5i+SSQUCzDwQdcQsCXQQRIv7FhEQ30oRKlUYInXJGSCeZSEPpI6UIOHlmFEPQS+Z6Bew
 3CmQ==
X-Gm-Message-State: AOJu0YwxNlDPj1ODpfFV1H7u/FGqcKfEoz1T1qUD0E/fAz24gPFi9qCw
 EcEEmDvgzVeZGk86ATDu/n7zdhNPBQKJRiklwrPYus2X3lDFu0aBq/6+EKXj0TQ=
X-Google-Smtp-Source: AGHT+IGwpJHqZC1lRVdU5S/p2xiz4xV8JcG21H/8OQ/9C30LOaZHjArpJC1qKnevHiXD31wDLT5ueQ==
X-Received: by 2002:aa7:d9c4:0:b0:5c0:903e:963a with SMTP id
 4fb4d7f45d1cf-5c413e5367cmr4076130a12.29.1726248427640; 
 Fri, 13 Sep 2024 10:27:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cc28sm7886984a12.83.2024.09.13.10.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3295C5FA2F;
 Fri, 13 Sep 2024 18:26:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 11/17] tests/tcg: only read/write 64 bit words on 64 bit
 systems
Date: Fri, 13 Sep 2024 18:26:49 +0100
Message-Id: <20240913172655.173873-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

While the compilers will generally happily synthesise a 64 bit value
for you on 32 bit systems it doesn't exercise anything on QEMU. It
also makes it hard to accurately compare the accesses to test_data
when instrumenting.

Message-Id: <20240910140733.4007719-21-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/system/memory.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 8f2371975d..680dd4800b 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -163,6 +163,7 @@ static void init_test_data_u32(int offset)
     ml_printf("done %d @ %p\n", i, ptr);
 }
 
+#if __SIZEOF_POINTER__ == 8
 static void init_test_data_u64(int offset)
 {
     uint8_t count = 0;
@@ -187,6 +188,7 @@ static void init_test_data_u64(int offset)
     }
     ml_printf("done %d @ %p\n", i, ptr);
 }
+#endif
 
 static bool read_test_data_u16(int offset)
 {
@@ -254,6 +256,7 @@ static bool read_test_data_u32(int offset)
     return true;
 }
 
+#if __SIZEOF_POINTER__ == 8
 static bool read_test_data_u64(int offset)
 {
     uint64_t word, *ptr = (uint64_t *)&test_data[offset];
@@ -307,11 +310,16 @@ static bool read_test_data_u64(int offset)
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
+#endif
 
 /* Read the test data and verify at various offsets */
-read_ufn read_ufns[] = { read_test_data_u16,
-                         read_test_data_u32,
-                         read_test_data_u64 };
+read_ufn read_ufns[] = {
+    read_test_data_u16,
+    read_test_data_u32,
+#if __SIZEOF_POINTER__ == 8
+    read_test_data_u64
+#endif
+};
 
 bool do_unsigned_reads(int start_off)
 {
@@ -476,10 +484,14 @@ bool do_signed_reads(bool neg_first)
     return ok;
 }
 
-init_ufn init_ufns[] = { init_test_data_u8,
-                         init_test_data_u16,
-                         init_test_data_u32,
-                         init_test_data_u64 };
+init_ufn init_ufns[] = {
+    init_test_data_u8,
+    init_test_data_u16,
+    init_test_data_u32,
+#if __SIZEOF_POINTER__ == 8
+    init_test_data_u64
+#endif
+};
 
 int main(void)
 {
-- 
2.39.2


