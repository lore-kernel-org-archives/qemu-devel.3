Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CE4C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcQH-0004cX-Fh; Thu, 27 Aug 2026 11:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQB-0004a0-Dc; Thu, 27 Aug 2026 11:53:43 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQ9-0003ss-Nn; Thu, 27 Aug 2026 11:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=a4QW4FF
 wFPBKold22TrKrJqlDGXxFldUetiN2dTYjDg6XW1+df84fOK78MZl/m7XGPktePSk0hAZP
 YSlriXehMG+pIQXSds0SJa1kqAVAzawRjUGkU+tuhIiZJxGfRYhnISMAL4HN4KGTfMrOdI
 X14a676hQb93Pw23rqRUbiuZlFrdS+cszvm4WrlUIfyKBEMo1QvWnSVbSNfTo+t9aG35FA
 sRTOI+NLWfKB6+WQI0w/mkOGVgXUBM0bDm2D2Xy4NSgFzVnBC1+5yTnfbwh1eop5ZftTk1
 JNY3ZZkVBf/96GrcwRkkPWD+op/a6TcyGyhjkk6EsOof/zaYEKefL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=L
 38mssKJShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=uwS/WGG0pnLu0VPYYF51UOYEkpsmsNAPeTSVxPfZg4la7FqjFpdmOiVe0ZYPAgmwFSN7
 Oyrh+txzdRCHdA+GY3ya6fguBsGEkqKWhmw8zvyr8XGMaHHF1aVAxF0KKZIJkcK/8UNvTH
 Bm9cLGVNTPCnCX2HszwwxIodB+jsscDwcmuQlFsrYla1BmMhKZ2vovm9aEtNZUh9mgUyC9
 Vvw7cfe9UTcpcjZa9EsTtsensJ06z0hG/8yk3rnUTr205ocuEHdpLt+XCwhs20nSxU4PVC
 /dBp/lrnRNxmDQXmH+G9DsV0siVEQK91kepFCn79NSzg1IVRXXRC3p6dN+cpOUiA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=KBGroQ6w; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=94NRxHMy;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=L38mssKJ
 ShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=KBGroQ6wBl0HcuOp/lSc9Ko+8T/OliUDh02
 N4KcmE6VgaFJar9yPrLOPSfRw/RlEj62TLGtDwg8EaHzsMeZD+9lNvulA+auHJqBI+rEqw
 J2svsv/OKIwbBVceREqTvbgakgpESgmndYHYltF9+n618QCQrdmEHaLIsgZeUxM+oJ51gh
 LjJ86H9Uc7+j1TWAaiF+FXmVvscZAvvm6npaWbLEo3vlYkiedQaHedm/DcoQ+UkivKE+mB
 e3pt+giIFvRLSVbcOl6s3xbPCfyU/lZdGT8PIJFQWnVdpYIRhVedhm31LC7nP0EJVI3LwF
 wOt4WWpWMxJs5fzBqOmjrpIuOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=L38mssKJShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=94NRxHMy4lZHPiPQdz
 rwi6v/jDU/VDjIi/MVNrFeyDil1wI+MjNi8Ss/pHJSPCKTy6fQv+5AxQArdywE1rcuCQ==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 74f80001
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:53:35 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 6406bfac;
 Thu, 27 Aug 2026 17:53:33 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v1 2/5] ppc: Raise decrementer IRQ on zero write
Date: Thu, 27 Aug 2026 17:50:35 +0200
Message-ID: <20260827155310.7223-3-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827155310.7223-1-kirill@korins.ky>
References: <20260827155310.7223-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD writes zero to an edge triggered decrementer, then enters idle
expecting its interrupt. QEMU defers the already due edge to a timer at
the current virtual time, leaving the guest stalled.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/ppc/ppc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1c..d99e47d532 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
-- 
2.55.0


