Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA869CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJF-00074Q-2m; Mon, 24 Nov 2025 04:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTFN-0004bD-6x
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:45 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTFL-0001fy-Mu
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso3497797f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977954; x=1764582754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRhpOZ2IPeUGuaRRAtlX0yNoC2KCkeWanu75zA+D2wo=;
 b=jVaf9cz8ZNSCYjwguEXP1uKl3Z+n0RVOnIiedCyHI8xmpYFAvk+dZaFbX5BdWEtG2U
 xyBhl+mYSPAgzT7yNlUnOMBCT4Q6/b7TBbXaR0iB1XzKVTdJD8xLF2drvXHJDN5K+mNy
 uO7MQeBBdPZ5AglxuJTMSmflcyKNiyziut6HVZ80Qh4BDkTwts1fi8cP77RQKrC4cZOK
 ohWZOlSbBAnZt8fULP0Y+MsJWRb2uo3R3Y3v4XKjQjqyzV6wk9BdL9h09JOwl5zHik71
 IIdeYIAcYxmIYgD4HNSlLHpPooZ/ZxevJLeDs+yx3XOnpSH1wR7j2upx4/kuB/O9nGPd
 +bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977954; x=1764582754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lRhpOZ2IPeUGuaRRAtlX0yNoC2KCkeWanu75zA+D2wo=;
 b=d/bqnc54DIr35zzwuqrnRR9AA+AprMlVoT9XWBv0PpjhPdywJOaq1rIIw67KSsf2AL
 LL7TfFrylgGIQ1IZoNRDkVqch6gSPFl/aFWpMvMf8DC9VDsjOOsh3M1NAQeWMvg8fnz5
 RxK0DvoH9aEjbc3hvz0I2KJlFRlYDtiY9BkiWwMgCj+YH0I/KMc8pnjwgBkhRuv/avHV
 h1ZEqJPhINxaBp4GZBWAOI5tJoZC8uhOiRL10k6xo9W9rIst6ZgleMKk2TV6I9UC9Rmg
 XH3IW7bITwGdBJuD5ciQ1MWWfQqZtX84gc19ZUI3etGvf/xRJp+FIx1TBEffZwrrwB89
 /OqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLaAzFvtZJoNXBe6nbmBjQfk4sDPB11CZoFnIkj6vnTq7wAsk+GSEBpT5OKpBDtHGolYVKGsZjySnz@nongnu.org
X-Gm-Message-State: AOJu0YyZOqdyFGEP+2CD0VKHl2gHivnZNnXdI3pD42E5sVLMutPVzgP1
 yeXPGeQgaj/aPiwhLPUDr+wwYoRF8jZnBFEoJ8jqIASaeI/viqfILldl5XQZGNkL/kU=
X-Gm-Gg: ASbGncsSLxmXTalCIEBMXQrW7F+D+VjV0yH6RvQFe8EfO/KwJ91ib+i/r1SgeXAbWxA
 ItfD1RrOozEAbyDotMKGrZD2jqKqg1jOBR2eWZERbO2Nqxs6AEsjGPDFl90RxpH1u3Z87mSrwDa
 yv+n/rFTDUnmp9AgX9fuOzG+4SnqlhNziXMhq0Og6Z1iOs/vFXs0EQ3BoHT7UDjCC+Hv7ey8dTx
 2ggPGap26KIpas0KAzfVhLFbOTqgDiojRgJCFes6Mjnbo6zfDUQCGB8/vzALojb9yWyb00APZnK
 lYi7KTIEgZM0hfoI8K1MzTrCIg5cpzZ6Hb5FN3fDnLOTHUAqg4tOo43jFNkDD5o1PYIwHceeE5e
 uCtyHrPzX29ObdLA4mTAZztLQPEy+TOTLjW5pX9LToZUSiOymOVKEzMoF7fEXCxfbUEYbtgk+sm
 xYQfTLZD/Wbwx0plh1H1h5bZlolm2n+ordSm2n6RSUyEpfOrEPNpR6d+cshECk
X-Google-Smtp-Source: AGHT+IH1hM2dIyRXUs4GHI0q0tWK1cfmEuHIBKLHVXaY5vG7P907Z4bkaCiQILjg7HtUw+6iEDeYoA==
X-Received: by 2002:a5d:5d85:0:b0:3f2:b077:94bc with SMTP id
 ffacd0b85a97d-42cc1ac94damr11827840f8f.4.1763977954218; 
 Mon, 24 Nov 2025 01:52:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f49a7bsm27010486f8f.19.2025.11.24.01.52.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:52:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 12/13] hw/sh4/r2d: Add 64MB of SDRAM in CS#2
Date: Mon, 24 Nov 2025 10:51:07 +0100
Message-ID: <20251124095109.66091-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Expand maximum memory from 64MB to 128MB.

Inspired-by: Rob Landley <rob@landley.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index df62f7a48a9..f5bc7c46965 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -263,8 +263,11 @@ static void r2d_init(MachineState *machine)
     case 64 * MiB:
         sdram_base = EXT_CS_BASE(3); /* 64M @CS3 */
         break;
+    case 128 * MiB:
+        sdram_base = EXT_CS_BASE(2); /* 64M @CS2, 64M@CS3 */
+        break;
     default:
-        error_report("This machine can only use 64M of memory");
+        error_report("This machine can only use 64M or 128M of memory");
         exit(EXIT_FAILURE);
     }
 
@@ -356,9 +359,11 @@ static void r2d_init(MachineState *machine)
 
         /* initialization which should be done by firmware */
         address_space_stl(&address_space_memory, SH7750_BCR1,
+                          (1 << 2) | /* Areas 2  accessed as SDRAM */
                           (1 << 3) | /* Areas 3  accessed as SDRAM */
                           0, MEMTXATTRS_UNSPECIFIED, NULL);
         address_space_stw(&address_space_memory, SH7750_BCR2,
+                          (0b11 << 2 * 2) | /* Area 2 Bus width is 32 bits */
                           (0b11 << 2 * 3) | /* Area 3 Bus width is 32 bits */
                           (0b10 << 14) |    /* Area 0 Bus Width is 16 bits */
                           0, MEMTXATTRS_UNSPECIFIED, NULL);
-- 
2.51.0


