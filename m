Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACA7C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXu8-0003hZ-9B; Fri, 23 Feb 2024 10:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXiX-0005ZP-LH; Fri, 23 Feb 2024 10:44:05 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXiW-0006Ec-8M; Fri, 23 Feb 2024 10:44:05 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso433145a12.2; 
 Fri, 23 Feb 2024 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703042; x=1709307842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/uWlpyLjbwpL//Tp94l/d17ZDvOpZ1Q/CQ+bpb2Coc=;
 b=afOiToqLIVOb90o9gHQhTQWBrx/0eIzaxkpWR0C+q/UY3bvokGDx5XJycMrcY+iT/b
 pZJ+vkfoGa5qNfPMKlEOd05n6qEnhflFiLK2KN0hHNjW7YPT1cOGDBSUfIEmF6ZwXJO7
 xDFIEnHnbwhUao1tHWDggoK/6RCyRy6wtb+XQjKNDCWNhKwqgJRKfcnu37+kdZsXGVF4
 Ww5klY2l6SPwMD/N2YyPCjU5sklwbYIdBwX/eT3c+pWX87QRcjNmVz5mVrRv7W6h6XCs
 foFqnyWtPvlwtY0to+3GQDaghPsQ0wEw/FJRaeiL3Ozgqr0uPM3zxLTFYUCA3aA20m71
 yN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703042; x=1709307842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/uWlpyLjbwpL//Tp94l/d17ZDvOpZ1Q/CQ+bpb2Coc=;
 b=mq2H6LbB6OJv16rFx0ncZG3DmV88cM1fJO6xbJGaig8BrnztQOPGxlIei1uMQLGTEO
 yNPIDEvQdGAT68cpc6xoQoqxFbxydfNeE44eZr9IxwiN7paD3sKbGYVgNBqpYUf+N689
 RzQ+I+QQ56BuwDyGNy0MYaleH6M7fbmQVzCCs54VuhIX9ztVtrwsid7zZFzuG6yqXHR7
 qMGhCn3d+KJ0jokib+4ony5bMXBIQPqE9LsBxDqQIFMrKf7wSNnQS7vAljoYPiqelJsy
 4yej4asF3zpjANye8XOu6UMTAoBp5bu2mGPorbJG4qzjFg+TjpbVDxKu2pDebBx4WzXB
 rrbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWblacq2is+xbiSnE7QKRVRwnNN/01dNY6IHXVnoJ9uxrN10z67Xt2oP5c+lJQG6O2F9VtwbgNf+JmMnlz9p3FqGJYV
X-Gm-Message-State: AOJu0Yz+JCZL6ry1cFfppZXDqzDuetjmrFkHfwxjwsKYnJ9yduvDfRJ2
 A+Iqv7q2NF7BOVpI9PZ444jfk/NboacE12gbZR+2n+St60YjlrFQLgAPp0Nw
X-Google-Smtp-Source: AGHT+IGu1MjbpNSr1z0v2yKboo7esOpYsgvluRPofCT4BWdD1grp/qesOio5ZaVp0mzkzOvIkJCA7A==
X-Received: by 2002:a05:6a20:d495:b0:19e:bd3e:76e1 with SMTP id
 im21-20020a056a20d49500b0019ebd3e76e1mr232774pzb.48.1708703042166; 
 Fri, 23 Feb 2024 07:44:02 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/47] hw/ppc/spapr: Add missing license
Date: Sat, 24 Feb 2024 01:41:31 +1000
Message-ID: <20240223154211.1001692-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 9fdf0c2995 ("Start implementing pSeries logical partition
machine") added hw/ppc/spapr_hcall.c, then commit 962104f044
("hw/ppc: moved hcalls that depend on softmmu") extracted the
system code to hw/ppc/spapr_softmmu.c. Take the license and
copyrights from the original spapr_hcall.c at commit 9fdf0c2995.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[npiggin: Update file description.]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_softmmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_softmmu.c
index fc1bbc0b61..2fade94029 100644
--- a/hw/ppc/spapr_softmmu.c
+++ b/hw/ppc/spapr_softmmu.c
@@ -1,3 +1,12 @@
+/*
+ * MMU hypercalls for the sPAPR (pseries) vHyp hypervisor that is used by TCG
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2010 David Gibson, IBM Corporation.
+ *
+ * SPDX-License-Identifier: MIT
+ */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
-- 
2.42.0


