Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E546D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzD-0004xz-Le; Mon, 02 Mar 2026 03:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxk-0003c5-3k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxi-0002IV-7f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4Y3KHfwBhYU7QmfPmdxCiReVolMHUqug+H9G0c80JQ=;
 b=fE5vGDvMg7R74Nw6tAKoVEF1EFnL+BtaUecucbc4x41IrXrb2Jb3+GVAJ4BjtJU+mfetw0
 MpxQbSIvx/qFGBUHGnm+tRt4Jv1A4d1PXH/2sCa2kWHzgKQoGWIgXMwatRUxC7SKf3vzVy
 EQ+dxL4bvicS7j27B0+HcK8OHyXvjSA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-w9x3RBRHNFyXadimtiXnrg-1; Mon, 02 Mar 2026 03:49:08 -0500
X-MC-Unique: w9x3RBRHNFyXadimtiXnrg-1
X-Mimecast-MFC-AGG-ID: w9x3RBRHNFyXadimtiXnrg_1772441347
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836fbfa35cso20696955e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441346; x=1773046146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4Y3KHfwBhYU7QmfPmdxCiReVolMHUqug+H9G0c80JQ=;
 b=DOD3zrdUJ04cuBXw5ixx0wZcFg5XD/BZM5WlzlkyHAB6eZ1YbMTr774VKwIPSjjUYL
 0zsN7os/BViIvqQ/z61vTw3sRwZTddcMyzlaCBfCrF3yjO6KNBETuJS5MCMIy7IzLg0Y
 kTyAoQHTAluMEl4fB0nViOR0sTw3sta1JELlj8NY60MJDLuxzkhOOWRfJHGQ9GurtkLZ
 mnuvUbJ5ttypAxRO18HVJW0Dkt+EUgAe/BtVgh1qXRT7Wldnc921bdGK6ZFhOCNCPhV0
 vNnLJsGws7mLtuh9jsZwt8vMpyIgricL2EmkAzkR/Il69c1qS2R4r7cdqMSojcV/zkLs
 A++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441346; x=1773046146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V4Y3KHfwBhYU7QmfPmdxCiReVolMHUqug+H9G0c80JQ=;
 b=HYaKo5ikjghIiFU7nG0Lk3OshvoS3mpcxkCPDsN6C/6RjfgfEbfL8P2wL6ywx2+RR5
 KG9b4zAtqfdtPiVFfgjGhR90DMFowLg0Y9Lu8AEzPkSaf4WjMZexTR9Dc4CjmLvjVnMo
 77dYd1T5J+ujrNv+fdXLmabJs8bqOIZwaBNtaVXXuUpeVSUDZpqZ5+JD/VvjFvb1/lZO
 xviv4C+aYMIMacUq9l0Edoejg6suPWkYS5UrZAwmxURdG2gFuFRoUgEkkveAnbHgmN9M
 7j5h3CKvFlDQqL4ANGB/CEhk6WkbPvtwwxzc6rd70gYBs0gl+EWBhf+yfNfIqqpru8Iu
 xJSQ==
X-Gm-Message-State: AOJu0Ywt3RZjbfDH4XdqSaJZEfx1zlWZMREbYnowSY5xuEgW89CLy6Pv
 y7VyxmaAVKQ6el3HZvPrYga5rrd4xxshYuyGTgiZ0fFGYCrZWRmae78HPIq1cCURC9DlobDzidk
 qnXkZZYhRc5S2peT5ijT9UBwJf7BrqssNFVlYlCPUapcZu38UxAR56fHlZ5g90kAXUgSHVHEdMd
 VspM6dCFouQAd6svtc33R0ERiJC2CWBh90e5qxiJAl
X-Gm-Gg: ATEYQzx0CQ24eca3KMAVGZXljpmsmI67MiLgAurlyUMUf+tdjRhW2lRiU0dBeBF+ehk
 Aocpl21Uzuno01j8FOnIqHXStdyDS5vU8O2DVSGqAH1yKjy6KeglwkzJZWbRvdBpMBBbm9yPP4t
 ClaR9Qt8MwNjkWTQR8WrJJ0tsWSf37BNTc29FT0VBOzqoIdMVbbJ1I2zIl8wy/kqA01O7iZ1Vb9
 cL6FwksOMVEn8D8XE1mB/qyTTQc/QpLnuweN65IsBP6+3AmOZWHFtuvo1YFWb94rlk6d9To+NxS
 Na3VeqP59tkFiYBxUpgh1LrgFVbUpu1vnlFr0kW6jcmIKaswrhJtqWTnNQ03ZY1zk+yx7YE9rqA
 vbXZFvnyss0g+o1UAw7ir+RARJYgAA8YImwCTq75uAdAFAMO6k53FgK5kOtFrRufBx6JxvTEaR7
 ybUVLXwh+IG/Oxd2f12DdzMcZbOEY=
X-Received: by 2002:a05:600c:8108:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-483c9bfa168mr172532705e9.30.1772441346369; 
 Mon, 02 Mar 2026 00:49:06 -0800 (PST)
X-Received: by 2002:a05:600c:8108:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-483c9bfa168mr172532415e9.30.1772441345915; 
 Mon, 02 Mar 2026 00:49:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb77466sm166001065e9.5.2026.03.02.00.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 097/102] whpx: i386: enable synthetic processor features
Date: Mon,  2 Mar 2026 09:47:43 +0100
Message-ID: <20260302084749.474955-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

At the point in time in which we setup the partition, the vCPUs
aren't available yet.

So enable them by default for now like what the MSHV backend does.

AccessFrequencyRegs is shared for both the LAPIC frequency reporting and the TSC frequency.

To still benefit from the fixed TSC frequency reporting when kernel-irqchip=off, still enable AccessFrequencyRegs anyway.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 285740bae87..2863224cd2e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2167,6 +2167,40 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable synthetic processor features */
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
+    memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    synthetic_features.BanksCount = 1;
+
+    synthetic_features.Bank0.HypervisorPresent = 1;
+    synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    /* if kernel-irqchip=off, HV_X64_MSR_APIC_FREQUENCY = 0. */
+    synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.AccessVpIndex = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.TbFlushHypercalls = 1;
+
+    if (whpx_irqchip_in_kernel()) {
+        synthetic_features.Bank0.AccessSynicRegs = 1;
+        synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
+        synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
+        synthetic_features.Bank0.SyntheticClusterIpi = 1;
+        synthetic_features.Bank0.DirectSyntheticTimers = 1;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+            &synthetic_features,
+            sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-- 
2.53.0


