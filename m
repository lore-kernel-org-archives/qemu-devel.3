Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC26C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnb-0007zv-1j; Tue, 20 May 2025 07:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnJ-0007RP-UR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnI-00033K-8s
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tMZM2SvIHbt7dyi/YnpmaamQemKlOM0b0XlIhcw77k=;
 b=E+ov/Vg4CIXUJDoHtuYGHqzsGQNUUV+yYACUCEhfkjV4ETwPunFIdvWzxLqZJCeiCWkkq5
 cPJRRfKvZ4na7llF0G7/inBvESpnQ/Hzec1XANM9FgkNyz94HRpJocV/MYPQqYWOUp4G6M
 joa22Uo8HEnvbwxsamdMS9oohyIV7Jc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-bDgVqFjfN6ifovwmAQq9YQ-1; Tue, 20 May 2025 07:05:56 -0400
X-MC-Unique: bDgVqFjfN6ifovwmAQq9YQ-1
X-Mimecast-MFC-AGG-ID: bDgVqFjfN6ifovwmAQq9YQ_1747739155
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad51ceda1d9so447258566b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739153; x=1748343953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tMZM2SvIHbt7dyi/YnpmaamQemKlOM0b0XlIhcw77k=;
 b=MRJiD3yezxKa4meguCXN+75HJcGG2oYxJkVeCkCDSEmflmdvARnvfHzAwYS68AykGq
 Ca1+AR1g+p+08NfWbM2cVDViqxpIeGZh7y/Qzi2QteUVpE2nFr0eIAIqBm/5rR+EIUt3
 PWBKxa9SCDq/R7QFaeS7MWntba8qAFfjhqCCz0ecL+7CifMWzFAm8GDqod0UZ535ovGW
 loqJydEdrtxd4bMrZlGazu5rZ7hKg+S2FKU+goY1b1ll3J3qYSTfiQRFr77dWENqwEQJ
 WTliekM1AnWP0bJERmRuY5n6g9Dh6u4gbfT74hFZez4SPsN+1Lohrs2FlVPvzWkTgHPQ
 sx5w==
X-Gm-Message-State: AOJu0YxYik5B+CGFzepoo6k8Nf7GYRWrFn5e99WAlFA83eZDyHd6UExX
 v4g4lQdRjx8+sLpjsABLpi3a0ZY0En/S9szzqRGpk4Ogh6ittzhSdCp97w9hQZe7ozXkPdYKiF5
 zVphSdV5tv3jOse2+rdcWQLQ02/6R6KNOVmYsDlvzXgiaakbVIECWC/OYfjXq2ABkgD1WN4YDls
 ksjSwfsHXLulEF8+0gdo7EyjEuqV73KHWDgJCaTKOn
X-Gm-Gg: ASbGnctUjQiMGngvQnpI/kXkU6SDbNx7Ff2NxVCb2LkHaTQJlQGZEmS+nW1hpYdHZfs
 LFGh97JJk9Xp4L5aquBg2YPfILT6X3EkLlV8FkWvvk5ulXGpbhAnaxBtmP4A56x+CTlMZg1YO3+
 lFIMjSqc6xg0ut7fZ5IWs58l3Iwm4tvVylMigbYXJLm+0Gf5QhyIeyZAPnkG13zrZrgUEu9NcWa
 j7IRJtgFnXZL2UZUgD5zxkcXWGbtyeYpAMHLp3g47LU1d52cgpY6cWkjrbIZPWXpxdaMc9pzNz/
 dPhBToVZSDyM8Q==
X-Received: by 2002:a17:907:960a:b0:ad3:e742:69ea with SMTP id
 a640c23a62f3a-ad52f86c635mr1283732466b.14.1747739153365; 
 Tue, 20 May 2025 04:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYpriw6KYQE9vflfI0tonrAr+6DNshdLi9pD7CiWJiuM/Lyi5AquqLNVkmP4Ar8Ek5xpRwbg==
X-Received: by 2002:a17:907:960a:b0:ad3:e742:69ea with SMTP id
 a640c23a62f3a-ad52f86c635mr1283729666b.14.1747739152920; 
 Tue, 20 May 2025 04:05:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d276592sm712788766b.73.2025.05.20.04.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/35] target/riscv: assert argument to
 set_satp_mode_max_supported is valid
Date: Tue, 20 May 2025 13:05:05 +0200
Message-ID: <20250520110530.366202-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d92874baa06..0f7ce5305be 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -444,6 +444,8 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
             cpu->cfg.satp_mode.supported |= (1 << i);
         }
     }
+
+    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
 }
 
 /* Set the satp mode to the max supported */
@@ -1497,7 +1499,9 @@ static void riscv_bare_cpu_init(Object *obj)
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


