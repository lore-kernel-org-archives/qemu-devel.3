Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C33C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQKP-00086j-De; Fri, 07 Feb 2025 10:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK7-0007zb-Sk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:19 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK5-0003ww-Fr
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:19 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5dcf0de81ebso4306037a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942274; x=1739547074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Um1CwtmhdsQHyRWJ4xWo6y2AlcWR+j1kN7yWOVUF0WM=;
 b=LfD4fPp0TZbBGnBQ0dM6TTBLxRPNHtZOFOf5A8B5oqp8yXlj01MtfW7mXSe91PlpM6
 u6W7s5aiY69tIaAgkneDz7QDHskuxOiieTU4ajNLXPPWpAtcQq4XOg9kEfMVTF4v3IVv
 iiWQEKD4OkyrNZsEmB5w0bquGDjleNaCL5a/CwnADK/+NQ9N7SZCTkRDMvXPmuTrB2pG
 QKH5N4KoLBIKoBdxO9pMhmlk4tOu6UccAjDgGq3yM6PAkjhim6wDHiQ9+cc2/dYqKYPe
 KEyCJB58dB5ZSa23KRyvQJ9eApF4aAKtjvAy/+9/vC3C9iYuSxV6FPqRF4CZNZ5/7a6B
 7udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942274; x=1739547074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Um1CwtmhdsQHyRWJ4xWo6y2AlcWR+j1kN7yWOVUF0WM=;
 b=utcJe5GNVVftKU3YfgOfY+83p/FqvVeyT11QbP85dbQsVPEufAqrtMmHHHqgfxqGPa
 qzTL7VUPTfgPSlB3mXdAy0Ohj1dFxp4dAjZcwSTUwItzH4nmfRHsVA40AbZzw2IigFF9
 KQKsyj0Tx27/CY2/FUPR2rzxHMrTAbzKzX6F7wqxdUSEokPBrMJk4c9zXOyMpXToCVvh
 3/wrA6X0TvSV2zzlnOprXnpLrC0kYeKbZIADh6RS4lCHfx5PennGTkc5r029vfpvFD94
 jS+hHZIjMxJH5BA6PsHqeUqEYapxQXOlyVV185wzjzibzR70rmBZaShxElGe1SLoMGvx
 AymQ==
X-Gm-Message-State: AOJu0YwtvII3DymOxtQzDb4S0t0ZUKzmJtjYJ2qEbvepNrRXOMyOo27v
 H3t3dFjKknDzrR/fwvvEYtiH1Il3MKSEWRLPb9MiBk17q7vtBErHprkZCvQUhYk=
X-Gm-Gg: ASbGncuxN3SzAGyJwMJTWXwUVDmrjKdV8eom4tEhzt50EQaf4GrfILQzS6PxLF/i3Zp
 GoPw1laNKcSajsIjVAY/0XEQDLVbVJiLzrOHBZl3rFmRaHSwfoFlIOU+uMg835QjOeit5MHHus7
 sFvPYL7oEjD9hPvJIDHvE7A/zdqQCvLqQlO60nrdlSae4NOjIMhwJfkpSgKPyvbdOvHNi74VK90
 bJS4qXQn+fB+kj+oKxc42qVlbiMNFYqI4N4cNJbuga5sjxbaEtK+GapebEjgh0IKLXDKkKjLVyV
 rfU0F52GjauXrqbqOA==
X-Google-Smtp-Source: AGHT+IElHjFtPVYJA73ULLa7+KgfPOyHampW28+/996bqIedaJsi9vSXndyF9JnqnF8avBEpNO5jIA==
X-Received: by 2002:a17:907:7b06:b0:ab6:eec6:7cab with SMTP id
 a640c23a62f3a-ab789c3ac8amr448973266b.38.1738942273971; 
 Fri, 07 Feb 2025 07:31:13 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab781453f04sm205306266b.161.2025.02.07.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6FC05FAD2;
 Fri,  7 Feb 2025 15:31:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 04/17] tests/qtest: simplify qtest_process_inbuf
Date: Fri,  7 Feb 2025 15:30:59 +0000
Message-Id: <20250207153112.3939799-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


