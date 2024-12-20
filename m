Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63927E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfhX-000882-My; Fri, 20 Dec 2024 11:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgi-0007SE-GT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgg-0007zJ-3j
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1631081f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711432; x=1735316232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpB4OZyWBhd1PT/tVcpqHdcUkkCs6TvRmlAnArs5Gjg=;
 b=G5ur1wturxKblRXCSbfI9Ekrrs0rl/bZo6i7+nZv0bVhb9Xwc07gLerMEr9Y4NKOKI
 DGRuEtiA3d5ADcLfxitnFPIMb/0963Ud5L3kFedB8vTDa+WcEsV7YbOF5tF/XXrmPFmP
 zHx/R7b/xyHpHrPzzqfjae50Jn417DOz8jEkaSE2DP928QFHWDI82/AMqW3c9KHXJEll
 8oJGoTvKwCe9n1fqB/43uw/nu+f9xP+sk3+YrZjytkaa2DCXtZ8K/35LYqJsiNRwDMbq
 oyiC8ORCdVTA6CW+5S5j/uTbkM8zI+nCHIu7sFo5lZDGhpbe49OaYIAfd02sZzIfEJR9
 kheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711432; x=1735316232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpB4OZyWBhd1PT/tVcpqHdcUkkCs6TvRmlAnArs5Gjg=;
 b=KURqG9Rzk3VcOoxhvDBQ8WukfxeCl21o73SJLsF5671DbMCQMUanis0SX6uLxJWOQ3
 JYIIJpxZAW1jdvq/PtoeAzo1600t2exummIuiUQkfrLVmVWf1JnxVWQ406QETMsJEPTV
 q9SA3pzsR99re6rm9703JLFQH79dXmmx2EN3mOh8X/r3aSiqqgOcqUKUOZV8kmSuMJew
 BrmzSV1ZU54zXqY7XyVj8QPNMhqXZF1zXEmAdlxcUseHkzaseUF/zaenAZW5kjDfhqia
 9YFu1gtBiivASUbVCAqLR5Jr6oreDbgEy9IJXDLC8hsMHfFlShcOQrp7ODxTPYA4sXtq
 8zaA==
X-Gm-Message-State: AOJu0YxhbZL43t4/fS5pXFinMbXxlRDqzCUN2ktFGI8n56deAwpuKdyx
 utnBQ3ONExoF3CKO77cHQuFkoAnZfTpBPGNie5lsEeOtna0YM5N3zE0gySjfUlf+6ozxeZ0W6Jc
 U
X-Gm-Gg: ASbGnctUTXOxFUT22yIq4Jtvz2d0q4hxsUvslBmWQxSnKoHQlppzQjdewIdsRzMH7n4
 TO9chEYf7JjyPZ5pqM9LY9U8m+CeW2foeBnl6jB+uzON48HnS/1sNMikRDi3Ppgn66GDZpd40R/
 8hRB6mPBRxiNcamDLJWjgGSvsG5MJHnXa1seTPXBYoWo+qaCp38kZdoyDsVqMv8M/V5MCKN352r
 vlPb0ZXbSPBP9jxHekZkrEKUp25UABXw8//bYGc3P85v17oxCjkrLdKbXvJJVRAl+FCK+6jQQg=
X-Google-Smtp-Source: AGHT+IGbLCT37XmiSDwmpS4kh5LRfMRrZGHsYgWa2JJmXkmkLupQKcfhEXxdrag0nASXhymdnViFzg==
X-Received: by 2002:a5d:6c61:0:b0:385:fc70:80e with SMTP id
 ffacd0b85a97d-38a221ed282mr3874138f8f.3.1734711432102; 
 Fri, 20 Dec 2024 08:17:12 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661200abesm49520575e9.18.2024.12.20.08.17.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/59] exec/cpu-defs: Remove unnecessary headers
Date: Fri, 20 Dec 2024 17:15:08 +0100
Message-ID: <20241220161551.89317-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

"exec/cpu-defs.h" should be kept as minimal as possible;
besides these includes don't seem necessary. Remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-3-philmd@linaro.org>
---
 include/exec/cpu-defs.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0dbef3010cb..ae18398fa99 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -23,14 +23,6 @@
 #error cpu.h included from common code
 #endif
 
-#include "qemu/host-utils.h"
-#include "qemu/thread.h"
-#ifndef CONFIG_USER_ONLY
-#include "exec/hwaddr.h"
-#endif
-#include "exec/memattrs.h"
-#include "hw/core/cpu.h"
-
 #include "cpu-param.h"
 
 #ifndef TARGET_LONG_BITS
-- 
2.47.1


