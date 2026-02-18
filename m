Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F07AE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfl-0004Od-Kx; Wed, 18 Feb 2026 08:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfh-0004Hw-3E
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfa-00064w-0p
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eC1GpsxsI4aDAAkTkGGQOGTuPmmj07fAx5eTswWosPE=;
 b=OlGT7XtUsRNEtvKfd2F/5rDRX1GO+rdKGkh/q9p2VesNCjAMc8wiBMcZQQQn/gRsnHZRVH
 TO9OaW5ozcS1FcjwLatoPUn06bgJQOxouoT4gIDSZDmUWMDTVyiHv5H7XKUfxaWbQIGTqR
 ELNZHakvs2XXRX+1KylXBFG2zwmZkiw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-A9ZZAotrOOORghMIuIAPWA-1; Wed, 18 Feb 2026 08:27:38 -0500
X-MC-Unique: A9ZZAotrOOORghMIuIAPWA-1
X-Mimecast-MFC-AGG-ID: A9ZZAotrOOORghMIuIAPWA_1771421257
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837f288194so42109955e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421257; x=1772026057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eC1GpsxsI4aDAAkTkGGQOGTuPmmj07fAx5eTswWosPE=;
 b=stytBGEO65PwvMt2foNCp+nVnTiADfmkjdav+su3jB0OdCqoumzr0/u7KeDaMvMHwf
 3l2+FitUfbDdrsjewzkmqPjs7/YdffnP9Ao76YcQSBpXeAa0BaWTCZDi+n8AzFa9NKYA
 YmhGq/OxhUnc2phke2h5MwwdVirRCi1Q2KcIRLTkqXcbBE7d+H6N6enVrqa0GEGx8C5U
 kWsFiFhqC75ys9k47qJeuSbagHdnDdkIIiiJHG/UA6IgazGBA1uhojIlR39bbxvtBcp5
 GCUYQyCT86SGE0txYuOIgW9WdfWkOMS3wuiSr3airaOy0vtStoKwZeC3BwV6OFQSXOf9
 R6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421257; x=1772026057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eC1GpsxsI4aDAAkTkGGQOGTuPmmj07fAx5eTswWosPE=;
 b=LUkSGu3wYBknwMF6g79GpfVeFZCG9uky/ha1CDN1XrgI7wSsYX8ofpxQl9mzw96SRC
 sVZXaokm3L4cdl8Du4ktOUaiE7QRAH6FQJGD+TGnaxNaa+7ZotFD/WKP3l9TN/7ovjaz
 MiEoVimrrS1JV/HumXrlGHASEeYiKohnIN/HhGYL95dTXnm4gQ3dKf5HBmq/YEjmHB/f
 IGqS8xccs0Uq1Vaa+BjVUB/bbc9UIHzpqGmvuvWjnaSKSjfuQ7KlqLTMKQRflo2Bqz+q
 3c6TOZ5o2oZObQUheXuoxJkVmZt7jxh3LDvAGt3IYCrtRjrlNgEeW2bqgR1+wIJQWVep
 EX3g==
X-Gm-Message-State: AOJu0YxtjjTfp8g87JsK4/tNW4/Nr9E7j5YT3UOmaV/Cd+O8vYT8ZPjF
 Ghnf7MaD9jLIOv27NFqwY8XlT0sCmVfsTebrttaGBs8aC0AbRTWL38pWDfnwRYIiuYwvbJxPlYa
 zMULVwx99MQE3923v7OQh4kO5WZJICeeWEzGV2UzQVaAIJqtCY8TbmNiS
