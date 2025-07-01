Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F9DC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBO-000746-RZ; Tue, 01 Jul 2025 10:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBB-0006g6-7y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcB5-0006wC-PO
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so33910115e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380902; x=1751985702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4o//Ahs6RE7G9qm1Fruj6+tSusgMKx7qzxtzsPrU+gU=;
 b=xPdWt0l+NQY6rd5vel+1zjVGxzttmUbo8WiU5SkQZj0qykPxhdJRzp1U48POy61bDU
 3cJ89wP2nlDU74qlvvFxKJ2SMC7x6mVGC10QFE5FDBz9HbY6899WmChN71kSXhvcPtpY
 85uCvKqAcaLAAf53MsvyC/mRpK+diqka/B1PcB8Xh/nxZgdt231rb0NPbaoV1GbWGtvW
 53TgYjlO82zuD+YpDeakXtzlKORS1XYEPhhOt9wwLiyP18s+lcSJSWWX6wp9gQHiNIe9
 8cs75kA1owmgmjW65GoNh5GJ8r3tJDHLYl7C/Pcg0/CDXvq5hiiW0jdY8Lxml0bl66FN
 AVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380902; x=1751985702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4o//Ahs6RE7G9qm1Fruj6+tSusgMKx7qzxtzsPrU+gU=;
 b=AFtWYGOIkS6Bt0mKyyGi44MI1p2YoPeOWf3lLUewxjvKChAqNp5EKN4zaBQsTA4QZZ
 afu+hsJQjJforDwZ1qqH2w8wr52H/UXBObkjVNe5uPaJ5Vt/wPjDYUvysJWeJBd2lJFH
 hth/6q9NCKEo34IqiZLZXhyfaPr6K2rYCKEjc4S+vj0BNJWDlECINnhY6m8N4kpOXybt
 Brw5w3mRLqGgzNUjF2iUH8ZK5Nza1ZYKqBSiq996OGkI91ShceHx3NctXMFek2CmxwTM
 L9sM9smqtwxyQ+x+ig6jq47kcuwc5J6LRf64i6+szwCDK4KO+3ZEWT4yIJ9GOWTorOls
 YXug==
X-Gm-Message-State: AOJu0YwuWOxA5N2ttKyPqLM/7WnPf9dyzIlFNK9XwDMo09gWoVc3JlDP
 0phdx9jgr0XUrFcp+aREZa+HUeLsNrolfsZXCf4hyXqCvnk1uuLbNQeVtvmTQIoA24MKAzgD/s2
 Hk7r6
X-Gm-Gg: ASbGncvrfc2rF+amzhthyfDh2Ofzdb+pWEk+AekqRWutCaUys50aKd3YeIIF1walxU8
 C3xoqOOc3DxZfNRF24ruYt6f9+o/SSzi3eFqfsGsIeTQDeMhuR30yfXVCL+1hgISyLpKQzWh0ac
 Y2dQLlOz1sopDIDHfRLzybf7Lepm8e3U09ym9+Gr8hLxaf175o9ogQneLapOUZQeblv0ohTn+m6
 w3zCSP0vF+cqbOZA4nT8QX+I/BZExtklr5l7f7IhFd3UBc9z23fwKahRWuf65x55jVM8NOh21BA
 Nu0SfUdCx92S+Bm6vWkGMVMpIG683dyPbms6ujNwv/KGc6LUvDn2akSYbZZrKel4FRTNyvqHf03
 vF3WThykptCkEokIUvZ78kbk0FbZz/yjGtVv3A3RIY3NUWIY=
X-Google-Smtp-Source: AGHT+IHkIeIkmmaL1DeIrAj1zDWqAFBMo1nLnPhzMXKcnT7k8hytvQM/TRUt5vNJ4Dqbd52x5dFZVQ==
X-Received: by 2002:a05:600c:8712:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-4539341e446mr154120445e9.27.1751380901649; 
 Tue, 01 Jul 2025 07:41:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453883d81besm181507495e9.38.2025.07.01.07.41.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/68] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
Date: Tue,  1 Jul 2025 16:39:23 +0200
Message-ID: <20250701144017.43487-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/accel-system.c | 2 +-
 accel/xen/xen-all.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index f327a71282c..a6a95ff0bcd 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -45,7 +45,7 @@ typedef struct AccelClass {
     void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
-    void (*setup_post)(MachineState *ms, AccelState *accel);
+    void (*setup_post)(AccelState *as);
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 913b7155d77..af713cc9024 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -58,7 +58,7 @@ void accel_setup_post(MachineState *ms)
     AccelState *accel = ms->accelerator;
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->setup_post) {
-        acc->setup_post(ms, accel);
+        acc->setup_post(accel);
     }
 }
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 1117f52bef0..ba752bbe5de 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -63,7 +63,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
     xen_igd_gfx_pt_set(value, errp);
 }
 
-static void xen_setup_post(MachineState *ms, AccelState *accel)
+static void xen_setup_post(AccelState *as)
 {
     int rc;
 
-- 
2.49.0


