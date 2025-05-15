Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673D6C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVn3-0004Qp-54; Thu, 15 May 2025 06:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmz-0004PO-Dg
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmx-00088z-Ls
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5736765e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304766; x=1747909566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CHj4ncL69V76HEaBcKrQS1jymf4RbpKZzaXqYG1J/L0=;
 b=sa4+g99pNfNulT0kf0qXHGo9jEI4FFqOWDogj5PLmB/fBg67CAGM56HrfJQ82+LQAI
 5hISOTYxxLf594coy/SCQk52cJuKNIV5NqvAac39bT8FMAT8Zl8cnBwCgqlar7JqdZpU
 dqvuvp8gAlVkVaxd16vaBzDZBhUYWbfpCpjh99nVGFxYbr3NRXnX3Jh9XUh8JxB7ODb8
 CbmZmdlZCV3jksqfIV5X4kemq6zBRmqoSrhk4BHQPedRbFzdUNFGtrRglWhgVChlJ6Ir
 taisAIIHWZggPifweUFXg0JtKXJ+A58ZtNVcAq+6llyWlU4FtauAAz7SEbuFQb7IV6ts
 Dang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304766; x=1747909566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHj4ncL69V76HEaBcKrQS1jymf4RbpKZzaXqYG1J/L0=;
 b=KMlLweh1zrvoQukdvrLzkF+PK1harDAfeuruLEad0JB0tbcx8d9wjHQgZmR9XujFGE
 B58kQxyR4c36QOp4/kKf0CDQmmHV6+HxkO4ZS8Nqz7QGTThGOQBfmBeHGJhsnY+QtaHj
 u3P4B5yOQIey4StXal/I9SoVpef9t7n7lpZ5tSDf2XznVxU4ItgeZJ1PGwCscU5Spmn9
 DTeOh+Fo0zf2ricJ+7mwWG3CLsaCMhkP7QndWqu2JYJxChbUb0G6jBnmsSvNQSXU3yW5
 zNSXABafFN3qUmQCs6oGa6mJwjZ4bNriUaqxA3e8g7n4xI4lzWJ6Cm3eGi+JYZVB1BiP
 Za1A==
X-Gm-Message-State: AOJu0Ywp4y3YjR0f1fPPC8RkH4JYhmxf5Nzy3EiAsCjSoi8DjrD6VVae
 0TkjAtQJgTeoaA+J9Kzoszj1Q4s57DM666VbS00GJk2CJOCVs1hqZqPDvn+livTkQxtY1yMTBoU
 KyX0=
X-Gm-Gg: ASbGnctjCAt+51c/9G8gvHQP3FFDxrX/A3m1FRhtRQl+4aKoCE3+dFqV6BrE3Tk3UsU
 /R0YPHrY9oQ7Ts3ZYuoJd7NrcdqPttqkv3LCWd0qxkhZQa21RGZn84PJceY7KJR9XiU2vZRVihM
 BxAqDPw/prvw+yfzYu8UdHiUlQSDCK1XN8kscOuBjzdAMQJeNtlYB2VtI9kjg9f6TsL17gm5zDq
 guBpkD1x2gCa/Q7gerBNJTok9dSLc6DazyGd4Do6wWmtwv/s15oWebEeW36TJfOI9O6+CH0Klt0
 PB7bTHWM21+BjN7lPXUfvtsL+GEIMI6EGG+wcFBqfxNeasIfdLc2o4wBjg==
X-Google-Smtp-Source: AGHT+IFhixVYU5SXiN77Kra6hjlMgjK5J2IfDQREnMDt//frICiUxt8kXVNWpB5XyO8CqcyQfeHa+Q==
X-Received: by 2002:a05:6000:250a:b0:3a0:6f92:ef7c with SMTP id
 ffacd0b85a97d-3a35373a1ddmr1718079f8f.17.1747304766141; 
 Thu, 15 May 2025 03:26:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/58] include/system/hvf: missing vaddr include
Date: Thu, 15 May 2025 11:25:00 +0100
Message-ID: <20250515102546.2149601-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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
Message-id: 20250512180502.2395029-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 7b45a2e1988..a9a502f0c8f 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -17,6 +17,7 @@
 #include "qemu/queue.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_HVF
-- 
2.43.0


