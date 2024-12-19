Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43473E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxn-0004U5-3F; Thu, 19 Dec 2024 03:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxc-0004S3-Cv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxa-00054i-Q2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFjwhxqsfjuevOjG/oLbzLqe5I9lt5Dktq2jkNMeE3k=;
 b=T9BLULDwVateM4r2bYJNTtzZfma0zItH2Ie6143JePTOGCezrHsCzTnCXFkoeK8lWTwfaN
 rKmQ0UCgV/1se9SQWixg/9TnKDAz6NDqDeJacN8Q21EJevk8wV0/pMAhBvkF7r0tT0njvP
 9UlmLmHSu6aeIHEWPCYuyPqyyEyP3ZE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-w-OLHRXdOYq9QELFSUeXWw-1; Thu, 19 Dec 2024 03:32:41 -0500
X-MC-Unique: w-OLHRXdOYq9QELFSUeXWw-1
X-Mimecast-MFC-AGG-ID: w-OLHRXdOYq9QELFSUeXWw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso4199915e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597159; x=1735201959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFjwhxqsfjuevOjG/oLbzLqe5I9lt5Dktq2jkNMeE3k=;
 b=OlxKKZIP8JoNeaGmXPZAA9BWtroPV7bU1LTdp4xT1zzs4Oxi7PdLaA6LradwAMCMxe
 1CbXCswBedEHTMBSvBjhoq5Aw4DEWiIR4+2TQLDQ6X6tKElDhvACIZekMujA9LofZd/M
 CgYJkHa7s5/6l5a5PKoD6hkOCLFIrVe0HVviBPAe7NsnVSdPe7Lb/l9yjwJ0mGxZun6w
 QzPJlEVGVvNo5TsNJ8Z2XpeDYNHqLNEiuMGKgLO9YeL+k0Dt/lhonQ+1oD3sP+Qcvl99
 1bYs71gDqn9C5TvPirvKus6KftbFPeUy6cFmxP47Xoy3jk/Bs2vDK4teB2qGirDGUCA6
 xDug==
X-Gm-Message-State: AOJu0YyzMsPvMaFxR8MzTYWFpaLnEJ23H6skagJwYAVFSyG4oe84MIo+
 xNrU0Gg3xxbzs2krcv43iLg6qaHVpXjX2v2QbHo3TIezrqTzesZpI1MVSzMOXqujdITD1JDnVZ3
 iFPY/i/99vsxKJRd1tggbhy6B/fX8Ofo5c7UUozW6NPelXjH2Oplhb2aiOLz2hkdUXswRVvpUpR
 6wmNtz5sod1RYsVGLftuIrgVliuxId/bGSrZ+0
X-Gm-Gg: ASbGncvKUphowAVdMIzQ4/sS1ANMQ6pSl1r09/sa4BnmVBefaDPWhr5CdRsXvgeOkdZ
 7xAZRgubi7JZVE30d1dd8Qa/EXmmCFFHJOw1AtZGfF5J/fK3+FKePbvpetL3J28JrrQV1YxIjFM
 SEVfewjy4ddvVsx/+JYyzmmMQIVTXlcBx62CQ0uCddFLLc9sET8TRus2zlNUkPhAkFdQRTeRP8g
 u8375M4djgiQTwjIVQ+B1YLSHPEZhTdLQ7ZAMq29o30zxaXE5WQi9PVeeSD
X-Received: by 2002:a5d:59a8:0:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-388e4d65796mr5705114f8f.35.1734597159112; 
 Thu, 19 Dec 2024 00:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxYvK4bFK8oz8Gs/heaVQA/Xw+b2f52+IbKLAIyYECueKiz/SKsrjxskWMlF5NkIR7yZELZg==
X-Received: by 2002:a5d:59a8:0:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-388e4d65796mr5705087f8f.35.1734597158689; 
 Thu, 19 Dec 2024 00:32:38 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832c45sm980369f8f.32.2024.12.19.00.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/41] target/s390x: Use s390x_cpu_properties for system mode
 only
Date: Thu, 19 Dec 2024 09:31:51 +0100
Message-ID: <20241219083228.363430-5-pbonzini@redhat.com>
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

Avoid the empty property list for user-only mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-5-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/s390x/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4702761ca30..263f9e84ed6 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,8 +309,8 @@ static const gchar *s390_gdb_arch_name(CPUState *cs)
     return "s390:64-bit";
 }
 
+#ifndef CONFIG_USER_ONLY
 static const Property s390x_cpu_properties[] = {
-#if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
     DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
     DEFINE_PROP_INT32("book-id", S390CPU, env.book_id, -1),
@@ -318,9 +318,9 @@ static const Property s390x_cpu_properties[] = {
     DEFINE_PROP_BOOL("dedicated", S390CPU, env.dedicated, false),
     DEFINE_PROP_CPUS390ENTITLEMENT("entitlement", S390CPU, env.entitlement,
                                    S390_CPU_ENTITLEMENT_AUTO),
-#endif
     DEFINE_PROP_END_OF_LIST()
 };
+#endif
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
@@ -388,7 +388,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
-    device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
     resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
@@ -404,6 +403,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
+    device_class_set_props(dc, s390x_cpu_properties);
     s390_cpu_class_init_sysemu(cc);
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
-- 
2.47.1


