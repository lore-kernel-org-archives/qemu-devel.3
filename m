Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AC9C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kWG-000488-33; Thu, 10 Sep 2026 15:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQs-0002MC-2v
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:40 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQV-0004d3-PG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068352; x=1789673152; i=deller@gmx.de;
 bh=K/zEFSxTT6/UgrMjGsDD6x6RufJlD9LGlrVxVYgOtUI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gc7JxO6OWOE9sAnYzbtatbUhdCdvIkCSd1MpdXUBCeqH+mUUjsAF0F+pwQrXH8Jc
 0Frk9dzrIm9UGx0/KKpXqUnWtg21AH+k1ywARdlVL5ImAyLq3xrECcSqmDA3oY0XB
 C5/hO/YuV/Bt+aZnsIgrtsBCV5hkVSZVLGdpGctXkT+E57/cmhc93kf7NG3Z4T9Lg
 QpQRjuhQqTw6/6eTavv7jdOy/IpKtq3hAZdHnv/A/e9TKI7WgSAqrfPagdhneNGNp
 rhNVF6reH3jBuIS2B7qfcot5n87zPbrao9yQt2m5tERSl8ur5LLKNomossLAalOhF
 vEnJ9Y/aY/UpxfqrSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJlW-1wO1Bj2DlU-00lYoC; Thu, 10
 Sep 2026 21:25:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 5/7] target/i386: split the FNINIT out of do_fsave()
Date: Thu, 10 Sep 2026 21:25:42 +0200
Message-ID: <20260910192545.768850-6-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iGxU4wesxqRU0tPfN4e8gRULYRQ/mawXO+zIkZcm+8YwRGij/dz
 6Ec/Wp9E2EDF+JZxTm2ObYC7PuXDJZv0VqT0dEHaV4cz1UdqIBS7mMm78vFrNtcLzy1G7WF
 YB+iFmqnDvmUwppAKUPKYV2YiwUEfIzENCoguTJXSvjTIfrw00T7p1LiGkWwvNKMdioTb6K
 dwsxR/C+rWa5XFEt//2RA==
UI-OutboundReport: notjunk:1;M01:P0:zpnQ3YWbUn8=;uj+Dg+fBDsSG5sFmG/OYw4GyYvj
 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
 E059AWkTp/uet
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

do_fsave() ends with an FNINIT, which is what the FSAVE instruction and
the signal frame setup both want, but it makes the helper unusable for a
caller that only wants to read the state out: recording the registers
would destroy them.

Move the FNINIT into helper_fsave() and cpu_x86_fsave(), and expose the
store alone as cpu_x86_fsave_noinit(). No functional change; the next
patch uses the new entry point to write the x87 registers to a guest
core dump.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/i386/cpu.h            |  2 ++
 target/i386/tcg/fpu_helper.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e61ccc9e68..786957fadd 100644
=2D-- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2727,6 +2727,8 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsign=
ed int selector,
  */
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
 void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
+/* As cpu_x86_fsave(), but leaving the FPU state undisturbed. */
+void cpu_x86_fsave_noinit(CPUX86State *s, void *host, size_t len);
 void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxsave(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxrstor(CPUX86State *s, void *host, size_t len);
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..f7cf4220ff 100644
=2D-- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2536,6 +2536,10 @@ void helper_fldenv(CPUX86State *env, target_ulong p=
tr, int data32)
     do_fldenv(&ac, ptr, data32);
 }
=20
+/*
+ * Store the environment and the register stack, as FSAVE does, but
+ * without the FNINIT that FSAVE performs afterward.
+ */
 static void do_fsave(X86Access *ac, target_ulong ptr, int data32)
 {
     CPUX86State *env =3D ac->env;
@@ -2548,8 +2552,6 @@ static void do_fsave(X86Access *ac, target_ulong ptr=
, int data32)
         do_fstt(ac, ptr, tmp);
         ptr +=3D 10;
     }
-
-    do_fninit(env);
 }
=20
 void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
@@ -2559,6 +2561,7 @@ void helper_fsave(CPUX86State *env, target_ulong ptr=
, int data32)
=20
     access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, GETPC());
     do_fsave(&ac, ptr, data32);
+    do_fninit(env);
 }
=20
 static void do_frstor(X86Access *ac, target_ulong ptr, int data32)
@@ -3085,6 +3088,12 @@ void helper_xrstor(CPUX86State *env, target_ulong p=
tr, uint64_t rfbm)
=20
 #if defined(CONFIG_USER_ONLY)
 void cpu_x86_fsave(CPUX86State *env, void *host, size_t len)
+{
+    cpu_x86_fsave_noinit(env, host, len);
+    do_fninit(env);
+}
+
+void cpu_x86_fsave_noinit(CPUX86State *env, void *host, size_t len)
 {
     X86Access ac =3D {
         .haddr1 =3D host,
=2D-=20
2.55.0


