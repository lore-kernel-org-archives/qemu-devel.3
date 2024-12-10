Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85DCE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYk-0008S0-RW; Mon, 09 Dec 2024 22:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYh-0008R0-WD; Mon, 09 Dec 2024 22:05:12 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYd-0003DD-4t; Mon, 09 Dec 2024 22:05:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso9006425ad.3; 
 Mon, 09 Dec 2024 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799905; x=1734404705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgNAx/j9cKMKl1uMhP2lNjnmIgFYxQ7SDIVb2mQjXaM=;
 b=QdZc/uMuixsvnpNET5pewhopLnYw57H/dljgDJK6CJhs3O1JqScMhlm47JtbohS8Hw
 LmbJxwAylvdEhM2uh5+2kJoIVALgvUR92PeIyU9ILLQ1STgf/wg9s7Iw0K3UI7EiVL5p
 t+TWFD1/BzDZS3c0w5aSJvqsl//7vPApXXsp1P7tVGNOegq9eksbyb47lcaSkTc1rMu7
 aFuxRYgXB0SdCbkaV+bXDsg7WSi/oMfpGv7o6OnECm46AMtvR3Pj4FNX2ynxgBoxzxu5
 RRUJEGkr/34UvnDCoLQTqrASoN84P3gCQ11VjmDrDSnPoLdftdsn4uquEpHoDyyn4DlJ
 8MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799905; x=1734404705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgNAx/j9cKMKl1uMhP2lNjnmIgFYxQ7SDIVb2mQjXaM=;
 b=jtEWSltBB47ka4c6uMbpvCRzx3zWr62uAu0LiN+IQrmhoZhnBcByn/KkBhqiCf4ddg
 DDl0h6to335BuyjrSE7CLOoae4ZLK83LzEejH7U3DL7stoGM1lCvjUr/fUPaebxiDOCC
 9pGS3UFfWJl5HRXcPs7A4zSLEUPl9uzjVVImWI9w5HW8j1hzPupIpbr1bfdJskgIjp8i
 C8uRxNd5euhnFv/Dd+I7Kh98PhKIj0KPaxFVUFXyYNYt4bKYl2mWBybPRiQ+Wt/wbAxJ
 PCGpWrmKfa5n5IZHmqBULhePqBq17ACXukzKQu5Zg5OJOONXEEGRCFIlTFhUdsDK7vPu
 EXCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpI9lat2sk5CT9J+IA8SJC+MiV25fQgeD2xAYaGGSFbi5z8BiQgRrBmkd51afkMaathgCEk1kP0Rp+@nongnu.org
X-Gm-Message-State: AOJu0Yyva1NbEaN3pIHlG4tym5/fZQuWx1kLtRO7FuD798emD6Eu1+jc
 ZEK+mRZe6/abZmqNG8rdn6jGXfZLB90z11dHF0lvkCz68IPwLjAtV89HEA==
X-Gm-Gg: ASbGncueNmNqlK/UIC0NEqipF/9cElSLJslbO6trkbcLQVxSZj7r3VgWqmtcDVVQ5g3
 8sT2xcboChmqa4XT96Z3DHY0P46ZjwQBT3GGvT8a49MotplJyvEQunKxs/5kXdpIcuVLqLfWB8k
 pistzojk40AaeFcmDUThC1kiYoO6wd+KyI3o65wBHiApJeKMEIPtq4XARimXO9JDoUAHhlLMM98
 t2kmXbkvt/mkO60NaJzpE3G+Wu0ExJBjxuq6AoFdx68YOyKOKqjdO1xVu5S
X-Google-Smtp-Source: AGHT+IFxTvzA3QloZH6LA5GdCGtClXoZ+PpmuHpVV1K+D4DKg14b/BaebSaTKY/MAHysLR5hmQbMzQ==
X-Received: by 2002:a17:902:d2c5:b0:216:725c:a11a with SMTP id
 d9443c01a7336-216725ca612mr21655975ad.10.1733799904748; 
 Mon, 09 Dec 2024 19:05:04 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 2/9] ppc/pnv/homer: Make dummy reads return 0
Date: Tue, 10 Dec 2024 13:04:42 +1000
Message-ID: <20241210030451.1306608-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

HOMER memory implements some dummy registers that return a nonsense
value to satisfy skiboot accesses caused by "SLW" init and register
save/restore programming that has never worked under QEMU:

[    0.265000943,3] SLW: Failed to set HRMOR for CPU 0,RC=0x1
[    0.265356988,3] Disabling deep stop states

To simplify a later change to implement HOMER as a RAM area, make
these return zero, which has the same result.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_homer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 9aedc08cc00..658b0186a38 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -89,7 +89,7 @@ static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
     case PNV8_OCC_VCS_VOLTAGE_IDENTIFIER:
         return 1;
     case PNV8_OCC_PSTATE_DATA:
-        return 0x1000000000000000;
+        return 0;
     /* P8 frequency for 0, 1, and 2 pstates */
     case PNV8_OCC_PSTATE_ZERO_FREQUENCY:
     case PNV8_OCC_PSTATE_ONE_FREQUENCY:
@@ -259,7 +259,7 @@ static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
         return 0x01;
     case PNV9_CHIP_HOMER_BASE:
     case PNV9_CHIP_HOMER_IMAGE_POINTER:
-        return 0x1000000000000000;
+        return 0;
     case PNV9_DYNAMIC_DATA_STATE:
         return 0x03; /* active */
     }
-- 
2.45.2


