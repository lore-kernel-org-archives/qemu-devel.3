Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBCAC624C6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyza-0007EC-Vz; Mon, 02 Mar 2026 03:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxr-0003hx-5P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxp-0002JB-HA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsTRHSmch2QZEVM5In5IyzsyvhVTdi0t3g3pkwsZxw8=;
 b=WtDGUbg5wBi5VRkbYjFUYOu0DnhM+3md2Pe0ZDkFG67SikZPLJZ5eEm6WZkgTfcw9JvMFr
 RVy9l+Ay3N7pHv8xzsmiYKimycv7HrBzoArpr3ArBtSOoRw1ST7cmcMnznOoNl21njSrS0
 nF2RPJjsW/IttICf6to5/ezyfrbmj2w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ahLxv8tVOn-LqT8UCt-bbQ-1; Mon, 02 Mar 2026 03:49:15 -0500
X-MC-Unique: ahLxv8tVOn-LqT8UCt-bbQ-1
X-Mimecast-MFC-AGG-ID: ahLxv8tVOn-LqT8UCt-bbQ_1772441355
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439af95a718so1179174f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441353; x=1773046153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsTRHSmch2QZEVM5In5IyzsyvhVTdi0t3g3pkwsZxw8=;
 b=uEzVysbaV06NLceNmvX81LK1dBjMrCZS1eEwM/kA+t630XYeUZI5/PlyKRsB6fw/97
 JwqIXWyrbgwByMmkDpgKAFlRNrDXc8etvEZ1RTCy/gSDayEZ7oXLR/XJEHDtewi299rf
 Z4dF4cxVE3xnTS6ISP686zLL2TE1ItKToFvibeQ1aRvITeRBeOsPlaHXZZtMFGdfRClF
 bU+wcoY6ntkGvFP+RNXKWRs/czuhEipCkqzBTjXhWzpf+Ohoad0qL/BBMjNvieCmtnqw
 lmh2zpKZVy7jqPRQmI6g0wCX+S2dG5uolkV8bFSXBhu8P2fXcyU+klPqlHlebGDo9GAu
 Xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441353; x=1773046153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PsTRHSmch2QZEVM5In5IyzsyvhVTdi0t3g3pkwsZxw8=;
 b=KQOyyBrcyGO2gyaeLNUK2DFbYuRLVm1Le7vXOVq2+B/s/MXR5c25BtWMbN4R3gSe97
 583kFU9VsyA7Tj/q85M6Wq/sMDsqnaZKoez9KXldmxyKIilLEEaEYkg4JabizD5xEyUT
 gpneb8LPLKx7OJxBM6nq8ykn+D850zuu/Ylj1vjaCtVhCaTEYVDblTpo979KKLR9RL7/
 g3dAM1YiktO+7U5N49KWOHzwwRpenRH9A4FBpLswA0+36MsvCrA+lHZPaQR+biYSzO+2
 37mAGcOI2tNKusACVDluZQdBjM9g1OrBfThHwogcyiiAYwt6d1TzBB4PEqr8hfHHTSO7
 b0zQ==
X-Gm-Message-State: AOJu0Yx4+PeIBddkG83srvTccfHKrlzAfebBD/Jfz+75OFXl8HF3KUsJ
 qyuPlygPSur8+ZHPDyP1JCieuF8WoZ6odQV8SqWDYQSOL+eUaPiEgd7BwqB2Z/fWZr1PCsfqgvs
 r+CZDWM28Hs1VViQYAbrDXbAcDdqw3LAtIEALHrrSz9xDFrpToH3nOSy5LqdqdxifDV4hR0bY+f
 ozp8a0wsvqaK39auEE7AhJwSA92nF9Z/YiZij9NwnQ
X-Gm-Gg: ATEYQzy7fipEWtTLtA+MA0Acrz8+EJ+43IPFyHqyfGHWhUmNyVgXGrC4vQ+OOorLEse
 xpxfSrEujq2s1ssC2s2FBeAJ/tD5fEPDU8dhWJIdryIzUYFnirVe084zxPscvzdN3kaRseg04hb
 /V2pklRkckMt1Av5/oK2MVD7i3x5ThTVkQWzZ/2hTldAJXhCHhmSCPDu6OB+M25jIjTtufMTODa
 xmxECAhnbVieUALCj+KWkOOBOS8zBjogSW8SIU6oaYGjA/BLx+1hkq6Ypbrgev8Abl/OWcU0GGL
 DLnZ/JtpUzidZ0MxO1ghd4BccKwJFKxtcDVTklnAe/K21CDI51JDsL1ygHYYWmVhm8UsJCIv4Bj
 +uelrjX9N3oo1PVKljd/UFPxT7NHCzdUrWPkRYeyqWt+Mr3haGRdHtSHKonUEFMbygX9DSD/gg/
 EOQxy/bajZM5qzOJ8RdkCfZQLBs3o=
X-Received: by 2002:a05:6000:2891:b0:439:bcb8:54c3 with SMTP id
 ffacd0b85a97d-439bcb856femr929360f8f.19.1772441352810; 
 Mon, 02 Mar 2026 00:49:12 -0800 (PST)
X-Received: by 2002:a05:6000:2891:b0:439:bcb8:54c3 with SMTP id
 ffacd0b85a97d-439bcb856femr929312f8f.19.1772441352308; 
 Mon, 02 Mar 2026 00:49:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55d15besm8998746f8f.30.2026.03.02.00.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 100/102] whpx: i386: enable PMU
Date: Mon,  2 Mar 2026 09:47:46 +0100
Message-ID: <20260302084749.474955-34-pbonzini@redhat.com>
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

Also a partition property instead of a CPU one...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4186be62ada..7ccf92e4d11 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2026,6 +2026,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
+    WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
     whpx = &whpx_global;
 
@@ -2170,6 +2171,27 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable supported performance monitoring capabilities */
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
+        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get performance monitoring features, hr=%08lx", hr);
+        ret = -ENOSPC;
+        goto error;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeProcessorPerfmonFeatures,
+            &perfmon_features,
+            sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set performance monitoring features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Enable synthetic processor features */
     WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
-- 
2.53.0


