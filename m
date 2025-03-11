Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0533BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCq-0002Pi-6t; Tue, 11 Mar 2025 08:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCL-0001Mh-OX; Tue, 11 Mar 2025 08:59:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCJ-0007sK-SE; Tue, 11 Mar 2025 08:59:05 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso9000099a91.3; 
 Tue, 11 Mar 2025 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697941; x=1742302741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wd805KbtUJ3mYr3xoOW61EiyMaIe0guwHYCEOoqrQks=;
 b=GnYCc38CSjKlarRQLV1TNAiTKtvke5qo8gOewPazeRxH34A3GmTNIz+2wcSMGPvWIl
 GzGORteQEAMhfvjMn3axJd/U/I6+3DQ0vRKhOltK6sXSvWnOY009EqdUuIrM+pqEuIVG
 Mh63RXs9V6re68UWMddrXtRj4K7qkmcvTFMB55HIjoSJlVf9eOys7quE92upAvF40UOi
 vNJCJdH+1s3Lcs6j7bziRO0Lvx3AelAtovQqb/mhJ7kfbsE5mbSeE4xL8Qp16RJw4qIP
 LH8jR+vtaT9OKuBDiuRFrXR+QEEwtpkgsrGoMt/OpfM2DbD9qppKGp3DWYDD8Hork9lU
 XUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697941; x=1742302741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wd805KbtUJ3mYr3xoOW61EiyMaIe0guwHYCEOoqrQks=;
 b=s30YdnmHh2xnO4iwBOahJVfmLf0YN8RZnGyNqUZUuIqUZCBbkz/iLsG3qQ14L43W4N
 z7RGON3L60elwiL6Eq/0G8Sm8X3KX6b1XALyG6JbweIthmnZF8DRYisA/CRzIcQLhc5I
 /DSjHucdMcKyCqDnrbiYLpTY99iknnt3wNGYGBVfA/Hjk3VES1lTws4PqDtxVY8oC0si
 dq5o4YJIDK72qIet3SpUa/1ZQQvaSU+IgfdVZC5X5pHJBLdnIR3pOgbKLFy4gSM5Q0YD
 8AdA2zIqmdEGyNJ74w8nU4reO5/feqr5cW3G63TaRH11V92ZDw2SB2nj+x/ohp9vaVZO
 gFJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGcFYwqEel1JPG8OF3TjADk6EXCblhzM5h6RcWNalps141dIi+HFd4ZPaDLOwyJQFMf8fhHg+tpA==@nongnu.org
X-Gm-Message-State: AOJu0Yyhpggy2qFL+2hwlrW9U8O9HuNn5ikxLgdBHGXZG4ErBWgUM9y2
 qzOf1zBZB3eWF8ieHYfntWp73g/ko4mA0lPOtnevDKn/42kMhmISMAst6A==
X-Gm-Gg: ASbGncv5AcmUyeZClA3+/M1ud0oAegKGZYCu8/uSCXDOoX3J4KNguW4H+z9QOgDREio
 oSoEtBKgJN9BQn9eoKs2UhS8lZYBBi2KgPt94V9y88BCU0ea26NYU2kzn1gVDiXCpZo+pVK/lQ7
 2jVuxQnDIzbLxirZ5mE13N9imMNMRDjDe2ss00ylWLitfLCptkV2nN9fYBJMvYTdG134t5ar/KS
 R15DHBunQ16xLbDLiYk4uTntwH3OR/tmxJoT/wbqcRiarCEZNDwspMroDY6OC7a3NeoR9ulqVGJ
 D3fHn3PqsK9h6ILvBRGRgBVNJe4B/KdMYN8ERQsxjt0cGcctntw=
X-Google-Smtp-Source: AGHT+IEZ87898TFY5TjRDkDsFQrCZwnHYHK+prYoGxg8reddGGRazTKXy94Ck5ywDrp6T5iCmjCilQ==
X-Received: by 2002:a17:90b:2fc7:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2ff7cf2b591mr26976434a91.35.1741697940643; 
 Tue, 11 Mar 2025 05:59:00 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 08/72] ppc/pnv/homer: Make dummy reads return 0
Date: Tue, 11 Mar 2025 22:57:02 +1000
Message-ID: <20250311125815.903177-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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
index acd2f7b3a6..75b0ee7964 100644
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
2.47.1


