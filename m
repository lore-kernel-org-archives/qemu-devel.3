Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FA6C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 23:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMEjP-0007q9-7R; Mon, 02 Jun 2025 19:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMEjM-0007pw-K2
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 19:38:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMEjK-0002eb-Id
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 19:38:12 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e16234307so41207955ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748907488; x=1749512288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MgSl8HuZl3uXlLASWUN9oqKEx0Hjz/JuuBfOVhQ8ywk=;
 b=DRHu3DdgAXKNoFvNh9y5fSyhLlBTq30eUBlYo9r304HDRr/61MxnbM/Lm8U5CWmUUe
 c6NsZThshBP170zrwakxQSNo12vSC4fjcxyEkwH19kgKIbJAt5DdtFUg4x+KqWt9pUJv
 7xtwoHQ41bVBc+msYNXnV0JrJXVPaNR5PW87dNagcPGjUonWaXHeG4/21p4t2cizmfNO
 oDHAJ+jb2CeWyQWAkvp2t0ysB+Ba0SucXjzqcb3VvXRSEAsbQ6NhRZNMHMS4AYQSln6T
 2gASB0zF9X1cFjzNSuyVzvArYTPuko+ABiCJJCr/KX/MSbKkVwWEAqk3RsBNVr+EW2lV
 aJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748907488; x=1749512288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgSl8HuZl3uXlLASWUN9oqKEx0Hjz/JuuBfOVhQ8ywk=;
 b=YyIE/K0efzAJ89tWKpEqgeYsmr3qSgT9oiP2F2qKwV+kH0/jJblOjtCHuEGjjG/4uZ
 dQsH60fy209b3M6FzZguykuBvW9z17jiUSAOoLT3ZrAuRixIMkD/uhS5eSrDtP4aMz6B
 cfZKWDEnMsS8ZvwdgDzG9mQNf+pAw60eggoJxLEJHbwsAL3PzxlZO7RctW1Ayhf+Wc52
 enrdiWcd0tcf8GCnHRNTt5ewhSmhOfUP37KBSmex8ZXMqyznZtNPFCtQ8jlcBwumV4/i
 Ir3rxWwgPgBrvq/q7Jx+n4F3kDBC/YfwP6MzghfaDoGh5UU8HkGXhw+yK0hy1+49msxW
 //AQ==
X-Gm-Message-State: AOJu0YzWgQBSGorLWazJEkkIped/RQPYFiYg9ixhWbOThwpZSyFZZ/DI
 6a1oq1SGJtmwNxyRXwhHcOna1Oxz8hzX1i84imKX2lPcEqXaDvc0m+sKMVs4FgI5AHFC5Xt0k/N
 bzp81
X-Gm-Gg: ASbGnctiK2j7tMcNdNYZXeWOwDH6kYuCrD1x7dcSzRDeEkRMNqRJiisKkGsyj4v3IAJ
 p60wMeoK3TFJQdR2EyXday/s1BJ9i5Nkb7WhOcsaASYl+bkZ5CT9AmGUVBn1ktBwHqPBAlU46QK
 ngAOx1//HwyIcWQYdlpn+Do+Zs0WMVMuB0y2jV7TokXT9X1EbYI1rYAsIMm9phVl5WchKxTCDK5
 P+KjrrTPUBl0V0POeMOOsmZ+fr47murSmpWbOwjcsgS6R3GLqAFKYWloF581Mju4yrcbdH2IpD/
 Exj5zmpBDKs6k5ZHlgUT8ng/Iyld24q0Tv7qpQLcC4TlDueH5MM=
X-Google-Smtp-Source: AGHT+IF7f8dLoEd51pnOmYk8BlAomNBrtPXhgC+lE+FpAJ0GRRn3ttVbi9NYT4mnbiAjSjWcMpzNgQ==
X-Received: by 2002:a17:903:19cc:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-235c9d95d68mr5008575ad.11.1748907488468; 
 Mon, 02 Jun 2025 16:38:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd362fsm76178925ad.116.2025.06.02.16.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 16:38:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: clg@redhat.com, nabihestefan@google.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] meson: use config_base_arch for target libraries
Date: Mon,  2 Jun 2025 16:38:01 -0700
Message-ID: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Fixed commit introduced common dependencies for target libraries. Alas,
it wrongly reused the 'target' variable, which was previously set from
another loop.

Thus, some dependencies were missing depending on order of target list,
as found here [1].

The fix is to use the correct config_base_arch instead.
Kudos to Thomas Huth who had this right, before I reimplement it, and
introduce this bug.

[1] https://lore.kernel.org/qemu-devel/c54469ce-0385-4aea-b345-47711e9e61de@linaro.org/

Fixes: 4fb54de823e9 (meson: build target libraries with common dependencies)
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 2df89006f8b..ad9cef99ed9 100644
--- a/meson.build
+++ b/meson.build
@@ -4142,13 +4142,12 @@ common_all = static_library('common',
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
-  config_target = config_target_mak[target]
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
 
-  target_common = common_ss.apply(config_target, strict: false)
-  target_system = system_ss.apply(config_target, strict: false)
-  target_user = user_ss.apply(config_target, strict: false)
+  target_common = common_ss.apply(config_base_arch, strict: false)
+  target_system = system_ss.apply(config_base_arch, strict: false)
+  target_user = user_ss.apply(config_base_arch, strict: false)
   common_deps = []
   system_deps = []
   user_deps = []
-- 
2.47.2


