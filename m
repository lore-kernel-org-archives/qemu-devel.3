Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B315C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79S9-0004rf-9k; Wed, 15 May 2024 03:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79S0-0004eO-TB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:24 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rw-0001kl-IX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:22 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51ef64d051bso7635232e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759599; x=1716364399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjyMRvjnIaY+m73p3izMShXRE/INt2PJeY5RjBYNjA4=;
 b=mwkZkJ1Is7ordOGTJs9GTt3CSKhggvUCxWl2qdS5CRKaYJj4gi7lszzoWxUgq5YIOt
 yu5NK3su8cT8VilFhYxFp5/+wCeGDvzEqrWC9vH1jrmJxOtXeaZqKw1Qv7t9wEvuFh1d
 VoMpk3tZiqUiEJudVXcwDewt1p+xWz7GtW20zVfxBLOZPonjz+e3H8b4xEb+T+XZO5cH
 ZuK2+eYghdBfmljKl38bhpskohGWP1R3AqWIrDH/BcCZxQES3+Ki2rfnOeZm7q56i0eA
 NY33d/xhS+u7I0W9uN3xWDBi/wI57B5rImWFDXyKhlNvuzl8iMpDVIuX5Ce9kK9XxAZV
 xpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759599; x=1716364399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjyMRvjnIaY+m73p3izMShXRE/INt2PJeY5RjBYNjA4=;
 b=WjbtRLuX+aR6X3Xo62Fjh0bFhfqNw8ZBylhCbUxkJ/GiAGQ8HzRKhQtlEmlJwQ1bgP
 ONQ4L7Go5oQlxE5yvEliK2dTn24HkWJSTA8asinyOAS/SU4XBqLwlkzFwnXv3M/Y46Fd
 oZNnud9B6gA1T/vHaeVJfjUONysh75mTjxYXI7DzVdjoAs4ATxCmzZetPmVj44wuu+YR
 M06GG+sASSEsCqUeZ9n4MMmWHDDzHB9WPNCLs2DhYKfDfgFIA60bHU1h2JDbOcV9pdlf
 tJb3fRfVt/kbuEVMvadPvSHpQzlJ76nPlITe9Tmsb2ZOQEVDlMmJc+3PzrpvFVmPTbUP
 KC9g==
X-Gm-Message-State: AOJu0Yy1OUxaD0Knh5S0uxcpmjPA7NaTyOjbUfbERmEdK12skj6dfKrZ
 WwFyCTl3OpYhApU0DLdfwCcDhkAxcIAtQggGqYvey9fIqP1TOTdNRDd6aCVYzwo8pJC/4gBzBvf
 JCvk=
X-Google-Smtp-Source: AGHT+IGWd5DiXNIzD2An7mlb3hVLEPP7xH8/7s50yGf7sxaWHk0Iqj8JOir3lCjNDHWKtTahQSyCfw==
X-Received: by 2002:a05:6512:3b86:b0:51f:3f6c:7466 with SMTP id
 2adb3069b0e04-5220fe79356mr12985913e87.48.1715759589724; 
 Wed, 15 May 2024 00:53:09 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/34] target/s390x: Use translator_lduw in get_next_pc
Date: Wed, 15 May 2024 09:52:45 +0200
Message-Id: <20240515075247.68024-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bac033c63c..ebd96abe6c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -36,7 +36,6 @@
 #include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 
@@ -6471,7 +6470,7 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
                                 uint64_t pc)
 {
-    uint64_t insn = cpu_lduw_code(env, pc);
+    uint64_t insn = translator_lduw(env, &s->base, pc);
 
     return pc + get_ilen((insn >> 8) & 0xff);
 }
-- 
2.34.1


