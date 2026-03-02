Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CF5FD0054
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzY-0006vr-UQ; Mon, 02 Mar 2026 03:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxh-0003Zt-8j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxf-0002IG-NJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4ihGBXvjUCoqlMIHRWzm+yMtviH1aSrNrVoS3hHYfg=;
 b=OezkURJrrAPRJLYpGjPumg7VFt9NGeog5K6BV6bfFL3pu9Y2G3kHD3NRwgj1am+utGV3b9
 HzGbmf8wAsol0eIxrL1cy47+8XTdkP5c61i0+Ecp5rAnZM4WdBL3QKt2z8bl2H0xjtmq1g
 yUtq4DNu/YWd1RUNQDqTrp5hT06DafE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-6YV40r89OFeFL2we5sXV5Q-1; Mon, 02 Mar 2026 03:49:06 -0500
X-MC-Unique: 6YV40r89OFeFL2we5sXV5Q-1
X-Mimecast-MFC-AGG-ID: 6YV40r89OFeFL2we5sXV5Q_1772441345
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so44164895e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441344; x=1773046144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4ihGBXvjUCoqlMIHRWzm+yMtviH1aSrNrVoS3hHYfg=;
 b=WC1GPIVim7iTgRXtA/nMMNZCCsVS4YlcPC9p/a3lvMZq7la1mgji/nzS+3v5ZKmmwb
 mMVGfHG/FSrqGwy5vhBf4OEtActZikvz3odg6RDCgxynec+35Z2sDttJCpP+ucjtRHto
 KnmkeHXNc1DFN9MVfjyafkgz8Sg7UDE/MYGgp3gOBYgRAhS8TEpn1+1f9Q2k5OLBuQU7
 //qc0AUNeuYv3hh0Nkz/3eYoUpZTps02pV1wP8fNEbPOl2NggLWuluyiAU3vqIZ1hMxL
 eQc/1giOBHoP0S0lKINsor0w40vCPmwrOoG5AIa+iCFQ7hSIXxF/KY7H1wqdcJX5AzIb
 B0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441344; x=1773046144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4ihGBXvjUCoqlMIHRWzm+yMtviH1aSrNrVoS3hHYfg=;
 b=kHOBWPz16e8WbUpE/Fssw7soFduSXeAaJdr5MagoYHZytKwb4PYOwFuVUN0176eP+U
 Cj6vjbRfvzRlR9tEMTUgBg4/dUsYh+065+9pLh1Ox1tD8pXnBU55OQtJ7x6vTF/wm6Ce
 hhcMLJDFXVsXNkpqedqXnJ+smmUw+KInQzr7pkWlMxWf0XG5awf0BWckv6Ybr6Jyjgsh
 sqyVyT2UYYHL1TUy59M7YPfHrakXuaa7AquICJJucnVY1S23SHgoUkSJHmmFfc5heibI
 jfEhVmEboPrY1YQ63vScq0m006zo5/QyiEb/xA7XyPm4eKy89lGPL9JVUeNVADy4OBiE
 yV7A==
X-Gm-Message-State: AOJu0YwfcEdRDUgtYGKyaAB9e9h2HvPowqn5kjh+N+9dZdRHF27FTfLb
 nGzJLpVPXf/UOjyXpxXHgW0alyiD7MUSf3EyZZ2a7WoX6lddyFJTW7koWE6CA1Hbc+TUDIacaiR
 3Tu05RA/kQoum24XDI0BxMJe9SzxJz6MtS3LM8LrzPPjJhSG1VWOXGkCzPNYHgQ4opyV1Q9gM3l
 OddR1VwMKBFfly41EJYwdB2nfs4Ip/lQ0/TZU/EIxN
X-Gm-Gg: ATEYQzxUIEUCNKdBqo+6v+19yT2BvRg1M1qFXC/4yL9V6p+b1zU9AmcO26M8Dfab7Sz
 nRnpvG1V6t0yzwtKoZUja+O4dKGLAGSwVYtfzWucJkK0af9ok+1U1bomnT9zqprpTBzpnYnluoY
 NxBDKUgREbWuAwvBP92oKv4Tdwlyj3H9NGBvQJDfT4wndp5kybfHRQbED2CzUNTnHo52XErkja8
 jCKpqgI8Wjct42xP4fuTNQDyWsKzF58xIiQsIzObvhEh3y7SrvaZgM2wSzdb0Qcaf2/FDuPmSpE
 09a4A+cw4zcrIBIeB8SWkVqK0eF4u4L+GXYTmVPmT7RpDK/3z5nnLZ/vaD+7dRrDOFSfGVNRtTV
 Vlb1sTzMowcOIBDpMTzadWFd3Eu7o6eaIMUU5Juc/V3CIycxm/SPn4/gev4qBrTQgW8ncyfw6Sg
 /hOp9ESCNS/e9k74bhqRCP7/6Mbac=
X-Received: by 2002:a05:600c:548a:b0:483:aa2:6bce with SMTP id
 5b1f17b1804b1-483c9bdb0c2mr185458645e9.30.1772441344448; 
 Mon, 02 Mar 2026 00:49:04 -0800 (PST)
X-Received: by 2002:a05:600c:548a:b0:483:aa2:6bce with SMTP id
 5b1f17b1804b1-483c9bdb0c2mr185458105e9.30.1772441343952; 
 Mon, 02 Mar 2026 00:49:03 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df9fsm458676195e9.13.2026.03.02.00.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 096/102] whpx: i386: enable all supported host features
Date: Mon,  2 Mar 2026 09:47:42 +0100
Message-ID: <20260302084749.474955-30-pbonzini@redhat.com>
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f12e621a412..285740bae87 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2022,6 +2022,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
+    WHV_PROCESSOR_FEATURES_BANKS processor_features;
 
     whpx = &whpx_global;
 
@@ -2127,6 +2128,45 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
+    /* Set all the supported features, to follow the MSHV example */
+    memset(&processor_features, 0, sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+    processor_features.BanksCount = 2;
+
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,
+        sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get processor features, hr=%08lx", hr);
+        ret = -ENOSPC;
+        goto error;
+    }
+
+    if (processor_features.Bank1.NestedVirtSupport) {
+        memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+        prop.NestedVirtualization = 1;
+        hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeNestedVirtualization,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
+                ret = -EINVAL;
+                goto error;
+        }
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeProcessorFeaturesBanks,
+            &processor_features,
+            sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set processor features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-- 
2.53.0


