Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49B0C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR6c-0004YJ-VB; Wed, 08 Jul 2026 08:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6a-0004W7-3G
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6Y-0005pf-A7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493ba701891so4230035e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783512617; x=1784117417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H3syJG05K/noDigcZ23muuOk703OZjKc29wGEoKgFAo=;
 b=fxZab+iTdHx/vi1Vcex3gJWNMg8zHbc96G89fXKwxbE5NFcXwpH4qB8Wznhh1xeYFc
 69O93Btj3YAOPIuIBMnk+JmIewCAFiHnL8rVf0DLnX3DAUzNrZAPktcf3nSWVIpprB+D
 vR/aVL5cV8oQFdDqwJuHbrCmAaqeYa4+ct21PcnBoM/+7T+4EOy5rchDjkKt3ytWRPhz
 Px8p37kv6fVr7Qfgp/NFqCWR1oYswQWluwodoyh/BZ8bkvvKyiojJK/W/itT0su8DiXI
 N5VUTIWMLaa1L6rF/ErIH7wAnJTDvVv5CVudrfmhkxPp/LqidUt1r4eEZY/rMpiWt1lj
 JN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512617; x=1784117417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H3syJG05K/noDigcZ23muuOk703OZjKc29wGEoKgFAo=;
 b=jQhWvje2g+TA8d2ct+ptGelXJf15o6opFJudq9JiHnSESGaVJcs4m6ce4waMfKAptN
 mvjFvvV2bVR/ugnVvdxvWvJpM+tOOIKkC7NMh5ZYjOC3RyGnpNbk2ZKG2XMO2pZLzMPS
 ZLV01eNGoMXA0NOlg304NzfHU2lUGInveXbEqYN4tc7IYya2EyehUylq7j4s5CfD6lyA
 oZ96/2tE8WzjLEsJiIE6/XRwRnksq1n9z7TLXRvKUXD3ZUT/epTWlauy+iRIRu4n7JQ+
 vkwDMAb0y9XECdqJ7NDJn8OLI7UIi49jAk2SjRpdUjUZPByELtbuc4Ix1Zjg0b4yn89C
 meyg==
X-Gm-Message-State: AOJu0YwDGY6VR8fNskRWZX3f3SBNXDPTZaQhhhLVuCPhIcHGMspdysNA
 x+89TFh+7L0LiX7t1EXw19+vcD/XHaPyEdf9HSqdvKrZm3hWXMNpN8f0YCMWaObjIAarSsdfj6G
 BC5PkPh3myQ==
X-Gm-Gg: AfdE7clpS4H7gfDWjtz/1XUaxjbiXd/ALDG/yzgQR9LGeINOzL72N+jF6FvXSPcf7ri
 /aGuNBozkviLFBU3qU53+OC5PM0Mg7/2/0bBYGTUikgxbvhb7LT1URhzKu4rjW0F8aRuNdSU4lw
 rIx16Nnsoig6bc7yzfJqQfUNnxaGY5Hvpe/3hycX4z96y5PMZMwCQOOQvaJdy6ydPTvJ5qYaQEc
 A+SCLW+1qinYcvOn1WjDq98Oig2tgAa3RBo1LmwHOEFRYNOFNKpNqmQPlJmRZ4zEDfinl+/2ey/
 pGe8zeO99rwJ1qmZ/X6YcJHTT/wYAl9//BrezMuhGzMixEPQ48k89IqfVSbz1mdly5McYiN8tMW
 npBpN4OCH6RFFX0bZcyEjefLoki1HUmX2lh0nAmXJxzKInFVUnzCVo6Wz8/hkOHitxuOPc0EvpX
 vwrA13CfBHdEpLUdOsfih6I5Fm/CLZe/mqlpf4D3Mj/Qph1Tda5n/ZwBFqPTzBIwWFvoOcCvA/l
 uuCDSbMT2MMgB5CN0Enlw==
X-Received: by 2002:a05:600c:8a17:10b0:492:4723:166b with SMTP id
 5b1f17b1804b1-493e689a70dmr17138695e9.13.1783512616674; 
 Wed, 08 Jul 2026 05:10:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm43386298f8f.11.2026.07.08.05.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:10:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH 3/3] hw/pci-host/q35.c: Avoid early return in
 mch_write_config()
Date: Wed,  8 Jul 2026 13:10:11 +0100
Message-ID: <20260708121011.1653365-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708121011.1653365-1-peter.maydell@linaro.org>
References: <20260708121011.1653365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In mch_write_config() we return early if has_smm_ranges is false.
This is slightly bug-prone because it leaves the door open to somebody
later adding non-SMM-specific code at the bottom of the function.

This case isn't as bad as the one in realize, because the function is
a lot shorter.  But putting the handling of the three SMM specific
ranges into an if() rather than having an early return seems better.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/q35.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e42b84b978..f4556ad03a 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -485,22 +485,20 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
+    if (mch->has_smm_ranges) {
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
+                           MCH_HOST_BRIDGE_SMRAM_SIZE)) {
+            mch_update_smram(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
-                       MCH_HOST_BRIDGE_SMRAM_SIZE)) {
-        mch_update_smram(mch);
-    }
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                           MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
+            mch_update_ext_tseg_mbytes(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
-        mch_update_ext_tseg_mbytes(mch);
-    }
-
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
-        mch_update_smbase_smram(mch);
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
+            mch_update_smbase_smram(mch);
+        }
     }
 }
 
-- 
2.43.0