X-Gm-Gg: AZuq6aKyGW8g+crMaCSXj1uLih6jwhGNjYTHCHwiITjdzaN1hVXSBvaK4hseMYo6oVT
 rQbRPfYP1C5gkjlwIza9Jemd0p4g06JHzFdguqx1ORdfqFLWqaFS6VQFk/1uhfNKA81EQvpqvB6
 wQ0TbjNe2LgmsJADgJL8tGVW17qNqwB3Nax+a12vix3wTKPluxly2HbxP1VoQnGfwOs5B9BKWI5
 SDkEfIYw/WnsoN02v8NN7obuLnTwyU9J1W8ilwz7WG8vzhebdXe0IeceuXBEuRshsDDbtxeZiQX
 EVuZH/1kBDQG08JL6ILX1umnUTSELbvezjfeRswr15JjpgHKtdkYOZcKzqZk5Q4jmUIZpTMNkb+
 xdK6wzbfOhHb+9k0SQcCjPSUrl0rxndMPvLMw1xWIAk9whmkBt7L41mSq1W8B07rr9eVJVVG1Ao
 ZaKG7N
X-Received: by 2002:a05:600c:620d:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-48371043046mr263552445e9.6.1771421256833; 
 Wed, 18 Feb 2026 05:27:36 -0800 (PST)
X-Received: by 2002:a05:600c:620d:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-48371043046mr263552055e9.6.1771421256341; 
 Wed, 18 Feb 2026 05:27:36 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370ac3564sm362444415e9.5.2026.02.18.05.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:34 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 21/24] fuse: Make shared export state atomic
Date: Wed, 18 Feb 2026 14:26:30 +0100
Message-ID: <20260218132633.29748-22-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The next commit is going to allow multi-threaded access to a FUSE
export.  In order to allow safe concurrent SETATTR operations that
can modify the shared st_mode, st_uid, and st_gid, make any access to
those fields atomic operations.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index aa4f1c0307..162cbdacfc 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -157,6 +157,7 @@ typedef struct FuseExport {
     /* Whether allow_other was used as a mount option or not */
     bool allow_other;
 
+    /* All atomic */
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
@@ -267,6 +268,7 @@ static int fuse_export_create(BlockExport *blk_exp,
     ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
+    uint32_t st_mode;
     int ret;
 
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
@@ -335,12 +337,13 @@ static int fuse_export_create(BlockExport *blk_exp,
         args->allow_other = FUSE_EXPORT_ALLOW_OTHER_AUTO;
     }
 
-    exp->st_mode = S_IFREG | S_IRUSR;
+    st_mode = S_IFREG | S_IRUSR;
     if (exp->writable) {
-        exp->st_mode |= S_IWUSR;
+        st_mode |= S_IWUSR;
     }
-    exp->st_uid = getuid();
-    exp->st_gid = getgid();
+    qatomic_set(&exp->st_mode, st_mode);
+    qatomic_set(&exp->st_uid, getuid());
+    qatomic_set(&exp->st_gid, getgid());
 
     if (args->allow_other == FUSE_EXPORT_ALLOW_OTHER_AUTO) {
         /* Try allow_other == true first, ignore errors */
@@ -818,10 +821,10 @@ fuse_co_getattr(FuseExport *exp, struct fuse_attr_out *out)
         .attr_valid = 1,
         .attr = {
             .ino        = 1,
-            .mode       = exp->st_mode,
+            .mode       = qatomic_read(&exp->st_mode),
             .nlink      = 1,
-            .uid        = exp->st_uid,
-            .gid        = exp->st_gid,
+            .uid        = qatomic_read(&exp->st_uid),
+            .gid        = qatomic_read(&exp->st_gid),
             .size       = length,
             .blksize    = blk_bs(exp->common.blk)->bl.request_alignment,
             .blocks     = allocated_blocks,
@@ -934,15 +937,15 @@ fuse_co_setattr(FuseExport *exp, struct fuse_attr_out *out, uint32_t to_set,
 
     if (to_set & FATTR_MODE) {
         /* Ignore FUSE-supplied file type, only change the mode */
-        exp->st_mode = (mode & 07777) | S_IFREG;
+        qatomic_set(&exp->st_mode, (mode & 07777) | S_IFREG);
     }
 
     if (to_set & FATTR_UID) {
-        exp->st_uid = uid;
+        qatomic_set(&exp->st_uid, uid);
     }
 
     if (to_set & FATTR_GID) {
-        exp->st_gid = gid;
+        qatomic_set(&exp->st_gid, gid);
     }
 
     return fuse_co_getattr(exp, out);
-- 
2.53.0


