Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0DCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGyVR-0005zJ-IY; Thu, 06 Nov 2025 06:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGyVQ-0005z0-By
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGyVO-00084G-5v
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762429816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8aaUR6WzSNP4cK/DMriqb/j4Ba2z3R/UyBF2bczQJeI=;
 b=CWm3axmOIAjDt0WMAqpO4rSE2csi0wJequkDcfuT8ZIEdqZxlClFBrLZUM/w0DL2y+XCoI
 isgzBWpjXxk3HWliGlx7etGa7NAKuzXKxIrZTFOLTY4MdBBDdGyWpblXSO86qKiZWrLIQx
 FJk6ZMfUOIRzdd2tv93T4efJnHBG+kA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-62OlJdJUMQOZf7EKshzvUg-1; Thu, 06 Nov 2025 06:50:15 -0500
X-MC-Unique: 62OlJdJUMQOZf7EKshzvUg-1
X-Mimecast-MFC-AGG-ID: 62OlJdJUMQOZf7EKshzvUg_1762429814
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c7b0ae36so960164f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762429813; x=1763034613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8aaUR6WzSNP4cK/DMriqb/j4Ba2z3R/UyBF2bczQJeI=;
 b=MnFtRRsINTJuA73SLuSMqgJJvyu0t0QMuaAMxNLQ/X+GXeaQRGgJFvjxd0GIQKaiXP
 pYqzfxLmX+jtwfNZL2R9nz8OirqMktqdcD462w+TXh/kDyZEJ7BtMcM96Sm1jHo8uZF9
 AcF8PSiYBfkgmrgwR77q2FFeWUbWxauq4aUxFzRTSNGh2p6f2MLLb3YVBEnwbV9982G0
 adJ/bZCnf7/RJg1WTFc40mQltAQVSBSl8t+nIiHZmPn3dzm2rFpjujysjd7pB6rWD835
 ZqH6grwegjxl4ZjroO0V+tx3jMn+5WdGROgKYbi+iIa+k8kPMSOriZNKy3Juj5CSR0uf
 FdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762429813; x=1763034613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aaUR6WzSNP4cK/DMriqb/j4Ba2z3R/UyBF2bczQJeI=;
 b=aGXQnYFFG4Q7IGvdPGmd5cyRRzjSvI0zWUqJ4lqXjZy+CHAj0f4pCkmMM3Py1wKHkV
 tqIZuxqsnzvQ5vlIfSNb2VHae198jIQAjjHcvY7VeFIS+HExGYyc5sek9NSf8ayNhrH+
 pnX5bSPe3Z+hjZLWW4yd0D30HtfI1IPDxfye+lstkocrMsj78x35W8fKDmnSQ1TKWUs0
 3ou/i3ErRtRDaW9AEifeejcSMDcrEAyAScS+tL9Tv/18XmJfZ+aQoOW4SrnVEKKb65qZ
 +B07jV8kjbSnWZ38SFixNN8bjYfqU5SJdWW90hWJVoTB7lHjSwR5z53TgH7WsXuyjR59
 6ZXA==
X-Gm-Message-State: AOJu0YwTQrtHDouv/DUFjizPEv/sxNIh7zmbiDlTQxeUth3pMRe+1XRO
 vJdqZeD/yiopujQk0tkQ64yVlxrMvTUpWr78Q7BmJqMXJVg9UhNOnQ9F/YEZdLXxEklnjJZ7fmj
 aNMp10M/gbxm0x7l1YS8CNNkitoaZ8cP17t3uCvlDnangUfmbNHwlcwTrcJhtmq9iFVswwik0Qc
 qRZ5X/o64CW7ZN/s854BodeWNOxgyxUPrC0wdSHNGa
X-Gm-Gg: ASbGncuASjf9KQCGFCJz0A+PDYPtVWNKq2LZjK6AbBfPr0qOMreZYp8vo1BJvX19CZI
 EWvJWzLGHBwDqFb70NBa5e64q+yt5upEv+dmEnuCLaMxIHnweqJrdbpPWNDOk5gc7WpgBI6JbVJ
 Msj5BYII92T7sfRLew39wU/jGHvKjx7c2EctVFUZ8Z/Tds9TPhJ91TTeVc/wzZUtDQ/CEm7hjEL
 GNNxEb0m+Rm81ZL32wNuyjBBZbkCxfzCBLaRP4FGh7qnWeaqGD/wfkmw010pONxmH6miTGaPmO/
 Msqmg3brR1RUtieaTszDOCRcwx56khE6lvIZkFOeKhRiWLNTXCYFHKmLSsSE6J9Gvo1DFwKxeeW
 1RRIA8wwxknACU9ENyX1Jy0gFM8tMJF1ZIdXe2LqL8OVSfN48hS+boDXTQW0zeQZOHN5cOnZ1q/
 0TZCu1
X-Received: by 2002:a5d:5f54:0:b0:429:bb77:5deb with SMTP id
 ffacd0b85a97d-429eb1d0d12mr2856557f8f.31.1762429812925; 
 Thu, 06 Nov 2025 03:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWvnSe9D8bIEdfVpN1I1RPB787808e8hvkxlNS8rk9htpMfI/CUKY9yGYuFwNfX3anRkkrEg==
X-Received: by 2002:a5d:5f54:0:b0:429:bb77:5deb with SMTP id
 ffacd0b85a97d-429eb1d0d12mr2856539f8f.31.1762429812567; 
 Thu, 06 Nov 2025 03:50:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ebdab56bsm4211124f8f.36.2025.11.06.03.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:50:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] ioapic: fix typo in irqfd check
Date: Thu,  6 Nov 2025 12:50:10 +0100
Message-ID: <20251106115010.1141851-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

Not registering the IEC notifier results in a regression with interrupt remapping
when running a VM configured with an intel-iommu device and an assigned
PCI VF. At boot, Linux complains with :

[   15.416794] __common_interrupt: 2.37 No irq handler for vector

Reported-by: Cédric Le Goater <clg@redhat.com>
Analyzed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index e431d003117..38e43846486 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -216,7 +216,7 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
 #endif
 }
 
-#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
 static void ioapic_iec_notifier(void *private, bool global,
                                 uint32_t index, uint32_t mask)
 {
@@ -434,7 +434,7 @@ static const MemoryRegionOps ioapic_io_ops = {
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 {
-#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
 
-- 
2.51.1


