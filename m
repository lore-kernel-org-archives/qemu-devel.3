Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D25CD47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtK-0004fW-3N; Fri, 16 Jan 2026 06:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtE-0004E2-2P
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:16 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtC-0007MJ-3C
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:15 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso6848255e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562471; x=1769167271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DG6xVSgLd1ecTCM0FB2VlxI6VWJT+wNzYdwEngDQW+4=;
 b=zwFqse9MdJBjIchZ2WvY0HZdpYcsnX7iO9pgn2U1gCzTB3mFeXk79ozZZ9K+367Ett
 VLE96NmIPZ4yZQkUt3A1K3jk9uDCF6YjIeDlqHxx9Zlrw2w3yA03PZ332cLTmYWYLkTI
 fvT9czBpZl6I32h0lBBJOQJuqWtzVYxMeuV+3QAvAIYH2+Yf88vd7iStms5xQ2y6gaaR
 s1TqhdByVfhfVVgS6oasur3f6Uoj1KdgAWTijLEvH9C53cKX/er6o73nU6SQ5N+qvsTG
 KdoW3QFRAyZSkr2X1D/PPs4EwicYyVolurbN0ltaajJzojeS3K+mvYwzAFgl/Vq5Qv39
 lQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562471; x=1769167271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DG6xVSgLd1ecTCM0FB2VlxI6VWJT+wNzYdwEngDQW+4=;
 b=B7zp/LalSeoKEWt52d/IMRpB9bNj9I7gtPZbmnIGlS0/YKWTnjpmksHNb/A2mPBMOb
 rqgy3l90KTqXTfeCUWDKIs4KZStwkUqN2plUE4YYI6WGJUqudtrFZExW2Nuo9+wLiLNN
 F8c71bE/FLFod4kyQAQRPeuPCICOpuW/12xB9tb/6o2t/m40Hr8fGBEjFHqdmPfsaZUw
 +DCsq1CBYhrqSvCL7SlKnjqFgtODEZMshcUtAVRyKpR3e2/HxMGsCGEtbclbVdbdy7He
 ubminZcdEk8hxAdiF/Uc2LSYMTiNNZjFCO1ZOzjt2P42qieOD8DJZIQWViKV1c/7pyU7
 VQug==
X-Gm-Message-State: AOJu0YzbbTSAbU4AZN74np4NfzSMYyXhUvitC/WgP0t5pibRd1GJj5wD
 JOK7EPjKfz7alwQjDskdmdcZn/XPOCHcPK3aB5m6+C9hYQdO0wGQpE/0SR3afY4X1gpl3j72iAj
 0A5NtHpA=
X-Gm-Gg: AY/fxX5QdyIZEZ9Fq3TCdtQujPJUkdri63mZod6PJXRAjmwDuvsJJbFzaLxRGTDflRi
 fEOr4mC4qqvN0c/Dk/MdMX497GQtCr0WiXF+6ira7dOHMEF2pUH0/f/5nlEFwiQBuT1Zy4n3O/g
 J8BNlkmkJU+oAvLfN1jjI4MooVSrFuCKvORCbMpAugZ+bU9xokxVAYJUPVmfC99t1cMqt0yK5C/
 S1jBP5wuiUw5TWcJRRXIUcdahJaTBsKk1VROuOBedl+tMlK/1uv1sEXjNa0igvw/qFVQgugijct
 QUk8Hkfj2H5zoq3iP7AGJlaXmTRyyKAhbz4Zrv7ZcKMZ40CqeA4uMeC9g5YVFYgEbJxmg6uTLTg
 Bfo//E7kk7EgTi71OAs6xAka/l8RoXsyMMzPIveSqRKtCgVmmjXUha25H3LFVeDmm8GpKkBVSdR
 vqg2g4mc02li+uCg4Id6Fl1B+nwEjTYlNLS9/7bKjcqND47kwD8QrSbJjcdXO/
X-Received: by 2002:a05:600c:8b64:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-4801eac0f22mr24726705e9.14.1768562471174; 
 Fri, 16 Jan 2026 03:21:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8d77besm39553365e9.14.2026.01.16.03.21.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:21:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] hmp-commands-info.hx: Move definition of "info accel"
Date: Fri, 16 Jan 2026 12:18:04 +0100
Message-ID: <20260116111807.36053-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
inserted "info accel" in the middle of "info sync-profile".  Move it
behind "info sync-profile".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116005050.376616-2-dave@treblig.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hmp-commands-info.hx | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 41674dcbe1e..74c741f80e2 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -267,18 +267,6 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
-    {
-        .name       = "accel",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show accelerator statistics",
-    },
-
-SRST
-  ``info accel``
-    Show accelerator statistics.
-ERST
-
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
@@ -294,6 +282,18 @@ SRST
     being coalesced.
 ERST
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator statistics",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator statistics.
+ERST
+
     {
         .name       = "kvm",
         .args_type  = "",
-- 
2.52.0


