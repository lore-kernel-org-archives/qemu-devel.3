Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913AFF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEn-0000v9-R1; Mon, 09 Mar 2026 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEm-0000uN-Cx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEk-0008Nn-Sv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GpJAltRXiG3BftU38An+U5DT1j7yTwOzEMSCvYcGWQ=;
 b=L8NMoio9Qk+EXg8vwBrpCuh2F/lfaDlF4rCFCaD2KjgXspX9BFfv16O20+5tmWuod2yAbc
 blp/sqNv0zCogXaGU+0c280GTVyRqf+F1k+7fLl++Gxll30ICTkjmulUMkFRNo0iEexaO/
 Dk0F6B7v2umqQdY2ilWzM0dV3s0SQkY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-mc4QPzySMgCjMhxBjuAyJw-1; Mon, 09 Mar 2026 11:09:36 -0400
X-MC-Unique: mc4QPzySMgCjMhxBjuAyJw-1
X-Mimecast-MFC-AGG-ID: mc4QPzySMgCjMhxBjuAyJw_1773068976
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853efceaddso5827625e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068975; x=1773673775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GpJAltRXiG3BftU38An+U5DT1j7yTwOzEMSCvYcGWQ=;
 b=paClcC0Hs5o1TFteSGe7pOd+UE6hUmmhbVERTvMZ1YrwWbKNnUkPHLHLS1CW9arDhy
 W9nUEWrs5JBt36k4TfWoo7KUR1x1BEX8zRvJergUQzCMaCuqIZMa8Y0B0k23tWNAHWkn
 xgvrQMBiK8bFNbn7C7ZnzR0yZ3+zS4CbMMjUbn6p4XfXCyVQLAkvSy7o6/+KqbhPjvZE
 IglWvNEoYDf5EwkPtuKr2FVe8ZFLZLL6Bwdl7GhPQClpbyG+KOjmvQdedba+kIJ2Eiej
 x1rL1js1gSWID68kS4ttO5COcVvnltr12gqrENSWOqHv0z/XfIay78jzV7NPriI9vJ5I
 mh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068975; x=1773673775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/GpJAltRXiG3BftU38An+U5DT1j7yTwOzEMSCvYcGWQ=;
 b=obKMvYlw4atwlwd1opjGJlKqXx/g/u0YaN/vsiEq7PtuLafB4Gynh8JYUgHTSSHQqJ
 2eQvsnz6w9UVHcacM77O6J4tBuSTAz7f9KmQp8VOVBkQ0OAAVfpa5qz6iKka0Rs1KLI8
 ymCnBkdtwAJky60UyebRAeV+SZaFmp3ucuwhfyQifb6OSGxzvD0A3K8MTw+Adhslc/4h
 eMjqKu0daLFKXxZJVwQplenyb2gljsvPVQnV0loB8Lwgey9N9whJzN5O9GEbFzccInOh
 86ywG2zxY0CrpHAZvIV5giFiDB2BxKB3NlKSl23w5QnGEujTKeiLEheKcJf83OqJqABz
 4lKg==
X-Gm-Message-State: AOJu0YywJbcS2BUi6aJ2k1tTbDvQuDrxF0MxXQlj0eAvDBoGSAUcegfn
 PxiX9djriEOWRAnJgiNOzl7grIsHqjzeKMaOFeM6VHwEmtcLTd5W2mXpj4gih1SOwNvhplnugZX
 dU2WAhod2QTB9P84HUQggsiQklbbF5iSHE4fYAHgn0VTnaB87nGz0iIDT/O0Ky95I
X-Gm-Gg: ATEYQzxZye8rii/I4KGm6iJ6HQladt4qjgimnGcXwnWFCptQLPsqZBZWQ14FjC6McUJ
 Rv939+HwrGjUYugiN536CSAaePc4n00Cj1xE9In5EbHH/rkPnrIthbw/4mKu8rMYvKnQEg/zrZX
 UQpVimfwOc4H4Jgxs5D6j+rOXQRD18IhJ0GEGrr2eHew1oB68k6J0p9uabMzlZdMpH0GeT5O4Hx
 Q/cy/z8kBzaZh5VU+swijgRlbCJXsuaRVoSjt4zbiD+1F/19qyGSXnTYuLhmYhzTHcf6qqNut8L
 iKHnjMG+XONUTeiedpEBD/ZepiP8ON7Eb+b1v+YlO/hX0JZhfBetfB+/RP5k+mk10pEU8slOasc
 ixs+zcgABvzbSXXWBhzcOzFhnvxYo4nsOkrguEq8CHGYeovv005v/vBpZ0tgyYrjihacjk8ob4U
 MpYqg0
X-Received: by 2002:a05:600c:1382:b0:485:3423:727c with SMTP id
 5b1f17b1804b1-4853423748fmr106722855e9.18.1773068975167; 
 Mon, 09 Mar 2026 08:09:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1382:b0:485:3423:727c with SMTP id
 5b1f17b1804b1-4853423748fmr106722175e9.18.1773068974673; 
 Mon, 09 Mar 2026 08:09:34 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686bcesm438544095e9.7.2026.03.09.08.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:33 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 12/25] fuse: fuse_{read,write}: Rename length to blk_len
Date: Mon,  9 Mar 2026 16:08:43 +0100
Message-ID: <20260309150856.26800-13-hreitz@redhat.com>
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

The term "length" is ambiguous, use "blk_len" instead to be clear.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index f6a5f4fa0a..d45c6b814f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -637,7 +637,7 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
                       size_t size, off_t offset, struct fuse_file_info *fi)
 {
     FuseExport *exp = fuse_req_userdata(req);
-    int64_t length;
+    int64_t blk_len;
     void *buf;
     int ret;
 
@@ -651,14 +651,14 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         return;
     }
 
-    if (offset + size > length) {
-        size = length - offset;
+    if (offset + size > blk_len) {
+        size = blk_len - offset;
     }
 
     buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
@@ -685,7 +685,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
 {
     FuseExport *exp = fuse_req_userdata(req);
     QEMU_AUTO_VFREE void *copied = NULL;
-    int64_t length;
+    int64_t blk_len;
     int ret;
 
     /* Limited by max_write, should not happen */
@@ -711,13 +711,13 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         return;
     }
 
-    if (offset + size > length) {
+    if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
@@ -725,7 +725,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                 return;
             }
         } else {
-            size = length - offset;
+            size = blk_len - offset;
         }
     }
 
-- 
2.53.0


