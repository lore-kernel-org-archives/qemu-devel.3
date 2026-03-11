Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E539E112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M5S-0004O3-Vx; Wed, 11 Mar 2026 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5F-000455-99
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5C-0005s7-PV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuyIaOwGg3hOBBCUG5jek+OeVDlLciDtqXEanBQL7kM=;
 b=BDsikQpaFTtX10BSdBiA7kekyxW1VWj35zrSLbbvVxw1aH8L4aakH0yykycBPT0ucG9DCP
 hR41wDI+5LTcvXddH1Qa5QYZYANVUCatRNFyOl4c3aQIPPFDOsaf3SF9i6Z8tjf48lIABU
 EwPf7+NKfwLiOvY1dVeQ3zjI8zLI9N0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-LH0KZtmBPeuxWlkj8eg22Q-1; Wed, 11 Mar 2026 12:06:47 -0400
X-MC-Unique: LH0KZtmBPeuxWlkj8eg22Q-1
X-Mimecast-MFC-AGG-ID: LH0KZtmBPeuxWlkj8eg22Q_1773245206
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48531e6012bso150815e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245205; x=1773850005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuyIaOwGg3hOBBCUG5jek+OeVDlLciDtqXEanBQL7kM=;
 b=CDYTy9EXLOoWuUhXjtHz13ZmUi5fEt04Hg5BCptaeUFoSpfj14Ox25r3qz8nQtRJSd
 A/873e2h52o6bZj0gGC3jo+UCgd41t0HxX0KQYPuJyGkTua+UHF1Nuv9v9ZbJVSeRcnh
 CtAjlVequneUhxckLi7UwT7ZeNRhR/4wJQBvljqyCyZN9juDvHLms3PaFV3bGfNVlNzp
 8332qnDaMNecyXCwqYHMhrxWOEhS57xqV2V9RO7k44f8uJTg+qaMXrXe3ECaMNRd22T2
 pErGCiA6mAm60iNBslbT0c9NRtwGIO7nyIi8B4/H1+CF6YgyD5AGtH8JGWIsJftlezsl
 ibZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245205; x=1773850005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BuyIaOwGg3hOBBCUG5jek+OeVDlLciDtqXEanBQL7kM=;
 b=kuGBbj5Wap8jEvZGLX0dLYSb4oBIr0PJ/0qdkVrflVAg1xlJQ109PIN//zfWRiokNr
 LsK/opB5WeW3hQdGip9rYXnry8sbDNcEEHWDoLlpRZLdowr9YPi4t+RqLKCsuR96Wpw2
 Fr4OCNGLXmGGhPz2QsPcPx7W+QWjDllsiOAOonJwFzjbs9f9ixCr/BdA5UZDQWODSMgr
 0W7fSvnrzWh4CZeG5QEzE4UuZ/tp11XyXXMB7ZH6DZ7ppAWjcKGFHtwpFKq7clq7d+hm
 XyHNm6FRnO7omhO/Bgb85NLY4Owb/NyASqKMf13Sa27c8HEhR0jW/S8cGCt1rmXAee4r
 vs8g==
X-Gm-Message-State: AOJu0YxaQoYzDbyBCGFciUOtbXTL9pWXti17NFK3kBWxTs/Tmtw4RUzg
 oyOdociQ0HvMMje0N9ICYnKLe+FSs5ZV/KtZKrll1pTquf4ubHayzXl/BXWlWsyRqfGh4a6KndZ
 xSw+ltkP/lbpfi+wGR62P2wJY1RJt2V6EYclDa/A3NWroKB7kX6boVVvGaWbFsNC6
X-Gm-Gg: ATEYQzyBmwkcbfgY5dV5pVX1dAHT+UBZl+NXY42AiRVCX/kPazA1oxatrRyPB7ZEzte
 Mj0fYRwItY+N9+puUfHIZTDfdURCPKe51oNwPzD8s9W/zzQxh1/F9egLkT2xte/O2Ftt/VNaPK+
 F99w4kcmpos8hM+tLXHBcQGcJLbDpBR+h4ZRMrsgvYF3Dp47IuvgN5ekg3fMYfyU9PxnDiF2VaE
 yvxGuU/HEtmfNE55kEPWfmfIH5s6KkCtOkHGQZaK3ummuVpyBacLQHm0yS1URhhf1iahvwNsEhz
 l/sm60hSnE8iwc1PkrjYqQYAZgy3q/e8ajkI9xJ+XLGF8HHF/YdcgygMPomf2ei1RS47sIit/sL
 ywDhvyRdCv60ynUv3ueU2SO+H4bLqamTYLzLzeNvQhHA3IpL7DEAjVglaIufRxYK01IWDKWxRyL
 0P/AzK
