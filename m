Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F01DE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvx0-0007TA-WD; Wed, 04 Dec 2024 15:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvwz-0007SD-Rh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvwx-00070Z-HW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434aafd68e9so1520005e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733343977; x=1733948777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPV/ubcrZI2iapAPKTXZkCgfGpvNQPE7G4ysbpy5Jw0=;
 b=dRqngvANIAybBI4plRQlxbGRt7LPEOiaCux0KvE/ZHgfjadcIpzfr0vJYNoYv20AaK
 /wZvLKovl491nwxERsQyNHincW8MTSAgH1bpoyFqa6Wsch/lUMGFjEZY/aAFsvKYXHVw
 dxCjmzXDOgGfmonYcPcLyjF7ncHNBnCJGTBuwVxkS0/cAHoIYnsVnCH3Ivdd3BPYeD2j
 0Pd83NvnY49xelDwl3I8T8RBjRNUrDChC8wuQ4kYoIZTGQu0fEhduDxDAbgTtzpiS62o
 +2vlgpGt3n6H00hJYR4Z2kWeXqxwbVQryGLCgj6/2K+yxE8pEvlhDscguxfvj52uGaaj
 w2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733343977; x=1733948777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPV/ubcrZI2iapAPKTXZkCgfGpvNQPE7G4ysbpy5Jw0=;
 b=sXbBkp6xWem9GcZkm1Sdr+5WCC6YGdnOzEMxZsVvJFoLdomkl/yTxRqdDz8O2WbTLF
 yYQKEPKH/79n+PHeyfGDEUWBQcz+a/3NXf7LehOnrjwiHhLe3fuk1Kfe3uZu9wH8Taai
 /68O2tHONU80G5kp18dCWR+kES+d3oW38pk8adWRc/YD/wVS4qV2q/IaMPWdV3cUWHI5
 159tiQDRXZexXcVfvTQXjMZ8ctm6BQphJB04sp21rW2UB4yFbGmpjQXt8lLOdgI32ggr
 nfJEg8r96QBGri35fOfwcyV02Cat2H5/sT34n40xps6qek3w4YvJDb2x5TBWdNbkU2WC
 dHfw==
X-Gm-Message-State: AOJu0YzBmGjh3A1c45EHJvTPH6nfIexZWtWlxtfpCocgF3DsjXBMeNEg
 YPgZNW+H0mzcDct1/UHcFta33bwjdf/4B3p2w0ULzklVmCMFngZD8qP9+U0UkgYTTQlOUH+iRPx
 o
X-Gm-Gg: ASbGncuBb1D0qnQeUM6gWu7R6gyBBbk/am+3RVtWT04XCO27X6Z0CA26W99cZsLLHoT
 ze/2VJZkq7R+NQkXniT30FC9WXJZun19+Ie5TwC2xInoQjYtpNz0B2wMqVCK6dEq4+1+plr32VC
 m3SBCA4yyh95D+fI5rjNWxSbNhW4gTt5E2ovhBRcG3tgS/8T8Cd0GqPxm33xrZ9fMvK2lUPak56
 W7qAgzsjAdXztnWBMOAsdg1tjYUQXbZQxG8GkFwT+AyR8CzN64mTr9McbDBByHtr4B6Y1GAIuZ7
 DH+K2jIwhTAwJnchb6Oq/qBk
X-Google-Smtp-Source: AGHT+IFeaA2c209Xgk6HxXqyhoIdq9s4nD1+pCKbz/xRkRw7GRhfUdt4Ky6Zy1ZjVBGrOnLx7SCaQA==
X-Received: by 2002:a05:6000:698:b0:385:dea3:6059 with SMTP id
 ffacd0b85a97d-385fd429a01mr6525111f8f.49.1733343977503; 
 Wed, 04 Dec 2024 12:26:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385faec0c9dsm6672009f8f.20.2024.12.04.12.26.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:26:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/20] hw/core/cpu: Introduce
 CPUClass::datapath_is_big_endian() handler
Date: Wed,  4 Dec 2024 21:25:44 +0100
Message-ID: <20241204202602.58083-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Introduce the CPUClass::datapath_is_big_endian() handler,
which returns whether a vCPU expects data in memory to be
in big endian order or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3..91c6581f814 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -105,6 +105,8 @@ struct SysemuCPUOps;
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
+ * @datapath_is_big_endian: Callback returning whether the vCPU expects
+ *       memory data in big endian order.
  * @mmu_index: Callback for choosing softmmu mmu index;
  *       may be used internally by memory_rw_debug without TCG.
  * @memory_rw_debug: Callback for GDB memory access.
@@ -151,6 +153,7 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
+    bool (*datapath_is_big_endian)(CPUState *cpu);
     bool (*has_work)(CPUState *cpu);
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
@@ -750,7 +753,7 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
-#endif /* CONFIG_USER_ONLY */
+#endif /* !CONFIG_USER_ONLY */
 
 /**
  * cpu_list_add:
-- 
2.45.2


