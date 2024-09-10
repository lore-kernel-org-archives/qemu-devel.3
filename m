Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63738ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1d4-0003Cd-Pl; Tue, 10 Sep 2024 10:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1d2-0002xU-Ul
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:14:00 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1d1-0007Vq-4r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:14:00 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso27825066b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977636; x=1726582436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkzJlS4txjflyKkh4CCHIuVaip6qn2yADs/S0X5KKR8=;
 b=RNKA/M8m4PM+OZSubSJ6YOY/OyokkKEotNLgR1Xs3kpZZyL/vpSvQ5oJkNp0/GaazA
 mLxjAj/cZr9t0q10f16VreTvNMc38j5lWUq78MfLjT0znKyde6zDqLFDHojtZeL40YU4
 E5UJy+tfruWKVfxNV8EoAB/ivT7mi4SLk3N3YIVHYDAMXihD4Zx3Q3zkg52slLuHOGkA
 nUxlwRRLUVqOYAlyjvT9HeDtJGsliOO32wrTTHLSzDbzApYDptT1h2BbhNXKF+z5axQ1
 QGmDZGSAapdyEaHTHunAe5cpj4hcsjPo8GUHDwDGTd0rUWflg1/WSB6388sH5hhbhzYF
 HbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977636; x=1726582436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkzJlS4txjflyKkh4CCHIuVaip6qn2yADs/S0X5KKR8=;
 b=fcMq2MdVy9+Vd6O8ySERtBUKwg4xXfKVTlJV+aD+YqXwdYSulwCOGhD9E6r7lUcqJy
 H/YSzxGE5gNe9ZWpeWCg5HbJ9B38A7PkrMQIRXjM+TQ479NCO8HMXmNkKbIdRVkMxrMG
 412jHFhVJcdFaqRm9PzLpiHSHDnlHlDNHMWpQXbSUxLYEWLwf0tTDyLhqMVR1FLP7AWH
 Wlw3an6FDo2xLkEZN73eJ4KZ+bguWeJLtENlOJ5uLSZmyeorj137TPXzvC6REHwwJN5b
 nhvYklFjyhtmCIm5tN6KMz2+40p3M8FuUXHH1vSB4R9jr7gBIQSlOseL8Km5emjEQMWT
 9iJQ==
X-Gm-Message-State: AOJu0Yz6hG5igd1c2Ad/SJt026ADH/76jXBMfbtMseQK/I2F9VdhXxWR
 OxuhTXe0eSOyTV2kDgsCmChSuvAZJGBYgE6nCtF4hNmFcVBInYijp0UptKq/RNA=
X-Google-Smtp-Source: AGHT+IF0n41cF7B1EFfMC4EoXC2MXohjR9xo5rsGQgQXXAcqKVCZIXQA9xUQ/GKhQak3g2247joROQ==
X-Received: by 2002:a17:907:e291:b0:a8d:505a:5458 with SMTP id
 a640c23a62f3a-a8ffb20f42amr123827766b.10.1725977636389; 
 Tue, 10 Sep 2024 07:13:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259c1fa3sm487925166b.80.2024.09.10.07.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:13:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A628E63460;
 Tue, 10 Sep 2024 15:07:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 20/26] tests/tcg: only read/write 64 bit words on 64 bit
 systems
Date: Tue, 10 Sep 2024 15:07:27 +0100
Message-Id: <20240910140733.4007719-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
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

While the compilers will generally happily synthesise a 64 bit value
for you on 32 bit systems it doesn't exercise anything on QEMU. It
also makes it hard to accurately compare the accesses to test_data
when instrumenting.

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


