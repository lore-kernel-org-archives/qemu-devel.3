Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE9C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWuP-0006Zy-35; Tue, 01 Apr 2025 04:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWuB-0006Vi-Qe
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:23:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWuA-0008JD-6F
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:23:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso34703405e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495804; x=1744100604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ylIunMeCxHiz8JsEXS7LHxNFF61jnoLiN5fA8StwwDI=;
 b=uro2/847A7iG/nwR38DSfBhaFTw+dPD5e4dYqQ8xNLVNq//6K2XBVHNH809dFZRvaf
 REgx8oiGptakanwvB4gbEHwTMJT3A7q9msGXuYdF6V9SiZ5doJGneurU2uC8zYrbpOck
 bGUr7OhIu/5vFGAUGX7+6rkwP2QjFwDijwo1f1G3qoTsW8X4Zse8irZMqXqhqQ5lmWpF
 kJnv2258WA7TGkfblqjtvD05jWBir48Xx7Ch4i9W8q75laQ6bYaA7e5pv+CeQNLoATud
 Bjdb0TNdghek7ujBKr31mImWh7NitFjs9OBtFb/8aK6qM3xqXHcienGHP9xwjdWAESih
 szgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495804; x=1744100604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylIunMeCxHiz8JsEXS7LHxNFF61jnoLiN5fA8StwwDI=;
 b=UfjNp7kV1i8inmGKRucPa8s5lTpmuWhcifK3zmjztsZG20qeJSA42Qh8GJlS89nAmB
 f9R3L09F7FyePaeFORSpcBYsysbW9AQ/1nnp9jVhIoqF2Zinv+JmMU5vxgGcH6wKSKlg
 xR+i2t9glXHUyBlNIs2qpzChPaXBvOlHZ1KSryw+94QapSjVHkFuBUDv3485mdPLcy2R
 V7MRgK3GOcUoMxaKEPze6kZudfAQSUii9HEuALRoQJiPeFQa/JRvW5Z4xQq43TLSbYxW
 oAgB0ulkXGk15oGIwQZNahAJqp3uz3DwGz/jBD2QfeK7SnSlqnTCWgtYK4o97oDhDcWy
 v1fQ==
X-Gm-Message-State: AOJu0YwFW2fenLZiJKkbxcQttv1fxnHW3Vuc2ZhU0PiLAzcuSVF3Lhys
 RCxKPiL4cdVqYe8IHDv+SpgQ81c9bnHDesOAyRYf6N4sXBH+/EsQ+lqMSgbFzAWpoIEsX1aV4ek
 B
X-Gm-Gg: ASbGncuarD6YFZRUJGRzWacjpO5SDfbrNf9kgrAKlF7Zo3m879zI5c2vJnQbCxK+gOy
 N6r+y2cbFL+AWuOdZkrPHnhHikHYob3fPC3C5bG/6QsYzZ1qcnKg8f/vtFxuMkMGR9cADZUjSYO
 ur0sHjc2zHhRy1gKt2S6O4axStVKoXmZUjA6lulqhv0VRWjIQd5HdkD9U1cq6x6326Y44TwgP5s
 mNfM2nanW028gIdmrQD/eePLAt/sAjhk2Rxl3j7Pu+aqS6JOIgJaqsVhkR8rtgAA4flTg7RFGD4
 GzQFhl+t0xP9gNatBl9DSfgF6T7o2ZD4PaQzWtU72N3oxaov9CGwbxnrvYCktItpz645bWqr1ou
 0cFRUPEOVNJ1nKHMsqpw60PJkBqzNMg==
X-Google-Smtp-Source: AGHT+IHjZfcELBqnNIhBkuMy3O/hE/NZKOOXDDGxkPfwtw9KJRPSKm4x2sJdc7dh5OOTNkFSbJq3Sg==
X-Received: by 2002:a05:600c:1c1c:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-43db62b5d7emr93832195e9.29.1743495803836; 
 Tue, 01 Apr 2025 01:23:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314b6dbsm194799905e9.36.2025.04.01.01.23.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:23:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/arm: Update comment around cpu_untagged_addr()
Date: Tue,  1 Apr 2025 10:23:22 +0200
Message-ID: <20250401082322.33283-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since commit f9ba56a03c2 ("user: Introduce 'user/guest-host.h' header")
cpu_untagged_addr() is only needed in "user/guest-host.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1a0faed3ad..f679e515df3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3239,7 +3239,7 @@ extern const uint64_t pred_esz_masks[5];
  * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
  *
  * There should be a better place to put this, but we need this in
- * include/exec/cpu_ldst.h, and not some place linux-user specific.
+ * include/user/guest-host.h, and not some place linux-user specific.
  */
 static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 {
-- 
2.47.1


