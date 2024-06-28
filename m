Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A90EC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNB58-0002nC-Ry; Fri, 28 Jun 2024 08:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB55-0002kD-Cn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:51:59 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB52-0007iW-Nl
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:51:59 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a725d756d41so100770266b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719579115; x=1720183915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c35p0EHMCoCLYEMGnOn9tq4Soi160srZXlRjxT2HPQE=;
 b=p5/uAKPlYEte6D1WnYaBRboF+ZsFSljWUkZhxjKE87pVPuX43gfntla0Qgz52Dlzbf
 UG3zi9bKPjE8aXNVxLCBdouc4U3szMeTyWg8LaaoPRMy7h0jLt6+JwxQBSVO5qRJEA6I
 yGBBvvXUDaB0fwHL6ynYzgetMrUL+ACN2V1y5eC+Ty49ggXoZ9VmDtWkUw/ScwqW6wrE
 C+TTONg32lqGREZYqbV4on/NZqhz6IG756MDaVaAHITpfvK8mE3HhwSoFArrBtKFXqLX
 FO2OP0vFQk16zIZV4LlSLXOvG2WJy1WjHPvc5obk0k81szcOMY7ky5ngGRCqm/eEEyum
 caRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719579115; x=1720183915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c35p0EHMCoCLYEMGnOn9tq4Soi160srZXlRjxT2HPQE=;
 b=E7SuhGkY88M29WpKHzemek4vrK4QG5XrUDg0iKMUnPwujoPpos4bxEO8fiG77vycMa
 q2sFCrABOa+HfXIlK9irkpc/20qWsyoIpNsoD+04wHxnoA+ezBDxAlGQgomuI2MoSbeH
 ElCZI01eDACHuJucUfEx1fBJZl4cFfkqAo/TPJwS9SjYQCmHNqxZXmWXKWQ0iv6v5GBS
 Pg4Ai9QEnEa9xxbk9xlZlrXtIra8F2qJlaeYFoZRXPIiNPde/yCPffco/CHq8AYfrSiw
 8qTuDHyqghbiUUmYDE5G+5BCJjvpTPS+Ni5ksLcddof1VTRcSAAG7NrGU9Bqne2Ovq7+
 n06g==
X-Gm-Message-State: AOJu0YxgOzKxF6b6RH8KxlQrGrMubyYiPK0/zaYYgd/g9rcy8un52O+T
 7ArPoSOwsrTPbUK8Q/wKDvBuyQxM0O0vy2pto7uJWgayQD9sIF+bEkN6u/i1qUw=
X-Google-Smtp-Source: AGHT+IEpeM4IdhKauGov4YWvAD9pZODFP2WK6SysP3Gy7kw4k4sEekrrOs9aZigL1kPQ8zS+ztaeyg==
X-Received: by 2002:a17:907:94ca:b0:a72:b1ee:72a4 with SMTP id
 a640c23a62f3a-a72b1ee7854mr110442066b.11.1719579114649; 
 Fri, 28 Jun 2024 05:51:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18b15sm79069466b.19.2024.06.28.05.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:51:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCC8B5F929;
 Fri, 28 Jun 2024 13:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 19/23] gdbstub: Make hex conversion function non-internal
Date: Fri, 28 Jun 2024 13:42:54 +0100
Message-Id: <20240628124258.832466-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Make gdb_hextomem non-internal so it's not confined to use only in
gdbstub.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


