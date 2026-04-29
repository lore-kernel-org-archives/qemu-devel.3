Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A690DFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwqx-00013x-AU; Wed, 29 Apr 2026 00:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqw-00013b-EK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:50 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqu-0008IL-R3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:50 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so6092243a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438127; x=1778042927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTreqGd/1Raf3RsX/9R0sQ7/2mzs2tC0VLy5UcXV31E=;
 b=iuR9IbI9pPZgR0YwyP4FCU079bAXUHdf67eO9aTQ98MEK1/vCrYoPDLVs+gZJItS60
 6BeGCZ2KlF6jYgb7bCAG8WgS/B7J5DurAmD+zmw3Qm3XUrQ/Xu3axWwXoCyZZ4WO7Q8K
 LprwgfNxneYDpf+Y8Ydm5u7yLSuXAy6TEs7Cfrh1U6w1IzZNaJ+dLp0DysoGXwBEDc5c
 Yg4OVuEGZbwtNEFhO648+NCfN5o4+IUk55ejH6O5igTeqKo25bbplAl/jnO/1NF5AbGB
 +p+WNoXyL5bTQ+Hmb5IW16iJ8xF/QH6ZjupG0N4PDcmKXHPaZEJSs5HbyDlAbgi1/+CU
 rysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438127; x=1778042927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vTreqGd/1Raf3RsX/9R0sQ7/2mzs2tC0VLy5UcXV31E=;
 b=tWMJx5wo/128ZVza4pZOGneFjN5Tb53pzRndE5J1fde4FDlMLbISi9mN2XucxDLGFd
 RCBP2vGHpLwLFqOPjnW6f9RV1cv8yAodfts60pLa/m0PWD+qNBOx60PaITo0xJ5sirwS
 6bVScGFAawur7h4dj/TtMLTVZaBDKPOle4Dl8/gbI6wuReb/mr8ltnR7m+FvVFGDYMLu
 3H4/6JK72p2eJDnz8srBCn0Yj4nxBH+8VS6/FsonVFDr5onjtf/XCIDsdgdoVkxc1lpM
 BG+kBnFCHlff44MokQxC7au9SlMxpM/qh8pxmyPlj+6g0yxZ3gEsE40imIUYxTQvNvq6
 fQmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dc914SPwG+yYoy4DtN7sVdr9ypSnM2Hw7FEGlheMf6k410ZL/J1I19CVD1MUI2igB8Ht5xiJFo2Hj@nongnu.org
X-Gm-Message-State: AOJu0Yz1Ip2GUuJXm+AT5KmGZQl7XkGRq3WmsOewORsnoVRTqCB/77mg
 Hlvhnrw3WbY/Dc+ENydqTLyNFDenFVF5JMo89a5+dc6uQ5JlQFqRVxJC
X-Gm-Gg: AeBDieu8ZIVyxmq+6bHVPmrGNGASA39Job52D0eHGc6pzz9tYHPunGRYWzwoaouWYKq
 R0pF4taUGB2xmc++XyHa4bQ+9rssmReq+5ZvFEdFuH0juXE44Fl2fLYxEBCD3hfaKufD5pgJSq0
 +STB/n4gUSStgh/JxEEZ9y2TzfMDM89vz8zFmxTnm0R0UPlHYAzKKcjsAmnJnfm8IX3rclQLtis
 h03Z6zFkFeZY0zml8DsculuugNcQ0x9VZI4SpCKoP6GtnRH6JgVrZ0kVDKvHAau5K3qQybUA0hJ
 M5nRvYztm/455iRvM6LwI7K6Qps5I2r0l5yp3CXpDx52wRaeDzBSpEowRzQXTqYNYpPCIDB+0SI
 mIJXsaz4v7/B3JsmPOL1B30rAFfGn5Wx3OtQ7Qg8pVS8RzscoMZ6hroU6n4c9duPCMkAfPirxwd
 XyY/CHtqsommU+I5BZ3yF0WXcJ0TPoqL+vYtNq8EtrfNBtIgWuY3sk
X-Received: by 2002:a17:902:e746:b0:2b7:97b9:54fa with SMTP id
 d9443c01a7336-2b97c4b5056mr69431435ad.32.1777438127345; 
 Tue, 28 Apr 2026 21:48:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/51] target/riscv: Remove MTTCG check for x-rv128 CPU model
Date: Wed, 29 Apr 2026 14:47:08 +1000
Message-ID: <20260429044752.4176397-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

We had to check that mttcg was not used when executing QEMU with
-cpu x-rv128 as a single 128-bit access was done as two distinct
64-bit accesses.
Now that we use the 128-bit ld/st that access the data atomically,
this check is no longer necessary.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Message-ID: <20260101181442.2489496-3-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-5-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..3407191c22 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1305,16 +1305,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-
-    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
-        /* Missing 128-bit aligned atomics */
-        error_setg(errp,
-                   "128-bit RISC-V currently does not work with Multi "
-                   "Threaded TCG. Please use: -accel tcg,thread=single");
-        return false;
-    }
-
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.53.0


