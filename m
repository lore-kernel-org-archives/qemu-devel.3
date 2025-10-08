Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A86CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P2e-0002Yw-4h; Wed, 08 Oct 2025 03:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2V-0002YD-Ht
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2T-0004rw-0A
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so66452445e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910203; x=1760515003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ve9jd+oGfkOaQq1hzUDKikljX/fRw14kDDTKSAmdveE=;
 b=tLipPOC8Lq5Ge7sxt4SvdI7Y4xjTVNVDRkGrxunsmThGRo572I6OThi0tx4meSjmD+
 mRNSKkqoFHweMpCKOD6aEwz4pkF71k6+p6mD/oEObTMvVYwY67SFlKAQY3naKCCo3nIP
 A/auQWALjGcskbzgdruJRk+kk+TAUDyXbY9Rk/18eA0hvNUrhoenRwwGko/v8hezy9SD
 JHMW7u2noazETCprG5ZrxmwLiQhugaW4w69F8usZafgVe24GwVk3f8Fj4js6MRV9gXXL
 WsLh1lgYutKA2M/HQ1lBYiOanYSu8N913qLIxRtxvSkMB/7lnnHqZJvOfVG4aKFM5BTB
 mUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910203; x=1760515003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ve9jd+oGfkOaQq1hzUDKikljX/fRw14kDDTKSAmdveE=;
 b=lPaEV3X8xh/4P2uLGx/79Mo9BDEAzgED2E8cccpH52LwPAZ8cp9DE6iF1UqQBsapfD
 tpg+fjKwbsHwsVH0H62gCfLY5+7TNGRRQKBLVL51wLp1I9t7WEIZ/TUXSmZ55BC+7j1p
 QFuGo1AA4W6Tj17S7HYpLkjw/y+NOxHPQIFZ6YBCzaTimpd6BZdWJKZFQQj0b1tjiUab
 eq1O2JKlhvYxZ5gG2Osr7iN+yGyFSAL4bn/piss58N48CD8yJkEZGJX0sJwPbQhm/0zB
 0xa4LIYEmrKs8/FkLmVczrXokswVCAHrq3TbEhzZ1Eo6asLq5CPV2ThSQhZx5aHVqmqw
 Gkqw==
X-Gm-Message-State: AOJu0Yy+ZypnLXQDfRdwj5kKNOjIeoO4z6cwSV8V6kC2Gkjv5d4kU57e
 +oaO3abY/kmitq1NYCdXOKdQdBgD57Ih9PUWVCAa8AaQiLj91Pr4xnCQdsiZfMKa2atxnDD1Ded
 5qkIkfHIhIA==
X-Gm-Gg: ASbGncvMZVVDQxoNKBb4AEG0o4Jx61ZcG3VXqmrMQEBdYF6LubzlurmTvNXWj7Q/6Fy
 Fl9n36tucGyORozaJiRveM/e23L0ht3726xUaEy2KUy9riDad1OE5nWzSKqtSUNGCw/pOy+Ao4l
 CwgPda740ArRGaUsaCuFKUkkb1qFnTU92ysZ4oaT2FH8qB+QuMh5rbJl9YLsueD8j+zmHoUX7hG
 T8xgY8xdrvTPhijtLeFjTK5PdV3iDUgEH6YZJdHrQV9yXFkDZDG4cSRVmhVcwATxUakSQWqaqOr
 43zv5GlMwC2MgyCMVEVncbXO26W4+eF+P+bZUHDdP1TjbLvNZTH/Zax/JF1wSC7Vc3jDoAzBuP4
 ZuIZbRVkDwrIsPYOhH3r80NJ2INCo+NYRKUG5x/0gWbMCes2zbtSeIbf5MvRgGmL8jmo7ozBNDg
 7WBCCdpy+Mg9YIiJzwdAVm3Opb
X-Google-Smtp-Source: AGHT+IELa5R1fBlsLH/Im7z02L5VnRvEJhcoqnxJ5KCMBD/0rL3ZDUadKEBgPH7GkHfJqaVhUsH8Bg==
X-Received: by 2002:a05:600c:3b11:b0:46e:4c7c:515c with SMTP id
 5b1f17b1804b1-46fa9b182e2mr15992005e9.34.1759910202869; 
 Wed, 08 Oct 2025 00:56:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d2c1asm8584585e9.1.2025.10.08.00.56.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] target/openrisc: Inline tcg_gen_trunc_i64_tl()
Date: Wed,  8 Oct 2025 09:56:10 +0200
Message-ID: <20251008075612.94193-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The OpenRISC targets are only built as 32-bit, so tcg_gen_trunc_i64_tl
expands to tcg_gen_extrl_i64_i32(). Use the latter to simplify the
next commit mechanical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Squash in following?
---
 target/openrisc/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 9f61f917b3b..695e11642f7 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -307,7 +307,7 @@ static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
         tcg_gen_muls2_i64(cpu_mac, high, t1, t2);
         tcg_gen_sari_i64(t1, cpu_mac, 63);
         tcg_gen_negsetcond_i64(TCG_COND_NE, t1, t1, high);
-        tcg_gen_trunc_i64_tl(cpu_sr_ov, t1);
+        tcg_gen_extrl_i64_i32(cpu_sr_ov, t1);
 
         gen_ove_ov(dc);
     }
@@ -328,7 +328,7 @@ static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
 
         tcg_gen_mulu2_i64(cpu_mac, high, t1, t2);
         tcg_gen_setcondi_i64(TCG_COND_NE, high, high, 0);
-        tcg_gen_trunc_i64_tl(cpu_sr_cy, high);
+        tcg_gen_extrl_i64_i32(cpu_sr_cy, high);
 
         gen_ove_cy(dc);
     }
@@ -370,7 +370,7 @@ static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during addition stage.  */
     tcg_gen_add_i64(cpu_mac, cpu_mac, t1);
     tcg_gen_setcond_i64(TCG_COND_LTU, t1, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t1);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t1);
 
     gen_ove_cy(dc);
 }
@@ -411,7 +411,7 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during subtraction stage.  */
     tcg_gen_setcond_i64(TCG_COND_LTU, t2, cpu_mac, t1);
     tcg_gen_sub_i64(cpu_mac, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t2);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t2);
 
     gen_ove_cy(dc);
 }
@@ -929,7 +929,7 @@ static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_trunc_i64_tl(cpu_R(dc, a->d), cpu_mac);
+    tcg_gen_extrl_i64_i32(cpu_R(dc, a->d), cpu_mac);
     tcg_gen_movi_i64(cpu_mac, 0);
     return true;
 }
-- 
2.51.0


