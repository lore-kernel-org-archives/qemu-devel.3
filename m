Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9D7C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Bnc-0001l7-B5; Wed, 09 Sep 2026 02:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgarhw@gmail.com>) id 1x4Agj-0002bh-Si
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 01:17:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vgarhw@gmail.com>) id 1x4Agh-0005M5-GH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 01:17:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-868b3248b2cso283125b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788931053; x=1789535853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lH21qSRjt/8Q/AD8g78BmCGIWoDOBkBsX6AcoNnGDi8=;
 b=JQNWIJbdyA4U7KQTwQhtKbJihAaWEjx/T+sebTMBqIMPYh2/9G6rfpYutYLY7rdu0E
 1QezxSmfyhiWQakThw2K7m/xG2hta0X1B4+2WUxcL0zaltmp4SCguld7NSlQSLx+rbpz
 2llsrEiyfRPjZ6eNRy2AQhtxE1a/QAa0GDsEnfVoAPW2UAL4F81jFTZps2fj/5Vo8GFH
 /y/GO+Uwg62Nm41J/fpF3y0XNVhvPsCyBYEo7tdJidxwkmdgmcyJ1A1SwWtFaIfYGkWW
 5HOzQ8LOrSYidaR+MJmr2VMPAtXDE26Ze+r8qxgTi6sJkZ0L6eIdv1LY+C9FJsJhvd57
 75Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788931053; x=1789535853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lH21qSRjt/8Q/AD8g78BmCGIWoDOBkBsX6AcoNnGDi8=;
 b=Z/iPzf/tU8HcfKH+EJ9iYNeCUnJ5CPaPRAQ29U4PI6BNw75FtDfEk7SjKHY2hBI8LD
 2dgsnHD3CJ9QQEErHmp1+3V3gOHrlPro59PGzZektW58qc8b+fT/D8RbE2edGAbtaQ52
 o4cyQwCgB8V/CQat1MVUYHHkq3qQXgbxNqXwT/cJxu3vazaZJVxayXxBzJxC7L1SAJbR
 pb0NSBSljA6TBlyUoVLpnGCdnSWjX6YiU0uRsYhY+Il9d/A3mp2W+WlIk1owUQ5bNcUz
 XPWQIx7atxtKwHYXfsU7wbINQeg/gjqkbm6rFZXvbdX28T9UhJPELvzlUzlmw0c+Naoy
 kd9Q==
X-Gm-Message-State: AFuF++k/QV+jmxp2s90A/+l0jDrsrbFqWjpqtQzHvcss6Tk5jjPLsj66
 MZUGzsFbz6QXnTrzRApfwJbVOyNTCZ/S+WgNsre/2g81MoH1lFva+fNiuMN9NQQPCUjOoA==
X-Gm-Gg: AYBFou032BZK4RwoBTGP17gzlehanLUJXzSixmiN0hoimN4F3ykkCmC6nuk0EitqC0v
 /R5RUweU7uFUVsXIYFrDYyhcA/0DkY2TpzpmEewQnSIoBZvfDO6ePGmB+teD9IfW8H1Xgpqj1VD
 LewgWeAHqAJc8tA80JQxj28wo0QUtCkMfWuhGCYYphARF+LbdLU9FPqOgJa6ZKgWmgBamPdf4Lm
 Qh2kQkyobpHwN9Qi2J+aDZMY38EaJ+owIqUF2/6Ca4bA8+uTcCZQSJ5b4xyjxRW2OHcs6H1J5JU
 51o1MU4YVy54w5Ev1cbJsYoPIoL9E1/Mk8yHzaYzmpvfg2e/r4Kcv5eDaFvQjMGB3xmmAiATzc9
 BqmPgr6CTwsiYhcb4X3tZCd++fVBVVPPPbokuA9gdNWaWlHJMAG42pyVI0lmthO4zbIODjjAaNu
 yMghE535e9MjDggrIeyPIIgQ/aGcecYqpBqLmbZiTzhKgiZPDrwsGm8Cv8lwszHtPt/0MoyAUPp
 ICY4S84HCGKqN5k5RN6XL3w
X-Received: by 2002:a05:6a21:3cc2:b0:3d7:7b6d:4997 with SMTP id
 adf61e73a8af0-3da3a16bfd5mr52504644637.27.1788931053107; 
 Tue, 08 Sep 2026 22:17:33 -0700 (PDT)
Received: from mac.lan (c-73-241-3-198.hsd1.ca.comcast.net. [73.241.3.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-338f7bad290sm11130409eec.14.2026.09.08.22.17.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Sep 2026 22:17:32 -0700 (PDT)
From: Vikram Garhwal <vgarhw@gmail.com>
To: qemu-devel@nongnu.org
Cc: francisco.iglesias@amd.com,
	vgarhw@gmail.com
Subject: [PATCH] MAINTAINERS: Update email address for Vikram Garhwal
Date: Tue,  8 Sep 2026 22:17:17 -0700
Message-Id: <20260909051717.19647-1-vgarhw@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=vgarhw@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Sep 2026 02:28:46 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Vikram Garhwal <vgarhw@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..f001bf0d67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2178,7 +2178,7 @@ F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
 M: Francisco Iglesias <francisco.iglesias@amd.com>
-M: Vikram Garhwal <vikram.garhwal@bytedance.com>
+M: Vikram Garhwal <vgarhw@gmail.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
@@ -3042,7 +3042,7 @@ F: include/hw/rx/
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
-M: Vikram Garhwal <vikram.garhwal@bytedance.com>
+M: Vikram Garhwal <vgarhw@gmail.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.39.3 (Apple Git-145)


