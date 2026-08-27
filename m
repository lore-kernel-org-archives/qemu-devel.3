Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2404C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzasQ-0004Lr-3r; Thu, 27 Aug 2026 10:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzasM-00049k-7Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzasG-00068H-G0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8K1XNZx8pAwhOsPmaAvHPY7r0/0nTtUBbCf52x0tFMk=;
 b=QXookmiV9m2kjEbM1thdscYdBv9gOml1CtHFY6NvgsLsyG1sDwwusLHcZgk6IChjLTfkrp
 XgIbWRGo5Rjs1BGTkvYyl/Ly/xuF17Tu2aLz0k2PgeGGmru6vrLdyr3Nd45UBwDe9G6LCJ
 7RlTr63+Okq1H4vRVC9mjbs5yM8X38o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ecyWpmbTO_2t8BZ3w4qBsA-1; Thu, 27 Aug 2026 10:14:34 -0400
X-MC-Unique: ecyWpmbTO_2t8BZ3w4qBsA-1
X-Mimecast-MFC-AGG-ID: ecyWpmbTO_2t8BZ3w4qBsA_1787840073
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482f2b8a116so507163f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840073; x=1788444873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8K1XNZx8pAwhOsPmaAvHPY7r0/0nTtUBbCf52x0tFMk=;
 b=gui1b5CudZG69CSUhTeV7RWKyxNXMXwzRT2FqC8eIVacqm22zHqkuw9R83PYwjZSKW
 zOEPPRmpYL5HwdbUK4jP4QHdBqdIEVel/uRXoEHtTEnMCZ+U3hp8CKWI5jdKtO2pIehj
 6WhJUIOsHAnEETjBz0x4g15sFAhG4QCN4LSijQvc8Pl5cyBvXm1VFoZtwNUhIefEk4tV
 tOuI9E/YwA9dd51FHoN8H+eMBfHFN+pRe5+9KSISNAHYuERx5IKx7shwoowCRd2MZwd6
 F5mkCV7Kt4V9dzG5U0e5i77vhkrkFPUpQf65Q+MuHsYMeeWlQCSKegdQdPiqTaJSj2+f
 sn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840073; x=1788444873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8K1XNZx8pAwhOsPmaAvHPY7r0/0nTtUBbCf52x0tFMk=;
 b=JXPofe+cAs1J/mJaZsrAt3UNhZpaojYIBxWqti72o5b9DfkjbaDJm194gqB7W0XfBi
 uQqvS4zejOTdjZlXEhc4B2h1sbk/0EqwvL4ieSg0Z6mVzFbUz0h5xe/Oz4mmvApYFeRq
 uguX6N5j2w5F9Q2OZ8StDELzzvedHwZyssfw9cjfIcYQBQtPvx6CEk9dh5XWnnp1CM2t
 6lpwOORCD7t6TQRK2zgj9GmlY2PZe8r9wH6QpNIxa6Gpj2HCOpkxDTSbvRoF+zJbLBHJ
 u0CingBXV1XTTQ/UbJ0v7QqRVKGZMfic0JmhEq3xCgJuT7C0SZiRWhf6nDCGq/FNa6LR
 Y6Rg==
X-Gm-Message-State: AFuF++k585Yr6Js+q+atu3cWqy2fwfQfU3jRZCrIE5z+h7qX9P1jTmY4
 TygwgSZii9fj7Vkg6PB2/O1Cvg24qfLbXH1+jc0/Z2fea1f7LUQKGmZf+4WKKZGQSPHV+7+kjd4
 bw0Z0AKj77/MGV3GukjJ+1Ta+EbDkYuesLpfzqpC3MZsEMwmYlo5ybjFnhSGtyoAkTdNp6cPG23
 NIKzjEk8y6+CfxOWIRNL1u7nvywcPMei/V/CxLBidK
X-Gm-Gg: AR+sD131vAbch2W9Kx9ZA2TFWYhE8O6Z8v4qyuH0fs1HUnhreYdkNblcwKFw521cU9a
 bMoy6+1TTJNxsR82+rpkhaoTrXOsWMZq1iB/uuwuPOHSgBK9q3QAeMLs2JK49bgqfAvnMEPgbJr
 ekVg0k/2355OLbV6X11xhnAac3UIo8dfjsimbneCK5Z8glREebuf7rx3QL85fxbCQToS/PUBjxo
 WjBXMdDVcvgvAL1gH2UErtLNsoKfbPnlzUQxjRy1apXpyrarrXH4F/mNSrp9HPezS68otUSz8lo
 53bMULjltY3cJbTStoGqId/dlq+Ezpso0Z7EkR2CjnpfWQoyB1dAW80WKGeJKa4F4X/tBcONp3q
 577CYqTQpBMellxqnCKNUBPYvY9txpRjoMlZN5RgdBrnbo/tHjJR2uLTiAKSPcJbyccfrm1I7td
 dZ/c0=
X-Received: by 2002:a05:600c:3b03:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-499dc6a37famr175883385e9.0.1787840072994; 
 Thu, 27 Aug 2026 07:14:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3b03:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-499dc6a37famr175882195e9.0.1787840072437; 
 Thu, 27 Aug 2026 07:14:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4ddf5023sm50170215e9.13.2026.08.27.07.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 23/23] i386/vapic: unref MemoryRegion if vapic_map_rom_writable
 fails
Date: Thu, 27 Aug 2026 16:13:11 +0200
Message-ID: <20260827141314.1099352-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

memory_region_find returns the memory region with an elevated
reference count.  Drop the reference count also if the memory
region cannot be mapped writable.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vapic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 9adce172621..5c3911cf9c8 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -614,11 +614,13 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 
     /* read ROM size from RAM region */
     if (rom_paddr + 2 >= memory_region_size(section.mr)) {
+        memory_region_unref(section.mr);
         return -1;
     }
     ram = memory_region_get_ram_ptr(section.mr);
     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
     if (rom_size == 0 || rom_size > OPTION_ROM_END - rom_paddr) {
+        memory_region_unref(section.mr);
         return -1;
     }
 
-- 
2.55.0


