Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E050C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7u-0003xh-LE; Thu, 20 Mar 2025 11:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7i-0003dO-2E
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:48:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7f-0007r9-GI
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so10049185e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485672; x=1743090472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLsfjeKvzcqQzs8WcSuZ2zumUJNlo4E8yDOEHN/OK9Q=;
 b=E/uXN6ir9G4RAg1InPq+s+WQ1hBhaDE7tKGOZHFRfAhokOWOBZtVFVJQ+GyJOWdoRl
 6pAIOjEH+eW4FBsGveM4WVbyuF4/fzlTh0cGCnCyTuD92RLVsK1Z6c7MRKHppIRjuBrN
 pUBWFdXI6KdxJxqnlBFUxxRAG8ez70oU8AYJkNxSlU9jLfkDo8+aS6NclnSn1509TWL6
 LbhiSFW/vBLxw3IJi1hPeRVZAdBH45gj2V4QAG9YdiFhQ6Vg8USxgaR51vF+3YCJ6t/y
 ++Ecy7gsdpGly8l75w4y3piHOwJL65nmAg5D+ICaECIaJAwLsFfxoKl9QvLKB0c1Qt0R
 N7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485672; x=1743090472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLsfjeKvzcqQzs8WcSuZ2zumUJNlo4E8yDOEHN/OK9Q=;
 b=sdhRCMr7Lym7urq5NPTaZ75HBPQL1K8EhRV3mDkf9sVnABP7ErG37URSp1wnFp0l5w
 JrRp3x67sJQmqIFR/ehgHe6o7UL2N7uJTypgG5XW0GGBQCl4xJ4tW1Ghd99ESgfh7EXd
 w0unLDtFU5cpKNrep9DwTcwccI60+jiWZpoeUvDHoAUeGWRa624fbBbvQh28ZKUJBp4H
 P74yX2AWoCXOJ1SsuvsScKD/Feh9QADzBZu6X6fgIvNj412WoIR7zTKn7HOUr2nq+4TY
 UvFNG4NrcRueiTXgBkDuOWtZEB5GsgD8xFlunc1ldu91C7Q00YP3sN7xOuGLoYbPrfQe
 xb4A==
X-Gm-Message-State: AOJu0YzIhrxBUt5CeQYLO+hN/4L/EnceRvV9ZwlxXf5ParhcGgBJHSkl
 luja2TwUQQww7tlPboCwxoscYyozNGoiuF9HVd/bRLKvhGT2F5stmHWjMEdIUnTXSrdhX9cnRU5
 W
X-Gm-Gg: ASbGnctOfdYSS0rQFQ9EnVlm7mPfeDGc553kqhWlmSyPdBkHDaJuR+G7GefSIOr/EUK
 VrgXdacBIMm1cz1ozTPloCRV00W6CNZ/tzgI2XyoS+sZU43++EDv9wMnA11RL0SyOh1wdoqfygy
 4IjONz66XabFgpvFJJYsjVxlUEDEH4WFBpuivxuspwI8WcAdlDDulFP1UFgY/0Vx14pCV8O1Klp
 McFjykq1AE+g+ZGGN0fj3phUE72olm5oU+9l/3rD4stgV9b5OCyPZkkohXcb/u6WhPraL5VNkzX
 re8KK0Sqqeb4z/tJ0ot61RV550VcGZjmc1NZVOKXtlvPBxZhpYIZo2drlrsgtxnOi/R9Ntj+UmF
 /SpjOZ+DX+1bLADv3NvnuKFpV
X-Google-Smtp-Source: AGHT+IF8aYzjRgYgKSQFJmDxLMtD5eAA82xj5a2NHDZPCIVM6LRHldbiXoVMxxOIoc5KdxoslJKfIg==
X-Received: by 2002:a05:600c:1d9f:b0:43c:f81d:f with SMTP id
 5b1f17b1804b1-43d49542f51mr34329445e9.8.1742485672035; 
 Thu, 20 Mar 2025 08:47:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3ae04a94sm40779965e9.0.2025.03.20.08.47.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 6/6] qom: Test object_class_get_list()
Date: Thu, 20 Mar 2025 16:47:22 +0100
Message-ID: <20250320154722.27349-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

RFC FIXME: this doesn't work well :/

In the first iteration the TYPE_TEST_IF is ambiguous (matched 2 times)
so OBJECT_CLASS_CHECK() triggers the cast exception.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/check-qom-interface.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index c43a63e8b3c..8a997220e06 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -115,10 +115,26 @@ static void interface_ambiguous_test(void)
 {
     Object *obj = object_new(TYPE_INDIRECT_IMPL);
     ObjectClass *klass = object_get_class(obj);
+    GSList *list, *el;
 
     g_assert(object_class_implements_type(klass, TYPE_TEST_IF2A));
     g_assert(object_class_implements_type(klass, TYPE_TEST_IF2B));
     g_assert(object_class_implements_type(klass, TYPE_TEST_IF));
+    list = object_class_get_list(TYPE_TEST_IF, true);
+    for (el = list; el; el = el->next) {
+        TestIfClass *ioc = el->data;
+        printf("%x %x\n", ioc->test, PATTERN);
+        //g_assert(ioc->test == PATTERN);
+    }
+    g_free(list);
+    list = object_class_get_list(TYPE_TEST_IF2A, true);
+    for (el = list; el; el = el->next) {
+        TestIfClass *dc = OBJECT_CLASS_CHECK(TestIfClass, el->data,
+                                             TYPE_TEST_IF2A);
+        printf("%x %x\n", dc->test, PATTERN);
+        //g_assert(ioc->test == PATTERN);
+    }
+    g_free(list);
     object_unref(obj);
 }
 
-- 
2.47.1


