Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2209C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXR7-00085a-Ot; Sat, 29 Mar 2025 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQz-00082H-WB
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:20 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQw-0004RL-VI
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:17 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3031354f134so4171126a91.3
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259512; x=1743864312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wI3WGjdzB/nV7QTfWxa/O65tEI33+q/RVQcoNGfCbIw=;
 b=njUgTFGdt1AqsIktZdUMPz17xLOtJwR9TDlE39BHK0MT8sm0CnEaTfsNp0nYJMCEUl
 iT2CyFf5ZfmIligxzaZSn+0XV7wCfpBU5EkHeV9Yz2muDKcJXc9EAhaMD21aavO80pZy
 /uWVeAjtIT8X9w2/DueaFcKPS2XrfAaREE//knyVUEgN9DSCLz8moGllpPbr+yfZC+Kc
 prbKopAy/Tven4n1BabfMxra0GiuRVDLfMiHrTmzQou6fcyHzDp90ILOADkfFfuY6emR
 MBSCR9nG8gBKezjxBYT94WQPv8jp8TY07HhMT0Q2AE633Gp2l2LFtz6Kn6+CZB6B2M5b
 EwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259512; x=1743864312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wI3WGjdzB/nV7QTfWxa/O65tEI33+q/RVQcoNGfCbIw=;
 b=sJKJH8DD8AOnLktI3+L1tWmuKRCzTJkTsD7IKYpuvWpLS5YXnXHzGeEVSUl+nZk3tE
 oRV88pobGIyS8NGDHaZ5JHEGcyZjyB98uviIf5pySFKjACypTMxq1c5tHUj/tagy7B2r
 alytuqtoeB0kyo4LFgI1kWBlVgleg7HDCWUmrDCv/pkekRplE9PwrZeBHCgP/fMVKPzE
 qRJbz3r8K5w1N/TkcfqAedWbS6tXSIQapKpsvVyipr2yuFDnCOWLyWXUIpUZI4yM0wN5
 8v3IOnqcBz4TFmprYsxz4V9OvYShVq9astaIGGIg6NgUlKat5/SaDahnBcjyj+cXhfih
 UsOg==
X-Gm-Message-State: AOJu0YwSWOnm4BAz4Az8ljHgzJyDUu57mz+MueIGh61eLJQQ6Z439AHS
 +6mxQDNAGUWSxT8AeB26pSL0RLpLMkYC4FHYj0cJvRCTyuRR0s6hYxUPGHBK9wLgXbcqTTxMI6P
 iW2ZtgnIGeRjMyIcYaQJ+czIz2LdleyCvqaQ3ZI0Stw1/xVvOGJA+d/A3yZKz3aplRqXgKNomN/
 A27FIyrnOc+QK4ytueG92HbszBau9CLZ9KVKTJeA==
X-Gm-Gg: ASbGncsBYIezfeAPpIouYHkDZA4StCmTl4EV+DSQR9pvYeYMgyc8l2c6PScdDug88Om
 KNEQq6mMukk9cgS5GMsEGG9mVtk9bv+VlY+xYHy92c5dEHqTGutCRZN3Vo+vmcC9aOnNcpUJnX6
 zeKHIS+lT3uRsCgrIo9XIvPLCxSw/q2rhQCqtst967zi1Lcx0W2KbyBFNYN0v0tWvqJuHEouT/q
 g71wYkGvtjTSuQ5H3Z/SUIl+TgO7JK+ImtV7dvDj634vw5Yg/e/9soWRP0GHoHJYzKlV+j6UuWn
 zb52lrjcCOf+xV2bfjmMLxod94I9tG4ctZdgcyxS9FS5T8UcsXB5umR4+d48+7NoqdgWRn41/Ce
 aqTO3Db4V7AKscA==
X-Google-Smtp-Source: AGHT+IFBaJ60tN0FxEOjZUj5m2tHwisPIt8QEytWikW/Lf0mLEBZSEhWf9Rji9JNXkn6Rn748s09yw==
X-Received: by 2002:a17:90a:d2ce:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-30531f957a3mr5213753a91.8.1743259512130; 
 Sat, 29 Mar 2025 07:45:12 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:11 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 06/12] target/riscv: rvv: Apply vext_check_input_eew to
 OPIVV/OPFVV(vext_check_sss) instructions
Date: Sat, 29 Mar 2025 22:44:40 +0800
Message-ID: <20250329144446.2619306-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Co-authored-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3d02a2f9ec8..2282b89801c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -433,6 +433,7 @@ static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_sss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ss(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
            require_align(vs1, s->lmul);
 }
 
-- 
2.43.0


