Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952DCD25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSM-00079q-4O; Tue, 27 Jan 2026 00:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSF-00075D-Rs
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSE-0008RX-A3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=aJ2U/G6/p60LYZtRtvHdLseZQgXFPNy4bckKriFL9+2/qujnaxBhDSWvzacY2wkytn4rUC
 MoXtZVh+ewg0idEq1rSbjjOIn0LYVMW98l4UZNe91moh2IwFBGJ41Oa6AT+AJxs9KA7tsL
 13kJmAkJG4JaeWqQyE4lrlTpQt7YWTI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-HksFdxf4OCSMxIPzWSFr7A-1; Tue, 27 Jan 2026 00:17:27 -0500
X-MC-Unique: HksFdxf4OCSMxIPzWSFr7A-1
X-Mimecast-MFC-AGG-ID: HksFdxf4OCSMxIPzWSFr7A_1769491046
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c38781efcso4921072a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491046; x=1770095846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=dX6fdI2gMgj4yvQ+wpXmcH8nFNHq/FjUrKb6r0cDUyxkrgjtRob95Dz3RLZtdyKzb/
 bWbDHfASJBysKAdVWbVg9V3q21zg8xBQ43wUgJ6MMXXFAKtlMKs+bRKpifp35SNyH7KL
 2utYth1R830V//P+kahaWYtnl76V/P/ORr/+IdHqc70FfJvEfIh/6PFJfbR3ZRXXtyCA
 qqyiol+JuU/pCa728lMWW2Y6vI5aIEj6lMZHCNkYTZ1CYlr0/P1wbO6iJZ/hP/3xOYrs
 8NRaDyVgPDGYJkZMtAAUnbmtOH9LRZO4ugSCNUuLjBcXqfQMhrIuJtq32nsY/2HpSX5Z
 vm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491046; x=1770095846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=NgY8Bx4QQnhjc8j6vydTlohj7F6/4KF3KgVymIGqEds97SgziY5YGG+Ied/YOiTzMl
 nc4pwW7Gm9vWyWaIOAAZiV0FPj51geusETFckRhmBo/naZ7m7bbiFnD5Eey3CFVTTCVh
 aJbcjpejdyjcByQSXNJx58uxnhXmIOMUfqV8ZQ7D25H/+Il+1cYU9CyxYdvbMZEOOkmX
 bDAA8WxHK2Gzd7/MDOBdqJkU6I4MZWnqk8zY6xUjGb/69lLvDhZ8cx1g24z+oHt9mwYe
 Zw3AeO8+YLGozQkavs5YsHR8L88MKIXe/qqErwoJruS+E92ho+3vEgfaRmen/H3FVuRX
 f/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJhlCPZaLxSxdnOzKolwLgrITzDqzsCGUd428ZXsPi/xTA8if0pGeQ0PFydeJKQZU/KEt9fvZZ45VN@nongnu.org
X-Gm-Message-State: AOJu0Yzsx+yLTSmH/iFG2VhGtU6HT9Vm470sP9d7IxrjIP/cgP5YYn/t
 dNk5x+WNDP/u+3NZY2ObgHKux1INrhUu2XE9Evoch1wq2EIw3aYRSRPhxIjqZ7tQxbxADkWmaFG
 SdDa1wmhx6tXYfMYEORQlUXyUHc0RrLVCLZXKkMXrtbH9wEKIZhKpiFVJ
X-Gm-Gg: AZuq6aIl/5U3Z1JiY+CEU/Ob719rGkDVpxdVdonstfhAQ2Yb0B8yAwahVlLfLdzzokK
 8Dv6dprgQ2G3GzPoDnvAepanAyvSJgWYiI3jaHygdgjbL3fMYvwUd3dZzXZEUHlLFwOaTtN5ZO0
 x9o/meo6gQwv6QtyXv9jcAX9B/OhGC1MR60F4ypypL0rrDP1eSfYAflLNnTxlDbqfWtJGui48dt
 xAQmwi4CSBdS/DewXm4pSgF6S3dcL9SXGxoigP1I1mtm13j07wpQolRC5yAhjK8wRoJu70UyDjb
 R6EsmK65MWDdiANLtobw3yp4CPAWYHllz5f2+hi4l1exL7//RbHLwqbIo/e4R/k1jDLT4nBobo/
 Yl2qO6J8DUCYW6DM6EP3xv0Z4uexl4UQCkQ2l8uotfQ==
X-Received: by 2002:a17:90b:3a4f:b0:352:e27e:79c5 with SMTP id
 98e67ed59e1d1-353feda98damr596439a91.31.1769491046547; 
 Mon, 26 Jan 2026 21:17:26 -0800 (PST)
X-Received: by 2002:a17:90b:3a4f:b0:352:e27e:79c5 with SMTP id
 98e67ed59e1d1-353feda98damr596430a91.31.1769491046173; 
 Mon, 26 Jan 2026 21:17:26 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 17/33] i386/tdx: add a pre-vmfd change notifier to reset
 tdx state
Date: Tue, 27 Jan 2026 10:45:45 +0530
Message-ID: <20260127051612.219475-18-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


