Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257C5E63F19
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEH-0005W4-Fn; Sun, 15 Feb 2026 17:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEF-0005Vb-1O
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:35 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkED-00051x-J9
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:34 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46391e91e16so1598666b6e.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193069; x=1771797869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxLWwnLWO5/HaRXFh+o5fRDXxqBc982XqQkT3y5pKHs=;
 b=ORIwS9V+IqnO8J24sSJoxJdeR/4s8DmjQHPVT6ALUmDZp71QCW2/V71e/CLvtWc5SD
 P3RBgvBw1MZR8CmmVZzY2M1L02DkDY6hUsKh9/GOldOnV3O+qjbMtYbrm0ifNkL6uONB
 /TkHLv5b7BwCkl5OtNzFyR3Z215nik6yOme4poKCP+4hKL3S5uRxRwLIQgxCVfboVxZB
 YvGYr4ydVVLoNgC+e9MEDHciyxzQerky+zH+eIs1Lrmbzg35tSeN9nxzc2pe97Gy0/eR
 t5rNIFuQnSaFmQQTD9ZDMvKnX+lIGixdJT9eRfTia2XyRDZIjRVMCvJ78yV/nfTUcxWJ
 0eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193069; x=1771797869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxLWwnLWO5/HaRXFh+o5fRDXxqBc982XqQkT3y5pKHs=;
 b=hpBTHtxbXVZI6FMoSlJ2OoQ0QnFPzMxv1J/toj5xGA+DoBGFzSMZlJb9hld/2oP0rB
 vzG/OeLQFzlqLByP+GWv7pMis01deYJmGvurqFflaGtqXihx6VH5+bt7QIo5qCdp//p7
 vY8AiMSKnFoLN+IEMmIkNzx9u4UtgbmVrciQRLSWwoBIsMb3MiCULhrTdWGVsWMHakdY
 kVO4ksTQn+WNe6ijjDvK+nAZvjtI/jNkU38FNvyiZHIcA8vE8+DHVZ+FTd569uS19gO9
 XixtfhIen0HTBjVI8h4GEzI4h81iszHZxuJ9mgIVIg4wzhUxIRoqMZJVO9j/scz5bfqZ
 r80Q==
X-Gm-Message-State: AOJu0YwewSfdMWt0tEeGdjCiqdalSuCMKV4zitxSN+YH4ZywWgJceOrs
 0xhiCq5U393NKLvlmS3FZtw9364r5P9FF0cnuzB2Q2wONMeAKbjX1HR7FPonIw==
X-Gm-Gg: AZuq6aJGAp/5Naw4UKrJtEUua1EhcA0rcR7mNoC6lx+TyJjilzKX9jk4HbO+wjzS51o
 2+B2AHLa5nL2+svBHTzDQF4BbUrO6/pTbfa5sexcMau2JjmckjirhRYtQCZLSQkRzt+JB/1BW/a
 iToa+N+aOpxny0KUCyfZ+IJi5JBTna9DUfFpq+b4hVVu6uKpJhITsMqx00Uo1hdhq6wrekAlw1p
 1tTN0ShjRRQnmekMNju7Gy/Kr3vP6ETB1iX56Z0F7sIT4TUcyWYz8dNgOI3chk5QeSntjhJJ+G1
 yPfCt5nbXZHbZIehv7ySu9Tke8cWMgwKr3Gdck2ai42vs/UMx3DssDEiWJ7dKWCKOuRHSBpPGuU
 TCHkh9423C/IyWh/PP7IF/sgFlVUvmePExFuujFw39wWxDFLhLvV+4Jepjhmna2aFrVKKI8VbF7
 U0pv000T4LeyS3GaihHK/kMda0PMm8Q0KmgVClRKEQN9SvVd0p9sF7NlQPTvmZWfQg0HnR3MHUh
 eni42uPrXmJMtgj
X-Received: by 2002:a05:6808:50a7:b0:45f:42d6:2fff with SMTP id
 5614622812f47-4639f1e8f40mr4545781b6e.32.1771193069658; 
 Sun, 15 Feb 2026 14:04:29 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:28 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/8] Hexagon (target/hexagon) Add Hexagon version field to
 DisasContext
Date: Sun, 15 Feb 2026 15:04:17 -0700
Message-ID: <20260215220422.212249-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22b.google.com
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

Initialize the field in hexagon_tr_init_disas_context

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 1 +
 target/hexagon/translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b37cb49238..c95c26c1d6 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -30,6 +30,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     Packet *pkt;
     Insn *insn;
+    HexagonVersion hex_version;
     uint32_t next_PC;
     uint32_t mem_idx;
     uint32_t num_packets;
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2fdc956bf9..d300c910d4 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -988,6 +988,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
+    ctx->hex_version = HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_version;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.43.0


