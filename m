Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EDBCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHg-0007nC-Ok; Tue, 21 Oct 2025 16:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHd-0007ak-Tw
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHR-00019p-8p
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso14345795e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079704; x=1761684504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=im+OEuCaVAw5x7x2mUEPI+ZYBfpg88mOANk8NkPxsC0=;
 b=hu/SCg0Z6gAuBUlRnxaU9ObpNn3xtFJfMn08ac/p2NfGD57SY/ZlRlgcGoY5oQk4GW
 W6SWE3uymki/AUbB/cOuR7XOgo2+BCFX5ISVN7XReziU/p47pIGV3UQQNLs8SoINVT7i
 2c2yhIQmPkz3xGUMVkri1T9b+3BuV/MmAyJI+hugGW1cfIWqYbLUHGJss9FJ9+qjsQ5r
 e947jsx2RANpO25AF+Bjsef/jhQ7+hRdLgmn3wqLC3+5fiC0cIlaIaG5fVYRmlMJrZSy
 xA4t2rC8Eb1Xl5vXcJl7s+RE/oGyMJgj5wQhKzyALrUt4B6iV/zC8Is29isMAZ4UCmzi
 2+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079704; x=1761684504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=im+OEuCaVAw5x7x2mUEPI+ZYBfpg88mOANk8NkPxsC0=;
 b=BmlnkPExFoTHKlL1mbLnVNXm2gcbFTsfFx3TcSg8qDwNszrr72wNhG4AA7AxuaWD7V
 wISfnySHpSnem9ci+/4W3mnH7h2O3eP4qqQwUoxtHzDO21Tyg2YQd+YsU26khDSC1dfa
 xsj+uqYNH8h97XUhL3ZRrkv+sJHcewr7AKCq5Y6+3o2tkSzHmOqgxbql9QwSa78PL7pe
 5YzaR+RYnA5KBmAERtc4rMYtK8GyG0Dw9jDCp5vTezt8hxKTfrz5wxfOTfluzF9o0+zy
 WUtLV98IMsa8hXQ1JE1vKxGij21iEzTNgII7heUz1s3w9R0KxATuTRU0FrUCfXlEQNq3
 Phlw==
X-Gm-Message-State: AOJu0YwWS7sV/182hS1cAZsp70EtvZUFC1SAQgPCr7GF2+Wt5iXoZwTm
 RzTj2aFz+FGxjXwPWUIodvIBgGpWcfiAQh16xGgMEoGiJ7b8m21LqnwyJLFBYmnHh5hr3xmFnuG
 ldIdRMUk=
X-Gm-Gg: ASbGncsZY3ETxFEOj4Z0/yvlpfqaRr7DeGDIqc0Jh7ZhwQNUSO4jqWzF4M3Ucyk33tl
 6wWwwuRzgCnvLxfOKQsA4jftIMfwn5usaRwQorpEH9g4BwhTN9+jXKgl7qixlnr7VZ+WVZt8Yp0
 t86sj1fYQrpi60RmaJU4TVBN4fExym4y+Rtil8N48+D3+BPIEsvSDYqrR5ck84U1RGXS6jmiJzM
 uzj2qetQuWE+WY2E1cf14BdZ/gr3qcJ7nn3Nwm2aZZlUFQYdgVaYpv5Ow2VYzTv5SWS67gJCSkY
 FA3LPkRv7DW6v1GZhWNpIjPZpNO81w6pNFRww4SSnn/wa/UemmTxZ5G72Ze36A0OtXe7Tz7w95O
 /KcvOgNhH1E/9Z+v6dE+8lSkQKvpBg/+hASBqv3RxEIT4PxGWZtgd09UgkXo7/Dq5tsSzCFrdkv
 vKdKSf+8Fg2rqIt4yD04nLPNNXgK6aJrgpGaCdc+IEUzBPH5b8vPK2rDfP+Cwv
X-Google-Smtp-Source: AGHT+IETgh478E3vvkI5VMl3KmOPE93VhkJeXNs7JngB+USmWlOp4L1BQXawj3X5Y5Hedw7qe+251A==
X-Received: by 2002:a05:600d:4395:b0:471:a259:cdbe with SMTP id
 5b1f17b1804b1-471a259d086mr55392225e9.23.1761079703625; 
 Tue, 21 Oct 2025 13:48:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428e9b2sm9680685e9.5.2025.10.21.13.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/45] hw/core/register: remove the REGISTER device type
Date: Tue, 21 Oct 2025 22:46:31 +0200
Message-ID: <20251021204700.56072-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Luc Michel <luc.michel@amd.com>

The REGISTER class (RegisterInfo struct) is currently a QOM type
inheriting from DEVICE. This class has no real purpose:
   - the qdev API is not used,
   - according to the comment preceding it, the object_initialize call
     is here to zero-initialize the struct. However all the effective
     struct attributes are then initialized explicitly.
   - the object is never parented.

This commits drops the REGISTER QOM type completely, leaving the
RegisterInfo struct as a bare C struct.

The register_register_types function is left empty here because it is
reused in the next commit.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Message-ID: <20251017161809.235740-2-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/register.h          |  7 -------
 hw/core/register.c             | 18 ------------------
 hw/net/can/xlnx-versal-canfd.c |  2 --
 3 files changed, 27 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index a913c52aee5..4d13ea183c7 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -75,10 +75,6 @@ struct RegisterAccessInfo {
  */
 
 struct RegisterInfo {
-    /* <private> */
-    DeviceState parent_obj;
-
-    /* <public> */
     void *data;
     int data_size;
 
@@ -87,9 +83,6 @@ struct RegisterInfo {
     void *opaque;
 };
 
-#define TYPE_REGISTER "qemu-register"
-DECLARE_INSTANCE_CHECKER(RegisterInfo, REGISTER,
-                         TYPE_REGISTER)
 
 /**
  * This structure is used to group all of the individual registers which are
diff --git a/hw/core/register.c b/hw/core/register.c
index 3340df70b06..2553cb15aba 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -258,9 +258,6 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
-        /* Init the register, this will zero it. */
-        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
-
         /* Set the properties of the register */
         r->data = data + data_size * index;
         r->data_size = data_size;
@@ -318,24 +315,9 @@ void register_finalize_block(RegisterInfoArray *r_array)
     g_free(r_array);
 }
 
-static void register_class_init(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    /* Reason: needs to be wired up to work */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo register_info = {
-    .name  = TYPE_REGISTER,
-    .parent = TYPE_DEVICE,
-    .class_init = register_class_init,
-    .instance_size = sizeof(RegisterInfo),
-};
 
 static void register_register_types(void)
 {
-    type_register_static(&register_info);
 }
 
 type_init(register_register_types)
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 343348660b5..99bbdd7d3fe 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1868,8 +1868,6 @@ static int canfd_populate_regarray(XlnxVersalCANFDState *s,
         int index = rae[i].addr / 4;
         RegisterInfo *r = &s->reg_info[index];
 
-        object_initialize(r, sizeof(*r), TYPE_REGISTER);
-
         *r = (RegisterInfo) {
             .data = &s->regs[index],
             .data_size = sizeof(uint32_t),
-- 
2.51.0


