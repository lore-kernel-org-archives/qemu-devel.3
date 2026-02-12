Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70EEEDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9m-0007qM-KZ; Thu, 12 Feb 2026 01:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9l-0007qE-U4
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9k-0005Gn-KH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=A3NhNfBDB5ZwFLkZypugI0rN4zUe5OU7WZ/ArY2YtGXxK6k5XrZeoLjNdviA+dN2+crx5Q
 tzpFlGjVyZUvbmmVG15O8jAWjI1fBboZEF9jiDETYNsW5KfdG/kmF71/GxTmFrdpB+POoD
 pvG8FJX8ZonpXu5wqENU6c9P3YZ+/WU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-1re6DG6JMFybbm4PjIuCag-1; Thu, 12 Feb 2026 01:26:26 -0500
X-MC-Unique: 1re6DG6JMFybbm4PjIuCag-1
X-Mimecast-MFC-AGG-ID: 1re6DG6JMFybbm4PjIuCag_1770877585
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c7febaefso5792037a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877585; x=1771482385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=CH1JpQQIPUwmKk9zZkC2O68HIfjm1Rk4ECflAMum467A1jwjqphqqd5d1hWdht+FrA
 hXrqnvqvcjiq20JqrQln/1T6+akiH0gr18OmNPAhDa5Ga6mKjxyUZskcU3UyQCdYkG2Y
 rWRRAmv7ohl9WLhnF2/ToV+tF2agme9YJ27EfYonfaU9wwBZX9ByLckCh9VHx49ZlxfJ
 sLQe7PybsBaSin7XcKsAgKB2z1wmcsufgLdMAVULMYoUs9C8r9Hrtcegy15HXNzGxqBo
 x8FTqapyq//JCHeZ+z+b8Y1MBKrrGDC0JMzab34gOE9iIn7TMBDQHNAqHlzeNtLw84Yb
 e+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877585; x=1771482385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=RF43A9eZFE2DMDo6y/5FxYS9Hl3FyweGNEoJpvbeWymso9lRBOK0Q7EF+NGwYb85dv
 hnaOHJd1Lc/rPF5oklTG4fhjajKr0m7eg1ZTjVJg1YdZutLZHqxlDwtUQeEV3bp7A98f
 E1FlGnTCHzsNuFaHDlOMLZF1060gOBSTEdopxYf5/+BZUis7DYmOlyDQfOx3VVtoP9a+
 ZxGepFNiuVpUhzBraprYGG6kr94z6KIjY+HbW921Me76ZiY9+6OmeK/wNJOOHpG0cyOH
 +XERAcaccBtc27SWDyD9M8pMN1PcewTypdck4trYavNcj0YmVTRhHCrhnac6rAydAUwG
 nM5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8y9i7/XZLfTw4SkA28KVyGZkQDM8YXqaipiFSVtBjGn0zwqAb2EIDtsYiwtsjKMzQj0h+crvPK+J5@nongnu.org
X-Gm-Message-State: AOJu0YxSbiBSV64e5OdvbrNvvueb9EKs/IpKRbKvtF+8x8MaIx9p7VVo
 NOXMg+dal/fdD3lSw/zGGbjln3ExWehNnhIe4soFovIzC17dD5XuaFB+k16sd2Bi6IKy7ivIeA5
 /cZU6D3P8OSq1ve9cREP+EVoPsafpdL48Y+lvvcrV/gAMfXcRlxckcM++
X-Gm-Gg: AZuq6aIdFAu1fnqumKuskDsS6VPhalemjXCiZGvBWDDTRii9vt60XiWvEUVZvcl+xDR
 ZO+vIG1Wt+Be4QDuzycQzQG+ZMDVO77y8PVQ3uHuXj8VOylJK3IMpEdwV2FGb+W2BBboShc+I3b
 nTShO5TTJRgqX2isknh7F/a3wc5paLx6RpczCWbvg/2TG8EBN4MMAfGk62zAd4hZ5eXoCmfHHs9
 C4tZvyNw+ebg+5WQv+fv+3vRfUQWnMVV018iCVRh6QN20N6wWBGEZVn6FsDuUBQ9DXRSP8TW2eN
 ru2KqFelenTt04iTsKoLixe8qgcLOKqpp5bq2WDamXZiWPqKYT0+eFOPkAVExEZVlz4wxVvKK7B
 YOMxfVYBm/fPruvB7p+I6GsAKp29GxBTsbOxIppsZpRT5CovY9fBNBMM=
X-Received: by 2002:a17:90b:3f8c:b0:354:c7f8:6d7b with SMTP id
 98e67ed59e1d1-35693dbbc2cmr1055216a91.27.1770877585310; 
 Wed, 11 Feb 2026 22:26:25 -0800 (PST)
X-Received: by 2002:a17:90b:3f8c:b0:354:c7f8:6d7b with SMTP id
 98e67ed59e1d1-35693dbbc2cmr1055206a91.27.1770877584981; 
 Wed, 11 Feb 2026 22:26:24 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:24 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 16/31] i386/tdx: add a pre-vmfd change notifier to reset
 tdx state
Date: Thu, 12 Feb 2026 11:55:00 +0530
Message-ID: <20260212062522.99565-17-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