X-Received: by 2002:a05:600c:c4a2:b0:485:4371:539a with SMTP id
 5b1f17b1804b1-4854b134965mr55660855e9.31.1773245205305; 
 Wed, 11 Mar 2026 09:06:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a2:b0:485:4371:539a with SMTP id
 5b1f17b1804b1-4854b134965mr55659935e9.31.1773245204733; 
 Wed, 11 Mar 2026 09:06:44 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273e8sm185724f8f.33.2026.03.11.09.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:43 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 4/6] qcow2: Call qcow2_co_truncate() directly
Date: Wed, 11 Mar 2026 17:06:26 +0100
Message-ID: <20260311160628.344838-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311160628.344838-1-hreitz@redhat.com>
References: <20260311160628.344838-1-hreitz@redhat.com>
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

bdrv_co_truncate() checks that BDRV_O_NO_IO is not set and that the
RESIZE permission is available.  However, after this series:
- We want to set the BDRV_O_NO_IO flag in cases where we can ensure that
  no I/O will occur to/from the data file, to allow concurrent use of
  the data file while a qcow2 metadata image is put on top.
- We want to take the RESIZE permission only when we are actually going
  to resize the data file, i.e. when it is not big enough yet.

By calling qcow2_co_truncate() directly, we bypass these checks.  That
is OK because qcow2_co_create() is the sole owner and user of this qcow2
BDS.  (For example, taking the right permissions on it does not matter
if it is impossible for there to be another user.)

Note that qcow2_co_truncate() takes a signed int64_t, whereas
qcow2_opts->size is uint64_t, so we should add an explicit check for
overflow.  iotest 206's output changes accordingly.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c              | 17 +++++++++++++++--
 tests/qemu-iotests/206.out |  6 +++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2ab5a9e0f1..dd0f47c0ff 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -82,6 +82,10 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
                            QEMUIOVector *qiov,
                            size_t qiov_offset);
 
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
+                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp);
+
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
     const QCowHeader *cow_header = (const void *)buf;
@@ -3657,6 +3661,13 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         goto out;
     }
 
+    if (qcow2_opts->size > BDRV_MAX_LENGTH) {
+        error_setg(errp, "Image size must not exceed %" PRId64 " bytes",
+                   BDRV_MAX_LENGTH);
+        ret = -EINVAL;
+        goto out;
+    }
+
     if (qcow2_opts->has_version) {
         switch (qcow2_opts->version) {
         case BLOCKDEV_QCOW2_VERSION_V2:
@@ -3939,8 +3950,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Okay, now that we have a valid image, let's give it the right size */
-    ret = blk_co_truncate(blk, qcow2_opts->size, false,
-                          qcow2_opts->preallocation, 0, errp);
+    bdrv_graph_co_rdlock();
+    ret = qcow2_co_truncate(blk_bs(blk), qcow2_opts->size, false,
+                            qcow2_opts->preallocation, 0, errp);
+    bdrv_graph_co_rdunlock();
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 979f00f9bf..46c2d8db97 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -169,19 +169,19 @@ Job failed: Image size must be a multiple of 512 bytes
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "qcow2", "file": "node0", "size": 18446744073709551104}}}
 {"return": {}}
-Job failed: Could not resize image: Image size cannot be negative
+Job failed: Image size must not exceed 9223372035781033984 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "qcow2", "file": "node0", "size": 9223372036854775808}}}
 {"return": {}}
-Job failed: Could not resize image: Image size cannot be negative
+Job failed: Image size must not exceed 9223372035781033984 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "qcow2", "file": "node0", "size": 9223372036854775296}}}
 {"return": {}}
-Job failed: Could not resize image: offset(9223372036854775296) exceeds maximum(9223372035781033984)
+Job failed: Image size must not exceed 9223372035781033984 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
-- 
2.53.0


