Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BBDCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXen-0004YE-GY; Thu, 14 Aug 2025 09:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXeK-0003zv-QH
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXe0-0005dY-Ue
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2eb6d07bso919848b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176721; x=1755781521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weyLI8Pwby6Pmklm5JI4NiuesSFjCf6M/0WIe/lgfK8=;
 b=Wdw4P+MYA8/9s5MtfbuS8MnTHDewYUxZy6IxjFEPLtVLpPGxWUpiEo9/9SupFjpWsZ
 +YGdE8+L8Jo55xe5XrYInSbJMD/m+WIpRZ6RbgIBgUE4pAANczNjx0tATu2vE/ZIm3Oj
 u9yMMq0Va9woDw4v5OriBkuO/vi53X7xrOoAS6GqbinRn1NTSwqhyrAj6HChKf8ND2hN
 FTjyrtCNiMoiR/lo1b8UXGlNonD3RJI17KgNVXcAuE/Nq/IRNwuSoJnHr2KdYfQB1dlE
 RSgHblDpw/rbpk2tPKSsFAESYsNjFH+OwcJbetHOkwXljfyDWERSpWCSuAQsDjSBM9d9
 7iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176721; x=1755781521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weyLI8Pwby6Pmklm5JI4NiuesSFjCf6M/0WIe/lgfK8=;
 b=XumQnG1xwXWvTfiECeQRkZbLfYOUUAxmKtc0fygtG454EC78YwARwU1+JUgsA1f5bG
 MJs2N7QIIOaL5nN5ZE7sv8JFWWFVeflYXTcmZ+nUNy35w+2tli/ZRGHL7xK/ugSFNrWT
 AUZxydCE779LrDfSZmAf6pIA/hG59LpqMQMDjqP7IxuPJmzSnQ7YCVj1nrzeMajYOEWK
 UOsC5gipLl2BhlNrqOhOKLAXRVNO+Bfiv5m0vNtXbtBMEE2oc+231pHDnzuTxOaRNKpi
 8hs28lISN686XVwJRB2AwW0QWtN3zSaK2HFjbr3Jrl5pdZQSy0jopeFLB79wtOSX+IT8
 aLWw==
X-Gm-Message-State: AOJu0YxZ9ZxC2qtbcJFfE0Yoy8Zh6x+58yv5kMIqEBD64+C+C0495jdK
 YvSly3n1rG0mz8F2NY6EwVRjE57YoTZizIH+CK+mc9aK9eAgnng4OHavxD8wejR5VlpE15O9Tma
 7Vyhq8Us=
X-Gm-Gg: ASbGncsNgnW/D7ZNJDTb+KDJOT0RK0Q2ivdkLpBAHFJxp4eKtLYceNRduflVbtvbTQO
 EaeVdkwC6EQ+UGYXOs+AQ9aQlbqsvvU4BU3Vkx5Hc/xbqt7yb+G+TlUbMQovdV2Y+LbZqhS7sDJ
 8LTWktTDb3vAxj2IGOntq7YeuQkXBl+wvtHs3i9E4HWPqtjd+4gohqt8fhIQ+++mWbOOHSr1bQQ
 BlI4Rq4rEjM+kVC+p42CpV3P/S1NgLcAjzVqQbLogCiZom2CJBuTbyqVgqxig4R/RsPonDhyzUx
 YUE9V9/0GB22oZ8kBLBXWANFpN2toPpEWBR+len/IAFWBb8YYPKQzrfqec4bR/7iMpYK2GNHcUW
 kv3wSw5S3RjEyPJt+7+gFiCFpHTLVW5QF5AdwXBdmNfPOggLQ9YJIghfG2w==
X-Google-Smtp-Source: AGHT+IFQGzlyyD2ip3r/5qhf3oOvDbAe338WXf7KKQBDABXnHFR6gOVYV0jiwmtEaD6ERJ11X58p8w==
X-Received: by 2002:a05:6a21:6d8e:b0:240:358f:3918 with SMTP id
 adf61e73a8af0-240bd371837mr4806608637.40.1755176720867; 
 Thu, 14 Aug 2025 06:05:20 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:05:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 79/85] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Thu, 14 Aug 2025 22:57:46 +1000
Message-ID: <20250814125752.164107-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd..e509ac1032 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index da89dbb095..080aaf3369 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,6 +89,11 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_ILL_ILLOPN;
         break;
 
+    case EC_GCS:
+        si_signo = TARGET_SIGSEGV;
+        si_code = TARGET_SEGV_CPERR;
+        break;
+
     case EC_MOP:
         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
-- 
2.43.0


