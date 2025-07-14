Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939E5C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH4X-0004zX-4q; Mon, 14 Jul 2025 07:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH01-0001CL-Ek
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzx-0001u6-9Z
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4piWLg9/pXsMcb3TiD2BHuTgGHPf6VBLd1qMmuarZko=;
 b=Y3zgeAZu2yLvUCOBimWIjEhrJ2nz5yxmTOIIa6NvWddZIGDRP7ukG7tsEfff6SG3rzWnn1
 zsp0dfBQpgfgD4W0TiCDKck/GeFA3yDURdMoHAb2KJqBX7d0YKT8uUXCacOElgcJ7L8FPh
 aW/zy0DkrcOgrVbOqRaNOcDqVln5Edk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-2yRkKJEtMii5qV9BvQPvPw-1; Mon, 14 Jul 2025 07:05:26 -0400
X-MC-Unique: 2yRkKJEtMii5qV9BvQPvPw-1
X-Mimecast-MFC-AGG-ID: 2yRkKJEtMii5qV9BvQPvPw_1752491125
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561611dc2aso8324635e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491124; x=1753095924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4piWLg9/pXsMcb3TiD2BHuTgGHPf6VBLd1qMmuarZko=;
 b=JlPPm6mv3TcTWmec6Ow484mbZNH+g6D2NdwFj/0yS2YFuHP2VgSzZy2/gFO3MQYQw2
 qBa4HhF5Z34UWaCIvwzgPVrwXebBWriQqQ15kusjN/E5AG91nvhzgVOzZPVqXzVg2Hoj
 iYH1elg8i1bfBokMuPWl1GMQ6z+YK1AoLgV54lSwt7XxQj3MZvKjAFAuW5s2f8Ati9Op
 FNIY1qcDwkVHqkcs48KMWYeZACQi6sQmtX/9pmKQeEv/5cmCGtP6wptweaCQLmSBKDku
 BGNjhb0JI4feSosBBbnCLHGOhGb2s80GhxkneN8KcW9i7EkYo/MhKOm+wtYHtlb8r3xc
 Ku+Q==
X-Gm-Message-State: AOJu0Yyy/rK/xEgk1HO3Y7uDH7vsvDbctT7+aaNH5x81CA8Ah2EUfLNh
 myrKwnjec9IW+HBYYHg5V3qeR4hrY+SL5bxgRdVlQpnrhCkaqtw7XpS+DK7uN80/AfiEYTXqefg
 /xqVIA/8/FiKlKOAd5NzteX0D4aSSWpQa7JbfM7l/o5Z9GOXlYvBPMrbQhNg5/q0jXit1Pgsoo7
 1jIn37YX7JFg0aWVDDRvBKLIlIisQhQoTQvSfm0vt8
X-Gm-Gg: ASbGncs2CyjOu4DXOGqJWJ78GFvGdwRLFfMeRuDkKDOmSrRJSnRQGyn9k1GQmrmoxRS
 MAtzz43jTB5tmleKrfObxzWRN+3KVFp9KEaOms6CsvOA9ZdmnOvMFrs+hznse/CFoPHFUpjIeUg
 phT34MAyb9Kg7w4mnJSPdpFifTw/FL+ejCA2SJUnPPsJ+1Nt5yDNRxG+ft6h4ftKH/br/NOlzYB
 f3CL1RkTgpLxnSgwMOSSRvKjgnjCrJd/No+nlZzrGZVDePOvPzfoHhxmWzcrtoFcD6XBOSy8NKR
 ZI3F65BkCl0NaWyJDf2S/lygruraHdcG/+KBiX0B3Ps=
X-Received: by 2002:a05:600c:4684:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-454ec276b88mr126459285e9.18.1752491124180; 
 Mon, 14 Jul 2025 04:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc+/ULmaxrDqNpI0hd6eOH3oSnVWQyHLruBeh9qMxV1XGg356s67iG6GWieEzm8iaK5RHzpg==
X-Received: by 2002:a05:600c:4684:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-454ec276b88mr126458775e9.18.1752491123588; 
 Mon, 14 Jul 2025 04:05:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd474a9csm128750895e9.16.2025.07.14.04.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>
Subject: [PULL 28/77] backends/confidential-guest-support: Add
 set_guest_policy() function
Date: Mon, 14 Jul 2025 13:03:17 +0200
Message-ID: <20250714110406.117772-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

For confidential guests a policy can be provided that defines the
security level, debug status, expected launch measurement and other
parameters that define the configuration of the confidential platform.

This commit adds a new function named set_guest_policy() that can be
implemented by each confidential platform, such as AMD SEV to set the
policy. This will allow configuration of the policy from a
multi-platform resource such as an IGVM file without the IGVM processor
requiring specific implementation details for each platform.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Link: https://lore.kernel.org/r/d3888a2eb170c8d8c85a1c4b7e99accf3a15589c.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/confidential-guest-support.h | 21 +++++++++++++++++++++
 backends/confidential-guest-support.c       | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 79ecd21f42f..0cc8b26e644 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -57,6 +57,10 @@ typedef enum ConfidentialGuestPageType {
     CGS_PAGE_TYPE_REQUIRED_MEMORY,
 } ConfidentialGuestPageType;
 
+typedef enum ConfidentialGuestPolicyType {
+    GUEST_POLICY_SEV,
+} ConfidentialGuestPolicyType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -123,6 +127,23 @@ typedef struct ConfidentialGuestSupportClass {
                            ConfidentialGuestPageType memory_type,
                            uint16_t cpu_index, Error **errp);
 
+    /*
+     * Set the guest policy. The policy can be used to configure the
+     * confidential platform, such as if debug is enabled or not and can contain
+     * information about expected launch measurements, signed verification of
+     * guest configuration and other platform data.
+     *
+     * The format of the policy data is specific to each platform. For example,
+     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
+     * ID block and ID authentication in the 'policy_data' parameters. The type
+     * of policy data is identified by the 'policy_type' argument.
+     */
+    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp);
+
     /*
      * Iterate the system memory map, getting the entry with the given index
      * that can be populated into guest memory.
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index c5bef1fbfa8..156dd15e667 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,6 +38,17 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest policy is not supported for this platform");
+    return -1;
+}
+
 static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp)
 {
@@ -53,6 +64,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
-- 
2.50.0


