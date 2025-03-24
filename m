Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9307C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn1V-0001TZ-9k; Mon, 24 Mar 2025 14:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn1E-0001HH-0y
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn16-0001SK-JI
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-391342fc148so3311169f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842759; x=1743447559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MoNEz0fSiYs6s5Ieob4OaWyw4h8Wjxiwtk24X27qIo=;
 b=qXfXSdscP27fQ6aRFQNL7k8DZGedGVA4XB32M3YC1rcFD20QMaygRCyAxbkDWucORA
 CkB+RfOiJgLbvvYW4ljKXatCE5fCmXenD3AR2Trxy/wBMiYKGjqDd/qCCd0zNp78eh92
 gRVSmApeZs3YvqWKuDwpwkBS0vxVCsEMXZqeFiY+TlTk7zDar4PaeFn2GxDYU7br2lJP
 BkLFU8RFYnQlbQGcpghmd+jgXZcquroFywbW723nt+FT1C8X9230jeJx8S2Yd042GpqR
 JcX2YX9eFE0ejF82b2h1jWx8TbCM1CZf+h4yzsPIkZLJsSfC1jg0qqThEmntQDOICUOM
 UJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842759; x=1743447559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MoNEz0fSiYs6s5Ieob4OaWyw4h8Wjxiwtk24X27qIo=;
 b=oYhTYgkWCltGImny8Fl+yUrE7i6Yxd4cRhT6OOaBjuMeI47csCf/Q9jkJPC0bzbQNP
 rTaVtETNCt4yysVRBWt9HXu9sBwOYfmld3qRKvrZDoSJVZDzG1nSRcHURUO47k/dSyJH
 j/2ag7FE6R1ySYtG9KLBRPL9fVmCyxGlYuzz8u9Xxp1U8h4rAZo2NyDmaJekCQ+qsd+i
 FVl60URCYXktwzO2uNZsUWZfVcmHTuP/YdgOhXlVr/j8tkf8TGiESLIHpGIr8pKaldcC
 E7nPQ30O63IqGKxbtydW3SaRH16NrOSJUl1ytOQt4QBSJ1mIuqpy+oPvtY4r95qdo4SK
 /K5w==
X-Gm-Message-State: AOJu0YxuHZPAVTXFD537Wsq1rOljH0vZKotwTPUVOPkTe7ThrTpWeaIF
 ZBSMNgqzGLMMT9O0zbbnnK/G1WpeV23hEMVyjI+0CYP/Buq+HwZK/j/0jhvHyGs5wHy/hWsdkAh
 u
X-Gm-Gg: ASbGnctvbzkVm8R5n10Ghuz8XAJsjc6oeUAHUeYF5Cn1CutTCWtFo/RS2WxeXUUIBRn
 ItzjFsz+lkJQK7JYDeTr2Ucj02h5Jl7B73tV/KOoc2XWgI15qWcCltXUyDv3datE9vCrMxgVUG9
 Sp5ph1OMp1ea5a4eztcTSpzH4vjdPaDZzBdr8gFiglWc7vWcGvH6YlpblY51FxB/0bvDiKaWt15
 Tr14IUsK1X1zxyVcnIcLHtdMjGpOb6GX3jx2Lw4vwkIwucKzpat2Z8RxRkDHZ047hPNkv0A57rc
 FHTKWrIDCsSuc4Vg6tCjKop/AzCNyZG+c1sm1IBCDbVMm+V/bZlpG5wwIN4l3vvMbdDNpYqt7l6
 /w+xQ3yY5ljs4f4EcIkfifwC1
X-Google-Smtp-Source: AGHT+IHv+x2qZttrj4beJkSnLS6/+bSobh5sFlJfiDyzJUTfm6UJ4ZNqHJ5Yjxwy7C/fY5s7bSptRw==
X-Received: by 2002:a05:6000:1fa5:b0:391:3b1b:f3b7 with SMTP id
 ffacd0b85a97d-3997f90ddb7mr14616046f8f.28.1742842758740; 
 Mon, 24 Mar 2025 11:59:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efe61sm11889476f8f.97.2025.03.24.11.59.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:59:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 7/7] cpus: Remove #ifdef check on cpu_list definition
Date: Mon, 24 Mar 2025 19:58:37 +0100
Message-ID: <20250324185837.46506-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since we removed all definitions of cpu_list, the #ifdef
check is always true. Remove it, inlining cpu_list().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-target.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5947ca31a0a..30598619581 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -71,7 +71,6 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-#ifndef cpu_list
 static void cpu_list_entry(gpointer data, gpointer user_data)
 {
     CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
@@ -85,17 +84,6 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
     }
 }
 
-static void cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-#endif
-
 void list_cpus(void)
 {
     CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
@@ -103,7 +91,12 @@ void list_cpus(void)
     if (cc->list_cpus) {
         cc->list_cpus();
     } else {
-        cpu_list();
+        GSList *list;
+
+        list = object_class_get_list_sorted(TYPE_CPU, false);
+        qemu_printf("Available CPUs:\n");
+        g_slist_foreach(list, cpu_list_entry, NULL);
+        g_slist_free(list);
     }
 }
 
-- 
2.47.1


