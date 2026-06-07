Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24683CD8C8E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWEhc-0003nz-5M; Sun, 07 Jun 2026 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWEhX-0003nT-Hp
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWEhU-0005BV-Qn
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780843327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q8XQOn9LUh37rgLXmw94eIPYjrEIayaDjh+oohRkMR4=;
 b=ZoybR2KcIsOrt3ce0FJRIp3sUfQk6GgpZYkvJU3aORXhbTxa2u7cU9PgDEV65X6P2ILXzw
 t93rRVaRO04vTDN60JhI7b/Cr0M0eNkSuNS6iZ6zH/C/LaV3UO1qo5ghxvvQT3p9G/aUXE
 GErRDOyBSHFzflkQNQPG51vdbKp60Mk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-R0We1wGWNcmodFeOHXbSdg-1; Sun, 07 Jun 2026 10:42:03 -0400
X-MC-Unique: R0We1wGWNcmodFeOHXbSdg-1
X-Mimecast-MFC-AGG-ID: R0We1wGWNcmodFeOHXbSdg_1780843323
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8611b27631so882025a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780843323; x=1781448123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8XQOn9LUh37rgLXmw94eIPYjrEIayaDjh+oohRkMR4=;
 b=ZQr/lFcuP7MhQ1z7uKzAvo6psbLDK0kU+vcdacg09AzUR+Rc6KG7w0cgcBmxMwe1LP
 9x8V1gc3Fi39JqQpTIchY1ZGOGtGRN2FvAzq/5Pn4nc6RjSSRMJ3HaLC8ZcelBa6gBso
 w8Ujvs24hffu9oNKf7T8YYo1rb7lLXruPvqQW7B8xMo0ZRJNiVyUkLzUtJ1f4s1yQqL7
 OTBWl1SbBzR09RlvT3GkXY5kowI5G0zmUYRBXKx56yI/NTOdt51Eo6BQQyCGemCophkd
 CjmXKO+AY0HK8B06U5zKZ2cZKHnOdSE4HnOOSACRQTDa2KH2QzeOB70G6yv0H/6E9X6D
 vbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780843323; x=1781448123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8XQOn9LUh37rgLXmw94eIPYjrEIayaDjh+oohRkMR4=;
 b=VTQwJBrVAaQWAae0qp3plUhyH1SfbShIRDMhdhHhpIyc5lcdD1fsEqrBwvySfjCVIp
 s302DrRDtm5351zS2dD+S/bnElfh7enLyhBjFSzlQ6IU93u/yTrRYfLQMLCNlYgSWlKC
 IUj+P4TsyRN7ga0ff3z9yZQ35OvG8JWQTLYSoyha0iuDjLZS67i6RDLPeCtPRfxU1OrS
 xajjALjy48oJqSlGc/V5a1RGyVrBS/kfD0JHbJYNVGpD1jyw2JSjyFIPO8ROIzLRbarz
 pxwZl5/j1F8BgNoTMy03ug/WH1LVDKwOJ9G9aeaMSvC3JXktNtwA9aQtQSzzpHG/f5Xj
 MQnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/O9O5aCpa06f8eujt3IwnXJd+sAqnmIMnNqz129g8F3dxmkCXhS/2BeccmjwxOSJvPnoRAl8qucUyh@nongnu.org
X-Gm-Message-State: AOJu0YxniBqaJmqrLuLiAEsYaBzVQgO2iLdcjGqG0kKUGybfeBQLw2Jr
 k2DPMctX7FOnGiknrm9GbnrNJAlC9KhyD95LIE6jBLN6WWDSlS0azqHPJGv65Oxpjo7Ns9WXLpo
 x+bMVQOaiPR/jEDKr1qVapMxEhL0oQCDTI+fRQk0VyNUrpmnWOEdts0e7
X-Gm-Gg: Acq92OFcSsvYxvl+2irpElmO6sKLYaJoHD1EQJaAkIoDZCh4U69lSvySXxO4aOP8YIO
 Jr/6Z85hCdlpjvS2hocDv9KM63gZTtq2tK+ktn48j0D4txvNNx9FOcg0EE/9ceyyLp+BzdiDc89
 wpn0Q2GQjFDKQC+xZUt5a8Pp2hmx5CZ2RUelg97Ur2v0d35Hx5/JSBxJaUlXJSgGAy3DP1VBTgd
 EA2fS8sC4sqtbGsBEtG7jutl2+F2jusnqv+oYXjfm7H0hWwFqdJgM4xpl9Wz2GaievxVvkkfaNB
 nI84VADFKpWtNcmkxSlBzk1zCTPfm2Hn5ZMMAwRsJbtM2qc5O4ZRmiq6bSEKoG2GoZZO+G9gkI2
 4adyV7+S2t/PVYO+wwdLXq3qHi/1+cgUwCIrLQiY/RZ7BUTOLY2Bmj2gBjmPA+4/4QN7r
X-Received: by 2002:a17:903:2acd:b0:2c0:bcff:e1a9 with SMTP id
 d9443c01a7336-2c1ec7dc6d1mr87143965ad.9.1780843322697; 
 Sun, 07 Jun 2026 07:42:02 -0700 (PDT)
X-Received: by 2002:a17:903:2acd:b0:2c0:bcff:e1a9 with SMTP id
 d9443c01a7336-2c1ec7dc6d1mr87143795ad.9.1780843322167; 
 Sun, 07 Jun 2026 07:42:02 -0700 (PDT)
Received: from ani-lenovo.lan ([122.163.16.238])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm147750565ad.21.2026.06.07.07.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 07:42:01 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] igvm: spit out region size on error
Date: Sun,  7 Jun 2026 20:11:44 +0530
Message-ID: <20260607144144.445493-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This change makes the error message provide more details on the values that
caused the error. Cosmetic, no functional change. Only useful for debugging
purpose.

CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 backends/igvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 31ff6ee0b2..8b578b3b5b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -207,8 +207,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%" PRIx64 ": region size exceeded",
-                addr);
+                "at address 0x%" PRIx64 ": region size 0x%" PRIx64 " exceeded",
+                addr, size);
             return NULL;
         }
         return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
-- 
2.54.0


