Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB85FD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIT-00055f-4N; Thu, 14 Nov 2024 11:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcID-00050q-SL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:05 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI6-0002GH-2A
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:55 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7f43259d220so598426a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600113; x=1732204913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AnWkT7tU0GDgeoHYcM5K7eCpXA9PnKUyZxtzeQFAarY=;
 b=xzsPK61FSnUindBobiONzn1KOBiD4SLunuIIgAkQ02i1kgRcs806SIhj8x58HS7oS+
 mlX87IirUoVmD1dKtzDJz2P50ry6u/ElAHenTW6xktiDj1uRYf4lyReeCMcSVMYEHcGP
 eYWYxBN7ZS1f0lHx8IdL/yl1RgFPLsSbMBU8/COLW2C5GHkOfLPoDFHbL3rsGIbdfDl/
 vJxaxk9mD8wll+fgp1PTqHfZDi1Z0tAZjZiQdhHA9lJBVo/lk3PEFn9qw6D3uOdnp0gg
 bjxyEF2MButakqYj5qyOKnk5Nz0ZHF3BObze5plbFPeEpzYGrD1ua2UHyk0Tcrejza05
 8Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600113; x=1732204913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AnWkT7tU0GDgeoHYcM5K7eCpXA9PnKUyZxtzeQFAarY=;
 b=Y4emIzIf/1CauYYk2xrkw9ACQBOV3BdyGBnDe3rm0SbElPvfSFFRaKrd+ll9aGiOmL
 4APecnxYeZbRtUfaXqsAdinNUsLpHQPB5YtruZZwyolYYz4TKIcWQWSbJpt9QxPrQkBs
 JViDgvQCSCQ3lWrQEOtPujMDFu2lZPk9dXtcDBb0gS/iPen2A8W1M7R9XvxtzAmgBZkm
 P9gEFbigfyTMXJYTc40rCbTg+vVvtPNPnheB4nSbdIpykQ9ZN3mIysDH+CnOEzvvj+zs
 j83Y5IWJ1PuXN6hndssrvDHDYgyPSCw/j46gNylRboo+EStI2rxR7D4DguipPqmnRigV
 ACXA==
X-Gm-Message-State: AOJu0Yy6r2DLPMJysgAn6wpbxI5prccH27Ye4zV7IOo3rnq6747Z4BTw
 /WJq7rMEou8N2qq5tyGHHHLA65JVINVyLurwup5ln7Y2JgW91/UfKz21mHi6qeEtnmtbcolsipH
 e
X-Google-Smtp-Source: AGHT+IFvnIHz7a1MyEK30ABDABS/y04r0zAC5JEVsqHkdhBLA4A6WMpdB018cq83f65IAhiKpdf/Aw==
X-Received: by 2002:a17:90b:2792:b0:2e2:effb:618b with SMTP id
 98e67ed59e1d1-2ea0636fd3bmr2866679a91.13.1731600112677; 
 Thu, 14 Nov 2024 08:01:52 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 24/54] accel/tcg: Preserve tlb flags in tlb_set_compare
Date: Thu, 14 Nov 2024 08:01:00 -0800
Message-ID: <20241114160131.48616-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Before, if !enable, we squashed the entire address comparator to -1.
This works because TLB_INVALID_MASK is set.  It seemed natural, because
the tlb is cleared with memset of 0xff.

With this patch, we retain all of the other TLB_* bits even when
the page is not enabled.  This works because TLB_INVALID_MASK is set.
This will be used in a subsequent patch; the addr_read comparator
contains the flags for pages that are executable but not readable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ae3a99eb47..585f4171cc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1032,15 +1032,13 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
                                    vaddr address, int flags,
                                    MMUAccessType access_type, bool enable)
 {
-    if (enable) {
-        address |= flags & TLB_FLAGS_MASK;
-        flags &= TLB_SLOW_FLAGS_MASK;
-        if (flags) {
-            address |= TLB_FORCE_SLOW;
-        }
-    } else {
-        address = -1;
-        flags = 0;
+    if (!enable) {
+        address = TLB_INVALID_MASK;
+    }
+    address |= flags & TLB_FLAGS_MASK;
+    flags &= TLB_SLOW_FLAGS_MASK;
+    if (flags) {
+        address |= TLB_FORCE_SLOW;
     }
     ent->addr_idx[access_type] = address;
     full->slow_flags[access_type] = flags;
-- 
2.43.0


