Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D5DC83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEu-0000T2-G6; Mon, 14 Jul 2025 07:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH03-0001Cw-C5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH00-0001uO-Ec
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVHO2u8SmUDUe3LEdxt2f5AcmTsLQh2zAS3ZSUXRVXU=;
 b=S7Ixespu0aY54NX4RAFC9dcQ8mdeacPZDqe1N3JgRlvaKSzISO5RkbK5PoiV+hqKogIyUt
 cKlpyfRHhx2oXzTObBHn93xnM0Qd2d4xeHUTxuJ3Q81qfGVmkJeSxyyCE8sqVdjirbidRP
 c+r8QO7RMK6JtswoupCp7gNm6BByWPU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ZxL0rAm4NO2aocjXxU4oiA-1; Mon, 14 Jul 2025 07:05:28 -0400
X-MC-Unique: ZxL0rAm4NO2aocjXxU4oiA-1
X-Mimecast-MFC-AGG-ID: ZxL0rAm4NO2aocjXxU4oiA_1752491127
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b5f97cb8fbso576970f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491126; x=1753095926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVHO2u8SmUDUe3LEdxt2f5AcmTsLQh2zAS3ZSUXRVXU=;
 b=KF1IwXmV2NzjnMnhqexM8/MjFuplp+WGIYEpfvF1XXSrRpa9iefjzOgpZ1Buy7clAg
 zaLjpf79YWyoRsJJC49fNf5nAd/jPQjonz5+KxK7FhluJG078cwQ+AgeII561afMdJ+6
 y/8tnsRPBDXzmohlO9f6lvoIU78ByiMwZZeRSs624a9y6TRgAYHwgfvZd8fUjhr9V5KY
 TX8yGOaXyJ9K3kdKtk2Z/c+jG0+jiR7/0gI5JDCHXXMbmyYopPY2DV0mN2YyK6m3SICh
 T5PzYBaLPRAxuB8ttU5HTbgxH6D3hh5x7vVTeKxf1OOD0G0R6oSAh+nEzSYWmgo4NeGq
 koaQ==
X-Gm-Message-State: AOJu0YxUr57X0MQib6BVUOoANVIfag3YFuxLSV/JINSYNyzkcWr3939C
 XKT+Vbfr47vR1jMwWlXbfDojuz7KO9NetvP5RUpb7FVDqsZmcrDdYNgJrKq+EQJZSIpiSEt/CW8
 7ktYkDJr6/oKV2WQ9xQIFgYswXQgiamcnn6SdpGqnVeym3IvxdjGgLvnT6snapxPRxemsycQR9d
 zxe1xocOE7WVogRey99dV+q3x2zBwMlVlbXAhmeOGp
X-Gm-Gg: ASbGncu0uh7z3iI+HlQ7m21fBN63JdQD0eJi8zCK5BNNaAUrQkxb1WA+D6jSNeVqBDe
 6jrmHs6UNzvg2hYdfK2RJ+E9NhTt0G7zQH7RljTpPoILoVd6HDXMxvOkj7v8B+9Y8LDXrafgqg3
 T0jeJBbIj+jL3H0cZZE9P8GFz1ldkYvsc+3T6a30BSLZ3VPmOU+Z1i0ukgopaLFLn/nP39Rnvgj
 34y6+cFVaZ7gc7kyOkrQnDlVwWp9IML5jq2XUE2hHusgLRgPaaZe5roSIlh7j1xFupuQvr+q8fh
 k0ha5a7uVREXKqHVVnpQ2AVQYpvvrDS460gL4NxyL/4=
X-Received: by 2002:a05:6000:23c8:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b5f1895be6mr7251088f8f.23.1752491126090; 
 Mon, 14 Jul 2025 04:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4oJOvMpEE+COZ74cajQ5huM1RITiW1sbVI+/xC7GYTvyu58ggMweSEATiVK9zfoL3qMNNg==
X-Received: by 2002:a05:6000:23c8:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b5f1895be6mr7251061f8f.23.1752491125577; 
 Mon, 14 Jul 2025 04:05:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45623f4f838sm169425e9.1.2025.07.14.04.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 29/77] backends/igvm: Process initialization sections in IGVM
 file
Date: Mon, 14 Jul 2025 13:03:18 +0200
Message-ID: <20250714110406.117772-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The initialization sections in IGVM files contain configuration that
should be applied to the guest platform before it is started. This
includes guest policy and other information that can affect the security
level and the startup measurement of a guest.

This commit introduces handling of the initialization sections during
processing of the IGVM file.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/9de24fb5df402024b40cbe02de0b13faa7cb4d84.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/igvm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 2a31021d449..ebdb4594d10 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -786,6 +786,27 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
         }
     }
 
+    header_count =
+        igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
+    if (header_count < 0) {
+        error_setg(
+            errp,
+            "Invalid initialization header count in IGVM file. Error code: %X",
+            header_count);
+        goto cleanup_parameters;
+    }
+
+    for (ctx.current_header_index = 0;
+         ctx.current_header_index < (unsigned)header_count;
+         ctx.current_header_index++) {
+        IgvmVariableHeaderType type =
+            igvm_get_header_type(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION,
+                                 ctx.current_header_index);
+        if (qigvm_handler(&ctx, type, errp) < 0) {
+            goto cleanup_parameters;
+        }
+    }
+
     /*
      * Contiguous pages of data with compatible flags are grouped together in
      * order to reduce the number of memory regions we create. Make sure the
-- 
2.50.0


