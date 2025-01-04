Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E742DE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz9A-0001Dy-4S; Sat, 04 Jan 2025 03:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz92-00017x-KQ
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:04:29 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz8z-0000V9-Cr
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:04:27 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so14844527a91.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977857; x=1736582657;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6KqNbJ0icnUmTbOOjRCVMq62RIgVG9Rp5Y4iFoy83bY=;
 b=BiljICQQPZS7GkRvoipsfgJQKUawHOCHNsPXO6onvhoH0D7rjsnBhLvsae28JsyEYg
 6T4YnwA8CrEAEbJNmEiiazaFu3rUcszpMmAwEKPKoNPtVEO/EvoSZQ1ZcTsSgaNZqx8i
 GcBT2JfgJIWF+bFcrYMofje7Sjrzz/Dgo4g5uR8Bg8IDdQcipDimeYKe+1I9tGEOT0y4
 2II+FnnFPScTrc7769txGJWUBEH+1E8/as7JvDL5UvyDldtJkslLVQfXL9ENb0Cg0HEZ
 QQucgnOUegkmpRxBoQfgV3GRKWeRHvT1/GMQDBsn2AAFdJK977R/QJo16Opfl5RJOAAo
 pAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977857; x=1736582657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KqNbJ0icnUmTbOOjRCVMq62RIgVG9Rp5Y4iFoy83bY=;
 b=EaXEHfxUmkpgfAXmq4MOXrE/elukGWWsjFT4Sh2DZQhbMXIG1cIWlOxJY0GutbiMbw
 0BlG0ALwMFjfyfq4l+kflqaySopYiJqWB/fH97ckqXO2Ro4RKGZS/OXQAfupkRmBSkqd
 J+xqFz8QNZtlSXMiiAN7u3qjFZOl5soTIyl6tEPYsAUE9/qLZXhdNsZ0JB2CT3HtKI55
 6LCosN4U0Zjhz+S0v6M5kTSwc+7ErELNtTIJEZJ+COyyFj31Z3+HgU/aJ4toVA/xs9DF
 Y8bRSwMZskksdP1dNgkMrP0JIPHqqlFrmhjXIb+PiWP5FvIgwLbg/M6A/sBlgG4hrZfl
 h5qw==
X-Gm-Message-State: AOJu0YzJC8g5Fsz7M32b2tu5E2n3LPhXVTH+X5jUMbhj4B7vQzrl/foO
 uEWACJK4eJG75JP4s8k0lSAiN1dMMWnGiV4RPwB0ZhWucAHLsQ2DvtX9N4LiU2Zxr4pggX8nQOL
 uq0E=
X-Gm-Gg: ASbGncsJvHxuz8mHbmqwQN9334rzbPcrnwt4Tn84YS7n4BzHoChGmnzeEF1yrgVGN84
 ceqN1wbdduVFS/8ozcVcamfzZ9uOjXp9B5AkEWkMzspfwBbuFJKY5Dl8LO461E8+9MdlVHxTMuu
 81XJDPYdUEmoUi/78vLfa0TYKAgdYs3qQJX3c6sCjyBHvlzd3Gh15MP+jgmMjbRgDz8rblvonz5
 Qp4Jb26CZr3944qvEGGujJQCJNJh8TLLJGtMbZRJCjlJ1vEp3E2ZieX7CFj
X-Google-Smtp-Source: AGHT+IExc4Pp0+LYrBmrsqFThpH0Yw38OPUuv1K5uZoLNPg5kjWLVhtn2Ojm3hnGW1PoyNpT5D8XmQ==
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f452eed773mr69371044a91.32.1735977857379; 
 Sat, 04 Jan 2025 00:04:17 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f4477ec330sm32706818a91.24.2025.01.04.00.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:04:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:04:07 +0900
Subject: [PATCH v2 1/2] glib-compat: Define g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-glib-v2-1-12013f3e5782@daynix.com>
References: <20250104-glib-v2-0-12013f3e5782@daynix.com>
In-Reply-To: <20250104-glib-v2-0-12013f3e5782@daynix.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

g_spawn_check_exit_status() is renamed to g_spawn_check_wait_status()
in 2.70.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/glib-compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 86be439ba0ef..0bddb327bd5d 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -68,6 +68,8 @@
  * without generating warnings.
  */
 
+#define g_spawn_check_wait_status g_spawn_check_exit_status
+
 /*
  * g_memdup2_qemu:
  * @mem: (nullable): the memory to copy.

-- 
2.47.1


