Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C68D1119B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 21:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vONIp-0003z8-ES; Wed, 26 Nov 2025 16:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vONIn-0003wI-Dg
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:43:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vONIl-0007yq-Px
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:43:53 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so241744f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 13:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764193430; x=1764798230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qBmCfh5QnHw4NIKbuE54GqK3as/5AkLZm+R6zX3GXqc=;
 b=WywwK5qgb2FUXvENMINuDOJO43jsW9IB+kqwAzdPPv0fXq9RyG41IwAs3R8RjkSGRp
 hrJ3qe0Emeszl2dAqZhRXPd6bSRbR8Gz21CTmsFqXOH5N6W3YpacC55EriQMKDU/RtFx
 8jjka2OvMcTK+vj5uKpkkHd8FJdUL7VXClcKuz+kozsYNaW6HWwygfNwuDf1rg/yJ009
 azacsr5lghDfDeL2/17J/Dm1jy50xlfVWdycof/t8HQ+B4vR4ix/lhPhAfw5DfbOTsVW
 ihfRoBOJ2CM5csD/ZitPXThdvanWK/RIhN28hADfr89mH2ReemfLTal/AFVGjIc0yxq9
 z3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764193430; x=1764798230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBmCfh5QnHw4NIKbuE54GqK3as/5AkLZm+R6zX3GXqc=;
 b=G+MJV0TYCnuh0qNZHNRf3BqHSWBJWgcdYlrQwE0LFF3yOWylIGG0A1+rviiK33YG8x
 fa7uHINNTSMn2CzVVPpPGpbB412fQUzHIqEmFfSgJYfduwB2Fj6yxM0XdV3wDDwUEZRF
 5fFk7HgrBZn+kAp5UzVPHKu/XCBtL0TFFoqvK1Kdef9cvIm8G6P1vDTBUUhFTx/0USeH
 GUCJ8USjFVO7TqRhvd1SvEQQ5Iu8IsW8LRlZolj1tO8cTOYwF4ovPoS8Liod9BdrCMCW
 FtVZ+NXvlUbGek6OouuPkZmVdScT7aMg6CyC8CQlEzNzM3Ns8+khsjpl6ipCYe+XGZnL
 qB6g==
X-Gm-Message-State: AOJu0Yz5zqseiWhrqRL1xZj7jNMjr7tlT9OqmAJ8L6xuTmEawqKEWtl/
 7RlC69x4HBph6DTO1dRm4INME1qU5wt4MF0IEmF6JxE10THTWQ3Sjq6wwQOUBssO
X-Gm-Gg: ASbGnct9q29ny63xNg+s2EZJ1RXlxWjadY0eo+dTY1zttE55RDoXApZ4wgWI+G1fLrA
 ltOq5Q/e55NnrIi/naJcq4CqJ5fbx49Lm1BV/zlJNyZYxR1Ract5N+ONTC/kFnXNPVRBUWmskpK
 1MwgtPVnMSAk+72sI1n0IC9H/KmjG8o0fBG2LVDDOb+abjHYsZwkbUN5LBaWhR0OV2oPv1Z+BV6
 vlSXRhEVGDQR4tytbRRXycgY07d5Au63BrU/RTOBL61bgnNVeBTSlYWzWtm+2255SWRTuqMsfx2
 +ywXNOX7BqBXteOiQ1XyUdxhMjRc+MBLkKCsfTY7emrnVZ+2MtATmTN6neokZmfJTYqpmE8tQaw
 MxvsZQJME6N/HGiKnWjZFzd+yA8Pv0BSii/k9l0k9sklpcaXe+TAQJOt1NP3VbuDD7hWrDtm3EG
 GZ+oOSX5FmRa83yQlmFGH4hEoDIg==
X-Google-Smtp-Source: AGHT+IGRfYxblmrH/HM/8lBmUN9/Fvk1uc/+bl0MJdqIK1qNvvlLQZysL8lUL1xGSfJAE6AyaNbVKw==
X-Received: by 2002:a05:6000:200c:b0:42b:4139:579e with SMTP id
 ffacd0b85a97d-42cc1d1983fmr22114990f8f.43.1764193429904; 
 Wed, 26 Nov 2025 13:43:49 -0800 (PST)
Received: from osama.. ([2c0f:fc89:129:990a:83a3:6137:cef9:6de9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm42628587f8f.34.2025.11.26.13.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:43:48 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] accel/tcg: remove duplicate include
Date: Wed, 26 Nov 2025 23:43:22 +0200
Message-ID: <20251126214322.64855-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

tb-internal.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 accel/tcg/cputlb.c        | 1 -
 accel/tcg/tb-maint.c      | 1 -
 accel/tcg/translate-all.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd1606c856..a5bfe295a6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -44,7 +44,6 @@
 #include "tb-internal.h"
 #include "trace.h"
 #include "tb-hash.h"
-#include "tb-internal.h"
 #include "tlb-bounds.h"
 #include "internal-common.h"
 #ifdef CONFIG_PLUGIN
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cd7c32361b..c183b66744 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -32,7 +32,6 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "tb-internal.h"
 #include "internal-common.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fba4e9dc21..b7e4e65932 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -33,7 +33,6 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "tb-internal.h"
 #include "internal-common.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
-- 
2.43.0


