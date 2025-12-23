Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15855E6FE31
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY9fb-0003m2-4S; Tue, 23 Dec 2025 16:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY9fZ-0003ll-G7
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:11:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY9fX-00059B-Vq
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:11:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so28034655e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766524306; x=1767129106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FlPkxUIoYN+yWgwO+DkFsT63OvCGGjMA2QzNc1VlN9I=;
 b=OFUhYMQXpXJA83a65M2aSofrf0LPimu3NFvyRflVcUckdYrEH6HWY/gsxDHf3ZgE7T
 vVM9JCj8JOyaI6CaQQyeVLPfNoQepdWpDSx/d2NOC0KC03XLHo8DlP82gaf2sqDKwDO6
 Z/XedoqXRVlsaTKXAM66qwAujR3VdmktHOeIce9MudULvn3r195EBWyZSDqQmMLxHvpR
 AWHivNHGmG0KKzsgapHBeuVvXRE34JDp8EA150ro17YocsofYv9Y63oPjm9lTekstBp/
 6oI+nl2wCN4wf9hQxqkFEgILqIf0PsnRyOBglhn85NA96AXVBQHNDoTIyxJ+ndRieV9V
 HYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766524306; x=1767129106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlPkxUIoYN+yWgwO+DkFsT63OvCGGjMA2QzNc1VlN9I=;
 b=ibCSPc+27JsSDlSBchJ7LYLdZ3sb+sD9pal0dLAX++BnR2zPoSJpxZZl8yhWAd7VVh
 95Ck5Nm7Oz6KC/uHK9RZVTHC4/7w6FcGB840+0+ID8yO9L8OEBc85dCZQJa3OiBrA5As
 UMNUcgQnlI63V5MNHUb373RL1LyveuEGFIFlPUKrpVjRRNajbJ9JLMRH2JYlttzi+InP
 fs5DVNQerje3/Ln93D50T7dYn+2lcJDhZZK1qZtwtWn7kyHn50eE/SYW6DU2wnR2MWW7
 qZMiTbL9pMc/qWcNKZZJrojKJzMAPWt+nDspMHqBQEmbwBttDZ9dAheHgbXcafBWvDay
 oSug==
X-Gm-Message-State: AOJu0YyMunE4mWeAv5m5nPanMXe10LVVbndG7t6MHHR8eQLp/DIrOTF3
 0d8d+HWUBcaq4+K786s4Pf2y2IDxh/kdJs+jnF3mZCBbDPZtzNHjQGG3cGMmbKdqFDiskpKoX5h
 rCDw2bAM=
X-Gm-Gg: AY/fxX4cNMl1aLtuPUjp3/5Sy6i9uQqvf30fFZjXXdsjn8QPJSt7nhm9Bz2c44ggoZ2
 RLYPVKWBdDT2jbjebDawGb5f5zoZTT+NWsYVp6CNC5SIqoeDLSCztKjxSW2K4XlAfwLk9mD9czi
 7WDKExCZCgTTiNZ6U+wMe7pssxSSNezf6N6sgejf+4XgBxA3rZuF/cKQQrqLctNR9MMPCr4PrcG
 4JSotW6ARJS4atZlzxFvJ77uwZupTYAbKv3nAgJix1DBrAO533XPqZEtqN04uHEmHqtLSTSQoS+
 2gBw7Djdn/3p8oG6RjYwxCrgJIOW0D/17m7QSBL0+DR6xL4VBJo8nTt8UK7ftuYzNllIdGbHWM4
 7DTV+jZtP2Hxu54GVu1T3rtogCHJzVftQC/Xi3e2NzGaDBQQB4jTiRwuwLSlnZTLa7JcqnyvO4m
 1DFcj5rX8mtf9F5RKlOWQ+sWistILKQARGe4I0b2xpKvKXABvvyxC8LwV2/buRmace45zTDHM=
X-Google-Smtp-Source: AGHT+IEQkIunVzhSpD4X/ZKWshna5ssurFbHNjQZSlnR79/LRrbY5ukURXd9ZLVTJluwpO/GN5nnPA==
X-Received: by 2002:a05:600c:8719:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-47d1958575amr148306115e9.25.1766524305710; 
 Tue, 23 Dec 2025 13:11:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2721sm29801492f8f.39.2025.12.23.13.11.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Dec 2025 13:11:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/qtest: Do not use versioned pc-q35-5.0 machine anymore
Date: Tue, 23 Dec 2025 22:11:42 +0100
Message-ID: <20251223211142.80417-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

As of QEMU v10.2.0, the v5.0.0 machines are not usable anymore.

Use the latest x86 q35 machine instead, otherwise we get:

  $ qemu-system-x86_64 -M pc-q35-5.0
  qemu-system-x86_64: unsupported machine type: "pc-q35-5.0"
  Use -machine help to list supported machines

See commit a35f8577a07 ("include/hw: add macros for deprecation
& removal of versioned machines") and f59ee044067 ("include/hw/boards:
cope with dev/rc versions in deprecation checks") for explanation
on automatically removed versioned machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Since all builds are blocked, could we apply as build-fix on master?
---
 tests/qtest/fuzz-e1000e-test.c | 2 +-
 tests/qtest/lpc-ich9-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz-e1000e-test.c b/tests/qtest/fuzz-e1000e-test.c
index 5052883fb6a..61f0553e9be 100644
--- a/tests/qtest/fuzz-e1000e-test.c
+++ b/tests/qtest/fuzz-e1000e-test.c
@@ -17,7 +17,7 @@ static void test_lp1879531_eth_get_rss_ex_dst_addr(void)
 {
     QTestState *s;
 
-    s = qtest_init("-nographic -monitor none -serial none -M pc-q35-5.0");
+    s = qtest_init("-nographic -monitor none -serial none -M pc-q35");
 
     qtest_outl(s, 0xcf8, 0x80001010);
     qtest_outl(s, 0xcfc, 0xe1020000);
diff --git a/tests/qtest/lpc-ich9-test.c b/tests/qtest/lpc-ich9-test.c
index 8ac95b89f72..535099226ca 100644
--- a/tests/qtest/lpc-ich9-test.c
+++ b/tests/qtest/lpc-ich9-test.c
@@ -15,7 +15,7 @@ static void test_lp1878642_pci_bus_get_irq_level_assert(void)
 {
     QTestState *s;
 
-    s = qtest_init("-M pc-q35-5.0 "
+    s = qtest_init("-M pc-q35 "
                    "-nographic -monitor none -serial none");
 
     qtest_outl(s, 0xcf8, 0x8000f840); /* PMBASE */
-- 
2.52.0


