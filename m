Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858A1C05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSJ-0007h8-9f; Thu, 18 Apr 2024 15:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQo-0002wc-Ak
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQl-0007lQ-5o
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-418d1edcd4cso9435345e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468501; x=1714073301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Yz7aRuiYxkABVdFEv0r+XjMMhiAPKgmd2KiD0xHfQg=;
 b=X7vURuSvQT07cVgIi989oUl+bZhnHoK29CgeeFQxYymNaWLK5OblSHmRF7Tjg51WnB
 zPhuB/xUeh58Z3cFClgBHDZdfXm7Y22Sk3JtlAlHTQ1c9Yh7El2odjwatSrrZIxmEgwn
 2br76v9t3LeU4lzGfIr0l2mrqtqlG+w7ZLmcS8mFSt37dyfcDtlskn5YXqrH9cUB97vB
 D6cT0QmeYMqGNrPOmDGhzyFs/bFcpKGl02M0qCOMil47F0Zo+kguv0rSefT25UtDH7ex
 Z0bT17Ga/g3rFh3+2gUVgrVugdXzkszACplAFYd63RIvyRWj9j/Rfy/to+KSq41I0e5L
 MuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468501; x=1714073301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Yz7aRuiYxkABVdFEv0r+XjMMhiAPKgmd2KiD0xHfQg=;
 b=pJ9lySGIBvxK5tbnl2TkhTCj9Yf3+8K7fkWlo48+YVdGDO4GzBOq6LzbHAjadyTm4c
 4vBU+62rx7gqT36k3+MYWEuF7BdPrCPD6Srcb4Z5kY+c25EosF7+U2/rgayhl/sPyO+D
 abhNcNr/jk7vU0fqhV9NxRqkZTvsvCzyCzQKkq1ZCFehdJgMGRPGIEfMkFKQ8zC33Jr3
 K6nlO8AW+BGzZj//YiyrHf6CSXXMQ4yLSe/oWGkUCcJSEUdUVnTKGJ23Ui7FRxRtisCB
 paGnnfxqrZGvcjt5TQWa8SDa5bJWCxG0HtIbuHClNxvvM2hFGcGarM7RWTrZWTVhtfsh
 ZGng==
X-Gm-Message-State: AOJu0YzWN3YqOiNGziBspbmZ0CjGCSY0MYgeMR6+j+GNgXEACojn8Xz9
 jQlBuPoD9XlYtNPtNAv3h7v6LykVXmgv5itzhL+HUEmJ/KdD9CCHEze7qPMz7nrcQHrt6mVzP0U
 b
X-Google-Smtp-Source: AGHT+IE562H6bYcdnvQhGKG5MNuVHbGU/S9+AnWWXJN4YRjw79fzPiSU1R9hf/G0jjN+LtZRXHV9Vw==
X-Received: by 2002:a5d:64ca:0:b0:346:44:3910 with SMTP id
 f10-20020a5d64ca000000b0034600443910mr2930235wri.49.1713468501071; 
 Thu, 18 Apr 2024 12:28:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a1709064ad500b00a47423b4c33sm1256988ejt.128.2024.04.18.12.28.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:28:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 23/24] exec: Remove 'disas/disas.h' from 'exec/log.h'
Date: Thu, 18 Apr 2024 21:25:22 +0200
Message-ID: <20240418192525.97451-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

"exec/log.h" doesn't require "disas/disas.h". Remove it,
including it in the sources when required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/log.h               | 1 -
 target/avr/translate.c           | 1 +
 target/hexagon/translate.c       | 1 +
 target/loongarch/tcg/translate.c | 1 +
 target/rx/translate.c            | 1 +
 tcg/tcg.c                        | 1 +
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/log.h b/include/exec/log.h
index e0ff778a10..ee33981aab 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -4,7 +4,6 @@
 #include "qemu/log.h"
 #include "qemu/log-for-trace.h"
 #include "hw/core/cpu.h"
-#include "disas/disas.h"
 
 /* cpu_dump_state() logging functions: */
 /**
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 87e2bd5ef1..b2005f3cbe 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -29,6 +29,7 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "disas/disas.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 47a870f42d..6bec38404e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -25,6 +25,7 @@
 #include "exec/translation-block.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
+#include "disas/disas.h"
 #include "internal.h"
 #include "attribs.h"
 #include "insn.h"
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 7567712655..ae87a68c69 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -14,6 +14,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/log.h"
+#include "disas/disas.h"
 #include "qemu/qemu-print.h"
 #include "fpu/softfloat.h"
 #include "translate.h"
diff --git a/target/rx/translate.c b/target/rx/translate.c
index f6e9e0ec90..4259ad6d74 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -27,6 +27,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
 #include "exec/log.h"
+#include "disas/disas.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6a32656cd4..e7e0ab6846 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -51,6 +51,7 @@
 #endif
 
 #include "elf.h"
+#include "disas/disas.h"
 #include "exec/log.h"
 #include "tcg/tcg-ldst.h"
 #include "tcg/tcg-temp-internal.h"
-- 
2.41.0


