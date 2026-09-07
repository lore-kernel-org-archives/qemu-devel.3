Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD41EC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bii-0006qU-AY; Mon, 07 Sep 2026 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bic-0006pf-3d
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bia-0000uo-BT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788796631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5hdb76LHaeRDjiMZ4Xz5jIByuQ8SJeJucbeRZQQXsU=;
 b=YNgiTlnb+NgBHYZRFzUbmQR8CLa7uGE/gV1aOq+rgHa3yQsF7CPOKORDFM83AVayj8a1UL
 xTrLaOv6nJYaMIFg9vUCOQBhT/5KmMP16yr7bpfkUYg98ZdW0e+mVzMvyTkKtDjsTdywoE
 DEmUOghl7ur2aIuND1qQS4/nDgJ+ywc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-z0vVQkpqPfmWvXxsjXdSYA-1; Mon, 07 Sep 2026 11:57:10 -0400
X-MC-Unique: z0vVQkpqPfmWvXxsjXdSYA-1
X-Mimecast-MFC-AGG-ID: z0vVQkpqPfmWvXxsjXdSYA_1788796629
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4957287363bso30313075e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788796629; x=1789401429; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5hdb76LHaeRDjiMZ4Xz5jIByuQ8SJeJucbeRZQQXsU=;
 b=tbRpi6VpaMtMTrzivIwgxR+7cJEM5XtlGSv/7dJokpqSsT8B3VtDIUQj7rnat3ts/5
 SilXlB5oW2O4X7NP7X8RMZOppPXzzNbV2FgPNtPIbWuBUomoYxgf2Bb8mZnSW+e2G/JL
 s2TPhGy8w/jWMqXMn0E7QvemaP64wYN61j1bR7ycTxeA81i7iVxgqBm8I6uB127DHIeg
 zDPm1CS1j051X0HWKV67QW9NhnyZaICpMZlZXpBPok28cF2iW1shTMTmN4LUVTRCg+50
 l2tGvbCe5GrkKrbW8WJal67WyFXUsM92CtBNx3Axr6+wVuLiyHai/0lzopjOIoDj08hU
 qs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796629; x=1789401429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z5hdb76LHaeRDjiMZ4Xz5jIByuQ8SJeJucbeRZQQXsU=;
 b=NK9AQgw30SCqcQCJN/iSVl/AWLRAVRjdBPb1xLlldHLU3/lhonyy4LvKBMHP3eFWlO
 DHfmbjy1ySrXo7RUFEs7LzDO7VbupujQIc8l+WmazxCbR/uksryrApDNyzWbTLFZ7JjB
 AkV7lRlmQN7KYZ6Pw+0G5G7Nor9nx5brWxjsVrrJ7vAMkFKBs09tFL7z//TFYHKpgLUB
 Pb48A4ZAmodwDWZOFbcoRzdn7wbnKOI7z89IDNp01f2oH7+52MIyXpP+DQFl4nyJD5cF
 A3nJmzlfovkGl/n1R87ZMnLAK5RkpCcsVFu5pWLFfeUsNr/ttDnoHI5OB+9Vgm1eepEa
 yJbQ==
X-Gm-Message-State: AFuF++kLpXX3aSNDcfthJc1I/ADPUHxoSKLyqybh+iHKtw1B64DUw1+1
 t8KAbcTvO/AE8LTcX889JGSpNdFKWEffOYn96p5pEr/szxpYszlV+kIBvqzS15QGN+iXoGJoECU
 hnXc13HqUlNiQsr8jF1qaJmndWssMXx5I/mwQwseOhjGGg5baJirESKEZeda9h2tEH5ALXpG+Ij
 pOR3PbmcmwAxCg3G17ukey6O0FdM0PAD7mZEe99LOG69E=
