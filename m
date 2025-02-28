Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86983C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcJ-00047R-0g; Fri, 28 Feb 2025 05:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbw-0002oy-Vr
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbt-00032f-0V
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkQcwTOfjNS+mBmW7otHuAv/zQ0WMwPFuxcc5R2fDDA=;
 b=QZSpcExsfkhhafu+Eg9X9iWsRli/pesVXWNC2k42Jl/H8jvmRkfhHdz248F4NQJnDt9Nze
 EK8+uZEagJ7f5X8MZoJ7uXOuTs5MISRQFNLnzSQgaQv4Ln7OW5Ql2zouVf209lFIcnwoDg
 y8er5rgrA34YxPwGzqjlM1DM/oLR0sw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-KLmkScBRPi-SWMBdU0AF4g-1; Fri, 28 Feb 2025 05:28:41 -0500
X-MC-Unique: KLmkScBRPi-SWMBdU0AF4g-1
X-Mimecast-MFC-AGG-ID: KLmkScBRPi-SWMBdU0AF4g_1740738520
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4398e841963so12448015e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738519; x=1741343319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkQcwTOfjNS+mBmW7otHuAv/zQ0WMwPFuxcc5R2fDDA=;
 b=WWtukhn9J/QDmvXkwQEwXhDcUxkTdPUoZYfnr6p1+OWgWw1IRS+Wy6n5QbN5aIWKZg
 950IYNiYr8XOp2JkmNf6Ohy4M80ziGUgA+63wqhkR08nLi98PP7WiEr25Xi5rHDswhZJ
 704j4EpqV7fsRCpV6gUpidK52qPQYFxiALWO3gU9svPC6EHymuHgpvdaC/656mPUytwv
 +qQiZELMgT6zLt9+I9DLR/KTYEHiDun3MTIjagWN8nRsE6Dvwe+u8CPIDYo5F4sYVSro
 WGnwEPdMkO6gVwv9u2h5HwX9xEA/qFNLysAIfGo5tP+IYbV1VWzROdy6VeNZc+Zs3dmj
 OxzA==
X-Gm-Message-State: AOJu0Yxwg/g2y94cUOZhfwCQOBhJSMaH2Zb1W/NRcAd+Tq+jQfiePJ76
 oQzgCL1oCzTYHcFR6cKnOOJTWxzdxtYTN87QXExT8VW/17WOzX9pgDDBeo42a+0Rj8Fymc1uqQh
 ENQTSLzxkTV8mk2Rbz27UNv95uRfgeYJcdLhAzDccis+7uAHJk1i2lY0oQ2n9ksmlyj+vXDhiFx
 /E8yPR9SYMaMTPaIwwzzwZd2AsfdbmRH4AVhUCTek=
X-Gm-Gg: ASbGncv2zlr5TrKOfIka9ItlHHWih+XfXOgEVpYqOmnZD+YsZ0YuALE8jXxfRWzAHwL
 7pss9W2h8rEOj+gxMpPyjgeJqY+rvu8Owonbyge6EEtbpl4sDfAgJqxFYJqt+f3KaJxulCG5+gu
 Un7AilAHWVPBDWOy7C6HfGGCjcczUU+TcwQR2tbNr8kdE0XW2LOrGxjZUStCWMTRr7hHor0jxq+
 yaEwCf5zMv0guXpCeEydiqbofSx24L4BV83H/E+wFMgTDImK+IM0Xy5vNGgQJD1VZy6O+EZdTEv
 K+lofg8cUYmneO8oqc7s
X-Received: by 2002:a05:600c:35ce:b0:439:9537:e96b with SMTP id
 5b1f17b1804b1-43ba6709bc3mr23303535e9.14.1740738519512; 
 Fri, 28 Feb 2025 02:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTvs0PebW3NwygtYXfkytadKvlsQ9v5+WlSb8dBU6Efjr0ttB48OaYdm0gvVl1jsROdDJTDA==
X-Received: by 2002:a05:600c:35ce:b0:439:9537:e96b with SMTP id
 5b1f17b1804b1-43ba6709bc3mr23303265e9.14.1740738518988; 
 Fri, 28 Feb 2025 02:28:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba4c345asm87791375e9.0.2025.02.28.02.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 22/22] target/riscv: remove .instance_post_init
Date: Fri, 28 Feb 2025 11:27:46 +0100
Message-ID: <20250228102747.867770-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index ceda1a6e630..e261b24a21a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1079,11 +1079,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
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
@@ -1139,6 +1134,8 @@ static void riscv_cpu_init(Object *obj)
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
 #endif
+
+    accel_cpu_instance_init(CPU(obj));
 }
 
 typedef struct misa_ext_info {
@@ -2769,7 +2766,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
-        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
-- 
2.48.1


