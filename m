Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F0CE64AA3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4Z-000810-Ki; Tue, 03 Dec 2024 08:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4X-00080O-Jl
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:13 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4W-0001Fx-6e
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:13 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2155312884fso38388175ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232970; x=1733837770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tMqvex4RuMXL27s3iBwmhMpuv9eZ7sBnrBfQ8TBDz4=;
 b=Q4DN9LQNJgmKZpVhNCWm43buVOTxbtNnE3Udedc5B1KEAmwOnOXI2L7/BWI7UxF1wh
 nCzHOOH0v7MdMXRi0vTs/hOvzdLTrwcIfU7t54ZY0JZIBggJ5OCVE6YLfkT7sXD8XSxZ
 svLS4loqZL30Ajad8WpePgpwk7IivB0KjCJYuMamYd8dg7Y43Z72CnVgHtGSN+E/PnbA
 GfY/mHMRowzfX4gpkZCHqqjhhKvCTc0N6G+uWzU6I0WAWvKBwz04U11JsmUqwTDUvOHu
 Z5SP85WygSSyO3/SYtPC5MlYj90jx7qkYlikDk3g8aB+6YnMI2VriyQlKwgdGGXjC8CU
 slBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232970; x=1733837770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tMqvex4RuMXL27s3iBwmhMpuv9eZ7sBnrBfQ8TBDz4=;
 b=kSahAtEpJJx12Hos+HqPVr6U0gx3iRZIX4/TSzAo5HZOBXsxaEYTxTeKg9mZAu/Dig
 yxWFQUs1EAaZv0WmGfpMHouA3hRTUUnG0k+skx0jAXR5wH7oK9p2ptj80mBO+R6j+Im0
 BMAK3Ams4FaGGqSNGe6XwBMePvHYfMQpgfT6vaudm5Pw4wlQeplafVOTMH97Immf7EsU
 snvcTYg7DBe3tIP6z/4Jn9PTibC5/EFndPJ+TLHIwkHGYe3yyz9LxxA5nKRutkILKSkB
 lnSS4b4mx1VQd9WC6Qu9XvxASCaVHWPf6otnUB8zf7Kl6f+3OjljUYNtXpNsqmwRzw+e
 ytEQ==
X-Gm-Message-State: AOJu0YwBfNGY8hy2FA/47mcWQgRUsOxMMQmEW2CK8MDyDbnorQ9a1EJD
 5TVROaPfhbKRMTafF8HP23fUIcB2+x+hYYQx8hgCOthULjRTwEyxBsCIS9axsA==
X-Gm-Gg: ASbGncsQrrjz0sf7fkvpzYb8qdqoQMonqAx7dT5fStSIKNG7HRUZfL4csaKe0NfGQH4
 2n5COVVnAiNVG33xqBjhfoUc0eppb245yfoNQLyKWeVmKam7zzLJMCq/nF+q5sXlW7IaQSKYcjm
 hhN0cTST/aIfXzBFhkQKSJAz298m4m77yupeuVnW2VjtV5Jg69szUzdyucTD7aoRR0Ofqz+YFgR
 n1dwUZv14AGbiuQ2a2kSxZKt9Gb3JT/qwbWqiP+dNF4Z6Qlual8TcgPSWs=
X-Google-Smtp-Source: AGHT+IHDc+Te6C5tjWuB2vORZolpVl9YpK8G927+biuL0Pxp8OtF1D8XTK/nXryFMaFfDK8ujl3vpg==
X-Received: by 2002:a17:902:dac9:b0:212:4ac2:4919 with SMTP id
 d9443c01a7336-215bd1c9e9dmr28972305ad.17.1733232969600; 
 Tue, 03 Dec 2024 05:36:09 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:09 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 1/9] vfio/igd: remove unsupported device ids
Date: Tue,  3 Dec 2024 21:35:40 +0800
Message-ID: <20241203133548.38252-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4047f4f071..6ba3045bf3 100644
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


