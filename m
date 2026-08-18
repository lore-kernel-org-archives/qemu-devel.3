Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A98C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThP-0002yN-9H; Tue, 18 Aug 2026 19:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThN-0002o4-NU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:29 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThL-0005Ic-Vj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:29 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-459281bc13bso333349fac.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097507; x=1787702307;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3SskvS39Q4usUFP0DLZu/MoIFQuAMk/c5gpx9M89oI=;
 b=nnfIlo2su0rh6OaquWdLDFtYWEup4uE3iYs7VzYcy1zTWAt5IJ1PYwmUjS2ApJGXN7
 /YPHemlj0rSMp1XMla3UlAxJsLoVmAsSw7VifByjZrgo6/JEzOG8fyYZiv5z1CjUyOhi
 pelkr369Ku7GPBHU7S2jYqmTrNpFTGAICmVtFhNmljaGpqF0Z+6OGxxnADoKF7EVjWue
 XCWlG/XZhaawSjLStirnVTDH49mkdtjKdJowNQgRhBHoqxz03jxHWfrZnEW0Hv+5FP+n
 GyRxVat888cvwES6G192eaaTYV3ky+Lku4qfggGCODydrXB60uRX0G1mHqo4M/OaIbg0
 6pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097507; x=1787702307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3SskvS39Q4usUFP0DLZu/MoIFQuAMk/c5gpx9M89oI=;
 b=d2XKzsuO8V3tHVfEmFrwNEyou65cSmzzwKZhV9XJVrv4zs/nE2OEjCUin2Q+7hfBg5
 P0EdsvUAl7xxqq1w0mEykizeHD4O/Wc23ivylDFY+IFYuz55A6sZTVn4+rN+hTJidhw8
 JX7w2slHsdZr7HKQA2pJy/8gZXzvXVJM78znogu//kh8prbPe7z+jpsxEmHMx+Oh42ak
 JHjZp6kz2He0u8PdRa96C8Bkr9omLZvdYt1Tv6IetpirXPSYylemby8x4FMMvtCFwwVU
 X+POPfHGJPXmhgy/IsIMkCP5ANBmPil23cXZQ4XLe/FCsbi2wBHb2Ex8K0HvYPFmfLoJ
 vbXA==
X-Gm-Message-State: AOJu0YxnfCBw372QcBGmgzbDqHvuNrQKIV3AathQDKHh/ApoAArzqzLX
 noBkDjz6PWbjsNd1AO6MpCzn6WoC6nuU25J8UbL5m6X2iG8mbiDjO3qRzFoBY7y1vYU=
X-Gm-Gg: AR+sD116HkvNqhoyfID7fQ7jBfmH9fXubK7qcs72uJHnBvVgjJjaCh0l4y443GW5pci
 Fl86zhUe0sH0C2E3G7pcIQLF7hk2KpKyFT4nFFRFUwrcfsluDHElmODroE7mlXFSWDJvXlpaqhx
 mOI2e/KABgOjF6cKYEAGULxHLZfFli445FL5C8IuJ1EfmdLdm2rDdzO5zhDezbYk0lyzmZExc5P
 X0KxwXSLTaanFmnlhWdfhmJwSu4hkO6eZyY+/7idbcJnJWjg4FfNr3YHPYUjZiItQnLbcP2QWrH
 lC8pHIWW8JXVKeg7+QK/DBz3jEtpDDTfH0wE+EoR4KR2tjzTLJ4qtnrvOp/7PZODT8c0mVEWl2g
 gz2xd/XF3yBiQnn7qVuc4a2oeGDWHeJsHACpL0m3gRoC2aMtBmBBWTCuS7l4/7nJIIPYXmKwjbh
 kpDIv/0QJEIRtV63j0s9mcUxUwmF18xTqOiVp8g6HPtun4VF1v
X-Received: by 2002:a05:6808:198d:b0:4b2:8e2a:295 with SMTP id
 5614622812f47-4b2bc46de25mr463983b6e.0.1787097506753; 
 Tue, 18 Aug 2026 16:58:26 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:21 -0600
