Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456D2EC113C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyx-0006cT-Va; Mon, 23 Feb 2026 15:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyv-0006bU-Sd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:41 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyu-00081t-7q
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:41 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso4542579a34.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880199; x=1772484999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05BLbE1y2qcTIXCrfk6WLG4//N7sVc0Cn/mxSAr9j2s=;
 b=AZiyJaQadNmN/jBxpY+emCjOMP3KX/v0Cz2SgY0O4lfxyq6lAq7Fl8wYM6spJ3Qpdq
 ViGoOZ69DBu8KbiHWLyIuGI+IV+RvJt/vrjlqFNW0UZi+12+t4P7/EThezF0lYgoCqiR
 L39U0VUjFIG+GK/WIPoa0mBJaWGrnp7CqEcxtSeQF5Ksh4uWo7NbwzNVeR30+0bW3DoO
 3blztA1EcjBXbDBOBWXKuRspSUoc2tpnYWhFvyW3kASGrf5KLFIzZiUPtvUAG/byTyX7
 KZgyDy5OzpjaW7sqIfBw6b6XNn1DbfUJ181JuxZLbdgm8tCD279hSL+KD9L1ggTxU0Hq
 esBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880199; x=1772484999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=05BLbE1y2qcTIXCrfk6WLG4//N7sVc0Cn/mxSAr9j2s=;
 b=guyLF7DW37+UQwjJZePt2FyO0R9pHYlOVF92UOV1IJ/0SD55JuTcVFRxogE73GAAV1
 m5K0usdEya9YbJV73ZoAXuqtHHVQ3qG5OhnDqzgdpjnTndBYfDGL/zehG/C3Iifchep+
 QkdE/bQcXLg1a4S5jhkz8NeXSYB3EG403yIEuxFhlrXvEVu/cBdKM++s2yBL5jBqaL3Z
 O/gHunBULs1fIm3bslmxA1age8XBcnTgMa5wNxecQZ6kmjYYKoz0oRPa2mr2f+JfqIsx
 LqrQ9DPHTNTbukRR9PxqGMggrZM+cGPm8HOqIknd67/1OfHCY3O7UZz08cNdZv5Ya+z1
 Xaug==
X-Gm-Message-State: AOJu0Yxx6N6HjBzvJZwz+/YDuFKHGFIkbwKD8JQcwqM0UQsAiyutNeBY
 EzGZ7cAKCYNlblMp1oSquhf9m81DIgTeOKZrPHxrSU9AOZ1DDqBgoVATSauDWQ==
X-Gm-Gg: AZuq6aIjYGfC5G1OG7zuIRqHNze2T5+i42+z2pcOqqmY6vEoJ57GP/2MJK3PFYdl7Ar
 47QMtEZ1dpjcYMGZe85v+a45Hk++4JulfSV1cwIRu60b5WgTJbC1qx6V6Rg/mcA3fGhovL8iVd0
 mQeChiaDRccQ8hrbC/w4B1CXoKjH/uy5hQsKj9neUj6zQe+M4fUdaKZTXK9Er3G/j7kA02wEUMI
 PNX7TZuBXzEXB5I5YTbLa6QUdx5BzVefFas15/dTDucnZDrYjWbN3852PCq3K2rKj67TG7d8sUb
 bHRPoIyNUHJAVsu/mIZVoDMj3/Xpu76seCXoqAnPc7pBYhDFTVahtPI1xgEzLI4oAUF4JqUgqbS
 P+sSRGEyKcpwwSSZlyiCl6BkEHXrrFcAHfIj8tqQ7w1SUoAcbE4GEQ/WsGBz+yoDZfTn+Brj+Oy
 sMrgQ4LoRgBLisF15ktg5/xoEKCPLkYpir4DRlK8YSX875rgclk7K5YVqH+iWnT/scpPQEehhBq
 DJ9ohqUpDxQfylRyrNNg1cS6Yce+IPNKiqgwQ==
X-Received: by 2002:a05:6830:850e:10b0:7d4:96c3:3f97 with SMTP id
 46e09a7af769-7d52bdf88a0mr4537396a34.2.1771880198887; 
 Mon, 23 Feb 2026 12:56:38 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:38 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 5/8] Hexagon (tests/tcg/hexagon) Add tests for vreg multiple
 writes
Date: Mon, 23 Feb 2026 13:56:29 -0700
Message-ID: <20260223205632.223714-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 46 +++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target   |  1 +
 2 files changed, 47 insertions(+)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index 4305903547..b93f2ab32e 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -199,6 +199,49 @@ static int test_post_increment3(void)
     return sig;
 }
 
+static int test_vreg_legal_predicated(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "r2 = #7\n"
+        "r3 = #13\n"
+        "p0 = cmp.eq(r2, r3)\n"
+        "{\n"
+        "    if (p0) v0 = v1\n"
+        "    if (!p0) v0 = v2\n"
+        "}\n"
+        "1:\n"
+        "%0 = #23\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r2", "r3", "p0", "v0", "v1", "memory");
+
+    return sig;
+}
+
+static int test_vreg_illegal(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x1e0361e0    /* { v0 = v1 */\n"
+        ".word 0x1e03e2e0    /*   v0 = v2  } */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -224,6 +267,9 @@ int main()
     assert(test_post_increment2() == SIGILL);
     assert(test_post_increment3() == SIGILL);
 
+    assert(test_vreg_legal_predicated() == 23);
+    assert(test_vreg_illegal() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f86f02bb31..ea73413bf4 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -118,6 +118,7 @@ vector_add_int: CFLAGS += -mhvx -fvectorize
 hvx_misc: hvx_misc.c hvx_misc.h
 hvx_misc: CFLAGS += -mhvx
 hvx_histogram: CFLAGS += -mhvx -Wno-gnu-folding-constant
+multiple-writes: CFLAGS += -mhvx
 v68_hvx: v68_hvx.c hvx_misc.h v6mpy_ref.c.inc
 v68_hvx: CFLAGS += -mhvx -Wno-unused-function
 v69_hvx: v69_hvx.c hvx_misc.h
-- 
2.43.0


