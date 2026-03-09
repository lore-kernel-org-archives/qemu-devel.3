Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78C8FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfo5-0003zy-TA; Mon, 09 Mar 2026 14:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo4-0003zR-Lc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo3-0007qH-2N
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFR0ObgIqPLlmWXGp14A60mgMZFVJ2G4Q5gsLMbcTvY=;
 b=Tx652R50KTLLXlV5wbFk1KnqFatA6C3e7Q1tjBjDouItw7UEBgWZachWha3htOdp1fn7MG
 BregSfh8Ps+AZ+MPZiNS1STzWK3kj0oRSuCe3ZKTW+UOmuEmyiU2QLOPb1/OnPZm7Kmxce
 50HZS8UVvR9sROqr1XyE6J1/Ly2cDGc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-_duFqRcuOF66UxFdarkZ7w-1; Mon, 09 Mar 2026 14:58:17 -0400
X-MC-Unique: _duFqRcuOF66UxFdarkZ7w-1
X-Mimecast-MFC-AGG-ID: _duFqRcuOF66UxFdarkZ7w_1773082696
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so28564285e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082694; x=1773687494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFR0ObgIqPLlmWXGp14A60mgMZFVJ2G4Q5gsLMbcTvY=;
 b=p2w2Lp9T14M8Jm/kQT+a3DoM1aEVeGfGGNSM7prDIO2/Sm2S71CGELg3/yZ/RP15BU
 1xIC+eCb4UHtrCCl69Unb6bkkwqUNYHqya6AOQixIeDKtMBvWm0NmGCD3Dy4qHncEZnJ
 aGN04V9yusQHk4iXoaOfqRR1rd3bNGKgUET2rwIvlVGaMGkIj907Dgn4WY/onrwny1X7
 HjtlJkd3F/f3iwf4M9wF/m5UhzC0BJm6jI2LGtflc7+5YP4PKXvKr5o6iLUbfCNO9AO8
 7s5N8XMSdFdt2MpOdvgcbDn+Uv6fg8QrapUQeDeW8Bo/mdD+6iSCiWK0O+7SVvdAMu9L
 oyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082694; x=1773687494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xFR0ObgIqPLlmWXGp14A60mgMZFVJ2G4Q5gsLMbcTvY=;
 b=Paq49JipKy68sxLU6mmTMkxfGVBRN+NragFNfNFp8afiBE+NTDUPFyul2raccvsVUy
 0EAZpJHWSMncqXRDzTSrCwItEKptSnI6JhjGiK2nWe4lT8XY+mef2+DVVvQon0su1b9k
 eorzh0ZAwY4ZsHP15neXb0Bv/bNDcpNkgn4NHF3Y50Y+9j8sRo23DRvF4POL39QMX8WS
 Mt+K6ZecFO0uDKvPhqKarDaPyLpieAmZ0fdVmVcCmS76Tqd/RnB3orvvybzxCgsEAoSh
 2Zzn37DvZfM6GxcArGt5SENDOKoE74QmbE5Rj/BI6Iyd8Y58lyQZXv6hvGN2Q8ujtu1w
 ML3A==
X-Gm-Message-State: AOJu0YyPbwPbNuQpbs9EsNWS0Jdio/thZx2Aep1ziYr9hdnJdH3zKswA
 zNxEJsnZvMDRPPJphAZnpwotIjG685KbE0DhC1VsM2oQhCO+0M1o0rCUI0fz/PX/3AVR9r1UvIL
 8ViUNtdi6VYTqHLHeZtReAkOb89DQGCK68FWJqXcXGhpmoE1de9pu7zO9sptSfiH+5cyVUKMgzK
 8SawpM7EYadylSUvH4OlGD/i6TnTfOS8a42lEgdmJq
X-Gm-Gg: ATEYQzwtFg1RiRWbU/+JjGXKgqs48/1cGN7zSocBdvJLoQodkCCL83SMWe8jH/p7q68
 VPDPe8sObOMysDXgZKSBEGBaEc73IZCvri1lDULvYRGkZhq0pe83Cd3wlDhJBvHVh6frxhFz8Lp
 qZgczN5zM/d5SJG9ip+sXOdOOMlY+VHBr54rTS6UFFtQ4MTSpJejFdqwsZkqdKpGCz9UR6BK1It
 fPiG2PXvcATZ3vzek5fBQS9CLIk7DxbcqRHKMsVMx0q7wON0es23Uv+VWGLulEkCtbmZ4Dq+dks
 /2NYCBTysV0mBKrK31YC/S7Jpk5CPvMLcueR5XNN6nWV/gb9FhacknEjVJmITdLQmuRTPedkEDP
 zsCNCJy5DpHTC98H6yeVH37pz3NspWDjX3gJy5BRfrZ+ibR6J3e9HaVME8pbDpuKPS+idpCmCLc
 N7wbZzWhUKzbP5aZd32X5bO5jc0qg=
X-Received: by 2002:a05:600c:c173:b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-485381238b3mr100271365e9.9.1773082694406; 
 Mon, 09 Mar 2026 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c173:b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-485381238b3mr100271015e9.9.1773082693882; 
 Mon, 09 Mar 2026 11:58:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48529f019a4sm85009545e9.12.2026.03.09.11.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 09/10] whpx: arm64: enable enlightenments if asked for
Date: Mon,  9 Mar 2026 19:57:51 +0100
Message-ID: <20260309185752.76865-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
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


