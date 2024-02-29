Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2892FC54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfkjh-0001uO-Pw; Thu, 29 Feb 2024 13:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfkjQ-0001hv-3V
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:02:20 -0500
Received: from cat.pear.relay.mailchannels.net ([23.83.216.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfkjM-0007t5-67
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:02:07 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 58004502FDB
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:02:01 +0000 (UTC)
Received: from outbound5f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id A057F502915
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:02:00 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709229720; a=rsa-sha256;
 cv=pass;
 b=WxbhE3B76yvRI/I8YFceJtfCzvO3IcwCD/mdNf9RVa1nEsKBdhlkuPpjyPEJeiDYrxGJpO
 c3F4ytRSwPlhb5z+5uVaw9CKV+RDnqBpAt/8fhcBi+321p3FXqL0ebUj4hqzvUqisxQlCh
 O5yi9H1487Ku2bAkBicrOmlsBqTP0wdBeQI13p1IIpMIDAK9KdEiMErKcNN7EMtwQHxsM0
 en0SDTQ5s1MIqhZF/rqFR90it1BLFr7EgAwN0wp323Uy8q8fjRVnTJX9J7YMmpeKT36exC
 GHckgnCYMcIqJM5udwNWxiTeamFLr/PPh5gdHHDBobYlKST4xaHsMrQTeJmFWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709229720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=RjUi/PeDAxmenFIyq3fsCYS/2p389XMDTViSE8RPfd4=;
 b=ER3qPGLri0KKta61jhpYvsKOnhG6mJ0Uo2O2EInXKSOU2IUzYLPO66ksOw2dcEqPy2Y8we
 1aGTe7L0qqsxCNN0SJyZXfJVGsdzexbpoWKcZ4qmCYWTyG4qRmGr2zKmesF1wXx5y8l/Jb
 +YndXuc3RSgAfB9Jsb4J7cvgR2wtQWqKss+HAVCycWnGVJlrfuRfdum8q6DrRM0fD7Yg3J
 RRB7fIe3DO3aaq+tVT8vtsOig3DNzWnWCIlQo2cvOeU5i0OR+JNnOqhDsyk3ZWn/xxO+H+
 2oikbIFx8DlRQuSBL52rUTCDIUIYy9FqTzZjJBAFCmV+wtnGCyiIm4eyfsfubA==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-smqdl;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Lonely-Towering: 36cc18795b6abb9e_1709229721168_3977930561
X-MC-Loop-Signature: 1709229721168:3319174320
X-MC-Ingress-Time: 1709229721168
Received: from outbound5f.eu.mailhop.org (outbound5f.eu.mailhop.org
 [3.127.8.113]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.49.214 (trex/6.9.2); Thu, 29 Feb 2024 18:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709229630; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Ozzc+SdvG++3vfgmgWOhqTx2TRgSWpYUnH8eqwtW7SfobBlEF5q/18HWpyStElBDcP33EK7z5SJLg
 YOMgoFk+GgsLLeCZ4xwc6wZE/fR6bgzAJglkFKawVmNeFgVGZaaNXmX9OCmE71+7W+SkozAQmjC9lF
 OHchspRXYdzyQyO1NMOvAdMGsJNFiCS1AbB5wh2f8Rx4TOyz3iS7U0+Lb7O7oWOlcUMvcWBSU5kvSz
 KjtNDeLqUwoeBP+wjlUlQK7YdAYfZcrHhRhj6RtSsQh36EeU63Ee5tYdXAEkjsfcsci0mauoFLXr3K
 /jQfd+AaWyNd1nFmAw1pX4F+Z7jojRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=RjUi/PeDAxmenFIyq3fsCYS/2p389XMDTViSE8RPfd4=;
 b=Xu2uwTObgen02/fDDxoCUadAj18Z361V4JlLW5kmIydk/KeZkxUhoT+3iyYUhjMOPyIJIw0SobDDE
 oHOF4C978FNd95Zii1cFoRE/XoEBQvMqkShrscJaICbgg9IJbfo0asX5558CP+Cmruy0+XRLFi6xTW
 D6isVw95xoXPRvrjiYVFvaW/1ktmQdBrSBveqAbSO30l7UAIVjRdNzA0/Dq9QpMCl2ntm3BLKYsGXl
 HqLrhMkAwI9Vw1E5SUT/ZZM34UwvHcu9Ygx9oJ5o2vXZlfFWu/P4Ct4PnqE4sHiaKJpcYTNaI4sYP1
 s8clry71GsXonyuBUmh/4knrBM5MeQA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Gdd9CnSe; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=RjUi/PeDAxmenFIyq3fsCYS/2p389XMDTViSE8RPfd4=;
 b=h4Jy4Iry/58w6CqslhxJ2Nysbz4p0AP+arb/QYN+nGfT8vMbeu9+YqD2t1Yy8DZx6R3wo9X/UWztd
 ad/yjEDmVJMq86aXYuQJlCUV1p6B8Zo8BUxMJnhiSQJwAwi65Dkzffx2lQqJ53uH4lW8G8mXsvCBso
 TmdcRpmBV+QtFnzk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=RjUi/PeDAxmenFIyq3fsCYS/2p389XMDTViSE8RPfd4=;
 b=BUiok26oL3YiTus1ZoRNjPF2qysyCqblotYlwt4vPZRUomnu3KOzEDKPR3LRmb24gDsgRf3DptKG+
 IneqrTo1gkYbIYdXoln5igrJDhBK2O236d2D5fOqMLKPJyQpoAz+vP9FD83kc07xw/ww++fbskx96a
 PmwQb9cWR3Y90zu+7r0YLDDRBIVSU6urEbbkdnmUKt+1KNnOHExABVjWz0+4MblQx2TUvHySMHh/oe
 J3KjzWEcZIoc/3BThgPA3grWcWPadFthMmmy+ekULY7YHmloa+Mo9HBgoMNT/nWK3nmu+Mh4TwszrU
 i9WjdMquns0iuIsD4JuBZM5A1+nCD5g==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 6a229436-d72c-11ee-b65f-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 6a229436-d72c-11ee-b65f-9b9d9be6ef2c;
 Thu, 29 Feb 2024 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjUi/PeDAxmenFIyq3fsCYS/2p389XMDTViSE8RPfd4=; b=Gdd9CnSeV8hHbSETdzol1FjVHa
 IvOi2IsgM6ZjCmuXJZJqxfwI57jSzWsiYXaukvH+E0xhkXNV8H3NE1WKXCcKCo2cYPlQuTMpwIA22
 i7ms74di8tPXXDZYO+LPjOanERsoxbyRpBD3gzPoe4UlP3BoximXR2VWyKMkn1eP/L0rwCJjHeBCN
 oKegeOzW+BDCBda7yJ9DIWCjaqEJLuO+FyHMsvMfYUKhcaDrI+JfTXZO5nI+e3sanPSV7Qb237PBY
 aHpyinOhwhx2fChbt6gDYUqpEFvhyqCQi65EcUiQ0D6qLOd/fJDy1Rf1cgCOYGJf9eUQawcX6b4SA
 zL1yNbeA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfkjC-000Mvh-0S;
 Thu, 29 Feb 2024 19:01:54 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add hack to prevent scsi timeouts
 in HP-UX 10.20
In-Reply-To: <CAFEAcA8tbtrtoZSO2MmLHr+7+mcys63z15qFEVYm=nAO4cUMmQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 29 Feb 2024 17:26:53 +0000")
References: <20240228211149.1533426-1-svens@stackframe.org>
 <CAFEAcA-KioRCJ97dbaiSf0f5uM0=+nAb=oLbFiRg=EPGwd57sw@mail.gmail.com>
 <87r0gvxlce.fsf@t14.stackframe.org>
 <CAFEAcA8tbtrtoZSO2MmLHr+7+mcys63z15qFEVYm=nAO4cUMmQ@mail.gmail.com>
Date: Thu, 29 Feb 2024 19:01:53 +0100
Message-ID: <87msrjxi7i.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.31; envelope-from=svens@stackframe.org;
 helo=cat.pear.relay.mailchannels.net
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 29 Feb 2024 at 16:54, Sven Schnelle <svens@stackframe.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Wed, 28 Feb 2024 at 21:12, Sven Schnelle <svens@stackframe.org> wrote:
>> >>
>> >> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
>> >> under certain circumstances. As the SCSI controller and CPU are not
>> >> running at the same time this loop will never finish. After some
>> >> time, the check loop interrupts with a unexpected device disconnect.
>> >> This works, but is slow because the kernel resets the scsi controller.
>> >> Instead of signaling UDC, add an option 'hpux-spin-workaround' which
>> >> emulates a INTERRUPT 2 script instruction. This instruction tells the
>> >> kernel that the request was fulfilled. With this change, SCSI speeds
>> >> improves significantly.
>> >> [..]
>> > I see we already have a hacky workaround for other OSes
>> > that do something similar. The ideal fix for both of these
>> > I think would be for lsi_execute_script() to, instead of stopping,
>> > arrange to defer executing more script instructions until
>> > after the guest has had a chance to run a bit more.
>> > I think setting a timer that calls lsi_resume_script() after
>> > a while would have that effect.
>>
>> Thanks, good idea. So something like this?
>
> Yeah, something like that I think. (You probably want to delete
> the timer on reset, and you need to handle migration -- you can
> either put the timer state in a new vmstate section, or else
> in post-load if the state is 'LSI_WAIT_SCRIPTS' arm the timer.)

> Does it work? :-)

Yes it does. I only did a quick hack without caring about things like
reset, freeing the timer and migration. I successfully booted HP-UX 10.20
without any scsi errors in the dmesg. So i think this is much better
than the commandline option. I'll prepare a proper patch in the next
days and submit it.

Thanks!
Sven

