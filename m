Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C2C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIb-0002Yz-AX; Tue, 22 Apr 2025 15:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002UQ-I0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:41 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIG-0006BJ-Pu
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:36 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b074d908e56so3896404a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350110; x=1745954910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WELs9tSDoOhv8oNl+uvddaNLwloxys1OzwUaiFl4qY=;
 b=ynD/FpzfZ6Mo/cWOUCzXPBsrXXHdyAHQSm8wnswPVSIRz97PjpccNVYzdS9wTEBuIm
 oCMQsD61OdosUbHKBDwWtmJtpqUPl0sEgIltlK6Uo9sahSvHnxaTa/fy9ILrwtulYS4w
 Cw+At6M5cijiiPqf4+pbFqh346RVa6oskjHmTwIndJETzVM+mEognF+sOyZetsNI/2cc
 G5jqkMAIyZeqlW588sfV6Zznzx828FLcCH+nSNYBSIwxplxbLmD4XHNR3+HqjXzsBaIP
 j2bqWngTD8g9ErLUvCiKd84rl7ihSqFpAt4sL15dxRaejVDgXJiYOMjsFLcFGzwr0M7C
 bvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350110; x=1745954910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WELs9tSDoOhv8oNl+uvddaNLwloxys1OzwUaiFl4qY=;
 b=gy1Bs885jLTEvkih8qI6nWGJ9m8mQ88dyr4czt9Cc/Z2M7yhXgv2vlsZH4oLGCKn3J
 kcRWhSoip7QjgX5J/oq3cBEDkFqSYVW4IvaLjYosMq5Srjt7xGq011280/H2KFRLZv1U
 nuRuCOUISyPUH4DuaIemchPzEczLElqO18BR5Ws9HU5wiS+Va2oUpJI+D6xDI2eFbE1r
 06WdqgBMFh/7uXMKD4aFHjgA9LXaqa76Doy5h9mjiuXNZTfPVTBowWxd3iXyUDrDl+3L
 4hlhDWQd6d9dgx2Oo0zProLWNqnzInNj8FDnbe80eI7vQmTNtlcYs9+P03P0LbZGmA7H
 bCww==
X-Gm-Message-State: AOJu0YySGB3X9XYLcrI+c7UqRiIiUTXtCZDeHYcKEOoLqopCkVOrQ5Nx
 QTPYioCDhEcE6mJA8dfmSBOIKcOArVxAmiAEcSg7fAWIwGm7EywXJJfYKSyIELF5qckxvR9b0NX
 a
X-Gm-Gg: ASbGncvoBNlvcD9sr3+OjWKy3hDz+b1kduNHfK5rHgicGNYT64ON4a7jOizkcT0+NM4
 kh//mgY/V9R0+JbSvkurHn79doBReefgTwm3Wb/TiiH3pqYvOiL+Ii4uLF1O65y9R+M7ySq1JGn
 q6Hm3Yw4yca6hnsUjaQnD4xoFpyDW6uhbK2kUYTy9HO/qhIyTuAqbnS+Kc4Sp+EMMuKC5ktlIAj
 hUjxuGmBTrszDEEncFLhhe2YTfzRP0VdxM+UR8oONtc5ohH8I04q6aNnT/h4sASdXmbdRuA4m1v
 UL///eX68a0bBwb/efXUR+vsqf4tcJXqIf+dxoE50Jdtey3louOm0ioouG4FrqDPLSHtrBiCisk
 =
X-Google-Smtp-Source: AGHT+IGz12X3Cx6YBd5ym559UuMvQCU7503+mVVmMYUvYn+4V2ZXxa1KX30nvK9+i1i6DQsuIiraRg==
X-Received: by 2002:a17:90a:d44d:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-3087bb50c7cmr25549530a91.8.1745350109844; 
 Tue, 22 Apr 2025 12:28:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 014/147] system/physmem: compilation unit is now common to all
 targets
Date: Tue, 22 Apr 2025 12:26:03 -0700
Message-ID: <20250422192819.302784-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-15-pierrick.bouvier@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index eec07a9451..bd82ef132e 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'globals-target.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -16,6 +15,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.43.0


