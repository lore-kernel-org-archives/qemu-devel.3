Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5151AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJa0-0007I0-Gk; Sun, 11 May 2025 23:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZy-0007A6-3m; Sun, 11 May 2025 23:11:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZw-0006lG-AO; Sun, 11 May 2025 23:11:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74237a74f15so3935386b3a.0; 
 Sun, 11 May 2025 20:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019502; x=1747624302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46zU+Eevw+f9Q2ci1zPiJorYU6o9xpCISdJakU0GPXw=;
 b=a8N+gPBO9ms8kN098YgM5f+DULe0O+V8BZfBy1bqArDqZvXTQUKyqji2cNYzoVBwy0
 lQWYhyiiFKDAtyBHe++sJDOuX7RZCbfn16WK6qouocuS3BQDF9YT94OE7KAP9CfhDhVI
 dltNn0dcX9MkDDpX+JAj/twCtc3pHOtvBBZhfmmk2p7Yfr5671KLVGYIk2sbJZ9SUDfC
 l105CzIQ3/E+WcVf/gO1z7KXEDrbpoPMthThc4++OFN56a2xa4F9qjFhNv8ngiPLpMfA
 rIW60ECjnylREhxjWg0XUW8AIdWiIi+7UapNH7CSSOks8l7KWPdK+u5XRzVY+CJIHnEc
 3KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019502; x=1747624302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46zU+Eevw+f9Q2ci1zPiJorYU6o9xpCISdJakU0GPXw=;
 b=QWPjo7rX+HrhCB8Yd73UViirPUd8OdKfOiEPtvAePFJYN6HNJPY6mi+tJHv2flSjio
 nOiikXQN4y+G139fhRzyPhWs4DcKwviLUef1+o4oHHMFDW06kNoqw+P0Jw142wd/HxKo
 8fhxiOIn2jl6FFogmdgaWPpO1WGQSugpW5BQBWHFCPvBD7cSM6Rn/b1EczWdn0tdw+ns
 6Ob6sR+oOrDgb5eydF1/Up4g0BepeyVUFDeZphg3Zib82vWRh5CgBwMaRKpfeUbxmVpA
 Qlgi2xr8j3dx9BlNtJdOSxOhTE5IN6jM3qo0HdYD8oPjgZRMpl+yRNI0e5kHCFUhnxdu
 lB3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+G4VPsYgkgyduNS2ZefBqpjLEuExIH9auQu9sNrBVRYgFQioKUCglQVxfdREmK+pfdMAbJ3n5b8e3@nongnu.org
X-Gm-Message-State: AOJu0YyLJRfHVF25fBPkkVTbzEQrVxil7qrEFaWbieGdXgGiQmiQ71hT
 TTpP2aWuWognDI02ulbE6JxtlEaMLSOCVoqaAFhfxguPVu+y2ry8bbaNeg==
X-Gm-Gg: ASbGncuW/jmBjb0OApLv4QTWM19M3yOFlGPZQKUowqgtb65QBijGoCwsmtTSJmMsRZP
 Cfd3mMFaKelhlt7gdwJubFnvBN4RUFQv1eqRPGsiuzMWl5/9COXxW4xvuPXPHnsyxLxI+CbKB6R
 vk0S83NU7+KFIRLTCwU4lZdtPV2F6pQ8tBoZ9rBxe59fp+/Sm40EJYDMa05lfJ7Al1Rff4h/zMb
 40PuNbLpLWbHWCU71d56xISQrBCeuwh9gO7Zv2IrxONqe+jveTdaWo5k2/zPqjXzVvJK5g63dad
 LRVQ9hc2woM3vyEI3oX1Ms86y3geE5STVxNW0P/rTTsP6QC5TOZ4/uvLqg==
X-Google-Smtp-Source: AGHT+IE2ps8ftIZSRMxb1WjRJs4JG36OM3SRChua5ItOaV6LvOZJEmkSgklnXt+pBJDhoYzNDTfDPg==
X-Received: by 2002:a05:6a00:2313:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-7423c0176f2mr15546994b3a.20.1747019501989; 
 Sun, 11 May 2025 20:11:41 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 09/50] ppc/xive2: Fix irq preempted by lower priority group irq
Date: Mon, 12 May 2025 13:10:18 +1000
Message-ID: <20250512031100.439842-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

A problem was seen where uart interrupts would be lost resulting in the
console hanging. Traces showed that a lower priority interrupt was
preempting a higher priority interrupt, which would result in the higher
priority interrupt never being handled.

The new interrupt's priority was being compared against the CPPR
(Current Processor Priority Register) instead of the PIPR (Post
Interrupt Priority Register), as was required by the XIVE spec.
This allowed for a window between raising an interrupt and ACK'ing
the interrupt where a lower priority interrupt could slip in.

Fixes: 26c55b99418 ("ppc/xive2: Process group backlog when updating the CPPR")
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 453fe37f18..2b4d0f51be 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1283,7 +1283,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
      * priority to know if the thread can take the interrupt now or if
      * it is precluded.
      */
-    if (priority < alt_regs[TM_CPPR]) {
+    if (priority < alt_regs[TM_PIPR]) {
         return false;
     }
     return true;
-- 
2.47.1


