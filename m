Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3A2C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyv0-00029t-GJ; Mon, 20 Jan 2025 16:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyub-0001cU-GA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:25 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyuY-0002x3-Rn
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:21 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso10886783a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406937; x=1738011737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptvjzIuVDQT2UCn5M7MTp4nlZSIRLqW4pGkuqXQqZnQ=;
 b=gWL5oCrMq1p46LoYyWfGNHlihzfQlZ78aMZAxao9Sermz0HFtyJ+uE+lRNYDVy3d7C
 /UK8T4/yfL+t4LKMDJMf/FfubZ/CZD1dL6tl7eT22f1oFezX3Ki32KKXvXOhntp9LkFI
 e84qGhgWbPd6cB0/IragWLYrP6uZxZjB8wfiJprnl+Wwo9P9YPDpkMWs8dwQIsO3E9uc
 8TbBg/ngylzoAhaolDNC6h8HCdDNP0CzBgQdJL8I+eyaEvWO5JtWFYIE5kiy15Zuujz6
 S7Qt57dOJzftAp+cVe2Cz9o1ANBKhHsc65ybWWvbxDfJ5yPjtYT6yqjpkYQFXtn/q5br
 CD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406937; x=1738011737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptvjzIuVDQT2UCn5M7MTp4nlZSIRLqW4pGkuqXQqZnQ=;
 b=xCdufuqjsHgHMx9jk3mJbDmPf+tOdh8e1LFj0UyksM5NaJtbUnBKkdFbB7IOr94BSM
 D6jg/o+freIwO4I2bYuydlq6A7Hhpt8sE4pzJwyFkIKrd38Lb6GNK/527TmTo8+16xLy
 ignmCW0lu3HuTQlNjaTOLB2zfQQ28XnVHues5x3ICga3fUAXzd8CQ2TnyIKhnEZ+NhKL
 ilg9vv4yeWaEtk/g9H1isEUsQVDjJv9J2q09dX+e9A6q6GVficYYcYGq5/iQ0Qu7wPEl
 5vzGSld1Th/tKpDq/1u2c6Zx39vM0B/JgyR9aF9UePWVBVOE7uiyhhHCUguYQUSfrbJB
 dkfQ==
X-Gm-Message-State: AOJu0Ywrzg6Tw+5BVQbzQXThk37RHBmqLjOlbxVTl9/t9ey8bXUX6hfa
 DK6LhkObUrpv1P1/xDe6kauC5lhUj7k4i2Mssi9JX8P9tmvO8gWAQCQrk8BS954=
X-Gm-Gg: ASbGncv7g/lt2p5ers9ErkXqTQvCx6EZZnYMp/zelAFdNvVB2YFjF7uKILFLr+V2uzR
 YxxHYZ/c63CeuIOg4OFCKQ7rwgCndqSkli13pr7UNF73MLInnCloDzIqzbp5yHU3ooKIFul04HG
 oau5SFDFLFeiPQoxO0wANXB02E2Mmma99ZlfVcu3deq0Tk4OPkAZQeElpNlsmNlnM+ZxPBfs+UB
 3lPmKb3FuPC5NV3k6cg9NeZoQUlDQJBucOXT/eLXy25argc3T4oAarxVS3gEXWXyara
X-Google-Smtp-Source: AGHT+IEy6CTvXjpH3hwX3WPd1J9MHnIjPXw6R7FGXXq6DCTUZoHI1DScxIs5x31kXdC4Odk5G/Kv8g==
X-Received: by 2002:a17:906:794d:b0:aae:8687:c41e with SMTP id
 a640c23a62f3a-ab38cd913ebmr1339787666b.26.1737406936897; 
 Mon, 20 Jan 2025 13:02:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223f3sm664050266b.116.2025.01.20.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 380E15F9F8;
 Mon, 20 Jan 2025 21:02:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/7] tests/qtest: simplify qtest_process_inbuf
Date: Mon, 20 Jan 2025 21:02:09 +0000
Message-Id: <20250120210212.3890255-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Don't both creating a GString to temporarily hold our qtest command.
Instead do a simpler g_strndup and use autofree to clean up
afterwards.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/qtest.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index e68ed0f2a8..bb1efba9fd 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -763,25 +763,21 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
     }
 }
 
+/*
+ * Process as much of @inbuf as we can in newline terminated chunks.
+ * Remove the processed commands from @inbuf as we go.
+ */
 static void qtest_process_inbuf(CharBackend *chr, GString *inbuf)
 {
     char *end;
 
     while ((end = strchr(inbuf->str, '\n')) != NULL) {
-        size_t offset;
-        GString *cmd;
-        gchar **words;
-
-        offset = end - inbuf->str;
+        size_t len = end - inbuf->str;
+        g_autofree char *cmd = g_strndup(inbuf->str, len);
+        g_auto(GStrv) words = g_strsplit(cmd, " ", 0);
 
-        cmd = g_string_new_len(inbuf->str, offset);
-        g_string_erase(inbuf, 0, offset + 1);
-
-        words = g_strsplit(cmd->str, " ", 0);
+        g_string_erase(inbuf, 0, len + 1);
         qtest_process_command(chr, words);
-        g_strfreev(words);
-
-        g_string_free(cmd, TRUE);
     }
 }
 
-- 
2.39.5


