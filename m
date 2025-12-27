Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E6AE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuo-0002ZQ-9f; Sat, 27 Dec 2025 04:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuk-0002PX-36
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQug-0006uq-4U
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxTxSluSeMR2sv+YqnYcIpwAfUPDvmouTbMC1Ijhc98=;
 b=AJ0IL+oNQAcddvBP/Xj68G2vahcHuCCtokoVWSM/GYNwbpL44Se+MeDIQPzQl0AcaasC7C
 79ddPDZsDJ5LOvqG1/hG1mONDwEQKgKkxzc57zL6NCIAtbQcmKusqTumf1ak9flv3aTdHS
 SRrj++18713sMnNP8PySZo50L7CSKX4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Dd3VGsH0N52T1lJ7B35K2A-1; Sat, 27 Dec 2025 04:48:37 -0500
X-MC-Unique: Dd3VGsH0N52T1lJ7B35K2A-1
X-Mimecast-MFC-AGG-ID: Dd3VGsH0N52T1lJ7B35K2A_1766828916
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so58139585e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828916; x=1767433716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxTxSluSeMR2sv+YqnYcIpwAfUPDvmouTbMC1Ijhc98=;
 b=A7sivJVsHJFcXCA1o3AUnnpO62VwGEw5XpmFfxpMb+hM90PdY1FttSOUE2WlfCSMeH
 ThGzQRUOIyi1rPOqNXboAdyT99tSs3fWfMdZXPom2hD3YSAQNc2e6XSrytTC8gTZ/hHy
 /+gayaQre3R07fq79wNjMqN4P5F0o5IEBgGo74CpVA+PA2qunn8uj0wneLjRqjRMgcP7
 RZ1ySjAoUYCrRe7ajhr0kI841xuGkL5H3IRBDMZwXhy+R13MHKf9gx5ja870bSH/84RC
 0i2F+ovUXQlEZ7UWT7NtJk5qZVVZmhxJ5TrUNHx/mdEJXY2idLdypJPE4vgSmI0dLZBR
 RhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828916; x=1767433716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sxTxSluSeMR2sv+YqnYcIpwAfUPDvmouTbMC1Ijhc98=;
 b=QSYjLCZwbThK2Fibl7nlazXCJAwM3TxA9aZvo09jgGLH0Z6nyK+YS64n9FNjLOf5sp
 5MRZ8sMVs8OPGb1AF72qAIiMkmnxB8hIG5DMkOM4PSVzJBigTmWqWvPZcrdF40nFtOKC
 FXPdwST/7/O/hOiSHwZEuhRYshSE8/hUfnnjFpQ7F9+5LGGjD5jJzeletRR0VQx3yWnp
 PDT4UGVzvy9dDuxvGNOnquND/A6jw7pwIXxsXRfJzM9m3eYieudrRdkJOKSBXBoUp2Qz
 xm55+qSb3RkEElUl7TsTZGgE47RKw7Uu1qg9RTiAk9n59rmw2LjuJIsSiQxCJeVt37xl
 bZLQ==
X-Gm-Message-State: AOJu0YzNTur0KjUyUEwdP+BWfKvvM/3fRMg9WZ13oKR76J1iOzzXMuFD
 N+WzyNRRX2S7sfmArie2EuV5wY99rrooICxLv9RzA4GlVficzKs0F6BLbh2F+hPpinWpA0BoxEB
 6Lp/Ch60OrS1dO3H560Pj7gooIOqN41ENkHABrSqh4ahNLOzECjlkg7P1ggL7vhv/mvowivLyH/
 0zXKGIyhKg4oGf0S8oeaegQEVVLz65qMJFV+nwRpZd
X-Gm-Gg: AY/fxX5gax8CWBlBZYTYzmtn/Bxrleq8qs+XwttZp21ROtdwVHKKOKsDR52w74/dQTE
 g4EgIxFYRx1/HpfTDF5XxdbIHeEgQzAcQS9ulde0+k5tKT2ZeVK7qiAHgHXWLHuMUkJzFRgIJ2I
 uyaKH8SMGGJAXbH04SwG/oqPx7L9+Rbh344erlIx5ly4CsbXIg1ujO15YEoJg/qVyGFBnCDkPvA
 tOwjQkb0qTSiHMhooWsG1IP6FvopC0fRO8UStN5rKKVB+RR60xXENXoHTvjSNpF4XBQ1zpYNOmi
 e6v4IMR897KqIYJs2lVaLX12vuHZZiURaMbJiLZGdAsmh8mpNRwAwBb3uOSsITLunZ4JW51sB+N
 owim2Nm9AjrWUTkvdsl4/imhl7zv67KNPUcJVJCoGLQcvs4fqpU+gollgz08ptC+c/KXsnYPMj8
 UUUPym1RZT6towGPc=
X-Received: by 2002:a05:600c:c091:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-47d195a98d5mr228100385e9.35.1766828916178; 
 Sat, 27 Dec 2025 01:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1pFD6d6W+lX0Ky/BGS5ax30VL9itizGK8C73Flx07LBaDxGXpY8So32uWdlN0Cp0DjINA1A==
X-Received: by 2002:a05:600c:c091:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-47d195a98d5mr228100165e9.35.1766828915785; 
 Sat, 27 Dec 2025 01:48:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2278dsm50745961f8f.18.2025.12.27.01.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 090/153] i386/cpu: Mark cet-u & cet-s xstates as migratable
Date: Sat, 27 Dec 2025 10:46:55 +0100
Message-ID: <20251227094759.35658-16-pbonzini@redhat.com>
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

Cet-u and cet-s are supervisor xstates. Their states are saved/loaded by
saving/loading related CET MSRs. And there're the "vmstate_cet" and
"vmstate_pl0_ssp" to migrate these MSRs.

Thus, it's safe to mark them as migratable.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-19-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b1bbb099f33..6774f662342 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1484,7 +1484,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .ecx = 1,
             .reg = R_ECX,
         },
-        .migratable_flags = XSTATE_ARCH_LBR_MASK,
+        .migratable_flags = XSTATE_CET_U_MASK | XSTATE_CET_S_MASK |
+            XSTATE_ARCH_LBR_MASK,
     },
     [FEAT_XSAVE_XSS_HI] = {
         .type = CPUID_FEATURE_WORD,
-- 
2.52.0


