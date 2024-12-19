Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59C9E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxm-0004Tm-N8; Thu, 19 Dec 2024 03:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxd-0004SB-5z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxb-00054k-A8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPK5B7YtV2XjDkMxiykKFLkaimx0AMVIvQ26Q2lKHEs=;
 b=eICV+vo4N8BQskoZdr2vu1vYJFdP1E4X7JM5+BM7jHYrXMMvMn0UFvfBcJ9jDBpPXuj1hY
 +XIPSD7xsTXgxZl1wopRW4ufksFf/P8mYqNn3pEuAkl51av0M91JRsxD7tqIMT0uTObzPQ
 dUWBSaLnPs95xUEOy7qrU+zOLGn2CQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-vYxBOmMuNpCxROYuzGv-KA-1; Thu, 19 Dec 2024 03:32:38 -0500
X-MC-Unique: vYxBOmMuNpCxROYuzGv-KA-1
X-Mimecast-MFC-AGG-ID: vYxBOmMuNpCxROYuzGv-KA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso293550f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597156; x=1735201956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPK5B7YtV2XjDkMxiykKFLkaimx0AMVIvQ26Q2lKHEs=;
 b=NqYxxXZNSZ+Ekhfssvz07DNDMH7qv3pD0VDFp9GyqY4oWxL82BGkCaW1CEDyPEe6WN
 Ql40hZ0I8hACUwlmm8yB0DDYfm7tr7oJwV+ycVELAeaxCaIVH5fyWzJjP+oFXiZJjmpc
 7FJp7EDX7oDQrTfkyDRC/A1IRnZp11CLTPvXE3o4xHQCUSqy96wYvkA9lkQmQFKdtumn
 HxNKDMjcmN8OskCt8uwaYC6hexfdcCQ7awwDTEWrPSrPL6dSMAi5zquRR4YbxprH4gHZ
 HYXVG0dFrPuxbtDYDSTlAl4DpUUOB9ZlgMyZ8VnXjPyr9w8Pd/T0DxHdH/M73dUW7VXG
 f9eA==
X-Gm-Message-State: AOJu0YxnChOsvKGjLIyswJwYcWfyTj70Wve2qcv/P6mOv0eCdT9j74QH
 KbwNvUlbXyWRLADwRLFvqAwW6A1Kr27Stk9uLHKD9guKzhzWj0vezboCqV2h3PQNKxndvVLR0dJ
 hPL8DcYGS+LqukZFnBL1MxuB3TQgT+5fv3uLCXJOdfUS6Lqzk9rMUNwFvdFMrSTvhqpJuU0DzIA
 1oTZVH7pFQf4Vip+sIW0V6+Uva4pLohdkfOV1z
X-Gm-Gg: ASbGnctUiFGyg67to0Va0jy3VdEEBvr60Cizq0XmmH+RF/6P398pSuaOgVkmmkhNXHl
 V+xJj/Tk0VwbiO4sdQ7Mt/ROWYzd+U/lMcBwA8DkFvr//tIJXnuxnI/3rMtJz3k5WAMUXSc6zuo
 hBZeRziA/WEeSSWqugcp+gEdpHwjY1pWN97Ybn32H3xwVdyxUr8rE8tcNwMb8igic3co3KHgHzG
 UEvXe6U1sAoKBLEG6j1PxEpgQmttDT0pq0KZY+LAM2ib2/gok0VQym95jML
X-Received: by 2002:a05:6000:4b0b:b0:386:3b93:6ccf with SMTP id
 ffacd0b85a97d-388e4d5f125mr5148607f8f.32.1734597156002; 
 Thu, 19 Dec 2024 00:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXiJ3hfiZdwZXJlW1EnLgdY5Q2vNsdKew//1XV57xNJzp6PUBRkYmYChmzUIKN60zymaLRVQ==
X-Received: by 2002:a05:6000:4b0b:b0:386:3b93:6ccf with SMTP id
 ffacd0b85a97d-388e4d5f125mr5148586f8f.32.1734597155652; 
 Thu, 19 Dec 2024 00:32:35 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4432dsm44551265e9.41.2024.12.19.00.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 03/41] target/ppc: Remove empty property list
Date: Thu, 19 Dec 2024 09:31:50 +0100
Message-ID: <20241219083228.363430-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20241216035109.3486070-4-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/cpu_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1253dbf622c..5e95790deff 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7414,11 +7414,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #endif
 }
 
-static Property ppc_cpu_properties[] = {
-    /* add default property here */
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -7468,7 +7463,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_unrealize(dc, ppc_cpu_unrealize,
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
-    device_class_set_props(dc, ppc_cpu_properties);
 
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
-- 
2.47.1


