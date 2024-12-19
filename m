Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419B4E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLYV-0001PP-0M; Thu, 19 Dec 2024 13:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tOLYF-0001OF-Kr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:47:13 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tOLYC-0004WM-8N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:47:11 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2165cb60719so11337355ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1734634024; x=1735238824;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s0p7094R+XWqq+F70+Oyx3YEV5bKu5xe83ZWvzAeyA8=;
 b=jtVIRCIFswwyHxG088JamyYxoS7SkWDqyXBc9KXefqbqu+KsQe1t8yKMfHXcpaWNxJ
 9m2hOsUErEDUVSsGJ1tsZxtlhBUEngPBx7poZx0qKoLl5ov/LWS65tXt0M4E0sLGLwsw
 npRfdBOT8l55yOVA45l5YmXm9a0KTjJWEIaWhAwPixB55Gspyij6E3j9/o+FFnpasPUI
 Txga23lO+0qkM3T1lK7qFCno358kr1Hpmouc4S6hqwYqpmcQz/ztP9a76v40J1NEHIcl
 FVJ171SFcOs4nvAXxc838ecin8A4G6YgeTj3eKUAB235If5Btf/TnsNU2nKTW19hSG42
 mZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734634024; x=1735238824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0p7094R+XWqq+F70+Oyx3YEV5bKu5xe83ZWvzAeyA8=;
 b=CcMZFCh48if11aKDYd8NQOLMlQITT04dpZxlLdMoyOF/mx20vx13iCVighqQxU1RML
 5/FdjA0do7PIXfxrIB9IcDHQnfudOp/dZHCOUYIFo5VNyWFVGu8iA1PY9vA46QqnYO6V
 q4DLn0FAuAo7KHXcLKOx31F6YsLDjeDafRDfi2qHP7EYies7OdEHOuZHKTk4cT8NTYEZ
 WetHL1D4OYonERg6sIj+dU27+d0dr88kraHiT9Mim6ZTaqAsutDTRh9ssB4fMsRH77GS
 dVXz2bufvPVqg/fUSqvomUJTbVAz/xZyT7lrlsAq2KGJGpDWLMybCT3hdKqHVXdm/VaC
 51MQ==
X-Gm-Message-State: AOJu0Ywv1TTK8+SodB8LODgy3gtEFfsfZv+e+9BYBBbkxbibbmZ1BQQm
 3P3XrYnUPxp/iuKO7WBoWLQsiRngzCUeNQqfj55MJCyD4ZXLZGY+RNMSNKwsbf5M5MOINVJJ0TE
 SoytoVA==
X-Gm-Gg: ASbGncvsC8NmLhdBQHlqMEMPq5Rk8tpCazB7dX5tfeanXTa773ytcg3EgBYr1UOtdYa
 fDE5zIUptjsmq6aDySY4VbMMVKU4vfeEpmImu3Rrm3qk/i+VZR99bI0ODMFNz3H+Sz9gXk3TpPa
 DYErCPvztxPXEnaxiWQrS4aNyDz92+2XboHbiKjTzbgd5KD2fYHMQc4jwXFXLivCi9M9jv0J1GN
 9HMXG0GU0zom/A9wlNM12+fd0yqmT3BW3xjR746k0p1e/nL/UA2SzsLSpTAemquU5Q0bX8=
X-Google-Smtp-Source: AGHT+IFsBwtwYOwAOGGyaYd+yEqqociwCf9oj3HSZkTJA8GRgDuiSxxNFOabwkDtMbxBMJZi281wOw==
X-Received: by 2002:a17:902:db04:b0:215:a2e2:53ff with SMTP id
 d9443c01a7336-219d9617e99mr54652855ad.11.1734634023959; 
 Thu, 19 Dec 2024 10:47:03 -0800 (PST)
Received: from localhost.localdomain ([171.216.138.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4c73sm15252875ad.121.2024.12.19.10.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:47:03 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH 1/2] qxl: Do not use C99 // comments
Date: Fri, 20 Dec 2024 02:46:57 +0800
Message-Id: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not use C99 // comments to fix the checkpatch.pl error

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 949949d374..ae2d983299 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -50,7 +50,7 @@
 #undef ALIGN
 #define ALIGN(a, b) (((a) + ((b) - 1)) & ~((b) - 1))
 
-#define PIXEL_SIZE 0.2936875 //1280x1024 is 14.8" x 11.9" 
+#define PIXEL_SIZE 0.2936875 /* 1280x1024 is 14.8" x 11.9" */
 
 #define QXL_MODE(_x, _y, _b, _o)                  \
     {   .x_res = _x,                              \
-- 
2.39.1


