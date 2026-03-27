Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFF110F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6E5K-00038q-P8; Fri, 27 Mar 2026 16:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6E5I-00038P-TJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 16:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6E5H-0001my-9j
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 16:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774644429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nQN6BGEz2uMzaWLtnDgvxzEtfd2FYHTGxTkLOU4YzLs=;
 b=HWlbBKjpjxeQbNAbIo4mPlr7K3G9Ig9khtDony5MjNcYFVTufjDPeRvnOPX7Kk1/P9eDFy
 tMEQSAR53NL8+z8vOgIKmIOvB/WFyFk8iIIh1nD9/ww8uu2rsX10jsaHKDaj/moe7qvFIq
 8D4VI91cazosiqMaO90yTkdxlg2wsBg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-jJWs1YiOPBS4XRDw2wIXMA-1; Fri, 27 Mar 2026 16:47:08 -0400
X-MC-Unique: jJWs1YiOPBS4XRDw2wIXMA-1
X-Mimecast-MFC-AGG-ID: jJWs1YiOPBS4XRDw2wIXMA_1774644427
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439cbfcfc21so2195226f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774644426; x=1775249226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nQN6BGEz2uMzaWLtnDgvxzEtfd2FYHTGxTkLOU4YzLs=;
 b=jYZII2Z/4DCflq5XYfCFxWdXzgQxKJ35n5CXnLfns3AsF61TtGq2JY8pMbNEXT63YH
 23vZ7hLMGy/eCMBSSjQuJfHGbCMXj7DbvaI5k87qB+r8VNAbXjTWFfOtjAUWX7+S/YO1
 5CTcFu3mRgPJp4r7hKtSO4kt1tubRvAaqEYWcTU5YLrsskrYjjyUSdT+4R3lB3dPWJSI
 QaByVCfdAD63VU6poFrhFpxZa9DIFW/EVlgaWtsOpyHVzMFImHCrkKuyH7ihSWoZPpDm
 Sqy3n9S6yXVozqqqPEYvxSsZDtFEIUcb2h5g84mpU4EDZSlvV4JzWnjRpwhmfO2i2GvG
 nPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774644426; x=1775249226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQN6BGEz2uMzaWLtnDgvxzEtfd2FYHTGxTkLOU4YzLs=;
 b=ROIaDAXvH4MrfJiNBuHCiZh2f4+1HFgaqOgJgKg5XE6Q+8j6UAm4jcnNvPqcaSW3+q
 Pt0UMf5rl5i8t6mT3RAGszvDjVGAG99WuLhWwpveHW4kyQfbUn+SZWrJ20nwJuHjz6dZ
 tE+l4WpM5lSrbZwDV2XzBgLjx3MWU6Y6SzaYoNDrlH0A5No7wuAv0D6Do1nTO337i6bB
 g07NAJLWAMIIyYp98EWmQ41BUSZEQDjuXGmBP42Lgo7I/WimfCKiMOHubYLgNyWG2RDs
 jKIl4HnQX6SWco3an1vhve1KhDnnDkDZnCmno+Ata3NDm9R4p1H+ssUfMo9ZeyUK3yaU
 HCcw==
X-Gm-Message-State: AOJu0YzXhFuh33Jigtv8kXCa9XGuo8yUElzBTNsqHjIjRg+kCmgJXzmB
 f1/eMUXuvW/8JV1BxpPEpkZjtBXRuvNTVyVBNr60jP1Y+H5KNZt4M7NQAQ3eH+iJbCgHnmK1Wiv
 viyzjKo7g8i0i/Vd8iqaONsEKwIFxJbFj/ac+WRSCOLsEY6LLiakxcSmA5j3xRpwktDxi29FSih
 /zga3dPFAjD3886eoHIJTLL5fZC/ibR3HAEVmDia9/
X-Gm-Gg: ATEYQzwlE33/qyIKcxjX3XAiJViJWFepBUzrjXOLqecRlVF/z7OKNI2UaajU14JbsNa
 Cv8F5CpygzpmT+kV+mWQp6mvQyutIcDGt6oauY2RMJsigeU4KGqUEsJFFOapEK47bzvJTP3SKkX
 hoIHEZP4pmIGFwWPkZPaFT97oslx1BkRRidixDFDxDUgNYk4XKHWPjjaft+CX+xZXGWY8chycaG
 BhuvMnfwnC1G0KRVX99dDq3362+e2WND9cQbFh3P40+urHny7+ITtGzAIPm8aoVFNlpR3yeOrUt
 kH3Rv0GF2XPILlv6Gcw+3PEu6P6NNGRuAagaFI+JVEAxErPvoGKnNxgC+GgTDrM/W0jzweVpAua
 OSIkG/R7JnP//BDviPv9q6SIlSy423W7/5NoWXlVXmYCfpJ/828GX1gtgRq1s7aSitRCMjP1QcB
 /kmz5C29ax8CxUZdxrs8eePhRX
X-Received: by 2002:a5d:5f45:0:b0:439:b3c5:ea1f with SMTP id
 ffacd0b85a97d-43b9e997916mr6907991f8f.16.1774644426207; 
 Fri, 27 Mar 2026 13:47:06 -0700 (PDT)
X-Received: by 2002:a5d:5f45:0:b0:439:b3c5:ea1f with SMTP id
 ffacd0b85a97d-43b9e997916mr6907956f8f.16.1774644425623; 
 Fri, 27 Mar 2026 13:47:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2580168sm516219f8f.36.2026.03.27.13.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:47:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] hpet: lower HPET_MAX_TIMERS to 24
Date: Fri, 27 Mar 2026 21:47:04 +0100
Message-ID: <20260327204704.424158-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Each timer block occupies 32 bytes, but they only start at
offset 256 of the 1024-byte MMIO register space.  Therefore
the correct limit for HPET_MAX_TIMERS is 24, not 32.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/timer/hpet.h          | 2 +-
 rust/hw/timer/hpet/src/device.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index c2656f7f0be..84be4c3529a 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -22,7 +22,7 @@
 
 #define FS_PER_NS 1000000       /* 1000000 femtoseconds == 1 ns */
 #define HPET_MIN_TIMERS         3
-#define HPET_MAX_TIMERS         32
+#define HPET_MAX_TIMERS         24
 
 #define HPET_NUM_IRQ_ROUTES     32
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 0a5c131819b..ec0bca4496d 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -32,7 +32,7 @@
 /// Minimum recommended hardware implementation.
 const HPET_MIN_TIMERS: usize = 3;
 /// Maximum timers in each timer block.
-const HPET_MAX_TIMERS: usize = 32;
+const HPET_MAX_TIMERS: usize = 24;
 
 /// Flags that HPETState.flags supports.
 const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
-- 
2.53.0


