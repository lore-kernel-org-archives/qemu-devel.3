Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4749CE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQv1-0003nR-VZ; Sat, 27 Dec 2025 04:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuy-0003g2-NH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQux-0006y5-5M
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6Mev8YzRHp6WV8Umh9a3vKCUUeFnkL4NvERv9PBdwQ=;
 b=fMW7P0FaoY4NRWTqo+n0vxINLLZQuiGsJ2sURU95wS3aiPUh6FdUeMz/NmsoXE/hzucElW
 xeH19HW8j3Wo3q1bvreXWzVdVoTTtzv7TeD1rykaHpY+7N9ipM/hv/+1YjJuRi+InI8B8X
 KeIEzTpWiEnDfwVf9N/e+IDPVNRgBVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Ht4vUt1UN3ilzabit3M7iA-1; Sat, 27 Dec 2025 04:48:54 -0500
X-MC-Unique: Ht4vUt1UN3ilzabit3M7iA-1
X-Mimecast-MFC-AGG-ID: Ht4vUt1UN3ilzabit3M7iA_1766828934
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso19454515e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828933; x=1767433733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6Mev8YzRHp6WV8Umh9a3vKCUUeFnkL4NvERv9PBdwQ=;
 b=Pw5mCEq2B0zSujjRJwRfFX8+xlhmCyMFGU3ocrwt2vmXgxKslZstkAXw8h+MR3Zz8z
 Z6NZlST4hig1rHPgeNFlPcmbN1JALZ2WK3B3yjiaY7XvvoAKymdH5SUH97YHflytGwdv
 tVAwEnsD7d7bt3s+XZXlLb5h1LBObDGAICcs2pgCoNVdd420cTRoGGTGJ4ZlFdRyiHR0
 R/6nRZM65ghHW1pu+v8Yg8MEW3gD6hADM1x8xEovC9SJoJmunuoLUXqyXH2cKMF4iVfW
 amWkBHQGLXSrcN62xVCuuQtHoDBmpbEVyr7awF7wDGthJg+IrxHT36DUMMzMTh6KSc00
 iYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828933; x=1767433733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i6Mev8YzRHp6WV8Umh9a3vKCUUeFnkL4NvERv9PBdwQ=;
 b=bE+VMQOG/iOLkO4ngokZuFJnn27Fo0gKHkm9EHicBkENv/6iof11wA64nYX5/SZL0b
 uWWzS2fJRktrQBn51g9ewaTBSFsH8te5z+7U1Z0wIoSNdNbfT3knxEacO/iyfYKgxIIn
 VmnhURiYsFDjgr4ozQNwPpMsSHw+QwLy1WFlSycRe1E7ZhwpvcIxV44piBjSw/c2yEIi
 UtIATdbiHYtZD0kmUPi8OuU8oO6Gd0QB7KQofuBpSauSLEEpT36LKyYl9+IU/yx9q5Pi
 4fjk/UP1DxNsngHjl1ic6+z4w0z7FXM+ma0uDN17bH39C02wC1+H/+j4NM+nfcCkYPm+
 lRrQ==
X-Gm-Message-State: AOJu0YylJRRY/v0zs7SeeZvGYDy7QbvUW3MP0XUVV7NCkivghbhqtubK
 0Qg30AYz+YF7cpW4i3PybReANPfIQadtsjgcSoM4rO37xBsOaqgiztc9zxfOktPN5ce+YVTosmu
 ToMjbHBwi9vsQMAaHBMDuvtLSrlvAK9U1wsgYXrvYaJgMGE5Ud6UVMGjbpI2qcgrV6vlrIUUATS
 M4S6zGMn/E4jMUBm6QmYpMJqh2i68gozXSz11YI2fj
