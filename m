Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCF7C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlU-0001Fk-0T; Thu, 22 May 2025 22:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlK-0001EX-0R
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlE-0007in-SW
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742b0840d98so5146390b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965826; x=1748570626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE/rElsE+sxHsKrFd8ZdZIhXnJuddVorLW+oNsQpqho=;
 b=JHbSQ2t1fZ0u4rdhhPvcpJAXtuaAbSdjjncaIa2jxhoNOtBCpYg327cOh0Zvzv82Hf
 LrXNGNs3ZKLs0cZIF2TySwkBW9ruFDRfsboSPvjeQZyCKqzk7yXICTd0q5q9lKzsXg66
 Oez5FUYJP+LlMlAnzAwVsy4uecAQnVpyLZfJl8baGbarHqWExCVGqWiJ2I11jAIREzVs
 vhzaT4UuvBubLgqnwWVb7/ex2WlDB//rPi+cHS0RZrsj80Nsn2FgtDTAd8H8JSqgtQti
 obT/B+laHgQAk9tV9kxL/+y5ssi1njk11XWGIBppUTXDzzqf/8M/YSQLd5/lNffS3OWR
 mW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965826; x=1748570626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE/rElsE+sxHsKrFd8ZdZIhXnJuddVorLW+oNsQpqho=;
 b=tgY+/OY/cmZVY0og2uGTL6E5dtxwcZeJIFrKsmdn8/ZdEou0qaNTPLE4DBRSOCC19M
 V/Vs0xRVZzDd7C4xxew1csrYryQuAIW+gm6U7OGe8v6GsKW//Dj3uktr5vUU1xIYAEEH
 acQbFNsgmZitc6CSf89OJXj6oamO2t9UK7Ss414zMt7Tq2gj3mK0PR09SyGQDZ+hcgs2
 7daRpD+dq2XDfSbo5veU5UT7bGGG4ZoP5HD4+hvFyWJZGbR9X34hPUMlKPY3RnF4zuiP
 wVOU8x9M0UhddnJUlAMXOJ9Yu709GFWNm3ig+h+nLSb/uL6++O1JA+G5hX7jEz8KhMiS
 dvew==
X-Gm-Message-State: AOJu0YzyMYyeU1ymuKClqhux2r8llZEwnxDokhL9OW0hkYUU0P9z0Y6E
 39MbkIswteaC7SHP8XqQ7haxdkZ0fRm5dwRZ/kzvvtKbiuGZXh4wH7xuw4usWsww/XQ=
X-Gm-Gg: ASbGncu5PGDoqxEW/RS6JGT1mnoyu83yBileKv3JMb/5Lkq5cEYbBvhBbicA30RnhVO
 zn2YnMmkjZiaM5SoryqgkVKFGkK4yN6rUGv2V+gf3/5CsgFj/gpyJihyJAf3PA5Tnb4/OtBJGQq
 PWaMJAvohgIyYRQLLj1/Z32hXqILK+wvnXLx3pkvWLGN5KlwnAqkj0NMCCBTA36R6DM3q7+Ar4w
 Kfup/1IIY6XyZqPs6qBNUVOdv+5KudHTYliA6h8vMCzGFrdHyiZcdCVeNwBJfJlCwPhsH6Obkg8
 sqiye+9S9pTnqbeWJIsvbhWib49AKc5IfOiIcwhci1+X1er3pAA=
X-Google-Smtp-Source: AGHT+IGpcZUZLs3jS/WUrLCd2zphu3OeoV8Dnx72o2Wrv8Z9Yej/6A43JNbF8vBh50RmeVuzc5wtdQ==
X-Received: by 2002:a05:6a00:858f:b0:73e:1566:5960 with SMTP id
 d2e1a72fcca58-742acd507c1mr34646406b3a.19.1747965826328; 
 Thu, 22 May 2025 19:03:46 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:45 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v4 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Thu, 22 May 2025 19:03:35 -0700
Message-ID: <20250523020344.1341179-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523020344.1341179-1-rowanbhart@gmail.com>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
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

From: novafacing <rowanbhart@gmail.com>

This patch exposes the gdb_write_register function from
gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
plugins to write register contents.

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 gdbstub/gdbstub.c      |  2 +-
 include/exec/gdbstub.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 565f6b33a9..5846e481be 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -534,7 +534,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     GDBRegisterState *r;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..a16c0051ce 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -124,6 +124,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
  */
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 
+/**
+ * gdb_write_register() - Write a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the register contents will be set to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * The size of @buf must be at least the size of the register being
+ * written.
+ *
+ * Return: The number of written bytes, or 0 if an error occurred (for
+ * example, an unknown register was provided).
+ */
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /**
  * typedef GDBRegDesc - a register description from gdbstub
  */
-- 
2.49.0


