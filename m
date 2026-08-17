Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDF1C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3tF-0003vM-7c; Mon, 17 Aug 2026 16:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tD-0003uj-Am
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tB-0002pn-MN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RDemstICwUKjxsppJmK9PMzf+f0kzlTt3c0ZIH3UWA=;
 b=IIGnwAYJgfjEX0duyjE6FeyRveeIWdavMqyixx6Wqec2t78WAkI7c78X2U4hber0zMyCv6
 P1oWbFjvVNxVZxv9elOVb32MRVpbeGeZVestm9KkPA946fP4aVLgEuRtH/ngYL8rs66mQ9
 tb7lxL1Oz51EqeWT4VRID6/y8PAcfaw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-0ZsZ6owmOhKL435AwNegZw-1; Mon, 17 Aug 2026 16:24:55 -0400
X-MC-Unique: 0ZsZ6owmOhKL435AwNegZw-1
X-Mimecast-MFC-AGG-ID: 0ZsZ6owmOhKL435AwNegZw_1786998295
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d91cc174aso59848261cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998295; x=1787603095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RDemstICwUKjxsppJmK9PMzf+f0kzlTt3c0ZIH3UWA=;
 b=PJAW6vHynWCm6SZyQB1/sHzDM1vWTd59Uhm2xZv0ecfzZ5sEe1RbH+YCy8/uJL0Dht
 0riWDxseyjsTDKvsoUh65Kviuj5CKJfg7ur9w+nTB9h7DKqhqiWCZoB3FQdDCkbp0aQT
 7dybj7zKQ0rAPlaRAxje2Q6pe8u87lwExY1kU51Hidxk+VmKazGdwJYVHSXHtLyO4ERm
 rtlIIb0Vyz9UEiLnIyDotBXaeSygN4raAs3Q0ZVo/tRhfL5R2X2CoaX9tMsqGboB6ztU
 LNz5AcVHyNRsbWVCHRDUz9QB787y5jbNJkhlrTATB32jawuuSSzA1XtKRyVeh4i/mKHR
 e67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998295; x=1787603095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/RDemstICwUKjxsppJmK9PMzf+f0kzlTt3c0ZIH3UWA=;
 b=WOz5BxxCYLRnpB1b5Ep8Oat/dhKlnVMSxFMUIHpV6b6D2juHIj8340XxuHWA7U6FZO
 VTmllIB2TtMhy1jlBRq0NVPWNa8NGKjN7tR/r/jKfaQ4aZeg9jBi4BUCNCZQNpyptBKd
 h+W45wG9JcAxLtQ5Q2V0F1DF3CHYaPpt6KpMkjBshGrWD2iak32VyorsmDjtzaPtac0o
 Ml17Yqdl/i4bFND0Xz+gdednEH0LIiwoIm7VgOO4NYKrbry3B6FYPV6QBJXMME/ulPdO
 7z3qbMLa2K4d6ViiM5n5A2+C8WG8sYwlIQfLLWJ1tAJS9/4jtjUL22XZ6nV8UfWnXECr
 5R0A==
X-Gm-Message-State: AOJu0Yw3vN4K8PC4KgAVK5h/KnZEfbqU0qAXLvH7IgizB4tvcgkW+ylC
 /bs48ToXh0eGS7RxT2cwRSU2ANttaClpSkHs5cQ3LQvL6egLNTOUNQLeLczKFE8dCR4M/XEnfWy
 S/360iMgNj3wJeNLgD+1B+3HfCIHoUUQvBvTICeOKc+FsRgaqmReONZfv8+ahZfq4OWFvKW3/Tl
 1DDn/FCwm9pS3wZI69k/MAc5HWFVDUfyugYjeh2Q==
X-Gm-Gg: AR+sD13fEKgHyBn7ozUr2BWMZTWypn/cOBcFHxmFQn6l0/VcsVlO1ASH3x72sCmAJlX
 NsFMK1v653Dh/SQSTwgmZ81m/VwrukXUzUPwNPQ/3IjLQCQwa3n0ZuiSgrC5LFxFo8lD+9Rr7NU
 mj1NDaojkX016ibhqEal9e2E+FZZub3TCSDvK16eUs+BsZZU+wa3+TrBwYNBFFlKh3L1uFK2kkK
 5Shf/9VV3JnkxdTpaPxjwMPNFf0hWwhdyziv4hsh/nhCnY/0LZ+hu/r/jDKxo8FvBEMG+RmnKsb
 PA/yWZjsAaUlhDbIm2GxbqScodoFgUFbuyOi8unq8bommEXG9g7sHHHRagU4FZcOeA==
X-Received: by 2002:a05:622a:1789:b0:51c:981:94a6 with SMTP id
 d75a77b69052e-52d8542c250mr285285911cf.23.1786998295115; 
 Mon, 17 Aug 2026 13:24:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1789:b0:51c:981:94a6 with SMTP id
 d75a77b69052e-52d8542c250mr285284631cf.23.1786998293687; 
 Mon, 17 Aug 2026 13:24:53 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 10/10] migration/rdma: Sanity check compress request ranges
Date: Mon, 17 Aug 2026 16:24:24 -0400
Message-ID: <20260817202424.2901438-11-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The offset/length ranges are not sanity checked in RDMA requests, add the
checks.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4005
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 13dd60c11b..699aaa9903 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3200,6 +3200,28 @@ static int dest_ram_sort_func(const void *a, const void *b)
     return (a_index < b_index) ? -1 : (a_index != b_index);
 }
 
+static bool rdma_compress_range_check(RDMALocalBlock *block,
+                                      RDMACompress *comp)
+{
+    uint64_t block_end = block->offset + block->length;
+    uint64_t comp_end;
+
+    if (uadd64_overflow(comp->offset, comp->length, &comp_end)) {
+        goto fail;
+    }
+
+    if (comp->offset < block->offset || comp_end > block_end) {
+        goto fail;
+    }
+
+    return true;
+fail:
+    error_report("%s: compress request range outside range"
+                 " (block=%s, offset=%"PRIu64", length=%"PRIu64")",
+                 __func__, block->block_name, comp->offset, comp->length);
+    return false;
+}
+
 /*
  * During each iteration of the migration, we listen for instructions
  * by the source VM to perform dynamic page registrations before they
@@ -3279,7 +3301,9 @@ int rdma_registration_handle(QEMUFile *f)
                 goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
-
+            if (!rdma_compress_range_check(block, comp)) {
+                goto err;
+            }
             host_addr = block->local_host_addr +
                             (comp->offset - block->offset);
             if (comp->value) {
-- 
2.54.0


