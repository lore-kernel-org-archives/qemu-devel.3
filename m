Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B33CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Dk-0005Uo-76; Fri, 29 May 2026 15:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3Di-0005N1-Dt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3Df-0004Wv-7b
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so85244535e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084209; x=1780689009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDALMDNynw3GUuarnrLNetX0Kec6G0245sRIZSxkHLs=;
 b=aIf94tDb7qWtb7tPlvZ8BoJ9teHaDc+bT/haxiAXFdHRxdYaAKYZNKY7SnqhlEFuKO
 TnHolPp2agYV8YIy+PCyL4i9g6kL0BHO8eMLYIv+2n3gOSgqd6DVe1ilP75vBhL6PGqw
 F6RtTVbLvKvBuKYZnipbMx0SMppGlDRE+CYahUAqiJShO0o03ga+kfD2K2Et8FOa4LRZ
 sU6ilgRrpEEdnVyl8gX58KFK7533aAvQTFKV4co9+9h229JfK0YvmnttgYBjBiOrtgqM
 6TiSbYEm8vmKZYR5fequ3g00xW0+k9q+/Q7aUNg7UNL5Jy/1YJ+LXimcU/E/Q1GXdszc
 QF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084209; x=1780689009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDALMDNynw3GUuarnrLNetX0Kec6G0245sRIZSxkHLs=;
 b=CP1Moem8Wz9yOi72qjsEXwbpPwPKrsrehS+/qpYFTX5HdlraKJhTybfBeyV4PEVNWW
 Axd/0kUAAwkK7Z/8BLxfURQKKlr17Aomg8P6EJePxYVgT2y+DY63QGgqMR19pF12owP1
 RHZhfrKcYoVVmUloB0qTmQHMASKEIH2Dl5ZT11DexxuEKUfmJURdmIsfjO3vWU72Qk+B
 s2vpsl4cLdkT1TJjrjVs/xi7yPqHdzlRODZz7IC6GKncesRG52wtQfJhUYKlypaRYao9
 Xj7RQ4R71x/tzkpMrVbyEB0htBFRpvgwlUzBl/gxAeL2ZBrxOXlxskm2Ck1CoZ/EVgyP
 HWtw==
X-Gm-Message-State: AOJu0Yx5ox1cTMF1SFGOzsSUmOcwIUWdQ3b88Qqb9PX+tEs7BSKHNaF4
 Drui4gCpW6n5guwXP+irmZh5pgNlJiYE4+kijMmtf7jCQM2IjqwyEYtj5PEpoV5oFHbg5GsA+gb
 ToymlM01U/w==
X-Gm-Gg: Acq92OG1abi2tX8MaMD3M6sIbnFsq6Yv8H1Ye6DNzQfuJoskeYrX4X3vcJJLahtQ+Nm
 O3+TBm5aOIDwU4uoF33DtPYpnNm9biylYYVJO6KhCknF7xEuIw4NyDzCqLcw25hXYz5Gk5HYGcL
 aoyWBiVTuB62PgBKS7Ego+LzJcP+QyHimf+l4ByEHB4YeUigkL/uyrgqP5AOhxbE/c38HEQJlZn
 3ex9WjYY/S13MhgZ/hCAOJGXFU8pW7Dq0OKRrrz7ChiBfUjBKhx9Oczp1785abaz3FyPE8Zs0sX
 R1qwC+OUFfFCZ4UwR10mWKw0KGRxyst/VcaFtpiFzwjPTWsROqxXe/Nbrq3kb4LHv3KdhOuFGxF
 +fJ7lY0tR6pGvyKWkRoVjSeB2J77YQqdJTQLGC33ezrv7hw7FOEIiJw37OF0AkQdfv3y058A4w3
 6T40mZ9KMxoWrHNzFCZNfeV3xWZUc/B3P3GRQDpOIkp5uUUoD5jFLjVuq0dXS+peIGkw==
X-Received: by 2002:a05:600c:8b53:b0:490:a29b:e72f with SMTP id
 5b1f17b1804b1-490a29be7a4mr15412425e9.4.1780084209487; 
 Fri, 29 May 2026 12:50:09 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0d4f4esm28563585e9.1.2026.05.29.12.50.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:50:08 -0700 (PDT)
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
Subject: [PATCH v2 03/17] accel: Rename AccelOpsClass::cpu_target_realize() ->
 cpu_realize()
Date: Fri, 29 May 2026 21:49:25 +0200
Message-ID: <20260529194940.97143-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

cpu_target_realize() is misleading, we simply want the host
accelerator to realize its things on a vCPU. Rename more
generically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu-ops.h | 2 +-
 accel/accel-common.c          | 5 +++--
 accel/hvf/hvf-accel-ops.c     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea0..fd1307dad6d 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,7 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index ebc103053dc..176b03e0e90 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -60,9 +60,10 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+
+    /* specialize with target specific realization */
     if (acc->ops
-        && acc->ops->cpu_target_realize
-        && !acc->ops->cpu_target_realize(cpu, errp)) {
+        && acc->ops->cpu_realize && !acc->ops->cpu_realize(cpu, errp)) {
         return false;
     }
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..6edc2242ed9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,7 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->cpu_target_realize = hvf_arch_cpu_realize;
+    ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
-- 
2.53.0


