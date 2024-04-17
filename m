Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59465C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2I-0002Fw-6m; Wed, 17 Apr 2024 14:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2G-00028Z-Ag
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2E-0003ZQ-Gd
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a5565291ee7so67317466b.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378568; x=1713983368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImXEe3AsI+IkHscdZF2OSgUHx6phFwxkW/+zKfz8Om4=;
 b=zmfu2R7pfQcSxIrjWzF7R2QWTHAKMiGLjY+8jg2vpo3pBA9dMGGqJ0URru0MCENtz9
 jRRcoYMaol2alNKioury7ooCpeIwwPjd7XygTzFi238wIgGi2M4faZJEU9f/GC9GpZjs
 NHTdbh3mUFMHFMAdm0IyQjeoOn7PCfqQO4R1XKWK+ZdQcqJTHhdydEGRzZEP5Tdwg3qG
 aodgnWuJdwjnzGXCaFYVgfrCyYTmNUFZcQnyd+mmL5zOFp0pgQ/jmFlW9WyubewpkRur
 KShmfvIac6rUpcvDHS6j0756/mvFumVtb3ShWuE+4pAzpHCdAd4FEhh0bzxPJopIqXyv
 8CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378568; x=1713983368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImXEe3AsI+IkHscdZF2OSgUHx6phFwxkW/+zKfz8Om4=;
 b=n+LxlhSrIw/ZZ9pY0QuwepMiZc51S8bDI9TJNKunu0VjLgEJy6a63gflP5G+XEwre/
 c192ah1DDTS1mDLQxbsZddHu2RshuiFY7oNIivgRmQSbzdksL3UUxOAWdS1JG7VeFJsY
 nL3YjV2I4KMD66wNIj39d3rCxVKjiuhBAf4B2+SjESoMyd1I1m2WLYAqdIwYYq7CjIUy
 B5u/IU9ep+2Jm1wbqz5v8TqNbXWMjPsM6cNBtsrWgquCo/9ijQVafh1pv1EEHlf8c40P
 nzGPNHulgcbsKTvzfi66iYAo//Q9YS/RDBmOQSklZ/Sj5oFBMtrVdwGY+/8X3r/6a61o
 /r/w==
X-Gm-Message-State: AOJu0YxxR1cQhNHDGoAdMoWgjSqPjFKVkZ9ntRy/bejdbcINLIePBeSe
 jYA8g8E6H7g6nrTLSVR17Dc6HsCxhBUcQcGc7EyIiBEgssdwZWwlu+LAz2lky95CMmnexywqKQx
 c
X-Google-Smtp-Source: AGHT+IHG0K9COUr5JVQZ3w1m72vU7dHPgen+/xvTwF9qhxGNBPeFrERx9+K7WteI5ZNN/BSyLOm3KA==
X-Received: by 2002:a17:906:c0d1:b0:a52:6535:d15f with SMTP id
 bn17-20020a170906c0d100b00a526535d15fmr185592ejb.61.1713378568584; 
 Wed, 17 Apr 2024 11:29:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a170906701500b00a53d6b895ddsm3527536ejj.200.2024.04.17.11.29.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/21] target/i386: Include missing 'exec/exec-all.h' header
Date: Wed, 17 Apr 2024 20:27:59 +0200
Message-ID: <20240417182806.69446-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

The XRSTOR instruction ends calling tlb_flush(), declared
in "exec/exec-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-13-philmd@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4b965a5d6c..ece22a3553 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -21,6 +21,7 @@
 #include <math.h>
 #include "cpu.h"
 #include "tcg-cpu.h"
+#include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
-- 
2.41.0


