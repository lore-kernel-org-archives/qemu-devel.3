Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98648C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNrO-0001a9-BU; Thu, 03 Jul 2025 13:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNr0-0001Aq-Jk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqu-0001ry-Ba
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so441025e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564162; x=1752168962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZwQanFWBRxwl5aAhr4ZCK6o5mkA78r32e7Wtw3A5EI=;
 b=iKoAVRhJCVyiUtu48eECt2tSdWpf4deFPKMqzTyqeH/uDKKupvNXFpoZBsvYLvlFx+
 AQ8PwCucH9q7Kylj9SCqxEc18pw7dfUqdLRWTuKm542mP6OmyL3ymm26g7ybHynuzkQE
 nniNBpc8Dtf9U+ckIEOF5fxf3sIdWPpm6QmqUv2gizZFwESBO74x61WoYX0KGk8XqLOB
 BRcaYxlGFN6VzgJx0hhk5VyB26vT6NhCcWPRNVwg7revFQgTX7CZrvvaUmcbOs8gPOUm
 g4CINwxArbzHYR8ZXMPvZspo/IAahmMaAhODO396fJ7lHJQ8HWZlfBGhEGnUPOkgIUpe
 tx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564162; x=1752168962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZwQanFWBRxwl5aAhr4ZCK6o5mkA78r32e7Wtw3A5EI=;
 b=Iw7Y80u4x/nlGJBTEC087xcA6zc+yib3sRKexfqiIMHxrCOIWhxsKTmiO5T/0hloFO
 imhNVX1NATP65Y7Bc2hh7SD2LU+Fl3mcSb1ztqbTFuGclh/vm29G4jDkGpjqNhOpRXWL
 82WsfPZEJQCFUsTeXSOvsV7npPr1+aWfQw2/twWfe4sVkLtDKktec/IPvStjnk+8cqIq
 Gm9+uDV5rGL3uE0SUj5a3BtqVPKYk5flW/XpOuzjLPqS5BvR+cLdAJyR8nFwCR1hY/zw
 DbSTuh62OHlrGxqpv1QHm4sVf5RJGTKQNmt8m7FStJx9rtIqg3HF0AexLZN43wRrWPp6
 CCIw==
X-Gm-Message-State: AOJu0YzDJ6hu+LTa9FyLFTMGBoDb/mXuQKbTZjZ8iaigIsYBsKQHNORY
 cc1lhqT+PdiL6OSLasF5UehI/3jMT5FLp9F5KhxLXVJuhtF00N/pVj/6DbSVe3zaK09J9T4XLj8
 1R2y27qo=
X-Gm-Gg: ASbGncuuquSxY6G6J0LoCnGn4DS3Ca5Q6c3g89ms6uE8VdAEW99X6B52DrBqwQ/5PWW
 Ba/x7eFl7Fi1MQaTfkrwQy5QYiTQAuStuROJpHWsP/jMAOYodRnpI9VOmW9J8KohCjvHg40DipI
 ZPZaWh2+AzlWQKTSRjAGaCzgwyXPKZGE+y2+pCA9IOv6wSRp0WKQq/Wa0O+x4Eg5vOYoN54QBNZ
 mxKsiwyDZHNFKE81EcZL/PEwH2pdUCU6tCd7xvI5ZRqQrhJKgsYlv+mmXJfpuBRkS2y3KfFa6Re
 12zcvGcfYQwhXayvbNkBHhZO1KL3+28rIZuJw0oLDR68GwC87dZhJX+N4AkXjhlOwd01iloiz5x
 fP3HSxDdP1qnuhpsEF4OUmGj1K+cJzopKJzH+
X-Google-Smtp-Source: AGHT+IFlGs8qe7BnVu94UCy3WqtQJpzJU7HgdWJZtFJUmkIJbvAs7L+AWB+WvKsRQQGdwDgHXZ8jPA==
X-Received: by 2002:a05:600c:8b43:b0:453:6424:48a2 with SMTP id
 5b1f17b1804b1-454a3d23106mr87720105e9.10.1751564162373; 
 Thu, 03 Jul 2025 10:36:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97481sm324603f8f.63.2025.07.03.10.36.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:36:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v6 35/39] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
Date: Thu,  3 Jul 2025 19:32:41 +0200
Message-ID: <20250703173248.44995-36-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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
index 44189b77daa..19ccc5ef6a1 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -45,7 +45,7 @@ typedef struct AccelClass {
     void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
-    void (*setup_post)(MachineState *ms, AccelState *accel);
+    void (*setup_post)(AccelState *as);
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
     bool (*cpus_are_resettable)(AccelState *as);
diff --git a/accel/accel-system.c b/accel/accel-system.c
index fb8abe38594..637e2390f35 100644
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
index 8279746f115..bd0ff64befc 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -64,7 +64,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
     xen_igd_gfx_pt_set(value, errp);
 }
 
-static void xen_setup_post(MachineState *ms, AccelState *accel)
+static void xen_setup_post(AccelState *as)
 {
     int rc;
 
-- 
2.49.0


