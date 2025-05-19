Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D0DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3r-0001F0-IG; Mon, 19 May 2025 00:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrni-0006Gh-Eg; Mon, 19 May 2025 00:08:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnd-0004DB-K7; Mon, 19 May 2025 00:08:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-231e21d3b63so30950045ad.3; 
 Sun, 18 May 2025 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627703; x=1748232503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9koq1jI9PnAy2EBT0cXlCZka3dT6wobo2uoSTfd5KCo=;
 b=nfaZntbmyZOkTlrKRmk8BDTwYDARe1ZPTpJ/Qsgz3bRgDA+eZ7APbur8AYZYWpyYFP
 oIE3gQPsbCPs+9yEUu/xWjAwDpmggo7DtrfkwkQD+dhCVGQ/VRgIf/z/3LDMvTuRMoIy
 QcfuJaBQu0Z43zMDbAlJfnOGbGPIaiE16vD6H898QQrdQvDZ88K/mjOEE59DmfbBbZbC
 4bNr6gdziywjulAdAWENL+jIejwZS4HOWBpXEtNkHW09XcuGu25DHrpSUeKRISr1wC1o
 oeAdlN3vDtQPi788J+9ZHJPLDw0ZO6rSvh+QTJ+IjmfMfr6ca3Yq7fzZje/zNlfVbP8y
 qB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627703; x=1748232503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9koq1jI9PnAy2EBT0cXlCZka3dT6wobo2uoSTfd5KCo=;
 b=tVjMWVE9kayYKwhnswtmJQ8iwB64r8VR3fmfjf7Xj/4Oq2a11Q0GX2JipDJATP/lLo
 i8TY50HJ+W4fdenPwlIAhA43HjkAr9wA4cUOCwOap3LLLdrlpTgsfkJjktVqxJg6SBNc
 OxvUkvmPcScnRaowqPgKycgmiH4FvDNQpvhu9FJPy/Tud9jgPfmMEMFu1q1pYmXWHDi7
 6+BUoIX09VFgH0KVWQHQJxD1u73QxI/aHWxQs9Z6G0HqQO3XzTa594KttF35jgSUxpxm
 EjXUYAGMOnDOvQlw2q2DMhtk9XRQFqJKQ+TmQmHzRaBs+aPYk9Jz8lzyh7v4l1lG62Wp
 /S0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVagHVXUAq1kWwe/Jtwtp+dFyajzg8lg1M4Rh42pn+mLlMQd65pvVKLHaKHJY5XpT681hB1pEm2RC5X6g==@nongnu.org
X-Gm-Message-State: AOJu0Yx1djY0yhVBfw24jx05q1K4la0DSGZSwemSFZVw2I6njinwzbmO
 9T6M6KayXSVZqZ7w+V1vFDfplejGjXHeOzc69IQ+vAaHqIUBO/msxazia3yo3w==
X-Gm-Gg: ASbGnctpN61E5UdXxI1DukB/JR4ZAMq9BJ0pu5h7VhGRtSFLLfUbodcNxooWyHCmJsb
 b8fXk/YkKv0ZkjLlODLYots9ZR6SMSZxehdFepKe5ewxG4XyppjiesbtyKkv421q4y1eutH3DBp
 xJCUzz/NcX6yTmzNlsylbQMRVuuCC7aaaIhYVoD1fLoxEMXVf7BEOKmW4VamwtmKLZHCDc4WtJa
 TLs+iGD7e6QPxcItrqzGumiJcU8xbtoHZuC5QOd9S5msxbso+4lVxd9zCkpUBgvBgir0k5qY20o
 4hUJFnTqJt0fCgYerZ0fMQWB7IvHYkakeLS72Y6GD11CPgZOFzZsf9H7HJzhkBzAwhuciitTrdI
 JR8LZebiScQonMlDFermMr9c4jFDstfszv+lTEBvRPHaCC8BH+GKTEfm+
X-Google-Smtp-Source: AGHT+IGQzDuqoYoqziXn+uoLqLMvemwGRerpgCGtxtUxNV9ibEMMTtC83+1CeVK8T9+nwwDyY1VkeQ==
X-Received: by 2002:a17:902:d486:b0:224:1609:a74a with SMTP id
 d9443c01a7336-231de3ae59amr154737275ad.34.1747627703298; 
 Sun, 18 May 2025 21:08:23 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 24/56] target/riscv: rvv: Apply vext_check_input_eew to
 OPIVV/OPFVV(vext_check_sss) instructions
Date: Mon, 19 May 2025 14:05:21 +1000
Message-ID: <20250519040555.3797167-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Max Chou <max.chou@sifive.com>

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-6-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b1e1db04a0..5de50422c9 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -432,6 +432,7 @@ static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_sss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ss(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
            require_align(vs1, s->lmul);
 }
 
-- 
2.49.0


