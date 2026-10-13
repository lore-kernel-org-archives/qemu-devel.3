Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E13CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGa6s-0004kO-RH; Tue, 13 Oct 2026 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGa6r-0004k8-EK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:51:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGa6p-00060k-Nd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:51:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so19399335e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791888710; x=1792493510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bRyz74roj7Gk7mgs1Uzn7YPeAkhJHfzrPoxB4VBW06s=;
 b=VFih+bF+wkPmDRSHT5MfWsbay3e9rdZuzpJ5cH0SWdzQhjEppRSqW/+wvosU37ev2D
 ixzIvz8xARkb0+sJcrK7fZAaLpkWNk4mKrov/KJXkNpVHZfekyRqZMGSVDAQMsb6ZHz3
 oMsfXeVjfghrNgNPhiSRRzDlMGJ16LtcJGhMTwIjskyxrvrdFw0+QB00FOH7+z6vA5xk
 RuFdkZuS3Lp8p4vZwqojnGYGA889S5zE4+sVcG07dPZduWKISFtG86IZLylK79wLyOqT
 3XY3DqkI1HodXAVLjNEOGd5Xm4jcTWjepNzxj2fTzyLEje8YqozC0s9Zwhnq8Us7Fb5Q
 3opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888710; x=1792493510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bRyz74roj7Gk7mgs1Uzn7YPeAkhJHfzrPoxB4VBW06s=;
 b=BnkoqRQHAoZcTvcrC/ZQa90lgSaYdpjtBuJnZXOyrKWjV3HEIgIyjg7BvSMlGOpVg7
 kP8vmTOVP+9aJewj9awwTbHVs0uF8876xAXtTovHEhmMsKT1sX7XjLjWuAa+8488maAE
 kBTVtOT/8aBDVjXWiQJ9IshfVac4DcU/7qn9AFZz9ueIThXTxHHz6T8gkfbNm7TBJJ5+
 6cFuQyrmyjLQMtxLBu+HrgauhhuADV+g5UKmlUff+Joq6c7n7aev/D3T17Tdp9qKA2IF
 mDfzdiZw1adDONfnSeJo9SaoVArR3yZCrvdEzQAHRFv4y3ltWPPSWCZBWV8PnjAlicAk
 lIXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1f83J6vBQbHqAymQ4AGGzK5YaPhQ5C6YlyaNYv3g4uH320s6HljurgQnkqZhMhd/J0K+G1pQMX6yH@nongnu.org
X-Gm-Message-State: AFq9FYIuJBJTfJJTR1xbXpv/MHNbJu/GkyGcZc8KmkhOMn7WfPfv/iww
 kGdBN9uqTrTjRvKxjygNLZYx5SfBKgaU+eAE4P4xCgwhi+43u6Z3LStchZR422+REbg=
X-Gm-Gg: AYBFou3F893osr3zAme411fWz9ycG+dv/4NrwyyZQESU0dYjcHnZbzbV7hYPbRcpn66
 DsRSpM6+nyKFx/N3hvjNsd5ubzhTVkpmmYh+xyjhfxS668jmrnXkEOtDV1E1dscmsaAJeXOUjx1
 WcWaLNi4Lx8mK0w0zQoB8D3UqtuLubQDnGCrMyLElL2HnTtTL1M/Hbt/IS/5VoqaPHfpFPB+xmm
 LdCmD1DGaJ6NaYZ+0IHr472kFFKoyr3lgRsEfNgvjrH0B+7fJdcbywG2ThxvoHVWcdvs0qjTmxx
 QJSIH3spzZHS4onuFvv9ylyneSxGl4PIMykTXc+KY8iPKbgs/1yDNwfg6h3nd7gxZiX59dLjaJ5
 yPCue397G5qYnTGR4Ain30H3k48KmUOxl3/GsCqJ4TdMgDBIogZ9ZkvPGiSfjMB7uH1Vev9nVPg
 WPmo4zlhzCHCfH9mKdRaeSP6ZfjUjxJRhcPJnQ0R5oHa/kgjd2LTQK6f5E3E6KfBkU08vFN0Byy
 SOgfObs3nRc4xz3GBYyZKcxwngT0fGgpyKSsXud8TlcQ1Yy5zvUGMq0GTIkd19NoR52hs6F6dPG
 /7M=
X-Received: by 2002:a05:600c:8206:b0:4a1:6811:8d with SMTP id
 5b1f17b1804b1-4a18e4a3b34mr238630055e9.11.1791888709875; 
 Tue, 13 Oct 2026 03:51:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19ba624b3sm242473825e9.2.2026.10.13.03.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:51:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH] target/arm: Deprecate using named CPU models with KVM
Date: Tue, 13 Oct 2026 11:51:47 +0100
Message-ID: <20261013105147.1070641-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Currently when using KVM on Arm, the normal thing is to use either
the 'host' or 'max' CPU types, both of which give the guest the same
CPU as the host.  We also for legacy reasons allow 'cortex-a53' and
'cortex-a57' CPU types, which will only work when the host CPU is
exactly that matching CPU.  This is because the original idea of the
KVM ABI was that userspace would request a particular CPU type by
setting the target field in the KVM_ARM_VCPU_INIT ioctl to an
appropriate KVM_ARM_TARGET_* constant.  However, it quickly became
clear that this was a bad idea, and now everything uses
KVM_ARM_TARGET_GENERIC_V8; the tiny number of existing CPU-specific
target values behave identically to GENERIC_V8 except that they will
only work if the host CPU matches them.

Future support for "show the KVM guest a CPU type that's not
identical to the host" is going to work by telling it different ID
register values.  Real Cortex-A53 and A57 CPUs are now all over a
decade old and not in widespread use.  Deprecate the ability to use
'-cpu cortex-a53' and '-cpu cortex-a57' with KVM, to get rid of this
odd legacy corner and open up the opportunity in future to support
named CPU types via ID register settings if we want that.

For any situation where the cortex-a53 and cortex-a57 CPU types
currently work with KVM, '-cpu host' or '-cpu max' will have
identical behaviour.  (Though note that if you are using "KVM, but
fall back to TCG" then the fallback under TCG will be different.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Personally I doubt anybody is actually using these named
CPU types...
---
 docs/about/deprecated.rst | 13 +++++++++++++
 target/arm/kvm.c          |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..153fe118151 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -234,6 +234,19 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
+``cortex-a53`` and ``cortex-a57`` CPU names with KVM on Arm (since 11.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU currently allows the CPU name to be set to ``cortex-a53`` or
+``cortex-a57`` when using KVM; this is identical to using ``host`` or
+``max``, but it will only work when the host CPU is a Cortex-A53 or
+Cortex-A57.  These CPUs are now over 10 years old, and the ability to
+use the named CPU type like this is part of a legacy corner of the KVM
+API, which doesn't work with any other host CPU types. Using these CPU
+names with KVM enabled is deprecated; use ``host`` or ``max`` instead,
+which will have identical behaviour on the hosts where using
+``cortex-a53`` or ``cortex-a57`` works.
+
 System emulator machines
 ------------------------
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d905f8565d..de09d63d2e3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2015,6 +2015,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
+        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
+        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
+                         "with KVM is deprecated. Use the max or host CPU "
+                         "types instead.");
+    }
+
     qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
 
     /* Determine init features for this CPU */
-- 
2.43.0


