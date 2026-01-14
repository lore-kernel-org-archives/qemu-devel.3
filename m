Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20CBD31A0D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfso2-0004bX-J3; Tue, 13 Jan 2026 23:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnj-0004MH-Sa
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:12 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnh-0003ow-0n
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:10 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so62234615ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366088; x=1768970888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3luBxTCpa8sPpFQ5gO3pZBPxYpvr96ETycK7Q9rpUQ4=;
 b=htVNtMFnJuczslD+dGzRsJDkTDc23l8OVJi/0Kc4hs9qMyI0iAJI93UWu5DYZL304M
 HADf8GiQ9wAQG88tMG0dhTGwKtMeGNhl/bfKL82l4BZDGznxNbuCzQ77vh1Z4DUIFTrb
 oji2Hq7soP1GQj/LM2B4gMHU96Un5X1j022B9vEjAmRkbYdN76YcXZ1X3DswhFaInc2j
 SBFVpvwcHRcgLUe/0sMDD2Ma6Ngghug9Tj9C7wC+aWiCBLK+HPoBSGvVNf0Mf7x5vqYM
 zjHDqXd+sn8RC91vw5DXYaBz1cKQtYmaHluE8C5/BCY93OFR68FhZdgpA8z7nbu+4s1R
 0Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366088; x=1768970888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3luBxTCpa8sPpFQ5gO3pZBPxYpvr96ETycK7Q9rpUQ4=;
 b=EsFR00p+lKBxU7LPfV59WWa+PB1ZkOiiS87f689llJtjhDZMwP3P9+KTomMKk07nnM
 4s0ewqCGR6l5GQMHgBkpaif3dMFCXgsHBtKC05oRy26dB956tvTZs7slgK26hBAc5km9
 xvNBZR24I1t8dLWB93sDZjoDeGVpABjobZgij/KsPO3IpDefk7pdTguodV+I5nPeEKfC
 eY7hZw3ozqmMsH1QpIdKJS08se8CQLC6KDg8qmQVL76mqSARI9ldQQ6rRxGt3Tdrxg5a
 um/nsqMdCG+d+ZiL28udzeCeU1tl0uHAlwAXxfuOg3wlHfbDPQKtBE3p8uZnc7tXAxVn
 NBLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1DC4GI9Ckd+ys94oIJJeL0urouuTLhh74fwmGPbhM97Jb7eNuyhkMSWNW9lyTiOiBT8Nf6TH/Eevy@nongnu.org
X-Gm-Message-State: AOJu0YxeVDMpyJfeflwF+ZjxaTDOuxZKnZ9Lah2thKnRnjPSvg/sM6WV
 UAzNK74u2DIbD/BDuG0pTY1BJFbuEtQPYczg0d3muUnAjuIAHjIhTZ1O
X-Gm-Gg: AY/fxX4x35uJ0sfkakC0x8C7yhG0SroUdd0yPi1PtAHi0DHpZoJ8+JZxmFgO5JSegaR
 7UZJAGC5MQKj/wg+dC+/5K7tbFge2XYXhqgV8Wwx0OQLeeLprcrF8sQQQzqBljdhS5BsIxycZyU
 PWLhfrnlrmDGXJj1Jnoobb2018d6Fly+GauJ/7VTeZCeSSZeVr93fwk0rAkzM8+gMVs7JQVR76q
 O5pyh/+nFYVBGzbN3cNQJ79JIL9UNNPU55NJ3aUST8beJOyfso7bycKG9oUG/pK9n7LfgjfoH2u
 JYr8cGJYOtz2jU5rqJbbB37kzik6zEIv4N27F0sd/PjZWku9fQe+1a9obKtiCayiKcDrP9ojKF0
 orTtIfHuUsK6WL7J/u1YsaEEUlMqCkEFoLvUOU7IYqgZWHjDKKzGorLFOSRCCX+Ku1j2KF3aMZg
 FKaiJMg6hajrHRfjif0QoDedr7Ncyct2W3hCbGHOCaJ/zD2MAP0wBVak0tyOo=
X-Received: by 2002:a17:902:ea09:b0:2a1:e19:ff0 with SMTP id
 d9443c01a7336-2a599e76d50mr16007985ad.39.1768366087731; 
 Tue, 13 Jan 2026 20:48:07 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:07 -0800 (PST)
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
Subject: [RFC PATCH 09/25] target/riscv/debug: Implement icount trigger textra
 matching
Date: Wed, 14 Jan 2026 14:46:42 +1000
Message-ID: <20260114044701.1173347-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

icount triggers are subject to textra checks, per spec.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index ecedffd3b9..d835c0e79a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -675,11 +675,12 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
+
     for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (!check_itrigger_priv(env, i)) {
+        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
             continue;
         }
         count = itrigger_get_count(env, i);
-- 
2.51.0


