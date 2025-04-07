Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE016C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 18:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qys-0001Kb-35; Mon, 07 Apr 2025 14:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u1qyn-0001Jn-Q3
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:13:53 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u1qym-0000yM-Ca
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:13:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af519c159a8so4188351a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744049630; x=1744654430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZPoHr83DG4r/Bx1w5bhtsfupgP+wbmobPwLqCD+uX0=;
 b=a8dSusm0VQOj1GO6yfrgGqljFc7Jdgn9voy1wzIwDYUTvOMC/wNQp5Gko1BZXBxu+B
 yONouGBAExKC/hf+YBiiskuIDguUiDJGhwMESNWqpUwygm/gJI8tUGymKm0k+XVCUc9C
 k32PRHXaXvu+Q9DgYOK8e3LYTSb0hQJopdvKDTYSk2yT086dhXl5OA2TE5cI41O9K/e5
 PVY1MYuKH1TbmDXB341htSk3W3gtLCmxhdNsDYl25Mhfrf1GUxTSe/ld9YVOnKoGxfDE
 IntaUGAm4Q60NB7HLeClSEmRcUmkhXSiURAP1SU2FMWB1QwQRRST0uwZxupV56UTjQZg
 Hj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049630; x=1744654430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZPoHr83DG4r/Bx1w5bhtsfupgP+wbmobPwLqCD+uX0=;
 b=V8Dec4LvVSlOIAVGaO0+PPcjcs06yW8PlqQFN0qZk62h/R63ZMjcx3Ou9Fd0RioB+U
 F4Zjpyh63ApGpgPpcjdhgFx7zHtW3WAs6feM+vMGs/CAa1N3QM6vu7M5kYXQrixVujgY
 p0c8g224Mvb7JTNHtLm0WQ25x8ze2z7pM1lQLOxL8ZJQlPzEPb/ad2mdgaxXI2ZLg777
 pyEasnO2Ix8BHHWegXMtr/rpZi7zzdnqnslEET/I3jvdRp8SoIvoOCCTGVZ5GyYlx+cL
 nxRLipYzSgtee/+E4iCuIu/F27kG4yOg30bBLFuZUvDAwuYfq+sAF/imLK15qjIBNaUg
 eMPg==
X-Gm-Message-State: AOJu0Yzbzkh6w7FQyCzsM6EUDcQy5y7q0WNv2cMgkKlGTaattvhraDM4
 EhDRyDhmmW8rhZBrtbuyAC7oh5MJWrAU3e3wxz0knw1Zh/+yLUUYvo3ga5UX
X-Gm-Gg: ASbGncvBYZk+NTdoNKIoyCL5nyXOi6xLwelPZ2DiMzj0l/MSU8t/wg8BvViaXzg671a
 A3A+zqauKVy9UMjS6idJkmUnx0LXWUw72P+wiz52AKG8VEek5NuRaAJfESkFy5roOd/fgo/Axod
 M8T5gYArlzEEpgebe3s8BCRv5nxJuoJpwxNeLmd4ynaN5pzlqXw6Or5WyD+A+iu/d4lB4wVXp9o
 j5D3ao+4y2S/f0BtVgZdNT+dKq/pldQQfdApzGWIpEck1cgcWqXRM0Jsr8iEOhdbPkphX0cejpX
 1j1vEpYaT3Xq493HXN8eCmfkSRRrYQG9iOffjlxMm8qWodOyK3ct
X-Google-Smtp-Source: AGHT+IFEvjpBQ5RtRjRh+aTrEuTZdEBa7Hr/SC1pMZYQ6uLiCY/bxjExqcoBFBBPTPUfjRKWlXGFqg==
X-Received: by 2002:a05:6a21:920e:b0:1f5:a3e8:64d3 with SMTP id
 adf61e73a8af0-201080159cfmr18804356637.21.1744049630246; 
 Mon, 07 Apr 2025 11:13:50 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:1184:2614:d863:8ed2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7absm9084572b3a.58.2025.04.07.11.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 11:13:49 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	rakeshjb010@gmail.com
Subject: [PATCH 2/2] rust/hw/char/pl011: Extract DR write logic into separate
 function
Date: Mon,  7 Apr 2025 23:43:27 +0530
Message-ID: <20250407181327.171563-3-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407181327.171563-1-rakeshjb010@gmail.com>
References: <20250407181327.171563-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

- Split `write()` DR case into `write_data_register()`

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
---
 rust/hw/char/pl011/src/device.rs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 87153cdae1..bb2a0f207a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -221,12 +221,7 @@ pub(self) fn write(
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
         match offset {
-            DR => {
-                // interrupts always checked
-                let _ = self.loopback_tx(value.into());
-                self.int_level |= Interrupt::TX.0;
-                return true;
-            }
+            DR => return self.write_data_register(value),
             RSR => {
                 self.receive_status_error_clear = 0.into();
             }
@@ -307,6 +302,13 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
         u32::from(c)
     }
 
+    fn write_data_register(&mut self, value: u32) -> bool {
+        // interrupts always checked
+        let _ = self.loopback_tx(value.into());
+        self.int_level |= Interrupt::TX.0;
+        true
+    }
+
     #[inline]
     #[must_use]
     fn loopback_tx(&mut self, value: registers::Data) -> bool {
-- 
2.43.0


