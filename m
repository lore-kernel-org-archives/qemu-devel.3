Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE2FCF649E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMA-00036H-IN; Wed, 19 Nov 2025 19:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsM7-00035m-W8
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsM5-0007Ow-TS
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aaUR6WzSNP4cK/DMriqb/j4Ba2z3R/UyBF2bczQJeI=;
 b=QEyUa30A+PLaLmmeHLBp5FLHC+6xU+OfMYUj2FlCvspcbn9J7H3WP60tTPXla9tmG6gJTS
 MV7dqGV9cvOjnyAXJwUoNZBUS8z4LaGjAeeDOO30AYpCBLkc7hWhk01MjqOxPlwBMI8ej/
 8s6ntAv06nSCm4gUVtprtMq6952lc34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-DVOER5kPOHahvIZNyHa6QQ-1; Wed, 19 Nov 2025 19:16:55 -0500
X-MC-Unique: DVOER5kPOHahvIZNyHa6QQ-1
X-Mimecast-MFC-AGG-ID: DVOER5kPOHahvIZNyHa6QQ_1763597814
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so1571735e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597813; x=1764202613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aaUR6WzSNP4cK/DMriqb/j4Ba2z3R/UyBF2bczQJeI=;
 b=P770kqb6eUi1H898SLnnMTayKfmN083oZO7OCclHfevASZD97tqHrvPKNtv5GUGPZR
 osKofTRs0qfc3mRDMCOS30r8O+AClewXG9Z5YHA+c/yfFm0rlmBup/SH9tiz9mskduXo
 DatEFrmMrxFQYlgWz21oCRGlhe3THkf4F50R96QyqksQEQrEjLihwkGNIuZKh+9CJC5r
 jfLfF1leWWBZfQLzdFeia+MSU1uBTUwxl/PJx1UZ9jsnuwJP0Necaal7/Bc9ng5hoovj
 gLB6+k9KId79pFKdUrarUWH/n2AvCw4e/DxcOEmTbNuYMdWe0UkrAZMG+LvrtWIZDR0r
 xDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597813; x=1764202613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8aaUR6WzSNP4cK/DMriqb/j4Ba2z3R/UyBF2bczQJeI=;
 b=CkBpNiv5QsR3zXI0XtBwn1YJ0xlqoFMxbuDT9SRgSZdLx9TPL0PdmbTauvQpKro8vD
 O9tkiv/+gsUswOS9V3RTkjoKnWhiSS82qo11QWyHOXX42bAP2R153woJXTlF2EyaTioK
 DUFJd5wn0u0/Jz1ZsrjQNnwTy7wOMAFSjIWld01WvRlhwY4i38UTJ5dxMlbOXzPcD6nK
 EU0qx7ynG3poF/5jzfcEt6GTbhRHl9APqdkFeKZ20qt2uLfnfYnd0tnIeV4i2J4i/oJG
 3wTN+35ZfuAVQ6KnwqWI8Vnn6ysIuiDyyhEzeZPUdk/SbLR9oOZv+By1QSeZ6wZKI8wU
 q3og==
X-Gm-Message-State: AOJu0Yxm86yXTaUNTNRBJU9+8825Pj8eqCsQmJ8iAtDQPJtVOkhVUcZ4
 eSWIr7GXJkCsg8gmJ7jca6I7nBag+XyIYBZIiTSs2j752CYIP9t4xo6kgg0ZK7l2yIasfnzdNas
 qtVM5XdKEjnBSfg2JzzBlYv7K5bevRZRT1OLkuFxkoIj36kY60CZTDx6TKqcmuwUc/EzS+ZufC1
 i/saSSkq8dJq8xYRO7mSrtJ9qV4rchAgKUVKsdVpI7
X-Gm-Gg: ASbGncvv+Ndpwk+j+Q5oGnsBUWjRmjCZ7ZNjsrr0MmMgFV9uZvl3hhkF3MRUXciMEyb
 ZPUfICZOxjxd5FUHDTbgcxuX3+4TWbmm/bTmJI0+KXw69L5pF+WE1qwHHrDUtNJd1vmjYV6wQHz
 KzdflxgOcOkR1jbkfxYMHiCuccc6c/JEzIpQ7nTJFf1I/TFNpFIyTR3+6RJRwm1Jyep9uMXQGBi
 UMiRS+tDq8SngIWQ00XzMNS06/RHCDrivfGtH1MBDl6+aTEYSPdNsPd3vjPPsW9MkYw8zb06OAD
 6iSVRvjJXwCSuLcuUuLKU6jqwXeIKQusrt9OYJ4v+2VEB9+r2zCmmy++9RelxTop62uQputM+9c
 xjWin6Bk1DaDJ+b6hf7Fr0x2y/mnsuFrQkOvTffnFddBwDJWweKz9I24SRf7x7LduU7/K8HDsua
 /dkYVXLE5RzbgwjSA=
X-Received: by 2002:a05:600c:c8f:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-477b8671ff3mr8969535e9.3.1763597813441; 
 Wed, 19 Nov 2025 16:16:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj3xzE6u774s/47T8gKXOnWMgAG84i6RAKPUsm9ek39gds3LW6a3xQ/J5fm7vLrBGy8xd8ow==
X-Received: by 2002:a05:600c:c8f:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-477b8671ff3mr8969345e9.3.1763597812968; 
 Wed, 19 Nov 2025 16:16:52 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b82d825dsm16085535e9.5.2025.11.19.16.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:16:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 01/10] ioapic: fix typo in irqfd check
Date: Thu, 20 Nov 2025 01:16:40 +0100
Message-ID: <20251120001649.1085913-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


