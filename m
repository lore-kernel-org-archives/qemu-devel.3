Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A74DC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5BW-0008Nn-0w; Mon, 05 May 2025 19:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AT-0006rK-CV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AR-0003wR-4U
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e3b069f23so1506645ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487448; x=1747092248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=liUyqysj8f8KLGSliJqmmqCXAmE9zXwKnqbm4SC4fMCOtNFqe7EMYVi/aSJT3IjVMN
 xONGbd9oRKfsROhIcZIqFmWfBwRRTZeT27JxVshQtCYrJr+KCninUWoXFrS8+g7qIDps
 XkprY8Adw3KS491uY6Mvioz8baJBEShntaZnDBLoe1RADvvq1OCQdgqMddj7ef205w/i
 fYTN8tl7m/HxZ9MRshVwNCmPh9PDRHAGjZSpVvYfYV487BahfS4dw0qeZ+DmmtHrPQxn
 FrQQ0Tg8sLHjDmg3sKe4gm+gi9atUcGsj/TQZN5HZe0NkS4wlCO3hRECMcjOx1yYCOys
 +NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487448; x=1747092248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=K2yb4qPKvAg6RqyGC4Gu9FxL6LGu9F1pAmB+EYk1YjFwsx9dLo7Tp0IB/xxBG1Aorq
 DJJ0G6/3TnYpYOFS/ecdXcsc3kSINmiVSUpQcEoL9LUcumIRnuLGeRQ8UGyszVdSyv9q
 ER+vaMKS63894K++AhJed5Mp8iht4yYvCOcwJ+sm4kIqmTl30T0LjagHVyioxgHo3y7I
 f77DbFah5UFWcAQ0JibSP4W4tjyYvA67xYmETTHpKw+5e3t2SockYLxip1pk0CcE/LEI
 O1dUjOxeLwp9PNS5WoEUoY92T59EdtPfdOj7ubrbHr2BGNvYLokcxLcBmH3BKtUUZsKT
 hc0Q==
X-Gm-Message-State: AOJu0Yzq9dv0SWU32e1iZyPnfQn53RQucP24grt9HSYIM3TfXdGo1UUi
 zkP1cnzIq6H9q7+3KwH0j/AxnYRUWi+w2x1NKOTArwKv1qedCLuM2YErVjqtE46G+2YbBy9WOkj
 nR28=
X-Gm-Gg: ASbGncvlGc5VPDZE1NBS6S3sWzcIYXy2qpwOo9+K+1/d0NvVLC51VgglTsCViI5bt7q
 EpjSZA/JkJfRMb023DWxzx6jIKMwp8k09FgmNUGTxvRKehPId5p8OxGXB+YXsk8V8L7y/81wGmv
 EFr+K4Pc1GJxaRClCFkobHkiMF4jwze71iDLs09sAMeaFvLL+N7mFRY35b/uzcbfr6EQy9Mla81
 D8t+wajuzXtJSTfGiINhlg4gcm8c63OPmIpGhaCC+cq6365jwMxLze39m+QQvq7PfnvSmTPcsA1
 cMRKORBLu9vZzE2/+Efzu6tUWMVenHYchFlDpxtg
X-Google-Smtp-Source: AGHT+IE4m0x6yn3Dhs8eTavS88cR0qWGl83trW3I/6iVUauH6UbtpdaA/Q0wYvVh89mav8zm9Mw0kQ==
X-Received: by 2002:a17:903:124b:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22e328a2987mr12958275ad.8.1746487448131; 
 Mon, 05 May 2025 16:24:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 40/50] target/arm/machine: compile file once (system)
Date: Mon,  5 May 2025 16:20:05 -0700
Message-ID: <20250505232015.130990-41-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index bb1c09676d5..b404fa54863 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'machine.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
@@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'machine.c',
   'ptw.c',
   'vfp_fpscr.c',
 ))
-- 
2.47.2


