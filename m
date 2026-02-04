Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C064EA7946
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjgq-0006ay-BJ; Wed, 04 Feb 2026 15:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgo-0006Yf-0F
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgm-00039R-4b
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so2484845e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237686; x=1770842486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbqtX+s+uDsTeZqUbq/TAntVszz8BdldLp1r/lW4y/Q=;
 b=C1EStjJ/z/kw5xkam73/DKEqQtbc/BAPR0r/9Wplr50nVXymzkGOL8igeNZLw5L1Pd
 uh8SqxzC95mls4Ko3d7wmYV6rRLGP1YvB7uJ8v3dpWAz4tezhnkvWKbA+Chi0x7D9H6R
 2vNCBf/Kn4eJWrieK7vZOuq2arzkcxe7KMSfvyeSwlFAfsUR+F7qor1ijCKYiOpoVar1
 OyiB+dM82+jJOSOs7CQ4cmkrnLGqpWre5JUvzQ69hVzNi5EFXYTHCRGb45FHPOS8SkUo
 kKuRB2ltuaPgipwOBXaN2Uf1FS0VpoC9mG+/1b2KhlBNclLo/jPWZTTjqcDX8nga0YBn
 MPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237686; x=1770842486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cbqtX+s+uDsTeZqUbq/TAntVszz8BdldLp1r/lW4y/Q=;
 b=m5VEDcuwucsFHmNGkDyIqyoKBNlZXs1YPJLDyUuZPh+H645rD4KKWkrFPxPghj9kUA
 xvcnyCq/ToOLDWG5HEuoocHc8DMrBOoA9rkUSYnW4LLqKd5c2AFxLl9pFdy2YtmpOdJO
 dlxiklV87jDsJD0c5pjJAvUSl+jkh7d87W9VjVVmUKlPSRCLmO3I4tf6Zil2+ElrCbmO
 8w5h+/x8OG7cIKk6k9UumpDR34DTbU2g3Q45f+lG49UlQequCa9hHDv3S2SiTaitjsJ4
 LmbFsfAXlMez19TA/TxdyfvVJ+aA6kTblUFaQ8Dqx6eMUbUMz5wjeo8WoX3VIVf+T7ru
 h8ng==
X-Gm-Message-State: AOJu0YwCUc/qaY5MMHjtRUr7huufLn0xf+jWC3P8CxCJoNLhOXqK5LVS
 CdlQSIjejbc5msBlAWSy3DusdBnC+7yLqH9sG4MO1CpSr9DmfO3KFV3a4wFUkft74EFU3lllrLD
 yQm9XwAw=
X-Gm-Gg: AZuq6aKCjOvktGhbVCh+5MMYxJJnRpm/kT3sd5loUTcPqw9B7ooHzjeGu6SnQRNXvKS
 wtzJBDzEq60dGOqsHM+MGxd5XEudIJiHLKTB4Z2suDb2U20hcisiF50m+0pHGIvc1l0tKavntAS
 aaoxpIi9kGFNeiyV61K1BaVm9vw/ovtOkfEGtFmmA7fEb5ImHYc+xf2Pur2eP5w17G1rbGYvUWW
 m4hq8ScJxvLPhASKdXaZHM9bBDABracIlhldf0FiAVS/KuSEup/12M59T2pFNgTTBoV7EQvnmE5
 4MNnQEp+5N6JDLwE3nyU1CGUYJPJtzSloaUNryX2kLrZKQBIgxLNWkYdNg5+M+iA6wuujPPiGKV
 pl0w1A7Fn6lbZYv7pZUMbIQl1THrFqT/EGKzIsgsnILlL6ujPvfv4leM+/1KsRhPHeLAbYmABBi
 EsEewV2V9ybDv4YuxQDYHD5tgGukVkLm7aRIrl0+ezxbXxKAknyw2yLOQwetGbvRrSOPwQgV0=
X-Received: by 2002:a05:600c:8216:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-483179b7338mr7307375e9.11.1770237686102; 
 Wed, 04 Feb 2026 12:41:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d2bab2sm15574315e9.3.2026.02.04.12.41.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 12:41:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/intc/ioapic: Replace legacy st_phys() ->
 address_space_st()
Date: Wed,  4 Feb 2026 21:41:02 +0100
Message-ID: <20260204204103.46343-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204204103.46343-1-philmd@linaro.org>
References: <20260204204103.46343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault. However the
IOAPIC datasheet (82093AA Order Number: 290566-001) doesn't
mention any fault occuring when the system bus (ISA bus) is
accessed. The ISA bus neither offer a way to signal recoverable
access faults. Therefore just inline the stl_le_phys() call,
not specifying any memory transaction attribute nor expecting
transation result, per the definition in
"system/memory_ldst_phys_endian.h.inc":

  42 static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
  43 {
  44     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
  45 }

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/ioapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 87ca1af5421..1b3f1e824ac 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -141,7 +141,8 @@ static void ioapic_service(IOAPICCommonState *s)
                  * the IOAPIC message into a MSI one, and its
                  * address space will decide whether we need a
                  * translation. */
-                stl_le_phys(ioapic_as, info.addr, info.data);
+                address_space_stl_le(ioapic_as, info.addr, info.data,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
             }
         }
     }
-- 
2.52.0


