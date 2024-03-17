Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085AEC54E72
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymY-0003eo-7m; Sun, 17 Mar 2024 18:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymK-0003cc-I5
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:56 -0400
Received: from kudu.cherry.relay.mailchannels.net ([23.83.223.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymF-0005jV-M5
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:52 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 031B47A26D3
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:43 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5BB257A25BE
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:42 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713682; a=rsa-sha256;
 cv=pass;
 b=bys+K8/cIL6lKimpDTbYoj7+F5sdFwHrbhC+NC5dqJ12q+5L7ec+bnRCr4Qc9kyt2FBEBa
 K4vUNYFSn8oYAzCCiE9IV75F8vk+yNoY8ei7XdN8lsFUz9rL3mEBKFu5wxzK3aPE8e41OJ
 NRBrfQ+FAS19xWg75VS9RjYOt5hV87vWDCEGHIM3IoW2GCYrVTjaoLCmBw+WZN2FssdJZZ
 R91XEYX/Us4zHm/sKgsRvYKx1dTZf8PMArRmkZp76VIOwsF4S3vvPETaF1/3If0BmNXqMo
 9ZsHrCLDRHgMoXiHFitm3nrckNuPCA4G+jAtW8K2OnjwbEFnuXLx7XClK3KAhA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=XIaZGXOlzOcFaNSLv1z7QHkqmwxhFrui26Dl781DBp0=;
 b=BKj/Pu0XvZPMbyW76MG46hEzZ82HbdYgQPbdG8zIncYVky7EdDIOVVhkZOJ1XSZKeNMqwX
 EY+97gYBdra1zCXIlvGnYsu32f+0j51a8MG+QyAQjkqLqbWYjF7yDx/CbOI1oSGRoN6iuw
 jnvFDViYRhCUQ9IYTt+LttulW6fIz9YKA3ipUjQW/c08Tkwz25CsLfJie9IvWttQtp9PJ3
 hRFBNAvW+DaDc+4x5Xzjln59LGbvr1s0sU2LnLR/CFpLs26UG/ZdacANsYMtmKdnTIFOZm
 ulHiMDmzEh/U8bNc1EFkSgAlCUcY58IcmJSfynmRj6l59Osl5AbgZcqwXOU56w==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-p48d7;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Troubled-Absorbed: 4ab606dc27b57978_1710713682875_515434682
X-MC-Loop-Signature: 1710713682875:4021988264
X-MC-Ingress-Time: 1710713682875
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.164.55 (trex/6.9.2); Sun, 17 Mar 2024 22:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713648; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=OMSyAlxoMekr+VGC0hFHEF5JzrD04fwPMaFcnp/1eaIkAb9tcLovyaiEbTSLxLBlT//oiUDyb7NvD
 VzXjZWt5HjVx5f25j4vK7TnGR6UJ9kZIrsPEqNbNOfoijulUksivrl48TbwuPQLlsrH2exqgy12xn8
 3ofxNJo3V7d46B8bG3rM/+gddMQfUJJAG5fQuP8U/I2oNk0IYxZ9NHgGK/QIOH/9eSHIec6JwdEI5T
 cwiO+1V14ySYL3ecJEvw08lG5/1h6GRiyfFl29DYEPCP5tdNw1QCxxI5DT8raoY2oDUKli4p+RhKQR
 HmGirHZw6lBA9M0kLD5dBp2f9RjHvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=XIaZGXOlzOcFaNSLv1z7QHkqmwxhFrui26Dl781DBp0=;
 b=d3cnsjAbBZk+M2Fea+x+FrfgmknIcDkaFQp2WJSuLQScAEk91OdaSxGkbdNFXEqmSxpzRB3Cl0lZp
 xbk3T4L+dX+07tmOS2wIIVVvkH9+ekB2OyXfuP8G5dDDLMRGzf/N821LDMGDZeEA2ROqWfaxVtrXwN
 C7pOJRjHV26x5mR13vY182fxKvAQCo7BMGpV2Ei1RPHtkz/hu4YxMlYaAS7C5lgbtuRujNyDP+KAal
 9YhiX15B4Yin8d0wwVY9F/YvxI9b3XWk7DFFZp9/jawI7y5mZV4DaCt1KbEFLYL7y1Muz+HLbWLnLt
 LrNFVKuMV7ajR5XyTEw6a6Y9xZVCs0A==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=HvghZ8zc; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=XIaZGXOlzOcFaNSLv1z7QHkqmwxhFrui26Dl781DBp0=;
 b=ocy48Vb2QzffA6up4as507TOLZbgjxX4SUwO5BuSFUv3o02pWQW4hnUaTt6cYPoE7IkxeufVNbOLE
 IrxaWlY0oAbjtXOARTx4abXhrz3l5RX4VA5pAPTjAmINukMmp0olfgWedSaiwTIQHDUBBC1NmrRKL8
 lGEmYtMejzViivac=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=XIaZGXOlzOcFaNSLv1z7QHkqmwxhFrui26Dl781DBp0=;
 b=V2e3XTGsOBN6moGA62Gr2DY89bQSjACwrC/aPS+i7ZoNSTflTYwkQcNjK13gzn9EqrUq0gH2seDyj
 7UY5JR8UhBHB64WhqgGk+Sia15WUr0Mo9x7ohBc7W27H/3HRKnplGehAUhzIlhkpMMdKZBgRGdPmGC
 0w+DJZfRP7j0WtRMxF4RKsn/ymQ7GHuM1ZrpaVNcuNAb6U0T1fAz+R8wh4dylcDZ2PGr2d40SohgWE
 i4mYke4UiDf9r9zfJ1qVuP2tpC40EP3etGhGubxt043reLSFvSFjB/2P+wockhV4+hPhxFRf4iFF3k
 Vsn46NMVE8lrZ0r5bAFpM8DDXiRgw/A==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: ab3de6b9-e4ab-11ee-b1ba-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id ab3de6b9-e4ab-11ee-b1ba-eda7e384987e;
 Sun, 17 Mar 2024 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XIaZGXOlzOcFaNSLv1z7QHkqmwxhFrui26Dl781DBp0=; b=HvghZ8zcwVBm04xeR2HwkcZqtY
 PEF5vVtSrtXpsRXlc/0i/jR0ilH9U9W6G5JvehfefP85oHgMhqx/JFKX4l0I2UYziJ2xw2BQv75OJ
 mKmKQVzUPhCPc0sG+Dlygw+IJ9pZMPMyO5b/gOf1WAhXLhWLrKI53JksDyEsrb7X18DrFs6exXwlK
 9+fLH2kHfiII6FwNxbHmXSDcttEQMphFvD95FoHB7B1KIMAXg/vyyaT5OcmsSbzWRaxMx5HoytIGq
 ExvEJbfW+mQph5BXWTyJXvNHNHbYCFEgs2DynEqS2ezeRqSV9xPjJpJ5YHzi301XIxLseZs35OoqR
 99DR2EHA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym5-004C3C-3D;
 Sun, 17 Mar 2024 23:14:38 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 4/7] target/hppa: exit tb on flush cache instructions
Date: Sun, 17 Mar 2024 23:14:28 +0100
Message-ID: <20240317221431.251515-5-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.97; envelope-from=svens@stackframe.org;
 helo=kudu.cherry.relay.mailchannels.net
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

When the guest modifies the tb it is currently executing from,
it executes a fic instruction. Exit the tb on such instruction,
otherwise we might execute stale code.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8ba31567e8..58d7ec1ade 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1940,6 +1940,7 @@ static void do_page_zero(DisasContext *ctx)
 static bool trans_nop(DisasContext *ctx, arg_nop *a)
 {
     cond_free(&ctx->null_cond);
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     return true;
 }
 
@@ -2290,6 +2291,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
         save_gpr(ctx, a->b, dest);
     }
     cond_free(&ctx->null_cond);
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     return true;
 }
 
-- 
2.43.2


