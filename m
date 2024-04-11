Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33950C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv21T-00020V-Mr; Thu, 11 Apr 2024 17:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rv21Q-000206-8W
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:31:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rv21O-0003bJ-4R
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:31:52 -0400
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-6ea2ac4607aso177056a34.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712871106; x=1713475906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eTKB9jKB7nvQuM5iHphykYJr3NXxpvQe5kGQR0xZlA=;
 b=XHlNNKwM2vp+pG+xSsaOW+M/juQtAmXDEp8rXRgy8nYqJnyZtpLrpPqZFqn/eHfcmJ
 eALlxe9JNIGp4MXL+T++Z9rF/WTEpm1u5rLc4b1GfU8YrGQyuThFdzAn1XnYcGyObWDR
 GAjgPMq3h3X2ZhiLBX5n9o4+bYsD58EOXIlTufsA2SGFE3/scRF38XHRq4WVPhXwxMke
 yfo2AoGBf9lmTk7Rh+up28ZVHpXGIyU72qEMl+d8erb2QqjBDiFISG81OctRh0vNsTa/
 XjgpLAMk8Ti1VSC1JwEgOxwaOhK+tPZmmi+T1Ul04FgYvzjYUTFfPu0XTOouk9wOy6LN
 wioA==
X-Gm-Message-State: AOJu0Yx5s6bu3qaJgzh9EeOXVoytgdf+Egflq1DgTIzxWEUfS33IA/Yx
 z4kTc9FTqogMtjOYOIxI0umzN5Y7/1Ybq5HmAUYuZqKdmgs3yTnuT/F0VNdo4Rs=
X-Google-Smtp-Source: AGHT+IEvGjaH7s6Vy8ZYKdcRKtOr9RzXYgUc+U8iBFGmT/I+cpmuTQEVXQLmC2HIb6AH04geo1rT4w==
X-Received: by 2002:a05:6830:1144:b0:6ea:fd0:44ec with SMTP id
 x4-20020a056830114400b006ea0fd044ecmr806302otq.21.1712871106697; 
 Thu, 11 Apr 2024 14:31:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:47:4286:35e0:7d2d:6c94:a5ed:56f8])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05620a04d100b0078d693c0b4bsm1503354qks.135.2024.04.11.14.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 14:31:46 -0700 (PDT)
From: M Bazz <bazz@bazz1.com>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, M Bazz <bazz@bazz1.com>
Subject: [PATCH] target/sparc: resolve ASI_USERTXT correctly
Date: Thu, 11 Apr 2024 17:29:36 -0400
Message-ID: <20240411212936.945-1-bazz@bazz1.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.53; envelope-from=bazz1tv2@gmail.com;
 helo=mail-ot1-f53.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

fixes a longstanding bug which causes a "Nonparity Synchronous Error"
kernel panic while using a debugger on Solaris / SunOS systems. The panic
would occur on the first attempt to single-step the process.

The problem stems from an lda instruction on ASI_USERTXT (8). This asi
was not being resolved correctly by resolve_asi().

Further details can be found in #2281

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166

Signed-off-by: M Bazz <bazz@bazz1.com>
---
 target/sparc/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 319934d9bd..1596005e22 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3,6 +3,7 @@
 
    Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
    Copyright (C) 2003-2005 Fabrice Bellard
+   Copyright (C) 2024 M Bazz <bazz@bazz1.com>
 
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
@@ -1159,6 +1160,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
                || (asi == ASI_USERDATA
                    && (dc->def->features & CPU_FEATURE_CASA))) {
         switch (asi) {
+        case ASI_USERTXT:    /* User text access */
         case ASI_USERDATA:   /* User data access */
             mem_idx = MMU_USER_IDX;
             type = GET_ASI_DIRECT;
-- 
2.43.0


