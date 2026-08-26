Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E17EC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIaP-0006yY-P9; Wed, 26 Aug 2026 14:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIaN-0006rz-JJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:42:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIaK-00029N-Fm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:42:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so18283735ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787769771; x=1788374571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IukQGcRHMsVbGXSG1mzI1R3dLtKOyYm2L7shctiJxkE=;
 b=joIL65oGCWHBM68YknwbarQ86NWE6PJIuU0usv3GZ34DvI+Lh3RO03h0F//fDJMmq+
 wIJeZTcRYV5n/2ofIyOL8f4/3ZkKE9jC+zkaZPajjUbW0BBjsw5xxB6IYCYwpCUGqpEG
 QZMIzmwduYHcHLwZrUvaurVCFhoTJp/1FyMWYNKEXAdrbk0ePIu8dyE9Mk4jPG5OWkmK
 OZW7SAq2d2APxke/IF9OWMKvyqpc1lLBRBJFHN5V6ZTjoDs45WkxIQFtREHBM1ZEb+7d
 t48/YBYKs1uhGmkwukbiy7Q9PivS+KfASN+k6hkOUyJ7BUQzT4Dyj5oT6nqDevhmF5YF
 Dh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769771; x=1788374571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IukQGcRHMsVbGXSG1mzI1R3dLtKOyYm2L7shctiJxkE=;
 b=VQaKZ3g/dpgpj5VnDC4Wr/yOUSpkotZfaSvhdvvCp7feIpKEvKgwpaZ1Gy05lGSOhd
 lQXm/YxTF4VD0+YbREnkMsJ6O+1Bw5EP0fnxR47lgbp/ie4hZAKzONwOM5xN/tw9ptuG
 u6uHwr/SxRmVfycl8Rj8C+apzNyXu/TFXsxbSpI4lVJktHRvvpIvSH2BmUUzcBZ4MP5d
 7uMbCwd0tvbn2nTD3ev9x5IYgU6JDZxua5tB8GOMDKiD4xnSpzo0KBMCPllYwJBzOuef
 GuSyG6tdArH8sSwdVfB0a8W3657a3+paX7C88P3XEbQzqM5kf2ha2D7Cl75wM0vaGFK4
 B9Hg==
X-Gm-Message-State: AFuF++lGBDTjbn4gAclUudQ0hwT/9yOJLu2lP82D0H1YdxBIgh63H2W8
 yzyi1h9iMMO6gjqmz8ARR8GDae6kuNVnAlhEVXuNdQ6R/rfp9pvbQTVvox4X9NIcrDQ=
X-Gm-Gg: AR+sD122GEtzbyjFjC3snFhY02I7LfgFxINmszTYttQe2w6+9pfwrTeIAKCRbiqoZZ+
 SZFLJrRcoGJk+LeV/8vU/IO4G2WcUn/N3SeX3BTTnPHTLis/cuaIDJpMIb2hwsaM60pst4LcEid
 e4sfNxU/FBZr8naaKIlG50orkbCa0iQrEPfNaTx7mPW6fDtERk1kHTA6bQknIk5B6yPjjSoV0hY
 Do2HVqL+OM9Qn9erL41AaETO5C01yaV1s4W/gkiAo72o5z+WrjhqzOq9WKkxfEPZj0TXzTY/YqO
 QAkRTRkvr3zx1wxgeoPQ+FjXG+8R4zytT4OY06OUTH61veHRILdeXWYGSOjQSaE9xVXIZnPC84b
 LqspmjpnjpuXlwRcjFPWM0HPdLxdOOio13iJ/zNQ9Mtchu4QhtuOkm08+JJGN0U5Zi/pNjMOfTc
 JLvwtio1McrplAK4BYg4uxKIxAFHQvHiU+6iUHeBsaXnBQKmih3icuY0j88q51flXjWjZy5gVEr
 RNziLeRKhAzDOSzxrA8ug==
X-Received: by 2002:a05:6a21:a382:b0:3cc:22bb:8911 with SMTP id
 adf61e73a8af0-3cf833389c9mr19772223637.6.1787769770909; 
 Wed, 26 Aug 2026 11:42:50 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm17681846eec.6.2026.08.26.11.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:42:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bibo Mao <maobibo@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 01/13] accel: use a shared TYPE_ACCEL_CPU parent
Date: Thu, 27 Aug 2026 02:42:15 +0800
Message-ID: <20260826184229.1145-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

- TYPE_ACCEL_CPU was "accel-" CPU_RESOLVING_TYPE, so each arch compiled
  a different parent (accel-arm-cpu, accel-riscv-cpu, ...). Common code
  registered only one of those names from target_cpu_type() at
  MODULE_INIT_QOM.
- A combined binary still registers every linked AccelCPU subclass.
  RISC-V tcg-accel-riscv-cpu has parent accel-riscv-cpu even when the
  selected target is ARM, so the old one-parent type_init does not
  cover the other family. Creating the parent in the subclass
  register path would hide that, but it keeps per-arch parents that
  AccelCPUClass does not need.
- AccelCPUClass is arch-independent. The parent only supplies
  class_size and ACCEL_CPU_CLASS(). Make TYPE_ACCEL_CPU the fixed
  abstract type accel-cpu and register it once next to TYPE_ACCEL.
- Leaf names still encode the CPU type so accel_init_cpu_interfaces()
  can look up "<accel>-accel-" CPU_RESOLVING_TYPE (for example
  tcg-accel-arm-cpu). ACCEL_CPU_NAME() keeps that string; it is no
  longer derived from the parent type name.
- Drop register_accel_target_type(). Subclasses keep
  type_register_static() with .parent = TYPE_ACCEL_CPU.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/accel-common.c             | 21 ++++++---------------
 include/accel/accel-cpu-target.h |  3 +--
 include/accel/accel-cpu.h        |  2 ++
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f0..c4c365f38c7 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -126,21 +126,12 @@ static const TypeInfo accel_types[] = {
         .instance_size  = sizeof(AccelState),
         .abstract       = true,
     },
+    {
+        .name           = TYPE_ACCEL_CPU,
+        .parent         = TYPE_OBJECT,
+        .abstract       = true,
+        .class_size     = sizeof(AccelCPUClass),
+    },
 };
 
 DEFINE_TYPES(accel_types)
-
-static void register_accel_target_type(void)
-{
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
-    const TypeInfo accel_cpu_type = {
-        .name = name,
-        .parent = TYPE_OBJECT,
-        .abstract = true,
-        .class_size = sizeof(AccelCPUClass),
-    };
-
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_target_type);
diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 6feb344e29b..cf33ebd79fc 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -24,8 +24,7 @@
 #include "accel/accel-cpu.h"
 #include "cpu.h"
 
-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
+#define ACCEL_CPU_NAME(name) (name "-accel-" CPU_RESOLVING_TYPE)
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
 
 #endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..5cfc2b24223 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -12,6 +12,8 @@
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 
+#define TYPE_ACCEL_CPU "accel-cpu"
+
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-- 
2.52.0.windows.1


