Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D4C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSNr-0002bm-3v; Thu, 27 Aug 2026 01:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSNp-0002b1-MT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSNm-00043m-M3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:37 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso1490513a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807433; x=1788412233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vh4dj4cz7gBkDt8LT9ZzL10T8leVWvoTLVZlSAppwZk=;
 b=nKrjF2CmxV6/J4vzLD/eZEMk8OKrylIn77HQeL2ErRBC54UyiiUwyOVN71/mM+laf5
 PcTshddp5Ju68GpEzGCuhQML2ELMz4Xfm521Rul+2jM/MEmElzHEB9PujfMQtu82Unf6
 tGv3eCHDtzTwCPe5Q/elX4p6rL27ZD4hXVHYMLQnKEKf+5WRQeOD9GQWFcedzLQD26LJ
 Y1bS8VPwmeXv+virFE7kpD227MnRhKD6+nR3vqHazqLRev0zWlbsfnn4Mqmvm72OQZg2
 /n5OygOHW4bf05jey8z/CeO/aX6UZVesOLLRVN6AeM7yFItAGmdxdblHUZZrMd+B0vmT
 TfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807433; x=1788412233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vh4dj4cz7gBkDt8LT9ZzL10T8leVWvoTLVZlSAppwZk=;
 b=MBnHdtBv9NfgUHT2X+U+XzHUcHW9yE4vwRYcef8FWO634QKThRS+enwCHQwGqhvV54
 IhtG4d3xcbD8/KLKM9niOOjWERqRnMtjMtHk3nWctgYtzqao0gIU6h32/vYq5brbKvQ4
 vtYrXlaIipdwS/0t5HXYA72K19XOQ9KAJY4s3oEl6BgvDiYm3FFRnj8ONtm35vDJ7xPi
 /EOtV21I8h2fw7UWE4QKF+pf7h7k9FswAq5oLzorhAlt+/uSoEsytmZat5RZwHYl5OP+
 qFDdga/9JuUbzv5NdgmZVl3laERTL6KXLb2zJzU3pg4D4TMYpCVKjx1sF+nIiKngnaJM
 oWeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHB75P9PS+BM8GyNhTMHTh8ROOxBCXrzg3ADvbMUa2sV8WWTEcbhUzzB44VWlttaoKdD+XmBelswET@nongnu.org
X-Gm-Message-State: AFuF++mK1UQ5YlzVb3jqcE6hLo3f4dkRcmFYZD77bwVQ4Xk5POEmJUPf
 PsimkTGFPxW/YtIiwYZcp8j3MWslnpWRhKGUI/Wkx8uTowSX0LJiIlSx
X-Gm-Gg: AR+sD12sTWxihoF4w9Wk7Ep7YRc9GH3zs7+wa6fALByWgFc2PlG7b60DuC71WaMjw1z
 tVsLmIB2PErF7vIzlz/72Gb6f0gYHb9y0/oyFUIzD0Md5QmVZobCQvvsUmT1OiJk+6mbEBWys1U
 b1iGdWgSRCAj4hhbS2BmFmUfm0LtIfLW5ywpE5IT9a8kxhAF8o9MnbiMjosD4tTASotjmHUwWDa
 q/DWI8yel/v4loRyBogPYyf1m3MZ9t/Y6HLkQ/UpRutk463Q+3rfFWikkqdf+dinHWIerjiCloQ
 VYznTsQQdipbG69+bcPWQi0A8mi52FLtnrvGQEyUDZbhOGP0zjeo6hApUsYc7CotwQapaBxv3cC
 7SW30tUFhuDBKUXh4WTE9bkTagO+D7qsqsaF5FHkcCmMJcSVVwLIi/wjHpmSDHSitr+B1FntXyG
 UFurZ/plfWTDS30qkVKhe+oGCJ0/zMsMOVMV7EhgWXoL1U7cxyR5vWP+eD7AOCGtZou5Xj2IwRY
 5sa7AqKwwdbKdXZ14SsTwc89LglHIccbyjcp27EliHgCekn4mVvOypaJveuM6Vk/BmL4QIXM/Td
 pey9XyX2mFriURKNvYNA
X-Received: by 2002:a17:90b:4a50:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-3966d48c3e9mr22557303a91.14.1787807433348; 
 Wed, 26 Aug 2026 22:10:33 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:10:32 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 03/12] tests/tcg/riscv64: Boot semihost tests with -bios none
 -kernel
Date: Thu, 27 Aug 2026 14:39:42 +0930
Message-ID: <20260827050953.67184-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Loading tests should conflict with the opensbi ROM, however the generic
loader writes through the CPU address space which bypasses the ROM
overlap check.

Instead of depending on this happy accident, set -bios none to skip
loading opensbi. This frees up the address space to load the test with
-kernel, required by a future change that uses the same rules to run the
multiarch tests for riscv64.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/riscv64/Makefile.softmmu-target | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 6a219c306c43..562ac9b0e0fb 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -14,36 +14,36 @@ CFLAGS += -g -Og
 %: %.o $(LINK_SCRIPT)
 	$(LD) $(LDFLAGS) $< -o $@
 
-QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
+QEMU_OPTS += -M virt -display none -bios none -semihosting -kernel
 
 EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-test-mepc-masking
 run-test-mepc-masking: test-mepc-masking
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-test-minstret-ecall
 run-test-minstret-ecall: test-minstret-ecall
-	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
+	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-plugin-doubletrap
 run-plugin-doubletrap: doubletrap
 	$(call run-test, $<, \
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
+	  $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-plugin-interruptedmemory
 run-plugin-interruptedmemory: interruptedmemory
 	$(call run-test, $<, \
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
+	  $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-test-crc32
 comma:= ,
 run-test-crc32: test-crc32
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS) $<)
 
 # Zicclsm: misaligned load/store support. Assemble one source twice: the
 # default build expects every misaligned access to succeed (zicclsm=true),
@@ -61,11 +61,11 @@ test-zicclsm-off: test-zicclsm.S $(LINK_SCRIPT)
 
 EXTRA_RUNS += run-test-zicclsm
 run-test-zicclsm: test-zicclsm
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=true $(QEMU_OPTS)$<)
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=true $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-test-zicclsm-off
 run-test-zicclsm-off: test-zicclsm-off
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS) $<)
 
 EXTRA_RUNS += run-test-misa-w
 run-test-misa-w: test-misa-w
-- 
2.47.3


