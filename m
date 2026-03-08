Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B52F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Pt-0006nR-DM; Sun, 08 Mar 2026 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pr-0006i2-Qu
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:07 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pq-0001YF-8x
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:07 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2bdfc4b191fso6049491eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954345; x=1773559145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FYgaldNviBYwmlMbWUmbtHwZ6I6FRjtzV/+ajNVBhY=;
 b=dr+FZTy6dmyk6GYTkqE7POJtR6NBkWAtOpxNMAwHutumRXyCiI8JHF7mf4mFeDGzXZ
 0YG478mKieYy4xNzFWV2Pa4QbYFV5Thy9NfuZBDeGdYHRBQHdKRX6J2rkC4EmjlQVMBI
 v1Ssx+ZCIpXiVqQZVghYFsUvVo3lYkYs2t7kgazstd7eHQaa37yUw4JP87swx431gHME
 a+Ib9aRnR5tVUGpiaIN3nxjSOFlih1G4KfNihAkACpd+wHiraORfeeiMMtgLvES9nzYn
 o+Ho+VCJDCBW5qDhY0zVMvDhgJgrYZgc6HQDhMZSpNNeC7c9Sb+8pxDCXi0VXPT+THYc
 ALFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954345; x=1773559145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FYgaldNviBYwmlMbWUmbtHwZ6I6FRjtzV/+ajNVBhY=;
 b=LtIFHTmRYU+QI/06NykkEAS6LMk3P5GjRv0/2dg6xHRlROecgsKrSnNw3ZcdSnjg/n
 QpnZJw1dX6zRd27PxAe+LM8nggvWIQ0d67cIfly54/5xcOGErn5P+mJvvCu3sA15pAxR
 Aua83NsP8OHrfWVDxgYVuaKW49c2nJxhZc/+AfRERrvvv41Mx2txPJOaqSO7Q6WLmGkC
 zZwo5yeOFRKxVqhlZ97KPy/KWQE/yYqYfA3Ht4NDN4L/ChA8YSrhVf7ICB+gyDRdPzf4
 jHzdaexv6WtYrDYrHd2WcXO5z5BIkXizPMqU9rvAr+gMSU/foTH4ez55f0Rn3P1xw2Zu
 JQ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMGjyDxUd+se+dc+x2/9u+oRsHXieYqB/ZF3YDb2Z+AT+h/t59BE7Q7Bh0OI+TPqGuf3OG4HGg0fm7@nongnu.org
X-Gm-Message-State: AOJu0Yz6QAv8ToSDi6VzTcKQzL7ZdEH+tj0AKHF2i9WEwCdUHPfHT+eG
 ugmSi6Tm4mnqfU5W6FOcNFtDNZ7Kz6qUxoMdzCjOSKuQEQ819EMesOOV
X-Gm-Gg: ATEYQzzA5bblIYjGT2333TQF49hSqooESEl5xi0bP0SdJi+gCKlqo3xBo6FYaHQhe2H
 oHqi0oXt4kyBbK0vOG99u8nUgoc/XMnBNjtS53bV77550dmfzgl5svD7+KqyEbAe2GVtoErgmSh
 z7NleDXIJ9cOfz+WqHkYOeyY0+vtw8QciUt3ZgKATtS1EbQnFuVrLiR+ZsI7ccj6aTC+DoSXBRx
 RaCGtqdq/E75BoRagZ1eMSpgYpbN4NQytT/N4Qnwr1Wy3ypWskeZ+fsqPGv/wPpU2BsnvVBf/yf
 Mayb7RVb7BqAXBNrVoXzdsvf/sQQ4FLid45fioMrDGlTdDI+KMqGXphsIogadlHRwQH9SdRT7y3
 mxpQwDyaQa3oX95l8HkoS51/pSimUubpNoF+/y7rdA1ziBV5Wn/LJrZrbjNTpLJmo8ldCtDxjW7
 HUyydcvAuJwq4wUZ+3/FsOijfJAawmOkaijXwJEIJLQTlRFXKrt7FBgPfnmbL/hx5AUiwqBwLCG
 HMDjqnDV43hxkGAVA7R1uxlCvc=
X-Received: by 2002:a05:7300:a887:b0:2ba:a60a:15ef with SMTP id
 5a478bee46e88-2be4de8dea3mr3085524eec.1.1772954344869; 
 Sat, 07 Mar 2026 23:19:04 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:04 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 06/28] target/riscv: let ebreak enter the DM ROM
Date: Sun,  8 Mar 2026 15:17:09 +0800
Message-ID: <fe29b3622f3db629078fdbd466829d7a777e3100.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

When ebreak is configured to enter Debug Mode and a Debug Module
ROM is present, restart execution from the ROM halt entry
instead of reporting a legacy EXCP_DEBUG stop.

This makes ebreak-driven debug entry follow the same ROM-based
flow as haltreq and single-step stops.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 945688eca8..7f2769f444 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -517,6 +517,10 @@ void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
 
     if (enter_debug) {
         riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
+        if (env->dm_rom_present) {
+            env->pc = env->dm_halt_addr;
+            cpu_loop_exit(cs);
+        }
         cs->exception_index = EXCP_DEBUG;
         cpu_loop_exit_restore(cs, GETPC());
     }
-- 
2.53.0


