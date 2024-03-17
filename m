Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C4DC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlyml-0003hs-Fz; Sun, 17 Mar 2024 18:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymW-0003ei-AV
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:15:05 -0400
Received: from bee.elm.relay.mailchannels.net ([23.83.212.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymG-0005lQ-R2
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:15:00 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id F31B92C2B38
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:46 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 587B72C2A9F
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:46 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713686; a=rsa-sha256;
 cv=pass;
 b=SdOQe0BK2GCO6NMeFQARqZKZoxmEhJfBDMl4oRhE4WRrlRtmzU5GQ6EWQ+TzpZjqTREKbe
 csLgz2sSy01UR0xxBfrXX6P9TkCCC0AaubMnZlg9VXlFdJwnZpm6/DufewaQOyvxmWk6U6
 VlyMXU5SoL6/9qu+QFc5qvQfyjMPuVvJ1oC9byQgpHEu5fRrB8rxqPBunNNiVTQVXnCEjp
 F4WVsoi+vDRjvCia+B5/yDK8yvy/XZxqLoDUp/a+jTCQZzZ9ixnV5rHdUGmwelmymwi/yM
 QG1N4GQJlURAsyrQjLQbYw79iXVjcIhY5qLa5TSTVq2xaZxJ4IrO+LxQnTupuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+lH6+GK+Ys5CVbB/17/8LFUsWDuUB6jySmdupLQ/9Wo=;
 b=uGauR9kLZi6oqLZIs1Bmjkks6nhOTXUoJTPYe3LEvSA/XpHGqbP9bFSKQux+KAm1ssDEbt
 HuA8nbFXO/qUNvheufU2YzT3AsTSjVdYipEPIb4xVihCc2XLMIatDG1/HqArTD0ivpYE0n
 Oeg+/wvWwnKVKJ4WQXLttUUGKLj0Fg0+0HchPqEakIbDKdiLN2/k6BW4bSRpsW/8jSElkY
 CvldzsAl8AC+OvyjB9EOH9ZMoWDjGWvvj1dLBkJemmeyngOGAts0/gEAXVaIIBsji+48dV
 vSR9BBWuZ4WFjr0or7S1W87hj4b1BOGMUkIr3kvViCK9klgBbVri/CksACpO6Q==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-2qlcp;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Ruddy-Print: 3fc5bb9255e65364_1710713686855_2028950366
X-MC-Loop-Signature: 1710713686855:3439411052
X-MC-Ingress-Time: 1710713686855
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.122.162.95 (trex/6.9.2); Sun, 17 Mar 2024 22:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713649; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=lA2uyPhwjVgENehJ2HhPO1ZAe8fE7mLDpc4e4BuM01L/HFP2r0VoF+nGflBGqZzEnd0FZixl1IgKt
 hvIAv+YrAxXBXVmnJF0fJcAx/B3dz6GVBd5cgUwb5U7i8c1Yu7IqQK0QraHiAz4M+1AG5uGbLEMEZI
 +qH93JbvyFzAOwEj4Nyi3w65u18RKKVUHpeR9tUBt5zxLuthCla5QZucM9sm8Ru8lmoRtQj7jhkjGl
 0oUHf3iLMwR1O6itwXOh3A+cj9NJ0zoXPacJIEYsNeYBDxfYR0wyFloUTIKANTF4jnVjsixFpSZaq+
 ZD5utuC71F9/T8FblOecDPfk0+VcFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=+lH6+GK+Ys5CVbB/17/8LFUsWDuUB6jySmdupLQ/9Wo=;
 b=O0vw34Wf6GqylLQwAHJ1c0qWLqDiNOlUh38bMNZ7hhNyOyVbldea13Ngbwc4pLzRk8Ljz7gvgTa5Q
 T/Pt2v9yP1uuba6kvxhahhOnyDYfWSgXzbreRJLdse4qpLY4T34LN1/gZ1orOWJ55E9ORUjfFwB0NP
 V3iY4ZXQJMXsqsBsV3sYzq/6s6ehNF3ifb1fRhrHKFtoHzEdwijLQyitrRQ87+YsPKkfp4nxlu+nPa
 xehQOQcdUsP3IrSyr7D2mFionEH5MHUDadGmG7mc4rQR8f15Kp75KeMlIYOeLc85h8ktib2T7JKpM9
 Q1GRZjFk/AKOlRSAXJSJ2YSnoIVxgew==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Nok1zDPs; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+lH6+GK+Ys5CVbB/17/8LFUsWDuUB6jySmdupLQ/9Wo=;
 b=crASQZzmUSIyOlOFoQDVfQuP7ed+OBeNdV/rfn4AFinUUZrMXNkXYLQ1XCcRIDEWRpkzaxd0r6S5d
 wK6xRBoAjgdaf7EkGedlPkm4k4npP0P/W4qBNMa09CyCiJRMJsNzjg3fv/3FjjtkBMCjr0hi2WlMe8
 Y7hItYmke6Lf33mw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+lH6+GK+Ys5CVbB/17/8LFUsWDuUB6jySmdupLQ/9Wo=;
 b=q7/uN2MvSJw0IebJBdqjuvvdMXuJ8MxVF4Aykmx67pE/gkDZRVKwXWr9bITdYPmoinoxlmllCYESz
 R11e0nHKaDvsOCg/DCcB6pyx6kwEuaSlzvpXwLbviiO0ZgO+b/Y9OL11C2osO7rhShjgPxIiMIKgoP
 kMhRqGE4faRfoZ4Sfe6x+mkvSF3u7Fpwt/yPME8AQuqlyfB3plMvNeYvVf6UElW04qSzb9p2XUEk5n
 NTqctHl3EdVoi/iRPWtE2CrOQJ4P2gKZ58o1j7ZfxLMNh2XbeeXZjyEPbDQg0bx7rUGrmX+fM9ZI6W
 2Ct2mazLSCdtOqZYGdy27oeVa5ze05g==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: abb9060d-e4ab-11ee-b1ba-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id abb9060d-e4ab-11ee-b1ba-eda7e384987e;
 Sun, 17 Mar 2024 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+lH6+GK+Ys5CVbB/17/8LFUsWDuUB6jySmdupLQ/9Wo=; b=Nok1zDPs3K9q5kVpd9EnfOiGnn
 n7j+vdAucdOw3/p6SXX7/egim1VBOd9zevuicxS0c2GIsoXhttsx8zb91S0hF9wGFXmq/OxaN49X3
 XA+xuJwI7XExr3FuMcwqU1Ie5fziHIZcfEPvXY9jjX9s1UBp+89JQ66N627XuvKoQqVH1ptEqxbwL
 grAOirndgmdboB5Vsf5O4R+6uDoJhl/X7b15k6iZ0ih4t2MGERls3KDfqzm4a/GEtC1/1Q+EDzK+M
 avg7ikYjip1JX2+Uc29gqsTL+AlPedQAVgPiXO/g627IyeMgNWjeHXKPuplHChmI+GxJO3qIrAesi
 Hg9uNKCg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym6-004C3C-2H;
 Sun, 17 Mar 2024 23:14:38 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 6/7] target/hppa: mask privilege bits in mfia
Date: Sun, 17 Mar 2024 23:14:30 +0100
Message-ID: <20240317221431.251515-7-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.212.14; envelope-from=svens@stackframe.org;
 helo=bee.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

mfia should return only the iaoq bits without privilege
bits.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a09112e4ae..e47f8f9f47 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1962,7 +1962,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
     unsigned rt = a->t;
     TCGv_i64 tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
+    tcg_gen_movi_i64(tmp, ctx->iaoq_f & ~3ULL);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-- 
2.43.2


