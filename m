Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4BBE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxc-0005XY-RE; Sat, 27 Dec 2025 04:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxb-0005Hn-0X
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxZ-0007Vj-B9
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3gJ7NVwC86I3OXasFD21/vObhIQMzDU+Tc8ShgNyik=;
 b=YXeA9xwLE6dEPO6IuexxESl+TKKa9M2mCFXgEZak7UTYOKVP2+OkyeaOV6+INsiB9PRsyt
 eQ0aIyLRCfEB+H27j+KC/L6gqcG2MiOYldinzajajTM+s9F55dMU74WGwENgUjYYWpOrcb
 Dq2AGRNJA0K5Ox0WjYXKXvEd4KzKCs8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-1dJ-rgLhN_a4P8JFYSsbxw-1; Sat, 27 Dec 2025 04:51:37 -0500
X-MC-Unique: 1dJ-rgLhN_a4P8JFYSsbxw-1
X-Mimecast-MFC-AGG-ID: 1dJ-rgLhN_a4P8JFYSsbxw_1766829096
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso4752751f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829095; x=1767433895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3gJ7NVwC86I3OXasFD21/vObhIQMzDU+Tc8ShgNyik=;
 b=posfjjo1dzXHDMO9iKYBFKi1mwUH3mnhgJ+PSUPaAM95W6NPwi0X7y4oMoib7du+sd
 I47WQUs8n44vOA57wpesUNMnfvpeg9yqTYdlLO9HC21JNXEW2Ly/Jc8qdqtBA6Rew1qE
 MHePLo9NknvX+ZwlysRKOfzuTk5DXiIDtUW72iSvbOmSC/XNbNodeyxh1/zQPpddHBNq
 8PkT586jNCmNnNaROxFeVG4m8I93JYwkliegNP31lZtDbBwOdEhSvq/XKgzcBYuVFpSl
 dcihesPQWNbRPCPngTUdi4DQjAMLwrGKi/Phdh7aodRdUV+Vs8IA9gWVDktq8uwWoTZ4
 jkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829095; x=1767433895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U3gJ7NVwC86I3OXasFD21/vObhIQMzDU+Tc8ShgNyik=;
 b=cBTcG8QiryLHzn3DgMlotcTFWYDvB21w7StbPnU374SbXCEMAbB6XEXp1gvKvot+gF
 OJ/AiZX2j/aYEDPUT7EE7+jkijcAXdJTIFnKzKAiA3llgsAZr3xJej++/o3xh86MXc8c
 bgv+vmMWsYXMrXNT+pO2m4/b4IPzf7b5BlwtKicUMns+YK5kCuTjWUKM7jgJvgoWij2E
 Y0kOKYqwuEek8rIzTcGh4ZDvdarqoVFgJnEYlIPGYLb97HRZM572teTmwGvoszUr9E59
 2C6X8Es1FRuZZNxipKfxXXi1un8XNM2rpUhNAo2CvMM8rjowuJ+ndoUAl0jy+s8xiYS/
 DgvA==
X-Gm-Message-State: AOJu0YxAYL2DLu55TXmux7F4N+HWZeDOmAQjTElXHzraLMjxsIQRjHgr
 tG0/wAzQrC30D4zKWV+Wd2t175GDXVZe7tJfzbJRI4lBH+O7exAaIp8b0YJLPYqd5ES2rMMLqqS
 ZSdFK0R2ux/6NxsK+2EMu+ZkqiOtuFNqdqZg9vFTieyg+CE1+C7h413sJWb2ql8GPZ6MY61X6WN
 j7mvOi9W0XQLJrdVXcPmUxDzpMTANR1VG9mnAXj5Gy
X-Gm-Gg: AY/fxX4OEE7Ot+ogLI1J3UflmH1+8SR+M/u+9W4sIvaXbnMTFMFRFUtsZ1/Nkx+iEsK
 Pz1qfw01mafLNwhevru2sDnK/lyAZIZ/KwSNMpQDPJpA0Su+sxXd9LLGQi1kQEhhJ4bVBBXXEp7
 71IXV2dSOgDCEayjuKllEMVx2ThuunDdnNdOAFZ90Vm5C/vOaPWkqC+NsCtYiVITx/no67fqsBr
 2IY6v5VFJeJ17j7AmKwLTPkMMAJpIM+LNV0SE5aGFO5+jryo9Q0Z0w4uc/guw8Si6patlPW36PN
 JeHWbCy1ajcr5kZWMHQOn9ccMnStmg8VrbCMujY69p+f2tYSCC9EV4+RsskevM4Gw0wP8iqcAkR
 HJOo6Gojup8Y5LanJJGTHySpEfV5UYRs4Qy9VI5XNpNKmMItPnYB+E2VG6Y8DWaqn7XcZHQ5pp0
 pTFb6fNld7TiTXgfM=
X-Received: by 2002:a05:6000:601:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-432448bf4f7mr33923741f8f.22.1766829095031; 
 Sat, 27 Dec 2025 01:51:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH90IUEVNbEUmkHnK1VYQsKbQZ/J5o3iDmpTROLusgFtyYB+7Hyr0h+BZSq9+SIwZibAskjcw==
X-Received: by 2002:a05:6000:601:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-432448bf4f7mr33923720f8f.22.1766829094560; 
 Sat, 27 Dec 2025 01:51:34 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432613f7e6esm38875648f8f.21.2025.12.27.01.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 144/153] i386/cpu: Define dependency for
 VMX_VM_ENTRY_LOAD_IA32_FRED
Date: Sat, 27 Dec 2025 10:47:49 +0100
Message-ID: <20251227094759.35658-70-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

VMX_VM_ENTRY_LOAD_IA32_FRED depends on FRED. Define this dependency
relationship.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a4a8bc61a99..41ea04099b2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1439,6 +1439,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
 #define VMX_VM_ENTRY_LOAD_CET                       0x00100000
 #define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
+#define VMX_VM_ENTRY_LOAD_IA32_FRED                 0x00800000
 
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49a8f30feb1..3440a70852d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2036,6 +2036,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
         .to = { FEAT_24_1_ECX,              ~0ull },
     },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
+        .to = { FEAT_VMX_ENTRY_CTLS,        VMX_VM_ENTRY_LOAD_IA32_FRED },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
-- 
2.52.0


