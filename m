Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EDCC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgx-00008F-HO; Wed, 12 Aug 2026 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgV-00087f-SX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgU-0007EX-8X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdsfDJq0N8HUdLIKKMBehusFJkGfXcTT0b2//0AMEHw=;
 b=eH1xMEsGsblYPNsddahp+b8MktXHH6HwLS4HZ7f4AU/R6t8BmJfk5yYf1yIbzHC31dzIFd
 uf24DZfCR3IjCiQG4BhVfUy/v+n51l3yG5xkUCdVAmb9GyvFopY6Z12wtU2IA1SHi1dgk/
 8u+EKiOwDDMM9OzL1jZMnb91hepWwPE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-nX_UV4JAPwygHhN1Pp8Z4A-1; Wed, 12 Aug 2026 11:15:59 -0400
X-MC-Unique: nX_UV4JAPwygHhN1Pp8Z4A-1
X-Mimecast-MFC-AGG-ID: nX_UV4JAPwygHhN1Pp8Z4A_1786547758
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso10747271cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547758; x=1787152558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wdsfDJq0N8HUdLIKKMBehusFJkGfXcTT0b2//0AMEHw=;
 b=dO15qFEETl1BRhNsCzA1d6RlMvM7GultG0mElWe4q9ZUyOFpQrSFv1pNxm+T8jhQE6
 GyTk2AYgnt/V0KGKu0Ax68T464RS8eYs37l3ZoZwSS70e66PcCQuPsCi6yxNr4UAfrUg
 yWKo9t7O6ZQJVm/UYHsUlFzKPAVYRaL9mfcps2Z8zzCX4UJySKosmA0tIOpTXMyPZiqu
 eviFMB37H6o3a+MI1qr/tYAXxrlqZN+wNTjbPb3T67AGw8g6VDvEPEaigfIry6lcZDw5
 THVLj18mXHCZG0FQhRG8GBaBUGde75/VUx3jXNk1vsKGzrKS3nsmmsGbJONt9Wr3kbIz
 AAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547758; x=1787152558;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wdsfDJq0N8HUdLIKKMBehusFJkGfXcTT0b2//0AMEHw=;
 b=OVy/JW6gNFVgDSzq22gyC++jr56Yjf4PjPbSELpYjagaMcajQk1sHIZANcB3xrn72z
 yEo59rIyB2BeXa4FruOzwuhlrxfVuSoNP8uoK+yzsK2Z76wHqbNIZvp0PrOnl2lklBwA
 COo/hgMug7M4HXERyJvBzoAIzbl5e2pCwJfLm4duy0kdtc+F3VZ8QwUaoY8GEP1q3vnn
 Qru1AI51xPZ++7vISpVeoXBzGkfvpLlxGZm5AEsltCA856ZxXIudMIXZvjr3/GaiSlHZ
 rjvrVadKuJ1ITIcMybc+pwzyXaZxx0s58TypSuL0UgR16gxtsTBPxu/gKTEvdIRTlfxh
 nH6w==
X-Gm-Message-State: AOJu0YzMhOjnSJIILekl1Q2KqFCv1GcqD6hZ/5sabIRZyLyV5u9QNbL2
 OHLvMov6R8JUnibUrHBetIrVyaEUG0LdJiCA0b/Qx/oN8gSsySiurb8e8zU58ADfsk9K/a5yH+a
 lc0BmfMUJmvlyv4LIttr5uItJDPQVUM5CoLCNSVSVPO7/ue864oU2eiyHepIiOC5+FpZYp/IOun
 bGPbohYdjpeYNUMKgWQ2P/uNCetUtnSAaZDPK8Nw==
X-Gm-Gg: AR+sD12m4FO3YO4iTopeymH1MdMtf6iLrhFM0H84/IJ/bUNQYdG5G9Tf8R+vhxoPZQC
 TtkPv7oHx7kCgvxY/AmH33dNrVSWpuY1A5eGk32cwIRgx1WO4YXoAf4V2M2uptlf+9klSO2y2K7
 a6vdq2b58R3lTau10y4HE4IFToTt1xTfq0x7AEnoVjeBZBerhFhWt0C3B/I83a9WgkzhcyXKIyS
 e2cl/PC4rfHDEL20UuYCkbIjfIzhgVxBhLpELaljdJeEbHqo4Xfx+SzZUXbNrVakjpDQV6bf+Kq
 CHmhGqxhHCtuIBerZ5NiOkbeJ3EJD+4CTC3OwoRZ2zBXmyG299xS3+gcCGDYfwvxcg==
X-Received: by 2002:a05:622a:581a:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52d648b2a9emr49738331cf.38.1786547756938; 
 Wed, 12 Aug 2026 08:15:56 -0700 (PDT)
X-Received: by 2002:a05:622a:581a:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52d648b2a9emr49736781cf.38.1786547756149; 
 Wed, 12 Aug 2026 08:15:56 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/10] migration: Fix rare hang of migration_channel_read_peek()
Date: Wed, 12 Aug 2026 11:14:43 -0400
Message-ID: <20260812151444.2611689-11-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

In an unlikely case, when a migration stream is attached to the destination
QEMU and only send <4 bytes to the channel as magic, it's possible that
migration_channel_read_peek() may spin forever.

Fix it by adding a manual sleep for partial read.

Since the path isn't attached to a coroutine, it means when partial read
happens, there's yet not much we can do but hang the main thread, it will
happen even for len==0 case.  It means monitors can hang due to this,
either partial read or no data arrived (but connection established).

Leave this for later, the hope is this is extremely rare in production.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
Reported-by: Feifan Qian <bea1e@proton.me>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20260812124327.2572363-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926..266ae8f776 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
 
         if (len == buflen) {
             break;
+        } else if (len == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_wait_cond(ioc, G_IO_IN);
+        } else {
+            /*
+             * When partially ready, we can't use qio_channel_wait_cond()
+             * because it will return immediately.  Apply a manual wait.
+             */
+            assert(!qemu_in_coroutine());
+            g_usleep(1000);
         }
-
-        qio_channel_wait_cond(ioc, G_IO_IN);
     }
 
     return 0;
-- 
2.54.0


