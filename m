Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A61EC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcQK-0004dK-79; Thu, 27 Aug 2026 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQC-0004aZ-El; Thu, 27 Aug 2026 11:53:44 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQA-0003tN-Af; Thu, 27 Aug 2026 11:53:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=s3N7lf8
 eK2qQs91l0/G9JqpbSOY6D+SgAESk+1UYAmLKmk2K4nsuLp4ZJJq0uyjZZYIGQVyrq1aCn
 wXHo2G0zxrqnj0jnXbrJtwsmwO08ooULwyaX4OkGlu2g5qSbJ8ar70kdmNjCJ2Nx2duQQW
 FsrUmYGRm9Ij9NAaaXZVi00fQWad8IM0AzZ/3idFpj8AKZRMn0zjkueE+NmzI66nCf+a/s
 yiMLDRZgi5/dAKHMID3zGx/fQ7gtvfB7ZU4w6uvWyBVQkqLM559rGF/fCN6BEisSBqTjWZ
 8T+J3KnrV4hrYEp52CjEDAmvkbb8zLRk+kGDK4b6aUb+mwiI1Mbm/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=k
 oHFNGi4Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Ht7CtIX0XOLhBO5Uu56MpRa1RMl7hL9c60aCdi3lcI3EFsizavKby/wT/MNSulQUCng0
 q4wzOp0+ISoAcGIV+UTIbJnzPKAivUFDZHVpDEfAXnbjDdjqiZ9OUKwIjJm2yMyc/KM7Pp
 ZDdZg+CxMiz+GK6hJMqFYNQicafmG37B43uBSCiYHjGMHvS99KcZlxWKc9HeQlKiPweLs+
 D+QVuQXefz1sJuaAc/eTYs2P6MggSZ5NFjOghLg1hUB10WVM3eWrgC55TsIQYfX6+4552G
 ivA9vqqALouXFHUMz8h7CAM/SY0e9jvCtaNlaMjjIDgsZrRkUXBxYqavbIUZnv/w==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=N08YeuPB; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=orbkN/Go;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=koHFNGi4
 Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=N08YeuPBRn+y2i91cFwiJbm+xeEeZdfilGC
 Z5OeM2qJlxOUoW6XvKReD6ED6avzShXmKCUx5QX8GbCXZ0cB13qIbIDecXTXUB6kIPbrUa
 BgEyDIhkNvS7ip0uoFKk6JVUMmWiUOnM5TZzHZ5fesYy+k+CV7HDaKffXc/5IWqpNNcufN
 KFbwiZClG2tqjAG0UFszKIiA/eR+AX3fUCmNqWvQ3pqoPBP/8EhbGat8qjmv9v8Woo7bti
 O6aRWgfSgxOtWGtZsuy6fKVNAn/YSNfhB/a3cHijDt9MXnFfQpOpQAwfs/DXGhLYY2i6SY
 sil9AlMk0xwGUexSzemfp6YsHHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=koHFNGi4Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=orbkN/GolrxBfQQm4R
 dvoNILVUHzGbteF9TOqJO95rSAYFuPDdd5/cFUKJGpdzOaVysxAng5Mue8iq8bfkBmDg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 45be0742
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:53:35 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 2d6fccd7;
 Thu, 27 Aug 2026 17:53:33 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v1 3/5] cuda: Include command in successful ADB replies
Date: Thu, 27 Aug 2026 17:50:36 +0200
Message-ID: <20260827155310.7223-4-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827155310.7223-1-kirill@korins.ky>
References: <20260827155310.7223-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD and Linux expect the ADB command between the CUDA status and
reply data. QEMU omits it on success, so guests consume the first data
byte as the command and lose it from the reply.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/misc/macio/cuda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 312dde242b..ccb3e1d74b 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -431,11 +431,12 @@ static void cuda_receive_packet_from_host(CUDAState *s,
         {
             uint8_t obuf[ADB_MAX_OUT_LEN + 3];
             int olen;
-            olen = adb_request(&s->adb_bus, obuf + 2, data + 1, len - 1);
+            olen = adb_request(&s->adb_bus, obuf + 3, data + 1, len - 1);
             if (olen > 0) {
                 obuf[0] = ADB_PACKET;
                 obuf[1] = 0x00;
-                cuda_send_packet_to_host(s, obuf, olen + 2);
+                obuf[2] = data[1];
+                cuda_send_packet_to_host(s, obuf, olen + 3);
             } else {
                 /* error */
                 obuf[0] = ADB_PACKET;
-- 
2.55.0


