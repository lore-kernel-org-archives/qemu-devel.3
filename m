Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A4CC0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 21:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thEcS-0007J5-VN; Sun, 09 Feb 2025 16:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1thEcQ-0007Iu-LO
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:13:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1thEcP-0003NN-5U
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:13:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso24436955e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739135611; x=1739740411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mxNmu2xFcIw7eeu6rCjpzywjGDaWVjP/XkaZ/Tsld0=;
 b=RAdVa/buKD7PqvZZPJXkC6FlD3b/1mnkuz9Gwwh79lf9X01BVa7LHMwcudULEXMuIx
 PXk5QVayI/IG7SpU+kMOgDLr3rb8yToOX+s8IweTguzN3Uz72dAX8DrJUSfmIxSfKHq0
 3Mv3OWtD8se9cETV7fIuP2ixsH7oppOqw7iDW16CTf7zmCQoe8tiaMeDH76fwIrsWNMm
 jb3j9a4Zy/3+ZvRiUQIOFcm/K56fG4F8+1Vda/bSOL5z3ccv+yqcD0TtGMjQ+F1otEGw
 N6Da9z/bCqOp1k3m+12q+Xi9lI7efxUv6GnA5A/RrQ7cdzwvmOiywU7Gx17mYE8psg+V
 mI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135611; x=1739740411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mxNmu2xFcIw7eeu6rCjpzywjGDaWVjP/XkaZ/Tsld0=;
 b=bUnYtWmaADIuh6MxDqQ0yJ3t0UzNhPhRd0SxekMOweUBnuxV+9O9yuC1WC6JbgdrMP
 CGp4zvg02ptchMFo3zatJIz3E2k71pG6BpPGNNoXfWcau+v6Y5cm3uGZNe0CKOV9AlZF
 30tK3zoStD7jM4R0ib9ZvlKmVPYR0d6rbds3s4kNXE0XIAsYINFA7TkZCEp6njZdpSx6
 mT5xxp8yLBiyPP0jAu0nz+UAZSt60TopxW823K4pbWcfqQ02Z922lHpLfHciVKg4eE+t
 CmgszOiUO5MFeHKgnqoqcFw+CFX06m4t/UNrTkKDrIkS1c4Y1GEkot/eZq5geMdXFDHK
 E4tQ==
X-Gm-Message-State: AOJu0Yzm8KQ5HKMt+KjnlC+Sx/wxeePZLSbjIWGP3KkN8ko9p2vBkR3s
 ez0AEA6/EBr5Q81636n2ykMv98r4rVoQ42CZxiGZonz9D2sp5roAE0rcGAQO
X-Gm-Gg: ASbGnctMn8UUlYQJX5pSMbgNJLc7EaBBNhuTsLo6YI8q1pMuz/dqTR9vPL7m/rg3Zr1
 RtFlhcqrRzYziMrqDjygeHtzTYirby31UBB9pl/N05bnXy3k5YqgIShexHSmZyCakoSeS2MhAjV
 b27QDyGftlNaYm4avqQxkOb/k5Hcb5NAbRBSI4Fg37q/IUS49WieLErXcz5tAEAe4WCvo0of5kY
 1vdiaywAXp7mOTylYXwWszOsHuLwoRG+UYy9WzycwGLI/xPmlg2AIsxFooTVGVVfd7nzIzlwgTM
 CLbGtAx9VmwMBkUc50vFZHXhb3VmLqVXuWLDAnZsuNHHOt+/2A5+WvSTAu09r2Fg7SL9vtmMz3B
 cPuXDbu0=
X-Google-Smtp-Source: AGHT+IH+z5ZwmEYNze9Qd6b+uGIRoid1lrlidhxGorHbJ7cwRb/5G6DL4OPW8/NCm9zDF93/VcnhGQ==
X-Received: by 2002:a05:600c:4754:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-4392498ac55mr97841765e9.10.1739135610774; 
 Sun, 09 Feb 2025 13:13:30 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-077-012-237-182.77.12.pool.telefonica.de. [77.12.237.182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d966faasm160357045e9.23.2025.02.09.13.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:13:30 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2] target/sparc: fake UltraSPARC T1 PCR and PIC registers
Date: Sun,  9 Feb 2025 22:12:48 +0100
Message-ID: <20250209211248.50383-1-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
References: <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=atar4qemu@gmail.com; helo=mail-wm1-x331.google.com
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

fake access to
PCR Performance Control Register
and
PIC Performance Instrumentation Counter.

Ignore writes in privileged mode, and return 0 on reads.

This allows booting Tribblix, MilaX and v9os under Niagara target.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/insns.decode |  7 ++++++-
 target/sparc/translate.c  | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 989c20b44a..504147563c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -96,7 +96,10 @@ CALL    01 i:s30
     RDTICK          10 rd:5  101000 00100 0 0000000000000
     RDPC            10 rd:5  101000 00101 0 0000000000000
     RDFPRS          10 rd:5  101000 00110 0 0000000000000
-    RDASR17         10 rd:5  101000 10001 0 0000000000000
+    {
+      RDASR17       10 rd:5  101000 10001 0 0000000000000
+      RDPIC         10 rd:5  101000 10001 0 0000000000000
+    }
     RDGSR           10 rd:5  101000 10011 0 0000000000000
     RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
     RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
@@ -114,6 +117,8 @@ CALL    01 i:s30
     WRCCR           10 00010 110000 ..... . .............  @n_r_ri
     WRASI           10 00011 110000 ..... . .............  @n_r_ri
     WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
+    WRPCR           10 10000 110000 01000 0 0000000000000
+    WRPIC           10 10001 110000 01000 0 0000000000000
     {
       WRGSR         10 10011 110000 ..... . .............  @n_r_ri
       WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e5c7351cb..bfe63649db 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2882,6 +2882,14 @@ static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
 
+static TCGv do_rdpic(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(0);
+}
+
+TRANS(RDPIC, HYPV, do_rd_special, supervisor(dc), a->rd, do_rdpic)
+
+
 static TCGv do_rdccr(DisasContext *dc, TCGv dst)
 {
     gen_helper_rdccr(dst, tcg_env);
@@ -3315,6 +3323,17 @@ static void do_wrfprs(DisasContext *dc, TCGv src)
 
 TRANS(WRFPRS, 64, do_wr_special, a, true, do_wrfprs)
 
+static bool do_priv_nop(DisasContext *dc, bool priv)
+{
+    if (!priv) {
+        return raise_priv(dc);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(WRPCR, HYPV, do_priv_nop, supervisor(dc))
+TRANS(WRPIC, HYPV, do_priv_nop, supervisor(dc))
+
 static void do_wrgsr(DisasContext *dc, TCGv src)
 {
     gen_trap_ifnofpu(dc);
-- 
2.43.5