Subject: [PATCH v4 28/40] bsd-user: Add cpu_copy and make init_task_state
 non-static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-28-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=C3PdATJBpYfnoQRiXA8L9JVToAfUaoFluIF7aJeCNe8=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFLjLIsvwSWcWoe+DCNgZ2WEFyOkgkt6B1Sv
 UHApY8+ykqJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxSxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBAlBAAvr/+j+cwkZBsH/Df4voiZTybgSst4HS
 m6H0zDcz3sMKzCFcSL585OqyB89ukE69hRiLP6NNzgnxu71jmuc6GziWWpc3So+0JMd53Lfa3X0
 24/OZahTNu6UBeUSAp7Tx1Ow0UPPJsxfafYZANTbXc/rz/hRiU1PF+xqyOKXUDYIB57UocVmw7g
 SXjLFi/7+bYBvPGR6OOZoWE6EcjpT58123s51YZDk7YmKDKEHBD/oWHHS1wB2GSXBSIkL1AK7Ug
 GEVd0Z/KWTKeN0CSF9CR9GB8soMnHLHbzL4HPFSlZspNruRhtRzRCMuzk+RJEohlWxWf1jJLtKF
 f1YsAnZ9NVCrEymI8fJ6nwuiRqC/i0D9zgzJVsQ60zFSwneXCS+mjT4sUq5UhN/blhqWys84e4n
 lwdUSfCDiUJwpviLrpzG4PDhjboEnE6sFc68spBTvWwYFwwAv7ey1a/t+tM9tdra3SuERTkSD8h
 zAA9bXHxf0Aq26l4oQyKMR/budoAUQwFcL3jnf/A3wfC3ej6kT1n+5yzRh40tlOw3gYYj0Wxjnj
 qmFjNmEAe4cSiGTFR9oAVhiqgudZagX5zLSMq11VQGU/noSpcsKWQQZj6nB7E7+JYIXiE6TMvAc
 cn5ice+svdgUwONXUo7k5m/nItwYmjCDOeP8W30EeT7Tu7ulEm3U=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add cpu_copy() function for thread creation support and make
init_task_state() non-static so it can be called from os-thread.c.
Move cpu_type to file scope so cpu_copy() can access it.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 32 ++++++++++++++++++++++++++++++--
 bsd-user/qemu.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 694481ae3e..2fbbfc3d86 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -50,6 +50,7 @@
 #include "qemu/guest-random.h"
 #include "gdbstub/user.h"
 #include "exec/page-vary.h"
+#include "exec/watchpoint.h"
 
 #include "host-os.h"
 #include "target_arch_cpu.h"
@@ -215,7 +216,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
 }
 
 /* Assumes contents are already zeroed.  */
-static void init_task_state(TaskState *ts)
+void init_task_state(TaskState *ts)
 {
     ts->sigaltstack_used = (struct target_sigaltstack) {
         .ss_sp = 0,
@@ -224,6 +225,34 @@ static void init_task_state(TaskState *ts)
     };
 }
 
+static const char *cpu_type;
+
+CPUArchState *cpu_copy(CPUArchState *env)
+{
+    CPUState *cpu = env_cpu(env);
+    CPUState *new_cpu = cpu_create(cpu_type);
+    CPUArchState *new_env = cpu_env(new_cpu);
+    CPUBreakpoint *bp;
+
+    /* Reset non arch specific state */
+    cpu_reset(new_cpu);
+
+    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    memcpy(new_env, env, sizeof(CPUArchState));
+
+    /*
+     * Clone all break/watchpoints.
+     * Note: Once we support ptrace with hw-debug register access, make sure
+     * BP_CPU break/watchpoints are handled correctly on clone.
+     */
+    QTAILQ_INIT(&new_cpu->breakpoints);
+    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+        cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
+    }
+
+    return new_env;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 void gemu_log(const char *fmt, ...)
@@ -256,7 +285,6 @@ int main(int argc, char **argv)
 {
     const char *filename;
     const char *cpu_model;
-    const char *cpu_type;
     const char *log_file = NULL;
     const char *log_mask = NULL;
     const char *seed_optarg = NULL;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 069baa7011..d2dd8c2ee8 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -122,6 +122,7 @@ struct TaskState {
     struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16)));
 
+void init_task_state(TaskState *ts);
 void stop_all_tasks(void);
 extern const char *interp_prefix;
 extern const char *qemu_uname_release;

-- 
2.55.0


