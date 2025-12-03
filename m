Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE208D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 03:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQe1M-0008EM-Q1; Tue, 02 Dec 2025 22:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.d0e4v9dbe8d7847=ei9y78n82hs8=kkrtpyhcwbj6lz@em483429.getutm.app>)
 id 1vQe1L-0008EB-N6
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 22:59:15 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.d0e4v9dbe8d7847=ei9y78n82hs8=kkrtpyhcwbj6lz@em483429.getutm.app>)
 id 1vQe1J-000080-PE
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 22:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734343; h=from : subject :
 to : message-id : date;
 bh=/u1E37d+3X51ePDYb6BmriMzonR1iBWObPUX/d1gKos=;
 b=egAtQscEEIJgRuwddjPdAmq4tABynjX+tgYuHgDQhCYWqkNZ0QR2jjFgxG0YHMdCNfVQG
 Pj7N0Y/sszLDXAgAo9k9f/4GA/kwgKdDPFbPqL8bgQfyKUUNVxR81d08ejunm5Zm3LV5ztX
 B8NXO6ZIrz/GgQBlrMErfdTEbEK2j2HLn1G8uuiry9aFmlDOI3z6RufZ67268/q24j8q3jT
 twkyrJuNBmvS52Xc3VOn1hGCPf662AapJIDHk2SDb7IGvS0aFiEEdjdqOl5TZ6TmL40j/24
 mpeB03RnOzak8I0Z5QV7pFiq6q8xCcHrDdgwXUkzGdp2cBoyxu0JoCHCzBxQ==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQe13-FnQW0hPuz7X-XUJo; Wed, 03 Dec 2025 03:58:58 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] hvf: warn when attempting to add unaligned page size
Date: Tue,  2 Dec 2025 19:58:47 -0800
Message-ID: <20251203035847.94102-2-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251203035847.94102-1-j@getutm.app>
References: <20251203035847.94102-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429socTp5oMZ1
X-smtpcorp-track: nTpqvOl5bKWd.XwnSChh5x7a6.HiMA1QJCakm
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.d0e4v9dbe8d7847=ei9y78n82hs8=kkrtpyhcwbj6lz@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Instead of silently failing, we should print a warning so it is clear why
a future guest access to that location might cause an exception.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 accel/hvf/hvf-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e83..7823d8416c 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -112,6 +112,14 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 
     if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
         !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+        if (add) {
+            warn_report("Cannot add 0x%016llX:0x%016llX because it is not "
+                        "aligned to page size (0x%X)",
+                        section->offset_within_address_space,
+                        section->offset_within_address_space +
+                        int128_get64(section->size),
+                        (uint32_t)page_size);
+        }
         /* Not page aligned, so we can not map as RAM */
         add = false;
     }
-- 
2.41.0


