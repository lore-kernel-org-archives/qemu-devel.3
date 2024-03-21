Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFFC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 18:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnN6j-0006Fi-6v; Thu, 21 Mar 2024 14:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnN6h-0006FT-IN
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:25:39 -0400
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnN6f-0003VT-C1
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:25:39 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 3C1303628AE
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:25:33 +0000 (UTC)
Received: from outbound5h.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 928B5363ECE
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:25:30 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711045530; a=rsa-sha256;
 cv=pass;
 b=Fetufl5VIiukdj5Qi3A/AcHqG62yavE2vV58CNDIlzxkdkjUdt/Nf0eeKuMUTAU+oylVWJ
 8gW/6xoto6gx7ycJTH8Yiq8wLSHjMCUJ10IDEZQDHEKCJmTTCwCwn/vfBTwye0WRF9vfGl
 1iMlXVysDYykhcuw+/bJZcHyi4oOZRm7cdUc9E2F1G/cc0B3g0TuIl56BoewQUrKS3cofl
 JnhZz82s1Du1RAXFt8TtxQKTpE8Wu4+82T41XkIzc8+8G2CPaHpn1nQwqUBrFVdOYMtiPN
 OoTphnFoyQ78ullUvcswO7LmeYGia8eymtME6o3K2FfzhRLtuB+G/QIljrxJWw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711045530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=EHsy/84rN7um0ftMkIcc4SfWPb4XNi46oqX/4TCOY/4=;
 b=yn8N43YZPG5kW+FR2CdeOwQTVYEXkaEycpOSemzYcy07P/nNXPGrsab+WiBJMkh+M4TcCw
 h7SCtvxMD493A6IjbCF9WK/8Kjr8E32ehbFSPuDFI+S1O0vFrDNQVrNYliAUTSyHWPgJGS
 ApD9HZNpXGZiwvUZO4TLayDM6lrHrY+ieUf/B3LTVNqmCbaiYqFRG+tljWxEsC0SjOG52/
 0DAfV8vCv2gTG3MPa//b0zTbw2FFWi64TFFH9/5UXXsOVck3ZmF4OIniZOiwAMLIz3o5La
 BSFOBikM6gtMwqL1EbN0MGcICLooExxYM2acFw/qgDDycyagVveVP6c842b5ZQ==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-nszwx;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Tasty-Wipe: 1681afd00012d697_1711045531886_3739279554
