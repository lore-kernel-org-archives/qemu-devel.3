Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7842DC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugueV-0003MB-Tm; Tue, 29 Jul 2025 20:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJO-0004vg-DU
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJL-0004hJ-P7
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-769a9c3bbc4so1412347b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833886; x=1754438686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P8lPJjGll0So1byMy/+oBlKdiKlOqDRJHguxp9paJTQ=;
 b=kzosJjLhSEh/vNIC629JJ3+61kmFvE++X3S1YHvpELyewDanNguCxtdUbgJ9DwmZ+B
 UQSqapwSChm5qFOroB7/8AAqbSEiEfShx+N/7WFUVLbErHGEBJ5Zqgj01aAgPYBGeF+N
 PlVoQcWXNcudmTVNx4qzd+S4cNSz8MuuC+5fzRSuXgaaE4ruYYwnLdlu3+bez4WuITtl
 70ooYAeKE0jL+gxydY7DInqCgCBGuAi1jqSvTXIo7+R60C/vPPUNS4uTAQZGDvQsGcb4
 cHZ1bclIiwScuIjkU5s0jnrEZkjit3wfdhy3U4HpPmU26K1xuFmamTd6S8UOOC/5SHI5
 DoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833886; x=1754438686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8lPJjGll0So1byMy/+oBlKdiKlOqDRJHguxp9paJTQ=;
 b=LhJkqMij1fjv6saSL7Q2cuekBnS6T8TX8w9XeGgHn8uFXgJ3jPJu7uwGsJ9ZcfyBkU
 BQrLm31cJuncUfHZpB8aarJQI3T9TrYgJ75JHaQ9oo789at06xW9YwiHmgzdonQDdFq5
 v3NJKvNOgIt5jfo/DHxgR93JSEyFnwjAjQ/7lpkXIUNh9YJnvTWz5gkb+MUSQi8/BAEJ
 InOJvxCcHrnR8Put8am0fWzJV1Tsy74RdQS9hgRkqUO2n9IWzQ6MuUGdsZv7QQ7bMnPQ
 Bb2MDCZ5hk8tJQoKIWkdWJGwOVe5f1I1uxnCyJEUDn3YzFe3xApek20kG8fnAAq7B63Z
 Qrkw==
X-Gm-Message-State: AOJu0YwVbJWzaADAbfmXvd7XG8wtaEcYj0v/+eKqFb6TWym4QvLCJzPG
 3zH1OqASg2xsiaxyVX7DDvFhz2ZHwuvvrSRmWPAAwSAUnTufrNEgTvDSmNCcvo/ioukrlueesAY
 Ynbi3
X-Gm-Gg: ASbGnctnkeSR0Wgq3WxIxn+kw8K2MHc1LxKfNNEUsNZo8GGvTVtOuDe4+rcPWUYjU5m
 WVvr3ljTJxqslZlCCLzMWBPojV0T+BHSJc+2t8avf+6uxJYn4zQ07tk62b22IwIGhJqHrHG5z6c
 6uFd2R1nmlMQQffSvFlVRqVGycDbVfv18He/SkgWi3t7difV947ZfD3ctCBxL7c9yaawWMUM+mr
 kE2sXEHoEgpUfIsjg27gA8j7CncgGicZLqvRaS4GGACYSWOM6asFHrMTTcvrXjo4JsDk1M+a7en
 fDcLzOKtaa+uVlRHse865KJ+K/6DbGOy9w7R5Z/7OOTTAGpPdhEfX3qYjgRCJ0Gj6EUyu17WhdR
 YwQoeNwNxvMxFBXZTbTttQmo9ujfQvGQZIVRs46A/jy6PkFhz3h+pnZdPxbMnYHO/Deq4VU+R+r
 DfQpMfY2EJ2w==
X-Google-Smtp-Source: AGHT+IHI9/RTY2PxpTjJmAZ3AjCwNNr3N2KSX+xCeyT8mvBAldvmiVz5u7u32XBCD7zjP2CCayGyog==
X-Received: by 2002:a05:6a00:3d12:b0:736:4d05:2e2e with SMTP id
 d2e1a72fcca58-76ab1021712mr1866683b3a.6.1753833886409; 
 Tue, 29 Jul 2025 17:04:46 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 70/89] linux-user: Move elf parameters to openrisc/target_elf.h
Date: Tue, 29 Jul 2025 13:59:43 -1000
Message-ID: <20250730000003.599084-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h |  4 ++++
 linux-user/elfload.c             | 10 ----------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index b34f2ff672..0a2b3ef762 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,4 +8,8 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+#define ELF_ARCH                EM_OPENRISC
+#define ELF_CLASS               ELFCLASS32
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aa05abec05..a45d23b91d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,16 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_OPENRISC
-
-#define ELF_ARCH EM_OPENRISC
-#define ELF_CLASS ELFCLASS32
-#define ELF_DATA  ELFDATA2MSB
-
-#define USE_ELF_CORE_DUMP
-
-#endif /* TARGET_OPENRISC */
-
 #ifdef TARGET_SH4
 
 #define ELF_CLASS ELFCLASS32
-- 
2.43.0


