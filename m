Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F0CD128E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps5m-00016w-5N; Thu, 28 Mar 2024 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5e-00012h-0W
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:54:54 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5a-0001pX-Rw
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:54:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so140389066b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641289; x=1712246089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xoyjiIw561YlGIaQRdLbxciG2dWfen0yY52crHbWn0=;
 b=hycLjgOdmSGADLUg7E1++Oeuk4Vs98GbuyXacIb1L+UIUXU89jYl56hdG8XsG9rTdf
 NJpM4rDqoJMjOOB0PBNXf39Ol5iH0THFjjO7y7FU5Ft9qqTbbE/UUU5fHjTl9vbdzF0h
 FxhNx3rKGkbahyu9rmI3XO76tyrNoBuoTSbZK/OkUOqDGn+d/syYxFMW6OQgjPp18Zvt
 GRYLUhU4sohr6EW2MnTty+QUFVt8cVLRjZr8yNgjaoTggQriyUhPn6Q5Tf3RjMAbTKbW
 DMbJd2UiyDLbz28AU6LeKJsDuh9BCFHj3jo3FIzF3u05cnQhk5mtGWM0HHvjIQc1G1wG
 OMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641289; x=1712246089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xoyjiIw561YlGIaQRdLbxciG2dWfen0yY52crHbWn0=;
 b=erjzWY+wHzkN3VGCKSLM9DhWFT3qpGepkaroWIT6glo7ZN/e3wpmTp1JkJ4fpzgYD1
 ikbdh7B8zLASFQsK7ytGZUgwIzyqKZ2xJIbeHdT6CPLEVXG2ABl7GVOpwuSQHDeWCoqv
 y4uGDI4z1qqODxWz7L5jyleUwr/bsx8hDfjZrmmRdFmTYpvNG/gTDUpi6BrUOedKMNo5
 rotdDKCe+4tfMISnpeGn6YT2i+Xxve8iWsnfy9teJE1MZQ2NsyKc1DgjM2v3Shm7TTYB
 nyigCvwXj2jxT7YcaalfNu8UcZpyWarKD6sO4Tu26uI8l63tu/3SRLKxcwo1BfxGQnKs
 5RzA==
X-Gm-Message-State: AOJu0YzbQV4FkJwyMMxs12xym+ktLfldIwxSgIhGFar9F5HQW+ehHOMb
 84oNwMQyFlU1K/tFfKlilsf3HOsTecg3N3qNDUMOJO77S2roDxcTbtNAwmTzEMmjt1RSwJplzZy
 Q
X-Google-Smtp-Source: AGHT+IF5nPNNk6iWv9K9gmp+zF28jumHMVCID22KWO3BYQCYDbLztVinN6sDOrMp2q9Gec/eNpwGrA==
X-Received: by 2002:a17:906:4892:b0:a47:3664:1b98 with SMTP id
 v18-20020a170906489200b00a4736641b98mr2095599ejq.7.1711641288815; 
 Thu, 28 Mar 2024 08:54:48 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 f13-20020a1709062c4d00b00a4df82aa6a7sm882455ejh.219.2024.03.28.08.54.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:54:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 01/29] hw/i386/pc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Thu, 28 Mar 2024 16:54:09 +0100
Message-ID: <20240328155439.58719-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

In few commits we are going to add more types, so replace
the type_register_static() to ease further reviews.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0be8f08c47..2c41b08478 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1810,23 +1810,20 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         pc_machine_set_fd_bootchk);
 }
 
-static const TypeInfo pc_machine_info = {
-    .name = TYPE_PC_MACHINE,
-    .parent = TYPE_X86_MACHINE,
-    .abstract = true,
-    .instance_size = sizeof(PCMachineState),
-    .instance_init = pc_machine_initfn,
-    .class_size = sizeof(PCMachineClass),
-    .class_init = pc_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
-         { TYPE_HOTPLUG_HANDLER },
-         { }
+static const TypeInfo pc_machine_types[] = {
+    {
+        .name           = TYPE_PC_MACHINE,
+        .parent         = TYPE_X86_MACHINE,
+        .abstract       = true,
+        .instance_size  = sizeof(PCMachineState),
+        .instance_init  = pc_machine_initfn,
+        .class_size     = sizeof(PCMachineClass),
+        .class_init     = pc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+             { TYPE_HOTPLUG_HANDLER },
+             { }
+        },
     },
 };
 
-static void pc_machine_register_types(void)
-{
-    type_register_static(&pc_machine_info);
-}
-
-type_init(pc_machine_register_types)
+DEFINE_TYPES(pc_machine_types)
-- 
2.41.0


