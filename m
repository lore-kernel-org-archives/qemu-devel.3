Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFC2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPqn-0007aF-Au; Mon, 12 May 2025 05:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqX-0007YW-Fr
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqV-0000fJ-Nq
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tMZM2SvIHbt7dyi/YnpmaamQemKlOM0b0XlIhcw77k=;
 b=Chz6U/rH3y9G/GswdRi5u0eiVHojlvaRTREGMN0J2s6T8ilgqgLxI6/obVIE41VD/5ir7a
 oj3YrCiENF8MSKBtXilH0cWLV30FHL8KxEobH6AI+ewYGH/vxmjuHrNNnOoU/9fwYaLZPz
 82n+np7jebKaCy91gUgAQ/rnrW1UjXM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-5c0r_XWhNMWSbJ6N-TlA4A-1; Mon, 12 May 2025 05:53:13 -0400
X-MC-Unique: 5c0r_XWhNMWSbJ6N-TlA4A-1
X-Mimecast-MFC-AGG-ID: 5c0r_XWhNMWSbJ6N-TlA4A_1747043592
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad4cc6928a3so21536766b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043591; x=1747648391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tMZM2SvIHbt7dyi/YnpmaamQemKlOM0b0XlIhcw77k=;
 b=HrnMQbBFNqeASNS7wjnqz0IxB35ynVG5yEiUNlvV31wTY6VYW2b4FCv7NOD/VDbplX
 ZYTv30AfiM3s/l1msGb7XncvbxjCllWullL4eLxQwlUfRwdE+ASyOs7eLi1oAfutIVLi
 EQ/TIl9yhCk25WP3Y8W6V/V1wLiG8nOTI6Twf7m0bubDe4KLV1I8/VJpmMPeA68UiJ7z
 DxJaN4dj8R7bqCD/0aWdfopqURwJapT2zhtCA2iNQHCE6zPs6vsf1xTiU+dualBxn6/N
 wjcfyDIkgPG0kht0GRIedd4GHrhktMt/OhRH7negeXuT6ZtEoxdXkh1aRa7Jdyfcenwk
 3aMQ==
X-Gm-Message-State: AOJu0YxQEj/690fSmitCS8BJtggJZ/bSuS6npihaLdkwipJ68ZyjM5nR
 Kn/00PstMkXVL3+YiE+4j/y/GfMTMnp+9HKVXkZO4TSMWQ8/XTXB5MWQBYcNstuwSTn43Ss3//d
 u0FbWUNOkxlB94wnlqa0DKeIrSrvzldF94by35FGrpF0avvIfsBHYjsQfMUxgn9YGd3J/SFf3PF
 P/Feb2ABMo5xgMeK5RXX2UIlF5aLguohiQJxq+
X-Gm-Gg: ASbGnctuJ02mjcP0ct1LGDgl+HQugOzoUsvJazi6gWTJBh8FHEnr5jq3U3iyzUrXkGK
 E6qBbVr3pW4drDzaBgyxkkJy0/6U1pfh/hd3IgjZHAwQJNWLj7x7lNTu/zQF44JkXoE0950A7sf
 nXcrPKBiHblz7CcY5dZehgPzSnZ51YCeFskDFahFrCWxhQAeHb9HOXdse52+48hQizM8jeCTh27
 4qT0yjDPO72WRIsAlf/Bgff3FXRwsU1kH2QUYeiu89JxieNw3gur86ES1eq4jzl3eamK+IsSTG5
 IfQrO0cHyd4B2kIvW6PLzTJRbbkzKZGW/XCIZ9UJCjeTW70=
X-Received: by 2002:a17:907:1c8c:b0:ad2:450b:f8df with SMTP id
 a640c23a62f3a-ad2450bfb99mr513398866b.8.1747043591453; 
 Mon, 12 May 2025 02:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0zWGKOVG4k8Ay8P64kh+AqS5mGFlfr5SRO1Xt59dNpfK0rlN0zQBb0cGGkhalrGTSwcah0Q==
X-Received: by 2002:a17:907:1c8c:b0:ad2:450b:f8df with SMTP id
 a640c23a62f3a-ad2450bfb99mr513396266b.8.1747043591012; 
 Mon, 12 May 2025 02:53:11 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd454sm591029366b.126.2025.05.12.02.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 01/26] target/riscv: assert argument to
 set_satp_mode_max_supported is valid
Date: Mon, 12 May 2025 11:52:01 +0200
Message-ID: <20250512095226.93621-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Check that the argument to set_satp_mode_max_supported is valid for
the MXL value of the CPU.  It would be a bug in the CPU definition
if it weren't.

In fact, there is such a bug in riscv_bare_cpu_init(): not just
SV64 is not a valid VM mode for 32-bit CPUs, SV64 is not a
valid VM mode at all, not yet at least.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d92874baa06..0f7ce5305be 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -444,6 +444,8 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
             cpu->cfg.satp_mode.supported |= (1 << i);
         }
     }
+
+    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
 }
 
 /* Set the satp mode to the max supported */
@@ -1497,7 +1499,9 @@ static void riscv_bare_cpu_init(Object *obj)
      * satp_mode manually (see set_satp_mode_default()).
      */
 #ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
+    set_satp_mode_max_supported(RISCV_CPU(obj),
+        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
+        VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 }
 
-- 
2.49.0


