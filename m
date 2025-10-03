Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD5ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTz-0007dz-0i; Thu, 02 Oct 2025 23:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTv-0007b8-CW
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTj-0001TN-CA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso1306230b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462142; x=1760066942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vr0e4UoAPxLMWhFqkDNYKeUglLnWLkPWtIy497A4i7s=;
 b=ctrTS5Vjb9AMzyNEvJyp90uc+EfD0nQSAonIU+D8H/q68TZ9jqKwuHW29YuM4IjEaL
 TA7P/70xf4O1nHB9eu6FtEf2d4c9IXR2AMdqGbSN8gwwoSdToJtkzynIoxfNWpjseb7c
 0WsPiKiErqFpn93+jA74H/LE7SIou9kNcev0Bwz15HnokAYsKRX43Oy+fFUqrDorJWVT
 scEQi+eFuAjLywcp03O/pBc+2oqh154lwj7WgnJ4pm3af+KSEngTPqh4ybKF58j59Ewv
 pF0sucG06EoYKn9aTJV5Uuawy6VxVbaFlG2WtjY2GTLW0trGaOOQhbFLiTxxotIgw3Ij
 hzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462142; x=1760066942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vr0e4UoAPxLMWhFqkDNYKeUglLnWLkPWtIy497A4i7s=;
 b=v1HhXDvhAK3i6MX8d0JXK22bVVOaAQZXLzMFFNR1S5NmVxm3cViYa/WNhsx0hpQEtI
 rzJtbaEQ4W5MejEYttA68KZi5cAZdwsj08D8bY8rlAsNwX3QfznztVIfE9RmSpljbg48
 MdX2lCGF1o3ibfQuU8ob9m2KRpYXkmp9xeePcmHUdWI0SZWhSQug0rm8MvmaYW0GHXm+
 5f0xC/RuA6wYWyqbcHeGlyM4s+ELDA4RL/D8/2qqNt4kWT/dSLqXfs+eAW/VDpFEZha4
 jEskwMFlhGH9F6aDW+/pHdto/oHnbD+yrmWiXuJatBVEuxwa4qwHaVyyXg9LltLbTVRA
 tHqA==
X-Gm-Message-State: AOJu0YxfjEe3I6x4hc+KDOHVJ1URwXQg0hQ4mvvBMjMjdD1OOs2mNwuw
 LkKtAMJhZfGseuTiYpV7QAFG7mPXS1uwDkYz8xX5EeVaqRYeSk20L0S/7iq0Bw==
X-Gm-Gg: ASbGncsSaeqfqCJNz1aAEW3kdsPv8VaLwNdpMW+odv8cofHSjx3x+oKoMSi8dDpqPc6
 f76K2jYTryAhkD9lOYqh+gVHgXyZxPNwNBnIrxE+sp9L+nh1bE9/SeIPXGzwaoSt/Yb2MtWBnLk
 yjP/8tbU/ZMwx6tjnAe+jrGfniE+YcCwqTzFRDEFYtREJ8fwRH3jMA/mldjISJN8ykYwTzVP5YB
 lQF3FtAGrbOQCV+GnLHnBoPnFTlDGv7lySldvHCzYmEr6LlhepRgKKXq8sYPFRt4J31UHOJtDfm
 mnjkXMEMLM9o3AGZPuCf29NVhAwlMKRm6nucaXftI+xtw50dWDv4FqSwCrDybEOdZigaQD9EtUJ
 l12nx7PtABa5iNzf8BDDpxcLV7kQtHimv1zudQOzcSpSyAweoPoUKm2zsFHyvCzf9T4BhYHgkDI
 RXXcnfC960A4Ts26A3uGtZXab59xaJtiLCWgRqaGLUApLP1ksRB7V7
X-Google-Smtp-Source: AGHT+IHhvP57IZQA2EdKWXHFtX4gz7+XEtwwEf5VcSJVbcBvi2SjiW9Br+bqVVuMBJIuwparKPkiCQ==
X-Received: by 2002:a05:6a21:32a8:b0:2fd:a3b:933d with SMTP id
 adf61e73a8af0-32b6212a95amr2248500637.58.1759462142313; 
 Thu, 02 Oct 2025 20:29:02 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:29:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, vhaudiquet <vhaudiquet343@hotmail.fr>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 qemu-stable@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/26] target/riscv: Fix endianness swap on compressed
 instructions
Date: Fri,  3 Oct 2025 13:27:17 +1000
Message-ID: <20251003032718.1324734-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: vhaudiquet <vhaudiquet343@hotmail.fr>

Three instructions were not using the endianness swap flag, which resulted in a bug on big-endian architectures.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3131
Buglink: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2123828

Fixes: e0a3054f18e ("target/riscv: add support for Zcb extension")
Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index c77c2b927b..dd15af0f54 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
 static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_UW);
+    return gen_load(ctx, a, MO_TEUW);
 }
 
 static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_SW);
+    return gen_load(ctx, a, MO_TESW);
 }
 
 static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
@@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
 static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_store(ctx, a, MO_UW);
+    return gen_store(ctx, a, MO_TEUW);
 }
 
 #define X_S0    8
-- 
2.51.0


