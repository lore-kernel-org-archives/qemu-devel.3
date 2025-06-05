Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22624C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNGNh-0006lj-P2; Thu, 05 Jun 2025 15:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNa-0006iG-6e
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNX-00016q-Fk
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so8270095e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749152153; x=1749756953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83yRFqQDqtEfhfQYce2Osef2dywXWD24VcAWbnFp9Kk=;
 b=Oqcb+mrQWvq4iZ1eAEj0YztXidNZ9xREngt3tFL5TMElowPNHfSg54rx8V9GgVwGCP
 9Y9FZGTzPkUIYyX0bWPgF9YCMyrbhpc+SyB2RVgIqjio+ZdKzFLfJXMFhajZtazfGRyt
 eKTIJCv6kDI0Q4ex4fzA7qtYMggbn5XFEFnFOmV6BfZQHqtjC4JyowI1oCg0eP3RiWxP
 4Bd6nAGcoEIv70jSsK/+syRWJ+Fe+94qjD3pNDCpB5MCiWhMAuVBsmfA3QkVHQI6C1kL
 9vr/SD72ukDLhUKoP78365XuuKOZkjUSuXKwCabYFYxyuGOWoUe8yk6km/dvILoV0GXA
 sChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749152153; x=1749756953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83yRFqQDqtEfhfQYce2Osef2dywXWD24VcAWbnFp9Kk=;
 b=BRzX5ofqRQbekSixqYBLHUlnzDLjEVxEvl10zNiQtp7oTTj+2ipC66jVHHmCv8Zqvn
 Mr8QMw7puH+AYHOIZp1jsYCXKA1c1/AArWV1piyGFuNdOsG+HH9Nit0ss0KCaJBKj1nG
 8m1bLNL4BzVaoqIDwGhue99AQgi6c91gL20dJ1zLgcjx9Ivaq2D4ltg66aBN86lA6DUv
 NyJE7N0xLacE241Rg61fKqQ4L4hnsnxY+Gmym/WkliZtHJPyz1SVMYByxgWYXOgFR5La
 P54UGxhwin7iSVaxUoRxmmN3vpiaP18aUXMXEWX1UVfpM6nobax25xn4zp55Y/jIdtWp
 TnXg==
X-Gm-Message-State: AOJu0Yy7Bvlkm99bF9GX/ODtW0mBEsvJRuCc7r0R257On4qLDRS+2+4B
 +FIm1pWnNnON/3wN573Frvsor7vWSLFQUrNtZ3AQdzULEUbLPtxwNT4UeadJktpPZJCSVpB8adx
 4Zi1RfSg=
X-Gm-Gg: ASbGncuNwc8Icrw4+Ac1gkzQqqkCREJgXUd6bSzz/lzUBHKBV3dfPBmjDMz91AHUCW+
 zwTLpGe5pHHYeW8RsWJsgCdyxZIviCiGni/DfsBDedxS1duQOAFzAHHyDQWibAO3Z2ddbcHt64t
 uHA37XQXCMMhYIUNtw5gIlxUPMxldSQ1Z/duFAk5rMxvoR+zAVZC/EoaMn9gDKiQB/7ZWDG+6HK
 p3PNcN1TBmjfy7iHnnmK6qff4K2e25ESxvAGhecA8L+qcWfxawvWUQrEjJ2LRlAh/b67HVSV/k1
 DEo5KTfUuHV14X0J6aJvNHR9D1xpKhmxu0rShuBdUIxZYJGQps07xeo692AEBpvGg4zN/lq2xFf
 1VGVCK31QkXDujHEqPvj1qsDURoYX78GXfDJz
X-Google-Smtp-Source: AGHT+IEwwg1icoF6ZnxFG0lbDu28dQaCv3Q4Tq0/L1LJKc8Joism/TsTRg9wQoqo6DYinr3mSHfX6g==
X-Received: by 2002:a05:600c:458a:b0:450:d3a1:95e2 with SMTP id
 5b1f17b1804b1-451f8855f11mr44862745e9.9.1749152153306; 
 Thu, 05 Jun 2025 12:35:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce1f34sm2477585e9.14.2025.06.05.12.35.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Jun 2025 12:35:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] backends/tpmL Avoid using g_alloca()
Date: Thu,  5 Jun 2025 21:35:38 +0200
Message-ID: <20250605193540.59874-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
References: <20250605193540.59874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

tpm_emulator_ctrlcmd() is not in hot path.
Use the heap instead of the stack, removing
the g_alloca() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/tpm/tpm_emulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 43d350e895d..4a234ab2c0b 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -129,11 +129,11 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
     CharBackend *dev = &tpm->ctrl_chr;
     uint32_t cmd_no = cpu_to_be32(cmd);
     ssize_t n = sizeof(uint32_t) + msg_len_in;
-    uint8_t *buf = NULL;
     ptm_res res;
 
     WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
-        buf = g_alloca(n);
+        g_autofree uint8_t *buf = g_malloc(n);
+
         memcpy(buf, &cmd_no, sizeof(cmd_no));
         memcpy(buf + sizeof(cmd_no), msg, msg_len_in);
 
-- 
2.49.0


