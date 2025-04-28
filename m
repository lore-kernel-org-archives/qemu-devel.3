Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CBFC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J13-0005WZ-4X; Mon, 28 Apr 2025 03:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0x-0005UM-0M
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0v-0000w3-BO
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6A8Q80jal2O/r0XWxsKgPFOPn+7kL6jWK7xkvukvpdQ=;
 b=aiUvty/zzEKvB/92xVq3CVmg+eBeZIkhu1bZrqBB5+bgRXfuaZErFq9sJUUdDxmkXEbd8C
 fpzbDITYHkXxGt1XZkM8e/Ci+SU5Qq3hknXqP3Dcz2njnXitADixGJvz5fPItQB8APt7eL
 eEXyPgMtzz+VO2C9uTOkqe4U33aANZs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-_yt-24CbOrWpmm3L5QVMSQ-1; Mon, 28 Apr 2025 03:34:51 -0400
X-MC-Unique: _yt-24CbOrWpmm3L5QVMSQ-1
X-Mimecast-MFC-AGG-ID: _yt-24CbOrWpmm3L5QVMSQ_1745825690
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so2312990f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825689; x=1746430489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6A8Q80jal2O/r0XWxsKgPFOPn+7kL6jWK7xkvukvpdQ=;
 b=T7E4Rniaxa/NyvBy1kvzGgftWC5hncQI05jniui/zWVlZEGc2RJvaW4JcxOK2Fx7qj
 en3t8B4t+Gi42qSzBkOztkcAN+Ksg2/aqwcbn0jwtpLhJtH9a58IfRRXVPhaatJ3DxGq
 jlM+z825NbKP7fISBNCnyvCcnHVz9Tsb7f1nnluhHnLnxirw8RChGNIl5JPG03HDEqWX
 m3j3RI7GFB4qzRkEXWC8L+l4hw40Tcr2LwYA1ISMFRWeIjot79QrflSOajrexwA55ozB
 bNc8Fd7JfPU+xO9heSM0/1NQ7ak9bLboNIHl1BhQKSHREoNjsyXFD3PjPUUbEi+HaS+Y
 kz7A==
X-Gm-Message-State: AOJu0Yy3z4TCsm1z1h7Dze/0Lb8h8TIoNG7HyKa1NDy1k0dkHFnMZMbC
 1ry9GTksCQ0ygOxXXdd37l3F/l0EuQ1wPoECxhbUKtqBPpob8/MIW319zSiAPxCs0zSRFsli3bA
 rCGPV/CZja/ybM8sa6/hAso4IHOtWbNz0sq10zWx+3mxjb9meVOVl8VVh4BalvMgvGe8bmLVRh4
 6n94T9YxjcHXaFvTU83JR+J3B9UChgCc5qShmn
X-Gm-Gg: ASbGnctMq3YWi43TM+oJhWBKqE5UYS0m/iDpKG7Hu3bDN1g3de4qf785juUe5GMkf11
 YG7nSc0PZQg3cY9if/leEiBainnB23VcZNi8EkUn+kDqO1kbOytqIxLNCw8YqK3XkP5titYgswM
 fqHyYF9orFWhoaDtOqKGDCrkF3Ie5NN85tRhpLKxklK8+XPJpBb33MjHcafnMDmcAxkHj0i0RVZ
 7HZXx/9M5/4aTZHPGA91xrbD/WC3BZFUUdDAhaQ2e3THaE7Kq3USVwnIwq6saG6CtQdDDLsO5g/
 dQclvQNBKrP1RTA=
X-Received: by 2002:a05:6000:659:20b0:390:ee01:68fa with SMTP id
 ffacd0b85a97d-3a074e2f5f4mr5412468f8f.24.1745825689398; 
 Mon, 28 Apr 2025 00:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCbhDcYVjq266H6xnfPTnegEg1cNRv0W4LrRnB+jtT/ymIF+lKZ7QnlcbVZE/zq991gLduNw==
X-Received: by 2002:a05:6000:659:20b0:390:ee01:68fa with SMTP id
 ffacd0b85a97d-3a074e2f5f4mr5412450f8f.24.1745825688952; 
 Mon, 28 Apr 2025 00:34:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc180bsm10449518f8f.53.2025.04.28.00.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 02/26] target/riscv: assert argument to
 set_satp_mode_max_supported is valid
Date: Mon, 28 Apr 2025 09:34:17 +0200
Message-ID: <20250428073442.315770-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check that the argument to set_satp_mode_max_supported is valid for
the MXL value of the CPU.  It would be a bug in the CPU definition
if it weren't.

In fact, there is such a bug in riscv_bare_cpu_init(): not just
SV64 is not a valid VM mode for 32-bit CPUs, SV64 is not a
valid VM mode at all, not yet at least.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e0604f4c78b..e0e70a2227f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -445,6 +445,8 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
             cpu->cfg.satp_mode.supported |= (1 << i);
         }
     }
+
+    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
 }
 
 /* Set the satp mode to the max supported */
@@ -1498,7 +1500,9 @@ static void riscv_bare_cpu_init(Object *obj)
      * satp_mode manually (see set_satp_mode_default()).
      */
 #ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
+    set_satp_mode_max_supported(RISCV_CPU(obj),
+        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
+        VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 }
 
-- 
2.49.0


