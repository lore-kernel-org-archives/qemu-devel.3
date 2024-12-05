Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AA8E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9Wg-0005bk-CX; Thu, 05 Dec 2024 05:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9We-0005bK-75
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:04 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wc-0003cj-Su
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:03 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7259a26ad10so596199b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396161; x=1734000961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxafhFvYtf9jVszuSh+7ZDIex2hyUu5Kz37u7+ddEIU=;
 b=QEWn2cGDg/kUk9L2twWzJW6XeZ3f9WNhFNGQwxemsK8jHlqBS/Dq+xcKFj6Oe1zRLT
 LIZDCj1UyYQNjINn9g5+OaWpEj7d/hUGXVFgK5eRlF2+1YB+iLu9rHPw5oKYDps/PED8
 LxJJmHMatw1pH5/8lzcgpMRGeN8KXu2kYOHQi9b8WoW34nXoq+iy+qkUCgcQVDCkzvPc
 D/Ye6DX1JR+X7qLOIHedJuvhEHDNCv4VQpg27X5MsEseS+S9OYl2vfK/QPbwpgxc+bqp
 25b/ch2GAh+8uFQ2YU/wkkdoT0P8B69T4wtf2WyBhGJ8t4jb+rwhztxwYh53ZJI5nA9Q
 TWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396161; x=1734000961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxafhFvYtf9jVszuSh+7ZDIex2hyUu5Kz37u7+ddEIU=;
 b=tFZDH5TAjdbLn/RhsprCMsi8L3mt04W1dOQklE1gDQaxQFyiIszbSS46gFk3MjvRDv
 GSJxiLqSngC/rznuVek9Bp5N20g7cp0VDtz1jOCpLndazGWL2hz+CBiN9l8USUWaVodW
 CyEbVP20pylrqIb+wN7NDvQwM+JvyutWNfJZQBkvLmOG4ZgtSRpw0bSuZJGqrFXGA+TO
 S/YHAgDL3yQYj8u3EFyRVU0AKxqFaMiYRCQWXNF76HSsTRVXekLRdF2qFFv78yig1BSw
 g0GZESzN6MRtWfUK8dN1QA09Q60zjpE/5FU4LnY30Ss/rf7RUpgxiyg1DgJSAnkbptgp
 qjDg==
X-Gm-Message-State: AOJu0Yx21NebEQx51jdO1vys1UNYozqiFPO4TuWTXvESuQcOv8Ct957t
 LW9K1l3ToTf7a85Qz1IgpEp5YYogVgsic8TGdXQmsz9lP5BJfnWLhsRQGKyMMQ==
X-Gm-Gg: ASbGncvH+x48rgb+H3p5NnFzniHL0/cJVbh+MCC8u1oYTlbiD/kXR1fLvDeCy2AlVpv
 i8mPrIQbtDUpLu/XUV6rvoEhSFJFAUCwMHTakJz9roCG7jth847WeJkeR/InG06q1ExZudPQKCj
 /GcnWmqGjK+TqQ3sAaTMaSqIhvCnWZ0TwAgWB5lMQR8B3Pqe9SUVd0T8zbcQSvHXblLKcTKiyId
 CGvXlMncPcqmKb5MzDjoUvz/O+RAU6wLL3y4SQueYMUjh81FdV/BWM0rw==
X-Google-Smtp-Source: AGHT+IEkD3tQsDEgh2ZuXMRKWxdFb2cm2O7aRW4deG44fcNagjy9437lUqcQScd76khla5M+mZ7FVw==
X-Received: by 2002:a05:6a00:c86:b0:725:8edc:948a with SMTP id
 d2e1a72fcca58-7259d634437mr4087780b3a.8.1733396161245; 
 Thu, 05 Dec 2024 02:56:01 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:56:00 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 05/10] vfio/igd: add Gemini Lake and Comet Lake device ids
Date: Thu,  5 Dec 2024 18:55:30 +0800
Message-ID: <20241205105535.30498-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
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

Both Gemini Lake and Comet Lake are gen 9 devices. Many user reports
on internet shows legacy mode of igd passthrough works as qemu treats
them as gen 8 devices by default before e433f208973f ("vfio/igd:
return an invalid generation for unknown devices").

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e231865d72..ed236f443a 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -81,8 +81,10 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x2200:    /* Cherryview */
         return 8;
     case 0x1900:    /* Skylake */
+    case 0x3100:    /* Gemini Lake */
     case 0x5900:    /* Kaby Lake */
     case 0x3e00:    /* Coffee Lake */
+    case 0x9B00:    /* Comet Lake */
         return 9;
     case 0x4500:    /* Elkhart Lake */
         return 11;
-- 
2.45.2


