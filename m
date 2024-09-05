Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F08CCD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC79-0001oi-Ku; Thu, 05 Sep 2024 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC71-0001Ic-AV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6x-0001mt-Jf
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42c79deb7c4so5916365e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541278; x=1726146078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pTJYExxOYFHS9qVhAz/vysSNcJs4aSX7vL8lE2uSNrc=;
 b=mNLPg7GtXbHl0thyX+yt8BZaHrYSv77ueENoqemwcDCThqbNDXiPt9YP9M3EgCNNLC
 JJLAEiH0PVsERJBBKQCUcfex7UCKoZ2OQB+aRbgksfZqSlgVjUygSE13KLxEEvotbmP2
 hnqbnRWoxQaY0h5yDCTeo9VBdbFqNPThxAJoVZFtfkWYnQrb2vvirviPfNVUIsSuI90H
 3u0RO2yZD2It8XJIcIWAgaJXGbNTwz6T2Y3LcMcfaFs76IIbVhTf+luPvNsnYlGT7RhY
 EkxZwuU3+WP3B90MGKFZG5ipVEFJBctqVwscBl/Ry3pXd9SY44KPguYTlZ30+1CoFNjF
 U0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541278; x=1726146078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTJYExxOYFHS9qVhAz/vysSNcJs4aSX7vL8lE2uSNrc=;
 b=vTYY8YB5p8Vead8lzRRZl2+U74mZLZ0kKE1A7FR2XJHCVm9l8votHj0kXHYQDinEOW
 HlSDw/DsDfaKFgWMO/EsJTKUC8vHzVRCeL89gZVnB+MrCWR77FNRDOhrr2YDazKUv2ru
 QootsYaCGB2kygwg9Fpk/w9/iGlvw0sqM7SzOHiWw1MKN1CjpN1f9PsC0o0XMYW5f6O8
 yPsgG+p0jzKi4LP5TyWqh/YkLjtB3omC7XJD6e+0EiaYA3dLgNNMPW0IWqGLyFF9MSFs
 AQcXOkVjZMp5so12GhBWNd8+EufGpFPygvc9dQCy6kf3hhQqi/D3F1YZEeWVmF/hFDcr
 VSVA==
X-Gm-Message-State: AOJu0YzKGrdo1nM9pyW2t6NQ/50D2LnW+RTO1nWTF8LHhqxq6ysxNV3T
 3syJl1NumiglYUwwcmAbWExVUXkinCG2QpFkv27p3MNAQCFs0y5sRj1VBNScZUqC3H0nRv037Gx
 +
X-Google-Smtp-Source: AGHT+IHeab5UdpNvVy45ZmZB9liQFJIg9m2r80b3j5PFux13YAuVtjpcu72Q6otTqVFiBnp0vtSQ6Q==
X-Received: by 2002:a05:600c:1e85:b0:426:51ce:bb14 with SMTP id
 5b1f17b1804b1-42c7b5d8f29mr110960935e9.30.1725541277408; 
 Thu, 05 Sep 2024 06:01:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/25] hw/arm/xilinx_zynq: Enable Security Extensions
Date: Thu,  5 Sep 2024 14:00:57 +0100
Message-Id: <20240905130100.298768-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

The system supports the Security Extensions (core and GIC).  This change is
necessary to run tests which pass on the real hardware.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20240828005019.57705-1-sebastian.huber@embedded-brains.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3c56b9abe1c..37c234f5aba 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -219,14 +219,6 @@ static void zynq_init(MachineState *machine)
     for (n = 0; n < smp_cpus; n++) {
         Object *cpuobj = object_new(machine->cpu_type);
 
-        /*
-         * By default A9 CPUs have EL3 enabled.  This board does not currently
-         * support EL3 so the CPU EL3 property is disabled before realization.
-         */
-        if (object_property_find(cpuobj, "has_el3")) {
-            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
-        }
-
         object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
                                 &error_fatal);
         object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
-- 
2.34.1


