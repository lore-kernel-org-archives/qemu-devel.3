Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908DDC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQY-0005S2-37; Tue, 01 Jul 2025 07:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQU-0005PM-5q
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQR-0003YB-EL
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKgwNKq5swcj1deon5pQ3hxXSW/pzxl1K8eAfdwbPRQ=;
 b=FftC9xk4Avu822YnxBxC7OgBQU1wjcGC5KAHAlEa5Z8/oAQQWCU7zt6kPv6fxDSaaA9Gfc
 SJMTu/iP9YAcNY0IetrMYhD9mizasv90011KoJgC4T9WqXwO1IMVD4Yh7t4EVRjsFZHgei
 LtOse9fJbRYsj841MsQVXaBV3JbMYrU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-rd2BXWNlNtudO8ev5lXdjw-1; Tue, 01 Jul 2025 07:45:20 -0400
X-MC-Unique: rd2BXWNlNtudO8ev5lXdjw-1
X-Mimecast-MFC-AGG-ID: rd2BXWNlNtudO8ev5lXdjw_1751370319
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450df53d461so25881295e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370319; x=1751975119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKgwNKq5swcj1deon5pQ3hxXSW/pzxl1K8eAfdwbPRQ=;
 b=lvhu4C0IafCllEYCBQ59kCkFQRQFG4BoEgRXGDSynKo8uDSYaY6Xw13VEKxoeJWvot
 +/SgBYu6rd0WIS3QPVcMfoiLgu1vzV/++cGzAZMb2Oame9rH/rfkoigq+MIBTbT2tILP
 vRS5TFarbJHIsCcAgHNK9d/uFDlI+a06stZlIQ2lf4adrmO0Cfa3IbXGRPrHNsRnZ2y8
 VXecG6ejcaWbUxTAidU8lAmVZebJj5v0yLq3gCTJhNnKqpmm5Mk8BqSTobrOq58hhcrb
 bzACEPj8iAPOgZsmsYXcJ2L+RoDJZ91JrSd8ouzypBrEauDShjwDvNzOxZIWpTdYiYIK
 Yo7Q==
X-Gm-Message-State: AOJu0YzPuqSxH4psKo2Cxd/4J5pS1GNqbVpgPmkxt0+4QKu3JZbdsvLu
 oY5HBkurP3EzD3STpY4FLeu8IPMRw7Gk2YLPErQr+WPz1Mr03bZOX3HnpUVAG4PTLv1bsur/sRv
 QWz/vnJt/IknCAPg79QXXW0qYf9wI4sgyojYqGa2A0KOX1I6dDBBaCN5I5SlTMSoC
X-Gm-Gg: ASbGncuxHIB3YjVNoLW5fsKoiWvuF69WsH/m+2RnP116vBu2qpZKnK8oiecxdwiLkvi
 MkDUn5kqBL5KrDQwHV8ukKu/LlaOCtrmfMD09lxkU+Xv2AwzVllQQXyRHPMDigv8HdiEqPMNbvo
 fTQrpA3wgSUmq07hLi0Bl0e4bWSZ7ZghgAbVIEDGk70j+E8ykEvWKx5OF+HNGSEtF1fNtMcLo7S
 VYEsBi89zQioIv9h+DkmFykDmTtOOr/TUKbAqprV2TkWCJIkbj4yRru1eD1vXu85pRxoZK1S9Rf
 ZLsCGZacHRFkprIG3YR9czfBa1qLmqeoPYwFWTCB2xiILSIPVqNAiuJel1grguY+HSrBIF5oxVG
 UpL+l
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-4538edf9e08mr199742505e9.0.1751370318683; 
 Tue, 01 Jul 2025 04:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF4wftffPv/6qtNJJik2Q4NTkD6isOIA22htPfCDaXeTSulgURSVAn8Xkg0bTgVN4xv5l/LQ==
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-4538edf9e08mr199742165e9.0.1751370318233; 
 Tue, 01 Jul 2025 04:45:18 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c23sm13154950f8f.52.2025.07.01.04.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:16 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 11/21] fuse: Rename length to blk_len in fuse_write()
Date: Tue,  1 Jul 2025 13:44:27 +0200
Message-ID: <20250701114437.207419-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

The term "length" is ambiguous, use "blk_len" instead to be clear.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 044fbbf1fe..fd7887889c 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -679,7 +679,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
 {
     FuseExport *exp = fuse_req_userdata(req);
     void *copied;
-    int64_t length;
+    int64_t blk_len;
     int ret;
 
     /* Limited by max_write, should not happen */
@@ -705,13 +705,13 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         goto free_buffer;
     }
 
-    if (offset + size > length) {
+    if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
@@ -719,7 +719,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                 goto free_buffer;
             }
         } else {
-            size = length - offset;
+            size = blk_len - offset;
         }
     }
 
-- 
2.49.0


