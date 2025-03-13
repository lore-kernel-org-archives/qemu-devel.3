Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC2CC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoGZ-0001wQ-Ts; Thu, 13 Mar 2025 15:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoGB-0001ql-TL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoG5-0001gK-VJ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1211748f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741894219; x=1742499019;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDzSIj54LKWcbPZowcPmZuex48RBy5Gx23oDRyzVEhY=;
 b=TJpJV/rrf3JCo9ENZ1eOn9bciZs0OcVK2KXzBS1bt0ovwZtVLm49N7gD4Yn2iKURe9
 ZtWv6ssyhnExCRGEnjFlqkxg2EVcRw7eQKkZ1wMQXKLZe6uxFEILypoKnAi5Ug0FFe2Y
 lnvSmuATfTCgBvKbWbJDDHqzg2kxnLsCXfYWDtf3k52OGYnNE5b7idrL5ZN1THvH1tzC
 JFN8lkLbXrvcNdZjoAeZ4mgFX0+reNYif4grn1Ksj76NMsyJpkMgEA4HdNkxG8GH+xf4
 RGzLXzlrJcfNBs3W1PBAd/idH5WIYubAGPFRVLUhT5Ctzs5LKtxZ4eFQUK0dKki5A+IO
 Ghgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741894219; x=1742499019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDzSIj54LKWcbPZowcPmZuex48RBy5Gx23oDRyzVEhY=;
 b=uVylrlPipq8WHGojW6/x23IGjw1HZDoBKNFFE/a3R4cecXeqND4+xur1fSyhTun5x6
 zKpylODt+PUViPpDtVTKhePg+6E9IAIdpLSLAcjKYkrIqVZoq7+fzxE1QsgahWKJjTXu
 clQFSGYbVnuogvFZyhYLpT0GYOEKTQYyBUKqo1/iUcu18n5WLv7OcZOBMTkEXIogI1cO
 E9UC/dgMFIrms1+ASdlvjlYJMokP2nQm5NGDP/dbCwxock4rbvFTreBN8yodCJ5vUVdr
 s1b3mDc0ae5TBfGtlLY2dPfY4elaUkOokO8uJ0BF2ZtA4ZXF3YBbjQzLgt4KQOZMEUzh
 e3lA==
X-Gm-Message-State: AOJu0Yx8TcST6uIN2A9OMOgHX8lCKcvUXMi6SZt9rS+vVTXmENUFGdHQ
 q+5Am5zHPAMVxMAJu4JlWWdwPY+ymIaLFIRssRlKa4X2/u9cbEq1D8pITwOyTMY90PBypFyxnf3
 XQjxXWRqX
X-Gm-Gg: ASbGncveBAPnHnqfAQTpcVSjyXOVnj/U4cEFfq9D0YNs0+IIOnvw3PPPl93fh7z4KaX
 tRb35f5UakMsk8HaQ8tdOUrvoyuMtl8/Ba+pnveOzTaHQiAs8QZtbcIZSlEEX7ng5CDafWurV+N
 yYi2tN5JB7aFYgoi0fEDwg2BED3C1ldXnWy3WuuqpAv6PlkJuDZGG777w6A2hwG0GfU6QWiyqM4
 f87nekuLKX9wKpYU4C1n/aOiA3/sT+35gXoEPHdzAuTDvJUU17qS6+96YuIutcazwF1XDmdGMLC
 Si8BLwfdR8pmWNULoDHizZjxPOdNIjiQoCMxDtSPux9/4+/fk/Gp/Ecg2eenzXoJ4eAWA+4IuxN
 s7Ed0cv4cqPZKG6pWTxD17AM2cdtLOA==
X-Google-Smtp-Source: AGHT+IFrOkof5kWJMTLkQqDaz6bT/YCpOjNGxPlvlBEJS/+x3v9yltsxZadzp/6f/QN0KqfyzsrhuA==
X-Received: by 2002:a5d:6d8a:0:b0:391:46a6:f0db with SMTP id
 ffacd0b85a97d-396c3837fa2mr835070f8f.37.1741894218769; 
 Thu, 13 Mar 2025 12:30:18 -0700 (PDT)
Received: from llx1.ba.rivosinc.com (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888152dsm3016421f8f.48.2025.03.13.12.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 12:30:18 -0700 (PDT)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH v2 5/5] target/riscv: pmp: remove redundant check in
 pmp_is_locked
Date: Thu, 13 Mar 2025 20:30:11 +0100
Message-ID: <20250313193011.720075-6-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313193011.720075-1-loic@rivosinc.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=loic@rivosinc.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Remove useless check in pmp_is_locked, the function will return 0 in either
case.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/pmp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 845915e0c8..c685f7f2c5 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -58,11 +58,6 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
         return 1;
     }
 
-    /* Top PMP has no 'next' to check */
-    if ((pmp_index + 1u) >= MAX_RISCV_PMPS) {
-        return 0;
-    }
-
     return 0;
 }
 
-- 
2.47.2


