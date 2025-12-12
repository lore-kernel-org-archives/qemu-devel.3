Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7529BD4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iC-0003Gy-E5; Fri, 12 Dec 2025 10:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i0-0002JE-Kg
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hv-00064e-Ct
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AD5TvnPmaG2p4oioPCNypqz8ubpMGn5del8Os1RElwg=;
 b=gAV5sMRWKK+6Zl6mA5Pqadxt92q5LWr6vNsHLpXXvJjXcvZfArhbytN9fst3Ttw8e0lInu
 e4+fJ9SYeVp8pnOnFJ4u5wLd8V+gqK0kp2/Bk2APBOXhvOfAa+K+NHIKDrQvNhwiTBdOMS
 kjJ/1in07IJ82V7kgwvfMBbrFRIRT98=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-lw3So-ehO5Kukz2avpCVJA-1; Fri, 12 Dec 2025 10:05:21 -0500
X-MC-Unique: lw3So-ehO5Kukz2avpCVJA-1
X-Mimecast-MFC-AGG-ID: lw3So-ehO5Kukz2avpCVJA_1765551920
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-297e1cf9aedso23819865ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551920; x=1766156720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AD5TvnPmaG2p4oioPCNypqz8ubpMGn5del8Os1RElwg=;
 b=hTguHqd6qToLlck9A9lBA63sGUVAOedLTZhMc4XC3lZyUndDJcw/xXlAGXpV0+z5so
 qswi+yMkEIRzzgBqUFAviMdwpYANZKxjUwqGP1fhCC/ReqKaOQ8u//L3mLTD/V/Im6FU
 F5LTEKe0Naof/7yWlpWz01Xdc+NHbUURhVcsaP+RgNwWtzUMUdDkseoYa96F9xzSBBJA
 9MxCsFAvI8+8BGg6C094gJ+gs2E4yveTGQIgBWbRAjILWF1ChOtrObBvdpWj8U2KYFUj
 ITfO+MniLRaTTxD42Gp5ZrLw+EOkDgIzGbpjkdDajOYBV/bxVsymfp9TDaU7Aux7JP1+
 VtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551920; x=1766156720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AD5TvnPmaG2p4oioPCNypqz8ubpMGn5del8Os1RElwg=;
 b=TMkf9PoPHc2y29aEzC2KlAsW/4fnVkoFK4kmuTRqeUYkLE5HzQJPQWAEBCRm3O/+21
 OCFHB/8CXbvJqQijpgKB7dyS45V0C+0VrA4i9miS9VjQnBvHG4qbvmQbMP0Qfg+D8csj
 +eFWHM5xJ5LBsLKj2bbdguyRXwL/oo6NNIOVP+bZzhZyZK0oGu0y2vCbMrTDaXaBTVVP
 T4oLA0BT/ykTnHUZ9euPW+uI3XX0FHxjprGTH1jRidiQGwWeZQn3zXiBph9oC3Qhn2Hv
 kybzHBHtmlcBSw0laASPrdBoJ+w+0o5bNUh+Wl8UmGGKrlk9yQ49akv7UTWjkrVLWyD/
 10AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoxVZpeGU0itJPreUdaFr8YV/DuuO+aT7LuItUZ2+VQHcxtdmvAj+pmi3Q42J3rnHC7x+3dd3xL2wJ@nongnu.org
X-Gm-Message-State: AOJu0YwDuTgXH7/pndAL8pcFbgMYcWnMif6Atp+a2FzANUbCRYteJGka
 XzWtrn63jDx76/CPv/YXzcUjLvmDNkpDyUz67F3DVBckiHxkYBXx1tGnav1ZGkm/iB2ZmZ86ZK2
 ifrB3vN4aEBkRaKR3qR6h03wVBueZx4sjxE0Ah0J1WDxywTVtIH/oHR1J
X-Gm-Gg: AY/fxX6cMM9wZtHRA0fNbq94DWZIhESlmtB8dpQLaQd6isXaPs85YWLwDuUutflEdfj
 CMmTOOOItbRtWTizh9dsCtPa7xZsGj8lfCHeA9+txDe/CEgWiJnqYzkXUwra6hpucSxve8RIdsl
 NDogu7ldm3qw03Z+bwyKsmI8E8zZsNmZdhkOWSynJ+fXYzHwLQXfi3py1vQWG4j3C41aTomfUwk
 zcwCB6ayo90KjlARiy4AP1qtt0+0k6W1Q/eNPXZbpi+U/97k+q9flQmqf+3bvhUSqltaDs/h94e
 09WczN9cnjI4lezJtn5rD01lgNgW5YUoD8vEYqAziTZPcae6KW4OEdyLSkHKUc9sALjJt3b9RbI
 c5IJAZgYKpVMXhNg6MoscVxOr75ubawZ/Piw1F3NQKOc=
X-Received: by 2002:a17:903:37ce:b0:295:195:23b6 with SMTP id
 d9443c01a7336-29f26eff462mr21754465ad.55.1765551919604; 
 Fri, 12 Dec 2025 07:05:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtEEFZPyNKKCDsh5aLQtzNZu0DfrwfLsiOJl4sm0R3t6SN2FzDZ5y63d85tglByziYc9oKwA==
X-Received: by 2002:a17:903:37ce:b0:295:195:23b6 with SMTP id
 d9443c01a7336-29f26eff462mr21753995ad.55.1765551919077; 
 Fri, 12 Dec 2025 07:05:19 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:18 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 17/28] i386/sev: free existing launch update data and
 kernel hashes data on init
Date: Fri, 12 Dec 2025 20:33:45 +0530
Message-ID: <20251212150359.548787-18-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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

If there is existing launch update data and kernel hashes data, they need to be
freed when initialization code is executed. This is important for resettable
confidential guests where the initialization happens once every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1212acfaa1..83b9bfb2ae 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1791,6 +1791,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t host_cbitpos;
     static bool notifiers_added;
     struct sev_user_data_status status = {};
+    SevLaunchUpdateData *data, *next_elm;
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
     X86ConfidentialGuestClass *x86_klass =
@@ -1798,6 +1799,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     sev_common->state = SEV_STATE_UNINIT;
 
+    /* free existing launch update data if any */
+    QTAILQ_FOREACH_SAFE(data, &launch_update, next, next_elm) {
+        g_free(data);
+    }
+
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
@@ -1989,6 +1995,8 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
+    SevCommonState *sev_common = SEV_COMMON(cgs);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
 
     if (x86ms->smm == ON_OFF_AUTO_AUTO) {
         x86ms->smm = ON_OFF_AUTO_OFF;
@@ -1997,6 +2005,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    /* free existing kernel hashes data if any */
+    g_free(sev_snp_guest->kernel_hashes_data);
+    sev_snp_guest->kernel_hashes_data = NULL;
+
     return 0;
 }
 
-- 
2.42.0


