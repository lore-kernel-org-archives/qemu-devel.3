Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B09EC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPV-0006Z9-KG; Thu, 01 May 2025 17:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOu-0005FM-D1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:00 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOs-0002EB-7w
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739be717eddso1241859b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134695; x=1746739495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HNVWGhJHja66UOEh7K5lL2rGWNIhIiIn3A57097VKo=;
 b=LTP/Y0ZX34iSot4Ne79Cc/dqge728Ogwu6X+LEFEj28QGGpseW3Cdg+XqR+L9yJyeY
 33MYxP3eJRETnOiQjtaDjlqxZeX4rBxnbHJe5Q+kQTpFq3wfGZDzaHIM/XwDnhN+jdvc
 gpmhXmS2eqA+fTwTFg2T+nbTqihKAp/qs+asa1/KhS2eABq7h+KJBGj+Ko9tgyYz4wg4
 fUEY3hta5ad7adOY9PIyZ6eEvBPVT1qDoddAySRHyyu/8IvZvejD60W1c+xVi9x+3jgf
 rEIkqEet/RQbIzQsWRdKrwULAznCRRsRhpf2KXK9eW+k0X3lI4tFjxL16e+Y703wWVfb
 EzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134695; x=1746739495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HNVWGhJHja66UOEh7K5lL2rGWNIhIiIn3A57097VKo=;
 b=jyVXW6pzAQbOq4Kv7lHjz3ZLR5wZgcDcp7PeLizX3viRmePEyRFpsu3aAlkOM15VIa
 ztWAgf1bnSsAVXnJKfwrbBJRODIeMFyHgOXY31NwHM0HkRQzTGDu68dmQ4CeVwRlWPSk
 XDHSzhNO9vGxL4W03MZPca0yI9eP5sHaPs8m2kFy0xvffEYZEX2D5qGlDTIpEFhpDPV5
 L35Lwb1DGfhZxNifZNEG4srKZpb5TdoahUbHkx2bAup/dBsFTtAwI4C3D/qId7oKZpG3
 TwMqyBWtkegEXkATAl2mD47PtHpCnZWPzISA02HnDQ5K/1HGcbqH9S0eY7ZB7SHo1xQc
 jIDg==
X-Gm-Message-State: AOJu0YwsyFBPThNfm+8izh/i9p9utZgQmGjT4mpyoZkntoofC2WKFZI/
 t8+mVTRG+32aowHa7HeVds8xuciT9iXHtHCMhzVuNSgbPcg+aWjIxdMKzZ3Sak2YEBhiibhnm5E
 K
X-Gm-Gg: ASbGncv+TI3E26bgckPVc/dqup3JOw/81lDr96/mZ0jVxKz/D3pXkkwXcOrFtIQmh5Y
 SThU1Nz7JcmV1O/1vMIn/ZzCJs2wilmYmeog+xLcNAllsWscPMz6kKxTtbKKlmYUwuKivpqZPzI
 VsaC3ZcGrKqgBgjCQn/Mry0v/fDOIrxxJqWHsLxmjyqtnx2sbkgf/RgSVEmb8QEAdUar2bXSwRz
 P3HlSsXcMm5nWZxyNqT9O3QJtUTOX3yaBbb9aV0H+5GW5mRW2hukAotHdw88bkoWCrqVf/qu1bX
 Kb6C5hOlLEz2JM/GestRK0phYlRJlnlbvozFRy444I52G+bktIexhBe63OOJ+A/WorchJj1r9tY
 =
X-Google-Smtp-Source: AGHT+IFx5kOmu2bcYNJVK5UbnDLb7xL2K4mUhGkzwXf/HXWcfvzytyg/JPk0DY//nj/5BQhKOXObkA==
X-Received: by 2002:a05:6a00:3489:b0:730:7600:aeab with SMTP id
 d2e1a72fcca58-74058a4906dmr605001b3a.13.1746134695594; 
 Thu, 01 May 2025 14:24:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 53/59] accel/tcg: Build cputlb.c once
Date: Thu,  1 May 2025 14:21:07 -0700
Message-ID: <20250501212113.2961531-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c    | 3 ++-
 accel/tcg/meson.build | 5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 35c467aace..5f6d7c601c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -25,7 +25,8 @@
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "system/ram_addr.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index d6bd304add..9b86051b82 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -25,15 +25,12 @@ tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
-  'cputlb.c',
-))
-
 libuser_ss.add(files(
   'user-exec-stub.c',
 ))
 
 libsystem_ss.add(files(
+  'cputlb.c',
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
-- 
2.43.0


