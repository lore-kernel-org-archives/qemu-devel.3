Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB19C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFZC-0005rd-HN; Mon, 31 Mar 2025 09:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tzFZ9-0005rO-LM
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:52:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tzFZ7-0001k6-UE
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:52:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22928d629faso48260685ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743429155; x=1744033955; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pDmh587MNtmbO4Hi7j8VcvMCR3H/Msk9nHMXgpFAZ/Q=;
 b=Ftrm+OVIq3cah9zTY2g2pbS25ZqTh3WuLH/jJpBPmMOeDFGIVGcHeMHPVpfPFcdE7O
 w1rlMhn+vvCFIyVkdlPyadxn5gvTvsCPYH29/+aa9r8a1MI4ZLxd2aniXzcVt8dLIhNz
 deAFcWUgLu3xTrsoXL96nTtv06+dskI2e/sAtywSlsTdVm0YOQ3PasfJSKFPFI2byK9P
 F5pHPTwbdh2nqza/2Ki4gLi8B1nnru5+NJhPf35vFnmlPou/qB7+bLA9l1mJJan2EukJ
 /dbJ69+tcIyGTSGhbmEp/2XQR0enYKu2WAQOg9jCIv3+u4Iseut2MLTWVnQ4kJ8HzqnS
 OKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743429155; x=1744033955;
 h=content-transfer-encoding:subject:from:to:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDmh587MNtmbO4Hi7j8VcvMCR3H/Msk9nHMXgpFAZ/Q=;
 b=B3qZvkcfmCdA3h7J32FgYcx8dSy9uGcDnadALpA/+FQqc/SEPPS0eyQOIf3nGdmRQ0
 jiA6ITw7VEYCW7+akI2rNGEegvflZnW4pl3EZ9yKSTiStHN6vqPr0S9rFJhnld1ocFTI
 W9dOTuddzC4cjSCEKLLX37m4WFDi4rPKBET3LAoKiF9pNHrYQvMzw1G8SJ4nWwrGH1fF
 Y0j9/zP0nOgmuEKoyWC1s3j5Y/Bxs3RgIiUpYhlpRTLP6am0TmvAu0G7XxwoTopxkH/O
 W4E7Tz9wMeFJ4gT3F2UtFFKplCPy2XPgCm0lbyvqzORPLvHRvK3v7p53l3XWuI64QBc0
 bDAg==
X-Gm-Message-State: AOJu0YwSYD9gaPYoYgaBD0R7Z7qVsrioTkWOkjynPsi//fij3o2fdyqn
 UAYnkSSObkiVZSEv6HR5EdNkwkZGsFb4z0ztpaLogmRWjzVo7QeYUibO1A==
X-Gm-Gg: ASbGnctJj1JKLHzi8Z2Efanp1UdYfV6zFT2kZMbmBKeQ2+4kYiRLsXECOz9f04PF92/
 rdNygQWCG/dkFUvbXwn6fX5nc+uvDoMBTGiCbsUCsqnE3WQSR+9+VoelKStC2S3s35M9K2y3RgN
 rBMN3pXmv7h7iDNHXIbDZLuuH2HJLoQrabztBq1iW8T+wO74p30Vd+29rKuRmYwMvdjMLa96uRh
 F5HskQcAJdPIjXPz4KhNu9OwvJGlWixxTXdRl5Od4mnSLDYRXdOVjkpaOcprT3ukDbANyi0/VP+
 AbAlVSnss9jk05pkZxmvb8rUag8Q6JW3UlTLzMHHATG5ZI2O+q+lL2uLo40leX3b
X-Google-Smtp-Source: AGHT+IGZq5bwtTuwxV/xfamWPb6QYX3Z1pgqDWZCetsGwMZjjBiwZ/uBlgM4nTvT3s8kEa+4dXfK7Q==
X-Received: by 2002:a17:902:e74e:b0:223:f9a4:3f9c with SMTP id
 d9443c01a7336-2292f949436mr142440435ad.9.1743429154739; 
 Mon, 31 Mar 2025 06:52:34 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1dee68sm68929535ad.205.2025.03.31.06.52.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 06:52:34 -0700 (PDT)
Message-ID: <a4e34adc-a425-4183-bb4f-f1b8197125eb@gmail.com>
Date: Mon, 31 Mar 2025 21:52:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/9pfs: add cleanup operation for 9p-synth
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x635.google.com
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

Hi,
This patch adds a cleanup operation for 9p-synth, which fixes a memory
leak bug in synth_init() and other related operations. All child nodes
of synth_root need to be freed before the entire filesystem exits.

If you have any better ideas for the implementation, please feel free
to share them.

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>


---
 hw/9pfs/9p-synth.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 2abaf3a291..ead8b9e3be 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -24,6 +24,7 @@
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/cutils.h"
+#include "qobject/qlist.h"
 #include "system/qtest.h"
 
 /* Root node for synth file system */
@@ -136,6 +137,19 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
     return 0;
 }
 
+// Must call after get synth_mutex
+static void v9fs_recursive_free_node(V9fsSynthNode *node)
+{
+    V9fsSynthNode *entry;
+
+    for (entry = QLIST_FIRST(&node->child); entry;) {
+        V9fsSynthNode *next = QLIST_NEXT(entry, sibling);
+        v9fs_recursive_free_node(entry);
+        g_free(entry);
+        entry = next;
+    }
+}
+
 static void synth_fill_statbuf(V9fsSynthNode *node, struct stat *stbuf)
 {
     stbuf->st_dev = 0;
@@ -615,8 +629,22 @@ static int synth_init(FsContext *ctx, Error **errp)
     return 0;
 }
 
+
+static void synth_cleanup(FsContext *ctx)
+{
+    // recursively free all child nodes of synth_root
+    // V9fsSynthNode *tmp;
+    QEMU_LOCK_GUARD(&synth_mutex);
+    v9fs_recursive_free_node(&synth_root);
+    // QLIST_FOREACH(tmp, &synth_root.child, sibling) {
+    //     v9fs_recursive_free_node(tmp);
+    // }
+    QLIST_INIT(&synth_root.child);
+}
+
 FileOperations synth_ops = {
     .init         = synth_init,
+    .cleanup      = synth_cleanup,
     .lstat        = synth_lstat,
     .readlink     = synth_readlink,
     .close        = synth_close,
-- 
2.34.1


