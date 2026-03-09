Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E0CF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcFM-0001Rr-DO; Mon, 09 Mar 2026 11:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFB-0001PS-DU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcF9-000071-On
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773069003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=633uGYxCqCqS9HhKtlvq4s6urigO3aDNgdTdJUn3P34=;
 b=PqE8Arsvk8AuUT2S0dQcrebo56mN9TA/G3noeVg2mNNWlrehpvscpQc36aDItu1JtRi6eJ
 1oum5UTb+nZoBLDsURmUqgikXPqPBaj0kM1oy6aNx19SE1OxIbqlLFgsKC8ZfD42O50cef
 RDRdj+CnRSiJT17mTaf2tdqafgR9j9Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-8Gx2_sfkPUiwY1z01t2gTw-1; Mon, 09 Mar 2026 11:10:01 -0400
X-MC-Unique: 8Gx2_sfkPUiwY1z01t2gTw-1
X-Mimecast-MFC-AGG-ID: 8Gx2_sfkPUiwY1z01t2gTw_1773069000
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso6178011f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773069000; x=1773673800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=633uGYxCqCqS9HhKtlvq4s6urigO3aDNgdTdJUn3P34=;
 b=m6+3NHEHwA1ipH/A2JBXPM080Dx9SZnHHgD1vfsaQZini2Cr3Rk9Llt1uTLgOGRWBX
 +BKGdA8ANtNyOGJ+rSXduOEf1UV2MQXYVw9uJKoov0aqxmMZLBt9gfQ8f8b2DEvgfQoG
 9bu5L7IotdIKtVTduSdZVdAnP+1Fqz7v2UMcEzSUvpbF88B2n90UtjwDPuHzTvv4ZpZS
 9hD6sOu8r32Mn6E8yYLuWGiE6uFY9kfSinVWgFtCe1cQuXvkYP6EH0FiZB2zjcVnWPa9
 8ThhnuifOffnv0IP4B5zinKro3H1f7GuuhFYjwh2QLXABSVOhjlc9r6yKKhKGdbWsm9L
 A7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069000; x=1773673800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=633uGYxCqCqS9HhKtlvq4s6urigO3aDNgdTdJUn3P34=;
 b=ngerMhb/86U85Y30pB8MpaM4t5brzWW+z17eNO6uK9YfW8HZtQjjxvlygPXZP8s6Fb
 CQm1+IiElCap5qF2UHKVCgBVe2IUGs7vwNQ0jc6nzrQF5oPEeyAoDAb06ub/OTOP+Usq
 jRe33otZLMCvXQe7bFA952srsIYhYD7/gwwz28M0p+d3di30PE0v7k+l+MgLsV/tfnPk
 7YlUAu3rHL9BJzyTwTOWNAV/MJQ1Mqqq9KNcdEVsavfjw4MqTDz3unp+2WfelPRcbOV2
 1ZuLquGjVdxae/FlHnmZFJkO9YagmZEbfZgqkMnjI5hGTetx98rDAdWU4yoaPUXP7xYM
 N1uw==
X-Gm-Message-State: AOJu0YypYE7O/GTuURlOaFL4xCRpj84RbwX1N1KPG8vUJLvIaXP5yRg+
 5FVWYuykGfOw6KVEuRmVw6kUuJEmIRW53WsOxrHeBHP6QcgAXFOgTLCPzcM3BsZMgvUPY0ta03j
 FiGwIaOMwpAqcJdt0maXzZTUBLIxyCRK9ijXOrbJ1XAn8StZNykB3dvyD
X-Gm-Gg: ATEYQzx/rk08IizyPB7UktTEskU3JX3nUPP3fcZT8svf1GLUHGws7a9dNzCnSTlx7n0
 bJ/FaQ4w+7BMCtl5c2uK8+r2+wgDAZx9t/hcwxCWl2pp6kzgDB3C4MC+PbllDUPjbd6kmtrYn+b
 NkDoC7937Gn3MeWJqoNgQkvjs7jv2HA7HQ321xK3SqZIFXE3SPYcePmieUN397M+/3+owsmp5hV
 0FCk4kaGzln9B5KkovjghUT8uoZnjjub34GpA8A4GUW1KM5c512cPkJBMdX6kuTmn0979fGunvw
 TojoSLaUKSzDduFt4xU+tJECS62AOwJA195ei+J3S78QlsMGnMOnw3KbBZNbz4gw0wCYY9nQR87
 x4i8Zs921APmcfPgBFhO4ejjrLqQorm+sHUWyinqIwmFJFim9Cj2KKXcjY9OWKJnbymfqSbEir8
 +cKAIc
X-Received: by 2002:adf:ff89:0:b0:439:de1d:74c6 with SMTP id
 ffacd0b85a97d-439de1d76famr14581666f8f.19.1773069000323; 
 Mon, 09 Mar 2026 08:10:00 -0700 (PDT)
X-Received: by 2002:adf:ff89:0:b0:439:de1d:74c6 with SMTP id
 ffacd0b85a97d-439de1d76famr14581620f8f.19.1773068999863; 
 Mon, 09 Mar 2026 08:09:59 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d968sm26247465f8f.6.2026.03.09.08.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:58 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 22/25] fuse: Make shared export state atomic
Date: Mon,  9 Mar 2026 16:08:53 +0100
Message-ID: <20260309150856.26800-23-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The next commit is going to allow multi-threaded access to a FUSE
export.  In order to allow safe concurrent SETATTR operations that
can modify the shared st_mode, st_uid, and st_gid, make any access to
those fields atomic operations.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 1c79411839..fe1b6ad5ff 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -156,6 +156,7 @@ typedef struct FuseExport {
     /* Whether allow_other was used as a mount option or not */
     bool allow_other;
 
+    /* All atomic */
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
@@ -266,6 +267,7 @@ static int fuse_export_create(BlockExport *blk_exp,
     ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
+    uint32_t st_mode;
     int ret;
 
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
@@ -334,12 +336,13 @@ static int fuse_export_create(BlockExport *blk_exp,
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
@@ -817,10 +820,10 @@ fuse_co_getattr(FuseExport *exp, struct fuse_attr_out *out)
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
@@ -903,15 +906,15 @@ fuse_co_setattr(FuseExport *exp, struct fuse_attr_out *out, uint32_t to_set,
 
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


