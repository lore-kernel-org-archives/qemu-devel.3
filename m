Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D3C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANbK-0000az-Ke; Sat, 26 Sep 2026 04:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANaO-0008GV-CM
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:52 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANaM-0006qQ-OR
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:44 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3429bca3880so957236eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410601; x=1791015401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p2D6BvndCEnjow47Ybu/EbhOevA9PsUUD7TqVOt/bAI=;
 b=FC4Ga6RfzpaG5IRJojP0sMqblg2DccwtLLBeSP0zHIW8MNNb3LJcGDDF3uJQzjyE+a
 vK/RDBNbtRwZufRnZP7TCTBmO/fTwX8cIkniU2+d0YhoPjpttM6RLZyVgNmlMiEQn7Ip
 5fj7pKsYtRmKMPTYZPyXAc8u2EJfe3JZrtjl1cF0lMEtIE1wwlJHiF7bCscTl9lUTFbV
 7HKlDMxwP90ALuJyvY2Mg6SWUoXkmOWKFD4FtlrqB4rZNNQIYgYUc9tdnltVDFiWa1Gi
 NxZGg0dxR+s29xvjzq0ryLcUgNi+6pBwHCXLfvNvdvucyJY68l1lft2c1S+FqFOMSkBU
 AItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410601; x=1791015401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p2D6BvndCEnjow47Ybu/EbhOevA9PsUUD7TqVOt/bAI=;
 b=i1Zvr5vdpkGO5KKGauWD4YzRJ6XL/EcPDaX+2lQ+9izX8grAF2HHN3FPboMVn6/Mgs
 GryfhrJR/NtlXinb89g7OVFPR8hR7L4+JgpiD5z35xWg+O4fy8T3C35DdsOTPt0vQw/C
 KkXVu0TqOFTebvvTqcFF1/D1LoYfySSRrZ/p5BHSROVfo0xSbdiQL0NVjCyA9QP93nCF
 9BVDfqxFtnm3OTpLoHt4NPg77XP17oPP2m7KlJy2kMMtIwRfwCn/J8HAMZsZ7WZLq0zf
 VxZnWL7JDc0YqPLsjntpWIsm4JDtEfvFfFA5QqwoO8oY9RKLHLIPq4/ZT6UnPPFMlVE0
 TtMg==
X-Gm-Message-State: AFuF++ksBeSrHq1kU6anI3hj2QlNT8rx3WKt7cctmK+OKDQPK7ERE8xV
 xFPaBUYSed/LpgTD4A0OH0FJl1XXFqZMBclXKLBkhh9CR65f8Si2OmC5njOPLx/+
X-Gm-Gg: AYBFou3V+AhnApgmeui+HtCl6Yb0CzckhttPqNHmsj7KJ5EjYKDc/xHmSxSMh5KAJc7
 6BygrCoFr4TbBuBPIreEgg8gnJdrEUckSFu8MnHCZt2l0g4Q7Y4g5lBwKvWikXwvBnCxaPTOmqd
 WivZ4wBa2tEGXYffqVhZorMJD1a0nZyXYo/aEd3OGDDxQp+qAhF8ASbQMwplfN+4ZvPyrKqeKsK
 xmAkG5dNaxEkfMl0j5KgmnmCwOVVy9mK1iW1nZ7KgWWNfHbQhzf8nwGMXTkU65JVzAE/P2bwU99
 nwfXQnNEP6u1IKhmT08WSuaC1GdC3qjmCuDQjiVAc/4lVaNSiIcnVOOTBLjPiv7KzK9wNGWYMiJ
 KxaH+IMfD2RZeM1KvtaaljEoPGASK8m5NIoZOY+xnAp29pPoVmDqI7xp0/p1JFylNMwDz/k4F2f
 3exvPqFIjgplLPHB3iDlu438dBv6XcxkFqq1l92R4CZ45Rh0Dj/b4UdwG7djSYGo8NXJ0/Z14jt
 XlBO5NvjDORdw4bh6ZS7SzrpDVXYBpA
X-Received: by 2002:a05:7300:c393:b0:341:cbb8:3c0a with SMTP id
 5a478bee46e88-3426cfdd59dmr2246804eec.0.1790410601124; 
 Sat, 26 Sep 2026 01:16:41 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 07/10] hw/m68k/virt: use unique QOM name
Date: Sat, 26 Sep 2026 16:15:47 +0800
Message-ID: <20260926081551.29-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Set the parent and versioned QOM types to m68k-virt so M68K virt no
longer collides with other virt-machine types in one process. Keep
the -M / help / migration name as virt-* via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/m68k/virt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 274970978ff..1faa178bdfc 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -323,7 +323,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo virt_machine_info = {
-    .name       = MACHINE_TYPE_NAME("virt"),
+    .name       = MACHINE_TYPE_NAME("m68k-virt"),
     .parent     = TYPE_MACHINE,
     .abstract   = true,
     .class_init = virt_machine_class_init,
@@ -345,14 +345,15 @@ type_init(virt_machine_register_types)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
-        .parent = MACHINE_TYPE_NAME("virt"), \
+        .name = MACHINE_VER_TYPE_NAME("m68k-virt", __VA_ARGS__), \
+        .parent = MACHINE_TYPE_NAME("m68k-virt"), \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
-- 
2.52.0.windows.1


