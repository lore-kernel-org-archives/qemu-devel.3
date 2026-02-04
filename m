Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE7AE95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaAr-0000LA-6X; Wed, 04 Feb 2026 05:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAp-0000KD-TY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAm-0003vP-6h
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJKfGyDowF0GDPWbmFZ/c8FoE/RkZBRFybZy0CTtjYU=;
 b=e6VooL4+QLqqyE3KDtYKXU7Wig4hKQdNVPz3mlS/fH6uB/K06J2fGOaTtJcdEATPVLTRXL
 D8pXZ8s2qtQlDqEeSylJqgbT4882ymWrJNf95aUT4ZLuJzvNmvOZVZhcy38kaN0YxGeXWD
 pDIDNogNiW8Wh9IA/DqlJHyc/+4kaTY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-0BVictwdNHGK5B6UNAr6Ww-1; Wed,
 04 Feb 2026 05:31:44 -0500
X-MC-Unique: 0BVictwdNHGK5B6UNAr6Ww-1
X-Mimecast-MFC-AGG-ID: 0BVictwdNHGK5B6UNAr6Ww_1770201103
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF7A195605A; Wed,  4 Feb 2026 10:31:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CBC218004AD; Wed,  4 Feb 2026 10:31:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 01/45] pc-bios: Update vbootrom image to commit 1c8e9510b22c
Date: Wed,  4 Feb 2026 11:30:52 +0100
Message-ID: <20260204103136.1795455-2-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FUZZY_SPRM=0.01 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Full changelog since last update (183c9ff8056b) :

Joe Komlodi (1):
    npcm8xx: Fix u-boot copy size

Jamin Lin (3):
    ast27x0: refactor FIT boot loader into fmc_image.c for future Caliptra Manifest support
    ast27x0: Add Caliptra Manifest boot support and MCU runtime loader framework
    ast27x0: Fix compilation issues on Ubuntu 22.04

Compiled with gcc version 13.3.0

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
---
 pc-bios/ast27x0_bootrom.bin | Bin 16408 -> 28564 bytes
 pc-bios/npcm7xx_bootrom.bin | Bin 672 -> 736 bytes
 pc-bios/npcm8xx_bootrom.bin | Bin 672 -> 672 bytes
 roms/vbootrom               |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
index a4c94d64da55ade9b4beb2a409132f315fb51347..626499b117c72ea59d906c60655780d91229616e 100644
GIT binary patch
literal 28564
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
E14Sx{n*aa+

delta 4114
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
DBJm?y

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 92282892b70dbcd6828c5054dff33ffe3385c485..60e5517eedfd6b35095bfb8d18181f561bafe556 100644
GIT binary patch
delta 287
zcmYL?Jxjw-7==%6(kd}S3J#75I4WN752V_mTZ<py;Nals=-?pq8XO#4s-3+T+?-q;
zO7j=QrF2Sic|n`S$)%K6s-OoB&u|_%rk2;9Z=7BOs3dO{6Xq!}XMi~q%#kzyDWtJs
zviad=Y3?RT4jfxIZ|0#Ij*&f(CwEI^*Yw3aU6IDl)_?sAnUZK4i)cWXQj?3l!U6nq
zXc{qBUNoRHse6CJDKxz>S0_?aAm0esw{^f5v9YsNW0&JQLUcu~NRzv5ilfCr!`Q^>
z6VSCD;J4yFiH)>;Wv)b^%1{m8*Pv;^?$Y7YtzbUrbaoyEGaM*{b@d4Wb>9~4AjW^b
E0jKYKB>(^b

delta 209
zcmaFBx`1^<2V*@C1H*5F|N0Ma{r~@pf#L6e28RFt8<_t8S77`L#tg~@TdznQlVZ?W
z_?nrO;ZDI`oeUOhlY}qNxt0AtR67Z5ot*Cffx$&7L(F@Y6Y~X0j|!Ln-zU6J$`A(g
z#lZZI_X6J1)!rNZKQK7?f2el6^n*i@D}l#rwj<-@RR0eQju(G8Fgk3!_`^k!=_^Cg
z|L;fsGkj$z5ZKG=@#i_i{s8vSRU!WVP7I6;4GaPe9~hVz8nPG|7z!B}7$)~Hc}%{*
GBme+2%vQGm

diff --git a/pc-bios/npcm8xx_bootrom.bin b/pc-bios/npcm8xx_bootrom.bin
index 45fb40fb5987ab681cc902659d85e76a7385cb53..4b6f82f38d61750c49f2eba61fb3f77dbcb179f4 100644
GIT binary patch
delta 99
zcmV-p0G$7z1)v46-~mCw0RU7a07AK+00V1b0RU9}d%vmu0|1dF_(8cM{6V?k0|hEV
z00<G@|Noc$d%>un00<Gl17Fr500fag008U3lN|ydlRyGA4U7N)002}D5S;>^0Y{U8
F0v|xlB4+>q

delta 98
zcmV-o0G<D!1)v46-~m0M0RU7a07AK+00V150RU9}d%vmu0|1dC{6V=T_(8eg0|hGI
z|Noc$d%>un00<Gl17Fr500fag008UZlOX~hkzfRqKms%khyVZp08|bTodTW#Mw5X8
EA4gjv-2eap

diff --git a/roms/vbootrom b/roms/vbootrom
index 183c9ff8056b..1c8e9510b22c 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 183c9ff8056b7946db1ae49cc23e8980ac413174
+Subproject commit 1c8e9510b22c5b0fd7d7753f08042a4bcbd2939d
-- 
2.52.0


