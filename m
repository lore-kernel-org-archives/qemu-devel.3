Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8DFFD3762
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGAU-0000hk-UT; Wed, 25 Feb 2026 09:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvGA2-0000Wb-H8; Wed, 25 Feb 2026 09:46:46 -0500
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvG9z-000766-Tk; Wed, 25 Feb 2026 09:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1772030803; x=1803566803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uVNVDznm7NxQ+bwTqP9jZD0VXeg2067NIquqLqqPp8k=;
 b=YS2SgXzrpDil1NE9uU2S1OabF2f7VN6XqJcsP+EXcWqF+kVcz8ltFY1m
 a1GrjqwmA2nJPBPNL/EJuFdWBuDvh4VrTqZ5NNt7sdAIDPzYAby2xe6Fb
 YtqWen083mJcVhidRcJfC89m9VZQVZ3nXIjbpF57aplHluUzTCN22+GaL
 DTtrokAJnLV2dFnM6F66HaktApyeVHR0PSHPSNR96h6mDeqM55uIUUfLc
 7CXlVvKYs0bv1UgufNdpHofFkSiYvuobdGnaEhvgBlrHGOL9pe5hETRYl
 S8vFm04gfFnkvajgV8ME64dm2zScO0rR8cijWUVX8Qz+9MuUPhsO42F1S w==;
X-CSE-ConnectionGUID: +vTHUKSqQSKNT0EyRm0YMg==
X-CSE-MsgGUID: jhYyOK1UQca5uScKAuWp+g==
X-IronPort-AV: E=Sophos;i="6.21,310,1763424000"; d="scan'208";a="13768594"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:46:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:20004]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.226:2525]
 with esmtp (Farcaster)
 id c571fd97-c8d4-4901-921b-6ca72cdfe0b7; Wed, 25 Feb 2026 14:46:41 +0000 (UTC)
X-Farcaster-Flow-ID: c571fd97-c8d4-4901-921b-6ca72cdfe0b7
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 14:46:40 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 14:46:37 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH v2 07/11] target/arm/cpu64: Allow -host for nitro
Date: Wed, 25 Feb 2026 14:45:26 +0000
Message-ID: <20260225144532.84673-8-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225144532.84673-1-graf@amazon.com>
References: <20260225144532.84673-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=509822c20=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The nitro accel does not actually make use of CPU emulation or details:
It always uses the host CPU regardless of configuration. Machines for
the nitro accel select the host CPU type as default to have a clear
statement of the above and to have a unified cpu type across all
supported architectures.

The arm64 logic on Linux currently only allows -cpu host for KVM based
virtual machines. Add a special case for nitro so that when the nitro
accel is active, it allows use of the host cpu type.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 5d7c6b7fbb..c01051f038 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -765,6 +765,14 @@ static void aarch64_a53_initfn(Object *obj)
 static void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+
+#if defined(CONFIG_NITRO)
+    if (nitro_enabled()) {
+        /* The nitro accel uses -cpu host, but does not actually consume it */
+        return;
+    }
+#endif
+
 #if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


