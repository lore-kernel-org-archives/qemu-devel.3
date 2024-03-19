Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4368C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBc-0005W9-8X; Tue, 19 Mar 2024 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBa-0005Ur-FX
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:34 -0400
Received: from cockroach.apple.relay.mailchannels.net ([23.83.208.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBY-00049S-8I
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:34 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 80EBB143682
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:29 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id A9F8014377E
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:28 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865169; a=rsa-sha256;
 cv=pass;
 b=WbBku9TB+3Eaq8VxsJqj8wR6zjUZRBvXQtMfSVk1OoM8dq+QJ/kfgIDLLCcaX6qbG1rm15
 yi3ILUT8wD8arqgZV1jx0H/8V10nVWL+QfJcOwnVvoX8P6Jn+dFQM+gXCbvNAtK0U4UGs5
 mZK9MU9IJMt9TEwwkEH5P/I27L73L4ejTnzgAhLwoswE6S86jvTLhG2OqCAW+yNq+y6fPD
 e8bSCqz7efji2HjX7f8HnpLgYiDZ6kKPQauRE5//+tU9jsRKr+8ebQy7u8RtNAKdTL1LtW
 1+OdNp1I9izKmJFWP/NFMys+ZQAHWHaeVPji1SLDah7Lxh6fvYej1BulJTGvbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=B06SV1wbypmp+DquTUTmW8+G5JiS8jXqtvpB1DDgEh4=;
 b=CdGYIKaBERvjL9wTZtdNGFw9akhH70fECiDs8SXaJ9GCAHbubQu4Zx5vSCjz1GahRgTubv
 Jngqvb36PPYkpRp4R0JWqOfhcoOyaVPZa4vQDtX9Y6RY4B/OXcL9MBSdB8y8FNRmMdH5sS
 gAt50TgSnQgBaTa4Wem7DHv/FeTB5v2v0r/AZirKssIlEiB6yTbQ8kxm0EQsGGJuH3c2in
 lKHddhot1gKrl+AydXRaDPrsj5qBoD4pgh3cWawE6AYxxPb8uUH3dhQTfI77QjbvRoncYk
 t1O11S4OHyjjNZ1sE4oGX6yIn88Ke2jXjFeE4hOkO2SodLBQ4dgvQYmp+h2l+Q==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-lgx7d;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Befitting-Tangy: 44b52cf309e5c235_1710865169241_4005851963
X-MC-Loop-Signature: 1710865169241:4104094198
X-MC-Ingress-Time: 1710865169241
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Tue, 19 Mar 2024 16:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865134; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=SvGA66XA8QYTn29+xEDe5B+cIp+VZCfg6NUU4NLzcqG3hyP7r/GrZuArqyPTTq6syJXF/JzSavu5v
 qoXf/XrKdgpmi10IXQ4chPnTNYIb8wRi9wVIyKxw66HG4IZIIqn/j4yKpsj6yYRsJY3HBqPiio+1rI
 hLUW3A2QOe5PiFB0ZNqIAUZgQq3B+xn5iRARslKEwDdWVXSZxkmn3WxjGWEgV4bExh1xvBUcjTDpIC
 5P3nB9couJLd0nHYqDgsIbKwOGRBTiB4N4fwM4/v4SZl/3pE7l60/67xxBfGiyZX1s+WsEBvemkgKT
 bSl3t/sGkma8JQAPWoLwJiRIfPnTGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=B06SV1wbypmp+DquTUTmW8+G5JiS8jXqtvpB1DDgEh4=;
 b=YvRPhBjT7J0yTZ+TmfyfxfEGDq5aY3Ckqy4pK56eCTfYc0WCutGa2VPLOQ85T6kFoT+gekRHZsCK8
 bQHHt5fTRNFao9GEcGmRvrPsYFAzm88PH9W2RuiOv5TQ/PkC0W9Ud4v1jnOUoA0soO9vEpxhr4Tr1I
 zLY7KmgXSkvr55Xq2xvgihp+POgniIok8IPsW7NfzcEz0GaIGHvChdYfsXtZX4tyie6rU2EZrtFpKi
 UWKNT9SW2hifMWk8Pu2EjmCQ+4fVOY6vb8EZJ3vyA/Dqnz+vn1b9/J2JLsXWVqCaNkkR4P2FpW9bpr
 g9pivnVVqEmVdtJ4VSpJO/CaeiK9jWA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=dBbG1Z8I; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=B06SV1wbypmp+DquTUTmW8+G5JiS8jXqtvpB1DDgEh4=;
 b=UVY56rvN6S2ElsIPlWM+AE7IMuQ22EZGsHZDgrGdsukPE/0p9CgDJL64iDnrFhnuXZv++LQU1j7pM
 7vI9Sfh7lawN95SS/uOCDRmxOKx5klz+h8ALA9MQ0dxWMg+CmJ0k8zeWQHFHz5tjNiH8yobKZahHiI
 JdGz9Bem9onu40bE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=B06SV1wbypmp+DquTUTmW8+G5JiS8jXqtvpB1DDgEh4=;
 b=rEsTYIFWVtRGkLCdDqJCoxbaNW0YdihOXIXxHZy1SlWsDbJGIlSyGZlGStMe7p+23pk1QHfC+cBA/
 Db97BSiGsgK2X832Qvm5EHocez5GqI/ksuiw0hkmNEFvSXkmuUo0RloOA4J5LhiJPPvqbidOH+1xUq
 zrU1J4hi8mxih/sJrnNkq3AgX36T7e431Q5Etzy0UsVb3oRJeB9fiKpGny4QajNPujahy5F1WZDB7v
 XKzGCLgXbLOLDBtN4WcsNwU1/GJhjCot/F1hJTCFN9rothMxic5jwlpbk3g3dMp9CbyWQrO/dKsd2H
 WfUOAw9BU6LAGeJF2hEGyZSA8+ndF3Q==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 5f78f6e7-e60c-11ee-b1e6-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 5f78f6e7-e60c-11ee-b1e6-eda7e384987e;
 Tue, 19 Mar 2024 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B06SV1wbypmp+DquTUTmW8+G5JiS8jXqtvpB1DDgEh4=; b=dBbG1Z8IgviwAGk1x9kpuHdSPy
 X5L9am1lZCcSTXtj5BFkOB23bIEnaJQFL6dVRpi9ykK6PtmWcmcFB9996jHf8O/Ox9vSA7p5wNTFv
 c5YYzELPewbNC6X1hnzZgCs95XPmZ5yghVUk/XbpNP1cCRdBOddLmYeR5vasTi6XYzbIHmen+NdUM
 HCG/FGfeiEgG6712zRumA1BVzZmxWnirG+5DrSYq83B/jp3Oe/iDOztxTbxEUWlcGEbDaQZouikye
 dwz1fIF8UIvTV2kriYVeo5yWsjLT9dUzkmXupnwBs3GuRnDO2R5qBKhV5puZTOkx7n8ZjeoRBujVo
 g5PppLhQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBQ-004VVI-0X;
 Tue, 19 Mar 2024 17:19:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 2/6] target/hppa: fix shrp for wide mode
Date: Tue, 19 Mar 2024 17:19:17 +0100
Message-ID: <20240319161921.487080-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319161921.487080-1-svens@stackframe.org>
References: <20240319161921.487080-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.208.37; envelope-from=svens@stackframe.org;
 helo=cockroach.apple.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fixes: f7b775a9c075 ("target/hppa: Implement SHRPD")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
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


