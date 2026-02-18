Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118A4E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxr-0003Io-8U; Wed, 18 Feb 2026 06:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxh-0003Eq-SG
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxf-0007rH-TJ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
 b=D5hUUWtXex1yJMWdoReGFHgYQ/1jnLiIRmkWeUwHtd/zhN1Rykh5pnWIdT5AmuFQlUXxFX
 h/4fSqXAKNpmBMXsjsSyFjPlCzoGX8AYDADR/DJ24HS75kyRAOjSNKg+Hk8kz7MxHjaVDz
 ksGVGLMSLhWTZglUvwGtAb/NcfHXBa0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-vSYj64RdP_WUg36E9ONRCQ-1; Wed, 18 Feb 2026 06:43:18 -0500
X-MC-Unique: vSYj64RdP_WUg36E9ONRCQ-1
X-Mimecast-MFC-AGG-ID: vSYj64RdP_WUg36E9ONRCQ_1771414997
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a946c0e441so53227545ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414997; x=1772019797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
 b=thrjL4vYXH6V71h4kPNTd1NSi4uvGzLmzhWKK2TXhbdUm49QalHfOKq1Qi3k3fiRNn
 GN8MMLN5DyM8tfw3NRI0MaFLUrZ9Oq53j1D6eMfi/SB8Oc+UjrIHZYA7XryedhavLOl0
 NspkTJAyu0XZdaCMOWxkDh1CDkh+ThXiomQ9uH28ZfM2dFaAznXnSTfUzxbMsfA/IOGD
 fHJwZyJBnyhsKmM0pe9bRlfYmT+hl5z9EVP5p/Uz7X6lLbCJojJ8KRIF+z3QYUz9IytF
 bXaEml3yRbODuUf7rX3XGBLXX+Z9convaGwvHmD1aeaQkyHZPzXqnmiG5YR2XZpdVGri
 IiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414997; x=1772019797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
 b=qc1dKQWN4Gr3FS5EGg897TNU6TmcUFyJsDDZEjYGZv1SiDpk1dBRQEzwEFkg2Ivzq+
 BAvr9jTl4Ude7U50+URkBZ9mlRGD+D6i/Zp8Qj/CQIAwUBu8cvt2gRT70IxiX6LpSgVw
 AMTq0BwlImkcviwu6jxBIuJm2Oh6l4/jHk8ghFiK9os56zQV056HdfWpraJyo/9swUAO
 trjwfxUaJRGKXVIiH+8K6pSLAheeTMRpv8ZJVeGTpmBn/LQz7DIIgvAmTND24uybZLlA
 Y9cUfhe5hNTyqGkOSEaqplGJYBT30/3piSpIpPpT/oa522UjKrZtThaJMrFdoZ/i3cBZ
 YFJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWrfKgyrR70D7Z9U1UnZBCOqS/6k96z+MzTk/IjzuMlxuLVy/GS3s/Mre72WhERt5x7V7Zq4WfAZr@nongnu.org
X-Gm-Message-State: AOJu0Yzo6SS0vcMuIHJqK73ZY47n5sxqtEqlSO4MaysKwZKn2HEP6gyI
 ctjMT0nE/9nukKkvsAURR0aX4ktPFemw3bUmD710cUzy3vgE05bAfOV3JOe7is9U0XRa/7NhekU
 nJEa6u7pVItGIanAwD4sGqDSA+NUGg6vfPjEFu/qd3IAeZyzs70Ih6tav
X-Gm-Gg: AZuq6aLpmqAEN9jIcjcf7Eg4hOIEhcT1ipEFOExQ0B5w8OwP8ZmTYV6lBBVRguVDAY9
 YfMR2ZQAoIrDEm2/GXPFMyoPQKp1a8wYzNBPUqZjVJDljammWyx1Y9Ave1GHkbZON/9o7PUFlH3
 +LwhFuRnXYqlay0pa9clAqnpqE/U0ZSugAwmzBMtsgqPVpg9S+seiPTSvqEo/vthJLUVAaWnk9K
 J3sHQGtA5cEWbx//VuhzP4cGZZGS6zd+FULcGWzCyJiDHP2koK17gYX0QKQ1Kv/BN3zPTnxPkus
 O5WgPNDPsB1TVhPpVNL2vpDaOk/1ETwrmW5AfNB6MTUNmKu8R7uejUvQvAzHoF5dNzv7p1Y4hW9
 NpsphEofXED4jQtyY3wcPh59N46ohmJKuXHC+Qbe1BReFG5m21NqA
X-Received: by 2002:a17:902:d50a:b0:2a9:cb10:42d with SMTP id
 d9443c01a7336-2ad51004771mr16038185ad.61.1771414996581; 
 Wed, 18 Feb 2026 03:43:16 -0800 (PST)
X-Received: by 2002:a17:902:d50a:b0:2a9:cb10:42d with SMTP id
 d9443c01a7336-2ad51004771mr16037995ad.61.1771414996169; 
 Wed, 18 Feb 2026 03:43:16 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 10/34] i386/kvm: refactor xen init into a new function
Date: Wed, 18 Feb 2026 17:12:03 +0530
Message-ID: <20260218114233.266178-11-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cosmetic - no new functionality added. Xen initialisation code is refactored
into its own function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8679e7d3fa..feb3f3cf3c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3433,6 +3433,24 @@ bool kvm_arch_supports_vmfd_change(void)
     return true;
 }
 
+static int xen_init(MachineState *ms, KVMState *s)
+{
+#ifdef CONFIG_XEN_EMU
+    int ret = 0;
+    if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
+        error_report("kvm: Xen support only available in PC machine");
+        return -ENOTSUP;
+    }
+    /* hyperv_enabled() doesn't work yet. */
+    uint32_t msr = XEN_HYPERCALL_MSR;
+    ret = kvm_xen_init(s, msr);
+    return ret;
+#else
+    error_report("kvm: Xen support not enabled in qemu");
+    return -ENOTSUP;
+#endif
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3467,21 +3485,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (s->xen_version) {
-#ifdef CONFIG_XEN_EMU
-        if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
-            error_report("kvm: Xen support only available in PC machine");
-            return -ENOTSUP;
-        }
-        /* hyperv_enabled() doesn't work yet. */
-        uint32_t msr = XEN_HYPERCALL_MSR;
-        ret = kvm_xen_init(s, msr);
+        ret = xen_init(ms, s);
         if (ret < 0) {
             return ret;
         }
-#else
-        error_report("kvm: Xen support not enabled in qemu");
-        return -ENOTSUP;
-#endif
     }
 
     ret = kvm_get_supported_msrs(s);
-- 
2.42.0


