Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD8AC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsg-0000eJ-Ay; Tue, 20 Feb 2024 03:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLse-0000bF-FI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:36 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsb-0008Gw-Hj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:36 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3eafbcb1c5so178898066b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419212; x=1709024012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUu5a76jY50nFXASHYB85g2gMeODgMhQO6/aUsbeOwk=;
 b=Z0Bt4TVRq2O03dtBCEP7PyvVdREEGogaSNzCqx8s0YY5eRv9zneQ15txxQacljjz4T
 /2gzwInDkTo1jDusVinjzYFqahZEE5J+GP7zc8CRSzqgcjP+Lo1DShoe47C8zOfZ7mHu
 FkePGgYEB+NFxZiyz1J8ZANeD9uOoi6mqRr5YwgOF/1yDWhskqttx7itaFf5Sn9lspFd
 yLiFeVrNNLPK36wE2tqSVgEUQtrT1TcMiauhShPwtJDgM9bzJn67MnP5nEtIivuUv0Zp
 tIF15DCdvwEXuLNBJxVynr7tnOQIjxH+3AOI6C7yzaXEw8G7QOBLYJFN6rrjbMDk5uYb
 Oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419212; x=1709024012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUu5a76jY50nFXASHYB85g2gMeODgMhQO6/aUsbeOwk=;
 b=Vf1Bq3q34A8AJr5qafbvVi+3J41A9vBKN135LhoRsZmlpTOJA7KN1ZcHTwNGfvDjmX
 cdRwD2P2lbJaH9bWxfx+6bJ13Nx8noizZBqmoTysCWSRB5gBSTW9VWMGWoxM7qzlsSQ/
 PNbBOwljNiDlAEw0uR+wS6VZcmDQH/B+ROBgO+oT8ZnVYPa6Y6D93aot1AXAvIxMbu0F
 ugMPo8ga5t43Avm3DilGsuE+Rt+YBxcbuQ4ukiJRqo2PWva4CoVuRFxVo1o8U0SorhOB
 cbzqAYhb0G8y691cnYsuJsgFRwUPWL7rK0iiUkxAgKI58Qvmsj/JdXIBbaGvTW/Q/8O2
 7v9g==
X-Gm-Message-State: AOJu0YyIzS0nxgo5T2bng4VshQR/hPJmTYgu1UmleePD9LVDsduvRZSd
 q9CfFA6ZnmfflNmebCHVxUbpSO0XVeKVm+87pN2HQB0VXIItsjZOeELBF9arOEI=
X-Google-Smtp-Source: AGHT+IHpL6/7f/V6MddKY5h8nGC66oEHaxJ/oG2RUhoH6YSIo4i4RDkTQ54lOTSfJopnQ3F2N12RLw==
X-Received: by 2002:a17:907:9869:b0:a3e:f163:75ee with SMTP id
 ko9-20020a170907986900b00a3ef16375eemr1054420ejc.75.1708419212190; 
 Tue, 20 Feb 2024 00:53:32 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:31 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v1 19/21] m68k: correct typos
Date: Tue, 20 Feb 2024 10:52:26 +0200
Message-Id: <e24a3deefb9d721ace414719e8b773e6bf787fcf.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/m68k/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index aca4aa610b..57e3b6d3ce 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -478,10 +478,11 @@ void do_m68k_semihosting(CPUM68KState *env, int nr);
  * The 68000 family is defined in six main CPU classes, the 680[012346]0.
  * Generally each successive CPU adds enhanced data/stack/instructions.
  * However, some features are only common to one, or a few classes.
- * The features covers those subsets of instructons.
+ * The features covers those subsets of instructions.
  *
- * CPU32/32+ are basically 680010 compatible with some 68020 class instructons,
- * and some additional CPU32 instructions. Mostly Supervisor state differences.
+ * CPU32/32+ are basically 680010 compatible with some 68020 class
+ * instructions, and some additional CPU32 instructions. Mostly Supervisor
+ * state differences.
  *
  * The ColdFire core ISA is a RISC-style reduction of the 68000 series cpu.
  * There are 4 ColdFire core ISA revisions: A, A+, B and C.
-- 
γαῖα πυρί μιχθήτω


