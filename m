Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7A3C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 06:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm6YM-00071L-O3; Mon, 18 Mar 2024 02:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rm6Y5-0006zN-9e
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 02:32:42 -0400
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rm6Y2-0004Hq-My
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 02:32:40 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BB1361419CC
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 06:32:35 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 11F211427F2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 06:32:34 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710743555; a=rsa-sha256;
 cv=pass;
 b=8nosavmmPN1WRrrI94lfMDHfbVVLzQBDfrup9N7SsGoRZsZMShiOiHDEMqxiFYGDuM6uKJ
 TGVVY/Vdtnx6VrCvhzRhUlWspiRTIYBOi5JSlLvsf3kuDwkHNG7ymB+z4soKuiG4NMxxqS
 fME1BpnBCWPcX+y+NSb21lC3JC7TkIO7hMMIk5k9aux0A0tYb2+Nqh/EhV8gOvAd596Eu7
 gSZtOUMOtS5ZUuBj19eh7qh51wurxGnr2eJEDC/IsmMdH7to42adwc7FWfhc2DoaT+jxoj
 ZixF+cr4ZqUi8BRp2Z7r+2i1sxzJRP+Q6MSOAQMZ7olSUeSXV4BBXh5X2W0khw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710743555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=uauC9RaMTR08EOglLT6hsYu2NoiXT09wAPsh72B2MA4=;
 b=Drw6XDAtI2xJk3mw2VQXFPMF/ChpefRQwR05ZvYktP6/+th+o/zWuglrTGOC9Lq57cO8Hs
 yGj3ljce+K5/i/6is+WKgZBG3b7ewsNDgI6DIKVME1RiipluZklHWLEcydKOMqBaVsWWOR
 izmCXBxxWjhDLoTJG04dMuCvv5wa1YlZsyIAqfPlahdWQXh4QUXvYvwl+cuc83eTbnqg5V
 MLu+7ZRT1TCsvU1mzxIhx/Wo714v6svoPIvhQ6rZk22ex5tYr+oxGCKfTvh3Px3RhyElur
 dl+UqNyM8hUZF2C9PsTaDExPO4fqK8jXEs2WuZGsDptkG3RcK4B+vQZv9fK/gg==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-d9kdd;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Stretch-Turn: 727175321418b1a9_1710743555584_1685567598
