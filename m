Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCA9C021A2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbMZ-0004jz-Sm; Mon, 10 Feb 2025 16:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbMI-0004RA-7N
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:30:40 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbMF-0002V1-W0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:30:25 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dd14c99d3so2418589f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739223022; x=1739827822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LstW3Dp8wkhRDMPLlcZPAPERKl2k3gDe4YnYzMJVkXE=;
 b=AHuujSzT/vIc03J7vcPjIbWL5sK+jSW/DyV/WXxknilZ/ltsSpWanjW8c9zmu0k6rr
 A5tptiAOhQA+NTc6adnBnGXQjfbX6T1Qxpo3NxTTCvi3vZZ5RYEb5+7OLNPjeoifoR9x
 /tmPaUg9GL7iDodVE2aK/xCS9FvOVOIJnvseb27QQg0GNEaT6nIfnMpR8mtC9Y8cp4uK
 0hwAPkwX/Gi+VZmJ7OCC70vOkjCJ836+McK03aoOkuk8qjjdYb/d+bjLp45Oo6/v3z3n
 yKtqbG9ensAnuc0nZ7INbPCmImFYJ5juXL+uFcdXQtRIJxF+F8PHGnvsB0f83CgcWu7C
 A3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739223022; x=1739827822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LstW3Dp8wkhRDMPLlcZPAPERKl2k3gDe4YnYzMJVkXE=;
 b=MBC5dOUGatMQS+5yua/O6iTKUctu3YJB2QDK6Bwv4jElcajeG4VvI5aHh96ydVpYol
 JNHNANBm40s6yzXe59l2A9FCepc+v33yukG/x/5+5zbvOZfCbf+uF+a7pSr9xyb+uLLo
 Yek3ieu5OBCk242HtYGahrbKluscsyzAzRX4HuKzAWsSlLP/xKRuwL868Osb1sg7Nw88
 vw4jw8PzoWYwTUzRZVlBjHiNU1s5F47yCuBvKPNPxE4N4zQjMijOKXBMZ79ZxwdjEBa5
 ozt97gDMhRKJaES5Pfw3v7C3rZtRszNpvJHIPc3WNKdvN0lHw4BwcQN/C6o7PxkM4XSU
 Brdg==
X-Gm-Message-State: AOJu0YyaG1/59zwq0CJDJuapClNKjk8WLBIH67eklUPqXgNex7rGGiEi
 ew5Yg91/nYp8ef3yxecBkg563xyOXnTs53WdcBSfustTfZiZHietTQ7eEk0n9uiD8Uzj5Q01kgx
 boRw=
X-Gm-Gg: ASbGnct5+fWgLnYJw15k1p5wEmEQhrClPBURv+Xr6r7If9/F79RAWUL5egB/YJkawFm
 zApUKxt+70zgmh9cCK9JOeWYu/Ulcd7QUM3k+yrHauKXUHodaOM7aDMZ5GHJo+pdjrdnGUwdXA7
 mm733rfRc9eiTFCT/PFYg8B1TRDAwRniw48wNIaIPHLRiiHmaVgbXkLZSOAqaPZm393gs2KunHx
 fgxnsEnxVfaUOz3ijEGmYxe7yiluhI2rHvAQpzwdbw2ZZ4aUwUg+nFNqL4Ys/xQRFaFlNFEmNLs
 qy/vRHtquokyVV9Fo6UCDdCg18NQNwMDfPn7l36WyN6Y6pUaBSe75w/osYv6o2DT6Q==
X-Google-Smtp-Source: AGHT+IEzTJ44VsNwmKpxj/vB9wEUjYCYpZ/i3rUv4ZNFDQKr/78ZUuyADGycQZ/O10oaiL3ZlWS2BA==
X-Received: by 2002:a5d:47a6:0:b0:38d:d9e4:9ba6 with SMTP id
 ffacd0b85a97d-38dd9e49c91mr6523185f8f.3.1739223021731; 
 Mon, 10 Feb 2025 13:30:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf7dbcsm193931685e9.30.2025.02.10.13.30.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 13:30:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/10] target/xtensa: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 10 Feb 2025 22:29:29 +0100
Message-ID: <20250210212931.62401-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210212931.62401-1-philmd@linaro.org>
References: <20250210212931.62401-1-philmd@linaro.org>
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/xtensa/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index efbfe73fcfb..bc170dbb5cc 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -159,6 +159,11 @@ static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 
     info->private_data = cpu->env.config->isa;
     info->print_insn = print_insn_xtensa;
+#if TARGET_BIG_ENDIAN
+    info->endian = BFD_ENDIAN_BIG;
+#else
+    info->endian = BFD_ENDIAN_LITTLE;
+#endif
 }
 
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


