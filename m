Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49243C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR45-0001MN-Ay; Thu, 18 Jul 2024 09:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3t-00008Q-P2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3r-0004X4-UE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:45 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso12347241fa.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308842; x=1721913642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o7iLSHvSys+f0c7jEjjDGMSoZe/hp7+J3/pSi3SDPcI=;
 b=Gj5Ucd4rrTa3eO+4Sc5Ef3+Id6+FclLA3J/k5KVdZGu/tdUCMCYN4oUmnmi5gqlLqc
 bmpwueEIOxeJ5y5Rh2YSTCjFG2JQnfR9YfiuaPtgggNkHOEp4pF/HN9U1ulFq9uSCvPQ
 I3Q5927RA7h5o++RyjufVKpHj3xj3lMl8i446xfCtO2QbofOXpDEL/5g/7vDlTP3Cb2j
 fAfsK8wjxA4hmeehEkSXS4ZWVcPpUDb66ceNNcJ7GjXS8hXPSSUxj9RtLyQNIiEJRr7R
 FndcXu3pQD9DauOyY0o58xC0MrSp/0mCbBdi6XVFpMZxCHmZHffiHEk19ZPZZWNw4N9g
 cf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308842; x=1721913642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7iLSHvSys+f0c7jEjjDGMSoZe/hp7+J3/pSi3SDPcI=;
 b=vPz/epKA7W/MixwsdH9V0FbeGP7tv/Fqt6UOSFu5bOpct7FNOzigO0RJy0WTUBSmyz
 4bbmATKwRIrytKhvnTzZshIHYbTQumC/78Ss2EUpUDaNn993ALEa3XZE2C5a8wN0/0yw
 4WhYreEMirja1evInLPYdiq527Yf3QuYXgYPZlfac/zPmRvXMJkwgI7rKiJWt35LRHxV
 eC7c7AR8aiWnpAkp5znY3wHCwm3F84WQ/PQD2bRGoRm+4d8aHcFHU/tWg5L0Pyt/9++N
 kNQsM8t+XZKZDNPaCanZUD1FQ1duT5wVCKoWuTPpzStzuZUi83VjBmd2JVGOB8I6wXqa
 MZOQ==
X-Gm-Message-State: AOJu0Yz+ZAy1N0/77rrN6+dDaiqEM3VqDglIjL8qofxcYUrr+JvwY0vH
 E7L9CKv3NelNIboorV2CHjtDwUR0YWZlzzrApiX3JRDKVBgPL7nMxU3GRTYjT8kHd7IrHJmwlQ2
 R
X-Google-Smtp-Source: AGHT+IGHP8UHTqaSOPj8NzBnlXYUl4UmNeDIPJfKy96AoVYRJouK1aU7uD4DsnVSx3N5sv31RFQ0rA==
X-Received: by 2002:a2e:96d1:0:b0:2e1:2169:a5cc with SMTP id
 38308e7fff4ca-2ef05c79cb4mr18185591fa.15.1721308842245; 
 Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] tests/arm-cpu-features: Do not assume PMU availability
Date: Thu, 18 Jul 2024 14:20:27 +0100
Message-Id: <20240718132028.697927-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Asahi Linux supports KVM but lacks PMU support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240716-pmu-v3-1-8c7c1858a227@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/arm-cpu-features.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 966c65d5c3e..cfd6f773535 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -509,6 +509,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
     assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        bool kvm_supports_pmu;
         bool kvm_supports_steal_time;
         bool kvm_supports_sve;
         char max_name[8], name[8];
@@ -537,11 +538,6 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
 
         assert_has_feature_enabled(qts, "host", "aarch64");
 
-        /* Enabling and disabling pmu should always work. */
-        assert_has_feature_enabled(qts, "host", "pmu");
-        assert_set_feature(qts, "host", "pmu", false);
-        assert_set_feature(qts, "host", "pmu", true);
-
         /*
          * Some features would be enabled by default, but they're disabled
          * because this instance of KVM doesn't support them. Test that the
@@ -551,11 +547,18 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_has_feature(qts, "host", "sve");
 
         resp = do_query_no_props(qts, "host");
+        kvm_supports_pmu = resp_get_feature(resp, "pmu");
         kvm_supports_steal_time = resp_get_feature(resp, "kvm-steal-time");
         kvm_supports_sve = resp_get_feature(resp, "sve");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
 
+        if (kvm_supports_pmu) {
+            /* If we have pmu then we should be able to toggle it. */
+            assert_set_feature(qts, "host", "pmu", false);
+            assert_set_feature(qts, "host", "pmu", true);
+        }
+
         if (kvm_supports_steal_time) {
             /* If we have steal-time then we should be able to toggle it. */
             assert_set_feature(qts, "host", "kvm-steal-time", false);
-- 
2.34.1