X-MC-Loop-Signature: 1711045531885:2984293667
X-MC-Ingress-Time: 1711045531885
Received: from outbound5h.eu.mailhop.org (outbound5h.eu.mailhop.org
 [18.156.94.234]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.127.222.112 (trex/6.9.2); Thu, 21 Mar 2024 18:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711045414; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=PTpRsjd2bdAXMz9vMisPT4yTf2KQtuKU57alzJg8ljdux9a00vEa53ggTWxG2myhk0Wc2+NjYqRBh
 oxsr/VPOG/VvMN9y39KstB38BZDtWFcnk3utNTv2XmZ998WOaAnHU649V5Q8HAABkH4LMshK7Wq5+E
 HTeo711Io+7zuqtuvk9Cu6ScG/NTQgTYZwfBzv2GbwYNVcbLbR1A5Rp73K0A1rvIWFOFdWGx41Ukt1
 /4hFJ2grvsJkzjwd45dABNXlbjszRhZ+qHy7gbeDSQsaJZN295leRVnwg5flWRvx1PGs3kKrZxF5OT
 wRYIYpGsD1HkP/+Y/aNEF2Vx8KFtjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=EHsy/84rN7um0ftMkIcc4SfWPb4XNi46oqX/4TCOY/4=;
 b=hP2RTTvAolzIxv1Za7QcSkC37pd6lAJ/SLuE6vHaSHC6HLeEXmiz9mvyjKJw61JanBzb75OXhOb4f
 M+Nlaly/51SXWAW9TJeM+9ZTBVFqTpu2+gTYF8k1uwUEja42yabMKhM9s4fT/MLG2GxCQ9oMkLB3fE
 bbO7AQJPeAY5KuVQe2gxB6tiYrE/8raOK2OqKFxZHaVVLs4tZSCn2WQ9zYDo3Ve0kKfmVynr1aQXAG
 uPgDTnLsnADv/tMgS060v89k/M0rYqDYOR0gxpS06CNeVqPv00JJrLky8d8jkIxTo7BoBf10MpfU0q
 YHFwgc62fXj9Szp7aT5jhn04u8BL5og==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=ao5Edf6g; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=EHsy/84rN7um0ftMkIcc4SfWPb4XNi46oqX/4TCOY/4=;
 b=g0A5eDmjlUisQshEHus2EqrCL0rCXjZP1KeoH+YJiR0sX1NYuERtPhpg/TY8Xm1p5CXHlemeDWQTf
 zIa3kMESNNJ+Exe202K5OhpPr7N+ydEg8jN3ixaxHGK3rqryXSlwtm1NfmvCWCNccA8R7MtImvXlc3
 r8RAga+A/bcKDES0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=EHsy/84rN7um0ftMkIcc4SfWPb4XNi46oqX/4TCOY/4=;
 b=QU1UTHKoZgh5kNgYnyx0kl2g2UqVLEzS3i/JnWhMRqILqwGiBPHe0rGg+QMLhhd0OR8qixmbgWYO0
 bch0ZdQFvYQd315P/efmYVnpEOqHvj2JQub9MJqknY5LsKWjepzaOGeXuofYB3aCuYoSOluUA+fUaw
 liGt5a7PwLqGORUYdo54KtonzLNkJc0g5FLNM/sbg+oScg3skKclD/auBJpVW7iVTE1sqKffbcqqyf
 vHAJRNBWGlfZ2mCzlmnN0/On8E7O/LCHz++VGWZgo9erh9wydBNJR+pPUE2E6ZN5gF7At5p447URaO
 3FBulpe6KpZMGcuR7MWWxHSDioblJtg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 1d87788a-e7b0-11ee-b80f-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 1d87788a-e7b0-11ee-b80f-9b9d9be6ef2c;
 Thu, 21 Mar 2024 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EHsy/84rN7um0ftMkIcc4SfWPb4XNi46oqX/4TCOY/4=; b=ao5Edf6gGpOFW5sDZS26HR8un0
 7BwGe/UymLs5eyZY+OBomgS7j83NY1COocoba+YvrGKT6UnQ+q6P01CRVOD79mkPZXW7Mulg65Lnt
 67pZmZkYtvtRG3yrOZzTWxh2+OSHT0GVscs5hr6hZArV7kfhgb2hhzNl+dn0ET8YVQoLCAwtqxDUs
 3WMbRBsb9h3UVXAZNQeHTPRTytyYACvGmblGQWP6YC8wC4Gr87qblz8ezfzLUeUbwjEU51wbFFdHb
 nFBcjotHAATcTZX86QXVxaLKY1EXaO5xKL9SiyTgpifC5UWgmKqIFLqEnBEriBj8vfw5mjQsjFr7w
 /z0wMG0A==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rnN6Q-004u96-2n;
 Thu, 21 Mar 2024 19:25:22 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/9] target/hppa fixes for 9.0
In-Reply-To: <812ed94a-1231-492c-bcbb-60a72c059eb4@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 21 Mar 2024 20:06:33 +0300")
References: <20240320003223.554145-1-richard.henderson@linaro.org>
 <812ed94a-1231-492c-bcbb-60a72c059eb4@tls.msk.ru>
Date: Thu, 21 Mar 2024 19:25:21 +0100
Message-ID: <87cyrnmoha.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 20.03.2024 03:32, Richard Henderson :
>
>> Richard Henderson (3):
>>        target/hppa: Fix assemble_16 insns for wide mode
>>        target/hppa: Fix assemble_11a insns for wide mode
>>        target/hppa: Fix assemble_12a insns for wide mode
>> Sven Schnelle (6):
>>        target/hppa: ldcw,s uses static shift of 3
>>        target/hppa: fix shrp for wide mode
>>        target/hppa: fix access_id check
>>        target/hppa: exit tb on flush cache instructions
>>        target/hppa: mask privilege bits in mfia
>>        target/hppa: fix do_stdby_e()
>
> Is it all -stable material (when appropriate)?

I'd say yes.

