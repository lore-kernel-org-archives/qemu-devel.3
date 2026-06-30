Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B97C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVxD-0006FQ-Od; Tue, 30 Jun 2026 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwi-00066m-1q
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:07 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwg-0004q6-Bm
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:03 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-37e4098e920so1801795a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1782816241; x=1783421041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lNhqIEO4Y4/uK8KijQuDX0PHP8gR1qrz5+KexoydX0=;
 b=V5BrZi09W91xkjScJHLvf//dFzwze5T120wwz4bicmWd3xzqdOlO4nWjhfqskzed5U
 9fIxBCw7CInbNuMlENnduiri0ZJ3lvOCGdePaKVSFO4a9oFrV9NJKYfmx1jNUZkyJf3A
 j7sAHoPnogUNadZcI/hb5PPZCRoPP5VJamyJVs1LL5cRfP9c3NZk/wKNtdaV0DwFyeIp
 WBrwZ/TlNYeId+Wugj9tBEjPFN/q+eIDRYeUui3KRq86sO8asZWlCL0ITr8qdFq9/6sW
 iYXbI/z6uWztSlzwIvnUYkEm7mXNGzL4yo3A0UJxfZU1guXrlLP9rsUHjmW+mY/a1mfP
 kzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816241; x=1783421041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5lNhqIEO4Y4/uK8KijQuDX0PHP8gR1qrz5+KexoydX0=;
 b=VMtgTnhlsHWBMWguw6u9Nl4D+LXMvSBT/dv4VleddaEQ1iWWkiPrtrj81x4gqWmSHQ
 7zfC8gneSi03UeZUaZUU3fdvSEakO9LyVk7yXJMgvFwTlaZoJayNo/FZbXBso0UWQ1V3
 MBpHIsfFp2Q22X3RWbWdsKP2Etn5DO+Cus8jBwXgOtMDNpzqYbN3b+e4qYY5YUPfldYa
 thrajIV+TywfLTNqbhal2bYEzAB7FQggtRp1WIuW2i/6fGn8Yj5EOtId0k0zTvExob6E
 BhZkdcodorWhAXFgAP6vxr/A/9oGUlSwHdC6A+cAaItX2BnMaasktzRvfsvjqd9GssFF
 rQZQ==
X-Gm-Message-State: AOJu0Yw81qnp+bj2lJa/OZORpOzWuQL+j629ZaMh2dgRtTW9rcvQqqmf
 ycwqhCOqdNagnTKP4kUKhqrutfUPcLd25AR0chA4tuHXyYT1sR8zPsFStkCQDLoSjgP2ih54EUE
 +gChjWrJioeIG29qqoSxiAt3NSZcKPrpIQN5C5v3Twn7lk6uxOW3JVeDrpfdnZLbvJaz2glWJSK
 2u4gZZyQLcQsuSAXdZxgUYjhZsSm9JsA+CtwaurNHRz7odutAz
X-Gm-Gg: AfdE7cm96I9CfaReA8uuCgFPWiTwhJ3lmuP+kfWQn7pIsOJJpVMleVx7iMATV32hACn
 WP1NbwtHDWiXrXpKF2+OD6Qx+r3QntovdIpfzsoV4lzaihQiB/WCKWVVGDKfVq5geBwP64KrJbe
 MRrox5mb4IutbC8HVjktfTcgp6xXWfVClLCRC5I5pY0z+5OiS4obM/BsPdexRU1joYaM2AZBftj
 607rgQxa10kpbBDwaaSsV3ij7+ZbcwZ6VzygL3JVbQ2rWNTnj7NeqBv7OCsNB5ZMAc8RmdyMpa5
 ZJvpHdcfEqeG510ugisAMG6lELfXUgHR+6x3JFtC31SJlRVJKQGB5Zq3aWIGIRWwkivJMwWawFL
 JFspy/tK5im7vhnlnoPdqv2hKA4+ZS9V+Jg9T4CXUOpog18t43EOWPhd9NbfMi08u0bWIRORk+h
 +0qP0B7rEdvtQ5qNIN2ywwSSArAwh8/nGgl1hBpP89VCj9uUNGeQ==
X-Received: by 2002:a05:6a21:648e:b0:3bf:a412:ca11 with SMTP id
 adf61e73a8af0-3bfc52dfba2mr2882693637.48.1782816240923; 
 Tue, 30 Jun 2026 03:44:00 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bbf95be56sm1274745a12.16.2026.06.30.03.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:44:00 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 2/5] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
Date: Tue, 30 Jun 2026 18:43:47 +0800
Message-ID: <20260630104350.748267-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630104350.748267-1-frank.chang@sifive.com>
References: <20260630104350.748267-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1029.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from scalar load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index e47b16a7fa2..cc1b5dbbadc 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.43.0


