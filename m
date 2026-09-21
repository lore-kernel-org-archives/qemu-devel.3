Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7679C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8d-0002Tr-Nm; Mon, 21 Sep 2026 06:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8b-0002RH-5j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:41 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8Z-0002g9-M6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:40 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7fccd4c3f36so2113356a34.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986037; x=1790590837;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZy7A5zxWV4gC9mqKSXKnBsL/zM8a9eBWjdX7xNCKIE=;
 b=RjGeter3rYfGLPw6f2GvnYVUxWsGhdS48Ho4VBKHMZnqF6i33gISiRkcOklOekNtKe
 MTJGB0ElFTZ/+vlfPdzuvgvfvKKR6qsq0v+uOXYL7CPapv7UkRKcBqarTL/APyAAgdLG
 YyBE87UyZl3nLjLPiqjC+29uxKy2Ps3+K5h69973mmA3BajBFxn76blN06oJhok6Vsl0
 X3QtusSq1Y4h0PkZ/+qOpfCrqIlowerG61f9WXRHeMQLH4FbxmpU+x8wAWwqjom/qAr2
 prxV/CfWvBl2PBBSg8DGMN0XaSGKj6vWdASh/zM962xu/mMj6/o3LnloLTb7UEW3BWmq
 /0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986037; x=1790590837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eZy7A5zxWV4gC9mqKSXKnBsL/zM8a9eBWjdX7xNCKIE=;
 b=wiWJK1j7rkfxAaPsrcr7u2z584tQRqn6rvSChti1NX09td2nf6hWU33R7xp+wiZawn
 XOfV44Q36gSD/u4GES0kKuz5Ioy9YoW5sXSpI0PdyApDjXncTVHp55xLuoXAUDiN5BD7
 VTGeVzzhdLPonf+b58fxhhM/6VkAOpc9Va3CiDwfZRZ0zf8FUejZ283iuMHPQnYaDFSp
 Md5b34jOhX41+S0HlPxLvY3MRBSljVNRwU3BVpToP+o4DtAfgRAampzNWdxR1t1dCnS2
 EMf6vEuPB9lldOW2tauo1iysRnGOV9dwGBjZTw1eCfwWpTSUo6vSDdumAro0mktlFIL2
 0Xpg==
X-Gm-Message-State: AFuF++ljwYjOdINriahCwebQlHkC8mYPFq2uTdK0KyYKaLegEXg2MCMx
 5QRWiul1J8nz8kr2DYnAAYcKyD1Ijpy3ObQMMVWer7xmfAfIVqwlnyIYIus3iwmxe6g=
X-Gm-Gg: AYBFou3bETRG/nl6g312+OrOkUEccSzi+jZFP0g7KDuZ5EbzclORSN+bJU0nLOKiLMg
 XlBOw//Cv+mO9c6sqy1tHqarP9kMYH6fn6GBo50wY199CJPEzRnTvbxAf9Ea6P2ne40oba0twSd
 HsTyBl3a3GHNQYtnRsEgoMSS+E2t6gVFyJUmr2aMmeiRwTHm0nDq7K9YQDosXGpeJVk97CBLVdC
 v5bS1sVi6KGnimzk03HWsMUvvQkYW3Zv0DdmdHagRsJuLnmQKmvg9P2WaxdL3x5SFOKRqePiw0q
 Xpt1w1iHY/TplQfL/8noILRwRao65fnZjxJLOlGm2XYqMlkNOjqAFgiklkCUkx5kCUpiBE729Hx
 84szkzPUZFTImc2Jtc0+k4vjt1hgqFGG3QwREgdwOMfwIOoEGQaWFoM87CtCgxBy5RHrPzaz6dH
 3YH5pc06MC0wO9aaShePRs1R6Obhuvl7ft0lFpMM2PuAsoZnka4GScsSao2A==
X-Received: by 2002:a05:6830:4c02:b0:80c:d34f:5f66 with SMTP id
 46e09a7af769-80de36f88e3mr12398971a34.31.1789986037670; 
 Mon, 21 Sep 2026 03:20:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:48 -0600
