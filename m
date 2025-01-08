Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F0FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKb-00044Z-4q; Wed, 08 Jan 2025 04:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK5-0003ut-6H; Wed, 08 Jan 2025 04:25:58 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK3-0004lu-Mf; Wed, 08 Jan 2025 04:25:56 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso24189511a12.3; 
 Wed, 08 Jan 2025 01:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328352; x=1736933152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwXzEhTAhGKIo4AswhlvC0Ew8f+aipAHcykX2e2ZcNs=;
 b=LYNt0DkYgosJXBySE2+TDhbWtejJADoEC12EKQ0tDAocPxhKw0nZVtlFhhlBEe9EmI
 8KeR3hn7a4wYPZc2Ewm4vQRtvbz2FaoYN81F6NIVZlJI2KMM3wpYO0L/stFpznmNPQbL
 jyvlRTNmboTZDDoTy0Rw+u9WiHNiXlghbp7/Q3ihPUmgv4Qu8X7Sj3lI2RmBVh2N3XLN
 Nj/mUXlAf/i3Ker4Z6XqwnlIiZHgqVMQ5cnYc/mQK1tam8wyj6wtuG9rAE/ctrtjgFu7
 3A2hygWqaHttI+yDJwqSm5JJ61ukzqvDC3SOvBarz2s2wCdWY0V0aQK1VVsByK3GH1l3
 67aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328352; x=1736933152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwXzEhTAhGKIo4AswhlvC0Ew8f+aipAHcykX2e2ZcNs=;
 b=P29GVU+tZxF2XUzHySmJ/jbeZFMpuP3wm/Rtv1bwPux30bFv6e7Mp4ItYNZsen/wnp
 xz4N0YgoepdVRd1r5XqjUM18neVlFRIv/Z+ckvbnNLYOeTnUs9XH2EjBgjX/3Ehe/5+2
 NvFa5fy0vTIjJtSVnGBjpCGfJMTybVZWz0xf+HKG6fFJckaE2ZZOM3yZJBQqWFbeWA0R
 w4pdlXlMdinT7aJ1QeDUz/TNZG2PlnSy5HjlCbIE7Dq8sD4nspOOTOvbE28/BBVeQ7zk
 H/GKcJz+LcbgWOXM7nCOceWpZtO3q7tZngo4ESJZDdxaSLLoGcvByzwP1j6f237Rehtz
 wO3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjBtYaLD+gvDS6TNBo0ppbDlln9G4I151ULJZrzbxm2tqqAaDKd986tJfpjUWfaJkB+znUVvjOWr8aqA==@nongnu.org,
 AJvYcCWuJlSGLrtkXtPDBSwDI5laGJKwZ7d/PZwxNNO5uDI8V4vpP9cyjQmb7ab/+JydzHXWFiSYT9oaSA==@nongnu.org
X-Gm-Message-State: AOJu0YzxmeXUb1ClebA1skWlf9GMWOZUBj2RE+RPRbJfQ2cZmMqu9khS
 GHM6I1gVqYgPuoqGQXXKKBAajpnrzdbn0Zvvz1V9fsgFIEYQ191jWeOk+mhZ
X-Gm-Gg: ASbGncsrGuEcdfPd5ph1ol5oyOSfWDKuM43Rrfs3Dr7IMi61Q4prqPQAlWxGXrMvC2A
 CgimEPGavdXT0+Es1aIYeO9LvJoE/TUCevg/cUruPI6EcyjtZzUv77BbHjzIgwmoCGRbT9iq2WH
 TOdEjFo7Y7V02yO/UTnRAg2sXU5sXakZ0Tlc9sWc2/HjfOFQpezRltZHhkJbTwN0l6pgFuCgtL9
 vQ2uhigNDCVyHouD+PaFyt52lKVAW0RQJ/XVeewkvrssDCamKnc9IN9rsuiQ59c0+dldtmRcv3S
 Es/8hWGsNvZecGyC3HZCaB38PweQMczx5gFAf3h/x+pbTe8=
X-Google-Smtp-Source: AGHT+IHooUNtU1SHuHJ8W88F7WGBPnxr1ss7L89Q8JzHOKPTP+CE60tv6LlDF9PydNLMb5WFTAcL/A==
X-Received: by 2002:a05:6402:4403:b0:5d0:e9de:5415 with SMTP id
 4fb4d7f45d1cf-5d972e08601mr1558175a12.14.1736328352217; 
 Wed, 08 Jan 2025 01:25:52 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:50 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 02/14] hw/char/imx_serial: Fix reset value of UFCR register
Date: Wed,  8 Jan 2025 10:25:26 +0100
Message-ID: <20250108092538.11474-3-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

The value of the UCFR register is respected when echoing characters to the
terminal, but its reset value is reserved. Fix the reset value to the one
documented in the datasheet.

While at it move the related attribute out of the section of unimplemented
registers since its value is actually respected.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/imx_serial.h | 2 +-
 hw/char/imx_serial.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 65f0e97c76..90ba3ff18c 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -109,13 +109,13 @@ struct IMXSerialState {
     uint32_t ucr1;
     uint32_t ucr2;
     uint32_t uts1;
+    uint32_t ufcr;
 
     /*
      * The registers below are implemented just so that the
      * guest OS sees what it has written
      */
     uint32_t onems;
-    uint32_t ufcr;
     uint32_t ubmr;
     uint32_t ubrc;
     uint32_t ucr3;
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 12705a1337..f805da23ff 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -159,6 +159,7 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
+    s->ufcr = BIT(11) | BIT(0);
 
     fifo32_reset(&s->rx_fifo);
     timer_del(&s->ageing_timer);
-- 
2.47.1


