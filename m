Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C01C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 12:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thScw-0006M2-5h; Mon, 10 Feb 2025 07:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thScp-0006KL-6o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:10:58 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thScn-00032G-F8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:10:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dcb33cba1so1450526f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 04:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739189447; x=1739794247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tz6g0+yjWCc5q957kaMmUJ2SDM1V5eBl57QBVioAIgI=;
 b=rsrbqxL5olTPLrZ8xU5wUYXubCNXcRzDEl8QBKvln43G86gDOXqI8M0M9YtHdZYfBX
 lLfH/S/un1xF9zLiMKILZykGIl+CpjQCDsmpCGdWui8P0UCVJ8zQRbr4Ef294xBHY+WK
 XtZms29+V3FlNIlfbDCmdbhifNj8AREQ8f8SkGtCqQLIOM2R3+trjDoOiOy9z+6kKLE5
 tQs38A6NcQkUJDtbgSJI/ra/Mayms5Z/hRyOPXEnUEsHOPmrytGVh0jGWV5agaCvOzry
 PQ2uC6z7ozJqUh4AsmcSWZpWfhhMt/A/K9gX2st1smf2h4E4Y2ix/67U1wJqoouV/iSk
 fvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739189447; x=1739794247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tz6g0+yjWCc5q957kaMmUJ2SDM1V5eBl57QBVioAIgI=;
 b=kGiOce9v8dB2/iucZcbWn0rGH5L2WkCG5ne4Svrx3nWJEeNuCOBH6NAQYC11seYdQ0
 yA2kNOYItIALT9LQQDMpGkUxxaDqKYOwQYNlC9DSNSWWIE02gkGWJREm5ALagQY5wibf
 fNxVR5hihuAWLuwxSTub00IBnSBvsJG3kjgEZj5d1pcwJ77hp4XU8Jrn33/MI0u7pqS0
 lsgaAyPoPb4UPZTllLYPeydOheOsM5MciocVzCxWPq9uu2xBdijxYeC0zpK7Voli9fFy
 Ip+oFFLP1xvM8Cgvr6iANp+j4KtObRWE/uStzGULETtYzYX/7/mL11PGVRLDcyeQnhzz
 ZfCw==
X-Gm-Message-State: AOJu0YxCBgNy7NaHFxiD48l55/e/Pb+QX2L2l9kv3KxDFGAd2EjQWKPm
 LS4AvowNaSn0pTcDy3vSZLaZsqmBMUjCw5McPFDU3Qf/HyfVpU1ZiGZ4UIvqijUUtKtpdTNYZPT
 wOyc=
X-Gm-Gg: ASbGncun3hHNcAcwWdGdsYJ646f7uRFY5TP8+mfQvVpTCIDGy7uc3d0QnPNkY8+syz2
 TDf07Cu1P7gI2XuWzNg7mz/35gzZZ1FfrJw1ucwYmgSbS9YfOSSw5/1NojzDEOpKFVNKKx4883K
 TkefRP191tolSLr7scJ30fz6H4eOUFt30UklFADo0cnfhPc8U2tu36tD2w3w5W93VaFOxqVydJJ
 s0XGJU9fUGUI20eYQbj5N3iLjCv8kUYDk+ReplQ1dVNHqJRdaebsMPjIk9ipu72yd8olX3XY5OG
 uBMYqKtI45kPmFB2t/TfE6AXPkXWP+M1oi47nZDOIpMxi41WapyJBkGxk7L9AOkTQek6ai8=
X-Google-Smtp-Source: AGHT+IFyIq98wfL8aNbGeiF2nCLbaI1dam8txKqn9eh80P51r6lKT2qqMWcbpETpB7iIMMF6jPngpw==
X-Received: by 2002:a05:6000:1865:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38dc9346494mr9790567f8f.32.1739189447488; 
 Mon, 10 Feb 2025 04:10:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93369fsm180642855e9.3.2025.02.10.04.10.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 04:10:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] system/qdev: Remove pointless NULL check in
 qdev_device_add_from_qdict
Date: Mon, 10 Feb 2025 13:10:45 +0100
Message-ID: <20250210121045.38908-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Coverity reported a unnecessary NULL check:

  qemu/system/qdev-monitor.c: 720 in qdev_device_add_from_qdict()
  683     /* create device */
  684     dev = qdev_new(driver);
  ...
  719     err_del_dev:
  >>>     CID 1590192:  Null pointer dereferences  (REVERSE_INULL)
  >>>     Null-checking "dev" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
  720         if (dev) {
  721             object_unparent(OBJECT(dev));
  722             object_unref(OBJECT(dev));
  723         }
  724         return NULL;
  725     }

Indeed, unlike qdev_try_new() which can return NULL,
qdev_new() always returns a heap pointer (or aborts).

Remove the unnecessary assignment and check.

Fixes: f3a85056569 ("qdev/qbus: add hidden device support")
Resolves: Coverity CID 1590192 (Null pointer dereferences)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qdev-monitor.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 861c25c855f..01d4b007322 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -628,7 +628,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     DeviceClass *dc;
     const char *driver, *path;
     char *id;
-    DeviceState *dev = NULL;
+    DeviceState *dev;
     BusState *bus = NULL;
     QDict *properties;
 
@@ -717,10 +717,9 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     return dev;
 
 err_del_dev:
-    if (dev) {
-        object_unparent(OBJECT(dev));
-        object_unref(OBJECT(dev));
-    }
+    object_unparent(OBJECT(dev));
+    object_unref(OBJECT(dev));
+
     return NULL;
 }
 
-- 
2.47.1


