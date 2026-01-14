Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6B9D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnq-0004SX-Dh; Tue, 13 Jan 2026 23:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnd-0004Jv-Fp
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnc-0003o5-2M
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso55440665ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366082; x=1768970882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9saHGUl9EQTg8H2X9TYI4nPrJjSrH32IOQ9QngSUeho=;
 b=HQuez1mmZCuztsSVIYri+kbcvk74ipBqPBcou+0yRUksnDJsBWExTBIS1rk1ARi34n
 NxilwSyf6O8LCto8cbOKuRHLNWdJcaG+8Mq2cfugHswwZJURXgpp9TRNN+ZJYy3LK5Qc
 iiiGWNO/CIQd0DJvahYftjyeqW83Us+YEyuuTkYzI2RlZekgKn4o1ECsTtq6l7ndzi6A
 37V1rLxQ3oiLaZL7akJHJLhZb//9SpNQ2aHiv49MGEhAzns5d/NCiTgzQDsTecAoDULS
 hrZxCvdlnq1AoSZgji6DpofrjFYFSEOq6Yi/bBxR5AfKPaUWHT69XxXkFWt6GRSjxyo9
 w/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366082; x=1768970882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9saHGUl9EQTg8H2X9TYI4nPrJjSrH32IOQ9QngSUeho=;
 b=PfTVgqXd5QGtzvG31rpVI5vLFm4Qz6sx9hBZM5/p8qP/H7l4KGHmKDb48mPUHh16SX
 faaeKM43PWau5BmGFsUK8Shjk1CgSDVTptctTv7EawngWxGPlLC8OiuZPozhVL1uPgcq
 ppZ+Wo9HcbiZWbdNUjDmHcolb5x+1OjctRHZB4l1sINf74IOJgTQEMIF2XCOQX794Htx
 6YoAKV7OEs9YcSGzzNNoyBKo4j1JgLpH9nswcT+wJ5YuI7WIZXMWZIP8aXRCuIwcqguI
 LHcsyb9lVNu9mBVED8Po3y0TjBPi8qtoijW6LepEY7Mu0Rn6oN02wbISRZ8N+km6vyKj
 LOVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh40njX9Tx+JKVmPPkoSTmOQRJ7HApPHWMLGCmIdIuq6iKL+WdkMVwD9EEG30+a/jFPMnK3fdKyHSM@nongnu.org
X-Gm-Message-State: AOJu0Yxlc8VU2Pt+3ZSZrOyZm8fzNEGKHlRXe/qnTWAJ6A8nVym98CFp
 /GevYWTGmbY1waBPNEW9T+O8wtiqpKAb+V/vAa/DTxpT2m0MJkSfNHNh
X-Gm-Gg: AY/fxX5vopPmCzRi1MFbzb4ZxicBAkzIl0l/SqUem+Dk0ODfMDdRQuC3JLaO/7QetOY
 t32cbh3ZmvlVSZabnvtpN5K8rjB+F1S+014FLCzsO8dbZh7sVqhGQTybhTFGgdTmHIkHq8Cny1M
 MILfPb3gGuVdhK8D5x7sfIMc82aHWkM11TQ6z9XDZFEe1bNR62uvskuJw6K/68U3ZD2rLsunklo
 Oyg06KKP+uTRnliTI9TCqj4SnBg+k3m3lJNeoO4DaZCuHL7b4Ioa+ub8WaGuypPsD/oJX1LSI32
 SAWxbIexvqOFT0/V5qKq0A+3TmYMe5GosSLDKpWXOX9J1pNl987bmVcl/1O//giBcbJG5nBEDp5
 /j1aJ/hI1gjMCwUh2n/ANWTMSPF78KgzVbyHWW3AxN0VoX1EcMc1pFLd3aG+xVjI+ue0gCawnGm
 A1T9TJqMwc4T/exw1B1aGxV3zpmWaO79GYCXDRfdAbGAcZ2eRRiLHmdlRMW+La1JS08dnRyw==
X-Received: by 2002:a17:902:c410:b0:29e:a615:f508 with SMTP id
 d9443c01a7336-2a599e23086mr14796685ad.28.1768366082562; 
 Tue, 13 Jan 2026 20:48:02 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 08/25] target/riscv/debug: Fix icount privilege matching
 icount_enabled() test
Date: Wed, 14 Jan 2026 14:46:41 +1000
Message-ID: <20260114044701.1173347-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

itrigger_enabled should be set if the privilege does match. The test is
inverted.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index af9c4e37cd..ecedffd3b9 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -679,7 +679,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (check_itrigger_priv(env, i)) {
+        if (!check_itrigger_priv(env, i)) {
             continue;
         }
         count = itrigger_get_count(env, i);
-- 
2.51.0


