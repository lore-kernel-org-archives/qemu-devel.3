Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87388E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR9-000630-1j; Sat, 27 Dec 2025 04:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR5-0005so-TW
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQR4-0003bX-CF
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3JUmPJ/juui8+XKZjoKGDOzRk+FSkrjgG0mg8NiM70=;
 b=d2KVAsmzwfCuTfkyEVh7uzWPHnkhkmhlpPwpz+4wxVbgDSwmnxx6bULXn9rhhA9SmR6hMz
 fHhlGNWFnZRZVctn2QAjyv+gi1efucQuQXIoHHZt9DNyYH1Q8xl7+PbxJmuHHSw5MsC3/z
 nK4T0I+ncR1FgN0qwVvVb/weJDslJW4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-pJFVjyihNS2Wpxt63MGOOg-1; Sat, 27 Dec 2025 04:18:03 -0500
X-MC-Unique: pJFVjyihNS2Wpxt63MGOOg-1
X-Mimecast-MFC-AGG-ID: pJFVjyihNS2Wpxt63MGOOg_1766827082
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso19381075e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827081; x=1767431881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3JUmPJ/juui8+XKZjoKGDOzRk+FSkrjgG0mg8NiM70=;
 b=ouRGWlQ1piwcJAbtZavaYz+kjIA3ogrAJaYOleUQmwH7dTgRvysXhrRIV83RwEZojP
 yqcC/b5mvT4oKgOpR2oMpWi63G5kRnCqkL7QwwpuVvz2uWj+8l9qzpHJFIzPNQL7nLfw
 HXmr1arY2klePLCBqHgyyPwcL0jRJXJwrGA4BC+nzd6d/J/VPY8YFZfmhdktqo8e/g+Z
 eTdv+DSezls6c4jYhq17e1WjD+sXSBLfeflN2nGFL4YaLJIDLHt13tLpEp4lDZWGedAZ
 HUB3AJ2l4EIaexhpRrNhwaqRdVVGGqWv1o6mXEkCTa61KU+ZtuAsjEn+r646zPJCz1P6
 NJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827081; x=1767431881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H3JUmPJ/juui8+XKZjoKGDOzRk+FSkrjgG0mg8NiM70=;
 b=GiK9uCPfF/8d3aPW+y0pkBRvlK3HgVjXcQJwIKIJ2UMyR5rv5mu1zEDpDo/x/nD5GH
 GdeqsNLwUmkgQzy3YjEd95rjgtxvxusOX36C3FlHHqFFW0YB8MFhd6IW7gmjZNYiMPPd
 /2r5b3wUsTjy8U2INzDQFNTuIDcWb/oDy2lNsjXZZ88EjTyjdwiCmacsa4ekVbtR29nw
 t4czxAdeXrLDyaaw5ItpAB8FDmTGvXQZO72lH8ygA81O4ys9tWyQk8Szj2KZyxwqqz/O
 KT79Wt85tTH8fQoOJm++qF6PPIf8DeFfwi+29ElEbeTgMD2CwP8K1HWsjNZ8jl/2zrxj
 FDbA==
X-Gm-Message-State: AOJu0YznBpZeHFmUF3b2wTmhE0hmTDjeMH3ODpYQTM+5zAib8DMYa7pc
 qhXjUp6scP7SyRuTPco3GXeSA0T2Gul+o/7UekXMU0wVJJHBzTMYRWPVeU/MSMq6S3VjPKPSJ9G
 LjQbEiIw1pdF8jT5eXh4K5RbTVJYAt/gPQkzpj3+ldh7lEqP+ibcYb7CP3cdgMXkbNIt9ZBx0ih
 64vUUkfgIlwfUn+S+MiBCICo+Ruk0UIbx0qUaJVWVc
X-Gm-Gg: AY/fxX5Wk3mgQuinbJu2vcXqNntzwC1fDvI0/SVscjT0sRizaeSjUm7G1kwNzK7NWEH
 Z9FZO8iJIyJkuIJNOd6yXfzg8ZCh5WL1ODzFPlVyS14DDX/E0u/hp/PtCHWOK3HxKF6MVRl3Gqh
 phDvlFD+fxbZ9fFfEJADuVT2dfmiJ6fCWIGYBGB3vhrCaAqvAm1sqCk+nmjlVsxP0mKECZ5OsVY
 UmpV8AB0GAaUHfSA+dwibocWIL+YX/e3YAWJxieMtlD6rkXMnsSonaGeblnTUzc8qiECnwiMdaY
 yZ1UDq4jaj2j2kag1/2ZmoGwWL2XDJDGnLayF3j76UpT59BoPZHvb6nQ74NbYF9ULpr4oBqe28O
 igs4/7vMYnr/MLBoOt2YVAEyc5BaUr+nkM2/C0fjU8lRZPeQsjjgpsfuXrRja/GLQ2DILtMEBqj
 oR7KehNSAQQr3ZaNU=
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr283136685e9.9.1766827081338; 
 Sat, 27 Dec 2025 01:18:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyIDXFhDPRix52DF5n3AOO1Tzo3X/E4Y6K4JSZAa/eVWW91cbhS6WBiNMkpChV5YOe3VUiLw==
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr283136435e9.9.1766827080960; 
 Sat, 27 Dec 2025 01:18:00 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm423172875e9.2.2025.12.27.01.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 051/153] rust/hpet: Reduce unnecessary mutable self argument
Date: Sat, 27 Dec 2025 10:14:38 +0100
Message-ID: <20251227091622.20725-52-pbonzini@redhat.com>
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

Methods of Timer and InterruptSource have been made as safe, so make the
related methods of HPETTimer to accept immutable self reference.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index a2c5b7d04c6..ddfdf5185ad 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -318,7 +318,7 @@ fn get_int_route(&self) -> usize {
         }
     }
 
-    fn set_irq(&mut self, set: bool) {
+    fn set_irq(&self, set: bool) {
         let route = self.get_int_route();
 
         if set && self.is_int_enabled() && self.get_state().is_hpet_enabled() {
@@ -344,7 +344,7 @@ fn set_irq(&mut self, set: bool) {
         }
     }
 
-    fn update_irq(&mut self, set: bool) {
+    fn update_irq(&self, set: bool) {
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
@@ -382,7 +382,7 @@ fn set_timer(&mut self) {
         self.arm_timer(self.cmp64);
     }
 
-    fn del_timer(&mut self) {
+    fn del_timer(&self) {
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
         self.qemu_timer.delete();
@@ -656,7 +656,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             self.counter.set(self.get_ticks());
 
             for timer in self.timers.iter().take(self.num_timers) {
-                timer.borrow_mut().del_timer();
+                timer.borrow().del_timer();
             }
         }
 
@@ -680,7 +680,7 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
-                timer.borrow_mut().update_irq(false);
+                timer.borrow().update_irq(false);
             }
         }
     }
-- 
2.52.0


