Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE0CF64A6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFuG-0007eh-Cy; Mon, 30 Sep 2024 08:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFuE-0007W0-7x
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFuC-0006Wu-Q2
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37cd831ab06so1418699f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700815; x=1728305615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A54AZmXL2K4S/evyBU6Z+PuWbfLne3N1JrnXSUgIbU0=;
 b=HNdzUcD4gvsy9Ns/BR8ooXmFkvlNx2q/oMMNsz/qSsu8GHRUYoRpcOMeWUn3dXXHQg
 mf5piQpj5tuMcvWOOSkRl3340++lJ0d9DB4jrpXjoc9XgTl/Ni/5jvRCEllMWUeiUFoZ
 git3ZKWz1ipwDJCx02EGRNtZIWYTpiG4cFknajZr+fKpxkz7s4j56E/JeLoh7QGReEVx
 FlcWjyHVAeRkFCBYrj/1oW3awCmXhAxhqziwp5Xov8qaFA4HrDhr1SafPuCHmu5R8/Zp
 xxk6slTEBm9N2DqO/2sPPof9dk7tBrwHPV00HB7xtCgovrsbueZAWaBLTQotMwXvWgmI
 3UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700815; x=1728305615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A54AZmXL2K4S/evyBU6Z+PuWbfLne3N1JrnXSUgIbU0=;
 b=mrfops0Ryaunqb1y7FFe2Cq12ViI8BWPezI1T5t0bR+SpL3jAfutvtb9nnvsE4YBub
 0qU+ufLckH/DcCPfs5Z0eXngZYE0u7m7roO3X/dqZpA8agLiRZJAhA+YdgPZZNFAn7R4
 RN1Iuj4zTr+K2CWeWwOlnrNJRUNahxKUJsMiNjnYMgui36Bq4ju/o6jRzfZjAT0UaN17
 pAsYQMBqkrYMypEfyXIoutn1VUnB9jqUq3hJfBLLcWGXQLJhvDsV8EXR38R0ISLSqTJy
 KSlLrlHVwSe1oJRw+712zhRx6TK6dNjwgoGdK6Mqx+84kgR6oMZRf291s8c+kNdRduX9
 siBA==
X-Gm-Message-State: AOJu0YzJmxfm35f9OdHspeJNRUK/4O6hB1LFF4ZEWoL/Y5btpLIL0HW8
 Jj5vQbi0Y64u8ZuIFUJBeZXzgljVG1/VLw7zYiBpCJI/VHW7iLA/UfFeK29Yk9lY4JritK4vAgY
 wzqs=
X-Google-Smtp-Source: AGHT+IG6FA1okpu2QB/TxZQl+zaSrG3+73s6gMHVvjez1IzAcrSzTh3/M3PoQrnOI32cQeogUZ+Dig==
X-Received: by 2002:adf:f1ce:0:b0:371:82ec:206f with SMTP id
 ffacd0b85a97d-37cd5aa9c14mr6128167f8f.16.1727700815008; 
 Mon, 30 Sep 2024 05:53:35 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57450c7sm8943227f8f.101.2024.09.30.05.53.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 05:53:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/ppc/sam460ex: Replace tswap32() by stl_endian_p()
Date: Mon, 30 Sep 2024 14:53:22 +0200
Message-ID: <20240930125323.54671-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930125323.54671-1-philmd@linaro.org>
References: <20240930125323.54671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Replace the target-specific tswap32() call by stl_endian_p()
which does the same but takes the endianness as argument, thus
is target-agnostic.
Get the vCPU endianness calling ppc_cpu_is_big_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/sam460ex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 8dc75fb9f0..6257ddbec6 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -248,10 +248,11 @@ static void mmubooke_create_initial_mapping(CPUPPCState *env,
 static void main_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     struct boot_info *bi = env->load_info;
 
-    cpu_reset(CPU(cpu));
+    cpu_reset(cs);
 
     /* either we have a kernel to boot or we jump to U-Boot */
     if (bi->entry != UBOOT_ENTRY) {
@@ -261,7 +262,7 @@ static void main_cpu_reset(void *opaque)
 
         /* Create a mapping for the kernel.  */
         mmubooke_create_initial_mapping(env, 0, 0);
-        env->gpr[6] = tswap32(EPAPR_MAGIC);
+        stl_endian_p(ppc_cpu_is_big_endian(cs), &env->gpr[6], EPAPR_MAGIC);
         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
-- 
2.45.2


