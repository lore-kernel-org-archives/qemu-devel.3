Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AB7CCF9F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 01:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEHrC-0000p2-Q4; Wed, 29 Oct 2025 21:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEHr8-0000oc-JG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 21:53:38 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEHr1-0003x6-Mb
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 21:53:37 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-33f9aec69b6so665241a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 18:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761789203; x=1762394003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nvN40USkkbLetcVwJjy1zLamogLp93oOAd9AgjmH4SQ=;
 b=DAtk/pLsNosDKxdAMScvxGhHSdEkkZcDa1PK7ClLeZcOK2IuU1aisxNhlDSzb4rY1u
 0Z02bPJ8LhFcdSbTYeLwO1+HH5ULSaTH4Uui5+sqoiKcdNXAtImXvNWC5vFp3SP1LQIm
 UAHrCMxKAF3K8isUU2LRUQ+xJJ9/+75raZ3C/unuYJM1OsPU6DJ2eSc2akshnWIG3huD
 o+1Te2DDHNrIE1e5epyuEb6q6Skt650xPBUeIunxOZiEZdZdtrwrR7V9UVU+5vx0cDGu
 /n4r2rsP2OWhB3iOXlKr4LKI88CaG48/GpeQ+MubaGq0LJNEnZKvmVX3OqwOkPjjnu4A
 EBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761789203; x=1762394003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nvN40USkkbLetcVwJjy1zLamogLp93oOAd9AgjmH4SQ=;
 b=wFaXDBru79/Rx8tW+6OOn7ek2LYzrMv+6z10SClau7nSl4anNUd7CwNDYdxEc7llZh
 zZm5CEkpVjVmSOKGq4dvJr/GvV9i2HDrnbN3eVCbINIiJ7WN1IodsYoMvw1PxWFaZaup
 YdMqXS6BbgWvCCfswoLA2VPFwCLZ/uOqk7ueVzMeW42AWeC0edqJZv1kWWciFBXhJ2uU
 SOkknFTnsNnJfuSLhQtNlHjdVVJJFbqpPunoArRU9JPxvVL5U4BojfsMKpZDEJ5wJGX5
 RtGuKjH4Lr09RZn+UtbAuPyXY3LJBwpeLgNYyXoLl9ZFZJHTgwJwVoNDIyE9E7PHdoz8
 Ajvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpETu+0GaWL3TGrQE/Q6RDwbSOmycoEyVcXziwl38NF5lsgj6x16pyIj+vga+MNXhKc2QKBFtAaqJ7@nongnu.org
X-Gm-Message-State: AOJu0YzAYdPNi0R1VG6B0G/YRSyQrBIQwAQJBRzS0TEkjueBdQecnBg9
 LcZmy6LKprFj+tWZNjGLWaRm0jdfsu6vIL3NRysYSAOsacusYOjS49h9ox3umA==
X-Gm-Gg: ASbGncsgO4DOR4ooqrYpLRxUPoXijjpHC8t15f8fCY4e5ksrcwP0EhGlrqF7BedzQQy
 KEL5qc+LwhEGWOu8DGxwzUglu2mCihYu7/xhqC4m1+zVxTmfwHN81KYoEF3qK6s5U4ea+f9X9V5
 D2QzLeHrz7pyGUHtFgzdss+xOug8dFQi68kHbxBgPnyiWv4b8mLGIrh//hedNa968GGKJdOWo9f
 6g+24oB83j88Hz3/ZrpnHi+MPSoOO9d8Tdc5FfbPbN9uhhnEUC2vvyQtUggigxPxzvuBx1Z98M9
 55TLbCXRxQeytvRFupStmFxi+Y51IRUIm9lQ31dJ8bYtf972JEmlKfpYVaAc10ugrEISEOSlmPw
 Txc0elWJzDud8SjobSWDlywc0+cNjUoiYCLbl/XioipRP01RWrzt+jICQJrxvSbbH9LCn0rCqUp
 Hyc8q1VD0qfrJBjlJiZBj0/h+NpkIHarhQrFuqI2/ZQkr6tc7qF7LjE+hQOoegn9imxSYvyl9vG
 t1PVbP7
X-Google-Smtp-Source: AGHT+IGh4DtzSmKYTuMk5XU39T/cPswqwFbgBTgXo66ItQlqz2W3W7F0Wnn9jD4mXniY9lOL/xaKag==
X-Received: by 2002:a17:90b:3c92:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-3403a0e6416mr5637585a91.0.1761789203170; 
 Wed, 29 Oct 2025 18:53:23 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3405089b069sm586981a91.0.2025.10.29.18.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 18:53:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: philmd@linaro.org, alistair.francis@wdc.com, vishalc@linux.ibm.com,
 qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 1/3] hw/core/loader: Fixup whitespace for get_image_size()
Date: Thu, 30 Oct 2025 11:53:04 +1000
Message-ID: <20251030015306.2279148-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/loader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 590c5b02aa..73564a2a46 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -75,14 +75,20 @@ int64_t get_image_size(const char *filename, Error **errp)
 {
     int fd;
     int64_t size;
+
     fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
-    if (fd < 0)
+
+    if (fd < 0) {
         return -1;
+    }
+
     size = lseek(fd, 0, SEEK_END);
+
     if (size < 0) {
         error_setg_errno(errp, errno, "lseek failure: %s", filename);
         return -1;
     }
+
     close(fd);
     return size;
 }
-- 
2.51.0


