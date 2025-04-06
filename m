Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CE7C369A2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K3A-0003Qs-F8; Sun, 06 Apr 2025 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K37-0003MQ-Lb
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K36-00025Q-26
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZE44lTWKdjje+P0JUfQEdLjWh7vVyRkTCgHvnMPggaY=;
 b=XLPyfcPshCchDu5d/wV4TbTgZUlJm7/YB7laMliWRbucoAPJi8k1rqKX+Ds9p3obD97Oiq
 L4Ur1rNL0alI0dXuVbAntEFRAAXiB1aVMqL/uZYkbQ6scY5EtLTWGgn9eUB2dcj/7R5iU0
 rD65RsQg2sU6HHA1lkTpRPAqX0YIGgs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-klcGE674OZCNnHryatdwuA-1; Sun, 06 Apr 2025 03:04:05 -0400
X-MC-Unique: klcGE674OZCNnHryatdwuA-1
X-Mimecast-MFC-AGG-ID: klcGE674OZCNnHryatdwuA_1743923045
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so17269755e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923044; x=1744527844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZE44lTWKdjje+P0JUfQEdLjWh7vVyRkTCgHvnMPggaY=;
 b=I4TTG2WU6TvcKv95CSbYqXQj32lxfIIVHKvprRRlEOmAl5SMA8HC94thEYoNIwp27v
 cLEo0nC+HmDQwRCwRPgCU+KCGD3qOOzG9IRpS8lMNJQFp8uLpLtCIH0KDWydaVopB+zS
 ZIk2daFFik92u0VIzm+rsWgj/bfYgdRFUZdP/selrfJKy5Y5fFmJr4Pm7IHb2GiBKK+X
 D40PQrgA0YQ3pLBzRQ4Lm7OJTKQNCq4D0yDE/ZiceM5F5if0xfqg/eJGRISY+Jyvy705
 pGVD23EqMWkir/USLQ6beGfbPZT4UTMtEIGhRWr+lp8Kme51lMbvQ5s6WU3e4KNMdrXd
 Geag==
X-Gm-Message-State: AOJu0Yxm3Ym/ah4pBVMupRQD8hoZh7Psnl0yn9ejdBgxYX4jVOKI0P7/
 ZaX7E1ErXOb6mElhtSnofmgUkcIymQqiaX5i/sQcZNoDeqd6FRc9MFE+uaF4/lYf+JHpaXnNiZj
 HcnpwlfyPc3z5Ro8FLNYa12JU6bHKUEcwBNL9OxsafjP5phc3TiaqjClQVhfW0+stllSW1drZC6
 bJPXS8YehCWR1bR9XJR3PzsZunoPt8j0sl+Xw+
X-Gm-Gg: ASbGncvJ5vIp5kEFdnsMzdoWtPY8VrF5z8nqtqshbW3HjdTQPG5vQdeskDJuqbbADka
 0hUXFk7igOFcVaLhtb8gAuc3req+oj3fJxsLd98vKkb8TVpTXyHuw3DGLOpwA1piFgsvO81Q7vH
 yT+xR2TKu7U44+EViMuFTbLTHlzVMWr5uzmTF8mHfU4v3+oeB7g7D272tgm2/p1v2oqYVlc9MfO
 gZyn0y6HYM67ZUoXUyGlaCT5fPxeFwPLVo0b0CS7ZAPyhcakynJxdDzCOiI+Ohg7XfKVMvQnbxQ
 9HPz8qr0061AhO0KSQ==
X-Received: by 2002:a05:600c:6986:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-43ecf822cf4mr65997525e9.6.1743923043851; 
 Sun, 06 Apr 2025 00:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3DbSO8VHEuDQQnRqHSj+3weUueN/4jSePuAuSxfbexogcwGLbZaNZRfbsMuawgIdFD8AaNw==
X-Received: by 2002:a05:600c:6986:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-43ecf822cf4mr65997195e9.6.1743923043312; 
 Sun, 06 Apr 2025 00:04:03 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea9a346e3sm92345085e9.1.2025.04.06.00.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:04:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 27/27] target/riscv: remove .instance_post_init
Date: Sun,  6 Apr 2025 09:02:54 +0200
Message-ID: <20250406070254.274797-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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
index 0a3a0343087..ee20bd7ca22 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1089,11 +1089,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
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
@@ -2889,7 +2886,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
-        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
-- 
2.49.0


