Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B3CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1XA-0004tr-O8; Fri, 16 Aug 2024 14:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwh-0003J0-IR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:59 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwg-0002L0-0Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:59 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d3c99c5d69so303064a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1723826216; x=1724431016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFdvC6MeP6yP93X/5WA8Lf++mX0YuQiplIojlGAQD34=;
 b=BNoD6jCCWFMYRbCRO8qxJSpdiRlkmwOBmm3cYQjiZkgsufwZlUCOzcpZGTz+aAGfQ7
 1z9Gmg8lblU95EZMWq1fDSEucw7+F7Xkg202L/E6sen9390wNdbCBAOO/QsgVIMWJXQn
 ZKQLwjEsNgPR08m8NZozOFdmj1/nEFz2dmLSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826216; x=1724431016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFdvC6MeP6yP93X/5WA8Lf++mX0YuQiplIojlGAQD34=;
 b=us6QK2DtE0eJWG6aoCA5tXbGu9T4mTBZQYtryMkTraZjrKAZPi0hMEdKFb9t+YBWe/
 zcVjlYAq+uwWJF3oxMQeZ2kGpM6T9IrsYE6AeT1hDZWY2OLFJ+0om8RXlvTXwkhXdsZu
 WeTQXvfiLBBnHQRhaYSHg4bxguQh/Z0RTGCpV/K+/3R7to8weQqDi6GmHTAhWdzCKTjA
 sd1R4QTQd49/QA7gF/7b3H1UaCy4BQTE09USYa7UU2BZVudl5wP2SWfVWPEVtis5x3mB
 ozLScp4ZZ7nbThxiJ84gLwGU1Cvk2YMwWYVnUOOYf23Yc/Zc8dzj/ggkSDf7PBoqJr95
 Ft4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRjCs5fYAL3nlNxq7wpoGfW0jy4Hd+8988kaeYRyaA/jdv2nOgCtg2RT+QWC0hy7e7S9MGzWQFUIvZkc4MkbnteWFDnzc=
X-Gm-Message-State: AOJu0YzF/uCX+hmzAqbBmXhUnDBBDiFh8JIPGIFtbDTxb188m9vNgacf
 NE2BxEh0heLrcC/9A+LzjtRMw4AQW1ZJ2VEFuQzZFome1bNXXg8CvTP3zNJqv9I=
X-Google-Smtp-Source: AGHT+IHmWA36aomK2A2/el1m/B1FdBylg7BZTz/BhCM5RRLZiXvw7jp6k+m5SlwCquHKZfBrsGDVMA==
X-Received: by 2002:a05:6a21:788e:b0:1c4:c007:51b7 with SMTP id
 adf61e73a8af0-1c9a2a456f3mr2103118637.6.1723826216349; 
 Fri, 16 Aug 2024 09:36:56 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2e6b201sm2134285a91.15.2024.08.16.09.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:36:55 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Doug Brown <doug@schmorgal.com>
Subject: [PATCH 5/5] hw/net/can/xlnx-versal-canfd: Handle RX of short FD frames
Date: Fri, 16 Aug 2024 09:35:05 -0700
Message-Id: <20240816163504.789393-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816163504.789393-1-doug@schmorgal.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:43 -0400
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

There was no case for handling received CAN FD frames with a DLC of 0-8.
This was already handled properly with TX. Add similar code for RX.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index fda1e7016a..ce68dab46a 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1052,10 +1052,15 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
         if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
             is_canfd_frame = true;
 
-            /* Store dlc value in Xilinx specific format. */
-            for (i = 0; i < ARRAY_SIZE(canfd_dlc_array); i++) {
-                if (canfd_dlc_array[i] == frame->can_dlc) {
-                    dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, 8 + i);
+            if (dlc <= 8) {
+                dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, dlc);
+            } else {
+                /* Store dlc value in Xilinx specific format. */
+                for (i = 0; i < ARRAY_SIZE(canfd_dlc_array); i++) {
+                    if (canfd_dlc_array[i] == frame->can_dlc) {
+                        dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC,
+                                                 8 + i);
+                    }
                 }
             }
         } else {
-- 
2.34.1


