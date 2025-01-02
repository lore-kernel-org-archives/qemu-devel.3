Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D33E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPt2-0007yJ-Fx; Thu, 02 Jan 2025 13:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPt0-0007s2-42
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:34 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPsx-0007sp-KH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:33 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so8276227f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735842329; x=1736447129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwDRyvTJZzNpnWnwx0B7XY3O+69910db4I16wox7BzU=;
 b=SlCsZmY5M42hv5Eg1fcSU//IgdsdQSAybBYIMX+O1oqIBOY/3eWeXHBtKJOIHG5YkJ
 UuoSoXGpdrgLasQsu1WQjAFEHRx6JYj0HmIJW0pJrIYoKovOwcg9+RaYKz/6/uNDjKnp
 Yeuo+igp4amaFoxj+60ZYx1hH7tNpXs0UwFI7yujm4sK9L0KWH4ZYeuPFOT1dMXwogs3
 ZUqFIA+m6xVNNCZnNZ4EPW6B+DxWHhvEj1debyWeptyzD8+PttwkBzdadSlbzP01amgD
 ENRQ0xb/tE2lexx+uZ1YINdQJHy2U98lkh5c/KChOSifjpNHaTJ9rUiCLirtidLxzauI
 1Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735842329; x=1736447129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwDRyvTJZzNpnWnwx0B7XY3O+69910db4I16wox7BzU=;
 b=osCvLFJ2rhUyveXfvow7LoHeR72w859kUAGThhuKVVM4HdW8Zeiy5c0LCunognR9XJ
 vFjytDE4N1utvh6R/AJENCWyWE6CoOWdMf86ZWyOFroHi5cYb8RwlyS6CFKRbRpVpLsx
 9uoCHv56+iXUJ/LjpZJp16GHImIz9JayeCO0bzmKKFaTDeyHfAPvelARUtfjbJ1QBDMX
 kXw15dIPldvaUJFVP64smYe6kHUTGGUSPzdcz3dZCHfvTMQ+2VOcMgtJHdfU5cU30qzM
 2Afm02YCd8qpx4aX/W4TeugV7YXV3QVcXZx48+JaFud4HcZDoO27x0v1DBQYjidAV0sC
 RV+w==
X-Gm-Message-State: AOJu0Yz7/fuVtUiA64wsX07BfiY3nFVr6wkcd3arpV4Fksr8tCRgwhIC
 bj9kWJq8ghRy9Sw2xrHMRalXPjQWTirPNIIj9sNrAJZeu/cgBYlpH0WanvZcPhx2A85Lu9CHSEq
 1CbSQSw==
X-Gm-Gg: ASbGncsJA+vp+6zmQUp0VEPrp9Xxri+rajrXQ6gphbC52gWwH37olX+t6U2yIDnwrSZ
 +2Mjlhv+S8ul7c6S61I5eRZxU5YFGLBRDua6cfCvCtwrXlajpQwgYWY0FYA6iCwPU9LX35ptrJP
 Dvna6v3KuBGRkxOQ0N/1k73kwP2OPpJYyyZ47wupBU5o7ZPdDt2b9mn1eKvzw5ZrkwUrv9U97gP
 ZFsq1HXucXx+9rU9E9GzoeMHr0+YZRfnDtYxCw+Jso3aJdzedhW6uUG90d6CeZuCgfVSYCjSNst
 3RcK2Y6X3SdO/m6trhPWrYJU/lpWNWc=
X-Google-Smtp-Source: AGHT+IEs2dh5EalLyOVlh1d+Em48iLhVk267HSINaUMWvVZzuLL5VmBAsRtby4EOJ/JHKZSbbvqbRQ==
X-Received: by 2002:a05:6000:704:b0:385:e9ba:acda with SMTP id
 ffacd0b85a97d-38a221e2738mr36306420f8f.2.1735842328903; 
 Thu, 02 Jan 2025 10:25:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366e210cecsm424125855e9.2.2025.01.02.10.25.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 10:25:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] linux-user: Only include 'exec/tb-flush.h' header when
 necessary
Date: Thu,  2 Jan 2025 19:25:19 +0100
Message-ID: <20250102182521.65428-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102182521.65428-1-philmd@linaro.org>
References: <20250102182521.65428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Very few source files require to access "exec/tb-flush.h"
declarations, and except a pair, they all include it
explicitly. No need to overload the generic "user-internals.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/user-internals.h | 1 -
 linux-user/mmap.c           | 1 +
 linux-user/syscall.c        | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index b9b05c1d11f..4aa253b5663 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -20,7 +20,6 @@
 
 #include "user/thunk.h"
 #include "exec/exec-all.h"
-#include "exec/tb-flush.h"
 #include "qemu/log.h"
 
 extern char *exec_path;
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6828b17a63f..d1f36e6f16b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
+#include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "qemu.h"
 #include "user/page-protection.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78c7c0b34ef..cbbfcf10d28 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -26,6 +26,7 @@
 #include "tcg/startup.h"
 #include "target_mman.h"
 #include "exec/page-protection.h"
+#include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include <elf.h>
 #include <endian.h>
-- 
2.47.1


