Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75314C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5t-0005EI-2S; Wed, 08 May 2024 09:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkf-0007V6-UV
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dke-0000XJ-68
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ed0abbf706so28848015ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161095; x=1715765895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REjV3MNcFfq7gH+69GQ9Wyw9SNuTcZ130RuiQhIkTss=;
 b=Bq3jyy65s6OIXByBJPOjqkdPcuLCiSw2t5sMF6q4tpU9nrM6HCG/PzN/V49x9sjuhn
 iD1S3LJIB2Fs/8C1Rv8eoDm9p+o4mrVXPUUfxqr3cY6xlUsOpzCivfeDGWLUHoYIXBlb
 lSo+UWmVxxuHzyz74h5NN6TwSGW0Ir8TYjiATkvuShZ+cBruvdBID2R04XMcxMsN78fD
 fTHRwA55kUHVzhutkIpKhtQhFG1uSpLiz+jCcigA87ysd822PH8F5mihOpZ24dLe0PbH
 w+1InPaFx2vzXmvt+OXSA2onRmVfV+r2oH2dZoVF2giYj3GFTOgKDkWJH41eIeRL1L8C
 KW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161095; x=1715765895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REjV3MNcFfq7gH+69GQ9Wyw9SNuTcZ130RuiQhIkTss=;
 b=jlhl6R+igzjMatQIFdaIWQqxAdMDG8F1l3kgmtWudJgw6BQFf0sDK2TyYaGsT/S9ir
 Xosi50I7+RQoQXUBkImpInrAdcTWQwrXov0iFS86xEUq0JXJnmW9KWovo2tRx3+3kXtf
 af+/QdnrV3S8fxbh58ibmn1QNP5TyeIaL5Q3lDeelAbW5O7Kl/IsWfZUMMUqPbxWaDbX
 XBUFlX6SDKO6S3kaF+4DjAs1EAXQnz1bSK8W11pWwUVQEIxq2fFEmd9TEjj4WduUDeOZ
 0F1v6dddWec0aD2hTtw4pewlC/TcjqZovQ9/OpkOG1AtPb8TYXQPZkO3p2LfoMqSDuen
 husQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIuKKTiooF64zwyNgkcslRzd58nbjvSYBJpuvhZSemebQ+2sw61i1rt10F1nLMTsu2Eiqs2X/s21FCkWDq4cLTHXdnxqI=
X-Gm-Message-State: AOJu0YxfpSxRIp6yG0FFJGZtzks3xpU3uXrXa/X3SEEOs8lQoYECKwN7
 24kAz4aTU/Wy/X6PCGHlfl+pLUY429kIVxjLEsLwQw/a0wjiMmGPCDPOi9mHhUU=
X-Google-Smtp-Source: AGHT+IGM3+Ubylkt9hhSsVGlCd72RXz03xCMm80BRI+tojF1H57vkTR76YzdGhOLEE0uMhtdjvNo2g==
X-Received: by 2002:a17:902:e74a:b0:1e2:3e1e:3d9 with SMTP id
 d9443c01a7336-1eeb0899ae1mr27124525ad.63.1715161094778; 
 Wed, 08 May 2024 02:38:14 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:14 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/9] block/raw: add persistent reservation in/out driver
Date: Wed,  8 May 2024 17:36:22 +0800
Message-Id: <20240508093629.441057-3-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 May 2024 09:12:22 -0400
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

Add persistent reservation in/out operations for raw driver.
The following methods are implemented: bdrv_co_pr_read_keys,
bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/raw-format.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index ac7e8495f6..7ba5b12101 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -454,6 +454,54 @@ raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
     return bdrv_co_ioctl(bs->file->bs, req, buf);
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
+                    uint32_t num_keys, uint64_t *keys)
+{
+
+    return bdrv_co_pr_read_keys(bs->file->bs, generation, num_keys, keys);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
+                           uint64_t *key, BlockPrType *type)
+{
+    return bdrv_co_pr_read_reservation(bs->file->bs, generation, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                   uint64_t new_key, BlockPrType type, bool ignore_key)
+{
+    return bdrv_co_pr_register(bs->file->bs, old_key, new_key,
+                               type, ignore_key);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    return bdrv_co_pr_reserve(bs->file->bs, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    return bdrv_co_pr_release(bs->file->bs, key, type);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_clear(BlockDriverState *bs, uint64_t key)
+{
+    return bdrv_co_pr_clear(bs->file->bs, key);
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pr_preempt(BlockDriverState *bs, uint64_t old_key,
+                  uint64_t new_key, BlockPrType type, bool abort)
+{
+    return bdrv_co_pr_preempt(bs->file->bs, old_key, new_key, type, abort);
+}
+
 static int GRAPH_RDLOCK raw_has_zero_init(BlockDriverState *bs)
 {
     return bdrv_has_zero_init(bs->file->bs);
@@ -672,6 +720,13 @@ BlockDriver bdrv_raw = {
     .strong_runtime_opts  = raw_strong_runtime_opts,
     .mutable_opts         = mutable_opts,
     .bdrv_cancel_in_flight = raw_cancel_in_flight,
+    .bdrv_co_pr_read_keys    = raw_co_pr_read_keys,
+    .bdrv_co_pr_read_reservation = raw_co_pr_read_reservation,
+    .bdrv_co_pr_register     = raw_co_pr_register,
+    .bdrv_co_pr_reserve      = raw_co_pr_reserve,
+    .bdrv_co_pr_release      = raw_co_pr_release,
+    .bdrv_co_pr_clear        = raw_co_pr_clear,
+    .bdrv_co_pr_preempt      = raw_co_pr_preempt,
 };
 
 static void bdrv_raw_init(void)
-- 
2.20.1


