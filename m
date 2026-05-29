Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09369CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy9U-00044d-E4; Fri, 29 May 2026 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy9S-0003zq-NO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy9Q-0002fM-1a
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so68770035e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064726; x=1780669526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bh2neLmp2yCN+no5zdf9s1S1CTB1NaAAPjqIYQpJDXU=;
 b=jv05KxeGCGgxY/643LjsMcSgKTuJqq9BooyT09yfEKcyXQtJkriDseh4jOuqiEoilb
 KKgyXW/pUQ7lga3/+eBYVTV/uSqvmlYsO+YkxCiHuH0TJwK0njCg1j000Kg9YhUWDnIW
 UFs4s2InFPp6b+blXW2R+uXRJg71JPe133b1EFC0fUqCPUdjI1JO+ga7TndF06X07Ug4
 KKvEdiWu/7ZRpfWyhoVLU1jXhBkSAl5tsU2g/zkaZ9i3/xfhQ7aq4KWCTbiIp2U8iKU4
 gQSwrDTSk2Lik1mkh2qa8IYbciNqUdlyo29oBvqTF4rN6x5chqoVCowIn7TOApZdbKnu
 RrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064726; x=1780669526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bh2neLmp2yCN+no5zdf9s1S1CTB1NaAAPjqIYQpJDXU=;
 b=pDfBT4C9u+43em8YaS0LTQmNPaoQNpvdnzkYv6ID7D/oNbIIQFT4+5Q6VIzqDFLrcR
 rIYNXadItyQ2RLrUiu4/pkFz6qvzy4XcvGryp92QESiGkB59l4o5CifA/rcKrcH89luv
 Hkwgdy1QpDWblgmXaaU0Dpj6cX56kJgYSKxhR1q8NGrI6CKN1tH2LH7abTZvMClK9lXm
 tevnyV1vg+YkPc8fUMzVM3kdN0aqJ4RksQZRYMKYpgp8G+K+X75jLUTaKO1vdx74nm5k
 8PpAEsN114otbkTbnKWXXloV6ay2bCUotSQCGh4lyOeTFuGUeiMiGHS7ni1g4Uju1bPq
 Hfdw==
X-Gm-Message-State: AOJu0YwpJPT3ODrCquWVjGXTHwE4Cj6F/vo+9fz03abQ03hPK1V3ultG
 oofkg8KLDQMWu8BolZbMPo7yx/sOjMBv5Q/kEOnxhXvq0SqmNTC4lqM7XjK1VKEIhwtu+Z+IYcw
 z2nGcINSBFA==
X-Gm-Gg: Acq92OH/SgA+7pCR7iUzGasbFyTGsTKm7tMmaYZoR2fQKfka/SFJ+VZHco6gLambgr1
 Jmgp2ywT6z5llxeSPJ+HyEYEghIfKust4we7IBHmc3mqY4vXHlcTLCnuZCG+AlOF8elBAe6IJ2l
 pdthimmf5bgKzG3RLf2KrPSW86SAImNbO1wpFCJab6YK2R06vhjrY4idN5CH2h1EPEeP8zOC09W
 ZxK/7Ga1xReWTZgtQjwjbrSznOTvXWSBzBNKYVDmyiJ+xx0fdobA9YSCwh8UbfMcZRYsJYLsIXD
 cgPJOJLsjBSGFUpRd7ByE2YnQxYstPBQbXmwmqb04BgD1g8ItF8B+1kUqdRW1F5Nlj7Q3a3U4Ez
 5VpAP5z4H5giRvvynWOjL0Ma8AzbH3/+YdpQ0YiJXcZeu6o4jk8kCR6EQ49+rE10v9f4o15+bh8
 vrOQW06wy3NmRbCAcmjm9mesSqnRDMUn3mbrscK4RyQrCoTlIIlSgkucgGXbcdxvufIiQ4Sdq62
 Ds3
X-Received: by 2002:a05:600c:c04b:20b0:490:3cb4:f1b3 with SMTP id
 5b1f17b1804b1-4909c0ba682mr43032785e9.16.1780064726422; 
 Fri, 29 May 2026 07:25:26 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d7002e8sm55832855e9.15.2026.05.29.07.25.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:25:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/17] accel: Introduce AccelOpsClass::cpu_instance_init
 handler
Date: Fri, 29 May 2026 16:24:22 +0200
Message-ID: <20260529142434.87880-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

accel_cpu_instance_init() currently dispatch via target specific
AccelCPUClass which we want to remove. Introduce a similar hook
in the generic AccelOpsClass structure.
We will convert implementations from one struct to the other, so
add an assertion to be sure only one implementation at a time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-ops.h |  1 +
 accel/accel-common.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index fd1307dad6d..9810cc27cd2 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,6 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 176b03e0e90..b3bcd53a4c6 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -39,7 +39,15 @@ void accel_init_interfaces(AccelClass *ac)
 
 void accel_cpu_instance_init(CPUState *cpu)
 {
-    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    if (acc->ops && acc->ops->cpu_instance_init) {
+        if (cpu->cc->accel_cpu) {
+            assert(!cpu->cc->accel_cpu->cpu_instance_init);
+        }
+        acc->ops->cpu_instance_init(cpu);
+    } else if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
         cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
-- 
2.53.0


