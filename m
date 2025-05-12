Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75A5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYJ-00049h-RS; Mon, 12 May 2025 14:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWt-0002Ul-UA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWr-00005R-Pz
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b2093aef78dso4731748a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073128; x=1747677928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=zrV5BwKGII0bIVE/xZv6es7VEQYH64GY9hzr0u15pT4NhhYO7UKKUPhqSQuHmpxv3Q
 7qBg+mZExSkIudSTM9MwlUVe3RFj/9SsH+r7Uvn1TfFyZNtaFHvkVbgAsnLRVj5Rsbz5
 /LtCG00hgo8GORnSxUfLgzgyvPD3VHOZAFbHtEEOYoSwBA5sGv8sgPNkCCz6XIH6yS2i
 WbTebCu2Um72Zw7M0j8XpJ8jIfWQyvzioRDxXRLzORNCVpeMXlb5P4FN8cjyu7m+QQWw
 Rtgpr11gtN5HUXtxoW0rV9Euhv7h+Kkk4c/C7DcYCVRuTtlcULm29EUxovcBXltr1X5B
 Oq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073128; x=1747677928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=kL2HmFiJaA7lBmapoaw5LK+xdk4ZuOkwPysUqTsbnPzyvTFzshOVvRW5YpWZ9AiK7f
 vyvQythjYrioUUDL05JPVFuv9MiPHtMXzn7p6xjd+kdjfYwPEwO2fMcxniOp8fQyXIQ1
 7eTXd6I4Fl2vSQ9I5ubUCXSP5SCLErxo0oz8SbzekhTcQ7+SQ9PdUZZfqFvCyX/JiWTD
 qqvKgkMbKyheaoHPQha3FMeLxGyQgducchqaavF/w6avCK9bsAyzj9mRYgbUku5cteu3
 Ge0QYtzG0JDRKbklsNT5yGjkU9tCoTLK/YpAF8WRQQMYwai5+DnaFS9yFQAWe0G6ZM7h
 93QA==
X-Gm-Message-State: AOJu0YxkKFPWvKQb/PdumF4M4jVqvbkrn/neYhhPvsMegnPifFfAQYpM
 9Q7O6AvNPzJYwam62sYoru0/7G32ZmMRSyzupf/AkhvXSqwItBwRqb7ZNUJmo7D4U5B58YlMJmd
 O
X-Gm-Gg: ASbGnctBH/iL001Sqo8RZlOmYVLdkJW6GAAzqGDCQWgeGcZfYBbkjJ1BQbcTT+DWuMR
 P0cA379Rq3TqmCjo04iEpxk7oUJwB2TEXqKrGnP5Op6hNz/3ki18t2mX2p3esxzQHlMmyEVZeQY
 GzrurjkgahyPzh5WigzNVcJFMCrY2l4r4vBXM4EL/ZnPtw11HxSZUX3fo2wM+ZVwYev/0keAHw3
 WVCyTNwrukzznryAlYhE5dDCQuPEpZWqmiRpAlnaHY9o7MdTw+28Lclhx4toyoHZHPGgeeCMW98
 VIZMmtQW2crq0Qv4BzDnda5g7xfb3KUlN9rD1T2d3lnkb3gQqQA=
X-Google-Smtp-Source: AGHT+IGBFLyUXnJODxwQklVoTmHypYD49+fnU1Q9uQoOxl8BDjJ///fY5fDQpGikfqEEvaljvptQSg==
X-Received: by 2002:a17:903:2381:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22fc9185e2dmr242500925ad.34.1747073128103; 
 Mon, 12 May 2025 11:05:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 18/48] target/arm/debug_helper: compile file twice (user,
 system)
Date: Mon, 12 May 2025 11:04:32 -0700
Message-ID: <20250512180502.2395029-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.47.2


