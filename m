Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4824FCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglO-00068D-Gz; Fri, 05 Apr 2024 06:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglL-00066c-Hm
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:35 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglJ-0004nr-T6
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:35 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-22edcfcd187so111823fac.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312733; x=1712917533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAOEMFBYb53UUAJdtrKHFH1TzVh5qJKo1U0lXRimkCs=;
 b=nwPZctgbI5gBLeeHxhrhAnfHLsQ/BjlPVZqptuCi+ixXmrYy5uN7+eVbrKK55SkISf
 yKJbMcUTL9vKe3DtY3I7s04cXktQr5ZfPOW0Oq5Q1f8kMh2B8FD8zB6gGrOygr9RumK/
 rALS3XU/lR0HKKuDjDkjjVyA52tsUlL+gBBaOPX4aKFLoGnrg8Wv0wVZwZLr3Jljfozs
 X4rFw8RQWInTMvo82xHNPJPVfUrC9d5rwIHWCppkjKYf5Bb92TIF8B844T79gXCio/4l
 k6/035JGJs/haMhhffhQMEPEljK77o+Qv7vabRgDgdyAytoElPVgCO+uSWGbRWXmI/Cw
 Eltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312733; x=1712917533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAOEMFBYb53UUAJdtrKHFH1TzVh5qJKo1U0lXRimkCs=;
 b=ZebwwOVX3E/cr9YIaLUCmUaoQRAZ6N9FFsiezROLxYRmsINw6XD9ycKEd8jIS/OBQp
 CFHq+zncYC/4jIKStUg9er76IHz1Wl3+4sAEBU0kYIqZZJoB2e8mxSaAxZee/9sIejwQ
 H1ueCZqiCS/MCXf6jw5cBct9o+3WH0k/wwrGD0hYXS8xQpbCl34dG9Me3HmbpgpFWWXJ
 hNvbaBWgVutP13Me0Jn75iCZTeOsgK6oT3QC5RiOblA4tE24MfI1fCEkL5hTZ2hdeh/L
 tPHH9W2MmOetU0vGIyUlEhxBTDJ/S889g26UXrCmwdcUacZvNogF3G4LPN+cMLb5hIwG
 utcQ==
X-Gm-Message-State: AOJu0YxNU6QLvgTn7zchFzKPYJUdJVlM/5AHTsrGUJiF9j9PDwUUcJUY
 KOgGXBBecG/bC6NX3hBez4CXROEc5N3zzJmRIXWvW8KdBR/276Ob1b03s3fJuI6vf4cBSnp0eB8
 N
X-Google-Smtp-Source: AGHT+IF5VZ5h2kIOPl3KO5AmoQt2TKAYqMZPZCUyO1T+iaYa017fQiyBMwVlLo4xHOL5xyXvMis3XA==
X-Received: by 2002:a05:6871:288b:b0:221:9157:b587 with SMTP id
 bq11-20020a056871288b00b002219157b587mr1120627oac.35.1712312732747; 
 Fri, 05 Apr 2024 03:25:32 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 24/32] target/microblaze: Use translator_ldl
Date: Fri,  5 Apr 2024 00:24:51 -1000
Message-Id: <20240405102459.462551-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index be3ff76f78..11d84bc514 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -24,7 +24,6 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 
@@ -1640,7 +1639,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = cpu_ldl_code(cpu_env(cs), dc->base.pc_next);
+    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.34.1


