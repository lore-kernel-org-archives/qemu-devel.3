Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F35C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh88v-00071T-8F; Mon, 04 Mar 2024 08:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rh88t-000714-GP
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:14:07 -0500
Received: from aye.yew.relay.mailchannels.net ([23.83.220.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rh88p-0003lC-VB
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:14:07 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9D04E901B2D
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 13:13:54 +0000 (UTC)
Received: from outbound5i.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id E38CC901B02
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 13:13:53 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709558034; a=rsa-sha256;
 cv=pass;
 b=FKmMBdwfj9DtAU5S5heT9CDSisSVHFiDRPfWAeSq2ZHRvEQ++MiJGfliOdDbWyxCVvKWA4
 0nDDfIY8ENp6+lhnvvWPC+0f60vLZONqHOnCjYhEZOhGyfkH0MTefqBbqm+aQsBBJMUydq
 eEQ/zw1BAas4x+7Re3sByzSEzDi+WyQHF4M6ms9Jzu0xckLZT+6pPqcYiVu91oJVHaY2sL
 dxWec9oKifTrtmV+43TaN35anp6ZZTK5gi8XKJfggPbqdR2fQNHSitoy61poHsPj5pfY2c
 gbNtYKTVD5fp7A7doOfHMAEJJBXkLTxYrz5JFR+trBS2EtBhDAAfpgnAtEAO1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709558034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=v8oo1R9nliai7StaByx6EngF66pk1g0gBLXxd/HFVh4=;
 b=acuxSZc1f7y7cbdwJJaWEStuMWl8sKWlCPdphpgTKgWU5FJfmGGyyptPwiyl7aBidOV3kq
 d1pmge4npyUBbfdUMwySr+RUH1NDso9pwSfMzWO6UsOANz6zITsBbxWiVFjdNdtXRJa4B/
 9KFSmexrMut8qlHWYiy47w7l7l22H55oTlICZrLf663+TwgZN9sK3YUs+DcY5eAd5zuQGE
 KiTcsIzSEYoFbo5s3SfVM3k4IpgkbzxLCQFae8VOz2qH8TupNqWzze++dY2c5FGrDKEtDP
 Q5hJXgh9rdpKoyxFkgNujjATx0pN3UqPakwDC9GYY9b/8vSS/eyNv/KaXalQ+A==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-26htq;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Harbor-Relation: 6032631c25cd868b_1709558034425_434175741
X-MC-Loop-Signature: 1709558034425:1571939916
X-MC-Ingress-Time: 1709558034425
Received: from outbound5i.eu.mailhop.org (outbound5i.eu.mailhop.org
 [35.156.234.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.192.177 (trex/6.9.2); Mon, 04 Mar 2024 13:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709557939; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=oeOIkMPAnpIb976RbV809Flh7U3mGv1b07S1PRItM26y47YDCxpxGnac192CDOZOZT6m/u7ov8b8M
 ot0l/g8n1os57itPKfy+IzZn0ILLA/LP5D8PrzYssqBru0gwTYqDKVJzmuwgj1fxe3/5OJqRUKOGr0
 61ew+9Ap8EWHiblr+okR4JQ9u4atGkpjiosX9rFewMy3O6PPCYsJOeVSjWYXpw2FVL1VikTLpNbVpt
 GyiRsWnhbFVlSb6w+gTtry1ITWDcJg7PogHl8fPv7T6bk+wHY6y8vi6eR2bYu+K1yDFiChf38KvFjG
 /TUtiMzxr5lEyf8Y2uXvZnjowp6otDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:dkim-signature:dkim-signature:
 dkim-signature:from;
 bh=v8oo1R9nliai7StaByx6EngF66pk1g0gBLXxd/HFVh4=;
 b=JAEG/O5/CqHOSoJs8lgYm1Q0O1ZFhLA7gF57puLI8M2+TNLQtKI1WESq+nVxY9h87N1hbrPUec1vH
 TcJL8pVqq/3qAvQgsyEWc3QPXX9W/vNLSeA7d221ZVKSyMEKKqdixe5jsMjK2A+f+7KFx92180Rma/
 QNzlGNW3Fr7YmG5zqAkAiDPrkAIgD+Bttu2y6Gr3UdoO2dMhnLjGcngX7SIeJ5XijCN/ZE7wMJbsX5
 z1vzpUbPIvWe2+oFoUraKDid75/ceIboN5PBp/nK/TCXfe4IdeXiNLKg1pGJK1L1SNEyE26vdSfFOi
 Xt3+HT7mV87pIK7CRKtgyHyE5DlB8lQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=YfOdZkBH; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=v8oo1R9nliai7StaByx6EngF66pk1g0gBLXxd/HFVh4=;
 b=oK+irFqFbMOo1WR9RovtVyhaJIdvgp/Mf1yAYVCabY/l4CoB907Xh0nt14FHJ9oK8SsGPw5UL96X0
 c9DQHDHOkogX/5l5NSkawZR5VDTB5zADOPOC4lGE6/Cn6BfXVirrSnlJgs/EqXde4O38itD8KJBLH1
 6VmbbPS51yQvkp7Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=v8oo1R9nliai7StaByx6EngF66pk1g0gBLXxd/HFVh4=;
 b=rRFpLeut/c1Zmri2LiK9K4nggfe6AhxGmB1TkRZPioRJB8TSR2XkiO4R1QY0xY8mxnjiEC+FLSjVm
 S6xPdKlgsFud+riLtZXYi8jSl65Nz4ZFGg01M3GWdfn71NWnwC9Ntrp3R9Wr/eYkBz/brxz0uM74eR
 YTE8GGei+ZOLDtJFRGfaR7K59BjJNZNI07M4eAF2ZEnr2t5FpLtkvcq3xtQG01hhOK1U1Q+2JPnf/o
 ItBDuhY5cw4f8UnD04FRvJLpsKzVVd4ef3j03T/MhVUlvmaDQ9WV4S2JBRU5KRIDdHxd1qQXqPGdeU
 /WuiZz2AA45ImIRsGcvfGeGZ17RlSQw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: d12ddaef-da28-11ee-b690-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id d12ddaef-da28-11ee-b690-9b9d9be6ef2c;
 Mon, 04 Mar 2024 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v8oo1R9nliai7StaByx6EngF66pk1g0gBLXxd/HFVh4=; b=YfOdZkBHKRWW9+QCAhw+ixe1PT
 VTm9FMrc4SB1/y8d9QgLDfupew+Uq5+dzOis2W2Ym5GzZ4OEGqc0pgIlC8gEtwJWPbWZTCXzc1gt6
 IEP1iEarYUIN9spAUKpFMeEfdNcPBE831AMo8qSoDmTTXXx/iIlq5c5eNjZj9PfnbIAd+0dVrZGTz
 rRfFYysHspGq+NVaWJ8sCYNsy6XimcQbBaJHMKH6RFGmtAgI0/bf5kBulxEiIkUTptZQTXgjg9hIE
 ngDoPPSMTgvCIgrI0baNoq6WGaLYP9wyzRqgCvDNzqNK2fhJWgLJWC40pYeNiK+s0nVxRixq01luL
 64GVY4TA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rh88Y-0017nD-3C;
 Mon, 04 Mar 2024 14:13:47 +0100
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
Date: Mon, 04 Mar 2024 14:13:46 +0100
Message-ID: <87jzmiuol1.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.83.220.6; envelope-from=svens@stackframe.org;
 helo=aye.yew.relay.mailchannels.net
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

Good point. I'll change it back to a GArray in the next iteration.

