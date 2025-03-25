Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1BBC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6Ov-0003nt-9V; Tue, 25 Mar 2025 11:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Os-0003nH-Co
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Op-00045x-Ng
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so4594734f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917265; x=1743522065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQ002iHqIIcWPiB1XY1rX4088N6FNysAgcdy0xlTwbQ=;
 b=CMjMS5r8r1TqVpRTdum4cQLvc4HWychQ/OiMBdSo1y2+nCoDkmyamMlaFdZDur9yb0
 cgx1MBsc/Zb/vEgkuv4SQJzLKsce2iDPsaNW4TFs2EEkXfSi+wyIyxnW71Jt0clSydmG
 pAxug+ltjBMZzOKwI6sc8TpjIzl2ZgTRwasPfeNh4/89bN3abXHSbBW/+18kO8yfD9PK
 xDJrDZwTQvaSK3M1zHGoWXiW/gpQkDhAGfU1KnUlDvAh71un2+PFCedk5lKlwGdhBreB
 rWBuGbF5nFWGgZLDg88Rwtpee23OdsytZ8Wcft07l4rTko40HsQRbwZzvBKC5XZ5nWro
 enFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917265; x=1743522065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQ002iHqIIcWPiB1XY1rX4088N6FNysAgcdy0xlTwbQ=;
 b=Exd/vSjbkxCWLrMiuCg5RJNAfC22fZquYZ+7+o8xC+7BvQZ0Ct9lotoZQwDhOW/VzH
 i5/XgZNZJu9chCP7idNsfKtHWbGvmiPxROpdiCgtptqwMYM6fZaHxk/0ze2mETw7K8dp
 H12BPZPsZzxbmOJid/QzzOsKt4v5ALjx9P1Y2tF22cOaRkoy+/1zdGBchbEAXDAQlRD4
 b/y3A0sLFYY2kDPkqvbW45KEsjFWV+r2c5yI2p9755YWB9ZhIMfiHlN+WY0f1mx4+oFK
 z7SMUJq+hdhn7etD1H0FAc0A+yjiweyozBYSVhY9t0BBpoet2ppZDXBiIkSmtDkFUNow
 t+WA==
X-Gm-Message-State: AOJu0Ywml1Pv6ydf3oGnZb6WuTdsY3b6mc1O2B76myNibaDQn0YdmApM
 MlslKoSFRwb5f2+j4vmwHi9SPIbi3WM7qaZc72xUl8ITkrVvDdIZ/CtYtc49AQsSiHWPod7/c89
 I
X-Gm-Gg: ASbGncsBH4vHo3vIxl7JLlQt8VmEN/epsk0W3h+tJuL46p/lx/ETOoP6Opi8kWoVT19
 +jG76oNS7/n0w8kI6HlYQL2gtH2g4x3PFYDMuZUd+8hxg+kX7g2xfCHESaRHALc9qV1Gd3Tkuze
 I+g4gvOBNEaY3y3wuX8QLBOZhymzYdF1HFjy/2k5NW7ImPsAzdaP8x4+ZGatciSVfmUppnoeOJw
 /cF48xWONb1FYPf4xLl1DmtNVkM2R6A09n/WkIlVFy5X2VzCzNEOjtVKaafKoI/nf83iQpBkjgk
 XNRHTXsQKCXzzI/pNd8XV3aDO1UX1UTDQW9/JnKMDuOr2RDfNAThhQ1yY5OGbEAvexWCEveUba2
 d04SRzZaNMotHaYyrsr0=
X-Google-Smtp-Source: AGHT+IGECrLTcWKDu7mHWtA1lA/qZo8cfniO7etIuxla2lCEwg8UOGl7Ig8dnQNHROioc1iJozH6cQ==
X-Received: by 2002:a5d:588b:0:b0:391:4282:f60e with SMTP id
 ffacd0b85a97d-3997f91d8e1mr15663179f8f.32.1742917265328; 
 Tue, 25 Mar 2025 08:41:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b3c2csm13776977f8f.46.2025.03.25.08.41.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 1/8] cpus: Open code OBJECT_DECLARE_TYPE() in
 OBJECT_DECLARE_CPU_TYPE()
Date: Tue, 25 Mar 2025 16:40:51 +0100
Message-ID: <20250325154058.92735-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the OBJECT_DECLARE_CPU_TYPE() macro uses the abstract ArchCPU
type, when declaring multiple CPUs of the same ArchCPU type we get
an error related to the indirect G_DEFINE_AUTOPTR_CLEANUP_FUNC()
use within OBJECT_DECLARE_TYPE():

  target/mips/cpu-qom.h:31:1: error: redefinition of 'glib_autoptr_clear_ArchCPU'
  OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
  ^
  include/hw/core/cpu.h:82:5: note: expanded from macro 'OBJECT_DECLARE_CPU_TYPE'
      OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
      ^
  include/qom/object.h:237:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
      G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
      ^
  /usr/include/glib-2.0/glib/gmacros.h:1371:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
    _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
    ^
  /usr/include/glib-2.0/glib/gmacros.h:1354:36: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
    static G_GNUC_UNUSED inline void _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr)                     \
                                     ^
  /usr/include/glib-2.0/glib/gmacros.h:1338:49: note: expanded from macro '_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
  #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) glib_autoptr_clear_##TypeName
                                                  ^
  <scratch space>:54:1: note: expanded from here
  glib_autoptr_clear_ArchCPU
  ^
  target/mips/cpu-qom.h:30:1: note: previous definition is here
  OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
  ^

Avoid that problem by expanding the OBJECT_DECLARE_TYPE() macro
within OBJECT_DECLARE_CPU_TYPE().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..01e03f267cc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -82,7 +82,12 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
  */
 #define OBJECT_DECLARE_CPU_TYPE(CpuInstanceType, CpuClassType, CPU_MODULE_OBJ_NAME) \
     typedef struct ArchCPU CpuInstanceType; \
-    OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
+    typedef struct CpuClassType CpuClassType; \
+    \
+    G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuInstanceType, object_unref) \
+    \
+    DECLARE_OBJ_CHECKERS(CpuInstanceType, CpuClassType, \
+                         CPU_MODULE_OBJ_NAME, TYPE_##CPU_MODULE_OBJ_NAME)
 
 typedef struct CPUWatchpoint CPUWatchpoint;
 
-- 
2.47.1


