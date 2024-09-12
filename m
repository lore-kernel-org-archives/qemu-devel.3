Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E90EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRq-00031q-Nj; Thu, 12 Sep 2024 01:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQz-0006uq-MP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQy-0003AA-5L
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e6299191so292286b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119118; x=1726723918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tNX42OJCNCOILNqFAqiVHWCMdtEBvk2w09U2xNMBqo=;
 b=APpB4KzfUdbQFWfub0v/CtfLWJm+mzlwHLMMePUM8ZEMeXAeU6v2yhjSzTV8gzPTQD
 Amtw+s3r0/OSOUrKmd7cwTLODfvqaKf0C5E71GDLDupwBOUV+qvsjpnQhWjiQHv81Mry
 ReefqHQDBzhU9wVQUX6Gz3vyLp2YtAERhFHSAzM6AgybXLymZqIJwmesNIb2hpJIXgqe
 aFSN0yqWDrqiDf5YtIS3n6aYEnB5JspRsv7Y15HStv75oTpb4Zium5vUVFk4a0RuuFL7
 KS2hnluysv/c/qtvi5cUfnYmrj2Jo42ejOCkHWfhkA4r1Ag/+jTRyFzyvVhF6Xx3etsV
 sleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119118; x=1726723918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tNX42OJCNCOILNqFAqiVHWCMdtEBvk2w09U2xNMBqo=;
 b=pvIk4xkRxtUPxHXCiBErNxHCKHtFUucJpuwOP4hiYzWb6SRtL00IdKp8lwcvuC7uRB
 Gy/AezOUGg/tVHuD5wf6/XgwZE78I5E2iHli/qZ89GoT++ba/edE5fngSblY7KuQ8viF
 Y5jdmQ8SaNhDIbddT7jc438/1WFHcm6B6+a0D2Tb+jWIydWr2i4LqZek/H7Imq0K7WdB
 5HeLe48VQFiyTkmEULcdFl0YzRlskPYsB72g4lCKafBOW1dlHamGcgEGSZcmOiblwM2q
 OmAhoSEENquw5YQ3Zm+4PRkYAsCL1Imqx8WKC72UoUCVaB42aDxJ1hBiQWdxPQ7cs445
 YreQ==
X-Gm-Message-State: AOJu0YzYMC7fKsy1hAEIYq8WsNDEl8mPOdmsj1VA0N5L4MtAu+c0dpf4
 JIST1HGpkW4TzhptmoC+nruGH4NBmuSg/wnzntyPcTTZPZFP0ROmmOBL7g==
X-Google-Smtp-Source: AGHT+IGiLlzFQNAE6LALOsuccmAY5P48mDoZEkcjl8k0rBu2eFCrtgtGtUelaN1hi+GZHZzmB+dpLw==
X-Received: by 2002:a05:6a00:993:b0:714:157a:bfc7 with SMTP id
 d2e1a72fcca58-71926084bb4mr2756081b3a.15.1726119118533; 
 Wed, 11 Sep 2024 22:31:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/47] bsd-user: Add generic RISC-V64 target definitions
Date: Thu, 12 Sep 2024 15:29:42 +1000
Message-ID: <20240912052953.2552501-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Warner Losh <imp@bsdimp.com>

Added a generic definition for RISC-V64 target-specific details.
Implemented the 'regpairs_aligned' function,which returns 'false'
to indicate that register pairs are not aligned in the RISC-V64 ABI.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-13-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 bsd-user/riscv/target.h

diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
new file mode 100644
index 0000000000..036ddd185e
--- /dev/null
+++ b/bsd-user/riscv/target.h
@@ -0,0 +1,20 @@
+/*
+ * Riscv64 general target stuff that's common to all aarch details
+ *
+ * Copyright (c) 2022 M. Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_H
+#define TARGET_H
+
+/*
+ * riscv64 ABI does not 'lump' the registers for 64-bit args.
+ */
+static inline bool regpairs_aligned(void *cpu_env)
+{
+    return false;
+}
+
+#endif /* TARGET_H */
-- 
2.46.0


