Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88CFC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtzv-0007yr-6F; Fri, 30 May 2025 03:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxh-00042N-25
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxf-0007Ex-Hx
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mByca/kl/qtKwO3VEhr3sZUJFwHtbTSeBV8OSE/EBu8=;
 b=FmOnUDc0c964QnbxAYw4ZdEebxmzKILITeJ1jzdKWPiD1RIU+BtxppnfVqvC8YrsX1NM+m
 IzAd5sWM70OGlK9+1dvcHv9aQAsyGvBru2lNvUO/BJ7/qQ+6Obxmmpi8y4vPj/AlPrWwsv
 9ehWwQJScjHM+JhlxsVktIikGK4hOMo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-MOt1iu12Pemjif9vHd8Hvg-1; Fri, 30 May 2025 03:15:25 -0400
X-MC-Unique: MOt1iu12Pemjif9vHd8Hvg-1
X-Mimecast-MFC-AGG-ID: MOt1iu12Pemjif9vHd8Hvg_1748589324
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-604e837c1deso1447650a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589324; x=1749194124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mByca/kl/qtKwO3VEhr3sZUJFwHtbTSeBV8OSE/EBu8=;
 b=DOX4BeC9B7yEqLIFF5og6XKVKkpklQvdZJAZAp7ecxYAvc+HVb6yxS/zP/u2KOZLhJ
 FvE8s/TpoL6AvVDVmuVd8gsTloFT9vMHK4RnQzl4KVZQgIrlIxcZKUWoW/tQY0EHzFVt
 bpcJ+jRcM3mpv5PVZUhDIoBcfXs+YUOMA74Y5Fv5AMifjZz9U5g27n7nipvC/LJJ3stH
 IM4fn3GAI1DeqfJN/9nmJPSyDvBprn0lZZPDsahDfKvJbEfJBpl4yMejrUt7/85GoT7W
 GkD6ABDmiOatZfM5t6jUb5zKq6AD0WBS76bgB1WIbxWMr+LibjAVv6oikS0rGKmN+FSi
 u0sA==
X-Gm-Message-State: AOJu0Yyh7gM+oDndiGv12uSwh+PTXSoCDBqxNEf8jL8VmvhMsJxC0hhj
 mnh3U8iPejNn8KLuUQ1zRAsEA1P6JzJiuVEX81vLgQxV01+beT5v5BMSQMTjHWjMgqBD+sP5KP1
 geYYpAl+qtnXA79rk4dGfTJ81xsvJl0vtGuU5kDDvutqUqyH5w7dx4Y+QN9mPKCoMrEAZhm4wvM
 uFsEXaJkRfTEontawDxK4bt2CKqnn1Xm4rLlB5mvMa
X-Gm-Gg: ASbGncsYEYc6IXz3IVwl6itjRBhDnupPMNmjIGfisqO4mn6iJS06TDZjWWreyBR3zt/
 /XWCbctprjlBL1i9EH+Ldmvtl3e5PDkrCQR7K3DYPZKyOOrWUzS5SAwqVuxtKjHwvWK2WvLYNXL
 C27eyL7gOd+FkBt9gfSCR7AYQ4CdCnVarQB8USOBvyfBt5joDbBCmhKDKO0CR7zVupU6pL0Xdj0
 iKxhu+oJ6sO9fpVxGW05FtCrk4ls0PfhNfyDuTEqFZVGRpJRcGo1jjuCoS9I8QCNBjzQO7ep9UW
 GJhCsCrDKXsdRg==
X-Received: by 2002:a05:6402:5207:b0:5fc:4045:7d74 with SMTP id
 4fb4d7f45d1cf-6056dd36426mr1612220a12.9.1748589323878; 
 Fri, 30 May 2025 00:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF28dpBupBemBN7mgNpHqoHcnIq4ktJU2L+G5XsO3Bi3/fI8hHFj3cjxmNJofFuaeXrZ6nCxg==
X-Received: by 2002:a05:6402:5207:b0:5fc:4045:7d74 with SMTP id
 4fb4d7f45d1cf-6056dd36426mr1612200a12.9.1748589323408; 
 Fri, 30 May 2025 00:15:23 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567142775sm1177266a12.55.2025.05.30.00.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 60/77] i386/tdx: Add XFD to supported bit of TDX
Date: Fri, 30 May 2025 09:12:30 +0200
Message-ID: <20250530071250.2050910-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Just mark XFD as always supported for TDX. This simple solution relies
on the fact KVM will report XFD as 0 when it's not supported by the
hardware.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-49-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/tdx.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b38e691f1af..8a4b4217d02 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1122,6 +1122,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
 #define CPUID_XSAVE_XSAVES     (1U << 3)
+#define CPUID_XSAVE_XFD        (1U << 4)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 188c2242d53..0f7f47c6da8 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -621,6 +621,12 @@ static void tdx_add_supported_cpuid_by_xfam(void)
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
 
     e = find_in_supported_entry(0xd, 1);
+    /*
+     * Mark XFD always support for TDX, it will be cleared finally in
+     * tdx_adjust_cpuid_features() if XFD is unavailable on the hardware
+     * because in this case the original data has it as 0.
+     */
+    e->eax |= CPUID_XSAVE_XFD;
     e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
 }
-- 
2.49.0


