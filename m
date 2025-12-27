Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4266E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRZ-0007E5-U7; Sat, 27 Dec 2025 04:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRK-0006rV-Nm
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRJ-0003gw-2D
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/s+BcBJhXrQ1Hn7p2/Ew5sWlE3mbAppM59lkGTyxaY=;
 b=GLemswEEpfNhllbZEyFcHBlIfE7nZaiCAXcyedaFYj+71964VADgFgzxty8prxoZMzeRf8
 b3cUvv8cYuxuFHXE+5HhZSPsrJc/PPUK4JpXt1EPG07ZY6xchlTajkd5omNr9ng8Cu74wO
 MGtN1czX/hIfI1pZsdKFj805/F/qzqg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-OZdyd51_PsScrhVsDiv7OQ-1; Sat, 27 Dec 2025 04:18:18 -0500
X-MC-Unique: OZdyd51_PsScrhVsDiv7OQ-1
X-Mimecast-MFC-AGG-ID: OZdyd51_PsScrhVsDiv7OQ_1766827097
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso99541045e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827096; x=1767431896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/s+BcBJhXrQ1Hn7p2/Ew5sWlE3mbAppM59lkGTyxaY=;
 b=ob+zouEBtt4VkeO5FroZFqVWJ8xdmY8/8iEFexbs/Kk3JvB3J98F1kmLgnjZCXy3X9
 N3gJMTYbYvyOQfVDaorPWMzGoTD0DvR0VZLE+U5JwVse3UZSlAIDurdWAaKZck5HqnRT
 gNS/fe9qVfsyZx84Cj0xF0U7tdf693TPgjDvpLKp7dm0DtIk7Qfk5mGlZ7dpoGJBdsp0
 sdQf8xqQELlLqUevn4EDOMk4pch5WNsvFaDx2Xiv8TJhUnPYnZbbDKvcBRuFz85qDvRh
 f5fSWtXWsEGtMIld7axF2NVRmQ2mYsVhs3uNrbNsEp1mnXEI2PJtTGnIMx50KYJweajV
 HDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827096; x=1767431896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/s+BcBJhXrQ1Hn7p2/Ew5sWlE3mbAppM59lkGTyxaY=;
 b=o3NH8CWciYHllyWAPEvhnzUqgAGKT7iMt86AfCIog3rGoNPLAGdoYimh+AcMJ9kr1U
 RBV5xDK2Sl4o0JsGx7Lfzm5FxBim0Zie3RRDJCA9jxhCQvzkHJxHn1Mh0o8gWBp8qqAp
 dPtaSsCRws+LjUSqnXDSSUGZr32IW4ulwNslgKD/9PJJmPOubR2DeTW6uY9I7iPlNVpP
 PRAa48yKcIYAhlOisQoszQ/eN2q4ii7XYjSgiK2hiKyyhp5lDoffSFgqvPvAkelDQFXq
 9KF5SsQmDuF2ixwQnJvIvbi5vGw9Lvyy7N9WYqFAo3zpf7cQg6Puza/Z4rHwNskF09et
 nCsg==
X-Gm-Message-State: AOJu0Ywfa0+DpEBiOhW7hZ+KWuJvJfHGc12bxai0XPmA/B5CP/F1kQOT
 qjoBeEO8sN7dWYYpS6E7LCuv1uGN5z5qv7wiPBcFhyG2l2GthKXBwvtUYilKa0M5CAKS87o1azP
 IZZlIqJlSFBaea906imVkJjMRtzZk6KSud01UjMjAVrAPpS24y/YZo7q9h3llEX9V+u9Vv/n6C6
 N5Zg7RZXzFAwh3IrrbqdWzBxsVoU6RTWM7rodxS47D
X-Gm-Gg: AY/fxX523yQZ7T6KqwteM/c7GCwWzLNRgSkUSCmLwCjnLLIhDGxluxk89R7we62BsDL
 8l5ItUeE2XyQ8TDxvakN4s8zbQaVoXS27TCY7tJUpWVt6wmwpxSwQd/AAcgh9Bway7REWozhWC1
 7wNkq/kwpQ8mYpl/6vIEcwYjgwIoZuGxF8cCaphzQl7NIqgM8K0uROwt7qUs588LN99548EjyIb
 rDuBTdwWVaiXdGpfRgTSwkb/U+wnl73PwaGNklgBgvR6/WHNoYU9B16p2dLbUQgXuZGTLfhDB3N
 8/e52jtDvXATS2PfdqOVAXn9yKnHXYwSCxRmvZp1shDJwoLrLY5Arwu8d87g0cFePQCLiqQmoT+
 IloCyB9mPv2vk5SFXIIHcmN8Okbh8Unqwlp5B0m7rQCUDC4EZ7CupFRTHN9KWGPV2Lxfhaj37/J
 sqIKyjeJJOrUs8wH8=
X-Received: by 2002:a05:600c:3e18:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-47d4e6fc0f1mr40400235e9.23.1766827096445; 
 Sat, 27 Dec 2025 01:18:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHjvIW48Vu01GRNP4RseiHgKFoIYr+urKP+RGe8ldUJn9pUUQlZKpFbnUZmyl6JjpaxXjk8w==
X-Received: by 2002:a05:600c:3e18:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-47d4e6fc0f1mr40399965e9.23.1766827095961; 
 Sat, 27 Dec 2025 01:18:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a49315sm203692265e9.2.2025.12.27.01.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 058/153] rust/hpet: Borrow HPETState.regs once in
 HPETState::post_load()
Date: Sat, 27 Dec 2025 10:14:45 +0100
Message-ID: <20251227091622.20725-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Timers in post_load() access the same HPETState, which is the "self"
HPETState.

So there's no need to access HPETState from child HPETTimer again and
again. Instead, just cache and borrow HPETState.regs at the beginning,
and this could save some CPU cycles and reduce borrow() calls.

It's safe, because post_load() is called with BQL protection, so that
there's no other chance to modify the regs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-15-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index da938f356e9..abbaebc405e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -882,9 +882,11 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
     }
 
     fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
+        let regs = self.regs.borrow();
+
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
-            let cnt = t.get_state().regs.borrow().counter;
+            let cnt = regs.counter;
 
             t.cmp64 = t.calculate_cmp64(cnt, t.regs.cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
@@ -893,7 +895,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         // Recalculate the offset between the main counter and guest time
         if !self.hpet_offset_saved {
             self.hpet_offset
-                .set(ticks_to_ns(self.regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
+                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
         }
 
         Ok(())
-- 
2.52.0


