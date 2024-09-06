Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8670CE7B1B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sma2E-000119-AF; Fri, 06 Sep 2024 10:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma2C-0000ur-Pk
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:34:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma29-00074A-Mz
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:34:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-206aee40676so19263015ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725633236; x=1726238036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zMNWTemNt+XMGFhIvLfgSfk7j8P7fZjmzkPpuiAszc=;
 b=Kt/gluZCo6EjDiAkP4HM01yYgJoP++VglR1iEiZFGncnUi5N22lmypNWPYQG0NsiF7
 Dvt2HoaLCxuYknPg2vuQsevMscALG3vOh9ICb5GdYbxIn5Mwl0Y1UcnD04atyKEQJ3ky
 qj/vBQsVwKsX1pB3K9CZbAM0ObZ2kstuFkSMcyi5BdDBsc3SLZKIUH14euUnZwWHyVnC
 8C0KZsB3H3iBBVDxIi0+t69eLB3yZsU/gUw/jdCjbWeNLA9NWEarcZewDx9ZSgQBIut8
 SFRB9PtfzRkObKDmNVaJAcIW2LoDHeNA+oe5n8XSly0E08haaf4gZGdsJb4C4xdoxpx2
 3H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725633236; x=1726238036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zMNWTemNt+XMGFhIvLfgSfk7j8P7fZjmzkPpuiAszc=;
 b=M0Jmz1BoYQC6BbDakvdhmNlHReigZR5O34rqrmqUqajY6eR0u2ovZJFC2oiawdTsFq
 8XJVYC2f6FVKdtaPgNE78wWeERe3J6DRxlWTQtioh8E47lOEq0MD9vAeGQpU3kKv350C
 WqltTRiDMP4stLoTVeyN53smGfIvpi2hnWW23iNhiDT3ajvg6tV2rFj1WjRlspO6sK1R
 PhK0xfG73+z1xItHrdWvUq6/zYeScCQjgSWSIJP3FgSgZQOuSaqP0H2ecPMfjE1s/yPf
 Ngt/gXXDBIVjQKeSKsS9duI5OmGBShL2k8op4Qb3qe0Pp+qjamGpQ7sGSFcM1xKBNQSK
 ptSA==
X-Gm-Message-State: AOJu0Yx+oK2QayGP0OIb8INDB997wyNoz0Zv5FlvURvVqh0A0NI/nRBp
 Ro69/HBvJrwW8Cw0ugdjn0xKYSWGLJnI6BR9ZQqdQ9ZfUDTrJJWaosSJ5Keila396tzjOgiPiX7
 b
X-Google-Smtp-Source: AGHT+IH8gbWemzgFZ5dRwfRABpQhdukRal21e9TYAaEQInC03y5rtghaN17FqPBskNDlZYUq7U73AQ==
X-Received: by 2002:a17:902:d4c6:b0:1fa:1dd8:947a with SMTP id
 d9443c01a7336-207070004d8mr410645ad.46.1725633236072; 
 Fri, 06 Sep 2024 07:33:56 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:42a1:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae913cf1sm43844425ad.28.2024.09.06.07.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 07:33:55 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 4/5] tests/tcg/aarch64: Improve linker script organization
Date: Fri,  6 Sep 2024 14:33:15 +0000
Message-Id: <20240906143316.657436-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906143316.657436-1-gustavo.romero@linaro.org>
References: <20240906143316.657436-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Improve kernel.ld linker script organization by using MEMORY command.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/aarch64/system/kernel.ld | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 7b3a76dcbf..5f39258d32 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -1,23 +1,23 @@
 ENTRY(__start)
 
-SECTIONS
-{
-    /* virt machine, RAM starts at 1gb */
-    . = (1 << 30);
+MEMORY {
+    /* On virt machine RAM starts at 1 GiB. */
+
+    /* Align text and rodata to the 1st 2 MiB chunk. */
+    TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
+    /* Align r/w data to the 2nd 2 MiB chunk. */
+    DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
+}
+
+SECTIONS {
     .text : {
         *(.text)
-    }
-    .rodata : {
         *(.rodata)
-    }
-    /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    } >TXT
     .data : {
         *(.data)
-    }
-    .bss : {
         *(.bss)
-    }
+    } >DAT
     /DISCARD/ : {
         *(.ARM.attributes)
     }
-- 
2.34.1


