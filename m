Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5C01091910
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ilh-0000AS-IR; Thu, 19 Mar 2026 15:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ilf-0000AG-Uf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ile-0008So-0N
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso11594945e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947448; x=1774552248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAJHgYrXKXC/iSuIeaBrhrwLYoHDHxYVlnJ8I9GtCSY=;
 b=N9Yyn2WWsPuVAvenX+2eX+eGVrsknGP52yRf/3ddBXsWn0KKJehH/lWyX5/32CKUiQ
 1aU0fZ7y2iI8kdncGkSqEPAg630sSYZQMlKYMHASQfHDTflJBmZ9meMb0Y8+mal53lKn
 aIHq15ldAxx3pNXzYW+8ZtLDKutuGECNMxlQJ18F3FWeH+U0ESOuBVKpsPJQdTX/pNwz
 8Ga2+AubYeJCcXIgjmsdM9R2d5O2tgb3akUbHohp+pdniGGQrxWH1BNuhjqZDmozC+/7
 9KV5wU4rNGSxzTFIGCoa2S2St5aqBPsSFCYZBsnPLm6O5eoXjB1JiuhH/I152pXLodj2
 CVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947448; x=1774552248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GAJHgYrXKXC/iSuIeaBrhrwLYoHDHxYVlnJ8I9GtCSY=;
 b=an0qqO3AKQ7VJ9QdUsp6LSgmyAg2wRitaM0ombLN0e7Bxd94InmY/AgDE4yuKiiYh0
 BfUJCz6MONJ+PiMuwnpA8sy1fsE1LQXKkoybVb/v7qTrUz9Nz50RJMSREEkg6+vs4hGU
 la4WUgZ/jiMLQMtSC1QlVtl/HVJbGc+WcsfvvxRtCsUtHm2h7shzGH2KgWq+4BmGBR7j
 h3EKSkvelo87vrHq9jBCmBSYXQHtXiovN3MOQ5M+xS0Aqkaqldog2tUnW8sZStqsbGMJ
 FrILUDJzignlLQILvVhs0MtaYIvAWU5RbZ1bpOwYNnn8MB1XYVThd9SjLNuFinzaMwtS
 84wg==
X-Gm-Message-State: AOJu0Yybf/Vcd5ch2l8VZcjFs04Pr6Bv/GfZi8IOogOn4VgXe3AcxLfw
 pOtR2S4mROKSFwgkLeYisTbqfw4T4iOQa1GApBvgjCR9lLLnK2zjF0YGY3MYKkAam+ew+Wq3Sn5
 26270NS8=
X-Gm-Gg: ATEYQzwKbn+8t3hHUfsPhWEMqD7EyESN9oFdRPKvhSoTvvyeJMXa7i4HVIKW4bLh2dY
 fiKGyvWPdu38bq8XsZpYA4gEqwPmsZEbUxARgjnQMrT+TG/gPcMAiMLjsLRh/V/2wUEFWKQszT2
 T2hGMzq017IUZKvhF1fM7D/DhYNp7kzyhPhf8mL63ayXKZVjSGCXNQUmExg2PiNYYgTOuSwllSi
 xFDGzK9v+ANYa+ieGGMR0A1QN/pxvUXZDIsuqByKkkiOv4O9lP+IArB95e4M80AJsPDqvq1vtZZ
 yBmGBfTADwC0oIL1mshBFWkw28pnCUhTf4YtS3YspYOQYzzjw2Ra+/SQAby4LQotYo0na3xfNUf
 UOT5R3F0ENG+joC9qV/tnWLHOuTP9Zyj13q6YLoCKO6Ly3XYLei/pLUZ/NVRcPp42Cf/XY7HCOL
 1d0GgS2Pwsqoh6hW/hZw9cAm9lalbP1gf1XpESvJ9C0zZbCb+DkxER2Sm559Dajc7Lhh31IQOs
X-Received: by 2002:a05:600c:3e10:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-486fe8b0073mr8736885e9.4.1773947447852; 
 Thu, 19 Mar 2026 12:10:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d91fbsm8499575e9.3.2026.03.19.12.10.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:10:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 4/8] system/memory: Constify various AddressSpace
 arguments (flat-range)
Date: Thu, 19 Mar 2026 20:10:13 +0100
Message-ID: <20260319191017.12636-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index bd12184a879..87ebeb93458 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -888,7 +888,8 @@ static void address_space_update_ioeventfds(AddressSpace *as)
  * range `cmr'.  Only the part that has intersection of the specified
  * FlatRange will be sent.
  */
-static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
+static void flat_range_coalesced_io_notify(FlatRange *fr,
+                                           const AddressSpace *as,
                                            CoalescedMemoryRange *cmr, bool add)
 {
     AddrRange tmp;
@@ -912,7 +913,7 @@ static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
     }
 }
 
-static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
+static void flat_range_coalesced_io_del(FlatRange *fr, const AddressSpace *as)
 {
     CoalescedMemoryRange *cmr;
 
@@ -921,7 +922,7 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
     }
 }
 
-static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
+static void flat_range_coalesced_io_add(FlatRange *fr, const AddressSpace *as)
 {
     MemoryRegion *mr = fr->mr;
     CoalescedMemoryRange *cmr;
@@ -939,7 +940,8 @@ static void
 flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
                                                 MemoryRegionSection *mrs,
                                                 MemoryListener *listener,
-                                                AddressSpace *as, bool add)
+                                                const AddressSpace *as,
+                                                bool add)
 {
     CoalescedMemoryRange *cmr;
     MemoryRegion *mr = fr->mr;
-- 
2.53.0


