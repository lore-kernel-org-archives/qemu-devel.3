Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5B3C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQV-0005Pz-MI; Tue, 01 Jul 2025 07:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQT-0005P0-0A
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQN-0003XF-9Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nk418H24kCz2+AUWTyV3Eb4pfrMBZv0WmNVH2UyfbVo=;
 b=Z28GYpujTljYSX3IjmEvDIAY2Xkc2aVLqtjCj7JVBMU66NsJt0JaNwwD2sf8a8hrYlfqVY
 zM9WJOughFvMsauwvT390mJM/uSLfx2H2pRxSLDURDyvpaqWrrqgqEKvjIyKFFO4Do1yDC
 aDte5C25G/PvvhemVIXcIA3BcN2RmO4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-oYC8NnRVOAWk8iKQ1Xtvvg-1; Tue, 01 Jul 2025 07:45:16 -0400
X-MC-Unique: oYC8NnRVOAWk8iKQ1Xtvvg-1
X-Mimecast-MFC-AGG-ID: oYC8NnRVOAWk8iKQ1Xtvvg_1751370315
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2765942f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370315; x=1751975115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nk418H24kCz2+AUWTyV3Eb4pfrMBZv0WmNVH2UyfbVo=;
 b=GV/S5Zc9UpGAQ40lt1NC2emcaPm3MO5tM5yB85cs8tkb+kPVuY9+ABnyqCMbb3bzRd
 h8iWDOfKZyJRUH7lH230G1Kap317BEa9UBPNWWCkMyUHYcELdSy1N63+DoVIL83430Dm
 a2npz4xe4EfBJRPD1AR8rdLT+Y6obHbcJJvbnut8T2Jaf0X+3KL19fBbkIKYOh6osDmj
 shJj1vEmdgP0MGViWCPA2MK1r6zuAMhGZXrYB77jLdRVkxzhLuAX9mhWgVXOKy1w17aR
 cIO+/HMsUeKhX0pF5K4UT5E590xy2EJ99G9ATgBsbLCZRRGDbWUODSnGT3RCMFnbGPm6
 2D+A==
X-Gm-Message-State: AOJu0YzkbWKoR7y4R+z4xadUmb96lZA9QkmALZZqqCium5pTZfaE5lHv
 +W1VLQeQfXGQTvasfRNelc1q1xKYwC1P+Sb2H4mk6zab3u7v2nhufAzOIw2b9Ozr3N9UnXoagTn
 /zaX/I+Z7jcVdM6Emo8gOqy9JSYKNxAie4gGlUe9X/GG3nZ8HhXpVdbNZ
X-Gm-Gg: ASbGncvpwEOIG+keNv0b0SKU1LlFT7hsPC4YmGqEXA69CXdxhA05iE49mjiUQVEOLzS
 B1mrMe031wDaAPBSYy/cFlG58Lqj3DlExaMtiBUCy1vpR30zKotT/YsQK5Yg4fs+noHvlvx4yjo
 tGq9gAVhL+aCa/PcaevmWZjsQ0biZjYEpgClORuW0E68yisv7DI5cfEDm6QZ8a+/TG6NUGGZyK7
 JZ61GFy7CtovrurFmURzcZEj1moi6//RC8x3TGf6et9QlGWhPC7DBqFJAOYyT3MQ+PAn2kKO8MW
 MnCU4mXeG6ssWGyCH3A+1uqEAOhsdnIY3CHq0RDmTsRg5wzL5l+jq3veqwKkpg+8lenZ9xqUu8+
 8+Y0U
X-Received: by 2002:a05:6000:648:b0:3a6:d967:37d0 with SMTP id
 ffacd0b85a97d-3a8fdb2aed9mr13224084f8f.11.1751370315344; 
 Tue, 01 Jul 2025 04:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1MgKiZ9yhjaYxG7uNg4tWjjVKbP5QUt+zUl1b+rwC82hbYsIIw4vYVXaROS3lWu/1TduaZw==
X-Received: by 2002:a05:6000:648:b0:3a6:d967:37d0 with SMTP id
 ffacd0b85a97d-3a8fdb2aed9mr13224053f8f.11.1751370314804; 
 Tue, 01 Jul 2025 04:45:14 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5972bsm13136456f8f.68.2025.07.01.04.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:12 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 10/21] fuse: Add halted flag
Date: Tue,  1 Jul 2025 13:44:26 +0200
Message-ID: <20250701114437.207419-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a flag that we will want when processing FUSE requests
ourselves: When the kernel sends us e.g. a truncated request (i.e. we
receive less data than the request's indicated length), we cannot rely
on subsequent data to be valid.  Then, we are going to set this flag,
halting all FUSE request processing.

We plan to only use this flag in cases that would effectively be kernel
bugs.

(Right now, the flag is unused because libfuse still does our request
processing.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index bcbeaf92f4..044fbbf1fe 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -53,6 +53,13 @@ typedef struct FuseExport {
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * Set when there was an unrecoverable error and no requests should be read
+     * from the device anymore (basically only in case of something we would
+     * consider a kernel bug)
+     */
+    bool halted;
+
     char *mountpoint;
     bool writable;
     bool growable;
@@ -69,6 +76,7 @@ static const struct fuse_lowlevel_ops fuse_ops;
 
 static void fuse_export_shutdown(BlockExport *exp);
 static void fuse_export_delete(BlockExport *exp);
+static void fuse_export_halt(FuseExport *exp) G_GNUC_UNUSED;
 
 static void init_exports_table(void);
 
@@ -99,6 +107,10 @@ static void fuse_dec_in_flight(FuseExport *exp)
 
 static void fuse_attach_handlers(FuseExport *exp)
 {
+    if (exp->halted) {
+        return;
+    }
+
     aio_set_fd_handler(exp->common.ctx,
                        fuse_session_fd(exp->fuse_session),
                        read_from_fuse_export, NULL, NULL, NULL, exp);
@@ -316,6 +328,10 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
+    if (unlikely(exp->halted)) {
+        return;
+    }
+
     fuse_inc_in_flight(exp);
 
     do {
@@ -374,6 +390,20 @@ static void fuse_export_delete(BlockExport *blk_exp)
     g_free(exp->mountpoint);
 }
 
+/**
+ * Halt the export: Detach FD handlers, and set exp->halted to true, preventing
+ * fuse_attach_handlers() from re-attaching them, therefore stopping all further
+ * request processing.
+ *
+ * Call this function when an unrecoverable error happens that makes processing
+ * all future requests unreliable.
+ */
+static void fuse_export_halt(FuseExport *exp)
+{
+    exp->halted = true;
+    fuse_detach_handlers(exp);
+}
+
 /**
  * Check whether @path points to a regular file.  If not, put an
  * appropriate message into *errp.
-- 
2.49.0


