Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A141AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1X9-0004nW-4x; Fri, 16 Aug 2024 14:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwf-0003Hy-Tm
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:57 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwe-0002Kj-8t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:57 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d3d4862712so231738a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1723826215; x=1724431015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF5wQtBRwS5BcKCR1fatsaBhyKFb2ABe75XUBpYoZfQ=;
 b=bOOgpPU47DHLJqCgRPm+hiL9bFX8BjxbHJ3FjbLoSfqQsK4q8iqwZP1QQ6GmO/Jl3v
 2taBKBJSwsphcpZV3+Jcp92azg7E2TQd0Il8HVs4umrcXsBKder5PDM7hCm6WVzbLns0
 KCQfDVo8yYtFOaW314OJCQcI9L0OSkx3eKxcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826215; x=1724431015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gF5wQtBRwS5BcKCR1fatsaBhyKFb2ABe75XUBpYoZfQ=;
 b=ZrAJprBw1Wng+M1ZtHWYx4rDLrp1GWKfQsQ19XjhvpueA/0eyiJGRmuwN7lAUXvwtJ
 GDfRta+sjeh2phJHhAjpPVC7RSn6UQyRyYF5MYpAw2ZYBr/MAwOv6C6dpbCuuIrzb4dN
 /40sEBp+OaYJx7YweIyy8fcToStkFT7KsnzKS6ej96gej1Qblm9Ic753hs629M3kjVVf
 IZwQ6Pb1/ZoCK6Mh46YUy2zJRA1bVf69MD1J0TjaduOmEb4BP2/n7NGe07G4kqAR7lge
 Oj9Y4kTYVi008ndxOHPHoGTeB4oBuPqp6EachtV2A+I4M3f74IpaTcY5WAmMGTpL3c4N
 Nmag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Jj7WTbkBqMQEEM7b5WNSq2bfo4I3zEHhY7kO8AiGf9PdAtx3Mb72vgVINeR1gj5p5pIMt8HX8Y2MJUQ8R6kJggnBsfY=
X-Gm-Message-State: AOJu0YwbjI5+NvZOhbl9NryCdElAK2GT/tVVOJ6zNrbKFIXHZSDqED7r
 /JMPDnC1QK9CBbnwBxUq2fVMbnH3mZkkYBnI9Ac7AQbdThKXRiBypzvmjfqXTBQ=
X-Google-Smtp-Source: AGHT+IGzW99cJKbppBdD/yEWS+jyMZaQEUXcPyTXolnJe480/RZ09i+Lp2aJkXpbluZDqh6DlRxVSQ==
X-Received: by 2002:a17:90b:124a:b0:2cb:4382:99f1 with SMTP id
 98e67ed59e1d1-2d3e1e10102mr2129671a91.6.1723826214781; 
 Fri, 16 Aug 2024 09:36:54 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2e6b201sm2134285a91.15.2024.08.16.09.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:36:54 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Doug Brown <doug@schmorgal.com>
Subject: [PATCH 4/5] hw/net/can/xlnx-versal-canfd: Fix byte ordering
Date: Fri, 16 Aug 2024 09:35:04 -0700
Message-Id: <20240816163504.789393-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816163504.789393-1-doug@schmorgal.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:42 -0400
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

The endianness of the CAN data was backwards in each group of 4 bytes.
For example, the following data:

00 11 22 33 44 55 66 77

was showing up like this:

33 22 11 00 77 66 55 44

Fix both the TX and RX code to put the data in the correct order.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 1704b558d0..fda1e7016a 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -945,7 +945,7 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     }
 
     for (j = 0; j < frame->can_dlc; j++) {
-        val = 8 * i;
+        val = 8 * (3 - i);
 
         frame->data[j] = extract32(s->regs[reg_num + 2 + (j / 4)], val, 8);
         i++;
@@ -1080,19 +1080,19 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
             case 0:
                 rx_reg_num = i / 4;
 
-                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
+                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
                                           frame->data[i]);
                 break;
             case 1:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
                                            frame->data[i]);
                 break;
             case 2:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
                                            frame->data[i]);
                 break;
             case 3:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
                                            frame->data[i]);
                 /*
                  * Last Bytes data which means we have all 4 bytes ready to
-- 
2.34.1


