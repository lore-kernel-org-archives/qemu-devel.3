Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9CBC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYUS-0008AJ-TC; Thu, 01 May 2025 14:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAYTz-000876-1J
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:18:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAYTx-0004dy-9L
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:18:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so5932225e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746123479; x=1746728279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oLJp1VGUgseMOfWdqMfmIGLYH+UOm2pR1gccOnFGVyo=;
 b=bJtLllJzBSfcSKwKHjiMnnRFpHc+ll1ZYTbASSFQwc0nqTfZqpHCUWrNQBAMnPMikr
 lJH0Zi1ISWaAhpChdUvw9cZmwxn4ag2HbxtVWdEDVoyReWe5iZpcdjkxGlO1xqIt6yo3
 r1CAkaz07T5QK6Qy32RzSMEN0zy0Y99SUdGwvDD25L8I732jqJsoQZhrZ8ZcwIu6GgIy
 UpkjwBpVANSp6sBXdN8KVVGuHBE9OJs+vxu8QvTNmYYgk+DyDLXrWSc4DwlLqGAFy3bS
 XFZmHeLOoJThKdUeeRKuDwGQHB9EeShpDWWu+dpM8fhZbcPLhIAP1LkbUkZQ5A0wl5rB
 L8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746123479; x=1746728279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLJp1VGUgseMOfWdqMfmIGLYH+UOm2pR1gccOnFGVyo=;
 b=pzmJZk3bxo79z/AHrI7EadS7tsVKw7Xo27Q11UsCzkn4Czx+nB3mQ0FwIF9bnPlSWq
 OmuGIZf0Lou+MNRCVmjkoVZ8lCreDVEHXC5d9GXjsNAg7DRrRpgcFLu+gOavaYt4zTIH
 VY6fvOH/+CIrQf8dkMHDLwIc9Rd2Qn7/JzDVbQg/taoDl2CMPpf+4kw7ue56tGCsROrS
 E5+m8QVw5mkBNDish2YRPMMcFCID9HXacYNE1OYC2MytQ0pfnw4thnP4KGB9wao2eSWH
 LeiYTjeK7CAcF5OxabbM9JeBSguJ4AXrXWgFG0ZXOVf5Yp3Z7mbqJBfKW65zXyVavurN
 AYgg==
X-Gm-Message-State: AOJu0YzPFUMlqJeCJSXJqW2G9miceqzt6VLOkp52eIyh9acWeuKogOsR
 nXsQlYBobAF5VlDJTzyAKuID+vLL/kaLBO4T31brz0fglsRtAtUJ6NZ+mgk4zPY=
X-Gm-Gg: ASbGncvSQff41ZwfVKfl2k8//1wXN6iS1DT5jRxN94X3diCegqRcY4RJ4OZG145c82c
 CADh9ycgrJZCIxmYJOpHRjS8Qqjq+v8KmXOfF7UFJ0/RI61reTUDmXfkeanMt7EbOX5XB9Qwfn6
 kHK9ZjGsCGqd1+vKgufuBc/vuVEcj0Z8FTfyGXsT0RMTsvRWHzDOX1McLIkX4RlBq92Jys3Sm7R
 iotbADCfAcwWKi1Gk6e8RczV6VtQZns7qpyDTYfJV5IRCeTSU/RDvfPvPEJclngJGlmzNOoEFuA
 Ef1vIu9cuPiX6fZNpklJbLbed1SV/VRKaHtIvVDQ/kIlQClzEBGpCj7kMzKbQwm84wk1bx/zOPz
 Cg4AIlDKTWa1RosDhdMZ8xJWamfpfulMud8hNa36gFqaExw==
X-Google-Smtp-Source: AGHT+IFaNcQJZrNNg+2lfIOXRfIi90SHvsGL+rz8S2mGWWIUlOdyUvHcBF7T5fpZ+ynHA/M2wdLOUA==
X-Received: by 2002:a05:600c:3482:b0:43d:7413:cb3f with SMTP id
 5b1f17b1804b1-441b64eda90mr35387465e9.5.1746123478916; 
 Thu, 01 May 2025 11:17:58 -0700 (PDT)
Received: from outlast.lan (97e5422b.skybroadband.com. [151.229.66.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20a57sm65423865e9.26.2025.05.01.11.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 11:17:58 -0700 (PDT)
From: WorksButNotTested <jonwilson030981@googlemail.com>
X-Google-Original-From: WorksButNotTested
 <62701594+WorksButNotTested@users.noreply.github.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
Subject: [PATCH] Support madvise(MADV_DONTDUMP) when creating core dumps for
 qemu-user
Date: Thu,  1 May 2025 19:17:58 +0100
Message-ID: <20250501181758.1057834-1-62701594+WorksButNotTested@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

---
 include/exec/page-protection.h | 6 ++++++
 linux-user/elfload.c           | 4 ++++
 linux-user/mmap.c              | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c43231af8b..f8826d917e 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,4 +38,10 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+/*
+ * For linux-user, indicates that the page should not be included in a core 
+ * dump.
+ */
+#define PAGE_DONTDUMP   0x1000
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fbfdec2f17..41c46da055 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start, target_ulong end,
         return 0;
     }
 
+    if (flags & PAGE_DONTDUMP) {
+        return 0;
+    }
+
     /*
      * Usually we don't dump executable pages as they contain
      * non-writable code that debugger can read directly from
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f88a80c31e..62fc8ac921 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1247,6 +1247,11 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_DONTDUMP:
+        if (len > 0) {
+            page_set_flags(start, start + len - 1, PAGE_DONTDUMP);
+        }
+        break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-- 
2.43.0


