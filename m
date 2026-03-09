Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBF0F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEe-0000p7-4A; Mon, 09 Mar 2026 11:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEc-0000o2-Gb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEb-0008Lk-1Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNGtHA3kcdOL2SVcnUEo+P1ksEysivVPpQTbAQYAGcw=;
 b=EVYi4Svy9V7OQXetFSFJKMY4oKhy+yuuW4myeQnjvL5yvO4qYCuXcooOiJ3bIJCmKX2pTP
 /XuLcDdt0ABJLeCoX9H4a9q5HjpYu0EVKUlxHpKRwXZdbeQzwYmhiTltzESnDIwSk7BHeD
 HLCg0rxH1wlW24xC9tUA/2obpfevxVY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-jVdNCG4rNXeCFXoXdNKd5g-1; Mon, 09 Mar 2026 11:09:27 -0400
X-MC-Unique: jVdNCG4rNXeCFXoXdNKd5g-1
X-Mimecast-MFC-AGG-ID: jVdNCG4rNXeCFXoXdNKd5g_1773068966
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c4bde453so4223299f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068966; x=1773673766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNGtHA3kcdOL2SVcnUEo+P1ksEysivVPpQTbAQYAGcw=;
 b=bp2mx7bBW3FpK27Zjdgv1sczfE9M+K65GLeCCI3B+oNTTvgLSJsRZWWMZ9iqnsyYr0
 JeHOdzJa9bE8Nk7N0dqvs1OrUd3xCk8PtOPHfiaWbUDB0x4LoDUcAAHLT2UUz3r3HAdX
 9sK4ZP7Gf9NvtVVkc/HRTOLseVONSZshobSfNrL0qEqYykqa5bdT20HPsLJzcIabReyV
 U5zFPfa45K57EaYV+taAs6/C/BBbaT/v9zaY7NY9LiTQRUCVxIlrFUGHRIn9cT17oOJj
 PFt1sIsJS3loos/IhYDU0gDLd10vytbqH2zcJ+99e5Mq7mZ5mp7SSVGfMsx46KkyRzQs
 GX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068966; x=1773673766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNGtHA3kcdOL2SVcnUEo+P1ksEysivVPpQTbAQYAGcw=;
 b=dS7D/byaWJMD3+Wk71X+z5CFm8+ew1gMjClJBh2osf/omAeveK+fOnBS/kgR1YnPe3
 SsVU7V7Mq6sOzgzuPp7fiMEPpgfyX2ETkOSFF5BmYnumAkrRTQ23xQ+D+VRKXfyLHSlJ
 FHtYj0PAufsi2RJp+VVzNH83LNuNqKe3YcvsBZkxmaAfWAwvD4/WK+hHQSD9c/YKQid1
 HcQX6JwDwhTlt4JxguMmPdFzwlGMD3zHNd6BzStI7tMxImPAwotZdaSvmDf2NUnWQXej
 N2BjVn91NtSaoqKgc6wIe4tkJM4dPSIPGTebwa+znkugMKkCZJwkq/LZZMYse7lIPsX8
 y2pQ==
X-Gm-Message-State: AOJu0YySdZmfma4Xk1b7t8RLJVfb5wJwnLMPS6SKv218nIqEx1kTfdj4
 HZ5IiVgj5hPIQAjtw2u9eJOB5ucLvTu2lfbnU1X9B0I6q7fVHcV+jfG5fIpLnRm0V+ZjUtHUH54
 dC2M2D8PIjHlTop5JTV9mFJd5/KlrG8RpyVqJERYRHZTICa24KaCmK+C3RImZLwKW
X-Gm-Gg: ATEYQzw9DqtFjBGnLKF/5JTn0sCcWXWpbdKjoXJufIgf/Iydzv5hZWqzUk1Y+196fkD
 Qy9w92iMUeQL7uq9lLI0H+F4R5StV+VXFqKqeAOYkkJ8As38+ZllkpyMx7XK0AXA+7Q6jmYOkOq
 jE9QpgqtNS9kxaaRFxVwV68IXNij0HpX9yT7xvINjDNmo2iNBPXZuaofsUr25XvPhX0cNJabuod
 9Spa4Nz+qYQZ5hkUHeeSDzPRhoXQUhNl/44IFKyG5p+ef3+2h66kz7xf5jawVE2kE0OdvX7qNT3
 PYzkzHVzjhv//QUz1Fhe3FwlpSIcisskqbfY0OlQAn/xk1TxZQkHJa+4wVHVtBMwQF0VROISgGc
 wKfmE3tJa7ECCHlnyj6FzOwMaNPNc+GhtGUAnMBgdw/lMi0ZfF8FEQqu+9yk1oLeFiKzO5sGEm+
 az8jM4
X-Received: by 2002:a05:6000:2211:b0:439:b564:7a71 with SMTP id
 ffacd0b85a97d-439da64fb62mr19920214f8f.1.1773068965515; 
 Mon, 09 Mar 2026 08:09:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2211:b0:439:b564:7a71 with SMTP id
 ffacd0b85a97d-439da64fb62mr19920141f8f.1.1773068965000; 
 Mon, 09 Mar 2026 08:09:25 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae4b860sm29872183f8f.36.2026.03.09.08.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:23 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 08/25] fuse: Set direct_io and parallel_direct_writes
Date: Mon,  9 Mar 2026 16:08:39 +0100
Message-ID: <20260309150856.26800-9-hreitz@redhat.com>
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
index 0422cf4b8a..d0e3c6bf61 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -582,6 +582,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
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
2.53.0


