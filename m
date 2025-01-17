Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5FCC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpkt-0004aH-Oc; Fri, 17 Jan 2025 12:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkm-0004SO-Ox
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkl-0003EU-3t
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:28 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21670dce0a7so53363855ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133404; x=1737738204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZvVEzy7Hpyg7HUIWubinjme/50xBSDYw0ukGt210aI=;
 b=MeerybNQk5aj6c6uCqcZl/xVEJ4IrZuVPWMDR7JV/GNV9XbVD4Iu/mhtJve54ptiKc
 yGylvgaacD5OpLJHO7E7ZKBlwKyneYyalDm/xfjjch1DK1X3VRdKCbGjkJqpDR9VTXRp
 4FjFtCf2RevSUNI/MtlmcDQg8AeoxfOoU7TzzmJ3uduMD8GUONlhfVyMHqQh6Xh5GVc/
 Vrwmnt3FFY0X+pNdysaN0cCBY/MN/FsSpFlj1OjacloIGHH99RXaliV9VHrNh8rB4i+S
 kFaIClt1Yn6oAN/EduHwH3iq3FQxFsLHr6Bu9AKaUicx04vfCICBJt3g/jppW7JHtCSI
 n6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133404; x=1737738204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZvVEzy7Hpyg7HUIWubinjme/50xBSDYw0ukGt210aI=;
 b=p+6tT1HpcGHjvfru2rrYbf6seAU5IW7egKelOb54cyahgpsn2Q/G0hCBHnG+5n2X0m
 Ecgi7yXF87grKYl4NuwCp+6Qe+q9Uf8/4ONszgDyYyrMpMe223eDwNSlkjJxjCInMDw/
 UVbkE+BPlz3HrxNhUwxLz4+08Rpfz7FjI6Sjo4d3EIuSYms/oc6sWQRvdHkETUIrW57c
 swzx8vx8MURLVdcahX3FDOkZznq0mHdB7Fzz/zYDApS9h2z9Mw8jo7E00bGjnok6wBIh
 I/1CYuNXftVZVvdliA9ZQhNh67NIbHtStT42xvnhaZ4ximaiVBY9q5iUd3GD4IRwDnVB
 EROg==
X-Gm-Message-State: AOJu0YxE8V+zk56Ic8DSWJZx3ThbOsDZ/UhgpLMLo29ITv5xs+dGrS1C
 RePQ+FYa3gIPknj6m49kW56DmrjWtXn8FJSRi3AUDacLseaja9cVh6ufbA==
X-Gm-Gg: ASbGncswO0m/FVxmHmsKQOPHORT0ZobP1dXMKkShgae+TLC9jEe8YUaOoD+K8XdV9p1
 0mcyfwGLXtPN8+xDy0GqMhpjX7Rh5jrMtbm0pMIVp6guDmZ23TN8wB7kscV6lWeFZ9aic0ocrCY
 P8jJ6hmjTw19VtyxVpU+gWUn6EcgBJz6tS4itCyQO6ZcqXl0BmpV5b7plCFct0iM1KTjDvaJKWx
 ScSC42AmAxu5jBJLhKK/irCyxxpRKUCvf4M1WQ72Aheng3VxLafe43/U9/ytrk7FhOXLif0/vOL
 KAmOCMzBtrA/h2M=
X-Google-Smtp-Source: AGHT+IE9XshYL0lPVtunRHBJmritVYwgn2i27qoplyHKYm2pVX6wh88fZZKKC3i+tfeqdm6B1aOvbQ==
X-Received: by 2002:a17:903:2290:b0:216:5e6e:68cb with SMTP id
 d9443c01a7336-21c3540d18cmr48638595ad.16.1737133404162; 
 Fri, 17 Jan 2025 09:03:24 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/9] net/e1000e: Permit disabling interrupt throttling
Date: Sat, 18 Jan 2025 03:02:58 +1000
Message-ID: <20250117170306.403075-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

The spec explicitly permits xITR register interval field to have a value
of zero to disable throttling. The e1000e model already allows for this
in the throttling logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 24138587905..e32955d244b 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2783,7 +2783,11 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_irq_itr_set(val);
 
     core->itr_guest_value = interval;
-    core->mac[index] = MAX(interval, E1000E_MIN_XITR);
+    if (interval == 0) {
+        core->mac[index] = 0;
+    } else {
+        core->mac[index] = MAX(interval, E1000E_MIN_XITR);
+    }
 }
 
 static void
@@ -2795,7 +2799,11 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_irq_eitr_set(eitr_num, val);
 
     core->eitr_guest_value[eitr_num] = interval;
-    core->mac[index] = MAX(interval, E1000E_MIN_XITR);
+    if (interval == 0) {
+        core->mac[index] = 0;
+    } else {
+        core->mac[index] = MAX(interval, E1000E_MIN_XITR);
+    }
 }
 
 static void
-- 
2.45.2


