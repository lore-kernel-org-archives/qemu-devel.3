Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36FDC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyT-0005kJ-Os; Tue, 04 Mar 2025 20:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyA-00057n-7R
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:48 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdy8-00007H-Ow
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:45 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fce3b01efcso9113675a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139682; x=1741744482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mXzu/q/STb5uoLRSBRxYvW5KroRtvT4LUQ7GK2i/JE=;
 b=dmm+eAEExD1uQ7D5LUVuMmPoO9yD52YwrrOr3yqU3kh9c9ZQFXxowNuaIeP12SZ9kd
 iGWDO3fK5oWMXv0Vw1Txwbt5kFO02G4lPsDnz3RsEU96ponWaAfAkH8CIBdoyTVATFws
 7ncoYq6iLaoFwbV9jhPFXqexZEuBsAmqqO1upuAAj6waWJVqYMP7FCaTngW5bxe7m5Xi
 18DzPPw6N+xRGIps7PFrA9oTyKHYiWvBXKppKAECVN69de4BzqV4PeKd2V3VmhOFO5TU
 59yJvHHx8g52SHY0LEPbVLz7Hzt8vPk9lm4wJ6A3ecLJ9bQ9zptaaOt8bn69pw04BbGb
 hwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139682; x=1741744482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mXzu/q/STb5uoLRSBRxYvW5KroRtvT4LUQ7GK2i/JE=;
 b=mJW+yaidNvT7LjpEtIMCzCXxvebmdDo02UXUJy7IEQpWtqQifbpBCsbXc3+q+R+KIr
 ufFN9BxQgv9FpfceH9bPbhAh2wHHwtzDOUcaH5K13vlJE2dZa47pQxmsjaEnJ9nFGlSX
 28yKswM1occ8Jkg9+ISNckIJS3BIz/oQugAAbm4qPqZPmO16S6igofHqugiQWRxU547d
 UNzZG7ssoKN665QnGLpXTkchnunr8KUtGptccGcYBybSZ3Y5eHLxJWic1Di96zeaQzy3
 dqkouGgX2d+SzVURUO6lO616TB1qA+rICz/nTXjjLS0brlJ1nYPBB3eAUINVNaZjj7Ed
 JBcg==
X-Gm-Message-State: AOJu0YywpiaWZXfciWEhIkaTQ861CA0c795avaz647DGD29KfXaBp6B7
 kLLJ86ErNmoK8gGHwcrn/QeP64sHG3ncpOrGCTQ9lN108fOG61X83NvnnTtffVo=
X-Gm-Gg: ASbGncuusWg9ewLSlX7psVJ2G1SGVGSaVM1Ef3yv1IBXpNSvaF/ymz/MuDh8LohwJLK
 QO6zzmP+2QWVqzK80mvzcUkA7NjH1M6I72kDFjfB+VpLdhL/iWeIgRZHQHFPk9G14fRMcVikyiI
 qzq8elnCS6nTpu8fZvU40PyGoGLNVhsKXCC5mjNF98aGZ9G9AzUkaudgqtjZjLG+++nEJ4NJWJR
 xLuYDj5xG4EGNSAly+9wT0nFSD1waCyIElVhRgfsGVFLuWFdAUPgHmj2KWTyxe2dnjAG1rTX6Uu
 gNyZHplxYFozTyE6uYQXty3ZyYGieX3KREcAe/OVNiIrFf8c6Zp0sUE0aQ9yAuHIBl3PnK5rYig
 ReKPsaMvMm33Cut6G9McO2fok2A43kfGKuwIiTfIvB6Mi3h02teg=
X-Google-Smtp-Source: AGHT+IFcSNMMq41FUWQ0kKGvgJs4ZxC70p7Plz6a3MV2la6Cwi3+srqjq8Iq5ZKFO0shxnwVKv8ObQ==
X-Received: by 2002:a17:90b:3ec4:b0:2fe:a76c:ffd0 with SMTP id
 98e67ed59e1d1-2ff497ff897mr2448212a91.27.1741139681988; 
 Tue, 04 Mar 2025 17:54:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:41 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/59] disas/riscv: Add missing Sdtrig CSRs
Date: Wed,  5 Mar 2025 11:52:38 +1000
Message-ID: <20250305015307.1463560-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

This reflects the latest frozen version of the RISC-V Debug
specification (1.0.0-rc4) which includes the Sdtrig extension.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250206153410.236636-3-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 305dd40ac4..85cd2a9c2a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2438,9 +2438,11 @@ static const char *csr_name(int csrno)
     case 0x07a1: return "tdata1";
     case 0x07a2: return "tdata2";
     case 0x07a3: return "tdata3";
+    case 0x07a4: return "tinfo";
     case 0x07b0: return "dcsr";
     case 0x07b1: return "dpc";
-    case 0x07b2: return "dscratch";
+    case 0x07b2: return "dscratch0";
+    case 0x07b3: return "dscratch1";
     case 0x0b00: return "mcycle";
     case 0x0b01: return "mtime";
     case 0x0b02: return "minstret";
-- 
2.48.1


