Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C5DC54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV6W-00055g-Iq; Tue, 05 Mar 2024 08:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV5n-0004F5-Rp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:44:29 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV5m-0004IW-1V
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:44:27 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so3678951f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646264; x=1710251064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi5x0OedtFiXYvl8cpQZIwBhtQ9Cn2QNkroxyToz+PA=;
 b=ovOXZhSojUVL7f/nmL4H7vG7WdNZKQUGL3G08M922lVyQzRB8lo41ss1vr5bxXdWh6
 O33Q6epATFlWD/BUuY1PpGF/Sdj0WEAQBjUm9Ga/yJ+qQkrEG6qvBnHtd5LdtRI0/erR
 2njraWTmFey4oS6fyR1IY1KbTg7WKwwzBduK3wowe0S5YR/7kndZpicdMV1M6ByZjJWb
 vap9pWW6NkghkY3hIeyD1F2DGw3BtbfNhGyOL6LPyX+0pnFeIAX5WYZSwM8g36eh8riR
 ZVId/BYqPsxFkandzamfqEolf9hv9juZ0gNwJQgm5jGIa+HLwNyH3WajRdT3ZyqBXqk5
 eD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646264; x=1710251064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi5x0OedtFiXYvl8cpQZIwBhtQ9Cn2QNkroxyToz+PA=;
 b=huGZdffapXLtnumLy6NVNUKD4p6qf96PkhybHlOvlM3PA6Un7lRhkIh8eiGBi0GOiN
 K2Qs+aBWxmPwjN9uoH32cgn9Z8He8F75vPu6JaKO9cKp4sRh+Z/XLLGWu7NHBK5NpCGB
 45WWyHmHOSTQ9NhgC+z3AICkaKT7hV3Rp6QAe0TNuvt3Uuq7te0l9jFmquG9eFEnuPlg
 6GfIPKvCfyXhg0xnJSthNIEvyjHtf1/qoW6P4YhUyXxz/PNNckvjOj+mbWxUwplNXnBV
 A4RbK+128duU6QwHkqBi8gjK4xHd4leeWM/wpDX4V1i7QIMOTp0yamrqS1vFyHnaLdcA
 Uq/g==
X-Gm-Message-State: AOJu0YzMZ4uOuFQOHNdxhOflaXqS0zcipx5paXyk1gfEJvKZyVqumaso
 WvauFSvtfpXh2IbwjiSaFBZsP+KVyKyjz1w9cRGfV2HLGFTkA3Q5LYUa0lmke2koc9Mcrn8Rl9/
 Q
X-Google-Smtp-Source: AGHT+IHolUnDHiaXONGNAEjHyoMbR0Z74o7ujBdQRH+ENiyhFcejbpl2YfJKfWkYeS75WpUtG+BnoQ==
X-Received: by 2002:adf:e5c5:0:b0:33d:274b:ffc7 with SMTP id
 a5-20020adfe5c5000000b0033d274bffc7mr9419456wrn.46.1709646264430; 
 Tue, 05 Mar 2024 05:44:24 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 v13-20020adfd04d000000b0033d202abf01sm14937659wrh.28.2024.03.05.05.44.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:44:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 17/18] target/i386: Remove
 X86CPU::kvm_no_smi_migration field
Date: Tue,  5 Mar 2024 14:42:19 +0100
Message-ID: <20240305134221.30924-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

X86CPU::kvm_no_smi_migration was only used by the
pc-i440fx-2.3 machine, which got removed. Remove it
and simplify kvm_put_vcpu_events().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h     | 3 ---
 target/i386/cpu.c     | 2 --
 target/i386/kvm/kvm.c | 6 ------
 3 files changed, 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 952174bb6f..bdc640e844 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2018,9 +2018,6 @@ struct ArchCPU {
     /* if set, limit maximum value for phys_bits when host_phys_bits is true */
     uint8_t host_phys_bits_limit;
 
-    /* Stop SMI delivery for migration compatibility with old machines */
-    bool kvm_no_smi_migration;
-
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2666ef3808..0e3ad8db2b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7905,8 +7905,6 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-                     false),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 42970ab046..571cbbf1fc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4344,12 +4344,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             events.smi.pending = 0;
             events.smi.latched_init = 0;
         }
-        /* Stop SMI delivery on old machine types to avoid a reboot
-         * on an inward migration of an old VM.
-         */
-        if (!cpu->kvm_no_smi_migration) {
-            events.flags |= KVM_VCPUEVENT_VALID_SMM;
-        }
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-- 
2.41.0


