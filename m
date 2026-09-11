Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915A6C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50MQ-0007Za-Bp; Fri, 11 Sep 2026 08:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MO-0007YB-1R
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MM-00073X-2K
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CZHbQQpgwP/HwF1mEYmyVjFVQko/FHk7cdnH9VJKcI=;
 b=cxLHJvO+ddEd0DmsI3XSFTzaAScBMTsXdh9VEKYuR+rHv02tZli9mIhSnsEUS5iCOT2lxJ
 NhcYqCcbk0SkLDHJgeiWb6TzVmLwDbCvo6wR2h/hCwrgddtnnetIVdG8YD8XC0Bv27LiEN
 2x/P/fQ981Wpxw3b6VcyUZ2s9QTFchg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-pS6Rxd8RPe-AcSNA7Nkosw-1; Fri,
 11 Sep 2026 08:27:56 -0400
X-MC-Unique: pS6Rxd8RPe-AcSNA7Nkosw-1
X-Mimecast-MFC-AGG-ID: pS6Rxd8RPe-AcSNA7Nkosw_1789129673
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 346C51955D4A; Fri, 11 Sep 2026 12:27:53 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B9221800576; Fri, 11 Sep 2026 12:27:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:28 +0400
Subject: [PATCH 05/10] monitor/hmp: add CPUClass::get_pc fallback for HMP $pc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-5-0c04f0c02cf3@redhat.com>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RS+4i3/UYY6V3Q/42QSB1RzVR7D3DOiMpDER38yecsI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/Ovt5zb6bfoTDvNPIM/H2X7ZCTXjQu76LKJf
 Asc8M0OtqeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrwAKCRDa6OEJdZac
 5a78D/0Ty2LH/fZUKAvEwyDmKIAM3s5jXh5wLTJBl1NYcN0XpGcsEnnQbyppkcNQzv630q6qNms
 Xsfo4Xl60+NFuzUvBRSuDcXjLBjR/3tbFwb3MO+KlBS6plOHtUkMQzjl+CVm5qv1RvsdojMQ95k
 pYYKjzWyRLGKhasPHJh5KBxj7EMmHUvv85nYtOpsEzZnYTRmyanDiuCtYiIpDpPf43xIYD9jKO9
 uzflwhYVReZ2XdYHVadX66jDYtqsr5PHJ/O6NI52KTEwDObaLN0tN2HSp9b14j2vew+xAycMJzB
 isHUYjtdaqPWraTlenJ1BcueV2bMV+cw26gij9MOcQr2BICwUprTdI1Ai0K0YKlEctlUwd9zeJl
 MAiWzhP5acgJH4bnj5LKFVWb2Bf2sT41LrhpTKQU5/xnFy5GnbV8X4I9AOQ5wDYRpMM8m5INp4e
 EnMnFjFlOauobMoTqyo53XICUqZNsdjloXdvZFYOtb9tJ2VZiQn70//OEEs+LYeqCyXLIvU5rdI
 zGV/SFw2yLPsydXwdrIKaIFu7lsZMMCJsJFNTTfy6/b5h32A+741DI5bxokUlHC0FqZH/e7qzMw
 5kvModbVTgusOG05DMTvHiBfynFBWoKskMiCPp5YU3JgppiCtiE9bGCYLN5gxava+zXK/7QMtg9
 QaGjz/nzkc2stXw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some targets, including x86, have no GDB register named "pc" (x86
uses eip/rip). When the GDB register lookup fails for "$pc" in
HMP expressions, fall back to CPUClass::get_pc so that "p $pc",
"x $pc" etc. work without relying on the legacy MonitorDef table.

This prepares for the eventual removal of MonitorDef while making
$pc available immediately for all targets that implement get_pc.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/hmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 10e19e417aba..0a74247ca66a 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -402,7 +402,7 @@ void hmp_help_cmd(MonitorHMP *mon, const char *name)
  * Set @pval to the value in the register identified by @name.
  * return %true if the register is found, %false otherwise.
  */
-static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
+static bool get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
 {
     g_autoptr(GArray) regs = NULL;
     CPUState *cs = monitor_hmp_get_cpu(hmp);
@@ -435,6 +435,10 @@ static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
         }
         return true;
     }
+    if (!strcmp(name, "pc") && cs->cc->get_pc) {
+        *pval = cs->cc->get_pc(cs);
+        return true;
+    }
     return false;
 }
 
@@ -526,7 +530,7 @@ static int64_t expr_unary(MonitorHMP *mon)
                 pch++;
             }
             *q = 0;
-            if (!gdb_get_register(mon, &reg, buf)
+            if (!get_register(mon, &reg, buf)
                 && get_monitor_def(mon, &reg, buf) < 0) {
                 expr_error(mon, "unknown register");
             }

-- 
2.55.0.543.g5ebe2ebe4ea8


