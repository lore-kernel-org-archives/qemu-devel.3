Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68559C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC56t-0006AI-W3; Mon, 05 May 2025 19:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56p-00065r-Rv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56m-0003UY-JP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso3722619a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487222; x=1747092022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=y3taJfqjX66nV9p+TxTHSuF7u0EQwjPcnVFsyPl2Elv5TEV4fWv1Zbz09XsOG7eiLF
 Dzd6oF2KLD65vviJ3FLXFu44v7qLd1tGn2Xtgk9NmKjb7hY1vF+aoAM84Caar8t8x0QO
 1k+3aL4NIZGEIpZRryFY91hKO0d02i+ypbv02/0eoJmkhuCMAFBpI71nEtZN//R/Iqfc
 XlDBXbFim0nonjslPm/gGxzhz6oy8ArWo9vm1ec1GNgX7HTjAib46fXA4ykqoSDdQ2ju
 eWiXeQOLabn4HZ4To6jru35oBGOWsu3UXtC211j0KBHYHpxWJkItSABBZkfKkjxDxX1I
 kL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487222; x=1747092022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFP3MpqDIAT/Xkpc6JOppR3V5lexoIXt45Qw9vGPUlk=;
 b=J6aqdHbjuovjlK85mcOd8dM7SxQOpIiZdEUccoRK0qcr0Cjgci9jcK/nJ0sAEWFf64
 0GzwzmiwPE9RoH597SUjIjPX56btUzuzEo9ehKd5ifkSugM+tBTE+BywX8ORdT+9flWS
 BwtcOOAgDM5Atr/6J1AWzw4DWhhpzZ+GIgWbaOyR9HcTdp+c9Vkr/CAy9sw7w/s8vRVH
 vGcSTC7/xj0lLRuINtgXhH83r7Y2hhUSiG298Li5rGOy9NCZ7cjUnf0gmOAKTxfLGyJ+
 BqW1lsF35eghrS4iKZQ4Ms21hhKTFqw9ineB/M9MTUvGqdwpWBgBam65r53jJVM8fQJ0
 JcEA==
X-Gm-Message-State: AOJu0Ywnb+eDO/Fc8YabWD9JKur6eYceWf4VytAIfkLsXBZqlVn1TkP5
 aHK3smUyx0KONhXdzGg5XnYytiSqo34lh8M0wNzlEIEzP8NxO9f7ni7h2ONEY1T+3UHisw0GU1y
 Sd+c=
X-Gm-Gg: ASbGnct+RKDvG3chsuNZnKiXlh+2xZ/h+sZqUSsUECXP01FIGOESmhYX2WFkLFBT4NE
 xQ/733JKWPjJN/w+AiHGF6rAWxym6Wu63BTUvG+gB6NMaEomMFPc8tJthw5RH1qnnVP7/LvJhg2
 Ir/nJBRFKubyHmlrIvFfETEK/Gp50baskH5G2wVPIw0a/nlyEmngBsjlnmCjpDho4oqbAkyHqHC
 sXY02siBbQyqyjuW8nTlt+0ScWqrTm0YiaqqF2TYtJnNritKsWY2w9F7/esJq9D/mDbfBkRW/Eu
 t890J8Q151Fw3mPyO2PW/CAR9AvxfN4DXSu5LjXs
X-Google-Smtp-Source: AGHT+IEkGA7F23dh8r0tL3IOEwmD1EC+JY8O4ZS7CbJfLPw/hDppOvggFCwGVG9SRLWdvxy/22v8Xg==
X-Received: by 2002:a17:902:ce12:b0:224:2717:7992 with SMTP id
 d9443c01a7336-22e1eae4d3emr132746025ad.33.1746487222470; 
 Mon, 05 May 2025 16:20:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 02/50] include/system/hvf: missing vaddr include
Date: Mon,  5 May 2025 16:19:27 -0700
Message-ID: <20250505232015.130990-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


