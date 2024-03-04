Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF1C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhDkb-00033L-6e; Mon, 04 Mar 2024 14:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhDkU-00032B-Ds
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:19 -0500
Received: from snake.cherry.relay.mailchannels.net ([23.83.223.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhDkR-0001YB-CY
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:18 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 954EA802137
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 19:13:11 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2D5AF802D87
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 19:13:05 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709579585; a=rsa-sha256;
 cv=pass;
 b=iG+QQGKZEDwwEQgMr1g85yiOdt7WbJsp8DG+IhMybc9kJYH6XaEiLbQANJt+4ukl61ARJl
 yocmMzrEjCdZ9Y9fnwyEhJxO0uw2cd+8pMiwIhTPTkXNXCexRsykYfNr3wK2kgcWtE6z+5
 31DDPjYTsiD9gOe/euQ4Epl58eprEDuOlLAcTWjX2D/26GSbui7xfgMsfW/16GCajCued4
 5wlYNfEH6f83KU/3v3HgQE4A7ZmKxBHKt07CuKmbmxmBHIhV33KpH8G+fV1ehdaGygnuxG
 fDszMG8epqAJDAv6Xybh+wqv69+OQrFsbxa9qma0AJ/2Lntw2qe3ywi+mD2hRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709579585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=QPLrExVbYEDpAF+rKXPpig3K1wcqV2R0lqWTKayQX2Y=;
 b=40vksEb9BTZxwecrwqigv0Yo0YamMUgu2rqk7Gk/SVZVo/FWBel1HfK6oHgsG8vtrx6y3q
 o1y7htX5mVrngLkN3q9Aa5Q6+kejf5jsfjYgkji8uV263wA5m4OMMYtSNc1s+7guWJm/ET
 tzwV0n+knZSBPYfM/fhuoNmdTf/D62bM6vev9qT+Uc+35y1BrIPCPjYUlK+tjm/B29mIbW
 RZxUHCPkyPWF1CGpmTBj+IJQA7rSJDWmb7SP17q+1tWPnLRQnnyCxv+OaoraIGr+eWZ/Nl
 1GQf6dVXcjSJe3FZQsqFde1mQYfoNWwTtcpHkay+l940556cc+y6gcVXo0zH4w==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-xnzjk;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Whimsical-Scare: 08ca98f6278d7c8e_1709579585685_2648520616
X-MC-Loop-Signature: 1709579585685:1178091510
X-MC-Ingress-Time: 1709579585684
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.220.170 (trex/6.9.2); Mon, 04 Mar 2024 19:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709579555; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=jt6QHum3uYyMpyZKJTND1j4b4FygrEOfRRfnkjWOrLL/uYlANz+dTH+vGtseiK1BNbtJsnLVYl93L
 EPoRGdy0r/llG6xFIDTxC+CSvQng5LrwtBz6NDXu01xX/NJpy7zRK4FLYRD8k6chNJNi7APlROfU6d
 NqkviBJAk/C27+RqM1C4DDm+Pcl0b+zhfylDkH1WkmCXoCUW7oCIaPl2Oy4xQFfqJqhcIpXw+VmT9K
 O4DeA/P5KOZs0VUP0fjw/bP2nZWXuPfgU8x9/lsRJq6kmVLpwMGameWnWu41qEslGnQlq3ogSAfP0C
 k3N72sWI3WxfhWaAjJ3PUM6dwLSoiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:dkim-signature:dkim-signature:
 dkim-signature:from;
 bh=QPLrExVbYEDpAF+rKXPpig3K1wcqV2R0lqWTKayQX2Y=;
 b=SZs4SR0/aG9bHzJoUQ/TnLswcwDII8PBRPSef++HW2gbyoNmFjutcS+ke5vDEZywE4w6CNoEx5eiW
 nLGXRRthRbQYfY0IrH7xVtk4KFoULCAX6iHA5aJSZNrfu6rncNLIfcqJ753YP3gjl4WKTdY235awCK
 HalHqvv56BhFDcYXQGIE+sadfVaDFkWtRqY7G4CJUrB/JiKrKsQse/AOuGr9Zz3TSvmWARTo+xf9Xb
 GN3klU9e3q5CDr1FkxAA8Cb+j5jGDdKNhKY+ID5U6XYIgbnTZx6ZzWJlH+umm+llKS3PFA9SvTLAPu
 XNCLhN1OEAHKLsZYJBjEomEtKLf1gMg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=PSPJBkNK; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=QPLrExVbYEDpAF+rKXPpig3K1wcqV2R0lqWTKayQX2Y=;
 b=NKwAv7jb8kpr3Zr23Max1t94yj5tkJdtuAiw5xpZRa52aNhQIV1Frd3o3gTZ52I99Y2CSDJ+zalW/
 TzIbbjflMo2vbdB+swFnN9bFxVUzmz6+MjabAcAiM4HjEcad9NJKKXPkYhVfBZFzrBrJyw7o3vIu8k
 pQ4Nv++KCmlKHiKM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=QPLrExVbYEDpAF+rKXPpig3K1wcqV2R0lqWTKayQX2Y=;
 b=BPjg4sEe6uZ1CeFS/shSSj0pSPS8jj64yPxlKxt7c27LqQxIdahw/4UIbWQAcZKF8Ifd+42tXCNOR
 p3AMz13ES8AgCgiUKdsQRwI+OqYWoo35MmyCgJxvh784Cd6fwbWi8f92y+ulf8Un9nasv3VVk2HF6i
 qNXmogzF3uGXYCSHswY8xXcs9W+pfDix0B1RDZLX1N+VN+F+yJbKxT+w9Z33fWtE51SFKfE30hw96O
 TaLinTmmjj3D3NVkyxs7BQ/oIJE4JJg+Pr01bZ9QqOpMB6IHbxWJbUcq7EDYZqW3pNP2krnlj7AfCe
 N24K9anWbGWRJZas55OqHGKcc2ywLAQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 257d7e32-da5b-11ee-b018-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 257d7e32-da5b-11ee-b018-eda7e384987e;
 Mon, 04 Mar 2024 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QPLrExVbYEDpAF+rKXPpig3K1wcqV2R0lqWTKayQX2Y=; b=PSPJBkNKIE3MDQ9l2F6GZeq1gT
 9Tl9+7+zn3/ucmyhS0vZWtyynB4L4lUFvGmdiE6z9M+xU27ETB58vGIWWvB2hhHg10JEvEFfikoRu
 jFG2A4yBuZek5jtc5QF430TxJ2+XNai1da1ecIQrDYj+GWECbv9fWnncr0D+Asytk/cOA1Mt28i1u
 Aa6wldLobrhKFoUFcJz7373SoJTnhZupuA2YeebZUX2M39IjX9f7e+L01Ele9XYmOHYbkm2pdfz1+
 /KE5dF4cjdCwgs/F7qjZVsZMzmiyl3CwrJWm3i3EKTV1QyhyG4jJuReVDhAcS1fpJpS3QAMlWBn17
 NaoLtM+A==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rhDk7-001AvK-2a;
 Mon, 04 Mar 2024 20:12:55 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH v3 01/12] util/log: convert debug_regions to GList
In-Reply-To: <87il21yj3b.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Mon, 04 Mar 2024 17:58:48 +0000")
References: <20240301174609.1964379-1-svens@stackframe.org>
 <20240301174609.1964379-2-svens@stackframe.org>
 <87jzmiz3oa.fsf@draig.linaro.org> <87bk7uue47.fsf@t14.stackframe.org>
 <87il21yj3b.fsf@draig.linaro.org>
Date: Mon, 04 Mar 2024 20:12:54 +0100
Message-ID: <874jdlvmix.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.83.223.171; envelope-from=svens@stackframe.org;
 helo=snake.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

>> So i wonder
>> whether we should convert all of those functions to GArray? (if
>> possible, i haven't checked)
>
> I think that would depend on access patterns and flexibility. For the
> dfilter there is no particular need for sorting and the principle
> operation is a sequence of lookups. For the other use cases keeping a
> sorted list and quick insertion might be more useful.
>
> While its tempting to go on a wider re-factoring I would caution against
> it so close to softfreeze.
>
>> What do you think?
>
> Lets stick to the dfilter case and worry about wider clean-ups later. As
> Richard points out it might be the interval tree makes more sense for
> some of these things.

I think i go with the GArray variant for now. I'd guess that -dfilter is
usually only used with one or a few arguments, so using a Interval Tree
is probably not neccessary.