X-Gm-Gg: AYBFou1VUv0jhSfS4S1k25YKVYtKJgZrXBDQ2scmmJtKFUuShV+cnknd7/cu/Q34Rrz
 p5Lz/H8EXP606zgqf44Ne2UhvxgSwfPnW8eCIrvUNQBngn3CmsxbwiOZ01sun4LvC9gCk80u2qQ
 MEQ2oyk6pOkTuZG4IKmS5S8t60or8hpM33JokoWEQtab6hL1sNuKp7u4Ouk2aITlVVUnM4nI5jx
 VaX+t9/d7o4uDUqrTelo6vs+UlVcj6XRDWK3LBMjvctbSPxQ6eF7ThDz4wXCTZBDhrD/d4Q8o8V
 nZy865G5mtQsWksAHJcAKXbZFuWelG4nfPmPnlRTGCFY9sFWeA6TmQ768mHqDS5aBu7v2BecDjw
 DMbXLBa0JfeEdRq2QmnY+GQ7ALiqczgNvDuJh9efhKMXws8rpkd/qFIf4Ir8mb8XLXj2b
X-Received: by 2002:a05:600c:1d1c:b0:49d:91d:d192 with SMTP id
 5b1f17b1804b1-49d091dd358mr118096925e9.5.1788796629313; 
 Mon, 07 Sep 2026 08:57:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1c:b0:49d:91d:d192 with SMTP id
 5b1f17b1804b1-49d091dd358mr118096055e9.5.1788796628557; 
 Mon, 07 Sep 2026 08:57:08 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:57:08 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:57:00 +0200
Subject: [PATCH v2 4/5] i386/sev: add a get_guest_policy callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-4-c8c50f1dbfda@redhat.com>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The next patch populates the SEV-SNP ID block's policy field.
That value must be whatever policy is currently in effect on the platform
but there is no way to read it back: the policy can come either from an
IGVM GUEST_POLICY header or from the command line, and the command line
sets it directly into the SEV/SNP guest struct without going through IGVM.
Reading it back from the platform is the only source that always reflects
the value in effect, regardless of where it came from.

Add a get_guest_policy callback to ConfidentialGuestSupportClass for
this purpose. It is not yet used; the following patch wires it into the
SNP ID block population.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c       |  9 +++++++++
 include/system/confidential-guest-support.h |  8 ++++++++
 target/i386/sev.c                           | 24 ++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index d60d1f6eaa..91701f1a5f 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -46,6 +46,14 @@ static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return -1;
 }
 
+static int get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp)
+{
+    error_setg(errp,
+               "Getting guest policy is not supported for this platform");
+    return -1;
+}
+
 static int set_id_block(void *id_block, uint32_t id_block_size,
                         void *id_auth, uint32_t id_auth_size,
                         Error **errp)
@@ -71,6 +79,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
     cgsc->set_guest_policy = set_guest_policy;
+    cgsc->get_guest_policy = get_guest_policy;
     cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 6d35ddb97a..27ae0a21b6 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -137,6 +137,14 @@ typedef struct ConfidentialGuestSupportClass {
     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
                             uint64_t policy, Error **errp);
 
+    /*
+     * Get the guest policy currently configured for the confidential
+     * platform, be it from the command line or from a previous call to
+     * set_guest_policy. Its format is the same as for set_guest_policy.
+     */
+    int (*get_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t *policy, Error **errp);
+
     /*
      * Set the SEV-SNP ID block and ID authentication block. These are
      * passed to SNP_LAUNCH_FINISH to provide signed verification of the
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 38f97fd9b2..f11fdb6590 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2758,6 +2758,29 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return 0;
 }
 
+static int cgs_get_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t *policy, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    if (policy_type != GUEST_POLICY_SEV) {
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
+        return -1;
+    }
+
+    if (sev_snp_enabled()) {
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        *policy = sev_snp_guest->kvm_start_conf.policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        *policy = sev_guest->policy;
+    }
+    return 0;
+}
+
 static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
                             void *id_auth, uint32_t id_auth_size,
                             Error **errp)
@@ -2888,6 +2911,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->get_guest_policy = cgs_get_guest_policy;
     cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 

-- 
2.55.0


