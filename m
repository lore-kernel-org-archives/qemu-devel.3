Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4605EC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f9-0002mo-0z; Thu, 03 Sep 2026 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f6-0002j2-NN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f2-00043U-MC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so25167715e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446607; x=1789051407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vF+6ndrGLXKQZTWxC6EFwxN5nkIplvn1xYCLbrS7Iiw=;
 b=qIVdV4OKlQW34rGD5ibC87A02fhGYwWRg1qgi7Ey+8v+lZPN8ws/QSSN6n6ToZ6gJG
 +oNF5pimNC1+cphmJCQ1Nbd8ad4Sw4ouTh/bQnNOWOMqJbKr4+9himslRRdEMHQwz9Y9
 RLzT4FYaqMm8XiyzA/JVbilHf6BtPtM9BWg5tpWCTP1X3XWljbQpe6XGggaF5nvnz3+b
 R+tc198qvaZyywuqsYfPrHIT/EATwkDCpmD9NcaVCheAE6Fnh8g/Vms5fs4QXrVzrRsh
 c3vmWlkSAhO7d9BCPaQQ7fHB+8MPwfgP9SgKAvEsKDfA9iOoY354IueoYEUkElWxnzUn
 3ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446607; x=1789051407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vF+6ndrGLXKQZTWxC6EFwxN5nkIplvn1xYCLbrS7Iiw=;
 b=Y71eITo7kjeO8IkbfdaW6gnH+3q5gBqQKdBcfKg5vajiRPaumkUI1DradsU+kUDtnS
 svT2tVOzuayL4OjXmOjvuZ5CCZ4h4c+rE/NMNtUiENYhujKcKycvdsroHACrUhGJKEZ+
 4e4yWl8G3SVlavHibg+gqEFFR+AD5XXBetZtSBSA28zOPkVStuKwQiSbgGRThbmuaIcC
 Ft7ywsp0yw4ViysDnT3PBjFnX6+Z6TF/841hxS0uQ42oBcVFuaHCYOAXEkupPRF7opEu
 cAUAgRC00Iyo++OR0MZJXXqYdpQD0ZZvEGy2Apf5u+C2o/aU6C3FD/XTuzrAyOHKmlsX
 /pjw==
X-Gm-Message-State: AFuF++lAsXsviQgI+PeYkbcJ2JULF4PK8Q3EZG9bm8JSRoHK0ddqOpbE
 sF56zRMJfbRxjjxcaP/555KqCQ+Ow2q9RLvJBCFNSopkQjGQU/wf/Pu3Sx3rMNKR7WaIT8bJ4B6
 UGG/H
X-Gm-Gg: AYBFou34FPiFlp8al8RRL/tyaHFesl4Np7Gx81FaaP0G50x+NvXBonk2S6k5aX6vVcG
 cfg7GU4Sr2Zi/uT5JZFOYbOlwoP4wT1jxgttTA3WC/3/9pf2SM7+gNj4GZ/XB0/uHUpYEw2vzxJ
 rvGMFE3+ehVW0H2CZ942AKnb1n1RwCv2f28DsVlkJZNK1cMy2NWo5/dq2RlPMiJ6Bl8JWct5DtQ
 2HWIeuOsraytdmkxlMCxuia27FGSxP28CRUsy5SaFpX5uJVY5uO2ZRHlye36RaPQC3z/LQcH/SE
 hoA2yzjK7FvYpiUt/raNkrAnsbiaOC+fxae9Zv8/Vy7+L6yF2X2dLPmpowG0fGRKD8+jlGnW0pY
 ywxgKr40rx4X0PQns0MEWA+wetavbN2dtrqNKtg2rLGHh306qnrqwQukL4aSAfLaTy1wW9JHJi1
 rofcYHyPxMLzE7kc4j3vVKETk1U++Ew5k27KRChzcnHRsL9AsMfnWZ/VHpgfUPIE639cOm
X-Received: by 2002:a05:600c:3f08:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49cf5bbdbb1mr11054945e9.8.1788446607048; 
 Thu, 03 Sep 2026 07:43:27 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:26 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 13/25] parallels: Handle L1 entries equal to one
Date: Thu,  3 Sep 2026 16:41:31 +0200
Message-ID: <20260903144143.2328870-14-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


