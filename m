Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C95C282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyO-0005WS-SH; Tue, 04 Mar 2025 20:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyC-0005B9-7E
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:50 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyA-00007t-Ka
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:47 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2333395ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139685; x=1741744485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2tk+IDQAaFexLh32/3aSUR3dERRACns7VIzSWEBYTg=;
 b=i7jLdxgotlIlYjPG3i8pamr8QVfWwLJeB60tg1hPFFQspxr9OeHlQzONQrdE1d1C0t
 1VnIp776dA5Ix7zrQA3eRY5RJuWky4H2b16bTMgLxWQ6GfRAXqOMcKaUnYcS5gEDKlWs
 JG1NZ7NdPe/mepMG/c9TgVSsZEWTDbhBrsyeqFqJPlL6Jhm6pcVBfnBJrK2Epo2SYdS3
 KsIEskxxiyN/hZpkMFCjKmVb5bMjRkvleAPrqDDqnGjIMtMSKos/HjO9OLvm3r9GqFZK
 ccFqWmWwZJ4x4wpUGQsy55rJ+YuyVF4io18G7FYUyUMsG5R3rwUWClpsNPrTxLNO58fa
 p57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139685; x=1741744485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o2tk+IDQAaFexLh32/3aSUR3dERRACns7VIzSWEBYTg=;
 b=TY0pqVKWzm5CW04yPc9qFdetcRvzkmuRX8irXFavXp2/rqH2dY2XKh6RLGlzahTumQ
 2xOrrIlfYyRYCD+1zxXr2TBzbWLcyDYWbfjebCr4sQe0iZ3b3w32b7HZ1t6zCr/KBbBF
 viQFHq1sAVeNAqrF6Y9nZNzxFKnUR6tWTisObWRNzjS3hYvufGWVHEZNHJC0JWoGtM5j
 W8hBh7bsMIeLILhiBeirewefpKth4I4YZ3iBCQPAyliBoijJ6wOxtCLLQmXIhqpGta8+
 Zk1dp4lazxK0r3jPAraE6YMoiPJfpsnC14Ns8itjg/jst0wQWAN0fCNDWOGZPE1y7iSi
 JKkg==
X-Gm-Message-State: AOJu0YyqjV3Q0gu5TFf6zxld+kDj5wr2THBPsDGuTlMMstTz9bgMKkKI
 +zck2ZkrdaGcPyavz3esv691C0ygPHRyDv8zD2u1ycebPAPNDie2k0IAAxytJJs=
X-Gm-Gg: ASbGnctpVI3qmH71zE6ItUR0e0gmwrTDhhb86cenquHLHkHJ68eK3rZR0bwSmiCdGO4
 CowZUiyfytg4E2ehE99EjtwMgO/yNbJ4Nfl1a3OzJ7yTVyR2qJDo48QYxcf6elNKIYn/lu/8R7H
 8i56TD2KIvxdxLiKq7vHI1MMNpcYykXb0wTM0zPlS5i7zswcPvk7ScSQ+zfV/DcRW4WzAfrD4p0
 /0S2uDpffb7g8Z/W7Dc6NV+cVAYbLlQipvfiYkzZXkZH5LK0b9GCQfn8o0d0P7mSAWD3YGY54Fh
 +g1kG3f0A3wiJ90L9ryJ33fB8aG4QgjMX7GFW/Gl29/PAqgCut+C/zlZ2OENrTwUoF6rLQrHAAJ
 Xptt+sJPKIxBaEBb2DSUgxXVgXvZvFlleRBOkuQsmF8S1jOP+VQI=
X-Google-Smtp-Source: AGHT+IEaQosfOnW/G9cyn9jwnO1QLqXSVHa3KmXKcLlhDEAd4giTyDST7lILTOo8cJjqedE2yY3/dw==
X-Received: by 2002:a17:903:41cd:b0:220:fe36:650c with SMTP id
 d9443c01a7336-223f1e074e1mr21109925ad.23.1741139685042; 
 Tue, 04 Mar 2025 17:54:45 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/59] target/riscv: Fix the hpmevent mask
Date: Wed,  5 Mar 2025 11:52:39 +1000
Message-ID: <20250305015307.1463560-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Atish Patra <atishp@rivosinc.com>

As per the latest privilege specification v1.13[1], the sscofpmf
only reserves first 8 bits of hpmeventX. Update the corresponding
masks accordingly.

[1]https://github.com/riscv/riscv-isa-manual/issues/1578

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250206-pmu_minor_fixes-v2-1-1bb0f4aeb8b4@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 70ef443c99..a30317c617 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1078,9 +1078,8 @@ typedef enum CTRType {
                                             MHPMEVENTH_BIT_VSINH | \
                                             MHPMEVENTH_BIT_VUINH)
 
-#define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
-#define MHPMEVENT_IDX_MASK                 0xFFFFF
-#define MHPMEVENT_SSCOF_RESVD              16
+#define MHPMEVENT_SSCOF_MASK               MAKE_64BIT_MASK(63, 56)
+#define MHPMEVENT_IDX_MASK                 (~MHPMEVENT_SSCOF_MASK)
 
 /* RISC-V-specific interrupt pending bits. */
 #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
-- 
2.48.1


