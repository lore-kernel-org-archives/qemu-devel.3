Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4872BC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bf-00023h-Nr; Thu, 06 Feb 2025 13:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bc-0001wN-A8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6ba-0001XO-TE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzg4G+B9CUg3Ih4BbOgM+Ll0JBlL3MkCPC46o9u780Q=;
 b=iuiUazTYQRPtNAKWpRsEVUZa9CmcGcxv1qDifdbqmcCOOPW5mVypHJlVpw8aKGNuQPPkE1
 UvNLiXma9wlF9eEIBn0l8nkkydck2hMfXUe3EZjZsUxV+oWLNLGLqRhQp9qUxLDFkwv+sL
 XCic7j0UfSq0KMw1zD2goT4Qwpso4uw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-uVCsIMuiP2SW5OIddV0M2g-1; Thu, 06 Feb 2025 13:28:00 -0500
X-MC-Unique: uVCsIMuiP2SW5OIddV0M2g-1
X-Mimecast-MFC-AGG-ID: uVCsIMuiP2SW5OIddV0M2g
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so10415085e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866479; x=1739471279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzg4G+B9CUg3Ih4BbOgM+Ll0JBlL3MkCPC46o9u780Q=;
 b=xDJ7BtkQe6Qt/XF+3LqY9hFn1ADEeTh5WQA2LlJjd/KROSbdRV8WuRmGaS8ZfB4eeg
 Eg0AWqscMw0w33g8oaNfUb8P2bRco00qEHObeZTMyKLzpjwKktD/rMa+8t9lTPcMuiot
 YP8wL+euECDIk5MfGH6HuNQ5MiN4dS8EbyrTHr9U4t7GiuR8eKspNvQjlKMRrro+ExF7
 Q5fLwLMsS2FbQbxDAzYoz6k0kT6L80NqZRbU4UhwBrZwuKkHaaZkrqMdqpS560hlmVET
 nHi1d6/AK1wJoBV/N7vCHnfqNP2wGBFGrgHzpUdhp7cCrOtmihNKs5+PwFOiDL3kdvsm
 1ifA==
X-Gm-Message-State: AOJu0YwXGpSU9QE0X7WH7NGyJkLnqcoIfBHSN5wYc6EcN8nQtqxISJ11
 r7k0RdBdl85Q015qkgFZetuDU3tkiF7RSHhY8jUws9NVYYn3Fb2AKK8WIZmk3UUTXwGZ6I9YD2n
 PrmJimYB1UIDEEtjUgsxlsZ/Q2ljmuh+1ix6GIeGJGT9P6/wiOgVDzDhXyYncE+9EzuOdikC+EK
 WVXMpxoS3l+xc39dB93xIzIcIC4MDKfFcMTTLOWhk=
X-Gm-Gg: ASbGncv3Dng/25ySqr+MbJ7Cr9+OtVkXgVGvebn3dqqRUNQtnsUSs2Rzxx289kTWfzM
 NHwSzsRWL7NpOXJk4qgcH38LFPL8J9yWkFCjLVJs5wzpZD0ecbbxcIfvk4zGS47KdmgNt8kDeUP
 NlIlh6ZnsipDJfuDoyYakjD2fipLnK7UeYrB35BH7njjMZszhvz2i3GVnARB2n0+BfWpMwRwCi0
 yWWGTAZtaVisJSYeSKV44dDWcyok35PuD3olk6Vl41U6ssoodmKlF+9M3oA5Gd5K7ur9p5jx9DU
 NuXoXmw=
X-Received: by 2002:a05:600c:4687:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-43924991398mr4588195e9.18.1738866478821; 
 Thu, 06 Feb 2025 10:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEImlL96q9n+S+yuGxnqHkXwAljSTc0bco23rCK0vHAO8DG8vnwJVm4tYqwy+cC0lGOqcThhQ==
X-Received: by 2002:a05:600c:4687:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-43924991398mr4587975e9.18.1738866478336; 
 Thu, 06 Feb 2025 10:27:58 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d933794sm64995405e9.7.2025.02.06.10.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 21/22] target/riscv: remove .instance_post_init
Date: Thu,  6 Feb 2025 19:27:09 +0100
Message-ID: <20250206182711.2420505-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Unlike other uses of .instance_post_init, accel_cpu_instance_init()
*registers* properties, and therefore must be run before
device_post_init() which sets them to their values from -global.

In order to move all registration of properties to .instance_init,
call accel_cpu_instance_init() at the end of riscv_cpu_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b0a28c065e1..006d8696216 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1084,11 +1084,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
-static void riscv_cpu_post_init(Object *obj)
-{
-    accel_cpu_instance_init(CPU(obj));
-}
-
 static void riscv_cpu_init(Object *obj)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1149,6 +1144,8 @@ static void riscv_cpu_init(Object *obj)
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
 #endif
+
+    accel_cpu_instance_init(CPU(obj));
 }
 
 typedef struct misa_ext_info {
@@ -2780,7 +2777,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
-        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
-- 
2.48.1


