Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C4C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6of-0004nt-UA; Tue, 25 Mar 2025 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oG-0004Vr-2A
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oE-0007QP-Cf
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7d4MlmImkWG2UAQtaVplRdJ/rZ7XuvAmCbc1IVeJbTM=;
 b=cOujmWATrI/Y5YYdLo/yf8W80fW6L7OmaUB8BVrN8c9F27tKLRxEqEIrqcKdw1G3rNJ4C1
 IZOSeRtSHWX+I3EHRIzz5jfHR10WMVoSBsdw+fonmu6vjqu51zBYdJlSz6Ov7kvUWn6JYL
 IXc2xl0slDdhHW2sVvl2VQSfSfZCetk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-te1NtLWhPkGxtHAOPVnZUA-1; Tue, 25 Mar 2025 12:07:18 -0400
X-MC-Unique: te1NtLWhPkGxtHAOPVnZUA-1
X-Mimecast-MFC-AGG-ID: te1NtLWhPkGxtHAOPVnZUA_1742918837
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b41so38335635e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918837; x=1743523637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7d4MlmImkWG2UAQtaVplRdJ/rZ7XuvAmCbc1IVeJbTM=;
 b=E97duDxAzmi70Cju0Atq/mexwwWk5qCrju5UB0fTd0+7pJq7+p934ik3GydN0E+RpY
 w4jWa9tKkmhLMHml0G9giKjVo1jUSR7/MMhdVN3aZhVBxHRR+qEBUSSDKnOlI9TPbJbp
 YWP9pb2mP87SaIEfUevPleaDC+6UpPuezfASk9KlnueKgAShtaGmVUaOthAZOlcxPoSE
 O/O4u6lv5a6GuelnzvPdbLAaQRZlqTSN9bGzGQNrnkemdS2X2fpbzfTMp3K/JP/pdDrC
 HxB9CqCbPxGeiwbU83O3aGyZY5xFbbJE0bt6DeTZ7khyEG65CLAUUrcaAKs9f+mRxD1t
 RS/A==
X-Gm-Message-State: AOJu0YxD37Bun0g4azVwOYYdGeIe5um2UNSMxHA9IoJP3/slwWsDQAYz
 HS3vIPkTHnT5EclH5AjIjcrCoHND0IA8+LVPwx7Cy7V7f+ongYnYNO9uTFy0YTyM1J6FJtFWqq1
 JkLt3iDjCD2I2WxI3dbFj/QnLFQrih46WVgHgyDjYA2dgv4HeHd74
X-Gm-Gg: ASbGnctPrncQ5IqXvMME74Wp/oaKjvx8sFwh14XNtNxErV2TzcnckkW3qqONT+q/xJb
 0WCk/FjPt7TcX8unHH4GuVabmrtKbkz0M26TNpEXIKS6fV2oilePPcjmlSa3VbhTfg2FutkzozT
 EYPrR9Q+hJuwRnMLYAPhG2ZJpoqCoX+5UsBC9XWiopKbTn1CAMsauuX4BKG+7qQGY1Yntr74rcm
 e+ROaoV5JCEnR5uotmD0JXMjt26nTkydwiqMTpbUfWD9+VGnlJNDLX93fiBvYhMBeTZ95PUFyU3
 llwq5sdi6yP6pYCCXwif4atoFPjoE4OhvUZQ4s+RFlyz16DMkIP0K29MAd/ConYXLMDEtR3hog=
 =
X-Received: by 2002:a05:600c:1e07:b0:43c:fdbe:439b with SMTP id
 5b1f17b1804b1-43d509e374bmr176932375e9.4.1742918837108; 
 Tue, 25 Mar 2025 09:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvSJ3v6Q6u8oyl9O5UShLbPhsOhO1UOwaMBIE+BCxpck3GSZiLxNRn79X9aARqY4HhH9e6IA==
X-Received: by 2002:a05:600c:1e07:b0:43c:fdbe:439b with SMTP id
 5b1f17b1804b1-43d509e374bmr176931355e9.4.1742918836299; 
 Tue, 25 Mar 2025 09:07:16 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c99sm205914325e9.24.2025.03.25.09.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:12 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 07/15] fuse: Set direct_io and parallel_direct_writes
Date: Tue, 25 Mar 2025 17:06:47 +0100
Message-ID: <20250325160655.119407-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
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

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c        | 2 ++
 tests/qemu-iotests/308.out | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0d20995a0e..2df6297d61 100644
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
2.48.1


