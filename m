Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4854AE64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR98-0001J3-Re; Tue, 03 Dec 2024 06:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR96-0001I1-VY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR95-0000cT-2j
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e075255fso2556740f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225565; x=1733830365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LP08ovgAlxy3zJSGfhanCL3pqQJtbHP67JCIcBXaArA=;
 b=vEsN5IWOSA7SlEP54JXgEnJJxYXtekQxA01y9zailEZ4FV0Z5PKKU9kJLmoxDhsLRM
 zwQhwQu4oO8Tu2C+O9pMlH/NZYVFa3I9dttqM/Izzd1y4I5LyDmDtytozpboWLNLBNqH
 AIwmUNMyyDc3gy5izXfdO7yz0o3iQGmAgZ8+qs2RFX0qjv67CTKiwuNt4fmyYqlJxgkC
 trvw5b1RIPhUhzWygCtdnBmV47syDl8xB2dHFmIeDhWCjVl3wQEjbug2F3I9S1FnLlBZ
 CI7JuIIz9allUN+hBVaQcwyOqhTcz2Jr0osafXZAg4xOhHq1zvbVQamnDda+Jjict2AF
 F+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225565; x=1733830365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LP08ovgAlxy3zJSGfhanCL3pqQJtbHP67JCIcBXaArA=;
 b=hYl4IeJx3vrLAIFxuWi3wPEnQJJXqYtkJyN6gzEhpaY8Xog3syDgC39+48I8o224E4
 d8Dqq0klj7WFU9mm1b4mgG77386oNvft4I4Qms0ri/F+P4lBvuCGyWXbXl2/zExwaC7T
 uxiDZ/cizcuvk2eu2IPiBOELiQ9TBLCSOpifoRbC0+SIWzyAHSplVzBw/1VQ4Z8nzSmb
 0CXb7tdvIVg5ySWh7SccXLJ5SkGHAE0LCVhcGJ/SdAE5syInnlRPjZJdLXMdCa6giprl
 qQSY9/a/BbAsBgjyjTgy9VpCqmCxeDKHbVO57h7hnFyI1YazzOeZ0UqbJb4RhnLZlhS+
 lQCg==
X-Gm-Message-State: AOJu0YxEwvYTGGACSmWPtbvdX9IRAiNNqkLe2z4Bzra2ujWmvsqk4PaV
 8lcMg/ezIlduXBoBqagaXIxPhZ0ptcZREI+azu8W+DvHAj5ENxiW9qXku9EIVnjUaKZ93vFGeY6
 PFMs=
X-Gm-Gg: ASbGncvN50WEGJnnqBiMgRzZ4dPj5+HykSMQxHZsXA56ccmtB1qEPQ+H+U86V36s8G+
 aJsP37CnLKHLUR1kvC8JGcdvcDBiyM5vIG449dSX3ZCEXC2bspKnyUQnefKGAdjeivK6zG2uBDF
 WGZYE/4nW2n40FyLz6epyost8UedkRTKXOyqO3wPLynfJkJb/fMvFaE+yfcpxhA8RLv+cJHhcvM
 uUTsjNbNZswHJ44MudG2cXpvieu08YcV+Y4pX2kbArlN53EWmbQB5sC8BlxbWDQKHo7XdKy
X-Google-Smtp-Source: AGHT+IFvBel2HK3LiP4sazkdE4lBw/uzfYHrMwsLpHF0i4+dspVlm6VJ+hQkESIvTuTUo4fuFPBL6w==
X-Received: by 2002:a05:6000:789:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-385fd42108amr1763074f8f.41.1733225565138; 
 Tue, 03 Dec 2024 03:32:45 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dbe4ccsm184300625e9.13.2024.12.03.03.32.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/13] tests/qtest: add test for querying balloon guest stats
Date: Tue,  3 Dec 2024 12:31:39 +0100
Message-ID: <20241203113140.63513-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This test would have identified the crash caused by the addition of new
balloon stats fields.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20241129135507.699030-4-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/virtio-balloon-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/virtio-balloon-test.c b/tests/qtest/virtio-balloon-test.c
index 6bea33b5901..ecdd363b06c 100644
--- a/tests/qtest/virtio-balloon-test.c
+++ b/tests/qtest/virtio-balloon-test.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "standard-headers/linux/virtio_balloon.h"
 
 /*
  * https://gitlab.com/qemu-project/qemu/-/issues/2576
@@ -26,11 +27,30 @@ static void oss_fuzz_71649(void)
     qtest_quit(s);
 }
 
+static void query_stats(void)
+{
+    QTestState *s = qtest_init("-device virtio-balloon,id=balloon"
+                               " -nodefaults");
+    QDict *ret = qtest_qmp_assert_success_ref(
+        s,
+        "{ 'execute': 'qom-get', 'arguments': "     \
+        "{ 'path': '/machine/peripheral/balloon', " \
+        "  'property': 'guest-stats' } }");
+    QDict *stats = qdict_get_qdict(ret, "stats");
+
+    /* We expect 1 entry in the dict for each known kernel stat */
+    assert(qdict_size(stats) == VIRTIO_BALLOON_S_NR);
+
+    qobject_unref(ret);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("virtio-balloon/oss_fuzz_71649", oss_fuzz_71649);
+    qtest_add_func("virtio-balloon/query-stats", query_stats);
 
     return g_test_run();
 }
-- 
2.45.2


