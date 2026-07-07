Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85468C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEW5-0001TD-JU; Tue, 07 Jul 2026 18:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW3-0001SL-EG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW1-0004DL-VJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caf4496889so365395ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464225; x=1784069025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2hHH9KSwA+9uIb01eHUjZNIVZ+Ljwq30s0vXxHn37II=;
 b=vyQ8y5UQJR3URaEUViLga2F6sWbidIqQm/yltzkEW5k8Hid9RXrAq3MwdkgHUY3G2n
 AjgGKG2VjmLGTTcKPj7/I8D/TKUkpOTYiVHzf2ZHvb1iNoUFxkwTYMwRGX5xkrs9x1zx
 7Ddu4lXJ9QfTwOx0N+SrKHcAKhTuAnTz/ZxzLQFOY9zNPlsRI8Tzkyih1sLrxIvhskyb
 D2JrMh1WEO9ZGrIxgDwUTYcHNrJ1ynP+s+eWUshMl4+JdG6yuECgZuO9ussgD+limYdV
 1cs/6BQ/mE7BI+8dIQmDZvUfwkq/qCXUALErU8Dr+NqfzQIONTkXdk1y0yOBma3ZpzZL
 tsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464225; x=1784069025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2hHH9KSwA+9uIb01eHUjZNIVZ+Ljwq30s0vXxHn37II=;
 b=Q1NuMMqPmZhgFZ6mx4uxpli51/4h844K+30kz8keXD6Du9rVsUfWoX+1/9nq8hXgkt
 7TaxyyZeFVu1zyXdxLmJQddAbhzbEJGo/3HkbLU7edHx1rMP0TOT333P5l/UCpWgUjGo
 1mnoon9NVtbK7WXYMyHxf/9kFkJ2oQpMjR4FdbuffbLZR1/zOu40mTba1IiaO3KAvdoz
 3g5cC0ytX1WVkK4gBpSeEGwQeJnLeod7bzM9uEeiicK02jOHBaV9I79whlLbr9rxNf+G
 oNfVCmxx7Wxpmo6Ff5vdUTmqVoKVjMQ/VSNKdtbtTbmZHJ04qz1DSNc/osXfsGvzxcfw
 XSYQ==
X-Gm-Message-State: AOJu0YxcATb1PeQaadceG3IRi6tRP+KxxOduGBQJ7Prd/XzP98VE03Hh
 VNmo9H+ea7a/Pu4uKqcgfTadJylz+XNPTdgA3qJwngyAYhhGNGIVT7GeVjS1wWHK3AAF0dLORG/
 luXQnrOI=
X-Gm-Gg: AfdE7cmR/SkijeAUsfFqLFmU1O2DDVFYEdkg+mc2j6jsqgw08k3ojF2Dijxtf01NS6w
 sH9e9LfLPYFXUuOAsBkwOSYBq+36OkOmukl2nTTfbKW69toEN4h2Bv3N7BuGI1U+O/I/fPuzysH
 ompHv0wU/IpWIo1dEpQi1HiqBZ7vMImuZXIhzrEEhrUPIno2c8+YlItA1NEt/60h4FOhVfd/Fy+
 o1TLD47QbRb+me6dImlgm9Y0ZzgJiOdL+fMrnzWO9LmSyH3El7OUsfQeTEZNPHmrc0tg5SMaJtJ
 xkSV3E2BNtzFv9t3mufDnKkah7r7qpye+2SBshhygJIkb1wDHhrhzESsmUk3XTgdl2uLcCqbcCL
 f5dh8iuoRXg7yd8lYJg9QlMQPOtFh8AkBkkVhoaZwqJialP+ufB+pxuTC0zqS9mFyq0lgQ1hMAH
 hequqJE/aRyGkBT5nLoUTyXS6Dgzx4SkJevqKmXYM=
X-Received: by 2002:a17:902:f788:b0:2ca:f417:396b with SMTP id
 d9443c01a7336-2ccca8c80b8mr42177635ad.3.1783464224666; 
 Tue, 07 Jul 2026 15:43:44 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:44 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 17/25] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Tue,  7 Jul 2026 16:42:58 -0600
Message-ID: <20260707224306.1202330-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x632.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 317816f942de..ac16290b442d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4051,6 +4051,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int rme_vm_type = kvm_arm_rme_vm_type();
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -4080,7 +4081,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | rme_vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0


