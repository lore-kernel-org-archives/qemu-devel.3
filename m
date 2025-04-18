Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12428C369CA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pXw-0003JJ-24; Fri, 18 Apr 2025 13:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXb-0002o4-Il
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXZ-00009f-MI
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso13862595e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997411; x=1745602211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6XCT/fOeWKDikZcuPLXArzjT7R3nNzglYyQ5bI5y+w=;
 b=kcBt2vy8cgIYWrHKIuvror8Ufzn62QFAI+sr64PvA3PpfFXOOsZw5VZoWK1m3FvHn3
 dHn6bHbP3HlsllKZi8nsXyhTcdk3dmXSKHcmqFLaYGIlcjyljHbs1jkg7U9ldKsLtE/z
 mKI2oQMvokqLAIR/pIw5ekUwScsoN4tkUgYdZxGk1tIuZKoHMEMHrsSZCx+MfLm0CUzS
 mXpRg8CYJZ+6PRpZJNS+lWouyv7FqAgLlRWpvdSSD6xt2aqtnrUDMU8ZT9JcznSW648c
 6i7WuGosC+jbQsEdEtew6Z2/zoJOhEuVC7lUd1FEovYSBJvVxL6ynfjr2vHrG2NzRxEN
 nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997411; x=1745602211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6XCT/fOeWKDikZcuPLXArzjT7R3nNzglYyQ5bI5y+w=;
 b=QYReH71On7hB42teUzb/JESGXy9Ij2/KESwKuz4m3kEKmK+8l/XQ+ok71Mftgn1E8e
 6QCmLZ8JF8pw0lkm/Bo4aQwL8Slqh5ufKiY+5MgzAP8bRF6r0RpysPpXIt5WzCravYi/
 dKrgFMVj3vHL70fJebtpe+La/il7qyxeog5u31cCTlFW3RnlHLxc5fnqYXV//UIJLtRN
 Xl6FcsaEAOiHmNR5rQJ3IYClcvYa5Zfdr6Gf2O04Xya5MKNe8FcOCKS1oaxxEk3rcxx1
 2rzWL1J+eVqlYAaIxiasTg1+SEn7oelHtV4J4KlcMuu5JRAApACx0qitz89pGRuyqtX2
 1/zw==
X-Gm-Message-State: AOJu0YywDTeJPZaFDkKdQK7v33w9h5hecX7P4aUc3bW7JW93kUFd9UZY
 IkQevV646kmQd2Gs0v8tT2zLG5XKGtFdafkWuwysbZz6iNKp1xzHBtfxK6EWfExZL6a0tjaV3wB
 T
X-Gm-Gg: ASbGncvlJeeUX+f25k84TvLB4eZF8QO+m2x93VQhdvZ0MqLmF4D1CJcg/5rg1R0GCaP
 32vyT+/HlljFnCBY52i05gbYszhaIHhgNFFyiBYL/7K8qeYVmi6RQgt5NKYyo2ldIRc3Nwp80dv
 iQ+RuKdMeBW+I7cEV/1ddndr0HMaZ6+OzxwwkEPSCTe847AuXREB2hbCgS6DEF1xuBmQWrqX2yM
 swAvDJBA+HrdAHW9sJ9D29acaTbp+PuZIcCkTIUi9PKOB+gSM695p2HsSmaQzIBRfcg2Ba1q2Vf
 JDvVHfqnAX6knyMyHfOlpcynaqRgMgZGRBZRv9dlsRirgE+y3Vpf64BzdDIkv3OSUnfIdU6+ijn
 8KZKgEIiE4doG4Eo=
X-Google-Smtp-Source: AGHT+IFxSemXVcYeFZleOp0m94iH6wapmJ0tjVKFjZJAxXnAq+bTImDkPEa1AOlV87mFBXz00FdvRg==
X-Received: by 2002:a7b:cbd3:0:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-4406979083fmr31133905e9.10.1744997411558; 
 Fri, 18 Apr 2025 10:30:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d22esm3374615f8f.52.2025.04.18.10.30.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:30:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
Date: Fri, 18 Apr 2025 19:29:07 +0200
Message-ID: <20250418172908.25147-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Add a helper to distinct the binary is targetting
Aarch64 or not.

Start with a dump strcmp() implementation, leaving
room for future optimizations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target_info.h | 7 +++++++
 target_info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index c67b97d66f3..9b7575ce632 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -24,4 +24,11 @@ const char *target_name(void);
  */
 const char *target_machine_typename(void);
 
+/**
+ * target_aarch64:
+ *
+ * Returns whether the target architecture is Aarch64.
+ */
+bool target_aarch64(void);
+
 #endif
diff --git a/target_info.c b/target_info.c
index 1de4334ecc5..87dd1d51778 100644
--- a/target_info.c
+++ b/target_info.c
@@ -19,3 +19,8 @@ const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
 }
+
+bool target_aarch64(void)
+{
+    return !strcmp(target_name(), "aarch64");
+}
-- 
2.47.1


