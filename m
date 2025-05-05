Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E20EC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57V-0006sP-Sj; Mon, 05 May 2025 19:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57C-0006Rq-My
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC579-0003dq-Mg
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224191d92e4so57099065ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487246; x=1747092046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=Q71P1qpmX8G4aqLHblD9aRVVAVvrAmN9sHO2lCJ2ZmrUOfL6O8xD2X7qm3EAR7ysfv
 hF8ht41yFiYWl0Ej7G+OL2JKvVaNzKQ6PbvxzgFSyzJS9BnpI/ZRvKfuJpWUB+cA55pg
 NJPZDVEBMzfz4i8NcZe+cyMpAQAoqnvOh6txsOv1JwlC4+weEdegCBDQqfrNcmLTGq3c
 OFLV/2TNInabM6a7Q9Q4sbG39NY2Wm53HX4obuFqybcHa/rhbPX+7UBQiOoillXubeWL
 3aZeuBG9mM4WpxxxgS27WO4eL5NxL+yZNjnZ6VBfKNWgD7YFXjv2h35gM4ys+3xSBWkA
 MwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487246; x=1747092046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=Dxdg83X4LOhIa3hP/f0wa+g56c4NFrp3m0ZbZBLGP4YfAJLqgMvScT8xg9XfuaCNSQ
 H4C6k86isHHG51qXowQNrf23S44yhwDTkuqNVXhPrR7NEEV03wYR4Y2m13b5CHJOY5fd
 iSGr6dhebOj3gl21PsP/nkEnEC1g2Nh2BlmozORLf+Po7x4sEjd6Fh/W6/TXK+GHF8/H
 ghPiChZaQLZV7diuYhUXrQ9SRgrh7xyx2/hvj4umOFeBujsMBasdFJU9/3q1yyneYUrS
 LvjqzGKZFffiupu4iw8lUQaEzrrT3Sx9apEfIuDOLJ6qyXubyDeuVzwYaAeHSoG7Bq3k
 r/lw==
X-Gm-Message-State: AOJu0YyKQs7ta4yQ1smuMMC2Odig4nYU9KA2fDWhZnEpccjO79pVJdHn
 dDxbCxYX823Se8yNzhHuYJ3EXrWi6fSAzqSMZBrFsAtBfluUkcFZcXsJHHiKlGXaPM1A7A2XG1Z
 /SFQ=
X-Gm-Gg: ASbGnctxgIIIB16u/J3/v73o7yBjZy1g9sYQY9T9HrNhYZRlznKrB7fYrBgwV+zLKBp
 nzTvi1hJOw8VDzWVcJgnSg8n9ofVp85x2sQ9PBNv6hlJ1ZjMWQXk/B+yU4kIadRWNSgZUG58mHQ
 3uBadAg4NEArqtg706ZL+DzhAcC3lhh8fsXwqU8FxM1jPjRiU/IpnY3JE29l5iQsVgfl3guJ5Z3
 WIjeGzfJSfw00SUfRklvHn2PEvx1YrJbftapYUcdsxci2NAWEvdqZLlPb/DEdLfGxXwCsxH5UBi
 luVgIhO0hhShbPnEiG+gvWP3lBwLFDnTyijbxZ3G
X-Google-Smtp-Source: AGHT+IFNUpBxaxlaaMr2/wMPpI/FmXGW2lNuJg+7HXwY+aLS43ce6Bg6LfXYfcUASH6/r3st2BArqA==
X-Received: by 2002:a17:902:d2d1:b0:224:2175:b0cd with SMTP id
 d9443c01a7336-22e32ba0bddmr14905925ad.26.1746487246254; 
 Mon, 05 May 2025 16:20:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 29/50] target/arm/arm-powerctl: compile file once (system)
Date: Mon,  5 May 2025 16:19:54 -0700
Message-ID: <20250505232015.130990-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


