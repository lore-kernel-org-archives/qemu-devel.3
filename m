Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F60CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FMY-0005rT-0p; Thu, 02 Oct 2025 05:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMS-0005pN-7U
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FM3-0002Te-4P
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso4893925e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396314; x=1760001114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6pdgQHPSH9qdbjNEdRbeoehpsX1/WwswXCq6tk0mHg=;
 b=SeGeC03uWppr+6yDHKuUcxolgyy5gi9xNivGBuIhwvjBCgSwftAto0/Zsd+jBYsEIb
 SiM/oLHL65dwnaiT3jDwD/1uCvXWPgPWxddue6U7yTe0Ch709MeZrjf/3NWHmqMK3MiG
 7FeRP8MnQ323EvM/FjaNS7UmCTEM5Jw73BcE4+izSHOhOx2Vvh/ccxLVu8EjsmDW8NUB
 tpdmnaHDEu47PQ/jrKozjiaZs7VcLJXfMEONCGEsMy3Gnh3qsbz2J2WW2N2uRlSx+7jB
 /jxOzkg9XDGbSeZi6HUH+5w9Jk1rvKdB55m+0yta9Py/5JcUvf0Gz6TPvHJsjVxPSRT1
 rg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396314; x=1760001114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6pdgQHPSH9qdbjNEdRbeoehpsX1/WwswXCq6tk0mHg=;
 b=On7xwh/X7QXzaZOsUwkMOyRfT7NuU0hPseNdjgwe87rCEFBWYv9NfdgcoQRtfLi6PK
 IUvhb4i42pUal09ls6BHzaCbbhpE1HEa+ZeXxzQF+k6xMwjYBFykNyIi62oR1J5+KnOr
 IHHrWRXPtW0vA+4a5iI9wW+kxO9LPBub9at4pysR/gislxrjry6yCI+XtWsTQaa3+3pP
 4EMibe39CXtMtJiOIv6bXyJfKBS5YmudpngxK0h7vXMxwNtoaqS58dby4pBNCiFMPwsC
 a3hqZjHcAqxrSScXeE498cGvrEUANmA8BxdHs5rsDjSOOHkJtaGS5Vwx0oCHN/i4X+I7
 PbbA==
X-Gm-Message-State: AOJu0YzDEAE0gx7aNGZuyI2FEy/MPRfDjVoDDPRBhesTpP3UJrU1FBq1
 ILZcC/+yD/Kg2rUFWeR0CfMz9VmyDdEOXXB3zrVJWlrNMYRc6H0GqgJhwKfOrhTNAGDGnS+PPln
 0vMdsYWB/Xw==
X-Gm-Gg: ASbGncs+L6SnQfn6f2jpkw6VP3bTcp6aVqDHYUgzyZq3yMpeKIG/dLnsr5oZTFjcy6N
 2M4nGV+JzJX1tv7ViG6qhelsJbHOqovlYEUzaqPzZVw3WCrJukjZlc4G26EZ/lxJWxcY6DhmNhW
 Totv96ADt+e+ksv+LWsgNc6oBgpe/edREt39fTqSF/afKOC0KBngBwAPqxjrA4KZthYj3OCUA5M
 m5yMm7BJ4C07UZ5kPxnjx9eSPoY5jIESHc4be/vhf5uZIydExvnGwOeHC+mKogdryal+cYNuVCL
 P9rFRJzcpc8gNEiP+FrngPElSLpl80n6SSpzrpk0Fly5hzKBMLQJC0AiP9L8SE1RwDATOrxsMY2
 3P65pq7cPsvUlbacQtE7MDNi1JnAvTm+qqESRkPDbl4Q2NK96hBmxX7XFMUSdSgJDj2Bjy5+CS1
 dNAKl76NF0c3Ijj1Of+LyY9EVO8vpj3v/4wsK3ftiR
X-Google-Smtp-Source: AGHT+IGQQAjizCe5nQmeEQxRKbWpCa/eiBYlRv9gkFyNxktIdpLsgstXOcAiKZaoG6LVUl+H8tlC9Q==
X-Received: by 2002:a05:600c:1da3:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-46e68bba331mr21934275e9.8.1759396313736; 
 Thu, 02 Oct 2025 02:11:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm18283645e9.17.2025.10.02.02.11.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:11:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] target/s390x: Replace legacy
 cpu_physical_memory_[un]map() calls (1/3)
Date: Thu,  2 Oct 2025 11:11:27 +0200
Message-ID: <20251002091132.65703-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Replace the *_map() / *_unmap() methods in mchk_store_vregs().
No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/excp_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 4c7faeee82b..5e1d4dc9583 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -30,6 +30,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "qemu/timer.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/boards.h"
@@ -418,16 +419,18 @@ QEMU_BUILD_BUG_ON(sizeof(MchkExtSaveArea) != 1024);
 
 static int mchk_store_vregs(CPUS390XState *env, uint64_t mcesao)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = env_cpu(env)->as;
     hwaddr len = sizeof(MchkExtSaveArea);
     MchkExtSaveArea *sa;
     int i;
 
-    sa = cpu_physical_memory_map(mcesao, &len, true);
+    sa = address_space_map(as, mcesao, &len, true, attrs);
     if (!sa) {
         return -EFAULT;
     }
     if (len != sizeof(MchkExtSaveArea)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
+        address_space_unmap(as, sa, len, true, 0);
         return -EFAULT;
     }
 
@@ -436,7 +439,7 @@ static int mchk_store_vregs(CPUS390XState *env, uint64_t mcesao)
         sa->vregs[i][1] = cpu_to_be64(env->vregs[i][1]);
     }
 
-    cpu_physical_memory_unmap(sa, len, 1, len);
+    address_space_unmap(as, sa, len, true, len);
     return 0;
 }
 
-- 
2.51.0


