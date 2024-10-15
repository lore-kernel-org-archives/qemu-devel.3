Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872F5D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iN3-0005pI-80; Tue, 15 Oct 2024 10:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN1-0005nC-Tb
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMx-0003JK-TA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeHR+bg+4MGJxeuC/Jh2T+RPWl430P80c67UPkpQeJM=;
 b=LDussISxS8BKgXyi0y/csjxqrvm5M2ueRvsbbTgAfuYkBs/PnH0YzLL7HS457BaD9549Qr
 8YyRWbbNWiQOcAzOis1hfPu/6N2MRrLOqLDJvjwic8DiVVNXVLVp62eai1lFF44lKzEHwq
 YOiVZ+iPoxPW6cwALobIv173aaoJtzA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-luai4QirOZaTpIeQ1PeCNQ-1; Tue, 15 Oct 2024 10:17:43 -0400
X-MC-Unique: luai4QirOZaTpIeQ1PeCNQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so1341501f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001862; x=1729606662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeHR+bg+4MGJxeuC/Jh2T+RPWl430P80c67UPkpQeJM=;
 b=tiRJ3w8TY/ly6v9cZRs9o4m7q/1Dm72SQSA728jBuHBreSq5EFu4BZoNPmivOim2Cp
 kGhltZYYxiy0VissPZN/JXXA24mWndMD3BNvaecEapN+EK1AqefJF02zhHocTg80FQLL
 sbFadUs7ETmFONgKJv2gC0z//DqkI/3vA/k3C5jgo9pnM4r3yGfx62p4PwpzTSTZWYba
 5pk2M3PrxQNtU1/g/eh8mcI7CY3EUu7bUFGDRqQoA989Gv23ZWtyhBtutBOeaIWmMMSi
 IzvvQeZqKfTboZJ/lfleZ9/ot1G96TdqBRL/nNyTHArxnDwF8Qd0kxBLbggSQczM+KiO
 GDMA==
X-Gm-Message-State: AOJu0Yxf+vjbNzVZNXrcVbo6wZHqZO7tAwPBW3DbnGnpYkwz75l4QLUB
 +0rDW9GDPSYE4Idi5tijwZHAmUM1zQgXGQZfamqRpRf/xAkfuZzkNdx4NJPTj2uabiiMfQbg38x
 ZN9w+RZOB4ph135j/f0FB203ABm8rytRInDnT+3cVxqSVI1uwR2fzXZgCU0FXhLmtua8YXCUqOZ
 Fw7sKebPflG+ab77sLpPrP1qsdmlvO+CucbRvSN8U=
X-Received: by 2002:a5d:608e:0:b0:37d:3eec:6214 with SMTP id
 ffacd0b85a97d-37d5529d96fmr10826378f8f.50.1729001861969; 
 Tue, 15 Oct 2024 07:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXowqr775a7cxDXpjiAE0OixFS0x134GC7jhaqytrue1QqfEPhT16TmrQ2Mw0qAmUswdbKxg==
X-Received: by 2002:a5d:608e:0:b0:37d:3eec:6214 with SMTP id
 ffacd0b85a97d-37d5529d96fmr10826355f8f.50.1729001861469; 
 Tue, 15 Oct 2024 07:17:41 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa90a33sm1701897f8f.54.2024.10.15.07.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PULL 08/25] target/i386: Exclude 'hv-syndbg' from 'hv-passthrough'
Date: Tue, 15 Oct 2024 16:16:54 +0200
Message-ID: <20241015141711.528342-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Windows with Hyper-V role enabled doesn't boot with 'hv-passthrough' when
no debugger is configured, this significantly limits the usefulness of the
feature as there's no support for subtracting Hyper-V features from CPU
flags at this moment (e.g. "-cpu host,hv-passthrough,-hv-syndbg" does not
work). While this is also theoretically fixable, 'hv-syndbg' is likely
very special and unneeded in the default set. Genuine Hyper-V doesn't seem
to enable it either.

Introduce 'skip_passthrough' flag to 'kvm_hyperv_properties' and use it as
one-off to skip 'hv-syndbg' when enabling features in 'hv-passthrough'
mode. Note, "-cpu host,hv-passthrough,hv-syndbg" can still be used if
needed.

As both 'hv-passthrough' and 'hv-syndbg' are debug features, the change
should not have any effect on production environments.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20240917160051.2637594-3-vkuznets@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/i386/hyperv.rst | 13 +++++++++----
 target/i386/kvm/kvm.c       |  7 +++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 2505dc4c86e..009947e3914 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -262,14 +262,19 @@ Supplementary features
 ``hv-passthrough``
   In some cases (e.g. during development) it may make sense to use QEMU in
   'pass-through' mode and give Windows guests all enlightenments currently
-  supported by KVM. This pass-through mode is enabled by "hv-passthrough" CPU
-  flag.
+  supported by KVM.
 
   Note: ``hv-passthrough`` flag only enables enlightenments which are known to QEMU
   (have corresponding 'hv-' flag) and copies ``hv-spinlocks`` and ``hv-vendor-id``
   values from KVM to QEMU. ``hv-passthrough`` overrides all other 'hv-' settings on
-  the command line. Also, enabling this flag effectively prevents migration as the
-  list of enabled enlightenments may differ between target and destination hosts.
+  the command line.
+
+  Note: ``hv-passthrough`` does not enable ``hv-syndbg`` which can prevent certain
+  Windows guests from booting when used without proper configuration. If needed,
+  ``hv-syndbg`` can be enabled additionally.
+
+  Note: ``hv-passthrough`` effectively prevents migration as the list of enabled
+  enlightenments may differ between target and destination hosts.
 
 ``hv-enforce-cpuid``
   By default, KVM allows the guest to use all currently supported Hyper-V
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1ec4977a8e9..fd9f1988920 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -934,6 +934,7 @@ static struct {
         uint32_t bits;
     } flags[2];
     uint64_t dependencies;
+    bool skip_passthrough;
 } kvm_hyperv_properties[] = {
     [HYPERV_FEAT_RELAXED] = {
         .desc = "relaxed timing (hv-relaxed)",
@@ -1062,7 +1063,8 @@ static struct {
             {.func = HV_CPUID_FEATURES, .reg = R_EDX,
              .bits = HV_FEATURE_DEBUG_MSRS_AVAILABLE}
         },
-        .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED)
+        .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED),
+        .skip_passthrough = true,
     },
     [HYPERV_FEAT_MSR_BITMAP] = {
         .desc = "enlightened MSR-Bitmap (hv-emsr-bitmap)",
@@ -1471,7 +1473,8 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
          * hv_build_cpuid_leaf() uses this info to build guest CPUIDs.
          */
         for (feat = 0; feat < ARRAY_SIZE(kvm_hyperv_properties); feat++) {
-            if (hyperv_feature_supported(cs, feat)) {
+            if (hyperv_feature_supported(cs, feat) &&
+                !kvm_hyperv_properties[feat].skip_passthrough) {
                 cpu->hyperv_features |= BIT(feat);
             }
         }
-- 
2.46.2


