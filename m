Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2528EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmGjR-0006z1-HQ; Mon, 18 Mar 2024 13:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmGjO-0006yX-WC
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:25:03 -0400
Received: from bee.elm.relay.mailchannels.net ([23.83.212.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmGjM-0000PA-5t
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:25:02 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id DAB6C4C2191
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 17:24:56 +0000 (UTC)
Received: from outbound5f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 38CAF4C2BFC
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 17:24:56 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710782696; a=rsa-sha256;
 cv=pass;
 b=k4nI+zrEG6sY32dCfv/TOGDdMHoYvnTef2jm7aQdF4tAm7yKPVCA3UzOjEomOiXU6PXiHA
 CtPEEV8O5PUgBarJ7nuTEQfcl5CRRsM4YVOYkJF/IY8V5Gl9D/b9RYp0TBHv5F9xKfkoSc
 d8FKgsZJdB7+UfoM4OJgdulY1zXrlRTWxIjnoGs65o6yyyc1XxZdCQxeu3221xw+B1jPPv
 xooidAZz5sTqe5KQivQIvzABmoNOk92DFBHlA1AHkyXHefkTGPxorkm+5sBdWS6pV3Mgrn
 IchBwPS14wJ4rxiBJHzPEAd5JU1WlsoAUp/32wgfsjTs3I9SDUeNlNzmaY+4iQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710782696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=oyZejk69429C7zJAjEYxM/fL6FUEa24vQGVGkDHr3eg=;
 b=YBquodvy4WSI3to+oB1M/jw0ddXV8hWrnu7LXgqkEWp31zOM5iFCqGz4QO05MRw22towFy
 SspUzxbSsEXYyMmNfA+xVGxACzmd10yuM4SfLOa8tipAFR9o+z1Y9ouip56qtv7B+AhTCF
 DEcO+tCjwGdnae3Bln3mvBXbTvbzBZjPb+yrzv84pvl+3HTKe85xo11WCNsZvlONvao4xp
 OC6E2iW7Aqts8NUJSlm80DOhI2OaNAQvd8fANPu4DS5geWSMMpNiLgJkTQeswdN03s7ouc
 rle/wwcMV9duPe+4/avanD3ZBJ/eehJmS7TblWO8brKphS3G6N8lFLifo0Hgbg==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-dkjsh;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Drop-Turn: 0d8393ee1221b382_1710782696740_3151819379
X-MC-Loop-Signature: 1710782696740:3268727572
X-MC-Ingress-Time: 1710782696739
Received: from outbound5f.eu.mailhop.org (outbound5f.eu.mailhop.org
 [3.127.8.113]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.126.245.255 (trex/6.9.2); Mon, 18 Mar 2024 17:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710782584; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=qDqxaAsXOVSE5CFzbJMA+9P3Ajyh4dZYWgZmWU4mw9E/lM+CL6D6D7M5Y4M0lt4KH8jqC0BsfX2dt
 SYvFGLIS5n0P5EXX83+Mv6o47nO06IH3iCMvKOT5eIAN3KSX5Y4ElpTctikor3X7Z+AkQTaRPyqA5f
 m4mMJ2MRGQueQxHO7SzAWuZzAKk64NV0Zm0xox5CkS6UyP/0tgN87ynlahn/VcNX/qKBXOY2AN5YA/
 nbd4/N4iu8bnLZjiVd+3Z336mjpnY+OKy+tdmnvll6fnVj+F7z50OfWLtv5rVLOUW2m0N4mxHDVmc9
 ock+ddEVBpQgeYlVuxii5qahRFXEung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=oyZejk69429C7zJAjEYxM/fL6FUEa24vQGVGkDHr3eg=;
 b=RkwfdKtzFBu47pIwJNaNSINot/YWoNKpVsaJhf4hRgJuXReZlwO3tEAgYxk0aj86aaS3u23Tt08gI
 WslAz9ws2lxOLPU+bYVbrq2qHple4pU96wgHuF/0Zj9bQaXHPpYgtoNiZJIIGfzUlSf3Lm2FjEvKhq
 yeQ94enh11bT2PxotoW08iFU3IFARsb5kf/0rZ77ukBlPojp2EFLC9Ft1fgrFVg830qGRPDVObN4Xy
 z3HTI1GXjgcWJoiYAbIrnoSVV8gzx0Smm0DJMeX+32ZRWbaFu+/Klk39c0moj6IACoUVNh5ntloZAF
 4KotwoUCFb7guK16AI3hzJxFbi2RsVQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=SlNqK+Gg; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=oyZejk69429C7zJAjEYxM/fL6FUEa24vQGVGkDHr3eg=;
 b=OaZZKmkUTaazymo5THDjwoZ0pITVQgqCVF8mGtHJsZxz7Jj0fL+IWY1wyVIDn8KmxXVdFlB3dmEuM
 MTBcQC4jv4JtGCLNcV6pBkmOK1GlChwu5PH/OSe4j8Gpyt0Qsf43eU+NE+v5u9dfyhOkpbxMT75Pys
 VPOEHtcBhPynuHBU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=oyZejk69429C7zJAjEYxM/fL6FUEa24vQGVGkDHr3eg=;
 b=R8z6fmENmMVtO3YKiM3dR/jgvq82CAMpBJbT4nzFvGUPyD1y55WVHuJs9EuwThA0UJIrEuHqXp0UT
 UwewHA0koPY9TH18Ca+G+GIkuf2vw+K2l30Mlq+lXrzKr1SCcGnXadNBhwVSezquXMhnxMdfLEOM8p
 OSRAOhB6hivcetKiokbHeyA5adEctOMck9sZ9izg4k9jxmdwWHO03xLNEgadz1K4O5BMigoAimT1uD
 q7EfadeqZeVZyV5SeSh8CFWw44DOkPR8LVbi3EZphrnajs/5yWr4o2/o/P2oYLLlY03G+rty54baza
 KMWfrzP/eSY3Pj068+NDEUFRXw+SCaw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 2bf0ca05-e54c-11ee-b7c4-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 2bf0ca05-e54c-11ee-b7c4-9b9d9be6ef2c;
 Mon, 18 Mar 2024 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oyZejk69429C7zJAjEYxM/fL6FUEa24vQGVGkDHr3eg=; b=SlNqK+GgaP8trQqmAYv6DlgY8F
 3AyqAFbaJKHmOja6NGmu9W4TsnaaSku8Oi84MPqP1M173CuBJ7uz7sRr5NLD6xedlEI6+lH5TkFz0
 N05K3bM3sUaCtNpSB+m237E/TJX8a4IH4Zy7ZpEsbN0ckRdfi66SJZvYy2BDoESiByOujgc1k6fOi
 95nXYEuUMmIXusfIJaQbfTzjbOmYIGWawLFyn/HgyA/jxuGSh99+f4hYLPXeycoaTe4FqNXDRDnpp
 rkBpCtDs9vNMZEL3JxiDQQFDMiMNGDEtPQp9pj45LcZBqg7d47Ob8vnBgvjMGaJebOqpc1nuKHewo
 +G7ndbuQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmGjD-004Kmg-0n;
 Mon, 18 Mar 2024 18:24:51 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] 64 Bit support for hppa gdbstub
In-Reply-To: <60c3fc50-9b48-4f79-b9b5-2ba08c2faffc@linaro.org> (Richard
 Henderson's message of "Mon, 18 Mar 2024 07:09:44 -1000")
References: <20240228201434.1515893-1-svens@stackframe.org>
 <87sf0ouk1u.fsf@t14.stackframe.org>
 <60c3fc50-9b48-4f79-b9b5-2ba08c2faffc@linaro.org>
Date: Mon, 18 Mar 2024 18:24:50 +0100
Message-ID: <87jzlzv4f1.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.212.14; envelope-from=svens@stackframe.org;
 helo=bee.elm.relay.mailchannels.net
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/17/24 20:32, Sven Schnelle wrote:
>> Hi Richard,
>> Sven Schnelle <svens@stackframe.org> writes:
>> 
>>> Hi List,
>>>
>>> this patchset allows to debug the hppa target when running in wide (64 bit)
>>> mode. gdb needs a small patch to switch to 64 bit mode. I pushed the
>>> patch to https://github.com/bminor/binutils-gdb/commit/fd8662ec282d688d1f8100b4365823e57516857b
>>> With this patch gdb will switch to the appropriate mode when connecting
>>> to qemu/gdbstub.
>>>
>>> Sven Schnelle (3):
>>>    Revert "target/hppa: Drop attempted gdbstub support for hppa64"
>>>    target/hppa: add 64 bit support to gdbstub
>>>    target/hppa: mask CR_SAR register writes to 5/6 bit in gdbstub
>>>
>>>   target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
>>>   1 file changed, 45 insertions(+), 21 deletions(-)
>> gentle ping - if i followed correctly only one patch was reviewed so
>> far.
>
> We can't really proceed until you get your gdb patch reviewed upstream.
> All that will happen in the meantime is that qemu make-check will fail.

I see. Thanks!

