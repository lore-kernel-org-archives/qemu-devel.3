Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A37EE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZk-0007JJ-SB; Wed, 11 Dec 2024 11:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZh-0006nm-FU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZf-0000Y5-Pl
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NLLgbzYAR30822TQnyZFqYAZd1RN5I0WySMepXl6Io=;
 b=HW6LmZ8u1572hzC3+nCRPUnTnxvPzDpuPfpuMGUlLWiUWw6jbSqOrProfuSRYjtoS3yQ/k
 57H2dF7KQRHvxpkzaJgLmVF1WTsf/v3eCROVhzGE2fCJgeV6bOab/z5LM59VD+LDQjvsE9
 ZjWYkczc+XyP5MPPYaAurRTjjB71QX4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Yr0mUX9QMbukb2uboVP5lA-1; Wed, 11 Dec 2024 11:28:29 -0500
X-MC-Unique: Yr0mUX9QMbukb2uboVP5lA-1
X-Mimecast-MFC-AGG-ID: Yr0mUX9QMbukb2uboVP5lA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso5209055e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934508; x=1734539308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NLLgbzYAR30822TQnyZFqYAZd1RN5I0WySMepXl6Io=;
 b=UZ1TFwU4WWwRqryOlE6A+O/y8sS0lrBGjRgd/9QnxQG57wvPx6APpHg85G+7pY+gVy
 3tRA5ty6v/j9OSQHJzscHhjDVJ/PPSbJ41OQ/qG5z7N8HGKdpaBULwKBeDhONobmITR3
 E6+dSmXpIpQK7UTli9nmnEQ9iuxOsBYF4/uUx5egMN7Bc2GTe3drNj3qY26B4WIdxdOo
 EVEheCtuyeWiEUCmfJyObK5vkananimfLV1CA8y09a8nNT5oKAv1CCHOWKZNUhkljb5g
 DRP1ry+4CW5kXgXTEUyOEEb7dAEwvt3FHI3k+ZGlxbjbKCAuLuXq4k1frxwAaUv5TsBM
 X3Kg==
X-Gm-Message-State: AOJu0YzE9WnkJ3NdAAX7RqRW0Rts5oWQTVuwUsKq8Hw6kSnpaegvGcf5
 nQlvGMrarMx6DDl9f68Mp4jZcj/2z4TLkmk2ekQTSdm3Q5zUl4b4AafuKbawe+NQ8I/JcMgOFVD
 I7LMZgqTW1OMDQl/ZTidm9TDaFvN+GORZPnEU+2EyEu6VGsgBWeDLJUFXqH9ImPRBwxYbquqdon
 mGyvL17DU1Z/ndpa35wXrCzYJEae022L8s/fbP
X-Gm-Gg: ASbGncu4fNs0uAin3z55lRXAYiO1R7Z6J68O2uaddm5+1d61slrjHXD1+Ly1b4I266a
 VbJl7knmD9rKsEED9C8JWh7H9icQHRYLRZkvhdxsR1aItMER1B8mwOlFvQHjy6u73d4Y9d4/lc9
 OVD+KCPFshzxlT3qNHv0MqmvEcByTaqq/aklWN+0+hyEARrEdeE6nI14a4xVk/rwAhVPUqssIXj
 LFQWysq6yqBosvu2Dbpi1GH2tJ2FMhq2Q0Jt9tQFpGWOAgX8RE6nWr4
X-Received: by 2002:a05:600c:3548:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-4361c3e2345mr26020455e9.21.1733934507792; 
 Wed, 11 Dec 2024 08:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrK+4EDxorH88C3+2cLIr9tm3wrM8PaKSvtEuIFBw+SIV6dLxduqPQT90z9QY87wYgtRXDUw==
X-Received: by 2002:a05:600c:3548:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-4361c3e2345mr26020225e9.21.1733934507326; 
 Wed, 11 Dec 2024 08:28:27 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e600sm1675795f8f.7.2024.12.11.08.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/49] i386: Replace type_register() with type_register_static()
Date: Wed, 11 Dec 2024 17:26:58 +0100
Message-ID: <20241211162720.320070-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-11-zhao1.liu@intel.com
---
 include/hw/i386/pc.h | 4 ++--
 target/i386/cpu.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 14ee06287da..b3477ad6a29 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -316,7 +316,7 @@ extern const size_t pc_compat_2_3_len;
     }; \
     static void pc_machine_init_##suffix(void) \
     { \
-        type_register(&pc_machine_type_##suffix); \
+        type_register_static(&pc_machine_type_##suffix); \
     } \
     type_init(pc_machine_init_##suffix)
 
@@ -344,7 +344,7 @@ extern const size_t pc_compat_2_3_len;
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
         MACHINE_VER_DELETION(__VA_ARGS__); \
-        type_register(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
+        type_register_static(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
     } \
     type_init(MACHINE_VER_SYM(register, namesym, __VA_ARGS__));
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b3..305f2a41cfb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6429,7 +6429,7 @@ static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
         .class_data = model,
     };
 
-    type_register(&ti);
+    type_register_static(&ti);
 }
 
 
-- 
2.47.1


