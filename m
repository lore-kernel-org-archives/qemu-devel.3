Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E726CC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 06:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAjw5-0003zv-0V; Fri, 02 May 2025 02:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAjw2-0003u5-OI
 for qemu-devel@nongnu.org; Fri, 02 May 2025 02:31:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAjvz-00065y-Rp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 02:31:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so9484345e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 23:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746167501; x=1746772301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r9inCl48n/FEUF/d0F8bp05qecaBbZEla9jkg9JMco4=;
 b=lSFRk+TvHT6W3dlHitSyVfHF+FddHNbANhl+OF50fNxt0+nAQFCDiKSkhMXQ4KKJNV
 1/ZPt0MJdF6XjJeEwLMhGjmWLfak6mnNMufF/VPkIedWvaOPX7zxMlV06n5DqAufISg8
 WSU3KIIZDRvbGuNkWF6KMQBNuza7Dg1c0KfqJmZdeuL+xcOQWbzqQYtw6FtzGKLQwQZ4
 X+VFDXVPLIavQgD7fav/LNbn+ZNbSkg1SliiWY9vnZhmFee9xHChgMDUk82vuB7Ne0rv
 7pOxHMgQIXk/hM+criXXDp+ywgCos+fTfpnJ1EBvCs+CmZ0RhWlSgp7+lhERmRFNisM+
 sgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746167501; x=1746772301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r9inCl48n/FEUF/d0F8bp05qecaBbZEla9jkg9JMco4=;
 b=OeaXefx9xAAFXWdnTNHS5pQ2gxge+C7ILyCD8mEVN46q3FeMFH0nrxaDasDibUj6Q+
 38GXSjYbX+w5ETo6Xr6/ahIQ8VjIb54J2V5yVxU0TM9NPXZ4ehQPS0IJxG2qC32cIAQB
 xWFmjvyxCYEk7FZfpvfxpC/f+RnMO3ieus0c2HI8i/LaCcDfiBpde3Wos9JF0MCf2MY5
 gvs6MsM91geVLEwNicI64FwZ4rN2uwF9S+Q4E3BOKuqtPO8GC47Ls0KXDkbG7uAlu5KV
 GtZQo/iXLlwB6vHrWEhZ7d/fWmyxVxnZeF6p7mTNmBON5M2djSOVa+NujsRQjgkAvk0U
 QSPQ==
X-Gm-Message-State: AOJu0YyAeAvV7eEvU+bEGYL/9iycleUfhEmbaDuIxQvkrEDIhNCZKOHQ
 VzqSqrlK0yzaVcn/E5ZUPlE8MbX/p0lCcCKjs3zhz0iJeTeZJm4WWqrIz/mf1YY=
X-Gm-Gg: ASbGnctUwcdANHXuW+FHKpoIrM04kW4/TmDeJ1grlNF9w7pl1xzpqjBoa7xc0s3Yjlm
 l5lX742qLtHEeFSrjHUEGrAxM38PbSuhxQBNEjHelkhX8P+Ui/8m6BwXkjPTejcQ0scfADsmcD4
 /WznE86kCxj954gZJPoIq/efcQud4T5QmfUG3+CF/BY6UDwLcllMeaFt15lK3qjfYJjnVim5l6e
 3RFWHo7YsEEGML4JrDJULALJrsZVYsWe0tAqiCBv3izbtkwY/2fdOrrwjir4Nw/GV8og8l2xzZs
 92L3gs5VCRkjznOdbHizpxYKWgZVWcM3PdlNM5EUxlTKt5lNoKr0mWVL2osx+jz8Kvl2tdXfTqd
 ZiHBDFqwOrzAlWJVuhOJmQqMla6YmSsEUo1Y=
X-Google-Smtp-Source: AGHT+IFetOIxjtohMyFBIhkkrElFUPug/X18R8L60ByKurSTPsZFNLJugb+0G8901KQO1uGeJX7QFw==
X-Received: by 2002:a05:6000:1843:b0:3a0:8c3d:d7ed with SMTP id
 ffacd0b85a97d-3a099adcf68mr880319f8f.30.1746167500833; 
 Thu, 01 May 2025 23:31:40 -0700 (PDT)
Received: from outlast.lan (97e5422b.skybroadband.com. [151.229.66.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315fdsm33495825e9.34.2025.05.01.23.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 23:31:40 -0700 (PDT)
From: WorksButNotTested <jonwilson030981@googlemail.com>
X-Google-Original-From: WorksButNotTested
 <62701594+WorksButNotTested@users.noreply.github.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
Subject: [PATCH v2] Support madvise(MADV_DONTDUMP) when creating core dumps
 for qemu-user
Date: Fri,  2 May 2025 07:31:40 +0100
Message-ID: <20250502063140.1098807-1-62701594+WorksButNotTested@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x32f.google.com
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

When running applications which make large (sparsely populated) address ranges
(e.g. when using address sanitizer with LibAFL) the inability to exclude these
regions from any core dump can result in very large files which fill the disk.
A coredump is obvously very useful for performing a post-mortem when fuzzing.

Whilst the man pages state that madvise provides only a hint (and hence can be
ignored), this patch adds support to handle MADV_DONTDUMP and set a
corresponding flag in the page flags, thus allowing QEMU to exclude these
regions from the core file.

Signed-off-by: WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
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


