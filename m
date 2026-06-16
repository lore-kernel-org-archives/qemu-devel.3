Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B9BCD98EC
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDa-0005Wm-4P; Tue, 16 Jun 2026 17:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDY-0005WN-Do
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:08 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDW-0007Pq-Rx
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:08 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36b8e1760ccso3142120a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644865; x=1782249665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrKBw+gE75gvuFuGfBC5I7M54VqaLBUhSrdc/f0IVLU=;
 b=MjbGKkj0s4oWUF19tg9xf+HyXwQEmD3kCxTn4utBqScvHlg+mkG/N75N+BwowdJ6bX
 51nVXaCHV8vQro5p6kPiaPqYI4J5XXtP+m7mnrlN+8q4edMTXdLxWhIlGeiba8v+uXkx
 c2YpKi58Gyqd9zfMqA7Wv7OGeiAF/i4PjAAco6UT/aQD4NN9LV6u3T1EUEWkFuym8Oxh
 qr8nmBPooV57ZZN/CFrlF5dbKqpKd4AtR43VJC1BaPsuKR5FzrIzHleMlZWJywgk2Oae
 6/NcYoS+KRqej5dF36r2AsBc4055CLbVFqEP3qAqK/braQg5uokAtj5YrEewwjHcPjBF
 t+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644865; x=1782249665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrKBw+gE75gvuFuGfBC5I7M54VqaLBUhSrdc/f0IVLU=;
 b=n2LU4qXsM4fMb222r0C8aMHEn1cCK3GixqkBag75nuC2HfXM7nMf2UGtMcAppjy43L
 HPf95WhDOBnIBLME+57jWl6ggBR6BaqQx+++5UY88oQq1sISEE1ld+U+wTDOCsjrazu8
 wLBTgij3BkEgaMHDXZNEZiD2SlLqSkkHDyUdvwtnKnrmDJ9SfIXhJZ9AfSdTgRiAb15M
 ZrlvB2bBet0CjeYaUkc9iDqkGwiTnCV5KIFuberaJpESJwpXo0r1gfpdTcIqPZ3wZwRb
 6fNkCwVfGAQL2mjEuw3qhV/xjyp4DxipZxMYvRiQJxPdCbSKFtzG23gRZ3S3CZHQ3EG7
 nS9A==
X-Gm-Message-State: AOJu0YzvD+iTU7g6OlnQGuHkAAaCl70/C6XLUf7Wl66fwoGT+OyllcPv
 pQK5HFYK7mfpzdw8U/OU9OsyEW8qdQ8TAYV86vtLAltTMfPU9ttL+QIys+7GFTdxZ3x5s/O00lD
 stPJe
X-Gm-Gg: Acq92OEKVx8p4vWUo4RLxzQQhORKPnJ8VT37bKV3SZrw4N4saMAwFuY2yvuvA+Bmg3A
 OMrFXde4PL14pr4trJtiGE3b6Ehctka2FjtF94hFXyd+ddJH9Gsw2pdxva4Lz9ARYW0H4fjp0Sj
 zOwy46r7wGQg7k0Wzdxh1iI/2AuKDvcBcZxCwZredqOa2nRCwAOfPG9f321Yw5XcoNcq0k8UJlO
 7SVY1NkdXfcy0pBt5yY02tkROfomUxKqb0Jg94sgdiSVJM7fXXmawsLmil7za//boOMP0UiYOGA
 99tEvFwtZtoobj13LWUxdJrJfL5Me9WvkSI1Q/FAspj8+2+bIrRDnbRv08Hj/cfwAkVH/wTlG29
 a7DawzuTc7tLFOdz1Dof8Cl/KD43DpNBAoN1+bwxdOdIDbjhpqyFI+iiHwSXxRW419kglfdII30
 QhABzHkHAIQjppnCMWMGWAujuR5aggDhW+ZdYcRkuvrI2mhmojgOgffzl+VIx7
X-Received: by 2002:a17:90b:5890:b0:36b:71e6:3de3 with SMTP id
 98e67ed59e1d1-37c92ea967emr1060913a91.3.1781644865361; 
 Tue, 16 Jun 2026 14:21:05 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 07/13] common-user: Initialize mmap_min_addr for FreeBSD
Date: Tue, 16 Jun 2026 14:20:48 -0700
Message-ID: <20260616212055.334466-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Use sysctl to fetch the vm layout of the current process.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 common-user/mmap-min-addr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c
index b2b3762386..830c6f66a0 100644
--- a/common-user/mmap-min-addr.c
+++ b/common-user/mmap-min-addr.c
@@ -5,6 +5,10 @@
 
 #include "qemu/osdep.h"
 #include "user/mmap-min-addr.h"
+#ifdef __FreeBSD__
+#include <sys/sysctl.h>
+#include <sys/user.h>
+#endif
 
 uintptr_t mmap_min_addr;
 
@@ -31,6 +35,15 @@ static void __attribute__((constructor)) init(void)
         fclose(fp);
     }
     mmap_min_addr = min_addr;
+#elif defined(__FreeBSD__)
+    int mib[] = { CTL_KERN, KERN_PROC, KERN_PROC_VM_LAYOUT, getpid() };
+    struct kinfo_vm_layout info;
+    size_t info_len = sizeof(info);
+
+    mmap_min_addr =
+        (sysctl(mib, ARRAY_SIZE(mib), &info, &info_len, NULL, 0) < 0
+         ? qemu_real_host_page_size()
+         : info.kvm_min_user_addr);
 #else
 # error
 #endif
-- 
2.43.0


