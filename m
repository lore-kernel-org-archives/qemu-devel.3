Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF49C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUb-0002Rr-AH; Tue, 18 Aug 2026 13:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUV-0002P3-Qj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0001jV-94
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylGQNZMjBaPWcBdv90tRCoS+9huFuWTjZ8NZy4tE/gM=;
 b=LPb4nok6bhmUnwYaw0OsIJ3Qefo8LzLFIshocYswffL+rA547R0Phu5QKKze9J4DFpZSZt
 /UcPu06IELl/0pGy5zHe4jhYUOdmqtrk0CFe4YKeoMEvyRTjLgNu0/4GX2VPTZr2pX54iZ
 WB6uPKCEbWWrcV1BcaquiJY2NCbR9us=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-vBje_0o7OyyUydCin4FjAA-1; Tue, 18 Aug 2026 13:20:26 -0400
X-MC-Unique: vBje_0o7OyyUydCin4FjAA-1
X-Mimecast-MFC-AGG-ID: vBje_0o7OyyUydCin4FjAA_1787073626
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90c4e6517e9so3656106d6.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073626; x=1787678426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ylGQNZMjBaPWcBdv90tRCoS+9huFuWTjZ8NZy4tE/gM=;
 b=Dl8y2XmfAwJ10kjGCUCvNDfLmFGfklGH0bQV61gJuwKXWLClZiRVPlgTNXHQ4yZwmC
 CoOm2fVZVVQ1qdSa0WC+GL/MiiOrrFA+2E+l4y32kewegURIPV3dWDNMSn3dCyFTbmb5
 Y4sf2Vnupp/RWvIW/xdHUNdLHzdKcWno+6s/nqzOXJEa5x/eU8w80m+P4+YJ6rds0DvJ
 EoeicACYApGBxhIobTRN0U+0qi5jZKwQk1UOQv1K/vy6rlbIVXpfF8PP8P2Qqe3KgQtz
 X5vUm1Lf4xrFDncrsbn6gZhx+W7ejmnZafSmkOy4R92hkMI3XiZw1TjVtBz3ihaDtn9o
 ZyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073626; x=1787678426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ylGQNZMjBaPWcBdv90tRCoS+9huFuWTjZ8NZy4tE/gM=;
 b=TTouzg86vufd9VPcw4smDRK5ZYbin8h31KDTsuwI8XLgm6xBFRkW/LVj/rEd8EOCBd
 SPUr9weLBU1URwSYgse0IR0zj4mcUIhTIRDQDd76BdgkK44Ri0d0Y6rEWsx01W0gPl+f
 z5h7I1nTF1W/rMTE48KAVTqhmloQ1sNiCT5zkO6HK945bqo53gwDttTjaQpEYphix946
 VqWtiHIZ7NUMf/BrICqKJCaIn5vfgN/ALT26tAdtQncsDk35M4JXl7AZxxMv6gp83CDc
 Tr5a7spBhhCribPBth354fusLstwylB8rqzU3rmu1VLtDlBy0hAkI4tldo7mSHEmsoEH
 nrew==
X-Gm-Message-State: AOJu0YxDJVbh0xESEx2CW8HbJeKxKSt+ZTfN2/RZQnhqPrUr/BQH4KGM
 xCZxQMnxwqmY62Gq5AFJSyL6hBAR+otR5SBQB20dTLm4bbh2Gr5P+LLI5G2PytNZV2GCmOwJ1CC
 BkmzDJFXJHxaXHS23MTlQ/ylVeudrFsdinddCR/n98aFWWXs72+rZHEBVEyPAJL8mkb9krQzXZy
 Z1YVl5JImrsD32qztj7KmPYJuPII2qf815IlvjWg==
X-Gm-Gg: AR+sD10xajzA7+lsGa6y0ockQwCsEjF95ln1f4ewpqHJsz7hk1lYQualDE6SLGCt9Ks
 CUHYo5xmkgRpCRuKTEl3IT9QXHZCK50KfnN8L5RxyEhOlr506PovhNcKOBI8qIpgKnaIlhtPcoo
 2ah0/gcTHJBWV4dF+g26rd7sdFzCNX1bw2sbkbZyZlCMJsrtqa1IamdJDnPrpTAatFH0AyIO7Ww
 axoRSvh+9mgHpJ0N8T2nFZ76UQRNKs7I/o6V3EY4mwyhU76WZrDzWdGx5wr0e37cYDMGmK8hlMf
 tjabvfTGacWQpYLrbXR2edR+ePuWzGTO/WdY0U1zmkwG3iGIGqGyGgJkgnJfj6ZZScMSBpKA+1E
 DfQQYIoC21OXsLjAF2qYdOnYqtWyiIQopBEEF4ByGoWIIrWLlyJ8oemXj
X-Received: by 2002:a05:6214:246e:b0:8db:dd:4d85 with SMTP id
 6a1803df08f44-90a91e37da4mr391751286d6.26.1787073626143; 
 Tue, 18 Aug 2026 10:20:26 -0700 (PDT)
X-Received: by 2002:a05:6214:246e:b0:8db:dd:4d85 with SMTP id
 6a1803df08f44-90a91e37da4mr391750206d6.26.1787073625569; 
 Tue, 18 Aug 2026 10:20:25 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 2/9] hw/vexpress.c: Remove forced cast to u64
Date: Tue, 18 Aug 2026 13:20:05 -0400
Message-ID: <20260818172012.3052821-3-peterx@redhat.com>
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

Now since ram_addr_t has switched to u64, remove the forced cast as not
needed.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/vexpress.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f26d8c6f8d..a6ce426356 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -363,16 +363,9 @@ static void a15_daughterboard_init(VexpressMachineState *vms,
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
 
-    {
-        /* We have to use a separate 64 bit variable here to avoid the gcc
-         * "comparison is always false due to limited range of data type"
-         * warning if we are on a host where ram_addr_t is 32 bits.
-         */
-        uint64_t rsz = ram_size;
-        if (rsz > (30ULL * 1024 * 1024 * 1024)) {
-            error_report("vexpress-a15: cannot model more than 30GB RAM");
-            exit(1);
-        }
+    if (ram_size > (30ULL * 1024 * 1024 * 1024)) {
+        error_report("vexpress-a15: cannot model more than 30GB RAM");
+        exit(1);
     }
 
     /* RAM is from 0x80000000 upwards; there is no low-memory alias for it. */
-- 
2.54.0


