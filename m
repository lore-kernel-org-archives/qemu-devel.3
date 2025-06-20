Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F691C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeob-0007AA-Rc; Fri, 20 Jun 2025 12:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoS-0006ui-9F
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoQ-0000Lr-El
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iz8TBbp2Wl1d26CB0v1zApr7MJNN6I1UtHkwFZ3ZYg=;
 b=FEqrve+T+HpIcsj1zQDjUZh7MgXfrBTtKZZaaQs0rtpPFZu+DIb4GM6lfGKBIHvYT07QLh
 SzZ5B5GGbEyec0DjCc/apWbB8J83vhK53NcbTf7pJpch/Ff/UOzwVSCjLqvHMNHfsBtZzd
 sNf1U7Xn9mAY4WIW2et7JRrlrXyBBUU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-kt2pXrtYM8itNwqXg3HGNQ-1; Fri, 20 Jun 2025 12:41:56 -0400
X-MC-Unique: kt2pXrtYM8itNwqXg3HGNQ-1
X-Mimecast-MFC-AGG-ID: kt2pXrtYM8itNwqXg3HGNQ_1750437715
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ade5013dfe7so188967066b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437713; x=1751042513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iz8TBbp2Wl1d26CB0v1zApr7MJNN6I1UtHkwFZ3ZYg=;
 b=fdxd2G7jHyYU711dnOglVmTf2l3ali2SD1hfZLFlNM7LxbShBkXo+yLLxYIlO5K3vi
 wt/9jlOaKJlKAT2VhnDpS3nTscGcInvsmquxsAi44L8At5wFkJWkgt7Kw0U6NQ1GVwha
 BORa3YP4lqa6np7k+JltFWxypu8v5tJrR5bX6RnXx3EY48cpA6C5ELj3fjxUsrRUBSg3
 B1tpENblFMdEupzBNWUdw/KouUDbokPiycA415ZkqgjaQfu9EVdDGKebFt9K1T0ZI31k
 kW8KOrbneKPgpwIBQNKeeceUvEKBFbVcLvdvZI1f+bxk8iTsNop8I/8jWqFHDpvhEKDh
 8ylQ==
X-Gm-Message-State: AOJu0Yw7vUFFLZ2R3kt7WAvkTvQnOBO1JRjqUX5479bP4+NqjKTGK873
 zXbB6axNWhg1rzVPeWd++bVJutN4phmu+mvtaBkrhiON6IuNEIOokm86XBgzMA3zhqBIT7MPh/q
 +Ez6xV0CabONzhWsKO+FQMdQvHVaeMuX5jhf5sndfmTT8n30zcE4GOPMn0y12sywpDxA4eVz37/
 f81Xq4BQFchDepKhpF8OitTPZHlPE6jBukUjXThTvB
X-Gm-Gg: ASbGncvFh7l81RjHVBrgE5VHUzsEFFd4VTJCxNJcG5yh+gP7A1D/msKX6QXae5ZLlhg
 zTaJQMKglq1V+jCzVhD9Vogtukwey5hlSL2s/a4yc7auRrOA5gXFkJGntorDvo5aUKE08vItLw4
 ewY28sm6T02OoKMkcEr2C8A6rHFCBIMTs4OEFJHcCeYidvNjgACpUuUW1lFOVfhqefgiDtAI0t1
 Rb6b3FlXk2e9yYQKSo59oVldN1YJT/KjJ+EfYq55Hc7rl4+bMoZn0LFxMsxHUzNqF3INhOeuo75
 PTvQ6LPkUk2gMj3UW+gBR6qmWg==
X-Received: by 2002:a17:907:d807:b0:ad8:adbc:bbf6 with SMTP id
 a640c23a62f3a-ae057c3e3c1mr346919066b.58.1750437713520; 
 Fri, 20 Jun 2025 09:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ynPxnFxxNVEuu4UWsjLDWBgwtm9FU4ZWIomywsVqP+1OA4iMzchbyZ1TgF+vpJUV3Owmzw==
X-Received: by 2002:a17:907:d807:b0:ad8:adbc:bbf6 with SMTP id
 a640c23a62f3a-ae057c3e3c1mr346916166b.58.1750437713025; 
 Fri, 20 Jun 2025 09:41:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0541b6f8asm186204566b.117.2025.06.20.09.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 21/24] i386/tdx: Clarify the error message of
 mrconfigid/mrowner/mrownerconfig
Date: Fri, 20 Jun 2025 18:40:49 +0200
Message-ID: <20250620164053.579416-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The error message is misleading - we successfully decoded the data,
the decoded data was simply with the wrong length.

Change the error message to show it is an length check failure with both
the received and expected values.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20250603050305.1704586-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index acbe7497543..2284167141a 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1032,7 +1032,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX: failed to decode mrconfigid");
+            error_setg(errp, "TDX 'mrconfigid' sha384 digest was %ld bytes, "
+                             "expected %d bytes", data_len,
+                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
         memcpy(init_vm->mrconfigid, data, data_len);
@@ -1045,7 +1047,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX: failed to decode mrowner");
+            error_setg(errp, "TDX 'mrowner' sha384 digest was %ld bytes, "
+                             "expected %d bytes", data_len,
+                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
         memcpy(init_vm->mrowner, data, data_len);
@@ -1058,7 +1062,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX: failed to decode mrownerconfig");
+            error_setg(errp, "TDX 'mrownerconfig' sha384 digest was %ld bytes, "
+                             "expected %d bytes", data_len,
+                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
         memcpy(init_vm->mrownerconfig, data, data_len);
-- 
2.49.0


