Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7A6E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZs-0008Oj-O4; Wed, 11 Dec 2024 11:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZp-00084B-DB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZn-0000ZQ-G9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fir0u+8ptlpf2CF197Bj8LY/8X91SvFC4TuyE/kpTSo=;
 b=WGRsqXEPOOt6eOZwikI+WQObsZmnHJGJWT15Ht3U0Pajwv7cZzZ9K0cMhJkSBrYqGpPqxw
 tA9MlVKqcaXWSBhfgVn/ypKGJgEg3rvGUqZZB3rJLnfFSLHPsexaFyIdifUZGIgWUx0aAZ
 fBNky0NxK5bF0XO4hy2R8EFCnu5STK0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189--K7pNdq0PqSwEOW5FIerOQ-1; Wed, 11 Dec 2024 11:28:37 -0500
X-MC-Unique: -K7pNdq0PqSwEOW5FIerOQ-1
X-Mimecast-MFC-AGG-ID: -K7pNdq0PqSwEOW5FIerOQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so16807975e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934516; x=1734539316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fir0u+8ptlpf2CF197Bj8LY/8X91SvFC4TuyE/kpTSo=;
 b=Gy12X5ftyPxFNQ9QgshTeHWlyFwrIgimqHXkhUmb3X9Rd1zNv9AQ8+2XFOhNySLBvL
 xYjOfKh/qC+lV24+Hj04UhBQnC7X38LLEYYYtRhc7b484wkp65xLD8CYEQyx9pgcMzYx
 uG1dI9DQeV3QCmXEdruPtAtFy1Jpvj4ae326AqgdaHcyO8Vo6saNR9RGnBjXfnxZhvYQ
 m2y31esO3WiSWxhFQGa9UkOUsZ72MpzA+SHRmx3tJZ+7sFYhzjjp7zNjgiHXMi+veamB
 +wtRx1B/zF091IZtz1wufZv6TrTE6c0vXXiMrhZkEaJG8mUEyrqAc/F8/CZWCmkNvF3Q
 4C5g==
X-Gm-Message-State: AOJu0Yw/GRp4LQ9GhbTLxN1dq7CBYoGFJqeL45bApNvWq1ZjaN8v2372
 UUIdhzaoQagYmnp8Mwmt/5oZngN1B5gPgkOVD6JJrElAKTUdjRquiQQxhkFDexLQSAL2IQdOVEH
 M0CiIF20n0js4Z+j3QZcfsH0TneV+1xWlNWqdWLVrtMwVl6YWkfgkCqcQ6J5Vi3c0GUxID97+U6
 C+DZtlKPHr7sBCySWuoaliyOGKRTRKQYg8mE8S
X-Gm-Gg: ASbGncsVFQy2sAufVGBQ2kH/riRkhATU8F8ZPS+pbv5tnfjV7KFh31/CUiDI0XblPvG
 D0t1ocecbo4brYatRYQRb8HIoSHjf780fYTUFVsm8bWY4bFeukIBXlL2kHOT3lZ3j73bca164Le
 YW+Mg5AX7K2GHotIcTzFKKszZrlxoSXkJhrVvw2CNl5p6j8DHgpCcGsTG6PDOwjfTi2xKYmh0e2
 ILs/VEH5ZOhUj50uC0E31DDHYF/NFSdQAOvS0PfkCYSjUnSqUiDUlYX
X-Received: by 2002:a5d:6d89:0:b0:385:f10a:335 with SMTP id
 ffacd0b85a97d-3878768dc29mr173507f8f.21.1733934515769; 
 Wed, 11 Dec 2024 08:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjknTRrR32eQpKOFykRk7Mt96sKD5ztFpsNMc6XcY4rXEktA2XbAyEo9NNYvRP6l1Z77UdeQ==
X-Received: by 2002:a5d:6d89:0:b0:385:f10a:335 with SMTP id
 ffacd0b85a97d-3878768dc29mr173484f8f.21.1733934515238; 
 Wed, 11 Dec 2024 08:28:35 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a5005sm1631254f8f.41.2024.12.11.08.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/49] target/xtensa: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:27:01 +0100
Message-ID: <20241211162720.320070-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-14-zhao1.liu@intel.com
---
 target/xtensa/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index ca214b948a9..2978c471c1f 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -198,7 +198,7 @@ void xtensa_register_core(XtensaConfigList *node)
     node->next = xtensa_cores;
     xtensa_cores = node;
     type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
-    type_register(&type);
+    type_register_static(&type);
     g_free((gpointer)type.name);
 }
 
-- 
2.47.1


