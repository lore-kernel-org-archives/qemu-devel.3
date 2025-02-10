Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D706C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbM2-0004AT-UA; Mon, 10 Feb 2025 16:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbM0-00046I-JQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:30:08 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbLy-0002Qn-45
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:30:08 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dd9b3419cso1044653f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739223004; x=1739827804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TcZHkuWys2mgVq8GL0a6AId6axol/O+ywSBYt05fm4=;
 b=x3rQpBQ0c+TrEIT7+Hy0zDViNuJ7ynH5fMQEwrLIfl5D1yMS/wtOcifDbxaItyj91b
 GWdvbAe//aV6WJATfyo2O9rBraL9as/S24IaherGCX0Xiw7sXjVcNpsHcISYjlYcBd11
 qYYifXc3lIV9ASC5LO95TmCvRqWp8cAiBqAvzHihEsvEDwOLlf4diizljBLOnAfZwJhp
 VTgCWVI/d2L1+X186O/NkAgYcLABFDo0Pssy41B6tgq+UCEN8vo+HmUY/bwO/UcD0m2o
 7j03OFIWmtg2RblczMAr8bmm3uFNwX9pAOkojEqiYvEbg8Z69znErj94JnY0wsQHvec6
 6rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739223004; x=1739827804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TcZHkuWys2mgVq8GL0a6AId6axol/O+ywSBYt05fm4=;
 b=utm6Rsn7Xv4gFAksqpw4jq9sBQGUikJGj52FdMSffpF/RUBzuJqRyRCZyKm2AQ0984
 0ubAY53QEFjSZhQ8gGgbgCzVaOvqvsCQIs8XBqSbamidJBDQgkOeSase+BIn4ixP8DJd
 aHNAnrwvlgcfCXmFGkIMQtBiOl0d5jh/fWbIvmXXHQpxF03em7K9YNMm7I7crytAzd8i
 p014SIgqTRtDFGM1FKe0eoR/h1OlSGxUsOtOWhboxuWmhVQESxsVF70wiGhYC9/VjmGl
 pZLvtPCBjSYOPCAFD+bDEnEv+7c0MaedeVADeN11PD78jbZvWCw9CuqSQ5du96LKTGe0
 4T5g==
X-Gm-Message-State: AOJu0Yw7+x3C5F1whj34wQbhTpOhz5Lyxk8EF8mUcEJDJKcqASXhJTsD
 aj6V3YFRRuBKs8alZmsSuEWbrzHkCqf5c3C1OVGvNKk8C8gVT6tZ7/2ppvSXSGbn6EgEqKg9W6Q
 brAg=
X-Gm-Gg: ASbGncv9v6cemt3v4oWP/GWGWeXGsEXDjY1FSd9283OeGEkpkHFMqaw0LwqPy/H1GSx
 UfLejrMDs/UKHumW9nJ5Z+BsQvz4VFjdwSD+2mZgYMsupJc489bxP84weVMtNcyEKepy9HVYGTL
 346cerMgxIxJWAFuxt+CpBpSJqWSdjoFQiHNSIsZGno9Qn6iqS4ERrVbk024I61JY2ZK8d4pM9e
 KzkPRL4ZUzA31uwdqjxoe3wuE5kfJBoH3ukizy+rr8XaD67v+uxjoOkKYK3MU8Qxu7zcyzBXd6j
 UsTtnsisrqW6fI00xl0LRvVJEK6W1l01DAnUBe2jjEjPWqHWEjDpHrm2yBakMznWsg==
X-Google-Smtp-Source: AGHT+IEybuJN0iVC0lvUnYblFezq2sKDkEo6bIIrzo35HIr8jogIOE/wSfSGM77kq46sdHxBW6II2Q==
X-Received: by 2002:a5d:64a9:0:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-38de416d70fmr1012371f8f.1.1739223004112; 
 Mon, 10 Feb 2025 13:30:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcd34a39esm10092759f8f.30.2025.02.10.13.30.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 13:30:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10] target/ppc: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 10 Feb 2025 22:29:26 +0100
Message-ID: <20250210212931.62401-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210212931.62401-1-philmd@linaro.org>
References: <20250210212931.62401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Have the CPUClass::disas_set_info() callback always set\
the disassemble_info::endian field.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 25e835d65e7..e816d30114b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7398,6 +7398,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 
     if ((env->hflags >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
+    } else {
+        info->endian = BFD_ENDIAN_BIG;
     }
     info->mach = env->bfd_mach;
     if (!env->bfd_mach) {
-- 
2.47.1


