Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E14E75459
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYP6L-0002S4-3i; Wed, 24 Dec 2025 08:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP6C-0002R4-Au
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP6A-0002Z9-QJ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:40:20 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so39636945e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766583617; x=1767188417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWjac0+Kz5L48LnLkc+my141z9NWCQHb41+AY0m7S6g=;
 b=zuUjUtVLVOnkkelmiOGFNMihILMVRXmio0MJC3r4TOWCh6WZU6H+VGiKU5EjHwSf/b
 Xbt3mC+5ee4rbqCyW1E+hdUfgkPTFRWmDawqUYoFbkIKZ0tpQcbcmrYUwQrQhnFEbqIU
 TZZCMfMc0qwegkObiCBoYQKWyWU9IOSXSrkaJhg94QHOExUdPrrSyA7ooK6jWQ+lEkHE
 Xl77HhpkCGBGq7dbZXbZZP1t6Zhtkn41k+11ZHa5cKc1FM1Gj+odWfA2ZSIrRGjslpQN
 Li+z1HB00KWwasHmhez21nr+E1gA6oan+4BXwrVZLNUWB6NrENd6ODSCycX9Ure5mYBZ
 PmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766583617; x=1767188417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uWjac0+Kz5L48LnLkc+my141z9NWCQHb41+AY0m7S6g=;
 b=leQSBPf7iIFn/cZ70oO2PXXMmStE3aq+QNZcZ+9QXidHIvPgPRSzEACLrIN92fwwNj
 dI9mm/EHoyqsj4j18waVr3HB2o2ZXYuYwAzSQ1iNULDCbYeYJ/1XS91Or/MPpENn5Aob
 uANHEQ7XqYbP+f5cIW3mBKyhDpyJDvSZsrB38rJpQhRjZByoQOumhVIHG4gAAPehgR7A
 uv2QFA/fqjFe27Acy7aDpkCWb/P9HxxTouRcYgJNMvCxnezocSEJr6qKI+wIaF4H2PSG
 6/YWNV5W/zn+oIHPFVWVQje5x3iLUpW/qRB0XSb8BLXDCSBEcqWkL9l3oEi01fZUkPxP
 jkAw==
X-Gm-Message-State: AOJu0YwARlg2FwYWdw7tVxI3jOGmqMMcHIosRbeg4uHUjx5Snj/2DWpT
 1qoUDsYAKNXYpZ1JhMtB3zZntFdXA+IYftOnLKNDumVXdN9nG0oZ8+8Zlb7C6gaaoFN7zNBaZTB
 Vkkpl1Js=
X-Gm-Gg: AY/fxX6RBrQFCDE5qmYyQlqSUyZsg3kWFGnii1HvyV3bMY4pBIfo6Y6he4oyiyCZNba
 c50IKR3v+cFb9+mw5H/sLduitDcP3me4KwxsB2858Fhr6JcuYPUqlDtmdIJ+2TBat2TCCpqeuV1
 Uux7pzjYVOCBZryQ2iF+kjpHm7iZILNPci9SQstWhrO8H1e0lUPfy9vD7YykhihK7zG3o99gvw2
 5ILmnH64kG96pNYik2J/6k1qWG9rUuqVfj3WOWMBy0XnVQuKarQPbUvME6SRt+rYqaPEyjRa9UZ
 wG1iOL1c8lRb4xuGAW6jFoPMbjSr9kK3LYHaeXE7eqyTabZOrLoa+rmFtHZDUg31uULoWFCoHzR
 xZjX5oXp3xDYuGJyvA8X+m6uAmB1GtsqdBwRLgID9SNuDCTeiRJ95/93tQ6uifuiUu2iAjmYlON
 az4NgUym7LfZGspMsHyR9uro24SXO4V4H72QRT3914Z4yREC9x0L+KI1AkylEM
X-Google-Smtp-Source: AGHT+IGMAwR0p5ixFj+lSIqKJsyeYsvaGgH76RxhEingeOrtWIx+E5OM0LqiuI6eNEgEE/2sRzsd9w==
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr177420215e9.9.1766583616984; 
 Wed, 24 Dec 2025 05:40:16 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3af6dbdsm138952525e9.19.2025.12.24.05.40.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:40:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] monitor/hmp: Remove target_long uses in memory_dump()
Date: Wed, 24 Dec 2025 14:39:46 +0100
Message-ID: <20251224133949.85136-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224133949.85136-1-philmd@linaro.org>
References: <20251224133949.85136-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Pass a plain vaddr type to express virtual address.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index c00f75eab3c..d2bdf44dafd 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -232,7 +232,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
     int size = qdict_get_int(qdict, "size");
-    target_long addr = qdict_get_int(qdict, "addr");
+    vaddr addr = qdict_get_int(qdict, "addr");
 
     memory_dump(mon, count, format, size, addr, 0);
 }
-- 
2.52.0


