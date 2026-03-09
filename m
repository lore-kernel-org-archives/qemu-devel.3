Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B31EF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEv-000140-Ve; Mon, 09 Mar 2026 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEu-00012a-GX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEt-0008Q5-1j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mEiC7wHSRQEMHrBtID2dzu9OQQrbDbRtARSqIO9BMw=;
 b=H86WnRI+g56/86gurdgTWLRqWH5oWF8Pdq9U2VkH5+WQ2dhodSYlf74PHBxzKFcN67wU8D
 1jKftsvMk6C7OzmiHjBefEmMhKr6gl4Y1Wmmd4vUWC+t/ys/xIbaABmgaM4u2rEsJrZVT6
 XBYbtKVJOahVIem2E00k/EVlcRc/xcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-hObVzkqnNnqAOeYLtnvEKg-1; Mon, 09 Mar 2026 11:09:45 -0400
X-MC-Unique: hObVzkqnNnqAOeYLtnvEKg-1
X-Mimecast-MFC-AGG-ID: hObVzkqnNnqAOeYLtnvEKg_1773068984
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so94347935e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068984; x=1773673784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mEiC7wHSRQEMHrBtID2dzu9OQQrbDbRtARSqIO9BMw=;
 b=DcM5nxDsYWTTjmX9FfeOTWsTYkpCJhQGrjUyNPRFyGmT3ubeNOCixj/5xlAW9ujHqo
 yD9hWrpLHwdxJjEj9c5iga7XbIpKCpYBuYHBQtF1p0nVPjGnqOENgZd+iF+WXS7HXEX0
 YSrpmZ723Bm485r2XPnhSewXI4vTCglbKo+SMgEjDQ6MRw2p3EHqs2YOlDO1KQxwboOL
 9kCP8fZg0pLIxjkvyfvBKkhoZnOaIt2nXqO2216hqJiA5Y7wgDj7PYr3sUFphEFjURSV
 h1P4CSQePnPpSFR0Ulk/IL5at/zw99oubczj6g3WTTArzTvqG5skU1vCc6IzpLAPsY9b
 Mpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068984; x=1773673784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6mEiC7wHSRQEMHrBtID2dzu9OQQrbDbRtARSqIO9BMw=;
 b=XCSbHyJ5o96lnELMwmRjgiRoBxM9B7LR2JQ9xkxJfjVXeMzgMuvqf6o6fEPAnBLVkg
 boicGAtARzzlww1a5BdYzUZVjRivfoYR27WAPU64pmI47oZCop75yWgrNwlKjR/rTN57
 TmMkqrAj4kXIhyStaz6msCyqtoYrrUcFOet1adXQ2rEiBv7c+juvIYCakVvOQR3lfwmQ
 4Ijltd/Y0OctgCnAKuWgRyFcVqaLPZdJMgjpRzBsG15mQaidEP+8urS9Fc53an1TEkQv
 HpnEytwA3nysZAfa6hhJGrtzM7Q+GpSoVjERET9vZWt07lKYbPFkW6bcyBFbF46v7XrF
 quvg==
X-Gm-Message-State: AOJu0YyuENJrt1DFVpdEOHD1wNw4E4E12ZnIJvRL1gXIJQcl4VqwFVc4
 UCLyAKPOWPjhQQ0Af/373eRNnlvXuGsvKV2BOL7poEXaAkFsq8X6SMPGVn9UUR7M53vCLnlGj8K
 ZogyXoAX0jyHylPZLdny75LWq4iTmSA8PrF7BIWDUmqcCO/h41bzGP33r
X-Gm-Gg: ATEYQzw5cTUzp/24nFLFv7kQxP8WVpwKTDK2+z+Hpg9cg0D5FrFveDHrgWjLzxP9pez
 ugznI3Pa1XDbkdS96xRdVQPIubXFYl4FJ1+tUYRukafty+o1iO9GzLHMZBxreBimpAQmTa69tei
 uOxOEfLPQWtohLT8yfmTWCmvDvhOBybvBMzmRWvJEGXrv5P5fNiDKQkTNhBLRTCMSco1q4crCw1
 7LLtNLKwwZKCTiIPEZlmuwKzOo3sBDgNQuJYIVFW9hsTHZLT29evc5UU5u8lMyoxQOyXQCsheU6
 GX/4kyXor3QzZKNT7PM2O4HWcMzDgeeSDWOePhNcspU5vZquKWxS7gn9JcyqFXAVox1PePTYvma
 JJXG/2nEPuyMrf1xC5wAq1L/yefvGSe1QF+80ApIuhM1dI23QuAkhAN0C6KPzjPkyL7eRMn2bpl
 0vo7A0
X-Received: by 2002:a05:600c:540e:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48539d1bb72mr69257195e9.10.1773068983896; 
 Mon, 09 Mar 2026 08:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:540e:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48539d1bb72mr69256465e9.10.1773068983400; 
 Mon, 09 Mar 2026 08:09:43 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853252cae1sm173654115e9.3.2026.03.09.08.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:42 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 16/25] fuse: Drop permission changes in fuse_do_truncate
Date: Mon,  9 Mar 2026 16:08:47 +0100
Message-ID: <20260309150856.26800-17-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This function is always called with writable == true.  This makes
add_resize_perm always false, and thus we can drop the quite ugly
permission-changing code.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index af0a8de17b..b7a710c29f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -503,44 +503,14 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
 static int fuse_do_truncate(const FuseExport *exp, int64_t size,
                             bool req_zero_write, PreallocMode prealloc)
 {
-    uint64_t blk_perm, blk_shared_perm;
     BdrvRequestFlags truncate_flags = 0;
-    bool add_resize_perm;
-    int ret, ret_check;
-
-    /* Growable and writable exports have a permanent RESIZE permission */
-    add_resize_perm = !exp->growable && !exp->writable;
 
     if (req_zero_write) {
         truncate_flags |= BDRV_REQ_ZERO_WRITE;
     }
 
-    if (add_resize_perm) {
-        if (!qemu_in_main_thread()) {
-            /* Changing permissions like below only works in the main thread */
-            return -EPERM;
-        }
-
-        blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
-
-        ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
-                           blk_shared_perm, NULL);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
-    ret = blk_truncate(exp->common.blk, size, true, prealloc,
-                       truncate_flags, NULL);
-
-    if (add_resize_perm) {
-        /* Must succeed, because we are only giving up the RESIZE permission */
-        ret_check = blk_set_perm(exp->common.blk, blk_perm,
-                                 blk_shared_perm, &error_abort);
-        assert(ret_check == 0);
-    }
-
-    return ret;
+    return blk_truncate(exp->common.blk, size, true, prealloc,
+                        truncate_flags, NULL);
 }
 
 /**
-- 
2.53.0