X-Gm-Gg: AY/fxX7o4w8mrUkahzzsPv3gG9eFvdhIQMmWCE/YaWU3Rq1xAZPOTW75IZG982k24rG
 KL08Eqyjq+NVymiutuRQXPMto8Rq4FKxjNQdzB6xZHerndki2BCac1ei2XqO6gwJCh2AOmNVzfb
 HkobACTM5UHiR6m5c38nGc9NIW8XGhdQIROai6I/qp52k1QcIZPho6xHBgkF61aXjXtcH9aeQ9I
 wClz6EqWSGXV/jHLjsRTk9519aDmrj+pBet1HDA//6bOOzbKC0mCi6R5nDtX089bZ5Rr6KVZ2XY
 HrCLsBJivP7Fw+Se4VR4s2JracyUuoYl9QTJlTDX22V+D4NC+7hmOYzqLHCW7DCi8bd49w2593I
 BbBdsGAWulmXHpJ7BopBe8qFx1YAAVxQ8ue5dvJnVU9JoXyRwPbVXT42ghp/prDNfYbWVKWR20q
 60yA7v1nMR9KTK/88=
X-Received: by 2002:a05:600c:154b:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47d1958fd40mr260786455e9.29.1766828932817; 
 Sat, 27 Dec 2025 01:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFRcfLAS0r1FKE/66bgkCdoDHK3lcsa+a1y+vuEsLeKKx+K20YUrQk1CUJ0p3W6aTTItKkuA==
X-Received: by 2002:a05:600c:154b:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47d1958fd40mr260786225e9.29.1766828932307; 
 Sat, 27 Dec 2025 01:48:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa46c0sm50545558f8f.34.2025.12.27.01.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 097/153] i386/cpu: Cache EGPRs in CPUX86State
Date: Sat, 27 Dec 2025 10:47:02 +0100
Message-ID: <20251227094759.35658-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zide Chen <zide.chen@intel.com>

Expend general registers array "regs" of CPUX86State to cache entended
GPRs.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |  7 +++++--
 target/i386/xsave_helper.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 05e297e6bb5..471d3931056 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1664,12 +1664,15 @@ typedef struct {
     uint64_t mask;
 } MTRRVar;
 
+#define CPU_NB_EREGS64 32
 #define CPU_NB_REGS64 16
 #define CPU_NB_REGS32 8
 
 #ifdef TARGET_X86_64
+#define CPU_NB_EREGS CPU_NB_EREGS64
 #define CPU_NB_REGS CPU_NB_REGS64
 #else
+#define CPU_NB_EREGS CPU_NB_REGS32
 #define CPU_NB_REGS CPU_NB_REGS32
 #endif
 
@@ -1901,7 +1904,7 @@ typedef struct CPUCaches {
 
 typedef struct CPUArchState {
     /* standard registers */
-    target_ulong regs[CPU_NB_REGS];
+    target_ulong regs[CPU_NB_EREGS];
     target_ulong eip;
     target_ulong eflags; /* eflags register. During CPU emulation, CC
                         flags and DF are set to zero because they are
@@ -1958,7 +1961,7 @@ typedef struct CPUArchState {
     float_status mmx_status; /* for 3DNow! float ops */
     float_status sse_status;
     uint32_t mxcsr;
-    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32] QEMU_ALIGNED(16);
+    ZMMReg xmm_regs[CPU_NB_EREGS] QEMU_ALIGNED(16);
     ZMMReg xmm_t0 QEMU_ALIGNED(16);
     MMXReg mmx_t0;
 
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef..bab22587320 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -140,6 +140,14 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 
         memcpy(tiledata, &env->xtiledata, sizeof(env->xtiledata));
     }
+
+    e = &x86_ext_save_areas[XSTATE_APX_BIT];
+    if (e->size && e->offset && buflen) {
+        XSaveAPX *apx = buf + e->offset;
+
+        memcpy(apx, &env->regs[CPU_NB_REGS],
+               sizeof(env->regs[CPU_NB_REGS]) * (CPU_NB_EREGS - CPU_NB_REGS));
+    }
 #endif
 }
 
@@ -275,5 +283,13 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
 
         memcpy(&env->xtiledata, tiledata, sizeof(env->xtiledata));
     }
+
+    e = &x86_ext_save_areas[XSTATE_APX_BIT];
+    if (e->size && e->offset) {
+        const XSaveAPX *apx = buf + e->offset;
+
+        memcpy(&env->regs[CPU_NB_REGS], apx,
+               sizeof(env->regs[CPU_NB_REGS]) * (CPU_NB_EREGS - CPU_NB_REGS));
+    }
 #endif
 }
-- 
2.52.0


