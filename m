Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC5CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3EK-0006lw-7B; Fri, 29 May 2026 15:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3EF-0006bj-HG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3ED-0004oO-Kr
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4905529b933so58987605e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084244; x=1780689044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTEurkffFP4f5HtctBBlTf0KhJxPmE6GCKl/0QMxQlY=;
 b=HAg+PpUhSMYfNICGU33w73iTKZHZvHn0TEl8k9cMKjJKIjyb8+cFwk+SvfrpdcaTF9
 GBdqU2fCpWj/5g/0eph98ck9u4vmfLzFnrA2OBS8LqKrIyJWlXAuo9fTZ45mv9IQOkLh
 wsF0kcYpWiO/TqQqZKfJa3On4hZshQxKVDHnHhnmMDpXRAgZMPHWlJzQMRC4/ymqeV97
 Oku/ibGyjtEPxvPVPb3vJ3uPtw684f+8MnTgJa4rONaOMs1VyIph4GmWMcsja1FOaPmB
 e5OW7Lyr1Wx9Mi6hFjPl4HtfhYFMYOiDJM7U+ZjPu/40q2bbZ5hjsW7efV1C4dqF/Zg0
 cVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084244; x=1780689044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HTEurkffFP4f5HtctBBlTf0KhJxPmE6GCKl/0QMxQlY=;
 b=Px2tWwRV3NZmrQlAMi8/Pz0AzE5Dm+R2no8ToV0FuC/tHdA8Qvp+PcjG+4mKPEWg5I
 6uUzgANHWWhuQJ9fIP4p3hysdFwH39jW2ldodbyhCVV9qzgLFAa7uF4Qw9OH45j2i5Wz
 OPVF3lquhUfFZELoGyVruHZc8gegVmpB+C9Pj93TkuczJDbHHHEllMI6FWg829/P0shX
 gmD3JlUobMEMpbPOdSGivMAzCNF9lZRNBB1wJSLiUFpXFCEPW/a+hzC3KaPi5U9BcY6J
 JhUsllfPIYJF1tki9vZk+fW4d5u//Smfnnflre9gW/e2xJqd4z4B3I9mbgVEgmR+ZSQt
 SatQ==
X-Gm-Message-State: AOJu0YyjmNGK0hiCeNl/VApGUV0ndKQbHG+VQWy11lqBrB1En0pP/jL4
 f8qdNTLLRNUrX7hK6ynpDt3BZ2naVvfWR4YAkIUiU2tipiQoS1P9tePdYnpSBhUo77HT8Ipycd1
 RTJOx4viyLw==
X-Gm-Gg: Acq92OEPMaCi+BPpOKrWhyWqt7BwdLRGsoyTdHekVpurbNRhNyII+mmfArOitAj1kcM
 lpfdjehAsGTqF/jwVaN0Rb5TLm/r6EYVlL5XKPWptGXqtQkr+DG+eQswRJm9vE38MOzGMnflBNE
 mlSBNwZx2IF/dd0aGMi4shL9M2IrAh+wZVmMIRZolgmFi0jDnitD8pfq6aGA7G751GINBMBRsr1
 y2PoAs51c13FYHSOdJUmocnFZ0qZdOt7baK4hDYkcswvx6Cr77xwVjjwpsmOk4ddEt2Lky7hoRH
 PcsAtbtQxLXgrohbH9nK+++LwkLjuJn+s4d8FsIkZ0mgKDA/0KEpdFsWlJhHizm4vwXAZUUckf3
 HuTeq7FGXzeIaG+O1wvc5UeYBD1fJW77VtTnxs0J+pE7Y5T6CXwhZYg0LREhVP5hAgcPQxyHUDy
 2yaPTgWAyj0GsBXZUHzMIuplrMkl3iI4s534qFNKgrCCjemv5eYltgC+tMsHqfGvDF1g==
X-Received: by 2002:a05:600c:818c:b0:490:81cb:d7a with SMTP id
 5b1f17b1804b1-490a297085emr16599145e9.29.1780084244117; 
 Fri, 29 May 2026 12:50:44 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6f35f8sm52943695e9.13.2026.05.29.12.50.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/17] accel/whpx: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:29 +0200
Message-ID: <20260529194940.97143-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("whpx") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/whpx/whpx-accel-ops.c |  2 ++
 accel/whpx/whpx-common.c    | 17 -----------------
 target/arm/whpx/whpx-all.c  |  1 -
 target/i386/whpx/whpx-all.c |  1 -
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index b8f41544cbe..099e8ef6da3 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -98,6 +98,8 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->handle_interrupt = generic_handle_interrupt;
     ops->supports_guest_debug = whpx_supports_guest_debug;
 
+    ops->cpu_instance_init = whpx_cpu_instance_init;
+
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..25c5d84fd30 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -24,7 +24,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
@@ -505,21 +504,6 @@ static void whpx_set_hyperv(Object *obj, Visitor *v,
     }
 }
 
-static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = whpx_cpu_instance_init;
-}
-
-static const TypeInfo whpx_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("whpx"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = whpx_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -569,7 +553,6 @@ static const TypeInfo whpx_accel_type = {
 static void whpx_type_init(void)
 {
     type_register_static(&whpx_accel_type);
-    type_register_static(&whpx_cpu_accel_type);
 }
 
 bool init_whp_dispatch(void)
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..16040f102a3 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -23,7 +23,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "syndrome.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..1b68f13a7dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -33,7 +33,6 @@
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
 #include "host-cpu.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
-- 
2.53.0


