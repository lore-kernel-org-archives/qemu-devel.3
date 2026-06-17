Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49511CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIM-0006fL-Pt; Wed, 17 Jun 2026 10:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIK-0006eb-R7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIJ-0007iS-87
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLghqftpXQzJ1hZZJsFZxm2xXFHvSjTG7WPPx2ZMH4I=;
 b=JapBC+7BD+Ttm29rMoKeIlwh/oqaJcU3XqoYjID1H+879dQsPHoaRQbeVfjgRXRR8bbK0T
 9qCGOey+5Yu+aMx7kP0XbyisPVZx4mqwG0dB3wCdyZr2fnj/T8aX+f/s4FG2ebA9tzDLWn
 klnp+UlzDUlsecraI0XJhCid1iNARC4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-VWstmMn7MEqe_V7elzEzEA-1; Wed, 17 Jun 2026 10:31:04 -0400
X-MC-Unique: VWstmMn7MEqe_V7elzEzEA-1
X-Mimecast-MFC-AGG-ID: VWstmMn7MEqe_V7elzEzEA_1781706663
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-bebacba844bso519527066b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706663; x=1782311463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLghqftpXQzJ1hZZJsFZxm2xXFHvSjTG7WPPx2ZMH4I=;
 b=hE6tz7ZeCpvL0tdpN2GegBmfp7qSxQuIJOIVklsCyoY66YakhDETdOGXtXnX3JJjLM
 UjtJv/E/DSwBxqMn/t90mqE8lpBC66ld3Drjt8TQDCRhAwizXMQdTU8a7KVSL7fGOs+w
 Dkd+RBV8/RX9mweYZfrzxFVLf92Teq1xodes7rmYN6APG6e7qARU986XuVRn1WFp4g6z
 heC3EC6KPhxZWGgi6xHpRHcCxdVGuT4D0660pbG8H2QJeN/6WP9P3IoGZN7i3TybtGxr
 AvDkhFgTNsxS62iiKa+p6WO3hq/s1XW6pPbn+eGN6VPM59t80Inz7TnHEr6LnqtjBG+0
 qbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706663; x=1782311463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CLghqftpXQzJ1hZZJsFZxm2xXFHvSjTG7WPPx2ZMH4I=;
 b=oWg25s0q1qaa2CPlxUmYLyab8V/IDZoqv1NeCDebGNsWG4pJOqLORj++fjmpvMYwJG
 paGy6LY2b48ozQYeXuSep7+OphA8RYFzK1lcVQsmp6xphsKXlca+RU11gNt75wwe7kaE
 cfg6KAXpunoUOFFTA9TaiQt8goekz49xXwO1GEvIEUUWMOrIfZ80iWd4ZM1GAlh09Qzp
 4wqWLu00KQRkbPt3irVfOVMpFMykenAw9zHb+UFn6Q69CZdcHCxWcR6viOBSFOGlSV7E
 0wPWBUjD5DqG3A3wSsmQIPSZBGF3fbPXHUqmqVLJxmu1BbiGULUJZihTK6H5GgvNxuua
 +FCw==
X-Gm-Message-State: AOJu0YzUZ4Ri0/R1uAKktVmC7/kt4yrUmOb6Ozr4PjVLw/jFE4tq7YMh
 hMyZVj8t/dpdU9jXTlWU04lUgvC/AjGihg8xCfqAY6tOwBAfmUVwMykNl+cHY6oxTRFvs/wgZHc
 jmupmx0HGoz+AbjcfAyBThs3W5wxMTCeAtA+C52MqbIZgMFb1e+1z2F78+5mxbhGjSWJVcIoZ3E
 upjx8kk1grGUjg6atwIvqbKotkXH4fVsH0n4E2iFkD
X-Gm-Gg: Acq92OFmZ8m/qm4oSDc7GhNCVbYUcy3Na0CuRSf8xeBAioxJu16sh4Kmdf64HTXwqit
 TIEQBFUFvlqWVMzLModh7dA1TaCNfBxm8AEmqjzBgl2DrHGlz5FNsnmWQRp/RjtTkGzz+IlaAn3
 mXi3PzXGax2pyH2KyjULLHFXLXBjp1VjlMLs2/gxafLSxJilEOaq69RcG7fmtVlelxv1jTVg/jF
 XkYWT2tLHSG5pbNJ4OiwlMMXY3YMO8FgdEjKHmFi9Lrrr0gI1qULznHaLYAEUjJ9TAnfdzr29U7
 5pG5wXkLbuXSJPIOQS9QO4Q60WSBSb+j/iGFg3LY+0p4J2QPEXI06l76L0BKGsY/q06yDjV1G4h
 Nlwf9AEWmfo1GJRpwMPoP0+l2Md2+MhUv8TrYSJX+KQxSMXhBpbXeNxg+5ti9YwraxXOHkTAtE3
 f1itt1p6Z37xnwubos
X-Received: by 2002:a17:907:72c7:b0:bef:f4a3:e0cf with SMTP id
 a640c23a62f3a-c05a95760a7mr307186466b.48.1781706662398; 
 Wed, 17 Jun 2026 07:31:02 -0700 (PDT)
X-Received: by 2002:a17:907:72c7:b0:bef:f4a3:e0cf with SMTP id
 a640c23a62f3a-c05a95760a7mr307172666b.48.1781706661172; 
 Wed, 17 Jun 2026 07:31:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c01d667f63asm540392866b.19.2026.06.17.07.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manolo de Medici <manolodemedici@gmail.com>,
 Damien Zammit <damien@zamaudio.com>
Subject: [PULL 05/16] Include new arbitrary limits if not already defined
Date: Wed, 17 Jun 2026 16:30:35 +0200
Message-ID: <20260617143046.445322-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manolo de Medici <manolodemedici@gmail.com>

Although GNU/Hurd supports unlimited path lengths
only bounded by available memory, for now we can use
an arbitrary limit on PATH_MAX that matches what POSIX requires.
We don't have bandwidth to fix this properly right now.

Author: Manolo de Medici <manolo.demedici@gmail.com>
Signed-off-by: Damien Zammit <damien@zamaudio.com>
Link: https://lore.kernel.org/r/20260208055858.2166524-2-damien@zamaudio.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 2f0e61ad6b2..1ec5b42230b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -384,6 +384,17 @@ void QEMU_ERROR("code path is reachable")
 #define TIME_MAX TYPE_MAXIMUM(time_t)
 #endif
 
+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+/*
+ * Use the same value as Linux for now.
+ */
+#ifndef IOV_MAX
+#define IOV_MAX 1024
+#endif
+
 /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
  * the wrong type. Our replacement isn't usable in preprocessor
  * expressions, but it is sufficient for our needs. */
@@ -661,10 +672,6 @@ struct iovec {
     void *iov_base;
     size_t iov_len;
 };
-/*
- * Use the same value as Linux for now.
- */
-#define IOV_MAX 1024
 
 ssize_t readv(int fd, const struct iovec *iov, int iov_cnt);
 ssize_t writev(int fd, const struct iovec *iov, int iov_cnt);
-- 
2.54.0


