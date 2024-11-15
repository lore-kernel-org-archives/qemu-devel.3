Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1CD68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PR-0007do-AF; Fri, 15 Nov 2024 15:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PF-0007Yh-6I
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:06 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PD-0004Oj-Ph
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:04 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e5a0177531so1839431a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704342; x=1732309142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9lS2qyjum1CwVNKmlpZ0oVrEa1u6fRFy77taSYsw0E=;
 b=woWg9f7A6tRaNajF1QAd9dwm+qngALBOUnpIhiJbVY11Tb0+oGb30da62Nf8QEJhCV
 aN7g2nyEQefWgM6SBM2YHkX6PXpaZGpxIBmwfJ2+SyGeov/7BXaT2GsAmIWHliGNcC+W
 biKcapLnkYW/5ov4tyWq9gcPsZzEda+E1Q7WjuCqy+rxrHOR8fU4b/X52ppD6fSuxig3
 cRTjumGImDQMiBtk4jeE/siS7H4tWluy6DJadfMcaQ6xSURd+54tmhemHOFETpFG9XNE
 QT3J3MrW2yv4dsNK9A+WvXhYPnPNbK1a5LT6uGzyLtVa9m+6Jcfr9699a3iGAFawuE6S
 /pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704342; x=1732309142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9lS2qyjum1CwVNKmlpZ0oVrEa1u6fRFy77taSYsw0E=;
 b=J6KIlQOmXWnihqRFEtJDp5ytksrDIp6k9lvtVeYSugJL4+7qHfz2O0c4TQ0A8YXPUJ
 S5ptMP34Jj7uu6NOU1fEd+B+/LPRqtCsyLUISEfBAg1mt6DRGtgUC5yUSblAnnBtE/3B
 CB+CnMtBA5+Av2A3+Kqh8yKtoMX6jhNbumIpAS0aRo/sH973unupe3tox5vik2PAp9JQ
 iNSe0WWZbSxoeq1dHSw+4b88xA9mqj2aOs7FVQHRNeN/z0FTmdxsmOoP/Bfwwtd3SWYq
 dt2+nLPaHJeqRoJYC79/tNzWKpK24XEZX6c3u8MJxbTxh91Tic5rQVL58ZbpLfpohgT3
 YMIg==
X-Gm-Message-State: AOJu0YzFj6SqhhsGwpLliRRaddpdNdsl87lczbQRNZb4O0xPHnUM+16b
 Crg+mlh6izpbgGIXITLlvdNIcabLG3dfW4pFL/9nXr91joBV+YXfseYpmrY1qhf56SSEskk3qgp
 x
X-Google-Smtp-Source: AGHT+IFNucOeHVsj/18oUYqPdzOVO1dRYWycORJOAsr/+T5URW/+IEigd0AFHFaJyhIbPcqeXLm6Ew==
X-Received: by 2002:a17:90b:4d88:b0:2e9:5360:22b2 with SMTP id
 98e67ed59e1d1-2ea1551e46fmr5197504a91.20.1731704342371; 
 Fri, 15 Nov 2024 12:59:02 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:59:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/14] linux-user/loongarch64: Reduce vdso alignment to 4k
Date: Fri, 15 Nov 2024 12:58:46 -0800
Message-ID: <20241115205849.266094-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reduce vdso alignment to minimum page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/Makefile.vdso |   3 ++-
 linux-user/loongarch64/vdso.so       | Bin 3560 -> 3560 bytes
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-user/loongarch64/Makefile.vdso
index 369de13344..1d760b1e47 100644
--- a/linux-user/loongarch64/Makefile.vdso
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -8,4 +8,5 @@ all: $(SUBDIR)/vdso.so
 $(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
 	$(CC) -o $@ -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
-	  -Wl,--no-warn-rwx-segments -Wl,-T,$(SUBDIR)/vdso.ld $<
+	  -Wl,--no-warn-rwx-segments -Wl,-z,max-page-size=4096 \
+	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/loongarch64/vdso.so b/linux-user/loongarch64/vdso.so
index bfaa26f2bfe1aaa01d9a349b8b030ef6323e1f8e..7c2de6c50e706164225e82f652d4becc04c71ff0 100755
GIT binary patch
delta 37
tcmaDM{X%-eN=AW+tM-YA3hb&jk8@2<QS14Vzx}<pii5+a%{7cUJOC|W51jx2

delta 37
tcmaDM{X%-eN=Ao?tM-WmX?HPm)y|eS*?us!At};x;l^g2%{7cUJOC+;4-)_Y

-- 
2.43.0


