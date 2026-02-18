Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB65E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfyT-0003YD-Qn; Wed, 18 Feb 2026 06:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy2-0003RI-R0
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy1-0007u8-00
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=U8Bj2YIikquYxY8wvYYch5bTQcUFcxQ+tp6Mjp0I/V9Rn/MRaBTJiJb/Wv3E1yj1iyF1tF
 P7Ck1k6c6+QH0YbawF1CdChdQSMkst994pj7wM1sJfX+2dpH/stHh+WA1rHvqdKMeEmq99
 5uf4QN6OerLXOdhvLQGKFs9vuSs1pRA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-JOI0P-UwOWO4SyA8ouclLg-1; Wed, 18 Feb 2026 06:43:39 -0500
X-MC-Unique: JOI0P-UwOWO4SyA8ouclLg-1
X-Mimecast-MFC-AGG-ID: JOI0P-UwOWO4SyA8ouclLg_1771415018
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aad3f8367bso62776325ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415018; x=1772019818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=VDlDoccDDQKy/3MY81V8sXducEND9q4RlWWYh03lS5pbpgkyb8j4EWUud7WoHTgBJp
 Eizo9shvUiH0itmL2cDLNveV1L5Y5tTtqndW9kXrG50LKZiYl7B3waD66roZZhCxsS8i
 iYjNVs0eWwbwXBkFOHyLCRqzaoXwD6MMiFRI/blrhqh/Lxn4ut5Ccy9jxtUdZ0U++QIj
 F5Skxc2agW5GbfiyG2pV4anfJOKue89BBjwf/FUEz4XYRAvgsF9tqy3/I+7jLxAQ1+nA
 D7jfnalAN/dZ7/9A5nNy03HYByTN2W9SIHlaLNLAjjK5HUjSjhsAfOeq2TuQgBUYfNaH
 jYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415018; x=1772019818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=kqkQ67klf1R6LfGs+le+33FyhAYUud5NeAOA6xI6LeTU5C78gI06kTkH3jGSd+ap/O
 my76m7sGRPyzmEfVhNiHqpJUZasaEpMLwL8LeVTlyrzfESuItJLWGQp2DqT2CZzsGbSF
 6LrHgZOSXhkWsPz79A0VWi9Y5yS0olCNSjwW04nNeMUmJc12JHHD2yH20Qq2Wmwpbce4
 pQwOAPALXRlTV53D4zgwwfd9EB6pqqIJ9/hgdMwwT/NmBskXA6JDxv0A/XtXa/n66b4K
 MsJiv6th+7GcbrWkwqUZgSkC5lXt29aDBfo+3qexYEdE4I4HxN9nQN6BSv8qdguvF8ax
 NVUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN/duw2H+mA3TUjN9jQ1C3/5n1eroO9BU7YjZd0yfY104ZIdFtsgS/Y9ARfjCbcjV5qqNOIs76kAzw@nongnu.org
X-Gm-Message-State: AOJu0YybNvSXn6asw2Y0ldRHzFkAmg4O5cRt8/A5inxzbn+4Z8GywsGB
 JDW8hArx4VYbYOCYGE5F7PjEUOU/H6VT/JfoOKejHMAnMFIUo1SnALmE5CJs3FA8jTkI90Yfe4C
 Lxze4m3QqYkx1rJaTgdrvHiGeGMJDHYA5IPboKgOb0UG0e2ks8araC36j
X-Gm-Gg: AZuq6aJAYkuvyQE3s5GIZwXwNlU6kfIain9oK6q86kUroQs8RiqbMBb7usBQYkqk8p2
 2oIyCkJzunZrYnLNkg1AY8ipbsqN4ob6FiA5d94HsMrfKS04C5lkO3w6ItutnBSIO8lQUd9mIiJ
 V0wLkrpj5AaN9WL+MLHqEHQeooI6mamJUOzONqrNmnP3uibDx+BLh0xN2P526iJHUvBWE34ceNc
 GgZc1yf0TzIocgiS9cYpsicpKC+AFiP/c5S9G6mGo0r7HBwacmYSpBxp0t5LSQ+Nekt6lAZ3OOB
 HEM3N2rIY4HLfbmRO43FJ1VDkzlDtJx8AwmQZiKc6SXvwlkhf8gyvKQYv6sUlYNT8uk2g0l+hI3
 WPzQ/A8X+iht02c2nRmXvEX34jkFv7X+sf9J3Uo1F+QwJ2VAqnUXT
X-Received: by 2002:a17:902:f601:b0:2ab:344e:1400 with SMTP id
 d9443c01a7336-2ad17524ab4mr175576385ad.37.1771415018081; 
 Wed, 18 Feb 2026 03:43:38 -0800 (PST)
X-Received: by 2002:a17:902:f601:b0:2ab:344e:1400 with SMTP id
 d9443c01a7336-2ad17524ab4mr175576095ad.37.1771415017711; 
 Wed, 18 Feb 2026 03:43:37 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 17/34] i386/tdx: add a pre-vmfd change notifier to reset
 tdx state
Date: Wed, 18 Feb 2026 17:12:10 +0530
Message-ID: <20260218114233.266178-18-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During reset, when the VM file descriptor is changed, the TDX state needs to be
re-initialized. A notifier callback is implemented to reset the old
state and free memory before the new state is initialized post VM file
descriptor change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 37e91d95e1..4cae99c281 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -405,6 +405,36 @@ static void tdx_handle_reset(Object *obj, ResetType type)
     trace_tdx_handle_reset();
 }
 
+/* TDX guest reset will require us to reinitialize some of tdx guest state. */
+static int set_tdx_vm_uninitialized(NotifierWithReturn *notifier,
+                                    void *data, Error** errp)
+{
+    TdxFirmware *fw = &tdx_guest->tdvf;
+
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    if (tdx_guest->initialized) {
+        tdx_guest->initialized = false;
+    }
+
+    g_free(tdx_guest->ram_entries);
+
+    /*
+     * the firmware entries will be parsed again, see
+     * x86_firmware_configure() -> tdx_parse_tdvf()
+     */
+    fw->entries = 0;
+    g_free(fw->entries);
+
+    return 0;
+}
+
+static NotifierWithReturn tdx_vmfd_change_notifier = {
+    .notify = set_tdx_vm_uninitialized,
+};
+
 /*
  * Some CPUID bits change from fixed1 to configurable bits when TDX module
  * supports TDX_FEATURES0.VE_REDUCTION. e.g., MCA/MCE/MTRR/CORE_CAPABILITY.
@@ -1549,6 +1579,7 @@ static void tdx_guest_init(Object *obj)
 
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
+    kvm_vmfd_add_change_notifier(&tdx_vmfd_change_notifier);
     qemu_register_resettable(obj);
 }
 
-- 
2.42.0


