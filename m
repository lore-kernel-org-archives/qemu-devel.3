Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE93DFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV8s-0002uU-6T; Thu, 30 Apr 2026 13:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8J-0001yK-W4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8F-00051L-LC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tukUn/CkUSmS6DZF76bFAxY2JN9E7D6roxGBARASY3g=;
 b=Lq/gnsBJhw/A+/vbk5P78gbya+XP/faT7sfjxjsheL+vUZB7N6LY/yjuyEy4Q+h7yhQJCh
 zhFGv7EAvMao50pXriSNxEnFMaldNdAVA+sT5VgHaUJSJM6QpjCwhr1USxdXAKnwJIDhFx
 ihx2SNdhalgHjwbwacJjdO0B3FWTMFA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-yM7eZ6U-MXqx9HwhXz0Z_w-1; Thu, 30 Apr 2026 13:24:55 -0400
X-MC-Unique: yM7eZ6U-MXqx9HwhXz0Z_w-1
X-Mimecast-MFC-AGG-ID: yM7eZ6U-MXqx9HwhXz0Z_w_1777569895
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-612d26038fbso1879836137.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569894; x=1778174694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tukUn/CkUSmS6DZF76bFAxY2JN9E7D6roxGBARASY3g=;
 b=GLItv5ZCuWE4nm5qT0BQ4ZB8nREExiKYfdKX2VsH7XbF0IaAe45fik74HM9YHHPE8g
 g0sgGW/nwEIaWt85rPeLUIGgwixbi2dJj2mAUltgki4oqbG92mjZX8HWa0wck0D+qZP9
 UmAkfMYnPW2h5zmvXnkmc9JrJjhkS+BXJIucA9BLbYEKpxBbNsMR1MSKb2yZ2N7Ws8Tw
 k4G1CvON94p19hgd2VJg9HyHluji2+jyVzbbjmxJ2G/3rn3GupQEf5r26fsGIXdlkcZb
 bjB0Z2kHo0FfYxatemVP113Rn/gIGvNvciU5ocYQzzyhVn9b/qHvmT9ZfjkfzhAkjaOW
 yzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569894; x=1778174694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tukUn/CkUSmS6DZF76bFAxY2JN9E7D6roxGBARASY3g=;
 b=rER2QC8nbZEb+ynMgqW07MZYl5ulY+/duwY+FY30GydqHoRMKTWwfF7vggBH7EPCSJ
 kBRW2bsxW7TWqcL2d1DD6zDC2z1sm1EFuhJYoJw0+yvQoNWPKZZcZFB7dL5eRKcGOeq8
 YkzKL1zEDBnzuxuVCdHSNaq+uxFvFcqOBZguQKy3q29Wvk+JnQJzxs8bFkChPiAiat7j
 oIq5OPovJv7Fre14vgsUF/kJ58rxOlcIJM5Tb4d7ZbQcIx/IGGrQdZ7g4yUV9E5usRjt
 tkakMs51zh6Gga62t1SPQ9Fs3VYTG360A7FYF0m2HOuRKhiOr/Cg4ABsUYR3N4bokXnX
 TU7w==
X-Gm-Message-State: AOJu0Yzs1ddhrLMHt4jPT14e8DUz3DVStq9t4tZWPo91adWToxkEDpfS
 LOA6RWbFVUIzs5/OWP9ucO4nDucohEkr7BpMyoWyl5YA2rWqzBoxsG5fL5AajMCVddV4THiEZ59
 /cXy7figVr3cc6ekla8ZCEfm1FwEdhTSkMpYw0V0Crt1vGkI2RHXKiJRVsZfhNFvJZHJ8jvxx4Z
 sj1mzyGbqwx3sE7MaNuWL1rMxI2gaKI3+50L363dYH
X-Gm-Gg: AeBDietl6NFum40S+ORkXAnqKqumuYr+rXC0NyH5t46zQWzHwMbrKRf4jCQArGIinSL
 PU86VOPddJikbBxXA5xJ38Nk9uiuH/CIlEcAQ9atjOhvRXlR78h7EUxdViYpCu2Ww8rjGGPNOEr
 JjjlPGIDVcIvQ2t08cysEJCuLpP8QdIk4Qy7w6Wz4LrMsXPa1KB3FkJiV0dkvXRXOEYCg4zG/xQ
 11zc+u0u2TCsxPUoQ3VFwgxb6a/zlizPgO6OUHRUnSXfMzJzu/7r8LOd5S2QXdGv9PZmal/So0g
 kZg7ksHn7XGtc+8fAZmsJO13oFzZRMUJCgc3/g5/mq6Is1CQVuO42Lyv4lKIymp028v/ldPzUJJ
 uDMnWly20ds/l3T/MUrfTOxW4SP+T67vOl73inVd8LY9HxTHZvPCgRP5ZgpPuSUgNfmAwoI7372
 3D+b0LakzuePO8KA9GJmcdNsZNUmoR/MnwF7A=
X-Received: by 2002:a05:6102:919:b0:604:f155:9374 with SMTP id
 ada2fe7eead31-62ad3f5e7fbmr2898059137.15.1777569894578; 
 Thu, 30 Apr 2026 10:24:54 -0700 (PDT)
X-Received: by 2002:a05:6102:919:b0:604:f155:9374 with SMTP id
 ada2fe7eead31-62ad3f5e7fbmr2897983137.15.1777569893583; 
 Thu, 30 Apr 2026 10:24:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff43b896sm23106916d6.25.2026.04.30.10.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 54/58] whpx: i386: set APIC ID only when APIC present
Date: Thu, 30 Apr 2026 19:22:00 +0200
Message-ID: <20260430172204.1006673-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

-M isapc doesn't have an APIC

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-31-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 717d47f9cce..ce04d6b06f9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2643,7 +2643,7 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
-    if (!whpx_irqchip_in_kernel()) {
+    if (!whpx_irqchip_in_kernel() && x86_cpu->apic_state != NULL) {
         WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
         whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
     }
-- 
2.54.0


