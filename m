Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05CBC3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VZ-0001rp-Sz; Mon, 16 Sep 2024 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7VK-00010w-2K
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Us-0005EH-FV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so23832355e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476852; x=1727081652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Wv8Q736t11KQJ7N/ppo9YJRYi/AHu9klf968DMJMmk=;
 b=Xh4MlOJAHndo67/P7Ljlh3F/xRGgdZDfA1iEG8k/DSPKtXAp90h44T9BvILdtVquYc
 iUJdm6dUF7Yamoq8U1BrQBdSC08d2zzA24wO+TgdOG+HHmnXH3/pqDVN5xznkNTOQXFP
 tUOirf/qSYMXyuD+RrC92aaK1v7kPAp1hGeSrggeyIx4jOgOm2e/JABB67O4nbimDDUz
 FR80uuMHDgr0tR5ZzWXN9UktSZ9cZ9x0ATTbyEvqZ7afX7P4E3QjS6oMVr6YDYk09/+T
 CWVgC4M7KuKDuO7L3ISxlgb+SYmaXQYyqvcrfyUsxAJ361hxRasvUi2tp9R3cq1HkfpS
 R2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476852; x=1727081652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Wv8Q736t11KQJ7N/ppo9YJRYi/AHu9klf968DMJMmk=;
 b=mP52lh+zcGEHLBjR0I5bC/UQtK9mbk+1SNhQZ5klfAmHArkJ3VkK0SD0N5GRFQHJjq
 ra8IdhuME2I3LqOAnrLqf8fUWIFSejm6K4CbldTxAK7y/0+KMCkycF/D/MTBe0rsBKHL
 XV6f/NHkunZ7LCxqoCaQCbWcB6cgYsD8LNCrUk9brcr52T53MZ9omeUAVVdXGqFFnEDq
 lWCl55HClCffGIO3hm4FKZjNFiX1Q+EuXiSyisRmIfRBazs9P8pMB27v+NVQaHr/868I
 O2MMEonQcCsU1TGXvDvMA9I77pogCHJbQfrTK8YUkD0mZhDL/ijuwVZjyuGiaT18Mh10
 bfWQ==
X-Gm-Message-State: AOJu0YwysIiyxvuma1p1BpUu4EXES9TlZS7Z8y2FKFEOiLQdowKppRVc
 Yt5gaXGK/Il9M7eUBPNAaCFFAZgDt142wHlNWnDuywUnep6uGQSPuIkktI+hNJ4=
X-Google-Smtp-Source: AGHT+IE+qFa204x/jj7SX8XvzaiHkbHJcApUm1Knfx84uEd7A5cOQGFAA8YWzf8/HCkBSbKTzG8DNA==
X-Received: by 2002:a05:6000:1546:b0:374:b5af:710c with SMTP id
 ffacd0b85a97d-378d61f0d6cmr6976677f8f.26.1726476852125; 
 Mon, 16 Sep 2024 01:54:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22d8212sm70383055e9.14.2024.09.16.01.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 599BA5FC6C;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/18] tests/tcg: only read/write 64 bit words on 64 bit
 systems
Date: Mon, 16 Sep 2024 09:53:53 +0100
Message-Id: <20240916085400.1046925-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
v2
  - >= test of __SIZEOF_POINTER__
---
 tests/tcg/multiarch/system/memory.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 8f2371975d..28080767b2 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -163,6 +163,7 @@ static void init_test_data_u32(int offset)
     ml_printf("done %d @ %p\n", i, ptr);
 }
 
+#if __SIZEOF_POINTER__ >= 8
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
 
+#if __SIZEOF_POINTER__ >= 8
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
+#if __SIZEOF_POINTER__ >= 8
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
+#if __SIZEOF_POINTER__ >= 8
+    init_test_data_u64
+#endif
+};
 
 int main(void)
 {
-- 
2.39.5


