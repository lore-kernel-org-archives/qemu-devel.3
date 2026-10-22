Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5UgJiO7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUQ-0003c6-Es; Thu, 22 Oct 2026 06:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUK-0003Sa-Ev
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUH-0001Zj-Ar
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljLnaj4gz/0GsxPKW/RwMJjfsaYbsaV5u9F0MR4LXiA=;
 b=V5UgJiO7H05HmwCIpKqyb9PI/O7v/YkZBvTAwaUhNiz5R+SG1cTzMqVhweJv0mGrp5/dx5
 c+VhiSH0nkoXAgehJozjO/KSIZgXs84YqbUGV5SKwIzd34tntBIyXX3IWlYU4T0fjCizDU
 CUwwZHkeV/l46p/Vx3MztBZambxJ1T8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-CmagHI0WOwS3uMd-NJJlnQ-1; Thu,
 22 Oct 2026 10:57:29 +0000
X-MC-Unique: CmagHI0WOwS3uMd-NJJlnQ-1
X-Mimecast-MFC-AGG-ID: CmagHI0WOwS3uMd-NJJlnQ_1792666646
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B92F1955DDC; Thu, 22 Oct 2026 10:57:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B07E410; Thu, 22 Oct 2026 10:57:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:38 +0400
Subject: [PATCH v3 11/18] target/i386: drop HMP $pc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-11-7ad902b9a7cf@redhat.com>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=z12MoyOC8YM4RzdCd7yCmASaIUw/1qONJgLwpD0QjCw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmOtPzcNdkHq/CtNq2/a4KclQMvkRHF95hC
 hWfKYbOHEiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5UhWD/90PJ9Dpcde6Rm2IxdZPhDad33+01y1aeMNelC5TH4tY7CTHF8Odf8FmCp+PFjUoRVVh2x
 t+5DDGB2LE896a7KXGoKi/AcFLZnFT0HDLXLPCmhZVS9S2sWp7/umkznXnXU/TE2YYWmS9vVwI7
 4AGeYBmfgrMbC7BCWJVW/FYb+IecMjNrPaFvFD3uyiTDfQ+JsfYc0Pvl6A8qCMYlUoYY42RC4SB
 8MIb/HplFdhtffSOIr98uMmuCByO2Vrp3BXf9Ob9l7WbX/ZofHBOEai6mnImqkHuW34fpO1IDbW
 jLir52U79aKcht37FdnYumt2tOVV5ym5o7gxh2x2lXnFNyfq1pOJDQvOk3NxGVQWCgwpSDXXloj
 CtRrQUbFkh1Au8yruikzp7ySKn2wi/9/4Ir//H2U4mLMR6hyOcXx1hKf5PE+Ktdr5Qai+gUL7RE
 iBkJWlUBA2Xph5PL1/bRaxK3GTg0texcPhU9Ue3tsayeeUOgdKG02GkFwXWKOGFlH14+wt+/xvE
 Yk6CrSnanpF6IxkDKgAi4/qsyOZMoLOLjI24/cpfET6Q4eULmLbQCBwnJAEgcMovG9JHbAW7n3s
 V2O6ULmd3Y5zWmraanAiK+M+1ijtRap2UNZgOKI+UIfsFWXFHqlLciJjAGc0+CK5syK4sC2rrzE
 UnC2CL2B2/kHbrA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The to be deprecated MonitorDef provided a synthetic $pc alias on
x86 (which begin as an $eip alias). Preserving it requires x86-specific
semantics (CPUClass::get_pc() omits the historical truncation).
Use $eip or $rip instead, adding $cs.base as required.

It was never a documented feature, HMP is not a stable API, x86-only,
and the replacement ($rip/$eip + $cs.base) is arguably more correct.
Nobody asked for a deprecation window on ML either.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/about/removed-features.rst |  8 ++++++++
 target/i386/cpu.c               | 23 -----------------------
 tests/qtest/test-hmp.c          |  1 -
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 6a9944a0c794..444169b5b718 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -908,6 +908,14 @@ Use ``multifd-channels`` instead.
 
 Use ``multifd-compression`` instead.
 
+``$pc`` register alias on x86 (removed in 11.2)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``$pc`` alias (the linear instruction pointer) is no longer
+recognized in HMP expressions. Use ``$rip`` or ``$eip`` (depending
+on the target) instead, adding ``$cs.base`` when the linear address
+is needed.
+
 Host Architectures
 ------------------
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5ea4e51715..a28c3033ba6d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -42,7 +42,6 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
-#include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/qmp-cpu.h"
@@ -10907,25 +10906,6 @@ static const Property x86_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
-#ifdef CONFIG_HMP
-static int64_t monitor_get_pc(MonitorHMP *hmp, const struct MonitorDef *md,
-                              int offset)
-{
-    CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
-    int64_t ret = env->eip + env->segs[R_CS].base;
-
-    if (!(env->hflags & HF_CS64_MASK)) {
-        ret = (int32_t)ret;
-    }
-    return ret;
-}
-
-static const MonitorDef x86_monitor_defs[] = {
-    { "pc", 0, monitor_get_pc, },
-    { NULL },
-};
-#endif
-
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -10939,9 +10919,6 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
-#ifdef CONFIG_HMP
-    .monitor_defs = x86_monitor_defs,
-#endif
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index a523dbb446ce..b3f8fd58612d 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -58,7 +58,6 @@ static const char *hmp_cmds[] = {
     "object_del mem1",
     "one-insn-per-tb on",
     "pmemsave 0 4096 \"/dev/null\"",
-    "p $pc + 8",
     "qom-list /",
     "qom-set /machine initrd test",
     "qom-get /machine initrd",

-- 
2.56.0.116.g6de20f6092dc


