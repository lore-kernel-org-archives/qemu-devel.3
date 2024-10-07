Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7737BCFB442
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmGV-0006yC-QR; Mon, 07 Oct 2024 07:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmGP-0006nQ-Lz
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmGN-00059H-WF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uaBKaJEIWpYLfu+qqQkoHdGsmy7MgEbTsLbivZRrgo=;
 b=buq2WoCnVFzRUYhg2kcEigmuKpXw89IT/wzXNlU+gKR+RhzSyX5kRSQPt4BThMX/GlrtSS
 YyEyyRcWEG039ZLniO63ZDgwK/MkklbFQhMy/w0dx26sfW1nFO3XzGRonCruHHnRpnBG6w
 NtroDSKucowoXEiACUfdgSO3lTPjBjo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-xi3RG6cXPWaIjkAl0zOrVg-1; Mon,
 07 Oct 2024 07:50:54 -0400
X-MC-Unique: xi3RG6cXPWaIjkAl0zOrVg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 754151944A8A; Mon,  7 Oct 2024 11:50:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A0F719560AE; Mon,  7 Oct 2024 11:50:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PULL 07/12] target/m68k: Use explicit big-endian LD/ST API
Date: Mon,  7 Oct 2024 13:50:22 +0200
Message-ID: <20241007115027.243425-8-thuth@redhat.com>
In-Reply-To: <20241007115027.243425-1-thuth@redhat.com>
References: <20241007115027.243425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The M68K architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/m68k/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241004163042.85922-19-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/m68k/gdbstub.c |  2 +-
 target/m68k/helper.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 15547e2313..136159f98f 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -52,7 +52,7 @@ int m68k_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 8) {
         /* D0-D7 */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 4c85badd5d..9d3db8419d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -57,15 +57,15 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 8) {
         float_status s;
-        env->fregs[n].d = float64_to_floatx80(ldq_p(mem_buf), &s);
+        env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        env->fpsr = ldl_p(mem_buf);
+        env->fpsr = ldl_be_p(mem_buf);
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
@@ -107,10 +107,10 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     }
     switch (n) {
     case 8: /* fpcontrol */
-        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpsr(env, ldl_be_p(mem_buf));
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
-- 
2.46.1