Subject: [PATCH v2 06/11] bsd-user: Move tb_flush stuff to
 begin_parallel_context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-6-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=jb5+v75jbNJuuiLF3xUx/leyKn5gw3EifXIbRmwvUdc=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTee913J4pUgArtyneKs+sSYKJyCvyZzHeol
 +2qCpoPaaaJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQD/gw//Z+Zymh1AkKGrUv8qyndWjuk+LT8cgIF
 9XIy5A9Ecu/KTkDKk8Qzl8b99IVmhUscYnhvHfOB6jvVBl+w9yTb9g0tQWPV06zg9VpdgyCXbHK
 njp7B8VUL5294SPSu/jXi6be0YaGJs5HMKDkfwZtZbmWOroefkozF/nl0JeXeZyNIoAU8tjuhGF
 HLDUJOJUKJ/4h3pY0sXMsqMUXaFLuGnjxjlAF4tvK+qNXD6mVsK+xmvsVx+I7tggsp5sQlv7wb5
 v0MdJx2JN1ozoj9n23XkTBOZMltRCCoChhPf7+Z9H7DL/gtHbVr70eaSEQapd8xG/QcdVkARa/h
 S3ygGr3QBp9waosHuESBMSmiKzE9cec29lpQxz8NAHqKWKDH6i1K5c7Lsn3BQUkOytxwWIcpS32
 jBeV9dXtRYELcS9C5wcwV4jN3lVscrkAa2A5rLyNCBpRJqS+Pw02L7l4iVMvq2tvjyS6QBXsqzC
 tzoH2X37kB7SzCABb+nx4dRCbUNdePkTTBzqz4b5GmgBk6TehSYktwWzOYCMigvQPJom5dcTq1B
 kGuM9eqJqt3WAkV1vvhtOgQbzuxYYLsOj9OIy6/EKoWwnSm5RoCmXGYZvJzfc+/o1302hgFsCFR
 yadL8fFsuirTeg99ArHr3ku3QGVdRozg5JAw5ZHW5cfzDh5nGtoQ=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Catch up with linux-user 430014bee7a6c26a70e9f3854428843d5918cdf5 and
impelment begin_parallel_context. We'd already moved to using
tb_flush__exclusive_or_serial, but need this in several places, like
linux-user has.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c |  6 +-----
 bsd-user/qemu.h              | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index eaab062d3d..4ffa76a798 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -16,7 +16,6 @@
 #include "target_arch_thread.h"
 #include "qemu/guest-random.h"
 #include "tcg/startup.h"
-#include "exec/tb-flush.h"
 
 #include "os-thread.h"
 
@@ -1622,10 +1621,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
      * generate code for parallel execution and flush old translations.
      * Do this now so that the copy gets CF_PARALLEL too.
      */
-    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-        cpu->tcg_cflags |= CF_PARALLEL;
-        tb_flush__exclusive_or_serial();
-    }
+    begin_parallel_context(cpu);
 
     new_env = cpu_copy(env);
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d2dd8c2ee8..851b0c2c5f 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -41,6 +41,7 @@ extern char **environ;
 #include "target.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
+#include "exec/tb-flush.h"
 #include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
@@ -529,4 +530,21 @@ static inline uint64_t target_arg64(uint32_t word0, uint32_t word1)
 
 #include "user/safe-syscall.h"
 
+/* In user-internal.h in linux-user XXX consider similar cleanup */
+
+/**
+ * begin_parallel_context
+ * @cs: the CPU context
+ *
+ * Called when starting the second vcpu, or joining shared memory.
+ */
+static inline void begin_parallel_context(CPUState *cs)
+{
+    if (!tcg_cflags_has(cs, CF_PARALLEL)) {
+        tb_flush__exclusive_or_serial();
+        tcg_cflags_set(cs, CF_PARALLEL);
+    }
+}
+
+
 #endif /* QEMU_H */

-- 
2.55.0


