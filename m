Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9B8C5DF89
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUc-0002S1-LC; Tue, 18 Aug 2026 13:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUX-0002PQ-FY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUT-0001kD-3r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIQdYzUyDS70g4qZx06wyl1NEPaF0TzMGv46GneJ4Ys=;
 b=LhHnHTMilqTbIb9pDd+N96l/f53ww8NpZm6fD7jsG6Si5+L/fAtuBT3jqTbyjkB2lOe9X0
 3s7QwD8BBRuUou76VQVZkmeKnWXA+oOwqvdlNT+WuzueNfrcUTgQZLf/WiyclWZdEJn3ip
 J7iBRMWlUzKDgWNLjgA9BrOYW40pK+Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-NkNjfdiBP0yjchttsfYjxg-1; Tue, 18 Aug 2026 13:20:30 -0400
X-MC-Unique: NkNjfdiBP0yjchttsfYjxg-1
X-Mimecast-MFC-AGG-ID: NkNjfdiBP0yjchttsfYjxg_1787073630
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90a60102d6eso2195176d6.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073630; x=1787678430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hIQdYzUyDS70g4qZx06wyl1NEPaF0TzMGv46GneJ4Ys=;
 b=juKHuY5DYK+rSe+qOQn90jNJRZ+gHm23nS2DXDVkv7ia9mRF9L8fKYm1ATmqGIRWDw
 4h0fHCufbNPX0bEwP+qyqzuEC4s3Gam8cTSyMN/Gp/TDLUNOXHxLvuncL+FeRSyAwk4o
 laHnaCY3992slZLpH4m1TxcgUISmNjHzb5CGsxL1pw6h7fIsO1ZZZLSAUQOIwhJ21kAa
 W1e61q0xKoYjSlvHHA1XpiuduBjLAxi05gybHgFR5ZeJ2ptngun3zghDDbMhU1aQijIE
 +Wnq3cAstJeKzpNvb/+EhLhAh9V9F9lDzinwfWRzpbgoeAqKGWe4DxL9qX7hBAI7Fl/9
 te/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073630; x=1787678430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hIQdYzUyDS70g4qZx06wyl1NEPaF0TzMGv46GneJ4Ys=;
 b=imPZSA4S53yAAr10NV2UaKEBTCYA5w+7FbquLKHhlq2x66ewmFVCmQcJaCJPxVDEGH
 bQewvyUjzXhNxen443X5RMw82MjVdDIO6J1CRJqS0c5IoHFtlLGYqBBopJxs29IQBg5U
 jAuI6AVwG1X56VHL8wRD/x2PxpqMDFtVO5utj4us+bs+TiYBhDT2DkHqEUdlQmAN213i
 mXTnVLS/Ldi3orGU69F62M1WTR9dNW3YTCjgSdprWE6muALNMtkIho6urcHt34sHI1mk
 Dl/tL26aHs+mme3+B+DoX9HHm2L2nDWrzk7wI2HOukwl9iAT0FCgsINSMSgMFzFaqHAp
 gYig==
X-Gm-Message-State: AOJu0YwavvMbpCOwN9dKz9P6tEV1E3vuDZ/rNfQXF5Q40hFYSVb70Cjt
 LKoA1CPV0bfury3zJLF5uVhwqTH6kl2x9RLCT1rKtajWdgnjrpvsfSOPGrL/0SeWiAsBM0iSRFZ
 Zt0Bc61qkaYEEDf6lb9WMkLwd6P00lKIBj/nGjemaYnOd5DFiRI1sawDYa1Q4jdV6QVx/xeqxfH
 uO2njn9WOMBIMHjpcjJsn9qjyOj4AFR4KD82jMuw==
X-Gm-Gg: AR+sD11Iwvgf48NFhFH4rzZLBIljgfx1IdKDzSL9Yq7ktZdvhP3mAV4UnBu8up9scCn
 9XtRoWnUX5WpzyTtMoCvK2qC/kC006hFBMQYXXorgYQwYX5HAbKrwiyS3LmDj1lL9UFqauELGaR
 iNzgRxfT93hGiWSwg8d1Kqa36gE7Nh5axl5WkBR/wjCAv40Vrh1p20b9IB+MVF/1gKhTT/r6/6B
 xHu76rg5FZK6MR+ozeyuFBr+KVWelfHUGwgUw/p94qrlgIfvBxpRwEQmyGpOKb3EM9fIi0U1V+Z
 aypBVEj5GTA7kytF7LDUPRcc9Ar42rDPVyY6IrC22EUwDSNfQ0gziH667LoFCpO42J3/eeCcXnR
 VT4Sj2+Eb9wroKAWfCyQ2Ugug1mP1uEp56IStU7nUqXLjayn0fQsDUbzX
X-Received: by 2002:a05:6214:5d8d:b0:8fb:7e7c:b494 with SMTP id
 6a1803df08f44-90c4b3f4614mr116932956d6.26.1787073629894; 
 Tue, 18 Aug 2026 10:20:29 -0700 (PDT)
X-Received: by 2002:a05:6214:5d8d:b0:8fb:7e7c:b494 with SMTP id
 6a1803df08f44-90c4b3f4614mr116932046d6.26.1787073629260; 
 Tue, 18 Aug 2026 10:20:29 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 4/9] xen-mapcache: Remove 32bit support
Date: Tue, 18 Aug 2026 13:20:07 -0400
Message-ID: <20260818172012.3052821-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU has switched to 64bit-only hosts for all system emulations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/xen/xen-mapcache.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 85cf0cf359..e30c07c2ee 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -26,11 +26,7 @@
 #include <xenevtchn.h>
 #include <xengnttab.h>
 
-#if HOST_LONG_BITS == 32
-#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
-#else
-#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
-#endif
+#define MCACHE_MAX_SIZE     (1UL << 35) /* 32GB Cap */
 
 /* This is the size of the virtual address space reserve to QEMU that will not
  * be use by MapCache.
@@ -151,11 +147,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
         exit(EXIT_FAILURE);
     }
 
-    if (HOST_LONG_BITS == 32) {
-        bucket_shift = 16;
-    } else {
-        bucket_shift = 20;
-    }
+    bucket_shift = 20;
 
     if (geteuid() == 0) {
         rlimit_as.rlim_cur = RLIM_INFINITY;
-- 
2.54.0


