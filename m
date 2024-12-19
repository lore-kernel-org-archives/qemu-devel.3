Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E8E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLYL-0001Oi-4k; Thu, 19 Dec 2024 13:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tOLYF-0001OE-Jt
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:47:13 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tOLYC-0004XA-Hv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:47:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21631789fcdso15302455ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1734634026; x=1735238826;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hocOqJxHvogs9Y5+bpoc6lapZ/HpkwgmEX7qMs2ye50=;
 b=lfx3r8rbEuV+1mBigapYwRsoXtJX3PQf8NsZFlZlHtcPcAzBdTe1H0ey3TiMo0uhf8
 CCoaH53/8bMbpuFUBzuJ2iFGv6crB9nJfrHUW/2zieWW4TGiYjy98mcNDSvpeye4TgjU
 mf4x4uxfHWhsfPzRl8Fmrs6V/Jrq1jK4pV3uaG+jHVdYc+Ja7oL1Nb7CjCHTO9Km/L+Q
 5a2AaueQ+lGPP92CS/OjQu6t0OOXwypeBxedIuke/fm3agzU8h1DpLeT2Gp6n4IwTfcn
 sD1P7vUwgfTznO+/OdZwHJ6r+AlpCueVTkgOtndxiQcUNXSTd7Esgm3m0m2Giix7nE0q
 uFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734634026; x=1735238826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hocOqJxHvogs9Y5+bpoc6lapZ/HpkwgmEX7qMs2ye50=;
 b=j2AFxaXWh+rXeZYW8WmXBUcIb6K5wWgX3/unxkDWStQHXlsHyPsCUAIySEycbq//OR
 KuyO2tCe18k/OS3xr/5NVD+j/KVdTAd4CMcOrSiFJw9riSovnMSHl8I+pE7bfS7Ue3+j
 PRUgrYVUSDZWtrzIIMckRP37vfcs6mLHQnQqyIxLlPkpJy/nt2OHrmk3oqoGbGQZ0HP5
 P9CaOYSUUQ4be31tUuKHxkBA8Q9Xf9KH3kUKrDsPbdID2wYhr3JSeVO8rHvbOqgJtfL5
 WQfp/h5eSvLweE8AGwS7leOB6JRuTTJ7gdznGglEo8f14hbGUrh/71PTuhJGiH6b07vD
 EyLQ==
X-Gm-Message-State: AOJu0Yzl+IoHnWEUnvXBf4rJYp+wfEe9Z0odwvhD1bOYdY6XvZ2OZwMr
 PKTs+s2YFk8etnPZR1pVanzHVtoc9GgYyVWcf3Ue1hh/NMlIh3BtKqyI+77nrnUZX+zWXPdrjeJ
 WgsiCWQ==
X-Gm-Gg: ASbGncuGAcXbUZj1Fmlhi740WNmSH90PDYe++F0Jh7BSeyZBiXItqEyt8xiurM6/aV+
 NDBZYBhWELKpBNvasr0osD6SdqdOsJaB1P3WBZkubVoTnZMsj5TegB5oKNLZKYkvyJNXA0E6e9T
 G0JI9NP5SMZLp5uSch2NehdxLLs9mDEQspWjwX4qbmM3RtP4ihufNE+R+3IR6o3T2kzYLK6EKyy
 PuuYlzrOEqidciPZVdcWKP1BZ3gTyVB5v/RylOAzTHRDDfnYamnXhXadw5/y5JdXfaUbxs=
X-Google-Smtp-Source: AGHT+IGRXE4We5fu0j7FYelUwF/fwPhZ9GfBiEF4qCU+9EHKv/1MARfk7M2gdYjzGNtyqCs6Rg45TQ==
X-Received: by 2002:a17:902:ebc9:b0:215:3998:189f with SMTP id
 d9443c01a7336-219da5c10a8mr58794955ad.6.1734634026238; 
 Thu, 19 Dec 2024 10:47:06 -0800 (PST)
Received: from localhost.localdomain ([171.216.138.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4c73sm15252875ad.121.2024.12.19.10.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:47:06 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH 2/2] qxl: Fix race on accessing cursor in struct
 SimpleSpiceDisplay
Date: Fri, 20 Dec 2024 02:46:58 +0800
Message-Id: <6119a51b8626575d1f5e6ac31630f88afa32eba9.1734633496.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
References: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62e.google.com
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

Both the spice server and the qemu (iothread/main loop) context
can access the cursor field in struct SimpleSpiceDisplay.

Add the mutex lock before accessing cursor in
qxl_spice_reset_cursor().

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/display/qxl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ae2d983299..d1fbeb65cf 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -298,10 +298,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
     qemu_mutex_lock(&qxl->track_lock);
     qxl->guest_cursor = 0;
     qemu_mutex_unlock(&qxl->track_lock);
+    qemu_mutex_lock(&qxl->ssd.lock);
     if (qxl->ssd.cursor) {
         cursor_unref(qxl->ssd.cursor);
     }
     qxl->ssd.cursor = cursor_builtin_hidden();
+    qemu_mutex_unlock(&qxl->ssd.lock);
 }
 
 static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
-- 
2.39.1


