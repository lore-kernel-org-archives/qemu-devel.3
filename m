Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449F1CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKZ-0005dk-En; Sat, 13 Sep 2025 04:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKX-0005d8-BA
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKV-0004ZN-04
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757750991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDMh8Tj9XNE2pbl7SQeVp29Pr5x/uZR6F1csyzVp1gE=;
 b=aInHm+MKFbQvHJBMzEvj7uTY/4Pb3el4G6iP4CqzUpmAxKXXeDJSZoBYcDgzJY53qp+Y15
 +QOEq/P5b2dFGTCunmrsNkutskvFEF74NKMtl6+lNDlV1W3qBQn4DwoSK1hmwtV77xKiwe
 0OXGB86adoptdheIumUB1R5vAgjAIAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Bu8sHLKWNHKhbSc-EsrPZA-1; Sat, 13 Sep 2025 04:09:49 -0400
X-MC-Unique: Bu8sHLKWNHKhbSc-EsrPZA-1
X-Mimecast-MFC-AGG-ID: Bu8sHLKWNHKhbSc-EsrPZA_1757750988
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b99c18484so9751265e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757750987; x=1758355787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDMh8Tj9XNE2pbl7SQeVp29Pr5x/uZR6F1csyzVp1gE=;
 b=Vjz49h2ihx7o0mBetCU1tWV1MDorSHd0sTdPZqK10W9o8TPyzBONp9mM6jCR3aDF5k
 CvXjpmZ5x9CujJTxLrOCXI9/QJ9l+372YeZnzsH54YrTumCNazHud/xfYgxX2wFdzAA9
 PZsXxAQVPdCr68VTUcFEfMeekScJreO1Lhnbc+dXPaYjJ/yNTf20JvwWSREEIS/C3LTB
 clHCKT7VYi2XfDC48DRIZH9TeK8pPl/M8PZedPsPHoYzo4x1EQkXIwj9rjtYBYSg45Hg
 Uhv3FBASx83012PKG6bgBy3SarSUYKWg3MxJBAlSaEs4mzqu1z5BiKSSozJaMIe4aLxA
 /WDg==
X-Gm-Message-State: AOJu0YyEn5k00dM5GpSUY0wXXLgOn07AhZ0LZF1MeJJipCk40I+XYVaI
 FMPqWbc1aE3g5t07XBwOMD8LHeAXxrucMZLskCP6ir6SO9N+QY4bdU+gV2kWMxTaj56Jfm8LAke
 CgnxJE9orTjsR2MMUCYH6GkUH61mTj8omf4fLrN7WruhTEtiNdUGWJvOPUYQlK4bSD0VBG/nwlb
 nhEyL2JmHfdBwoM9ejSf2OIe1Kis5cAtT/V4TfRebb
X-Gm-Gg: ASbGncvkdz2ng2RATu+rc1Zp2vsxqoUBQAcUHtmi/afGnyEW8lIf2hgFOk+8nB6EyBc
 aSNtU35VA+g4i1zMStRGDGfUE6/NRQJWnxTaS3xQB8GYADLF7lCy7ojlvyRuny/enIF1EtyQKYJ
 yVG5kdI18ChbcKMbDeouBJ2vFCAjJ+aB7HVnFKbkH5POz3vVkGcspWa6dTtQd6C00mBjWGTpnnt
 vXK1b6p/bG9VHPFJLUTiI1uD0KzapGFtbV+z7xG9KT/ZX9fX3KkJ/5aolE6eJgYcqU82kt+D2Gb
 8Po7mfZeDovblvzquClXYTukOu25WI87di7bh+1I7H0vUr+sKx/xhcUnbExm7636EkaVVjBAyFA
 +xRnV/9uLvde9YY7vzGP5JXP2JEuViaxY76JYXZDE1P0=
X-Received: by 2002:a05:600c:22d4:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45f211cb52amr49034425e9.6.1757750986877; 
 Sat, 13 Sep 2025 01:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS+LsunS4F36q9tGReOz9TIZeDxRUWf1wNYpLz8toQ4yhohQnwKxj4ZOtd2abtECfioruTbA==
X-Received: by 2002:a05:600c:22d4:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45f211cb52amr49034145e9.6.1757750986409; 
 Sat, 13 Sep 2025 01:09:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f29174de1sm4544635e9.2.2025.09.13.01.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:09:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/61] target/ppc: limit cpu_interrupt_exittb to system
 emulation
Date: Sat, 13 Sep 2025 10:08:42 +0200
Message-ID: <20250913080943.11710-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-ppc* binaries.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/helper_regs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 7e5726871e5..5f217397490 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -274,6 +274,7 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
     return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
 }
 
+#ifndef CONFIG_USER_ONLY
 void cpu_interrupt_exittb(CPUState *cs)
 {
     /*
@@ -285,6 +286,7 @@ void cpu_interrupt_exittb(CPUState *cs)
         cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
 }
+#endif
 
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 {
-- 
2.51.0


