Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61103C54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymW-0003eJ-6E; Sun, 17 Mar 2024 18:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymK-0003cH-1C
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:52 -0400
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymF-0005jS-O9
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:51 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7CFB581905
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:42 +0000 (UTC)
Received: from outbound2.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id D6E348192D
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:41 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713682; a=rsa-sha256;
 cv=pass;
 b=AsuGSnZWfYHvuOC3u3X2YyxO1L6X5juk0f9Dn19cOTg92QpDuEKsd+wnVit3a3cR6Dnqza
 i0P/n+4F/uOZOyNI1nZhmT+EDZ+1/9t8IEkJO/p6BO1+XKio7n4Zdnpboad8h80gFkhwtW
 NB3xtu9vqZ9OjPmS7Ct9saM035AIRPxw5fC7Myz2Y0pTaO/Nj7ylK3u6IhMSDRJH128rKL
 ssJ3Ht+FGqBIaGn6fdY9q1B99BvHrDasJBdowYuS4Ff9Mq5BGPkhwVx3Tpzm2H4v5dN/37
 iWmvbyJWV/CLh7UHzyfcbz9RPlmkNH8sPSprMJYYOgsxOtVjREKr0RTjW0NEkA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=4Chx7VPAxEfKw1KFEIm2lqz2aDxSAD2i+QEL79EEIyA=;
 b=Hg6s+dle9+6YkcpJ+iHSGzQPY1ohbeAj2bOj9PV5E8Hymvev2FjWmWH/a8I0fEWRLF8sMc
 KP2azFVI/3vqydDmqBUBva4EzMWblImFWbWTTK0cMeE4xTDbPlxGaKdgeKtR91Xbu5S0gG
 TCRhKHdX1q3xKGXJaoJZ7JKsy0H/hZhbN/UUtzUAPFot0zsr+EvvzmsGcJoL0yRMVcFp1K
 SdKi97TV9dxwEcNZ/+9Zxii2dHA9ipFdlUrn7/VDyOdVaxScU1atWybMlvSx0U++BvBJiJ
 HF9snTON9tLl4ZryuBNq3/yWd4dBpLpT4bRHb1M1egDw8fkRDI/96ox5n7eo1w==
ARC-Authentication-Results: i=2; rspamd-b46fcdc5-wwhzp;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Desert-Scare: 4bf13e264cc9a68d_1710713682392_107567192
X-MC-Loop-Signature: 1710713682392:821115059
X-MC-Ingress-Time: 1710713682392
Received: from outbound2.eu.mailhop.org (outbound2.eu.mailhop.org
 [35.157.29.171]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.189.199 (trex/6.9.2); Sun, 17 Mar 2024 22:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713571; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=YP/wiqj7dmY05STGG5fgY/jhM26W9MReYL0+u3XRwbYGuACfh4eQUUbfEtFP1fcibPD9fnoAPJr3T
 hQCtTMKQj6mhKH41n1hCYICeJTJUYkuMfdKqT+HmtWmOINLOZqA0JjKv/SgFaeAZ+hXP/e8PotYrEj
 XBe7QSSiPMpI1ymS1+WrxVKEQBg0VaEUNw337c+eU9F+kJdN95IHYE8o45PyvpvncYHe0dYc9ZJ2vq
 EfAmY4zHXRSpichw81DBO6XT7UbNlSC9+3KHNfcPL3xn8dVbbtd0LgR8MphuanbWAI9v9cL7FNyFqo
 BtwuCCYgOauWUHJ9mYlkeThsOxJr5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=4Chx7VPAxEfKw1KFEIm2lqz2aDxSAD2i+QEL79EEIyA=;
 b=OG7k/EA0jNm8ILBjWRg3m/rbUHFqspiHs/SlYIkYoXKO4ykVHKRh1RBhuREPPKnfUpigz3yofp5zt
 Sdd0v9UFRmPd5JcjRWXEBN51rP2nBNT1wh0Nv941EALlxbJ5RNXwJ6iIPv2+ud45E1F9W6e7QLobAn
 spZhtSw1ZSNa7418kNBqLfPe/+V6pqANbQ+6QLaM4cwArFZnkiKLGMIE+ayVhDCNFO87k7y9aRkzhB
 cxikmUxTmElUJLCIGPbN+frQOMXcTkAg8FgyQGXWOTj9Bcus6WKTFo7rfnBljVAt0D2dlnIMUNJw2u
 r5TDQkHI2uj8AgRZ7v7oKnnx5OQ95bQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=JZTtNuAP; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=4Chx7VPAxEfKw1KFEIm2lqz2aDxSAD2i+QEL79EEIyA=;
 b=d/U0sV7dJsCXC1uquKSvYyzj6JkoXrMe6xUIv2EZTVMbmkTThGVIbD7bl6bCG3nWD9vnb/ldXD4uC
 J+Oa7uFHrZI4CHiEUvTreIf/zFvQUOc9vju+Qm4PjKxba/IKwiJd6aP490hicefy8OiN0YYoR8ylwI
 bMAyP8fkpU5jG0pM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=4Chx7VPAxEfKw1KFEIm2lqz2aDxSAD2i+QEL79EEIyA=;
 b=CVGdAQaMy3SvzVe/YY3Wj+f6OPQt3YUWzdfySx3TpWqEgzFuEWYSORVoG15tueEhxh2dHdw62px+I
 Xf2t962qoEolE8PNh78PuANdOz4B4gSdGKQRIGnO2kRhU9YH69F/10OixqQLQnJPefTA5vq9bQ18Fo
 20G8QLjUWXhPjPAI7bb26LLEECUg706jLrB/FHIzUY2EMenKwCZxJ1pMWOofKLjJvPV+Q8Ntr60tk7
 91o4VNGm/TkDlH/tTcr1PQYGN0xk91bMXI8UGJIgBURvl80Doyw1VaUtI8cqNoLNjMoPhbM05t9lIs
 aPgkrfPrLM4FEbYmsVcAehpornL24tA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 7cfc0b2a-e4ab-11ee-b7ba-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 7cfc0b2a-e4ab-11ee-b7ba-9b9d9be6ef2c;
 Sun, 17 Mar 2024 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Chx7VPAxEfKw1KFEIm2lqz2aDxSAD2i+QEL79EEIyA=; b=JZTtNuAPLN8yFRhIvUdK7Fqhy1
 dMjMomX+3sLxNLQbnOpbXC5C6htHGfjwF/nsCFgrwsnYZmdhXqS3fKZ5hDzik4XgHKLtQDgPiKJJ5
 jI6SmnM9B5Rlh4eGbz6dOB4Nbx0xm8th30rzFjSLxdbYslcm1En+/Men6TYc4vrGkLjl39t2EM26J
 tu1YUHOmbFN9gzwOZYO/R29FinHHYpDARZNjjpx/kMJCP+3ABbyrpSkV/UomTQ06RFSy/umF8L+h7
 K1RKuVz+MXG6PlTNBAO3P5eD6F3BzU0VeBWqzyOeT2Hv/FwtMrLjyJMyuogxuPs1lr7BE1pGBYROR
 KL6NS8xw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym5-004C3C-15;
 Sun, 17 Mar 2024 23:14:37 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/7] target/hppa: fix shrp for wide mode
Date: Sun, 17 Mar 2024 23:14:26 +0100
Message-ID: <20240317221431.251515-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6a513d7d5c..8ba31567e8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3462,7 +3462,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
@@ -3505,7 +3505,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
-- 
2.43.2


