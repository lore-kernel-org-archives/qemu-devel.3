Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E058C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHfc-0006hg-Dn; Thu, 03 Jul 2025 07:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcv-0004Rr-H2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcs-0001Za-S8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so53376585e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540227; x=1752145027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnLLL7YQoCQGdWR3EVL4zcbePVJyUuDX4baxuyLLriU=;
 b=iV3dj3wTK2lnegXOgl062UHqnFDWDwteimCHl6+jPcy3mFvMs2x2gKAoHmrSsdZhpN
 JE2UfnFo+buvRPJnuv9jtgIVYqFohzsJdTQUCNLoHzZUDviEwOXMgsxA8oqt4lbz2D6Q
 Z2H05c85rni1gdaiPIlDuHJ4u4cKQX0p3AAWUz5DP4Nbs23Otk6k6qekcZuA5IXyreEW
 dyG2LdrFuwdOMzRdKDY6X11RPVFaBlEctl+KhwykqqL0W5I4Cgk8vnK7sQMxsHMKnJ13
 e4yqygwuTQWdCf8t/fjTCua+J31HuhNGVlHFriy+vcXbBW33BQPKQGlAQzfgCix+SHQp
 GXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540227; x=1752145027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnLLL7YQoCQGdWR3EVL4zcbePVJyUuDX4baxuyLLriU=;
 b=jzurYrldMRMlidMmA5tLhfsiQKtnavTgEM/LFNc+60nszvPhNJnbxLT5NRpcbu8wn+
 kxLOyLvcePzP4wWrk2yC2LQ6uJfAVPo6uQWmmwKuRk5RplWeNhBiPuiONEV4A7nSywKr
 oXtoLJDbkTPbpBik6jR5/q8e9o5+ALPmSDyrptUYja7IKr0MX06LD6rj7gGwEnVpZ2r2
 VZTdX/tVIyR9EN/CCYsgsZbS/oal+qr9ofxay8o1aZlD5eltlNecbjEul07yK5MbdJdi
 qwIwMF2rG7wOMrFq8kHVWaNIyWwrp6zCpEqU27vtPanBPLRAbUy1QRnzAN6Xdz90HNdX
 54TQ==
X-Gm-Message-State: AOJu0Yz1B8yT/S2nLULQsmEQ6bV6R0fLDyUhYWHlhePzaiUTXvieu88r
 gegbN5kviAt0FVDhWEXUbDUVgpbXOkfwLzSZED6aB4nEhFRT6zjebVoSzNNLLIl7lCfnmkD80iU
 azTHWD7U=
X-Gm-Gg: ASbGncu22s90qIZPyK3eY57aHgvTOQV37UgD43wdOZ5Cq7eIOyoRJ402S9sLynxP94v
 3fBhDSaTrFpsXOAse4eV2hyukuJpa5MbvmF74Tyxv95gneYMqe4+uii9qXpGvZG671RA51l3Lpg
 2kXI6uoNMa1JmOzK0Jqu8xAMB01tOreoem2MrF5SVbK417tMQpeoGdopv6sWCTfw2OIO0KdbaC2
 RyUDx5ipu8y5YAAjUHA6rXeLuJFPfdyogb+gGX+e4gK2mdUg/m9bcBxOOiY2kgzpUyWNHb9GCGB
 CE3Eyl2vgMUTzUCDg8hHDRqPgrz7Qeo+XrNcEJlGQxaSg29wn/25lJVnbvIUwKBqgexwROAhC6z
 +s63Py4sw9rg=
X-Google-Smtp-Source: AGHT+IEYucf5bnqrTZ0PYjrv8kqSiGOKUc/yPkaJr/uv7wwktIzjqebLnUo5ht4si12JpTCvy+cETg==
X-Received: by 2002:a05:600c:820e:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-454af1d8088mr13927765e9.10.1751540226727; 
 Thu, 03 Jul 2025 03:57:06 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde8c8sm23730205e9.31.2025.07.03.03.57.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v5 16/69] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
Date: Thu,  3 Jul 2025 12:54:42 +0200
Message-ID: <20250703105540.67664-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This method only accesses xen_domid/xen_domid_restrict, which are both
related to the 'accelerator', not the machine. Besides, xen_domid aims
to be in Xen AccelState and xen_domid_restrict a xen_domid_restrict
QOM property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


