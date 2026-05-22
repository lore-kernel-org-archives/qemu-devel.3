Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7A7CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNu-0002Dz-8v; Thu, 21 May 2026 20:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNj-00020n-Q6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:52 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNg-0003hE-Tf
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c80167f5716so3031502a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408286; x=1780013086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MirGdvlp1h8clJvrvy1Hkb6T0OVMX8liN9iOwDmT8JU=;
 b=Bhdv1TicT/ScZOBr9eEHe8LH8VamRdJT6J2Say2avJpLbYNYZa7a0WbABVXLrYXe+H
 8fa89fRj9j6SlLC6/vXgba7a0f1fBBRZ1vlddIl8UrPguur+0s7jMAScBCA4ifaWGksP
 3ZsA7LE6r6ORXrFxEYsuaZTSEj/VlMZhp6FQaM5+7wdlvgqhpoxDiuajMd/vZqOce2ah
 Fes5IMKIaUMOZOjszEhUmC6M4d4oQA6MSnJljYQwS9W9/LWU0Dgbm5kVkAIkKaKWDCiR
 SNUlpqiVWTG7wHHQND7W330YAoJ24TrFxBq2o7OEIwvleRJxXBPfk5Rcw97lS25WZ/Mn
 /3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408286; x=1780013086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MirGdvlp1h8clJvrvy1Hkb6T0OVMX8liN9iOwDmT8JU=;
 b=Dp/woI7/SBM6odWWIhfDGDij38iiqOZdyoZHTufOcOl3nhrlKxJ9dQyHJSNttApHEt
 +0yLj+G4+Cde9BkniulVZCbERUsJ9eXnIMl5T5FkMmwZkoB4zHqEWNXu7mQpZeVCVty6
 499Y5eiR+nA8MRrCjz0amuZDeERA/XbqsfTRHj1awfKEW98PHDyRko27ttIWWLmNBkdl
 SN3Gj8YmRS617RVtS/0jKM+lMYTWlGDzrCmftgluNxdQ02BuE0ZnV7lKgyovpX6cWrFd
 3zUSZikMt/rX0kg2kUC+3RQxEZHl4UPON5/ahkx992o18GNA53RNLGx5qpbk6obWmGZM
 SJSg==
X-Gm-Message-State: AOJu0YxNc9dYLK5mCS+2haRuJvdMCvYCtXi6M56QD7fvRhUFY5wVMSFK
 Hu/KTTX62Fl7OGkK9ZxSmUsOqxn7PcDl9gXEXemjYb/r/YtGc6LJkqykN8v8NGTu
X-Gm-Gg: Acq92OFFd6eDdodD9xCI3c0JUNdicy85RqyfvolLvDBBZGSubxoJeM6qWcVv/bSYIng
 b6lZtoa2KpJEEx34oM3R4bOPyNM2fdjDQdLWfslKSloZSRj0UvwT2i0VVV29PaSCpYDPgZGH5y7
 eYmzruYGqoDk1XOr2Wy9S3WC5HiJpNqvFei+RyWkeIZVz7xGCZfbpiYFJHG2f8TAB5udMV1yJ0H
 K5w4UCcPpQvm0ZZGRm4tgqZE5mZ1jLhpxyCK3c8Y3pxxKNdoQvzwntZOV65NBFzZI3641PD3u00
 IIeAJqMjZeTUBzbr0qPZ7gp4mpfmhjJq1laiCa9FaK2bEhcvDud5c8m4LHVSZmeanmoDiq2d3MZ
 f3BlMrVls5D372cF8Ce+fIRHM1cPYLd7svOiyHCCv06kX8Ps5hF3egLNF9pK4KvRCHOI5W+rTg0
 dXjeggvdL0aQLgF+2lqU6vX5vfDc5EypLj+eTEuPKrvA==
X-Received: by 2002:a17:903:3c6c:b0:2ba:6bd7:8f00 with SMTP id
 d9443c01a7336-2beb06e9eecmr9878965ad.5.1779408286550; 
 Thu, 21 May 2026 17:04:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zongmin Zhou <zhouzongmin@kylinos.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/48] target/riscv/kvm: Add BFloat16 extensions support
Date: Fri, 22 May 2026 10:02:58 +1000
Message-ID: <20260522000324.23255-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Expose the BFloat16 extensions (Zfbfmin, Zvfbfmin, Zvfbfwma) to KVM guests
when available in hardware.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <1258febb0eeb4ee286eb88f70b077a7f1ece507f.1778653159.git.zhouzongmin@kylinos.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 608495630f..34f60bd80c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -309,6 +309,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
     KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
+    KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
     KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
     KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
     KVM_EXT_CFG("zba", ext_zba, KVM_RISCV_ISA_EXT_ZBA),
@@ -334,6 +335,8 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
     KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
     KVM_EXT_CFG("zvfhmin", ext_zvfhmin, KVM_RISCV_ISA_EXT_ZVFHMIN),
+    KVM_EXT_CFG("zvfbfmin", ext_zvfbfmin, KVM_RISCV_ISA_EXT_ZVFBFMIN),
+    KVM_EXT_CFG("zvfbfwma", ext_zvfbfwma, KVM_RISCV_ISA_EXT_ZVFBFWMA),
     KVM_EXT_CFG("zvkb", ext_zvkb, KVM_RISCV_ISA_EXT_ZVKB),
     KVM_EXT_CFG("zvkg", ext_zvkg, KVM_RISCV_ISA_EXT_ZVKG),
     KVM_EXT_CFG("zvkned", ext_zvkned, KVM_RISCV_ISA_EXT_ZVKNED),
-- 
2.53.0


