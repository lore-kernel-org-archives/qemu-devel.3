Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFE0CDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3fd-00050p-DO; Fri, 26 Jun 2026 06:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3fP-0004fH-Hg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3fM-0005UU-8W
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsOdP/w9CsB2e0wkH1FPwJZcH2RwGI7JrZ69X4jQzLQ=;
 b=JT9IqACTLr8K+RBeZbArW7rXqfgbFaIr+ehzkfngj7fZt4ZDMJJoS+3/3ngln1PFBpwwYS
 eyj7J0cYAyRxsYxEd4bfyTCjhahqStgCyQgawjFTrUVLYeJqYjYgDSqMJHDKIOWFrnnuYi
 IHp/318n/U3z7nGyiep3ErH888ihsBs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-2gXLEn6-MImgMM-og9FDCw-1; Fri, 26 Jun 2026 06:19:51 -0400
X-MC-Unique: 2gXLEn6-MImgMM-og9FDCw-1
X-Mimecast-MFC-AGG-ID: 2gXLEn6-MImgMM-og9FDCw_1782469188
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4623bdcad2fso441113f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469188; x=1783073988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsOdP/w9CsB2e0wkH1FPwJZcH2RwGI7JrZ69X4jQzLQ=;
 b=r/1PQmlSPfLFrwe9XbV8hDyudz/d16NAUJ04O+ff1OIY8r7aLATZKeqhcWTsUj2GOJ
 rgbvm8nTo3XYw/fTz3lb0J05mL8nGtxXIli3aDMWcYxMQNF5mmOj+5H+mXh9+dXYZ+z5
 8O+aoANTck44ZbOYrtnd4JtaLbp+ACDH89el7B5xJTZDjxewlwM8QLdW02uL+LcKStmn
 OIyZoT0dxEchZuwfV4ha5ZmSEYoYLavjkRpENL1vrrJpr36oBX+dioiWDtYok79/KFye
 fZcfTm0P47JlE3VqLLr/45RzPmpNxItcBi6cqUbdrDsf7yPGyLK5E2TIsly1G5HHzu4A
 rw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469188; x=1783073988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WsOdP/w9CsB2e0wkH1FPwJZcH2RwGI7JrZ69X4jQzLQ=;
 b=Q1dodZ7kNdK0Ej7q9L6vJhwtNlXQR1IMGPJJCUChZahMSDGPANCH9QVWzgcYUSAB7A
 9Wjdt2cDu8wYWHLY2UEwBySGmzgaOET83Sg0KztM3efDG1Z545xb0rFgXwowX4hngY8Y
 oGhGCZSDDrTotfFAZKAwFNqpQMJ/cqqBtvPNBuFMu7giSNOTv7pSPbiQ3q+6V+VwtkyI
 IF/4C7L0XAhrEUZdTrWqb9VwkxtR8XTOewKaU1Iyd+iO0d7giBCmaEWGCaEcJ5UlCFvC
 eT6w8+WlanhzXwTQUvnNKzzAiFIVt2SVK9uYa93gbd+sRvML4QBa1uRSxhM4WneqGS3M
 ScPg==
X-Gm-Message-State: AOJu0YyYhqgichLx3yUVituAx6XcScJzry8tFya6ILZzzMIvbbwC4883
 /1phKhK9h5FtrxwE7/rArz08dIFcE0tWFhOwL0IFV4fnG47D61Yyp/Vvtol2OfrudwkSSnyB2KH
 aVaS543QRHhMfViXXd3AVNK+7KCFqVBHGh0h1TA44uSFlmSFpH5Sud+T3aZ6ZpY+iBQ9OuahMYy
 47IcEmG/C+mPnV7ChnTJyONQDEq0yoksfGhnNKn4sn
