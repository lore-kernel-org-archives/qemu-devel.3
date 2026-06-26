Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7398DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3fA-0004C0-Oj; Fri, 26 Jun 2026 06:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3f9-00040z-En
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3f7-0005Sr-IP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSRwuOc010Ufku1OU9TvA9RlMNaejs2seQxcYG23jkU=;
 b=IJAEQz5nsdZrQgXqSLbjofBy0vSqgEQ0M/GttN84xtyLV3okAkEkaTRzgioIAyI9LzCdgo
 P+5Aaj0Rk+UfWT5fTvoTB85aNlMawvx4tmISEJfCLBY1F4V3wJNLCfUyo2lbMfCVMDjNWz
 4Xb8vrfoazjxVD5ASdG7hygdr4F+Rso=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-nxIJZnLKMYyUbF6eUxCsoQ-1; Fri, 26 Jun 2026 06:19:51 -0400
X-MC-Unique: nxIJZnLKMYyUbF6eUxCsoQ-1
X-Mimecast-MFC-AGG-ID: nxIJZnLKMYyUbF6eUxCsoQ_1782469190
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-463aaa77ffeso442076f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469190; x=1783073990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSRwuOc010Ufku1OU9TvA9RlMNaejs2seQxcYG23jkU=;
 b=bMdLc809ZbIu0qfurfx60TjExs1GAHVPCHaxOXoF7GWw2VzFPSlcp/QaHBvq2xeoDD
 0GZZbDPq1iTGII/BtbuTPrNcdX3fA5ntf5edMzK/MmHey5d9U1GZ0tZsqZfEdBTIxo7I
 2cvQr/BDBH/iaBRaIa6Y0T4HRd9q2qPfhHakqZn8htAwgkw9pYp+2dGrZiQK9swstj+g
 Go3KxwwU5kh8Snasp1pwXSxVNb4Al0Ob+lgKl1HSnU2cbxQo7P4RX1lP1yKAOpQOpONc
 ywU+Lnsm9nq6LWFq6IpFusdoIc6ZjOSJpRQInB7dEwY/+SX57Zt0+mRNpgiQ0JtGwckm
 wE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469190; x=1783073990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jSRwuOc010Ufku1OU9TvA9RlMNaejs2seQxcYG23jkU=;
 b=d2BRuY8I7iZ2th/A+CQy3v6JhHxEkQe5/RdQeCwS63d7bBvILYiite9nWQKjKnSIBT
 dxmftiUVU+mn+9vFYmBa7T4fNKQl+6XjpRa+xuWEuDumofRa4dEuFRzU1appfr9Ht1Wc
 oep4y/l4gtmFSWAMeA8Di1gfUbJ2RqetiV8HhlBdy8R3mmtIw+nQCw00gjwyTbXa24yl
 W8IvFrigc4TFAHdtALV2oL5Z1y31UTbZvUN1MdrI8N7DFB1Tvuj0xPjxEMj+w6DrG1iR
 3Fq1GVdAyWXTRKNhe/DPXZ3G9xMqMgIdKfLhqlIBre+I8xgfBO9/qgnSMUjY5SaRvXiY
 WO4Q==
X-Gm-Message-State: AOJu0Yw02Ty9X2oNfhosEhJws0xXF8LF77MXTMw5NUfNK6aGPWHnL2sw
 EjkusQbCZ+spRDAr+UlTsSVbBFvOomEkUZeAdbQ5bmO25IgNl5v2GvNTjCmGeedK+qClaLAwkYJ
 p6Q+AqCRK2QknKaqo22Bvt6JGbOW7Asa1VPndfo9zSj/UwuL3vXs5fSTgPg3Zj0REjhgYmOV113
 FT9GHwOCVR1ydMlYiBrQRCbW6ERTZTve6KxheQiWe6
X-Gm-Gg: AfdE7clgYFTet2HWO3AW3wscbU+ceJ5pkpRJVMAP5Rld/nQlezgfOAs4kLuVs4tUNYG
 KGN1N+II0i3bXA+aEab3FZYqKRAXkRLpEa/tiMJP++sJkQvl9pvzfRly685xEhd/p5TthQ6sPBo
 qD8eO/U/uKIK1vyHeTurDuwfysCXPv7ircmjixVWwtvIU78hgBaAwrIO4VWKEJGg4pdvHCK392K
 uiB4lmF2GTb6gfS03VcgvaL4B6czAWO3uOgqwabIuQTO1mtp7ZuEA1vC74ozX7dKX5uzQRQRLvJ
 wtquSBwAKc/aKAIvIXqwJUa4I4kEcuWHPDJUFycX88q2DWahU9W5Wge3BYcPVf9Rw5/BGLJa9hF
 +XW0FR5SuucQQlI+lVPo2W4TUZsKggsICQUubfQt1dKPwGUeFlmmfd/6CQKK9EtotNjy+mJMwwd
 rsknjrhKQY82nHK5S4
X-Received: by 2002:a5d:5f8e:0:b0:45e:64b3:af44 with SMTP id
 ffacd0b85a97d-46dc18a4a8fmr9740120f8f.36.1782469190349; 
 Fri, 26 Jun 2026 03:19:50 -0700 (PDT)
X-Received: by 2002:a5d:5f8e:0:b0:45e:64b3:af44 with SMTP id
 ffacd0b85a97d-46dc18a4a8fmr9740071f8f.36.1782469189905; 
 Fri, 26 Jun 2026 03:19:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d998esm22922825f8f.24.2026.06.26.03.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PULL 45/45] i386/tdx: Add CPUID_24_0_EBX_AVX10_VL_MASK as supported
Date: Fri, 26 Jun 2026 12:17:48 +0200
Message-ID: <20260626101748.1728079-46-pbonzini@redhat.com>
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

AVX10 depends on CPUID_24_0_EBX_AVX10_VL_MASK as defined in
feature_dependencies[]. Currently CPUID_24_0_EBX_AVX10_VL_MASK is always
not supported for TDX, so AVX10 cannot be exposed to TD guest.

The TDX virtualization type of these bits is "XFAM & CPUID_Enabled &
Native": their value is determined by XFAM[5:7], the AVX10 CPUID bit,
and the native hardware value.

For simplicity, add CPUID_24_0_EBX_AVX10_VL_MASK to tdx_xfam_deps[]
under the AVX512/XFAM dependency, without separately checking the AVX10
bit. It's safe because any invalid combination supplied by the user will
be caught by tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20260512082108.621596-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e3c5eb99842..f882578c707 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -571,6 +571,9 @@ typedef struct TdxXFAMDep {
  * - AMX alias bits, their type is "CPUID_Enabled & Native" which means their
  * value is determined by the CPUID bit they are aliased to.
  *
+ * - AVX10_VL_MASK, their type is "XFAM & CPUID_Enabled & Native" which means
+ * their value is determined by both the corresponding XFAM bit and CPUID bit.
+ *
  * For simplicity, relax the dependency to related XFAM bit.
  * tdx_check_features() will eventually catch the unsupported configurations.
  */
@@ -579,6 +582,7 @@ TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 } },
     { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI } },
     { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
+    { XSTATE_OPMASK_BIT,    { FEAT_24_0_EBX, CPUID_24_0_EBX_AVX10_VL_MASK } },
     { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
     { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
     { XSTATE_CET_U_BIT,     { FEAT_7_0_ECX, CPUID_7_0_ECX_CET_SHSTK } },
-- 
2.54.0


