Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9152C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFJc-00021V-Kj; Mon, 18 Mar 2024 11:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmFJU-0001xF-Bc
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmFJP-0000Ww-Lm
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igcS/L5aoSdp/RqRXlSQ8qbrsN0mnzGNEZrfapLAc0g=;
 b=ipfQ4M8OB39in3vyw34jV4I64A6t9yN/TesJo19fPCGq4K4/f3sNDLf3+KwcnSlMIs9Mdr
 Rbv7Tcb9bywxx96PJ8+n5lxTdHUbD+VOJCHEKwf2lFdZ/HMTXuspflBETBmcfNJcrkwggE
 GCA7kN58B9feticCMZME3jxndIrKZxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-9gElzMerPqaRuWegFa0OUg-1; Mon, 18 Mar 2024 11:54:03 -0400
X-MC-Unique: 9gElzMerPqaRuWegFa0OUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AB55101A56C;
 Mon, 18 Mar 2024 15:54:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E4C03C20;
 Mon, 18 Mar 2024 15:54:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A32E31800D61; Mon, 18 Mar 2024 16:53:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 2/2] target/i386: add guest-phys-bits cpu property
Date: Mon, 18 Mar 2024 16:53:36 +0100
Message-ID: <20240318155336.156197-3-kraxel@redhat.com>
In-Reply-To: <20240318155336.156197-1-kraxel@redhat.com>
References: <20240318155336.156197-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Allows to set guest-phys-bits (cpuid leaf 80000008, eax[23:16])
via -cpu $model,guest-phys-bits=$nr.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c88c895a5b3e..e0d73b6ec654 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7380,6 +7380,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         if (cpu->phys_bits == 0) {
             cpu->phys_bits = TCG_PHYS_ADDR_BITS;
         }
+        if (cpu->guest_phys_bits &&
+            (cpu->guest_phys_bits > cpu->phys_bits ||
+            cpu->guest_phys_bits < 32)) {
+            error_setg(errp, "guest-phys-bits should be between 32 and %u "
+                             " (but is %u)",
+                             cpu->phys_bits, cpu->guest_phys_bits);
+            return;
+        }
     } else {
         /* For 32 bit systems don't use the user set value, but keep
          * phys_bits consistent with what we tell the guest.
@@ -7388,6 +7396,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(errp, "phys-bits is not user-configurable in 32 bit");
             return;
         }
+        if (cpu->guest_phys_bits != 0) {
+            error_setg(errp, "guest-phys-bits is not user-configurable in 32 bit");
+            return;
+        }
 
         if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
             cpu->phys_bits = 36;
@@ -7888,6 +7900,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
+    DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, 0),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
     DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
-- 
2.44.0