X-MC-Loop-Signature: 1710743555584:342932190
X-MC-Ingress-Time: 1710743555584
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Mon, 18 Mar 2024 06:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710743521; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=ZZUMRJoYjZk8RWiJL/PV0ZE9zzHWmfnFw5TEHfsjhxMP9F8PXYZIy82/qMNE5Z+Yfh4SLPlCI8GMe
 z1vqrXA/0FJU179dYnsklEpDMlxk68vgSjtiQHgcnl365NjA2I4khdfuafJ8gAL49ExwLaag9YE7+L
 WU/7qd9YETV0LgFwsOVmUtbGezITB2iTa3IRKxPrdE2xxAtGk/TfPeKKvhhEsM6mBKefDfGdn3AQaE
 nKVW6cRXhZ+cbBpIbvH4kWT2dDp9zETRLdwIR/TIBTjpf8t6l5zdbjefCw+vvj2cuDpoT6ihiLvWGq
 dFeBhaGSss3wB+Hn73YcUDF/a7H2d6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=uauC9RaMTR08EOglLT6hsYu2NoiXT09wAPsh72B2MA4=;
 b=hrl0Y1AM/gFm//V/Nc7Bpju/iCIY/sPEJehVQqdyEFAWglW2/bJW0Y9jH1PTqBOXfXJxwv6VjADq3
 pUEeWQbTIGTmKFT5dgz9FG0mC+CqLgNQP02wlSyWhl7RkizBZQxga7Bys/H1GCGpfn1K1v7DmyAQDy
 2Qoti4ml6vmtuyHS3gMvsy6lQOjzCLxLJ4ZdXqSbbbKAdO7YDqL/3Hry7KDHnGJh+gBONOw1AIlJqP
 WzPaL8pB8jPKPVsqVqtKXQqvLJFXk6fDesuU3wSE82i2qBq7Lu1vk2CXyqcsaSSLSzUANN2M/sR/M4
 IeRBSjTUBOwXyILpZOWPEKW3jnrcs8Q==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=bdRdd2X4; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=uauC9RaMTR08EOglLT6hsYu2NoiXT09wAPsh72B2MA4=;
 b=Rw7WzZd3Kj//2MG7R5Op2h7KG8NEyHSwvUiELj1RBDoJsMHUlxLSICjsE9ocO32NCoj/ia/LvDDIp
 aczidJadTPfbj2GXoaJaKr509afd0DCPMk23cVY1PmoJxnDTXo/Mm9Y9vGcgYrOPIap41lyvOFAyWZ
 iUxFe3YyyRueBo6U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=uauC9RaMTR08EOglLT6hsYu2NoiXT09wAPsh72B2MA4=;
 b=EfuUknVTDVc9B0IvEn8QyrRFLc1ctJP1KwGJA619vADtTl9M1gDXpYG+09XD1Cmj/c11w0GV2/yKS
 QIT+HSQhvFMh0aEO8Oon7du5MOFK7vB4xBrOCBHAvUOBXo0BPNB6NBvDMoDzc9veMUY9eQAm5ktbpC
 NLkSrLA84CXZSsV+Sqi5imn9s0pmTNg5tzofvHsDYF+1OyWKz8Mnxw5pUi6+v4LTKL6dcaTIstWgDp
 /DpyjcvkwwUxr73R4Hnc8vLxJPSuGtFVhgCLfY9in8GZH0XEnyABdd3QBV5/wIdYk3g/ZDyifc0YW3
 jZoiO9Oj0XSzJ0Oi5fBSWqT72WQJxaA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 38630df5-e4f1-11ee-b1be-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 38630df5-e4f1-11ee-b1be-eda7e384987e;
 Mon, 18 Mar 2024 06:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uauC9RaMTR08EOglLT6hsYu2NoiXT09wAPsh72B2MA4=; b=bdRdd2X4EIf1L+57TBBXZ/Siox
 hsZwW3OOsnmMkTnb+28PBQO1NMVhC3YQAfmStza32BngU/NKHVJZcRw8L56bbred4XT+5MuxqM2KQ
 J0cliyxXbMWMAJm4CGWY+QRJ9vCWWeT48fg4zczlRQS/jHjDDSQDiMYM+J3pTV48OUo+jB9oDsTeW
 TmRkGsrY/eY2mbGXQoEc68NdxGdYYgb4cCg0UfABmsFvMu/LqXxx6Gy+JOdFhaydhaUEk0tqzGPpY
 rRQHMOG3TYtgb8h+eDCjBCUrK7OzNBWRPUmdbGVBkUnRhSrJz7ZzRDC1KtVFJEvLancG5Mgl+sDQN
 Hsuryx4A==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rm6Xu-004FWq-0x;
 Mon, 18 Mar 2024 07:32:30 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] 64 Bit support for hppa gdbstub
In-Reply-To: <20240228201434.1515893-1-svens@stackframe.org> (Sven Schnelle's
 message of "Wed, 28 Feb 2024 21:14:30 +0100")
References: <20240228201434.1515893-1-svens@stackframe.org>
Date: Mon, 18 Mar 2024 07:32:29 +0100
Message-ID: <87sf0ouk1u.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.32; envelope-from=svens@stackframe.org;
 helo=catfish.pear.relay.mailchannels.net
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

Hi Richard,

Sven Schnelle <svens@stackframe.org> writes:

> Hi List,
>
> this patchset allows to debug the hppa target when running in wide (64 bit)
> mode. gdb needs a small patch to switch to 64 bit mode. I pushed the
> patch to https://github.com/bminor/binutils-gdb/commit/fd8662ec282d688d1f8100b4365823e57516857b
> With this patch gdb will switch to the appropriate mode when connecting
> to qemu/gdbstub.
>
> Sven Schnelle (3):
>   Revert "target/hppa: Drop attempted gdbstub support for hppa64"
>   target/hppa: add 64 bit support to gdbstub
>   target/hppa: mask CR_SAR register writes to 5/6 bit in gdbstub
>
>  target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 21 deletions(-)

gentle ping - if i followed correctly only one patch was reviewed so far.

