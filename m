Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B94C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldc-0003tQ-MQ; Wed, 24 Apr 2024 19:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlda-0003rT-Ce
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldY-0002fv-HY
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso425563b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999767; x=1714604567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdYcjDwLN/xr8PQzvEnfgv6lYJ6ezf5kr9JF5Mk0QDo=;
 b=lMxfB9E51nVwCVawkxn8buzfoGOSX2vUXTqRFQtYjFyKzvoMj9DSmYwT1IJd9dMBul
 YMkKAI9mOCTZfGjP2BcDPTZNj2EwhLvk23vN5vKeW9JbYzjg1POQv9U5s+De9x27PvjY
 vjPc3znq608oqsHejximUSpt23JaBudkSmqUhV4duEdBf1xz7uxugi1f5ixWlXnsT8jy
 VzdeMwyIyio4GlcBPjrlUk31bhFRZgB/Hvrf6UdJss0L2Oq6m+wlmeVuLFZT5BKxAls4
 YcsKLTfZNIhBT5wTznqMuGjRoL73apTsJ60QpC5bLsVPJX3AzAkQDMkfOAF5LuhQrs3I
 Jr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999767; x=1714604567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdYcjDwLN/xr8PQzvEnfgv6lYJ6ezf5kr9JF5Mk0QDo=;
 b=Vfx2JR0AAVWZhnyq422tzq0+1+Guu9j5cgA/5H1yONeN9jhfn8P5KUgcSw8TdYRtRZ
 tHca13WCr+UJ8skFX/xtfff6RmpGHDDq5eZjJrRM4kT8FPzefNabmQ8bPKaExKYl6+XN
 tadNcCrh2RyE2bfcN2vfVTGZeAG7doP+eQ3CpSC+gr5BRz0H5BMmMBIb3xcCtD/J2fTf
 WowGwxm3NQ1dn5Dou5+U/EvvUf4xFO5aNnWe7HZFYV7SK31p6OROef/49dSRHMWiFtLQ
 VJ9eSPQ3suZi1jcjxQNy14l5DTO0AdZsETgcs4Wi5HAyjXiIh3EuH3YUvyFwvz/jZsHE
 YkDQ==
X-Gm-Message-State: AOJu0YyHuht6zOvwvZuZh8198/+XhOMDGkxbth6nrOL7+cEDLgwDDZhu
 P0NOVJPXTqB3dyesgA8qZYzByWcSIyYRnNcwPvcJDnbXwDVu8IQUVfmvdBTRdGD5Eb716Z0cP/u
 X
X-Google-Smtp-Source: AGHT+IEGbi8argVf6wd1RUoi6Vzy0EoM59TFzaOKt9yzkR+YHMRAmC8op4+OVxtCZRXCMQdXWD7M8g==
X-Received: by 2002:a05:6a21:6802:b0:1aa:5fb4:87ff with SMTP id
 wr2-20020a056a21680200b001aa5fb487ffmr4008038pzb.14.1713999767178; 
 Wed, 24 Apr 2024 16:02:47 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 20/20] plugins: Update the documentation block for
 plugin-gen.c
Date: Wed, 24 Apr 2024 16:02:24 -0700
Message-Id: <20240424230224.941028-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d914d64de0..3db74ae9bf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -14,33 +14,10 @@
  * Injecting the desired instrumentation could be done with a second
  * translation pass that combined the instrumentation requests, but that
  * would be ugly and inefficient since we would decode the guest code twice.
- * Instead, during TB translation we add "empty" instrumentation calls for all
- * possible instrumentation events, and then once we collect the instrumentation
- * requests from plugins, we either "fill in" those empty events or remove them
- * if they have no requests.
- *
- * When "filling in" an event we first copy the empty callback's TCG ops. This
- * might seem unnecessary, but it is done to support an arbitrary number
- * of callbacks per event. Take for example a regular instruction callback.
- * We first generate a callback to an empty helper function. Then, if two
- * plugins register one callback each for this instruction, we make two copies
- * of the TCG ops generated for the empty callback, substituting the function
- * pointer that points to the empty helper function with the plugins' desired
- * callback functions. After that we remove the empty callback's ops.
- *
- * Note that the location in TCGOp.args[] of the pointer to a helper function
- * varies across different guest and host architectures. Instead of duplicating
- * the logic that figures this out, we rely on the fact that the empty
- * callbacks point to empty functions that are unique pointers in the program.
- * Thus, to find the right location we just have to look for a match in
- * TCGOp.args[]. This is the main reason why we first copy an empty callback's
- * TCG ops and then fill them in; regardless of whether we have one or many
- * callbacks for that event, the logic to add all of them is the same.
- *
- * When generating more than one callback per event, we make a small
- * optimization to avoid generating redundant operations. For instance, for the
- * second and all subsequent callbacks of an event, we do not need to reload the
- * CPU's index into a TCG temp, since the first callback did it already.
+ * Instead, during TB translation we add "plugin_cb" marker opcodes
+ * for all possible instrumentation events, and then once we collect the
+ * instrumentation requests from plugins, we generate code for those markers
+ * or remove them if they have no requests.
  */
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
-- 
2.34.1


