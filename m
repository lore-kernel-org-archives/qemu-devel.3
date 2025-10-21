Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E26CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIW-0002GU-56; Tue, 21 Oct 2025 16:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIF-0001uF-Ka
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJI7-0001Dq-Sc
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37850175e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079748; x=1761684548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+cOm69gp8RtXa1qAAfK4fawY1gQ+HuTw0UpUvx18adE=;
 b=qAUPiZxihivV6duvZoWkLBmXIqTZvTYtYIAqRxwpTSmAWvVJAUWdiIEKEV1Mv8oDTT
 jxP9jU37fGmDg2F95F/5ZiJLAVuyJXfxaYAFe/LfiwjvjHYqE4h/N7sB3DV+FcaIq28K
 eOsq06+CXxG0b2VlsiaFh/32zkpMxWIwD+BJDuwct5Ne4lGNK25JB+z66J0qTA2E/Yj0
 xX/sjFVzgRKBz11u62LyKU2ceMdTCM/x9l5AuZ1OqvkvqSEsE9VUnMw1hmTB9oIv6RDD
 QsSEy1swXqm0ngeYezsO24jzT3fvcCvjrVwKJWEYRapKUxm6xY5IT0s71zd64n/sen4u
 UmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079748; x=1761684548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cOm69gp8RtXa1qAAfK4fawY1gQ+HuTw0UpUvx18adE=;
 b=p+qxkqzIaaAbPAHIsleFsDonDV4c6dX6Q7ZJToM5suJvMu2jKoc07tmvnumFw+Wm+8
 ufZhZcRSitaklLNWvka2vHMHmp7tgcDRGtrl9mrfae5v/zD3Oj5TpkLfXDamM8Ogldsh
 78s02yaezIwqw0uj3/Z4PrYnHF9RXNWrv2EZAFwdCikvyevdATyw45WcytPvFjs9Ov14
 azg6AEw/7u3WNxELDStW8llKAaN05TEFNw157Mb7hMcMAWoOIrlwZqrkfjju6lh6MFF/
 qNOS3k629IvZv8R4FpqzJM8mds/vrCzEywp0iHWV/Va7ldIeuKI89SqtGjyQpUD5J5wD
 t6lw==
X-Gm-Message-State: AOJu0Yzv/4EZuU5aa4VLGvguElnxi+owW91eIH6EuZ9vjpADGMrO66WN
 ifgSTgK1FYJeY71SLa02FlpAXxVw4u3y4vAMoMs+uXSGF8/m6ugWChfBxb7uJ1VtBmBIU9YWeU5
 rK7SHaBU=
X-Gm-Gg: ASbGncti1Vrv5+3oXyiO4Tx7E8r2gXoiCCvoIaSb0KY0l8O2kcmb2dasUcVNn/p0C/A
 rWWzZhZRMUOdDW9PDeGMAYxj+8kuwELcP3H6gQPscpuTQcnWozDGypYrsEkolETrbFLMl4RS3+Q
 CSgrh6HtBdEPuZZ1ijF8zmsbR+rQ10dpTmZXtyI4oIUO7NL8lyOagahhpaYqZhS5+OnvWRX0049
 3TMga7lC+UAcl9Og1t18HwpHLP6yITPB+CdFKyZ+gwTCZdfkdI8+QHOD/gA25iXzPnZsJl5TqtZ
 11ntbSabEXIDmUzPoUHnfSYN9vbRooqS+FOSjI00KZmFpRjbboeYlBJv3pXt0OqxY4EvMpPk1pS
 4NcrO3gR7CMhRrwH2a3bKxYCf27qNBTw3oP+F3x0wKISvZfAVGCJmwRJmI5E0G/ZbsRnpphGNKk
 j0wzcWLR/sFfdRjUWPq6meLTVKKHZJGPx2k8pK1MMP83OvEhGsTA==
X-Google-Smtp-Source: AGHT+IGH2WH9rt4xT5MElTptAVpFCrxyxM2OAreopV+TB4rOZODCkC697xGnuPcEXQWgilihapYPCQ==
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id
 5b1f17b1804b1-4711791fa34mr132500195e9.40.1761079748363; 
 Tue, 21 Oct 2025 13:49:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428e9b2sm9706715e9.5.2025.10.21.13.49.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/45] hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
Date: Tue, 21 Oct 2025 22:46:41 +0200
Message-ID: <20251021204700.56072-28-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Avoids the error-prone repetition of the array size.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/mc146818rtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 61e9c0bf99f..5a89062b4c5 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,13 +726,14 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr <= 127)
+    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
         s->cmos_data[addr] = val;
+    }
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
 {
-    assert(addr >= 0 && addr <= 127);
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
     return s->cmos_data[addr];
 }
 
-- 
2.51.0


