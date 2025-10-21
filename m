Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36CFCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7yb-0008Tv-QB; Tue, 21 Oct 2025 04:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7ya-0008TQ-Ne
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yY-0000wA-NP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso3636500f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036252; x=1761641052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fggegq+zKz5OUQPZsxqCN6WOO/FKu9sNtbgG7iUQYj8=;
 b=UfCYlxyVTyQXwCnvkH1HIXVyl8OdP5RlQUSw72QVhlXcFsmh9jSWTeGzWb/TVW24Xa
 QNGp1ZSZx+zg81cxnDXlkAsAeWGEI40v4vaKyW4hEEGBrVSBbcHR0Euk/AH5fcItUQVs
 aeamnG+hnO87BCodCVY4XHDK3EppmtPrJ9nTlUFMccgPHqgMgvpD7kPG7XJul5kpJ+0E
 vpQApL4EqtCXTbzKRHZ+uSg6zMXmW57o1Aon5hybxgng0jMtA2Lmk3tdUId1bq5ejJRC
 NB84KGx737UpHAE+IVQCz6dNJZAty287Hjswm4xjpVfEAObbHzzZxc2j058KS38/Z9qn
 Iwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036252; x=1761641052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fggegq+zKz5OUQPZsxqCN6WOO/FKu9sNtbgG7iUQYj8=;
 b=K04pwb+3IzT9uTptI06+GWXB5hQqJx3OEFLM6GCLYK6CLzgk1gizTSFhpMQ8KyZVSi
 tZ9ZRQNJysDoQWfayt/VraUlI2qf9rTP/o+1ch9M6+8HeLRJWTP6hj20O2CzWeKTAit/
 +rUuSqpaJeAhduvTngjlnNR4Ks2HzlVkw9HLJkEUTSc+UYAuUUaiX4Q8DiRTcKNugVtK
 OmpARB0C6lURBFNanq2LBDJJiLY1kv9vlqhnk8lGNXHvD750l8XoxIBHg0cb9EmO1Rox
 jj0OG8Gq6aRI7TgaVuHnzgZhwDdJZLspO3sSlH5YWlz2hCTgSmDs24GdCkz/y1DFhX5z
 TBIw==
X-Gm-Message-State: AOJu0YxArIn/9V0bTUEhdnj7Zx7gJTlMPew5Oa4uFNP4Cm972+Su9HC+
 ozLmLxZ+d20e0K3EuK3/Y65kSyEg+00retiMXrHztVDI99CrJVrT8Z+yy4/QTZvfvVRWRsuyHIe
 kXnp0dDY=
X-Gm-Gg: ASbGncsQCIDfdYEY1/zx9ih8mAr6bdF6LbYxAa10/d4JaxoJH913H3hoTORzSDlK90u
 3G8ea2qKBUwUtumnTx/JVEjOB4nJbYHRyY8CwoM1lz7Z/7GBqQ9QtWvdmf8KM7GfqEQ96HuCAzj
 GL+JV23t+D4phfIWkrz7AemqDdNx4iUF4cTjhbo601bVBr/233iwe4uE06B0/64bkK3yZZV0g7m
 kspOZ+qIkTi1/jd8TdOtAIritf6NU0SBomSm5A/cvsTmCUEZ6KkI8xPHm+l2r1wS0OhPwR1kaYd
 ffZCncjj7Jg96+hnYr6iWgUEl/1VnDOzxrWgZ0eIzK5QGYnLSvg7YVVRLc3UVeItvNqU92maQ58
 xhd//A00G1gBBkuDxihaKxVc5+hlGtL9L9+XUUKVmOIq/0uyDA4YRqRT8GSsNCjXvS2iDDxMXlr
 NHb+Vcl4biqr9h+c4ZpyKQiJ/7ENs7lj5f14igRVhRW7N6ScMupj2PYAM3PyHG
X-Google-Smtp-Source: AGHT+IEoYici4uejy48h7rF7LlsVTKlA5+khtpcojAL22mlKWdDcTixLD0jI1vVMR+Nu/9WOupMBrA==
X-Received: by 2002:a05:6000:4205:b0:3ec:db87:ff53 with SMTP id
 ffacd0b85a97d-42704b5a931mr12540847f8f.12.1761036252539; 
 Tue, 21 Oct 2025 01:44:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm19285508f8f.47.2025.10.21.01.44.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/11] hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
Date: Tue, 21 Oct 2025 10:43:39 +0200
Message-ID: <20251021084346.73671-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/ppc/spapr_events.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 548a190ce89..892ddc7f8f7 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1041,16 +1041,14 @@ void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)
 
 void spapr_events_init(SpaprMachineState *spapr)
 {
-    int epow_irq = SPAPR_IRQ_EPOW;
-
-    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+    spapr_irq_claim(spapr, SPAPR_IRQ_EPOW, false, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
 
     spapr->event_sources = spapr_event_sources_new();
 
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 epow_irq);
+                                 SPAPR_IRQ_EPOW);
 
     /* NOTE: if machine supports modern/dedicated hotplug event source,
      * we add it to the device-tree unconditionally. This means we may
@@ -1061,12 +1059,10 @@ void spapr_events_init(SpaprMachineState *spapr)
      * checking that it's enabled.
      */
     if (spapr->use_hotplug_event_source) {
-        int hp_irq = SPAPR_IRQ_HOTPLUG;
-
-        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+        spapr_irq_claim(spapr, SPAPR_IRQ_HOTPLUG, false, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
-                                     hp_irq);
+                                     SPAPR_IRQ_HOTPLUG);
     }
 
     spapr->epow_notifier.notify = spapr_powerdown_req;
-- 
2.51.0