X-Gm-Gg: AfdE7cknDaaJGxuYhKRPqKZsFyxxGceZj7twvGnskLtu+BjKHWpoeLfObSzFEP910Qz
 UAQ5uiTlBX4/07iGmKnsymfBmYGXMoJTmaHlDm9zTzYj9r7gyK3ZHivmJphdHpGtjr+0T3it2d5
 1l1K3T1KOAnfSI7y1YMsXtjOwHzfAD41CZGJiy6fqjA6G+garYXt9q8OL2qgIeoORFAeYpNmWXp
 G8yfxf2GJYjLMg0qkl8/wDUIS9rygbTC7Xz0Z9/hWVW3rcG0biRm95OS1d+AIXH80eX0eLNAw8i
 lIZK+lsFQfZAIaw6ErfEx1SFBPi1vqlsTjZRtoyjWA4Cr0CHbOo4DiS8O077ZMHZCHZvJ+vM7pJ
 tRvX1geBxys0ni3vCiMMMimSzLo9c65FfkASBatwD+yurSQclHCS4eM9Z2r1YaxMPgLu6fj+Kej
 K5QW98VQcy7bR5hvf3
X-Received: by 2002:a05:600c:8889:10b0:490:b58a:e6ff with SMTP id
 5b1f17b1804b1-4926688590dmr70373515e9.22.1782469188172; 
 Fri, 26 Jun 2026 03:19:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8889:10b0:490:b58a:e6ff with SMTP id
 5b1f17b1804b1-4926688590dmr70373075e9.22.1782469187683; 
 Fri, 26 Jun 2026 03:19:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fc0d36sm112788805e9.2.2026.06.26.03.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PULL 44/45] i386/tdx: Make AMX alias bits supported
Date: Fri, 26 Jun 2026 12:17:47 +0200
Message-ID: <20260626101748.1728079-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

When booting a TD guest on a platform that supports AMX alias bits, QEMU
emits the warning such as:

  qemu-system-x86_64: warning: TDX forcibly sets the feature: CPUID[eax=1Eh,ecx=01h].EAX.amx-int8-alias [bit 0]
  ...

Bit[3:0] of CPUID(0x1e,1).EAX alias the AMX CPUID bits from leaf 7.
Their TDX virtualization type is "CPUID_Enabled & Native": the value is
determined by the leaf-7 AMX bit they are aliased to and the native
hardware value.

These bits must be added to the TDX supported bits list so that they can
be enabled without triggering the forced-set warning. For simplicity,
mark them as supported whenever the corresponding AMX XFAM bit is
supported, rather than checking each aliased leaf-7 bit individually.
This reduces code complexity. Any platform that supports the AMX XFAM bit
but not these alias bits will still be handled correctly, since the TDX
module provides the real value via tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20260512082108.621596-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index da4478cb21f..e3c5eb99842 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -560,13 +560,19 @@ typedef struct TdxXFAMDep {
 } TdxXFAMDep;
 
 /*
- * Note, only the CPUID bits whose virtualization type are "XFAM & Native" are
- * defiend here.
+ * Note, usually the CPUID bits whose virtualization type are "XFAM & Native"
+ * are defined here while "XFAM & Configured & Native" are not. Because the
+ * latter are reported as configurable bits by KVM when they are supported.
+ * And they are not supported when not in the configurable bits list from KVM
+ * even if the corresponding XFAM bit is supported.
  *
- * For those whose virtualization type are "XFAM & Configured & Native", they
- * are reported as configurable bits. And they are not supported if not in the
- * configureable bits list from KVM even if the corresponding XFAM bit is
- * supported.
+ * Special cases:
+ *
+ * - AMX alias bits, their type is "CPUID_Enabled & Native" which means their
+ * value is determined by the CPUID bit they are aliased to.
+ *
+ * For simplicity, relax the dependency to related XFAM bit.
+ * tdx_check_features() will eventually catch the unsupported configurations.
  */
 TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA } },
@@ -580,6 +586,10 @@ TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_INT8_ALIAS } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_BF16_ALIAS } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_FP16_ALIAS } },
 };
 
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
-- 
2.54.0


