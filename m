Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD739D4977D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmeo-0006E1-DQ; Sun, 01 Dec 2024 11:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWB-0004eg-Mn
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:55 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWA-0000Lz-Cx
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:55 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-215909152c5so1417205ad.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069392; x=1733674192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zc2flP+weLaeacCQlZ9Rqxnlz3dYxcJBhurwoN/GxU=;
 b=HxW8mrqnFI3xI4AbJl6ylM5jIoJ4pg4RuBserX5N+n0CkHnTHCNnvNEKMBBPIDah2V
 FI533aqwD6Cy3zPY6iX4PWSK0ss66cr6VLGS5IMRHajU6wKp6DYlNZxyZPSyZFuHXNWu
 j5sqSCnKwd1fdSrbUg+sOJ38QwBuxS/qwB38UMQIXhYA0y+CkZ9vjG0M/KG20wdIJ4YQ
 ezwyPXgPmiWgM2ubr9ReAcxPtV5eHEnvDcQXG1SG+rbEh2LDjofiJUcprmRQgrP5anyx
 oVzkQDhlcAJ3GAUdgp/LglNwIdso65qNr+kQybYrr951tmRTQIg4EDodRhcmtcmTkXbU
 np5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069392; x=1733674192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0zc2flP+weLaeacCQlZ9Rqxnlz3dYxcJBhurwoN/GxU=;
 b=cTLcrtmYawJbWRHXqkFK0gaMFAEXDW28JQ9HHGTP6W6h6zxl6F3RZTHRAOt3uOSXPE
 uBlu2hP+eekoRrphvcZh0wsuVj4NZDXe9rEdHLG0YSGb/qe0m3MdIEpxO9SvGUoD3lop
 L0OyGb/W7jK22FoswUNwZWK5PrUh4NsKaJ8POP8S75cDd+xBIfTXj2KyfQDoEkbrcNbe
 qzkCsHmFvXFl07Kg6I8b7bsBHU1UkRBlNtPBwO4rkvmGTuXfJ0LBRhOZ1Balo/suC1L+
 CN1gkxnQnN1iqb+8pa/n3nUQob/pPTafHr3Ofjs+fhi87YQXk3T+wxOoISJnL+BisDWa
 NM1Q==
X-Gm-Message-State: AOJu0YzS2jiegVyslVLymIKXwMQW+bsuHPOwNBnt+PtKvUgJZaqxyTrB
 f6B9E/G2DHeCuYesVq23TcOnQo4D4y7NIHd4tCNHsAREFFjqjL/PCrAM4UH892wB
X-Gm-Gg: ASbGncsgZIPzZofS8h1LEhSFyQEZ3Za1tzv4o2EjAITk1ZSn6JEUudYsUqug0fHldSs
 +fiOOYdDBkGihUnlMRcCJZHshMTCKjw5TQGyyy+g7sj4Ls8V9qJr2Z5245JA1thEzQqhid1RxYt
 il7Iw6liJTarGBJpqdGYquvml7Spi5vIRj+mIDZfpP0B+/hu4ifuBXO/lZIsOfgk5p0dGED0hXZ
 eOQdIt15sOUNeLkCdx12xlkB86fSNjouvITYQ/1P1i3KndnE3Wm4kj0HG8=
X-Google-Smtp-Source: AGHT+IEBP9w7/tfQUbNMxZF9gAou0F5abZDZKGUjnGU1qtijxczZvRCHdZ2l+qtCY+fRyhtmCcbxZA==
X-Received: by 2002:a17:902:cf05:b0:215:7f94:2b8 with SMTP id
 d9443c01a7336-2157f94089bmr44583085ad.24.1733069392301; 
 Sun, 01 Dec 2024 08:09:52 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:52 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/8] vfio/igd: remove unsupported device ids
Date: Mon,  2 Dec 2024 00:09:33 +0800
Message-ID: <20241201160938.44355-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:42 -0500
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

Since e433f208973f ("vfio/igd: return an invalid generation for unknown
devices"), the default return of igd_gen() was changed to unsupported.
There is no need to filter out those unsupported devices.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b449316ec0..8f300498e4 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -64,16 +64,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* Old, untested, unavailable, unknown */
-    case 0x0000:
-    case 0x2500:
-    case 0x2700:
-    case 0x2900:
-    case 0x2a00:
-    case 0x2e00:
-    case 0x3500:
-    case 0xa000:
-        return -1;
     /* SandyBridge, IvyBridge, ValleyView, Haswell */
     case 0x0100:
     case 0x0400:
-- 
2.45.2


