Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D14CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEzh-0004Ik-Vb; Tue, 21 Oct 2025 12:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzd-0004ES-NJ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:13:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzW-0001at-OA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:13:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso3979379b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063220; x=1761668020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27TC79UHh7APf1kYdEu3SyfuDzXTlSkrNQqbdUNBRwU=;
 b=EFv3JipMcTxiZuEB7b541OD7aenJEphRSygWyuDqyjnLJvaPT9MQWevA/J6camucTb
 gpwjl0lju3tIDleq9f6/7IT8heL+js2g2FXowc7Je7df2N09e7xG+qfAxGAOl4Cz3Gxk
 mfqFaBE7CCoSXA3HFpofh9V1hVv/maeP1HEYfgKHoZ310BIyVwudumhvOrMyBsqzgnvR
 XD7zxVGq4RE/hC3YgAKA8Cp0fftgmE2xDZxJKQaq28WdZwfpXnMKDslhMYHcdV+PGc/W
 HloS/CfL1+B+5MAnR5WfaiTcoP0kWlvqG2MiMcH0emf2IUZXimsy5kaSxibnHgIUPL2Z
 vUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063220; x=1761668020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27TC79UHh7APf1kYdEu3SyfuDzXTlSkrNQqbdUNBRwU=;
 b=FzVJ853y+1ZZtydhCNr8yDJm34VtBF6Lei6nnMtpybM9VCt4BRVML7VKBZst2/qDLA
 U8gyqxPCvbuVrYL6lQKtytDvcKk8l39A7ZpAqXnkstNDuknEkWadIAgpcHaUrkH8xn0B
 9M9Y0y4xBoJur9iCC9ibyZ46PX2FYKHDbHgv7hIE2nZm/K84b/N0+IKo+xJ+KQLZWVnr
 BoQMHR8setJd7Y7aX9tciJTQcI00d/F6uAjUtO03dAEt8mjZlXCUiNIEGv9o/kll/lH/
 guBG7Qo2hYVmedS9Jtwqkr/4t2Ceo1ElpaZH1Ke1o1lnM1oKjOTKALWEzcuP+P3+M61o
 qceA==
X-Gm-Message-State: AOJu0YyhmiFJVUSvTKTmTx5dd+FNGy5kAzUNhSApgflYHgzehlLBUQu9
 WmcxzLSusEznDbwiTVXg/OoRNFm1hk7OxNYWaECx74lmWoD56+jznl/fIxY7z8V+JOF/+P/qYed
 KLFyBWaeZqZs9XuvV7mFV79g5e80eTsaEvBXTnd6JvrtUlilnWg0t9ucDLBUkEKTN+yIXtWsVFW
 GG5qnlacxwHAc0rRPnd1vZQjlX3eVy3D/IWGD/HA==
X-Gm-Gg: ASbGncuIf8l1Uf4scAr5TwRwZG4N4MZF8gFTgOfJ7UiB22aNdNhxR6gX1JjW34a+WWc
 yfvCp77twkhbjB07mf3wywpInQH9eNoLKiRcZxl0Rm+iMRCI0BMVlrVQ87ZcaPbauVd6VeFWydo
 jxYdqdHUQvcKRzaQnAv0Sa9zGCkixY7lWbCuf0CsmvfLHjg1qyFvw2plEvZ9KwfCZx2lqi4G8Fe
 92elBnct1Kza92ubRH8TBBt1vbXHHq9E0spQqocuPAq2trRop0BsqBrekHLUTU6tuWr2KhT476E
 w40SELs47K2dmb9yBMSGQE47LnisTmZxBU7puP+Oo3BC1j3Bfqj9RuD486Xx7q6KOEXlhNlcpcW
 x0UDv09klEav/BJ/SXl5x34bpPG7LnljV5bVqtTQi1JuJqxP2ha04wLkKaB/8ELXYi8Z3NC4+D5
 8UW6wll9+pEBMzihKnI0WJjJDwGWQlloZt
X-Google-Smtp-Source: AGHT+IEvKEZ/oorCPRUE3+2drUtMz/WjilkHhFd+68pw51VUwa/jNnxVq8UgoGwKNSE66uhNYDRydA==
X-Received: by 2002:a05:6a00:4b0f:b0:777:797b:7318 with SMTP id
 d2e1a72fcca58-7a220a5e685mr19877401b3a.7.1761063220131; 
 Tue, 21 Oct 2025 09:13:40 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010f7c7sm11731157b3a.54.2025.10.21.09.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:13:39 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 09/18] target/riscv: Allow global WG config to set WG CPU
 callbacks
Date: Wed, 22 Oct 2025 00:13:15 +0800
Message-ID: <20251021161325.585278-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42a.google.com
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

Some WG CPU functions depend on global WG config (like num-of-world), so
we let the global WG config device to set callbacks of a RISC-V HART.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b121e3bca9..8e18b5f13e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -513,6 +513,10 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    /* machine specific WorldGuard callback */
+    void (*wg_reset)(CPURISCVState *env);
+    void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
 };
 
 /*
-- 
2.43.0


