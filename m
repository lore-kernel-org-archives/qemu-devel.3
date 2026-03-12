Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEBA105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drN-0003zd-Fr; Thu, 12 Mar 2026 07:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr2-0003oO-Bc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr0-0000UB-Ga
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ns7nAFDx16yUvmF889rvuXTaNynrdAeH9jPODkUVorg=;
 b=XuSJo1MOxQ4bb0xgdfmpQGzl0Npt305bpQdZV9pdJEBNYQlRZ6zQ7hFKaCGyKDpZBiNIBE
 tEPRMLXUo8DUP/6NeLQDLt0BZ8jxMbClrfuN4kLepH4HF5xhKPpDSEP0j5ioWjdPZ6N5eO
 Sz/x0hq9Zj9JnC4OZQesXOC6o2fRVZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-jJLcRrjrOu-KIReDLeaorQ-1; Thu, 12 Mar 2026 07:05:16 -0400
X-MC-Unique: jJLcRrjrOu-KIReDLeaorQ-1
X-Mimecast-MFC-AGG-ID: jJLcRrjrOu-KIReDLeaorQ_1773313516
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485350666bfso6974435e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313515; x=1773918315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns7nAFDx16yUvmF889rvuXTaNynrdAeH9jPODkUVorg=;
 b=lPfBnxxYDIvktRo8LEmnNNfAg3lGGQ/GztsdBgvviBkhhhWS7tdFZP0ufj2KBUb5Hs
 xhEA6y07vRlnDbzThEI66gVdetyMp3zs7lrSC4bdjSHHLqR9KCqp3iIHswlvHxhBHaI6
 e/rFozHfyZN00EnRYVk2rrQ3dTjs2ItsslzfyDWEWevrAmayDZpo3sHCQ5bh15ug6Rcu
 z8+JkPqsfHUXWQIDoHqeiVJEsiiPpu9HNI47mVB+YrCo7k+7u/KV7YsKlJ1d4Q844NB1
 3qwwOL3AilldbvFQF5JT5RMtj0MlYGd+lYoh/Z28eQih32agCUSAUjBOevjBmpVAr1x1
 0USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313515; x=1773918315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ns7nAFDx16yUvmF889rvuXTaNynrdAeH9jPODkUVorg=;
 b=POI3q2KFTm0BDmx4O6vmqmbA+LlJb3uKPEPl2pXYLpnhKYPGrSZGKMs2hbHWXCXcjw
 GOWTYmNHWPXFVnMHzoQTckuxPzbwlmYOYGUL8re3LQq4lMbEz0x7HeJurYbw6lT7zzcu
 RJ91DHXttjRlPcjwYNlP+1piKXIX148bChePkZXAoxHXYhgTyAzhbfl1ksqXGt3nYl4D
 6j0TLnxGew1t8G6vYyNFqPLCxy1E4uUM5ExvVRbfsGBcokO0nFczD2h+FT4FKhiTPTBQ
 7Cfx+aJ3VFdGz0jsRe7sM4Q1NU8JDFqSaRdMYa56dXe6YKe626ETk1Vc3Xq14zV1qimD
 /dHg==
X-Gm-Message-State: AOJu0Yw7ZiQaAyPRu1GltmZKirwiUfRrR2dSiydgI0+W4r2NK9F4YZCG
 OLiWrxtO3rHAaFmxJbSnURtrWoNky5Hu+Ob9NzziQiWGhVZIaB/EVV0bZJvrCmh6pU05iWUQYA3
 EPawdqZRIhSVX3DIp47xZ1Wu1LE5+iMtzNgK75/FaUGoAXL+sCLWnFHreA6HWxW6MAdvjpNTKA1
 D1gPZH3KkZB4oqDMtlj90uVPT33ilS9Fs6kMcPCyuM
X-Gm-Gg: ATEYQzwa0czG+gLAzqHXBFPcZNrwAdM52E54IbSIykl9JgYHaErGDwiNuWaG+N0slQp
 W9soTx5vpuIsW87ks60muiG7j5CdvLrZa8nz9gM312zYccxiVI3RvEdLCw7Osf4JSPX+hnd/9zQ
 qIaHYx7i4OGIq4Wk3lo42gLA1Pb1dmQRkcG1Na7K4Ne1TGJj6BITRdsAbTNRX4ND9GiFynYVhKp
 a39Rf+uJCQVFodfxhdybzwchSX5ZtqsPVcX+P/8m4XVju1yUXO6zQACY9f6RpWeEqM+qbrmL7jo
 MrzrNA35lWkf06piNfr0/9XQFcnpieQLDUYKCGKg5DZLqFTecHn1uuA40zp9m5OeDtVioPS8uEs
 GTl4VNW5yxYQYQoazUT7RVCc3u9INkHRKZBbUumPEQYO8dJm/xNjvR3l37+1v3pkkr2W4WX3XQx
 +2Y++iovxmEEnKzm2TRioG/RkTCuI=
X-Received: by 2002:a05:600c:4fd5:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-4854b0c7f6dmr95470745e9.13.1773313514826; 
 Thu, 12 Mar 2026 04:05:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd5:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-4854b0c7f6dmr95470065e9.13.1773313514291; 
 Thu, 12 Mar 2026 04:05:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e912fsm313965155e9.2.2026.03.12.04.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] accel/kvm: fix typo in variable name
Date: Thu, 12 Mar 2026 12:04:40 +0100
Message-ID: <20260312110451.685161-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alyssa Ross <hi@alyssa.is>

Fixes: 94a8d39afd ("kvm: Consolidate must-have capability checks")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260311095315.25013-1-hi@alyssa.is
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 984db977795..774499d34f8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,7 +111,7 @@ static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
-static const KVMCapabilityInfo kvm_required_capabilites[] = {
+static const KVMCapabilityInfo kvm_required_capabilities[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
@@ -2992,7 +2992,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         nc++;
     }
 
-    missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
+    missing_cap = kvm_check_extension_list(s, kvm_required_capabilities);
     if (!missing_cap) {
         missing_cap =
             kvm_check_extension_list(s, kvm_arch_required_capabilities);
-- 
2.53.0


