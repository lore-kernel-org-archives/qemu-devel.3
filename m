Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC6C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPecC-0002YJ-I8; Fri, 05 Jul 2024 04:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebP-0000yr-3D
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:35 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeb8-0004BV-UX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:34 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so18483871fa.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169234; x=1720774034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i+oRffwUlRN86HbVYMqaafbL1Oir7rskJUuAdQaFjw=;
 b=ppwm+SJsomM+1lbrpmkabKEHNZ4qNKJsnvC7Vp4rrNsFNd9FH5h5la6ZL4UX2cDE/g
 4R+M0FTrGJT5eRclbxMe0ki4iSyTHzPLZICIjZFs29Ozp/oWzWXUxN1eCJMTTR+9QOQ2
 gidjEVPCE0OZ6SKYDkk4ZVg4TzWIahLp8VUxZscBX5ODiMpG/chF2z+ZisgHwcFcHQEH
 Mv+NKPkA+2YfHQGb5LOuxZA3cgFrF/4ecnvfaCOokSdRYsib8s8Xp/xTnBCXG+qiG9Du
 OVGG6YQyEmipdT5Xw9nlwWZHz2JM/VihxKn8rCZ/yy+XOFAVd5gtL1BH7xhNpXvOQthW
 +nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169234; x=1720774034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1i+oRffwUlRN86HbVYMqaafbL1Oir7rskJUuAdQaFjw=;
 b=flJZomAnAqdjqXtSjnLHkrapYHSZS27xaYMrR+rIGdx17Z6YYsJ8dnUHxm67L/bCTY
 1wQt2v4taKoti44gSwbhYXIZ+sAt+7Fp/jwPi8NjUpTB0kqaCHc3qwqs1V+k1Nv6kVId
 dgya4/1Ljg1V+NiPo2/KqfOklB8FNMjHrSPUXGkQlMZGFrn7K+cmONOsFzz/wK2ZQLya
 9A0ITcEuZXjNwSy8xc4ohtbGx8qZ5P8Mgdx6LrCGzyMZ8FIiayLf0zTMrG2vk54ezrzy
 6YxBPDZUgBa1D7kxb8Kfnt9bQz0UF/LFmDqHKc7SOvpTQb1CoKKMq5cgPW4eEceXk4st
 KB4A==
X-Gm-Message-State: AOJu0Yw+/XrTTxRta/bAIIN9MgbsIu3h7XFzHdImNs8qqepnc3Itgf1G
 So5xzREoWELndKbXeb7pt4/JSpQPHfzhBTAvJqcd8jQJk9iAoij5yK6nhTEjaWk=
X-Google-Smtp-Source: AGHT+IEGm064V0QCGpWjJY6+PWDvIDXdJSVlgntXRI1y+n4/3hPExEwt+0OzAzz73AOFRhlJ05lDIQ==
X-Received: by 2002:a19:ca13:0:b0:52c:9421:2739 with SMTP id
 2adb3069b0e04-52ea061b1bemr2470634e87.9.1720169234057; 
 Fri, 05 Jul 2024 01:47:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58ea536b05dsm1530036a12.8.2024.07.05.01.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C3C662177;
 Fri,  5 Jul 2024 09:40:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 36/40] gdbstub: Make hex conversion function non-internal
Date: Fri,  5 Jul 2024 09:40:43 +0100
Message-Id: <20240705084047.857176-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Make gdb_hextomem non-internal so it's not confined to use only in
gdbstub.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240628050850.536447-8-gustavo.romero@linaro.org>
---
 gdbstub/internals.h        | 1 -
 include/gdbstub/commands.h | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 34121dc61a..bf5a5c6302 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -107,7 +107,6 @@ static inline int tohex(int v)
 
 void gdb_put_strbuf(void);
 int gdb_put_packet_binary(const char *buf, int len, bool dump);
-void gdb_hextomem(GByteArray *mem, const char *buf, int len);
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
 void gdb_memtox(GString *buf, const char *mem, int len);
 void gdb_read_byte(uint8_t ch);
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 306dfdef97..e51f276b40 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -91,4 +91,10 @@ void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
  */
 void gdb_extend_qsupported_features(char *qsupported_features);
 
+/**
+ * Convert a hex string to bytes. Conversion is done per byte, so 2 hex digits
+ * are converted to 1 byte. Invalid hex digits are treated as 0 digits.
+ */
+void gdb_hextomem(GByteArray *mem, const char *buf, int len);
+
 #endif /* GDBSTUB_COMMANDS_H */
-- 
2.39.2


