Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFECC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAIf-0004bL-NH; Wed, 12 Aug 2026 10:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIH-0004Pw-2f; Wed, 12 Aug 2026 10:51:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIC-0006fg-GK; Wed, 12 Aug 2026 10:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=zT6lFfPOxPW+Ur9kQzPZpITJlg6x6e4dgHgTWaCwv+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CsdcoTCxBaQfTG2NHj9UIAxihBOWONZmH0fJTrudh1vxw3CAxJKf+3SJGADgZy7NL
 h6HqmOJ2hJ62H46942q9LiaG7v0SpasJMipgZfnoDvGpfFx1SZr2Pv8JYcitGMIQl9
 +I48LpOMGoh0x5WubT7v9xi9LRV8MnEWw6CZrBSl2G7oysB0O4Jhzhlz8y9zoa5xrv
 UxM9cUcDKi5C0FLzkguKkkQp927D78zI4Lc3JGG6GYaiJzleS6u2G/KvXPocc5Edhq
 i1Dj9y8ydaQRNeVNzGu0yAapTPskIuI1VBz8zjOJYTPOFa3uIUmq5AtdMipSSsGmfs
 KzIMO6Nunbv9Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8F031CA607;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1EC86409D40;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7B7752F969; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 003/120] hw/uefi: check lower limit for signature list
 size
Date: Wed, 12 Aug 2026 17:47:46 +0300
Message-ID: <20260812144955.649205-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Specifically disallow zero which can lead to an endless loop.

Fixes: CVE-2026-61406
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3899
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-4-kraxel@redhat.com>
(cherry picked from commit 647ba95eda5a21518f84c6593ed97e0447f38a90)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-siglist.c b/hw/uefi/var-service-siglist.c
index 8948f1b7847..9e03a4dc0c2 100644
--- a/hw/uefi/var-service-siglist.c
+++ b/hw/uefi/var-service-siglist.c
@@ -94,6 +94,9 @@ void uefi_vars_siglist_parse(uefi_vars_siglist *siglist,
             break;
         }
         efilist = data;
+        if (efilist->siglist_size < sizeof(*efilist)) {
+            break;
+        }
         if (size < efilist->siglist_size) {
             break;
         }
-- 
2.47.3


