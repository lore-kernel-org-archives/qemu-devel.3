Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB5DE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsWkS-0007wN-Q0; Tue, 17 Feb 2026 20:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkR-0007m1-BT; Tue, 17 Feb 2026 20:53:03 -0500
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.35.192.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkP-0005MY-Lx; Tue, 17 Feb 2026 20:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771379581; x=1802915581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uVNVDznm7NxQ+bwTqP9jZD0VXeg2067NIquqLqqPp8k=;
 b=UXRY5C0G990DBgrw/dvKvQujZca4G5QBODoCfh1ikdtEG9cTAbVUlRZ9
 SZnv1lYQn3U/RuD1Lw7nmAiZUW3iTt8xd5WLMB2m8vhX/32zil0GfdpPS
 iU67TWv6lRkG1leUY8k+U5vr1PIfxn4ZG6oHe84Tu6TvECqnoKhbp9pAa
 GZkJsSFqlUSRFlFrhqdzepIi/qC1T0D2tEqKJUb0VGuP2NgzzxMQmRdaD
 Zqb1dbRi1Sh0zOMg+Er9bF3CvUvjy77tALU5Y+uFaXObSvZ3Y8zUH8mAi
 3fP0k0ed0Raw0u29596c5q587ee6HWLdaA1Ztc9LRr17rJ01zIbzrHHeN g==;
X-CSE-ConnectionGUID: ec2gWyq0ToGqRTSbtgy7Gw==
X-CSE-MsgGUID: CyXLfvGWR6OfJac8E+6vEQ==
X-IronPort-AV: E=Sophos;i="6.21,297,1763424000"; d="scan'208";a="13037355"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:52:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:16402]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.107:2525]
 with esmtp (Farcaster)
 id 37763521-d57a-4bf4-8565-5edb81b6cdf3; Wed, 18 Feb 2026 01:52:54 +0000 (UTC)
X-Farcaster-Flow-ID: 37763521-d57a-4bf4-8565-5edb81b6cdf3
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:52:54 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:52:51 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH 06/10] target/arm/cpu64: Allow -host for nitro
Date: Wed, 18 Feb 2026 01:51:46 +0000
Message-ID: <20260218015151.4052-7-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260218015151.4052-1-graf@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=52.35.192.45;
 envelope-from=prvs=502105d20=graf@amazon.de;
 helo=pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


