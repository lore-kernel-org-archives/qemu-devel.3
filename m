Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80828D25931
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfY3-00013I-Ve; Tue, 27 Jan 2026 04:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXz-0000uL-EZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXx-00005G-TR
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cYofKArb7TT3IJb8VWVnq10rniZyiKo5QV+1i+5V00=;
 b=DQsUfQgYveGT58KRHbSB9t7rA5kwAqOhAMyJAM2aEn0NGZb2/RupbfxdusFkh162abkRux
 RGmHO4NShIhetbInalQbhbBY/t0OSgZIvKkQBgdwbGE2dWzHxzYgFCdsgEl11tmir3rwwz
 AA6l0iquH8fXpYTuBKI6aa9/UkcT7jc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ltl8jazHPQ-jFJgCnKU1ng-1; Tue, 27 Jan 2026 04:39:39 -0500
X-MC-Unique: ltl8jazHPQ-jFJgCnKU1ng-1
X-Mimecast-MFC-AGG-ID: ltl8jazHPQ-jFJgCnKU1ng_1769506779
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso71007995e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506777; x=1770111577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cYofKArb7TT3IJb8VWVnq10rniZyiKo5QV+1i+5V00=;
 b=j/lPRscSe5vV1a3DWTfC7AguyJwRe6oor3xKXeh3PsSa0iufOsR2iUOheA4gyaZ5e6
 4CaWn6UNy4Fv7fBd+y2Lw1ngaQczuGHyKYANw6ta2SmBpXH+f1CohmZ/sTfxnNvp7zGj
 Uo+9VnbdSNaTgovn8ZNLCz5alp2pzlaMVp2b1XjT2ldOU1JbijVxgkAgFaSk++MhEopO
 M1fdP2gB4dq7DmFs3t3Txmqmot4erPPsnsyZlMEAF634sjGtzrgNbQlUUDyWWODo6AmM
 LI4OKCZCBpef2IvXwPMBJHqaD0HgPZrUkuU2Ze98POvTPZlu2dBxLF+lYZsGMHrpbp+5
 c2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506777; x=1770111577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5cYofKArb7TT3IJb8VWVnq10rniZyiKo5QV+1i+5V00=;
 b=qheUD4k7zZ49ttkBx1Tc4v80bszXz75vM+B3sG+0p96Se4moJc2r7BwYCHA0IZbo4E
 lOWEOV6tq5HU/sAag53G07/D6F7BeJ3+vPmwIHXGlzdT0CjTR9Uc/S+ovVKEiUL0CMXL
 +bK1BDE4JfZuDBuA8jkYxLxajMK1vdMFzwu8+vIJyeguSI3JDFy4yDjwrAI0KEIO/6Mo
 owp9rEH4GpjRAER5AT4taEpPnGrxa8QifZByE80endXQiOYqr/vAMm6MQ2u3WYzeOmgz
 dcuQjxFtu2XIbqm9ez1LXpv5HnXOaYdMwf6KrZxs9QgcA36JpqR4yHCBMyJqplbnG7+L
 o/gQ==
X-Gm-Message-State: AOJu0YzmHJb3KF5T/obZWZpcHU4WxZZo8qPG1rias9Tia7DRsAB+Bo4J
 gm50hXZ5iKo25JxZM7ViZwt01hV7GMWz2MvY67ffiRRXpDFwNSLk9OYoySZK2e0ibP1YjJ+ofMY
 sBoCo1CzGTS60qLtLfg6WSXVlBTOe8u1JooUTkHMXcuLuyBvOHFQSgR1jU3FxtmsnrHoQdGuw5d
 lGw7ovbmY6LsMZx6BnLVjFCOKCpevXNvuc8Gp94prP
X-Gm-Gg: AZuq6aI84SK/lSSks/1LMKapIEnHmUGUuHGx3wh8EiBB3Q3iyPSqS8LvuRyakgqhYKm
 eKah5aq7TomvqcpqtRnXrTANDw5jnl23wUpibfC19ewnEnmpewcvXC418mD4L2M8QswgkMH4Ied
 Ez/dehBnjvLuqRtxd2nm2IiNaLEVfzVFBj1SnTDVy3jQh9xlIj48XM3OJk/QzIr3XSiNuxGInCD
 fiLqf0NMKH4fGK8OOc4HL4BBgs2s/k0RE9WFSHZ8oid8KE8GhmrIuXfZtk7i8NY4Vk9TUuRm/3b
 gVCRLphL7PvOgcuDjTsE1zh+8as7iKCwqZzE8B7jzqEoVTJX/HesvlOJ0QBcDoT9GY3sMBh8oRS
 psbzIKRftT+zUOci42FUtHPO8D+yV9omwC13+uRSX+rbiB5aatmil9N4iOkrahwReSP5K/0YWdv
 TZYUhYye1286ePiA==
X-Received: by 2002:a05:600c:4fd4:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-48069c98e19mr11036695e9.34.1769506777103; 
 Tue, 27 Jan 2026 01:39:37 -0800 (PST)
X-Received: by 2002:a05:600c:4fd4:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-48069c98e19mr11036355e9.34.1769506776584; 
 Tue, 27 Jan 2026 01:39:36 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d3ab9a7sm136288845e9.0.2026.01.27.01.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohd Kashif Khan <kashif04x@gmail.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/13] rust/hpet: remove stale TODO comment
Date: Tue, 27 Jan 2026 10:39:06 +0100
Message-ID: <20260127093906.353741-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohd Kashif Khan <kashif04x@gmail.com>

The irq binding is already implemented in the following line, so the TODO comment is obsolete.

Signed-off-by: Mohd Kashif Khan <kashif04x@gmail.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260126210910.28889-1-kashif04x@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 4757bf5fd55..ebf715d3995 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -725,7 +725,6 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
             self.irqs[0].lower();
             self.irqs[RTC_ISA_IRQ].lower();
         } else if deactivating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
-            // TODO: Add irq binding: qemu_irq_lower(s->irqs[0])
             self.irqs[0].lower();
             self.pit_enabled.set(true);
             self.irqs[RTC_ISA_IRQ].set(self.rtc_irq_level.get() != 0);
-- 
2.52.0


