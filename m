Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2613C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pqT-0008HH-1I; Thu, 10 Sep 2026 21:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ5-0001k6-3j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:08 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPv-0007G8-6a
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:59 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso2906695e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083771; x=1789688571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vF+6ndrGLXKQZTWxC6EFwxN5nkIplvn1xYCLbrS7Iiw=;
 b=hE2AsHPO7iItjPaK2FRzPWMpgBufMch0IVmmicilTvjMfHJBfkAM4HJMWEERiuL8GK
 OA5GlViTFJSoe6+/DCVzQQac6eDaYLzNUCw9nn+XCDhNavBOL72H+ATd5RcAn87L5Pny
 Kb84/yG0gv1jhKmMENTwgJ+6vvXTbtzK0iA+RBhGirMsiXZTh+q08BKCmFloKvmL+eam
 Z968NvAkRrr2cQ3Q5NuTW+IBOTEYF7k4VVzVq/LqFV+2SC6gLnVhZAcM3iFRhn44xzTL
 hhaTw/iPf6lt8pMQ2zdSisutk/+5nHhR+yz9cpxdmKMkYtWFo5FfNp9LftrVnaoaJ4+D
 femQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083771; x=1789688571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vF+6ndrGLXKQZTWxC6EFwxN5nkIplvn1xYCLbrS7Iiw=;
 b=b5cweRpP9ou11NLBZjcFneZHuEHcDLLbt5+fosesud8QVWRrAEf4GRJ7HtrHtW1i7Y
 Z35r26r2BY7laJW3mo5Yi+adAILnukYEZ+gNRFk+nSug0eOGvaQB5O12fNT1hceT0HkD
 XW1x9e3aCvPPJlAYakADh1htSNMAHGDlNAwqqkvXBfGddkO8Gm7horaNeXpcgSpdiHAE
 gbEvCQfgqA8CgSUbZbLMoco9dyNdNKQgpxbyHPRkmgjIEdxDR9GtG7w98WjbyHU0Mp3d
 YbIAXFQIJF7y6kDD0gdMizTCFFj64CGyAgfrFKx5K6j+M4d7Ia7ncbJWUdMy+XJtlwYO
 It1Q==
X-Gm-Message-State: AFuF++kMCsaEslf8HMoUeZSPMd4xIOlFNdhWwdQNbpwKV2CZoIqDIFiC
 2i9m0cvgDETdFqXeDJie1TwRc5/x7NgHT4TP9dMA1+XCkVpo9RtRiwsEJ7E2yMTi26k=
X-Gm-Gg: AYBFou3JkxepMaVacI/PpKu8zuWGe5LjQPgCL9x52u3KVjxKRI/By6QjL5ev5gEeKs7
 RGsf4VSKK83E1zsKVfdKsO33MuxmVUk1OJhB+TBBdhDf+G5Sbhtx+p/53SWfNnOObDyuuvk8pu6
 NkS0jiLTXGpsqvEtNtP4aDvgElMr3tlEhZF6sbVQeyP7rbbp9RR79A3mPGjrEXRZgKYJXE+6KVz
 O9LZuoe+bMUuWK4IWMy2pBYBX+H+Uoaj6ei+0jYLl4//qSb8GMF53WoC0m82y84tS9uGVvzsXzV
 ig1eqdLiHc7X04/Wy7uJ6Aj14YVVj/szfbYtRIIN6n8pdwcu0aRir5S6F1yT9Pp+WVrWrTM24VD
 DL2L/tFnTT2sbro0cnpse3Ccfft+d7MFS3vTu53DIoxTG9i/XWYLo5jIxKAZe2bwTslUnPAYb8N
 d4ztFoqPjCnU1N3ZhqLDYavSHi8lwEXTHc9xJbGy17ZIgc8k1zCJWkZYvk+OBxWZlHfjB9
X-Received: by 2002:a05:600c:3b11:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49e61645c2fmr26511985e9.0.1789083771563; 
 Thu, 10 Sep 2026 16:42:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 20/29] parallels: Handle L1 entries equal to one
Date: Fri, 11 Sep 2026 01:42:13 +0200
Message-ID: <20260910234222.3039975-21-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Ask bdrv_dirty_bitmap_next_zero() for a clean bit in the range the entry
covers, and store the marker when there is none. Two things have to
match the region rather than the cluster which serializes it: the search
is bounded by the end of the region, as a count and not as an offset, and
a missing clean bit is the answer we are looking for rather than a reason
to give up. A dirty run is not a substitute for either. Its length says
nothing about the region it lies in, so comparing it to the cluster size
marks a chunk as all ones when only a cluster worth of it is dirty, and
treating "no clean bit at all" as a failure leaves the entry at zero,
which says the whole chunk is clean.

Both directions are silent: a full disk overwrite comes back as a
completely clean bitmap, and a single dirty cluster comes back as
everything the entry covers being dirty. An incremental backup driven by
the first one copies nothing.

The marker goes through cpu_to_le64() like the cluster offsets below it,
as the loading side reads the table with ldq_le_p(). The serialization
moved behind the check, as there is nothing to write when the marker is
stored.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index e89c489730..6a889d86fa 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -439,12 +439,20 @@ static int GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset,
                                                   bm_size)) >= 0) {
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         idx = offset / limit;
 
         offset = QEMU_ALIGN_DOWN(offset, limit);
         end = MIN(bm_size, offset + limit);
+
+        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, end - offset);
+        if (first_zero < 0) {
+            l1_table[idx] = cpu_to_le64(1);
+            offset = end;
+            continue;
+        }
+
         write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
                                                           end - offset);
         assert(write_size <= s->cluster_size);
-- 
2.53.0


