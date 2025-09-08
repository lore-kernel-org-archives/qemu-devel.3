Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEBACAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsC-0001dm-Eu; Mon, 08 Sep 2025 06:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs8-0001cW-7n
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrs-0000tp-17
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3FQSNcvluKEhgLR2MUjySlRLq+bsJkp7JvA9EI2Wgo=;
 b=ap1jea98G4b+0d9ee+E7Hp8gJhZUhhUYiobeOpfo3+9WyVCL8TYkqMQqM0A6wJSJ5AUs1i
 gMxT2YqoY2aF6gMVDC481+gEyc3d+9ik6nhQ0ygrbm+UUZ7QfG4NFSM5c/5uiQEhR1uHtG
 OUBjBbeO/mV2HXFALlDnPIn5CzshimM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-LU0QyyLHPfKaYonlYsokEQ-1; Mon, 08 Sep 2025 06:12:52 -0400
X-MC-Unique: LU0QyyLHPfKaYonlYsokEQ-1
X-Mimecast-MFC-AGG-ID: LU0QyyLHPfKaYonlYsokEQ_1757326371
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd62a0dd2so15147825e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326371; x=1757931171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3FQSNcvluKEhgLR2MUjySlRLq+bsJkp7JvA9EI2Wgo=;
 b=KY0jX9vWW5M+z2nT7K5uu83Ac2NO4vfhqrlo63ifsDRpDfBpJFyFwaa/0VX3ZH7RTG
 pNlwgvgddTWOdmaa8BoT9swlFpMEY9mmG5tywes4DqJKJOngIODcyqKrnu2TIbRb9vgo
 q5i30Afpn/GGHh0qoP14EcRD/AlE3Lnx6X09/iwjnkEtkG7GLMmSdRwVpjyE9qVyudsu
 EmeGNlUhdqSqEzp7Jw4mj8cswraZaGbOqaGjkUWzlAKzx43aE/fLiWiDM7L/0UC3jGo9
 Ihv8NaaOEXN8QZq9Z5JS3gsD2/tU/6HJ08hPb8rNDzj8uVxv0xKa7uZR063+0vwyVJaC
 R5ow==
X-Gm-Message-State: AOJu0YynR++0EKb/Fuoj59NME8WodzimCrSmOqhoqlKL175VGreaIXli
 TK0OEv1OwYFqdICRoGikg8jkmu2iBjEJso31zJ6dX7yW3WvMER0dZ++sApXTqMD6VGOKYZleTGh
 eKfhBPKfVEVTj71CreKQdxNQNOiCKC9ReH/APrVwg6d6Pomj/eTTWo/US0ButMVrA4hC7q84E/7
 ZC1E3mUAlPB3v0BnEmuY4zaQ0UT4MmHX/LmRsFbDBm
X-Gm-Gg: ASbGncs4d+oAcCPwJGdyWjQK6BpMCW80v+BCybOmOs8tKY3+1vX4y6szeOMPD2opYDS
 0GW52p/2KDqGVvBwRX8YzSvdWRx0WIMchuNX6HYanHpCCV3BM9ke9czYh4CmQsPMhEbwfzooRgL
 tHTgGx+WzH0sLV9Q0xPsaw/n0diJGfJYIj2y0NEFjVEgj//HurCyGRDKnEFhi+p09ai9A1lDKjv
 wO5/fWeGfYhkaqlCRLJGBa+E19GFJAXdpTeA59dtHeP/DmdYTuTDQVM/nvaVtkoKEUR/XoF+sKi
 AlQbO31xqJ2o3quqK0FqL4iBbdSUhuYi4XIWfBlk6HRgva4gDZeKHEySwMYvWqNORe2OUmN8hsk
 adpYE6XJr1KBLVFkA6KXc9S67XKn2RWSmUt+9TD4Fhok=
X-Received: by 2002:a05:600c:8b5c:b0:45b:9b9f:88cb with SMTP id
 5b1f17b1804b1-45dd5b78584mr97865095e9.16.1757326370797; 
 Mon, 08 Sep 2025 03:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYKXTKSPxPqGOXHimUcEKnbe+5MhjBPp4oldtBktDXNtJWwNAdq4u6QxDR6zcw76EOMnrLmg==
X-Received: by 2002:a05:600c:8b5c:b0:45b:9b9f:88cb with SMTP id
 5b1f17b1804b1-45dd5b78584mr97864755e9.16.1757326370355; 
 Mon, 08 Sep 2025 03:12:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8879cesm439159775e9.12.2025.09.08.03.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 03/19] target/i386: limit a20 to system emulation
Date: Mon,  8 Sep 2025 12:12:25 +0200
Message-ID: <20250908101241.2110068-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-i386 and qemu-x86_64.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index e0aaed3c4c4..651041ccfa6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -110,6 +110,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
 /* x86 mmu */
 /* XXX: add PGE support */
 
+#ifndef CONFIG_USER_ONLY
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
 {
     CPUX86State *env = &cpu->env;
@@ -129,6 +130,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
         env->a20_mask = ~(1 << 20) | (a20_state << 20);
     }
 }
+#endif
 
 void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
 {
-- 
2.51.0


