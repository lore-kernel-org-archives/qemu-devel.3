Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2B6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmtW-0006pU-1M; Thu, 12 Dec 2024 12:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtO-0006mU-PM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtI-0006mt-RH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlSROje/jH4aIG+vHs+aMStbuV+YcJ8QhC20zV8MRIQ=;
 b=QjE/GplGFQm5Ttdag1tDtYNqPsKwqMJJjPysii5kM1x7xwZXuyM6IiFU8A4dPzl35aDrbt
 //SVl+E7XZ1Sh0SfL2lfh1+FU5V2vMxxaxo9G3p9wEk5v5e5V9KN0RMbdPnzDo/A3nv+dD
 YGylIcGAUmSzif2nGXF+WVavX4lcDR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-9_IpYgGQPVmR0-u-mxLz1Q-1; Thu, 12 Dec 2024 12:22:18 -0500
X-MC-Unique: 9_IpYgGQPVmR0-u-mxLz1Q-1
X-Mimecast-MFC-AGG-ID: 9_IpYgGQPVmR0-u-mxLz1Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434fe2b605eso5521575e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024136; x=1734628936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlSROje/jH4aIG+vHs+aMStbuV+YcJ8QhC20zV8MRIQ=;
 b=MdB5vOgzZCojbpN1Tbd0gzQ50Q1gpabLT1GUC0afM1ViN8E3aVCpxmA5giHlDGGDtx
 Z4j/or0SKcTr/XW2s8fdLXT+F9Y19u2fe0gWWpzhRXd6h34Zmbm2MnW4PaaOQ+nBHgOr
 yzmw4ixNeDUAiPclqpLx1lqNyZ29qI4pTk9qT1AXkew+Qgcp5I5YqCiCpJJ+ilMGthuC
 1oghwlXV97K02MeS6m/Iea06UAZ+DYYyYFoCsaEw4aXeBKlsG+29D7E8joSRFCGhVJhK
 vmNhkevNc2TZa3XzMhzZKOhBf3hhiWK0P6CSoa/67KC6GyPOapqVt3qI8ZBSHcPdGmXL
 qlMQ==
X-Gm-Message-State: AOJu0YwS1DWBNWu1Bmvrazv2VLHySSHEd7e43jaMkTtC5HHBbwhU0HTN
 U4b3RKbl+T7AE5C/lfISKEFmre1Do305eqh62ylnumji4XMdNTeJiEErCbadHdAnTf5VqzZh6vn
 x+V4m8r+GvZ1WAD3+k5tRYpFk3Im2SfOlW5LQI5Wd6mjXrdC4W8g/Bxi15Ar6RbNk0XrH7i2d3m
 Ig0Dd5N3cQ1n0x0afOoohDEtI9Fii+tkLCpxT5
X-Gm-Gg: ASbGncuNOP82TaR0vZwjEtVo2mYFgTe0AebLEia2px70YqhTNDuv1q+i632LUL8F5pu
 uRYsBI921yPh2Lumx21wUG/3kMLOloKPkuy9fUTACLVhUOY46NmQOGm1/Est9NxWj3xdG9SW82P
 vk3I2MT29nOR76yMa/h/AVUTL4bjLjyngCcRerod895/vMdNZEVD9GbYSyt9n+fZhbjSjQHxUSq
 RKPYg7WoC9ajn6yot3i3QNeg8T44SnuJAMW5dSUJkT5eTFPh5If8GR1Eb9l
X-Received: by 2002:a05:600c:4e4b:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-4361c36f5b3mr66285495e9.12.1734024136143; 
 Thu, 12 Dec 2024 09:22:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsA5q7Fbw+NO+Mi5ht77fAvi9wOGQ4Iwy+WrOa3qRpj3Ln99lbAVYKYkTAluwaRHRWlIHtvw==
X-Received: by 2002:a05:600c:4e4b:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-4361c36f5b3mr66285185e9.12.1734024135711; 
 Thu, 12 Dec 2024 09:22:15 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec88993sm27906175e9.2.2024.12.12.09.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:22:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 2/7] rust: pl011: match break logic of C version
Date: Thu, 12 Dec 2024 18:21:59 +0100
Message-ID: <20241212172209.533779-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212172209.533779-1-pbonzini@redhat.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Check loopback_enabled(), not fifo_enabled(), like the C code.

Also, set_break_error() must not happen until the break is read from
the FIFO.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 41220c99a83..c6a8dbe1af4 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -465,9 +465,8 @@ pub fn can_receive(&self) -> bool {
     }
 
     pub fn event(&mut self, event: QEMUChrEvent) {
-        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.fifo_enabled() {
+        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
             self.put_fifo(DATA_BREAK);
-            self.receive_status_error_clear.set_break_error(true);
         }
     }
 
-- 
2.47.1


