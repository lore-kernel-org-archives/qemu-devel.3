Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94732C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3L-0000bl-3L; Mon, 19 May 2025 00:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnQ-0005KZ-Tf; Mon, 19 May 2025 00:08:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnP-0004C9-54; Mon, 19 May 2025 00:08:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2322f8afe02so4403445ad.2; 
 Sun, 18 May 2025 21:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627689; x=1748232489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emiw7dknS6nI7w0EE/PpXVbkuw9YpLuTjEDIBsyRuEs=;
 b=YxaqzI7OpCOanDQFEnxSry4ysxqH+sxEQupk4bkCtRxGslku9PWHtNECg8LCSDCjNz
 HPQ7cWeTchI7jhBkQZkxwHWy7t2agdvmcZySQeplW23ENSshVOuYja/E54Gcjc43jxZ1
 dYz6a5PFPzcTASWQAprOOG9oZL6zZksPIez88exct0ZdMDVJ/6+K/vf5ZxDlnHCy5dag
 GLR3Zur0RGzqe1IzZ+u502Ldi1dN3v14joQuc2n4DxISRt6aLQC73VhK7+nA3mHEcit4
 iLiHy5PNvBJ65E1pgnR68iIx43VdU/sgxQCHxrIFh0eJiSaItnbNITwL7Lipx5yDE+ps
 iI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627689; x=1748232489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emiw7dknS6nI7w0EE/PpXVbkuw9YpLuTjEDIBsyRuEs=;
 b=A6iTAdlHQbtD0015+ATIUWqmPdwef425+k4eVr4LKocvX5MgWP81Te0/VnVUdkwg1M
 365jHKzsUfiSQZX0KdGg0bi/jWCitl6ns8QdozsytxlYDJfog7ASxTfTl3VqBRU5vIC0
 GUYq4tGFzW9ZCXScFSHilznAmHnZEDhGy8BZ6t05HCZFsrcnKlGr3M2SS4jj5bSS0wrD
 Bdgzh3rmoeLGoVv6vLosl5mcSitRbkNzfLbA9c9ejtJdze+jBz+uEn9SLCKxZKL18IqY
 qZa7lLizuDQoc6ziHx7WV0/dltaXLIow+I3YBcLrm2P/fjzSGYJVuBfA8YL1IU8jEbGO
 TXvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpeBtWGCBNVoiAgWjK2UKIGAFeRHkD2PvifB4WLLIlEKpvAlcKk/UvsOaO5+8a8RBio1p+1m1KV86s+w==@nongnu.org
X-Gm-Message-State: AOJu0YzIIsdltSAjCMJZK4J2jfEcWMMaDeNXImO40zQSBC9p+uBEfRLN
 efdDhaIK3VFFMeN+lcrrNR+KXXmW1Z1K2f9LXvqo8iATku4CPlNdFyyVEsrevA==
X-Gm-Gg: ASbGncsRHMNeSAXWc0ycA8q6orLT2sEtmCD/expeNofp/V/3IUdROkcv3Eneh3OsdKi
 tewTKJMFDB8Fy13/v4jUHVkEGW06OzaBH++PXvcy5I8dG4Gnd+QGJecV/UZJdFrwXMy1vjbBSUh
 IwCXHLVX1vxkcv5g4go4SJxxN9ougfTrMr7L4ynk/1UXX4lJyI+ieoOzpjqI8oQC51JvMJddnjQ
 iH+IgUhbM5DbCpawzPYbR+A/fz3xOH2GCP4x/H3e/eMqxdfRRoJpIvAbrbLSChveuTouJuPOd8z
 w6UqGzWI2X1G/HnAF5xYN1sI1HW6Mz/86yFPFf0gBgJrSc4/3d9PlqHibZ8I7V5xcurWbFmMjQo
 RoIuEoOL71iXjyHccOmiXBRia0JWOb6oWU5gZqrN9S/hnzXnRpWvl9Pfw
X-Google-Smtp-Source: AGHT+IHXRPXBStQTw09+6mHE5S+X5/yho/xVDUu0tBNefKzIiNRhouC+2laOEvfd9g6IFUkENKbN6Q==
X-Received: by 2002:a17:903:1a08:b0:224:1d1c:8837 with SMTP id
 d9443c01a7336-231d451214emr169221425ad.19.1747627688988; 
 Sun, 18 May 2025 21:08:08 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 20/56] target/riscv: rvv: Source vector registers cannot
 overlap mask register
Date: Mon, 19 May 2025 14:05:17 +1000
Message-ID: <20250519040555.3797167-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Add the relevant ISA paragraphs explaining why source (and destination)
registers cannot overlap the mask register.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 ++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4ca7b15da1..2110392d1c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -100,10 +100,33 @@ static bool require_scale_rvfmin(DisasContext *s)
     }
 }
 
-/* Destination vector register group cannot overlap source mask register. */
-static bool require_vm(int vm, int vd)
+/*
+ * Source and destination vector register groups cannot overlap source mask
+ * register:
+ *
+ * A vector register cannot be used to provide source operands with more than
+ * one EEW for a single instruction. A mask register source is considered to
+ * have EEW=1 for this constraint. An encoding that would result in the same
+ * vector register being read with two or more different EEWs, including when
+ * the vector register appears at different positions within two or more vector
+ * register groups, is reserved.
+ * (Section 5.2)
+ *
+ * A destination vector register group can overlap a source vector
+ * register group only if one of the following holds:
+ *  1. The destination EEW equals the source EEW.
+ *  2. The destination EEW is smaller than the source EEW and the overlap
+ *     is in the lowest-numbered part of the source register group.
+ *  3. The destination EEW is greater than the source EEW, the source EMUL
+ *     is at least 1, and the overlap is in the highest-numbered part of
+ *     the destination register group.
+ * For the purpose of determining register group overlap constraints, mask
+ * elements have EEW=1.
+ * (Section 5.2)
+ */
+static bool require_vm(int vm, int v)
 {
-    return (vm != 0 || vd != 0);
+    return (vm != 0 || v != 0);
 }
 
 static bool require_nf(int vd, int nf, int lmul)
-- 
2.49.0


