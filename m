Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3DBC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6ay-00017j-CM; Thu, 06 Feb 2025 13:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6av-000174-EI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6au-0000y8-2o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oMYSQ42CGFvDLdo/ZO8SVNdZmL4BuNaNRyk3rvfP3A=;
 b=cPgm2M7xmm0BPHCA2cT6an5XtJo9+XT1zEDrAzvEx9FhmFHoJsFkcmxJvs/wSSaByulkhB
 08z+7VPQFJo2hJ7OWI7xEAY/pyrhLoTryeBnVDMKg/dZ0vY6ilDgIkix1c2t8mhiH0tejS
 8fVjuS8mDVTba0Lwcc+ZLm7Tv0Ki3LE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XI3TJoQJMFq4SjSaj6eawg-1; Thu, 06 Feb 2025 13:27:17 -0500
X-MC-Unique: XI3TJoQJMFq4SjSaj6eawg-1
X-Mimecast-MFC-AGG-ID: XI3TJoQJMFq4SjSaj6eawg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so6243975e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866436; x=1739471236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oMYSQ42CGFvDLdo/ZO8SVNdZmL4BuNaNRyk3rvfP3A=;
 b=B5oTDWjf6ErJrNeGmLPi6JPcAUJsqphhpdM9xOAa2yFst485fpgc1E8CZJuj+kBLLD
 s1CwBv5fzDVt2BMBqjCwxEUZrcY+FTUm2r91o6H2FYSsJlCP9DH4b2jhlL1NF73JQP/q
 c+voKSMwSHjnnRpW71VqzZsirQ9itcU+6j+FGa8nAL5brvTB0BiwYfUuQoVgKJYjf6M/
 UBbatDczDHXDoBJCfjHAHoZ3gy2WMlGAqC7WkdZxis5gzKQ47YeHsZYe5wnUim3hAEln
 Un64pn56Ur+UsQzowu7Gg+ef764ckiTK4oEoHuTEgB3WS1JuYEf1WR6ouLbVVe7ez/WF
 S6aw==
X-Gm-Message-State: AOJu0YzHCEPH3kAyHfZnZOpx3rayl6GW9eJRZYvWZ+rNJMhBr7T7gQ62
 3aN9joEF/248O8gO88ek9pNOW7q6jVKO137tsqeFl47i+veGzIl8j0ReEa7muMEKb6gskfyVBnr
 AmJNnMpD2dqkzd5LEct26+q85Na+gdsVZM6xL8Gi+64QioJKnMceg0ZEacuMbfxnii88tjN92qC
 uHRp5UfcQ1vWdIYGexA7v+L7r4/TSIrzg0xBiRIwc=
X-Gm-Gg: ASbGncu07OKwUoWJRTdyke16lC9eISz57iFqDE4OdJWEFluqA7pkrj1+R7p2OjjInax
 pYcFgeSbXgYld288VoCd8+QDPwnGqh00XbVOsGyWgZww1So6Q3mLIIrydJTrHCil6X+iuXBLE52
 JEcB4x/d7Kj97BlZXDoTFND6opcmeOx29rU7/iXcvuRzx4rXJZipuXc5Mhd1EJY5SkJqRxCksqn
 hK7X/Sc5lfVUQ9K1gwE8aiYhy8SV6lV3ytrsWMExuk21cd9N200LeykfafOqOWkl2/U1iLsPfFD
 +WPB9y8=
X-Received: by 2002:a05:600c:35c5:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-439248c324dmr5377375e9.0.1738866435888; 
 Thu, 06 Feb 2025 10:27:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH84iD+gK3it3Q2F0aadBNLJJkHqpcM1qY8/yN1UjQlqz0ienVdvQgQhlmVljPyDtkJ37rUOw==
X-Received: by 2002:a05:600c:35c5:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-439248c324dmr5377125e9.0.1738866435485; 
 Thu, 06 Feb 2025 10:27:15 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd3856fsm2323316f8f.28.2025.02.06.10.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 01/22] target/riscv: remove unused macro DEFINE_CPU
Date: Thu,  6 Feb 2025 19:26:49 +0100
Message-ID: <20250206182711.2420505-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..ed9da692030 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3051,15 +3051,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_CPU(type_name, misa_mxl_max, initfn)         \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_CPU,                           \
-        .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
-    }
-
 #define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
     {                                                       \
         .name = (type_name),                                \
-- 
2.48.1


