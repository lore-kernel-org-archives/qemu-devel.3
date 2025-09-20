Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E0FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybf-0007T1-DX; Sat, 20 Sep 2025 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybd-0007Rr-Lu
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybW-0005U1-Iv
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9jcGdX1lSvJdDQcVF4FUrlARni1t0sPnSGCmO+JHDo=;
 b=WqDBvlhCakKgem+C+xKH3sFtIcbTbrcmehkRCQq2pLnZtD2VzlFs1AmSLPdJVeQIqnFBrg
 x3DI42EwGtuMDuWQWbhWFSJo1ue+9ZJS1bMY8XGFwHOrSoFVdyUXXcHV+AbUthy6EVKgW5
 YY/walyyT7OiCLlg25jkdXhjb9R022w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-WEdMH3o4Pf2RjuC79T_biw-1; Sat, 20 Sep 2025 10:30:20 -0400
X-MC-Unique: WEdMH3o4Pf2RjuC79T_biw-1
X-Mimecast-MFC-AGG-ID: WEdMH3o4Pf2RjuC79T_biw_1758378619
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so1647070f8f.3
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378618; x=1758983418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9jcGdX1lSvJdDQcVF4FUrlARni1t0sPnSGCmO+JHDo=;
 b=jUhwKZBm7vJyujgQAysNW8OSvPY0XF6jBWWnTyqjlEoScYJhT8kz9tM15yVmeeEwXD
 WydNtzDVb0YRQjDPOXKtV2YdpqgQyo+R5TmXTW9lHl+3FRCIfE/YpHHf7OtA6vNp7vt3
 5qiAELT69Nm8j0Ymod+1jlAtAml7P9agYUG/tWQrHeXo44/+Jb281Rx7Ju8b3S/jxCWX
 Zn71Ifu/7T3EPSDJUXDG3Q/wBGcUhFZPphJEnpjaPVKioG4sQeXJnt/HRLtkXPPiEMcb
 DfokpjLoqrrwrCgiKmMswtaAJpc18iloBzFj+1un6UdVK51EIxAvGnoV6FFjbG4yEBQ5
 Q7lA==
X-Gm-Message-State: AOJu0YyCOmZ7PAVR+cV4rfFw4J+OPprmxhU/Zi+vv7u73Q3hNtAGnXYm
 TAIxdVzF2bdKXu6uQBfKesuQc/BPFci52h/VINhtLed+XNExhyoBcir2nmovO4xo9/5T4sVbACo
 IyuBbSu9eRwr1nlRTZ7LfSxv8rvpDHr8e4utwFzr5jn1wwyFGTqCbQ9Om0/ukoOcCQ2DuUQA1CO
 ciWaolqc5og/+J37Z9PCMVzJp6Jct25Ctc0QmlPL2O
X-Gm-Gg: ASbGnct6a1ylUmHv1aNGxOG+WCiZr52Jk40uSWOiqsB4nHh41vBxOARMIQKUTsLmAJy
 R+0poRyAgmY34FRIcny5hFceAbK2+yBK1DDz0PtEpwc2hRuHByoHTRQN1MMrEMABQwbnvD1kYrn
 GEUb3D/Wq9mYEM7V3FwxhJdV4/nWljLrCC5Inr27twpvILbza174d60dv7IhsF0qc+Osrj4Zpok
 JrBVHilAHTXxGzFcd2X5Cj1cSpVYhyxMHd75z18mqPyzaZgvoXg/l8VP06ltXQpDePLTps7x33+
 +fNu/mbs6LowzFnFkq/eAlc43Zxb7yB8TjiOH1CkXGh5rt7rg2CMCCPuGx0374UXwgtB1lKnr3O
 sr+xoS7zFvj8VDjMJTuyhhdkc173pCsf0SASnjbhUbj8=
X-Received: by 2002:a05:6000:24c9:b0:3ec:ce37:3a6d with SMTP id
 ffacd0b85a97d-3ee857699acmr5746400f8f.47.1758378618448; 
 Sat, 20 Sep 2025 07:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVsQCkxTEWRDRQztw0Hn3LuLOS8XxwHM2e/j9Mx0kRIkEmI+325YL5RSZSPJLHN5BW03f3fg==
X-Received: by 2002:a05:6000:24c9:b0:3ec:ce37:3a6d with SMTP id
 ffacd0b85a97d-3ee857699acmr5746385f8f.47.1758378617995; 
 Sat, 20 Sep 2025 07:30:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407fa3sm12145305f8f.21.2025.09.20.07.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 7/7] rust: migration: implement ToMigrationState as part of
 impl_vmstate_bitsized
Date: Sat, 20 Sep 2025 16:29:58 +0200
Message-ID: <20250920142958.181910-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is most likely desirable, and is the easiest way to migrate
a bit-sized value without peeking at the innards of the bilge crate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 421a236194d..882dab746fc 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -295,6 +295,25 @@ unsafe impl $crate::vmstate::VMState for $type {
                                           as ::bilge::prelude::Number>::UnderlyingType
                                          as $crate::vmstate::VMState>::VARRAY_FLAG;
         }
+
+        impl $crate::migratable::ToMigrationState for $type {
+            type Migrated = <<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
+                                          as ::bilge::prelude::Number>::UnderlyingType;
+
+            fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), $crate::InvalidError> {
+                *target = Self::Migrated::from(*self);
+                Ok(())
+            }
+
+            fn restore_migrated_state_mut(
+                &mut self,
+                source: Self::Migrated,
+                version_id: u8,
+            ) -> Result<(), $crate::InvalidError> {
+                *self = Self::from(source);
+                Ok(())
+            }
+        }
     };
 }
 
-- 
2.51.0


