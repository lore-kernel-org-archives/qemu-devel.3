Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E8FC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvIM-00060O-6f; Tue, 29 Jul 2025 21:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCO-0002vw-2L
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCM-0004hg-7l
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3190fbe8536so5893164a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837295; x=1754442095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9Rc+6thE21wnYNbJPK/4zcbD+cK53gSa/IlvV/VG5A=;
 b=dXAoqA81Tv/davqpYXNZrAJRQvsae/K2VUYN8wk1/eSoVUmJ8oxkxdYMRcbFvZsoOG
 KRyKwCSbHLKUWCAWKQclA+Lw56wBR596F4/StoQhuZucIUjP33gE85RDUemfkUab4LPb
 MEFl5RmdSYAWQPXUqa8uQAk3QFwSP3Y20H8JeKCS1OrAE5N6K7BrFG1QHJoHCbWUvSyG
 bmA/ipUhfN2RagJIL4JoFwd7fHZxQNN1sGyUE2jAghbFC1CLBEpmmevySBXzORjybW0g
 g1hhLko1TdO6oM+uWwSEeozgua/DESnniqwTKmXI+9RV+iyve0mtnk1iGlcnxHKwnZ7K
 wtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837295; x=1754442095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9Rc+6thE21wnYNbJPK/4zcbD+cK53gSa/IlvV/VG5A=;
 b=PYlQ/3zBuLNsmSolzPUT+vBqBaTSeMPoKFeoAvyihv34ewdA/ujWi9dxPoscOSVYAG
 997XyC+Udvrds00YQKJoAF+IUcGOLMZMMcn5i3TRMQ/mJHPtFyrEMLGWo/iwZuMqkcQs
 er10BB+igGv2zWmBCnmNfTbZya/M65WdSFPBotd3HjqR72MFs5c/67r+xiEXhwaW8Fqn
 7v23+vUpoUrtPHeemsoVjo8Ix3MgkvIng7azKbqNhU0aW5pDark4KOlO0c0O+jaI2TpW
 LiVynE9rlM2JsdO9EmjM0wRtii0U2S3GoOOMR0JsoaHk4w29ngOss/bkYWx3qhV3viIW
 VPDA==
X-Gm-Message-State: AOJu0YyftgxfM4Vcz8XYnLRh4KS9u1nvr8JExup3ns2MsaET3/AenfXn
 ThhpwvsidSvGMP2hIH5Z11hIT5A25QAwtOF5zVQUK8xpmFnjhRmtkPB+3tkQ6g==
X-Gm-Gg: ASbGncuUZkjbvKpmPgesBfMEk4BfdB7gLuQvzqsNI+qBbcSOS3MFvgx0KNaYpiuMhBr
 sVPDU3J5Ib/79KpmOVtEEWQNUK41fq6DBAvuB8Hd0IuUvYiPeZvx6nhYeGHDMK9yGFggDWPFdDW
 UnspgW+IvbRPG7Fhw3kSQAhHoGjllt8ejgANvfDzQdyRpb47GXZY2gsGbF61YjLtLGxrzPtnLjz
 e9TMi4mOaGHH3fKge2UhaYpHHSOmQU8/PPjLufj0SO6vMUGWIhjwarpBBpKSLOEFgCHrY4PZPCy
 7TuTfFBTukAYXSvTfLHuJF/9FA39SaNf2YSQqBH4rzoUzIBrodUojlCRhXNI17FAM8Hb8dCLb28
 1p84y3iNZAk0IGZ2MBfPtlBO7PD/QTbiYJzhPZQXxuf8jyXW2jWy3bb+pStgYvlmgTflLP1HFmf
 8+7LyQFjJbJ5kHnD4Pm9GCgCQICuf1we1+oQRH6A==
X-Google-Smtp-Source: AGHT+IEKA8otmbwQfeZzBZtkDd7RSqjQDp8+hFYv6Cks9s2r8mPGtP/hv++itdLJkyHDBSPZuB3Kkw==
X-Received: by 2002:a17:90b:562b:b0:31f:336a:f0e1 with SMTP id
 98e67ed59e1d1-31f5de315a9mr2065504a91.17.1753837292676; 
 Tue, 29 Jul 2025 18:01:32 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vac Chen <vacantron@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/11] target/riscv: Fix pmp range wraparound on zero
Date: Wed, 30 Jul 2025 11:01:12 +1000
Message-ID: <20250730010122.4193496-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Vac Chen <vacantron@gmail.com>

pmp_is_in_range() prefers to match addresses within the interval
[start, end]. To archieve this, pmpaddrX is decremented during the end
address update.

In TOR mode, a rule is ignored if its start address is greater than or
equal to its end address.

However, if pmpaddrX is set to 0, this decrement operation causes the
calulated end address to wrap around to UINT_MAX. In this scenario, the
address guard for this PMP entry would become ineffective.

This patch addresses the issue by moving the guard check earlier,
preventing the problematic wraparound when pmpaddrX is zero.

Signed-off-by: Vac Chen <vacantron@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250706065554.42953-1-vacantron@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3540327c9a..72f1372a49 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -211,11 +211,12 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_TOR:
-        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
-        ea = (this_addr << 2) - 1u;
-        if (sa > ea) {
+        if (prev_addr >= this_addr) {
             sa = ea = 0u;
+            break;
         }
+        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
+        ea = (this_addr << 2) - 1u;
         break;
 
     case PMP_AMATCH_NA4:
-- 
2.50.0


