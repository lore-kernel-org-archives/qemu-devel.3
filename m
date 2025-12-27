Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0168DE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQY-0004CQ-KE; Sat, 27 Dec 2025 04:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQW-0003pl-TM
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQV-0002lr-G9
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhMZmw4l6Hf5SDK8IzfKQnQK0WMwwbYlh1bvQfymtds=;
 b=Exs7qz9ADA3lzaWGx/AfVs8GMHnDB+5EoG6n/sTISAgN5mHOArP9JbJxrZzjwJIMLQgiM7
 leS139K/j/E51j1NnJ/0DxVYEYZw1sH7gBr+v4yMTFOrGVZbRQ7AewuX78iPdg0/4p6X0c
 Lwh0mXva3U74ht9z0wAWWKLLAXZg/0c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-PEhCGSqBN4Kzkm8-dJO9Zw-1; Sat, 27 Dec 2025 04:17:29 -0500
X-MC-Unique: PEhCGSqBN4Kzkm8-dJO9Zw-1
X-Mimecast-MFC-AGG-ID: PEhCGSqBN4Kzkm8-dJO9Zw_1766827048
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47a97b719ccso46045225e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827047; x=1767431847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhMZmw4l6Hf5SDK8IzfKQnQK0WMwwbYlh1bvQfymtds=;
 b=tQCaRl4mf4zviyxZMZvV6hJG38f4OsDKuXmLKy8f0HJ7j+UbpLpvDDk3WqgIh0Si5S
 VIuNgQtv/Jc6U6rFGNTXxrTu1LDnx2hZkJtyK0LD4undt2aAhmt+xTWuGQdXboMkKlcy
 XqVBL3PRtU927jrZ8D4XilgXFSVAU9swdrO2SXd+v4yPMy9egzzQyknQNp4CkHx5WCpo
 zHMkNymNeT6nuDsfhdnjhiNfB7N94EEJghQ+KnjtcQIqmnT0Q2e/XXw4I0QW/QBzLBap
 BtWDNFyUojubBxahwOzOuYdnQiq/S+XhKs9zPjaLCUeghbbBmOCEUnDMJZ/jOfRCSoGl
 mg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827047; x=1767431847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FhMZmw4l6Hf5SDK8IzfKQnQK0WMwwbYlh1bvQfymtds=;
 b=Isdd0wESQSfML0Z/eF/eBQHoeiRptnFamComiJqMFSh4N5Tfcew9BdZQSnSWHifvcm
 j5olakZvj8hSOahf3d0Ozxg49oNsKENxyYcZqvPkgAiWX87F6Mx5ebC75iMimVaqwhwj
 eP00GcmjPhSCOowTdr6KdftH8aQkCEaz3YVwf7HG6qppvSJC/D532FyJmh91rosleuOU
 KkhGVAdG1yR7fSUVx4ma6KId8Em6kxdtO0Wv5Nv0UPzKKoo0wnvGbhi1Wj2WfG9ihOyy
 ZPOT4+/ot+IHqGuD8sDjBj9R2m8nVvOVjWilS7egFfoW8xv+QeGi/NpMp71QbUJiBbA1
 cV5A==
X-Gm-Message-State: AOJu0Yyu3LUuYelxHqflD0SiyGg6yIwlDFr0YQDIjUmNNCRNlHp7+GmM
 yMnpEEK+m1khBEs2uHHUlhAXXTbDhRtIKc1oA64XE891H6wIMM9LAZM19dF+sDjb43Job7+xgOP
 Fd4boc0n5XOBp5aJMA3o2gPwyahnhVeXMkLoWfJzCAkfUaC6EdagzIdL98mzXb8Vdu7TrZDtTVG
 YtI8hL3lc/xpT5gM+BAtjyV+NIaRwaKyw3hprMwtRq
X-Gm-Gg: AY/fxX6hHheLj0fE+x3VQJdrNQQlKj4UB3BGyMumBNeR2UySn69F4BpLM3/kjcXP+Wi
 IoPxi+w7BxmT4uZ3G4Ppyw1Fx2vOCP24QkWBrJYKf41rC0hUS22XqqfHOGmnmSq0Y3+upGS4uT1
 MAErPbErJqBiTeFvn+XMa5QiqfoFMKNBbmNjkNsIzTPZv9RNSG+tWTJM6FqfChTl3cJeaDGCyT6
 EPdd3BTDZQiCS5Lpbcl5BLbBXSVl1wHLl0/IVNIoPzB5FRFbfES8zr9hBa7MC+3yym8+47Vrw10
 58wfc4VKY3RQ7/jd7pbK1E+rGqg/twHH273NSGk8QwmmUH4errPjYyKi55UdRhAEa1BUMQlbcdy
 t9pnkXMo14LXDndsZTGT3vGcIVEcBQuTQ5EePKaaHUDURxfwsedmsaR17rnB4wn8hXqQZA/ySE6
 UM1iVuHWzAtLe4TQU=
X-Received: by 2002:a05:600c:c83:b0:479:3876:22a8 with SMTP id
 5b1f17b1804b1-47d19555940mr294996425e9.16.1766827047529; 
 Sat, 27 Dec 2025 01:17:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIbaFoSTuzbMOM6w2TnNnqHOHVgbC7rvsa5ZRIMPwj/Oiv/2BVWsdaAqBovczFP80Gz9bYQg==
X-Received: by 2002:a05:600c:c83:b0:479:3876:22a8 with SMTP id
 5b1f17b1804b1-47d19555940mr294996185e9.16.1766827047055; 
 Sat, 27 Dec 2025 01:17:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm489405475e9.13.2025.12.27.01.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 033/153] rust: do not copy the SysBusDevice
Date: Sat, 27 Dec 2025 10:14:20 +0100
Message-ID: <20251227091622.20725-34-pbonzini@redhat.com>
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/core/src/sysbus.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 68165e89295..ec620639be5 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -78,7 +78,7 @@ fn mmio_addr(&self, id: u32) -> Option<u64> {
         assert!(bql::is_locked());
         // SAFETY: the BQL ensures that no one else writes to sbd.mmio[], and
         // the SysBusDevice must be initialized to get an IsA<SysBusDevice>.
-        let sbd = unsafe { *self.upcast().as_ptr() };
+        let sbd = unsafe { &*self.upcast().as_ptr() };
         let id: usize = id.try_into().unwrap();
         if sbd.mmio[id].memory.is_null() {
             None
-- 
2.52.0


