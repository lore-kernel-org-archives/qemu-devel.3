Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E27C5B559
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoB8-00078Z-8v; Wed, 04 Jun 2025 09:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAk-00074D-Vq
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAj-0004ke-DJ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9wF3F+3bQ/mxGLpNGnaivuKHU4J9Rkz4uaRH9vksus=;
 b=UVFukt94SboZtd6ePetoe0hP1T5+CBClWNYAx6usqM01TOFyIXkTtdG5PuM3lI27XF8L4E
 L4HG8kunh3gRTe7T/nygw/4DtQbOsfKbl0iov/NlV1VPbtvrNUxbYffrtr8edBHCyPuj+H
 oxzRoQ38as8oBmzecFRYSroTi9ClII8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-4u5mvGmKODaPMPeHFMF1rA-1; Wed, 04 Jun 2025 09:28:47 -0400
X-MC-Unique: 4u5mvGmKODaPMPeHFMF1rA-1
X-Mimecast-MFC-AGG-ID: 4u5mvGmKODaPMPeHFMF1rA_1749043726
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450df53d461so38835375e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043726; x=1749648526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9wF3F+3bQ/mxGLpNGnaivuKHU4J9Rkz4uaRH9vksus=;
 b=MW0eCoo5Y+7COCT4n8rONcThs0MK3MKLMp4vyZsynnRsXsrp68lc8tO5Mhc0YO01j/
 ld6N9u6WSvXm8zOEkyVePPtvr3jX5pI68xO9nCBXB1g7zeUQ24VekHoJOx3dN0da2ht6
 oaEZEX3ukoX0hOO+iWRTjZEFw6UGUG66bClcIhlZNeG6DWPr9jFIdMo1cKG8ISRM9oAZ
 O5ISNohCeAmtujlZ+3w//UWmFVVT6Tu4Ce+IfnQvM5A7u4DhZraQUwBc7+4aVfSYn6Qu
 q94a8/amafOfOyIZXFsw7AjpqTiytxzrELu711q67nhmQvc90gmk1abZ4giPwl6+NTeq
 jOXQ==
X-Gm-Message-State: AOJu0YxyIqVba3ukh8WdjvcJUXft8z3ca7fAyY1kXv7WwAPpYXp3hgHI
 XEzv3Kk4zFEd2/YKnTr1vkMwT94wGaMocpJVCHv7Z6pEQ5294X6mlaGLs8Qnlpg7YwnVAx/DRvN
 5J7kqDiDa9XE3+AIxVPewUUn5f5jWckMRA15n0zwZGBWFI/zzMAmY2sVY
X-Gm-Gg: ASbGnct2bj7Mq1yQea/uII1ogc/SF816hMu7s3smp08jVPGOpYnVBlJM2lMu6M8b+KV
 W4ZXptQnLVOkqGi3GlzIzlVhikKQda5KDsWENf8N3sHmXK852Io89GTCC1D+Fv7udgoT63DnK+c
 vK4T4ua55dGmKzSotegO03nr5hZo8Y+34dGEnMEg9BwOLO1sclJUn6uTld0NItn8cMe8mud6/tg
 jamxD+PjBxKLY0EjuAo36+T6AIeRfe/4SpbqE6//2gslQ/Vwo5U9DWz9Whan75ywt5tz/KjbTm7
 oFnhLtSYncWA0uo/6WXZjz4TPHFpyX1nO+TI0xiIk+wet/gKn/r2LbPkAz3iUKiGCFfwpQ==
X-Received: by 2002:a05:600c:8312:b0:450:d01f:de6f with SMTP id
 5b1f17b1804b1-451f0aa72fdmr26627715e9.15.1749043726260; 
 Wed, 04 Jun 2025 06:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/9KCRq5HvP1f9mV98ahM8zPG2vDkyaue+NMm575X9qf1nPJAvYe1KNS0qtHcJvvvfSK6wsA==
X-Received: by 2002:a05:600c:8312:b0:450:d01f:de6f with SMTP id
 5b1f17b1804b1-451f0aa72fdmr26627375e9.15.1749043725822; 
 Wed, 04 Jun 2025 06:28:45 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e57bcb99sm40237895e9.2.2025.06.04.06.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:41 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 07/21] fuse: Set direct_io and parallel_direct_writes
Date: Wed,  4 Jun 2025 15:27:59 +0200
Message-ID: <20250604132813.359438-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In fuse_open(), set these flags:
- direct_io: We probably actually don't want to have the host page cache
  be used for our exports.  QEMU block exports are supposed to represent
  the image as-is (and thus potentially changing).
  This causes a change in iotest 308's reference output.

- parallel_direct_writes: We can (now) cope with parallel writes, so we
  should set this flag.  For some reason, it doesn't seem to make an
  actual performance difference with libfuse, but it does make a
  difference without it, so let's set it.
  (See "fuse: Copy write buffer content before polling" for further
  discussion.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c        | 2 ++
 tests/qemu-iotests/308.out | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 9d110ce949..e1134a27d6 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -576,6 +576,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
 static void fuse_open(fuse_req_t req, fuse_ino_t inode,
                       struct fuse_file_info *fi)
 {
+    fi->direct_io = true;
+    fi->parallel_direct_writes = true;
     fuse_reply_open(req, fi);
 }
 
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index aa96faab6d..2d7a38d63d 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -131,7 +131,7 @@ wrote 65536/65536 bytes at offset 1048576
 
 --- Try growing non-growable export ---
 (OK: Lengths of export and original are the same)
-dd: error writing 'TEST_DIR/t.IMGFMT.fuse': Input/output error
+dd: error writing 'TEST_DIR/t.IMGFMT.fuse': No space left on device
 1+0 records in
 0+0 records out
 
-- 
2.49.0


