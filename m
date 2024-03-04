Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40982C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBg1-0007AW-Tc; Mon, 04 Mar 2024 12:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhBff-0006z8-5Y
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:00:12 -0500
Received: from chocolate.pear.relay.mailchannels.net ([23.83.216.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhBfY-0001or-EC
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:00:10 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0E127761DE9
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 17:00:02 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id C9C27761BD4
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 17:00:00 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709571601; a=rsa-sha256;
 cv=pass;
 b=U7UfgLYYtfaluVg78f7jT+vLvoLmt7TgTKUaoeJqmsoJPtUs/gTNRIMCUvQh/zfoU4el6T
 oGoN3hhaigZOPDK0c8Uz8d138GjrPTPY9LOrcvI5Qnx408x2k7XYW29YG8uGgIKpzp9xq2
 Oc8OaVIlKEI9MmXo+5lHTKtOPREgHuMwEXU8EJMN7hdSJ5iOIDw708Ke99Nz5LbY+t9S6t
 1vNodYEda119Kobe/u5Cr9JmqmIymuBTrBqCxW91heEOyHfiJ5M4PcYzqCC3LKAF6hoMm8
 RfCIG5ZDsISq/hKfT3LfZ9OzBHr3CBOtZkN5GwaEM+X/TZDRLqqO5Q7q4MbASw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709571601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=6aLL4WLv+qXivdgJHK5nuaQcHevmqqXMZRwMguKfepI=;
 b=Lm1YqRx+ipiTt7zc2cF1c9Xqh/ceM3jjgbIj5MBg6LyrKQg/aMMAQ8KHGQigZ9D1YyGkbg
 T8Wl3/vuyMS/dXowTdZqYiEfEv2D+eFv85HJWCdKE5qrlPWDIADvIh7JIzSjHCyrKrCic6
 IzvTBttmOb9s0swyNc0iT6MBrJnLgHXN2c9ZEEbMQnt2Xc3/1hCOLBK5871fjQ+JcC/slr
 gv/rsFKp2jjbUtISiro6I7OnobUlOj6uOtFH9pAcCGdEz4SPnwN6a/W8v/fZjUcFbN0FWF
 67HoC6D1h0bH+jPFZA+9qKaH3+OOEGCe5DfocIUixm4m5kFUrGyS1wbOCASIGg==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-wmpx6;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Hysterical-Fumbling: 514a70323ba49890_1709571601322_2709736834
X-MC-Loop-Signature: 1709571601321:1202081417
X-MC-Ingress-Time: 1709571601321
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.52.242 (trex/6.9.2); Mon, 04 Mar 2024 17:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709571574; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=e5E6uSmDCgjKz8bPHLs74ext2JNQuh595g6A1+LbFyrVLcr/lR97Q/ldBBTEuTpArpc245Be4/BLU
 j/LPK5LTRYdg+aNXK7nqGbc6ifn2dMlmDqq6IpAiIWQ/y9xbs8OYvLyA1OQZPfZtQFzSWMcFMvOPcT
 JZQlo/gbRAg68CBzrrPwCk7aokY4EYHq/DqVxWQY3YiVkvY++atBH/JJdGp5I9W3YQ3jw4+UysYtrE
 0YBgdsak9bokE6M2PlNDIZkhj61g5+gJjUjaqH5oV6n9kMshFMNrA0jDEs6/pPW3J4+woAMUa+sGVu
 SbZMPPv7lc4Ky+WcYzEMKtDFQeoMzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:dkim-signature:dkim-signature:
 dkim-signature:from;
 bh=6aLL4WLv+qXivdgJHK5nuaQcHevmqqXMZRwMguKfepI=;
 b=MxAq6Or6/HKh6gahgSvtF8QZNLNXD4D4/gwlNqpS3ypDM3oUmAhGXFnZJqGLOzpfzV0xyCtEyTvXo
 X6vnw2bNfd9B3bRI0VFoTcxlTGfH1sv/3BWxjtHgakCfvAmSrYZ3KTa0org4NERU4rbY1c0+sB+DEH
 fIBacZw+OB2Maggf3k1mjqms7lUTwwMtl4hS6wEsCmLUrsjZiRDls5pQVy7KQssamXF978IxinoMwe
 3lcuWGsJPryrhzj4acQGSl8Tmn1UtQ/y20woJAWWv0Dvo1S7qcJAgqpxUjDn++9Xv1syJ5wCVmEvO+
 l0zRKxT96W2SkeEg1jRMHrB5Glp3emg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=aCa53Ft6; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=6aLL4WLv+qXivdgJHK5nuaQcHevmqqXMZRwMguKfepI=;
 b=EV+6WFOXM80ssFXvRT5ARQsA+XKjbVR6yIkTpUZn05LTc6CwV0MZXc+S9DjXsN6kjJrmYJuC4OF2/
 /ori7MEl076jOfE9gReNtN+OSTgZiTfetAFmkPSu0T/WmrzIx489mNFn51/yfRhk7qL6DZ7WDdFoUq
 f7sXIAaOzlefgW2I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=6aLL4WLv+qXivdgJHK5nuaQcHevmqqXMZRwMguKfepI=;
 b=s2XT8Zw5/SNLTQ/46H+bTdI0YwTNH0jviBnqC/zwotxg18jDGxUq5uk3521uHZaTXXUT6Iqv7olgL
 UhKeqI9ZFu7GlfMfMwGwq8yWM8rqdrCpamDmh4vRjlUH3sFQix9PmXlSYhmt0HMaGsxBekpIeXK3LK
 yF3CEzGbfJQNbWM6HMiISZBBzqiOIU7kqd2e6HGrKAvLkrrhxSVmh4XgdV7WTyyRMZQbNnAzkVO1LO
 hmWxVDEItBvRCYni6c845w+79r9HV/LbLMWs9ZPA9WBRXXF+2CmUR852dJVeXIkPcuA0PVO5wFjE4d
 dF0KYLMvAQq3p/FXU7tyCXOc+Ihfh9g==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 90419a42-da48-11ee-b017-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 90419a42-da48-11ee-b017-eda7e384987e;
 Mon, 04 Mar 2024 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6aLL4WLv+qXivdgJHK5nuaQcHevmqqXMZRwMguKfepI=; b=aCa53Ft69OaRfRcR2KPPj73MU3
 7GxDTp7JAAwXg5/jl9Gqk3siJaSeP7qHHqp2AptqRwiQh0DwMuGxx4JOEepX92Mn2nb9lIH/r5/i8
 du4L78epfqH9Sevn2y+I3JuApECNdazMh8C/GRlrEHV6zXN0QG+xOrq0E36qCHArZ4OqA8HQ1wwvp
 Bt8dRJQVOMA2+gibE1ghq+H4HIemKb0V6v7Vc+mar7bfMd43YSjXspab5yfeCaQfdfF3ZoOVkIDgD
 OyDSLXKhdpcc0nUk8cTxRfUY8o0hgeUyCJxNsz6jqaWYbDsqpJb+wg8eYrjQoeU2NH9Z3r7gDF3yz
 3Cw65bFA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rhBfO-0019t0-13;
 Mon, 04 Mar 2024 17:59:54 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH v3 01/12] util/log: convert debug_regions to GList
In-Reply-To: <87jzmiz3oa.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Mon, 04 Mar 2024 10:34:13 +0000")
References: <20240301174609.1964379-1-svens@stackframe.org>
 <20240301174609.1964379-2-svens@stackframe.org>
 <87jzmiz3oa.fsf@draig.linaro.org>
Date: Mon, 04 Mar 2024 17:59:52 +0100
Message-ID: <87bk7uue47.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.83.216.35; envelope-from=svens@stackframe.org;
 helo=chocolate.pear.relay.mailchannels.net
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

> Sven Schnelle <svens@stackframe.org> writes:
>
>> In preparation of making the parsing part of qemu_set_dfilter_ranges()
>> available to other users, convert it to return a GList, so the result
>> can be used with other functions taking a GList of struct Range.
>
> Why do we need to convert it to a Glist? When I originally wrote the
> dfilter code I deliberately chose GArray over GList to avoid bouncing
> across cache lines during the tight loop that is checking ranges. It's
> not like we can't pass GArray's to plugins as well?

Looking at the code again, i remember that the reason for choosing GList
was that the other range matching function all take GList's - having
some functions take GArray's, and some not would be odd. So i wonder
whether we should convert all of those functions to GArray? (if
possible, i haven't checked)

What do you think?

