Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895F0E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fR-0005Nt-Do; Thu, 19 Feb 2026 12:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fO-0005Lj-LK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:18 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fM-0000QV-TP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:18 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65808d08423so1724420a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521495; x=1772126295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GGmWkjWz4puRqxAAWgWsdZGg7jCqrUwwLlCs/EENBI=;
 b=Mm3T/3uQaIKRTqZ8YcIZ5tMR8BWeZhvz8n29B86ta1/5/PBzlBnxpOzDdVDnEAhUrX
 SiJGO6l8/y5JmmJ6rLX5z6/7p/w/bs+Y8hJ6FqkFPpBSOBzZfNBdH0laj/9mnrUakK5w
 +T42Vbo+nRgBQwZCQSmdnckZoN/IV21sMETor9dbsanHGWcJE0TRRRxdVg7hY7XTlO4H
 KOddffcQr55MDydsL+IliL6dvovntmj9kIU+l0uFzLwhfO13gnKX//rKjiQwihIrt1Nd
 kPQgAezBqFI9hOc8rqcoSSa9Et8cLWzUWT4MpUU160BKy1GYYSxFZheKqisYQo3pfI2b
 vSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521495; x=1772126295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2GGmWkjWz4puRqxAAWgWsdZGg7jCqrUwwLlCs/EENBI=;
 b=CWT6FOwc4HSwPtzZ+2rqyEl66kNGGG7uxvZZYg8CMA5Vd4+0PpULE6YYyCx/6RHBEX
 vEY03ZUYn4z8iNqlauFC6WvCJ4Zv6gdZ4Og4ni6nG8jow0M06RQXK5+DgYqIIATQHr1R
 EGUNZ25KtbUTNyKCMl9wHkzu6nubYkSuITcUnOYKzNnFrgoyqvngUEGONb7UJk4mtNHu
 4bs7ht9ZzpLrR13BQ/TxXP+b67VJSVPQXchnhrjRWvxdkS/EEOCA1ByDwh+k6cwngRFR
 nl/ePBhqwjGi6/jBcbdkVXjBG9znP074itkeRVpDWiM85/tNiypK8aIqbxqMwZ0rghFE
 ezTA==
X-Gm-Message-State: AOJu0Yz1mZCYvSdvFmihQXR88b1Mmtj7sbdb1yaMEKRAU+BX0cKg9rGT
 YSWf1F+5mBwr09X3seQkZfivN3GXIUHQIXPJCXz4IARz/jnNn0yZNcL3It1ohg5yvgY=
X-Gm-Gg: AZuq6aKpPc8SzXKjfgDBGFB4jny0kCk3XTwNQedKo1ZvwCC0/hgsYLONe5vqdS9R4/3
 +hrZOtbz9RdVV5CruBtZsRQSLzY/F6yDxxZytOPZKTbK9XaYjNzs2Jlpu358sqS30FQvKkh0ry2
 zw0yR9+1/pc0Q5AYC2WmlIMeLaF6ZwoBsLYVb6Iw37Cd6s4431r7sjcJaeH31MnuyvSsCxH3ymz
 CzBm2JPmN56uVamA3+0NCG7ufiRzN0kDq8R6Fit8gC+xV0RMY+O+WDRxFE+n6Qvi0YVMAphYXGy
 V2n6siOrhQy0Z340u8J23Pn3GU47k+5GiNobJ1pG4QUNCvouiFJAmbVlZOuKvR2f2cUW+jpkQLI
 0ZxF0HdQt6ca4vnBwHCOMqeB0pS2VsNjyZe455RgUwhAyc4SgOtiNjHxWm/mwONT7O6OoH5lK60
 BWAyc6lDk23u8M0RCRgqPPc/4=
X-Received: by 2002:a05:6402:5186:b0:659:5c63:e0e0 with SMTP id
 4fb4d7f45d1cf-65c76a24826mr3305965a12.24.1771521495125; 
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad29d4afsm3912153a12.10.2026.02.19.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F1355F877;
 Thu, 19 Feb 2026 17:18:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 01/14] target/m68k: clean-up includes in cpu.c
Date: Thu, 19 Feb 2026 17:17:57 +0000
Message-ID: <20260219171810.602667-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

We don't need translation-block.h as the TB flags are local and the
only bits needed come from cpu-ops.h. The vmstate is a system only
concerns so we can guard against including it for linux-user.

Finally tidy up the order to keep things together with the local cpu.h
kept at the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/m68k/cpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c721a23b966..d849a4a90fc 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -19,12 +19,15 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-ops.h"
+#include "fpu/softfloat.h"
 #include "qapi/error.h"
-#include "cpu.h"
+
+#ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
-#include "fpu/softfloat.h"
-#include "exec/translation-block.h"
-#include "accel/tcg/cpu-ops.h"
+#endif
+
+#include "cpu.h"
 
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.47.3


