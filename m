Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D41C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26C7-0002iN-Dy; Thu, 03 Sep 2026 08:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C4-0002hJ-Sp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:25 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C2-0005Ja-Nb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=NwJClQ6
 rxqCQywUO4C92xb0lZf3f9zNQlczCl4ds27/sqjCy5wXdGJ23KvwE9a4BbbxrA4t3nWI7Z
 u3ZszT30zXx8qAZh5ffFfhdQaxAqz5XAVV4aoMrZJIZoEjubFw3pVnbMIMAk9SUXja9zIT
 Gh6Ly0/FGqQhvVnhIC6zySlorjArT6fVnFm/OOEfVV+VXP/n1lN7ODOsk5fO5jGW7cnesi
 VnBFOfOD0b8JUkeknHwvpYVCGK2c2wCG4l5YKf/EKND/aNt0vo4M+4HMRrecGzi6UQSNqY
 sxxsT1nF0hMGJhfZetfcXIZNGyYmcMjhcWrDKGRWTxzMhtGs/ci9HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=4
 pig9i2fHRxRANsh7tiMj+tEIYraNPzc4moL169W8vk=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=MWCod3c5AgbAxnGr9xXqGOWNT8G4b4JSIpK5UPo+z8z0a6F4VEp18FqRSzuvkH1L5GPa
 0WhzgmWyGSS6s+FGjiMWXw6gOX0xTdJfbr84bHgoz7PWpDZOUAQXYkgQabNesiBUq3odKC
 ftHwQbAAzcpJlIB3ISEDX6LNZT/31muUygbmCzKYAQAdLyUIh7jxQT6muIn1wHDL21MPo6
 UFBqhCTq7JSVQwLtKGLyth+yFvjECoh5tcPn5gKYKJJQBhPsFxn/FRTeOEcuXBaFlhTOvf
 eMfMAWykjk1SKZWJKME/j93szEh+/85ZZ+pkn/bzcIXXPcuw1S2N+tYIqIbhh0fg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Za9hJZYR; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=6NLDU0O3;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=4pig9i2f
 HRxRANsh7tiMj+tEIYraNPzc4moL169W8vk=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Za9hJZYRNmFx9ogjfgwQmx5qKea36ZZ1yj2
 qHdXM1D20DEgvpk7iD6w/0o7VGLsQUZxVZ9u8IuqswmIZr3nukCUfqWuxSzi3K312R+QLO
 cEUD0OFSJc1psVfBGnEub//niFWsY6S2go357cwUW4CIHFNxNKbPnP+6OfJsq5MENS9lZD
 sStwGByg0DHurc7Ikufox1BUqNCwQ/i4ku9/Hn0wImemcB5eZkx9JshmLkpnlCwAqD6QtX
 bz25ISoSbb79TrStcKVvI2jZ38mwpLEG3xXD5OMzDiKaExZwap64fkIrJSoh4WOD3ewC3P
 97JQegNrPfnloT23dhtx9oZeczA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=4pig9i2fHRxRANsh7tiMj+tEIYraNPzc4moL169W8vk=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=6NLDU0O3XtohzWzDAa
 6KBRbh1U8ey4yz7vyf1pG/czDyigiLv2GF6vbQqeXI3XrNTs+IMdho+tt7Wh+XEoy9Dw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 4e406c7c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:19 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 73407dda;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 02/25] target/mips: fix MIPS64 segment access checks
Date: Thu,  3 Sep 2026 14:01:50 +0200
Message-ID: <20260903120510.34876-3-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
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

The xuseg and xsseg checks only tested UX and SX respectively; kernel
and supervisor accesses must instead use the mode bit that applies to
the current execution mode.

Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
allow kernel mode to use xsseg when KX is set.
---
 target/mips/system/physaddr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 746dbf8aa4..626d7ccc4c 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -143,7 +143,9 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
 #if defined(TARGET_MIPS64)
     } else if (address < 0x4000000000000000ULL) {
         /* xuseg */
-        if (UX && address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
+        if (((user_mode && UX) || (supervisor_mode && SX) ||
+             (kernel_mode && KX)) &&
+            address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
             ret = env->tlb->map_address(env, physical, prot,
                                         real_address, access_type);
         } else {
@@ -151,8 +153,8 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
         }
     } else if (address < 0x8000000000000000ULL) {
         /* xsseg */
-        if ((supervisor_mode || kernel_mode) &&
-            SX && address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
+        if (((supervisor_mode && SX) || (kernel_mode && KX)) &&
+            address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
             ret = env->tlb->map_address(env, physical, prot,
                                         real_address, access_type);
         } else {
-- 
2.55.0


