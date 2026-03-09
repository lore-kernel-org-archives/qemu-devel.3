Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC61FCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeeq-00037y-HF; Mon, 09 Mar 2026 13:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzeeH-0002kq-7V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzeeD-00027G-3m
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFR0ObgIqPLlmWXGp14A60mgMZFVJ2G4Q5gsLMbcTvY=;
 b=ZW/QvYCJPIrZZLIJw4pkSVLF49bSEUIk6PydQlKUTizyLOSWIcDXjmObQKl/lrCYG7TKgE
 sYWZw7OqK5k9n4xGSriqC1YwjgVVsgxsJOiK+JhG9ZKeKaY0kx66zTCjBrepwtWIwaPJa5
 nqEzB+FS9X3xq0w2xdjRxNuBooKR7zo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-OMv0cEcePEW_xNIVihVy3g-1; Mon, 09 Mar 2026 13:44:03 -0400
X-MC-Unique: OMv0cEcePEW_xNIVihVy3g-1
X-Mimecast-MFC-AGG-ID: OMv0cEcePEW_xNIVihVy3g_1773078242
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48535f4d5e1so8367445e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078240; x=1773683040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFR0ObgIqPLlmWXGp14A60mgMZFVJ2G4Q5gsLMbcTvY=;
 b=Uj/FCimUyZTo2G+WmOHVAioUlQU5uALKWgEDy9qxlbcEoQQYri3fO0vCJT2d62cTnZ
 mTBr1sR7MqtKT7BjIoQJk++sn+MiNY6OPojiJlG+Bb74PratwYErgWHG8fDYjky0G6zw
 Q1IhFBLJ5TQudoaVZK/iZZD8K8c3vYVwo2EiLmXPTVaYs5n8hIAb9XNK4mc5xnIFWfHD
 KqwNyv5OkXkWfoDbCcUBUr4V5xC+phs49XgdRmUWLklSSg0H34vmAjrB9wpc0mDSEAl7
 tOB5VcTAoLz00dwWg11Iag6msFs4o48684p65jBGTX7nOASpCJvfMxNy6Dkwlmd01mAt
 CzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078240; x=1773683040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xFR0ObgIqPLlmWXGp14A60mgMZFVJ2G4Q5gsLMbcTvY=;
 b=jyRmXB/EvJfjV+re2p95TFdeks1ilxKvgbp9H8Z9AuVDiz2CKJo6i/HRGT4zfjpj7K
 ZJ/1pDf3h68QILZjgX8ZCWZxsAfKlqqHq8E05rKo208nbMz2KinHzdLNVwHVcHvsOVFb
 F7oL+TyIGnRVF/lqq3FQMx36GQg6M+7dutgkb53sgvXQoe9PxZ+k83HCg8D/m0lK6eUg
 PY/fm19LzKCcPKxnEMQJPQHZDKvG3w6Gpux4X9nCxknaplXmsybZVNsE76EJLRr0CkSu
 xNB41IGBmA09gyNPCWXwAMjZiSSG/HcGfHB7EkGn3+jESVHkhbsEr3La7oAd2HrjejH8
 W7Xw==
X-Gm-Message-State: AOJu0YxWM0QIMj9cA86N3iD2mGoMODLNcOOXqXZheFChEMg88zHDyihu
 IfWoNWl0bXRIBef2K2fzNhORL/MgxPuFoyiAdClQyxBfpIvOV7rJpkt99UvWZ1pxasqHSg9b+6d
 6PAUPfgwwBHSk9n58kwC197D2QrE1Ce70YNyZ7SFwVziuh9um3zCcS4IcYo9nuwOseOrBgd2T0X
 8wQn0PdrFJQ4T3yENKzlnpNET9/7EgsmeizMggnq27
X-Gm-Gg: ATEYQzxgbhk3Eh5lcNuINwgrW6PuqirhFyDrOFpJYcr1CP7YfF2HiHvBhqTquKPyOs+
 Lgcx/OwkiFUFGwm4rU8gTpqMpRB9ZOe8imub/9XWUvFPzdDdovfqImWJUYMwYQjs3tHOK6rwMNU
 zoxsxSV4X+vc3OgQk/NntR9vHNy3w8KTY+BndV7VtPrd9XCfbKBnmGEmSzlJH/bTpDpPlAgaJBd
 mgjA1H7RelfIHvlTwaU5b8eT86XCJyucMzycsIwAzKnrdCBxDD/OUPrpUttUbpuQemXP98zrJ96
 YUK/IVkb1g3Xy9naiqv1/eZfGLgfCASW6jZAo7g5/p8MPVrdCJEmH8zcfMjpCdef8+jICuaEG8V
 hxh4N2CCnm8PyEX5GYClCm/kbEyATa//Fd/W7R4Ue60As1PiAVjBghd+f0m7g5IoC+Vg8EtJar5
 EyxLIPC4sYgMPiFstsli3I7I/HVgM=
X-Received: by 2002:a05:600c:1e24:b0:483:887:59b0 with SMTP id
 5b1f17b1804b1-48526978dccmr204278825e9.35.1773078240136; 
 Mon, 09 Mar 2026 10:44:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1e24:b0:483:887:59b0 with SMTP id
 5b1f17b1804b1-48526978dccmr204278455e9.35.1773078239572; 
 Mon, 09 Mar 2026 10:43:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a498afbsm79672665e9.0.2026.03.09.10.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 09/10] whpx: arm64: enable enlightenments if asked for
Date: Mon,  9 Mar 2026 18:43:39 +0100
Message-ID: <20260309174340.52174-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Link: https://lore.kernel.org/r/20260307181856.2209-9-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/whpx/whpx-all.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index c5b108166ac..513551bec1b 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -940,6 +940,43 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable synthetic processor features */
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
+    memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    synthetic_features.BanksCount = 1;
+
+    synthetic_features.Bank0.HypervisorPresent = 1;
+    synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.AccessVpIndex = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.TbFlushHypercalls = 1;
+    synthetic_features.Bank0.AccessSynicRegs = 1;
+    synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
+    synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
+    synthetic_features.Bank0.SyntheticClusterIpi = 1;
+    synthetic_features.Bank0.DirectSyntheticTimers = 1;
+
+    /*
+     * On ARM64, have enlightenments off by default
+     * as they're not needed for performance.
+     */
+    if (whpx->hyperv_enlightenments_required) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+                &synthetic_features,
+                sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.53.0


