Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9336BC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lo-000497-4N; Fri, 28 Jun 2024 03:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lm-00043m-FD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:42 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lk-0005G9-Dw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:42 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5295e488248so365188e87.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558698; x=1720163498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=avuRrMAF6rH/sTJFTAsB7oMGZ0jZuIMfuK+mEn/O+u4=;
 b=AIfHn9jRFNfKwFJ4vlAIjTd7dsJ5WGVk+aiFDw3pILmWHjHF3g0R4+hxL3sQigUldZ
 cy7DLBTUCeTf6eeMBotvrTGnZWkxNaz/tn5blFn5LVe2Qmrzo7zGPkBB1pPhwUlGWf6L
 4mPgAv4TDmYl8Cln3iuGHS/j//XtbM85CIJYuvFMfkJmHaN4GnQ2XVhIObg76nPxNOhM
 GaOtIKJWRsW67kQt+fsKCCBq+3J6D2uXNOh9N4BwTaFJxruIG5ha/qjfi5UJv+YpSAot
 OGPiY8BXCl4smZBlrZUFINHUW+BIwKG+Mg5uYbWXrEMBJ9RiahQIHY/xPJe3UkrdmvyM
 3Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558698; x=1720163498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avuRrMAF6rH/sTJFTAsB7oMGZ0jZuIMfuK+mEn/O+u4=;
 b=cZ0ggTlBOJuRvts0l7FVY0eVy198KaI4WcRtAgkEjwXZ8TN/uBiOgM90TEDq/uurfG
 49qyIFH/WWuWi2HeBAzn2RvdpmSdzfOWCPj+t2CU8sEzCWMI/AIUlAvi2R8UJpZ8JIdg
 UW06LBfmvQ5R1sgz617MUQr3i1hRMv3ULWDRNIrcMbYlWxYptEWTMMeP3Ls5/9v5HItl
 My/to06oFtEn/dnW+1G748rq0opYbVp5B+8RZa1DewwpcuXRXcsAHU+Ik4Pubzn5VB2I
 /l1tqrcjuXmdyBb1DKXvMSlz2B3etBWnablRYSmSSHTRtAshrfqqMKVW1mQDJwNxMXK0
 ItXA==
X-Gm-Message-State: AOJu0YzhML6v3h6iVfyTtTz0VJANvWzXLLHQmRyAwtzMp4lB1rjaC0OP
 shZliwYFMw1bJf4Bf8fl7iyRBlSLmbXXtioAgpN+Z2umR3Ya/CV/fmGplwLTXrScHhAiZDa6OZ7
 p+g8=
X-Google-Smtp-Source: AGHT+IHTfd1dnZJCaCnrZ4MiCAnPWaz+g4XQtEKRZi2QxTvOCDZkGK4T5QHe6Z6uEFzME9Qin0xWYQ==
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ce1862c12mr11635231e87.64.1719558697985; 
 Fri, 28 Jun 2024 00:11:37 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c17e6sm21525025e9.42.2024.06.28.00.11.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 97/98] hw/sd/sdcard: Subtract bootarea size from blk
Date: Fri, 28 Jun 2024 09:02:13 +0200
Message-ID: <20240628070216.92609-98-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Joel Stanley <joel@jms.id.au>

The userdata size is derived from the file the user passes on the
command line, but we must take into account the boot areas.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2d49be61f6..bbf054ea1e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -804,6 +804,10 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << HWBLOCK_SHIFT;
 
+    if (sc->bootpart_offset) {
+        size -= sd_boot_capacity_bytes(sd) * 2;
+    }
+
     sect = sd_addr_to_wpnum(size) + 1;
 
     sd->state = sd_idle_state;
-- 
2.41.0


