Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BFEE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fY-0005TX-TK; Thu, 19 Feb 2026 12:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fU-0005QF-8F
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:24 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fS-0000TT-Lg
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:24 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b884a84e622so189140366b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521501; x=1772126301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbJf3C90R3jDGQBcdsPQ9rdD2GJU3JqzF3kfy/njWjs=;
 b=kxovPOtsfX6LK0xr4Hk3JBK70KSTuqzYuIFrAyBLazH1IxbVdJSQsdHsoWL5Sew3XV
 7WOvWoGM6pdGvadkdZyujp51ELpnIDyS3o0i704WxvUBYoLYmKZCJKreQ8tSwfbw/1UR
 vEkOElgcovGPnojXC/oJnoPrvlcnoX3OAk3A9dWC4ra7++GZaFyUv4g9XvEg9xTe+mbS
 fniEsxGaA8tm81LU1AGS3YAtck0Tv7JbI5G8YdIU+GhxHt3C7oPqFDBMoz4l4X5rjt+p
 wVdGRB5RaQmaphrj3VndiX/lTlsk0NWTbMou4HJiK+84kvQy2vsfeQQl9X67PDmmtvMJ
 XfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521501; x=1772126301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lbJf3C90R3jDGQBcdsPQ9rdD2GJU3JqzF3kfy/njWjs=;
 b=A6pD0rj4dTakbygQchXJ9crWnse9GJONL6m9eLHHmbbmY4jRo7Q5WUGe43cLoCeafo
 bspeibSAtZV/qOmdYVDoYAAyBUnN8yR4DZFdfG9SpF2Arceg7NwkDfT1i4/vAig0Le/D
 rHoELZjtEVCgdiN+HQWOCqHjpvmFJfkC6HdgHz7iuo+NQGJ3wf2DAFlqVp45icglwCYf
 3F0z18YnPWY32QcIEhU3r4fFpWY2fpNnHHn5ZsjyUc3xlBCj7gYyuMruynO20t/S2Ln1
 6Z2x8bBGZAv20qmWQui4hDUAb0M4w4NHgGtMbfCx1sx+tw3bELMgc6j/QBogbpgOXP2e
 4TAA==
X-Gm-Message-State: AOJu0YwQ6FkCGA6N7k58rjtwpfnuIwjml1FqWgFVmfQtTIX62d4PvoLG
 Iq9KqxzgsfPVdaw2uASD2f2574WJOQkbGLz1RzzTf7hjkidos7uuhjO5ZMs5j09klM4=
X-Gm-Gg: AZuq6aIzeQXaL18WaqA1iBrHpvvVSiszfuOZOfoTfG5MPQF0urZMqKdlzIID/KRiVF3
 zCExOZIwzZRZ+vhN2z6GiAT+BihHeVVZc7w32NgyMY0xf0DF8cqYBD5KallAzcJoKyc3SGncsrt
 cTJlu0RAgA461hIB//pYTnYrrFAGJIXaaEpbyS2hz7+q3K4dy94MIS6MZTEluPUid5ogzhiIOjB
 jsAr8iTV2sIhlo03teNVx4aFssS1uGbVXSkYYyypHaVAJ6HeTnm/1YW8JIcZ2CyKyVlFQ7H5p5V
 QLRHqoYItiOypAw7D4asdqWP9iRzmUpbJyq4uOegP/viHMhATcSO4jugzKH7zS3p2jHyFBCaAIg
 B5Zh0xjqFMw143aazNQAEsDnDTE6siQ9itUSaOGS04JIXI4hJUWYTTJja6p0hbqqlyzrrb4Jjmw
 jmR9tLsSC5wRcGvwYaAwn68po=
X-Received: by 2002:a17:907:6d28:b0:b87:2fcd:1955 with SMTP id
 a640c23a62f3a-b8face541famr1257006666b.50.1771521500922; 
 Thu, 19 Feb 2026 09:18:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d66esm564719366b.4.2026.02.19.09.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A5C615F8D9;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 13/14] target/alpha: move cpu reset into a proper reset
 function
Date: Thu, 19 Feb 2026 17:18:09 +0000
Message-ID: <20260219171810.602667-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Now the alpha clipper machine will execute a proper reset we can use
the reset mechanisms to reset the CPU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/alpha/cpu.h |  2 ++
 target/alpha/cpu.c | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 45944e46b54..0da6a4a2f10 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -269,6 +269,7 @@ struct ArchCPU {
 /**
  * AlphaCPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_phases: The parent class' reset phase handlers.
  *
  * An Alpha CPU model.
  */
@@ -276,6 +277,7 @@ struct AlphaCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1780db7d1e2..e225f11ac0a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -202,12 +202,10 @@ static void ev67_cpu_initfn(Object *obj)
     cpu_env(CPU(obj))->amask |= AMASK_CIX | AMASK_PREFETCH;
 }
 
-static void alpha_cpu_initfn(Object *obj)
+static void alpha_cpu_reset_exit(Object *obj, ResetType type)
 {
     CPUAlphaState *env = cpu_env(CPU(obj));
 
-    /* TODO all this should be done in reset, not init */
-
     env->lock_addr = -1;
 
     /*
@@ -277,10 +275,15 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
     AlphaCPUClass *acc = ALPHA_CPU_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     device_class_set_parent_realize(dc, alpha_cpu_realizefn,
                                     &acc->parent_realize);
 
+    resettable_class_set_parent_phases(rc,
+                                       NULL, NULL, alpha_cpu_reset_exit,
+                                       &acc->parent_phases);
+
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
@@ -311,7 +314,6 @@ static const TypeInfo alpha_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(AlphaCPU),
         .instance_align = __alignof(AlphaCPU),
-        .instance_init = alpha_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(AlphaCPUClass),
         .class_init = alpha_cpu_class_init,
-- 
2.47.3


