Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3B3CD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsg2-0001lE-6l; Wed, 04 Sep 2024 12:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsff-0001DB-9h; Wed, 04 Sep 2024 12:15:51 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfa-0002GJ-B3; Wed, 04 Sep 2024 12:15:48 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5353d0b7463so11546077e87.3; 
 Wed, 04 Sep 2024 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466544; x=1726071344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6K1JnQDB3GxWbgLc2L3O0RRJjZo+EVTDK5d5nCO5jo=;
 b=nVEi3m4VUT785Tn+uvYQSKtzm35qwqWTjSnRxTAzUU3ydvvIipPfR2pBF5+iwIE1hS
 H9WSYUrPawi8VavgGzDm3butnsQC/5ohXS/hdaLarXDAqK2hV4jzZc+CmqHp9fa1MEQ8
 JpBikQtSbErx031ZKwQnGFZb57Dr+wIeth+DB2hSON6vAHJrILcrezYFt/pG4T5ye0fk
 alat4VWJRIY8QpY/dGUAFldNOgL/svDZFmJ42g0qkWX52nAu0DJR4qJ6LtUQ3bXaCcrX
 uE3sYCxrt+QYUF8vtJGUn42mfvvwnVzX6kCC7cfEEWEYpC8sRvoaQrCI2YT6VROCYJaq
 euHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466544; x=1726071344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6K1JnQDB3GxWbgLc2L3O0RRJjZo+EVTDK5d5nCO5jo=;
 b=BedZLwzMexR/Fu5sS/4KzJfBVrRTBecS7nVw4xW5ny6K64vB0lLC59y/2TTGW9W10s
 2gfiaXqG0dyXzijk3yJBWl578ioBPUmXW8pQSFUkNuDyXRkYxvQiz5SrApz/+4Iseoc1
 LoWtsvFevaehTPUqLM8edWsd34JoWAjp51C//JS+je3cNsknyupHnwyeOYEKeDT9vPWz
 cVi7DsV9L+gOTonyqBen7P7DO3rvhzpMjQXsyuxWo99ivRfJkvAxN4YEBLEngTirg20c
 WJ3DH0jz1/iFeOtJXPCJLr9m5UleFP1ZrcfJy99eiULAfYoS2tk48lGPu0Hm1eeYAE4F
 mymw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOv+bY8hprCUQRG0kSp5F3bsIuLzoN1crFMFM7gzn1v5NE+LqFiOs9C7/d9KS1hTw20C/c3cAnQw==@nongnu.org
X-Gm-Message-State: AOJu0YwaevuiQjHMk182+jW8ibdmzlCbXjMJq1dEX1fPTiZJu5KERKq5
 /IUdyBb6P3QZ0PUorNM/uOwnqt2DnERIHMqfpeKT0CoD13mdGsODQfHO7PeY
X-Google-Smtp-Source: AGHT+IFom4VEXuZYnoDrA4HGURvL615ZNQmYPSqV45hP6uADwmwNAHyfJ2jP5ftIt03oSUiu6NVu1A==
X-Received: by 2002:ac2:4e06:0:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-53546bde03emr15776888e87.42.1725466543416; 
 Wed, 04 Sep 2024 09:15:43 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-535692d9bf6sm176315e87.41.2024.09.04.09.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 02/12] hw/arm: xenpvh: Update file header to use SPDX
Date: Wed,  4 Sep 2024 18:15:26 +0200
Message-ID: <20240904161537.664189-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Update file header to use SPDX and remove stray empty
comment line.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 6fad829ede..766a194fa1 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -1,24 +1,7 @@
 /*
  * QEMU ARM Xen PVH Machine
  *
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * SPDX-License-Identifier: MIT
  */
 
 #include "qemu/osdep.h"
-- 
2.43.0


