Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E4BC9EC91
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuh-0004Z2-2o; Mon, 12 Jan 2026 08:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu4-0003BA-Tk
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu1-0003o7-DD
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPSeElKfzh/NRDXE944Lw0xULTqcWEbvHtXeuMQwV5g=;
 b=EkQgP69PHYlwxxM98uTv4Yh6v1a1h+XR14Ndil3E8if4z12FSxFS6Oi/lhpxEUEV+JHhVk
 RCVeInIXDW2+ykRoN90CwH7fWttxA0c8URymAhNw3PzxmJXjoMz2PqOYClNK5DVit5jYuh
 PYQZgxFJ+YhJWUfZxh0fvyk9BPcyMSg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-mM1FbyCTMA-LeAPyL26WdA-1; Mon, 12 Jan 2026 08:24:11 -0500
X-MC-Unique: mM1FbyCTMA-LeAPyL26WdA-1
X-Mimecast-MFC-AGG-ID: mM1FbyCTMA-LeAPyL26WdA_1768224250
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c503d6be76fso7436143a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224250; x=1768829050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPSeElKfzh/NRDXE944Lw0xULTqcWEbvHtXeuMQwV5g=;
 b=DuEy/P3e1FCHErr96CUJYODcf1A/V/VG9NEUJesOfxPoHr/HSSpr8kyRgIurpLE4HR
 hnYdFngewWE3IxiDUKCIDY/eDHUxN0qQSxmLl7HqWWoPpFWhlBJ+pSFSiZa4nQbh3eEN
 siE8Qa7XoIh+rQdQxABDbHlT74qW57TG1inx8Tw8hfcFm/+fExovh+MZWd3Pxk3RvKi5
 YuP15P6QAv9x2O7u+iadvRAOtDvF/JWhMSM7Oe/0U105Owl/LqPk+yOF+FAKhiBDKoID
 CIFAiFtbaCEYb470MHHiL+AcU84J+f//BJ9EVl4dR34qoZe5KrL1Ui+2qtPP8TUqWF5S
 T+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224250; x=1768829050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PPSeElKfzh/NRDXE944Lw0xULTqcWEbvHtXeuMQwV5g=;
 b=eAbuEcbOyNRUhbVDK+U4mO5APC2rdCySs6ochLZ/6VYu4gUtaqvG+Dq42wUy11rjqv
 DznsPJj2wLy77xIx6pu5hO6MT+OLGGhXttzrxfJ3gzGw7C2r5bY/R2rJ7ejoq7MfFPtN
 /3dRK1Ue82xBVEuApRXNRBTiLvLO8D4pjfjk579vv7PYvUpZDB4Jh359VAnlMPybkeX/
 BzhyznVjJZWHfpYWi46eXMuZ6SPMXZVPyrr/SPZA0s0rDLFtqY4FYNdDMHHG4a95T3fp
 +yjuH9VrMdWLSIts7X37zMvFPuiXNBtZ9NECgl81agdujPXUboJQt11zR8LcrizIQpfO
 o9vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbUfhe6k2FfBXbWp6BhjVndLmXhvbYMpANa1Kzt/WTGC0R4vXNGI0VVTTQvfZqxNoPt9FOwQkqIWYc@nongnu.org
X-Gm-Message-State: AOJu0Yx9R9Pz+GQ/0VZgXFWPAEuU9mRU5Cb4yJLGSyHQDNkJnnrwAgMp
 LQjRBqxjWJYae8c1ubgrthK5Sq3vbrU8g9zLp8L/w0MHnZL9OnR/IC7OSr4KXzqnSHw5AuHcZGa
 sVhxCA9xfQ4+Neh/vJqXyjMFxgp6BJ7mDrWzPCVBZgDndMK0H3bgMEDAl
X-Gm-Gg: AY/fxX4frJi/3PL+VjsMLUKjqTt0fS6uLqCGdL6sHdIpukXgIBG0p3jCvPkTHgQSOxH
 Az10SqtEGqCeIGiHTTZm/8m2nEY+Gf12Vj5pTyFKYjM7Od8j9Yj3b7rMG36QoKpdBT1/XzqMjYF
 Rum5G4/PCOXPrsLRRB/rlpCGRyqYifvlMJDccyN3DlSr/oNzT2Md9rYJVqlebOIrBCbBU3w18XV
 Q+fWQ39k7wXkilSYANs3YMxMd89Th3qyeBV102YmJxlx12BNQfM4x0nkB0ysWJ9zISIr5/XABwK
 O6y1aQDakSKSdGvRvxYwbzU+Wtiu8jeDTp2xM0IhCy8PEwVFI8C8cJXOkslqlICySMh0Fp10z0A
 a1B7dLJm/V+L6BS4tDMSmr1XQtHWxiSHhEQcTW1fT6JM=
X-Received: by 2002:a05:6a20:2594:b0:364:37d:cc63 with SMTP id
 adf61e73a8af0-3898f9bc4dbmr15772909637.56.1768224250417; 
 Mon, 12 Jan 2026 05:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHSc15yFGfVcbI1IGjoSw9rY0EaQDSSheDs5+T0rgDFRDspsmetxS02pKHWpV8ityc5hwTUg==
X-Received: by 2002:a05:6a20:2594:b0:364:37d:cc63 with SMTP id
 adf61e73a8af0-3898f9bc4dbmr15772894637.56.1768224250042; 
 Mon, 12 Jan 2026 05:24:10 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:09 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 17/32] i386/sev: add notifiers only once
Date: Mon, 12 Jan 2026 18:52:30 +0530
Message-ID: <20260112132259.76855-18-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

The vm state change notifier needs to be added only once and not every time
upon sev state initialization. This is important when the SEV guest can be
reset and the initialization needs to happen once per every reset. Therefore,
move addition of vm state change notifier to sev_common_instance_init() as its
called only once.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c260c162b1..cb2213a32a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1917,8 +1917,6 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
-    qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
-
     cgs->ready = true;
 
     return 0;
@@ -2754,6 +2752,8 @@ sev_common_instance_init(Object *obj)
     error_setg(&sev_mig_blocker,
                "SEV: Migration is not implemented");
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
+
+    qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
 }
 
 /* sev guest info common to sev/sev-es/sev-snp */
-- 
2.42.0


