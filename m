Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216A9C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdt-00020J-OU; Fri, 17 Jan 2025 08:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000x3-HD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002Cn-9o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so360725066b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121380; x=1737726180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTfYyauxFj85w9TzqXO1KGgQnkDy6owgJRE7biN3a3w=;
 b=xidxAFHWp4qPn3kKJJ9H8zTtzNfaCibSiZDV2Spp6VvynrkAkCVQwHDOGUQfBP04a2
 gHhNiw2xVnV+9oTQt269rJkmAaGm3TQEc1370ABcncTKiecV0WD4Z76qwVc/VRvpdPd8
 xZpWCsVg309/h9woD+2GYRHkgbwEef5ZtKE7NNYHBzSgiXvDHz/z4ccUBhsgxJ1FNVAb
 jXrC+9M9V2QQCqpod2LgOtTD/K6NbxOzRJgu5IZ5nOPj2WkVd+DBU4VKUqL/l9SQBK1h
 px2F0JjgrNOX+6dHb2Mxi1D+ujXM9bUP1Brwk/EfNsJYvXTxuvIh0EBNiSPPiF9O3K09
 4oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121380; x=1737726180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTfYyauxFj85w9TzqXO1KGgQnkDy6owgJRE7biN3a3w=;
 b=jVM2CZ8h/jnYPct/80YyYzuzZ9PGxIa15QZ34KC4r6AGxUYapfSB7LGTleleFAU9Sx
 55aRnF1FhjJULnktZpW8nGgmYnZsEB7QZg37a7xMAxVcpD8dPi3njTHZlLGlvGx3DGef
 SC02o7FSkkuXWCYQo9czMuTd1XFgGSUWuJevKC/kuLhlLNyGv7DylASYxVvV9BysVXn1
 WCClVE+6n1x11T5jBo3lX5OzuVY4ulCdNbX5zM7WwJjU6tMmQJ1AKAVBR8I/v+j8b1Or
 8E3R3d1Mk31o6yoYm0M0/kHxSd3E7Eb/WWmP3CYTTU43sUQG/uKybxH2cJfMG2j6Yh76
 KFug==
X-Gm-Message-State: AOJu0YyE0bJny4kxb68dpuxRfQkstxMV8Z1tQRa+XBL4dB56BVcvAv6M
 mwhQt3QdeCa03V2wM037iFItOB/pBxYCRjLvshXIFz+xxPoY2mbxkOG7YaO6TGblqnNRKzKSxtA
 /dKY=
X-Gm-Gg: ASbGncuozYUhgs4xuvX8aMvQ0xJtFi10LWOVnme9mUkZaukBzXNdztHHhruSsneU3YH
 ALyNsSbdCrnOx7iOWHLXx18zy9LXhw8pz744H2oMd3j4zC5DNFPKXVMPB73+HQKnwH+flXnpZ9t
 LiL349+xCijkAnmdawPBObUs21Q0yIlwkIZ8nkmSVSZDsyAhMLw3RSmTRk4gLC/L8qMoPJjw3Rn
 1nrNyqoYLJxtnYpc9neJD8WoqlCwQ+v4yz0RbmNOJRyJcK+BYIqCbk=
X-Google-Smtp-Source: AGHT+IFz+MtmXeku5YX7QOsECtVBmZlr1xuJGQx1B06fQ0GY2vyHQP8EbjHv/V1DtfVUtQy0vfZQYA==
X-Received: by 2002:a17:907:1b15:b0:aae:b259:ef5e with SMTP id
 a640c23a62f3a-ab38aedb10amr290897166b.0.1737121380098; 
 Fri, 17 Jan 2025 05:43:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fc35ffsm170338066b.160.2025.01.17.05.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E49260866;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/37] semihosting/console: Avoid including 'cpu.h'
Date: Fri, 17 Jan 2025 13:42:25 +0000
Message-Id: <20250117134256.2079356-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The CPUState structure is declared in "hw/core/cpu.h",
the EXCP_HALTED definition in "exec/cpu-common.h".
Both headers are indirectly include by "cpu.h". In
order to remove "cpu.h" from "semihosting/console.h",
explicitly include them in console.c, otherwise we'd
get:

  ../semihosting/console.c:88:11: error: incomplete definition of type 'struct CPUState'
     88 |         cs->exception_index = EXCP_HALTED;
        |         ~~^
  ../semihosting/console.c:88:31: error: use of undeclared identifier 'EXCP_HALTED'
     88 |         cs->exception_index = EXCP_HALTED;
        |                               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-5-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-7-alex.bennee@linaro.org>

diff --git a/include/semihosting/console.h b/include/semihosting/console.h
index bd78e5f03f..1c12e178ee 100644
--- a/include/semihosting/console.h
+++ b/include/semihosting/console.h
@@ -9,8 +9,6 @@
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
 
-#include "cpu.h"
-
 /**
  * qemu_semihosting_console_read:
  * @cs: CPUState
diff --git a/semihosting/console.c b/semihosting/console.c
index 60102bbab6..c3683a1566 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -18,14 +18,15 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
+#include "hw/core/cpu.h"
 
 /* Access to this structure is protected by the BQL */
 typedef struct SemihostingConsole {
-- 
2.39.5


