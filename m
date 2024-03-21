Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEF5C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOke-0002QP-CE; Thu, 21 Mar 2024 16:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnOka-0002QA-Pu
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:10:56 -0400
Received: from bee.elm.relay.mailchannels.net ([23.83.212.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnOkZ-0006AT-6X
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:10:56 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 755DDC3FEF
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 20:10:53 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id C5057C3FE1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 20:10:52 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711051853; a=rsa-sha256;
 cv=pass;
 b=hq1X0kESEE0k6qADZS1yYAnEXuP0atIe1HHX/elZKWjRtKOXf/jR28HS71ZIEqE5fWpkLr
 tlsaSuCdtrVs79LjHA5oR3CvC/astBvPWDtHI+wbKpeBsTTiZ4ngNeC9mqrciWeccLBvS3
 dJgpBXBcJ3yD5Cpmh6yFAHzdRoptqzjjPtNB2+0ceNbHn4/nCCKO6BkA6g/Q/0TalobKON
 r1/yMS9dHXbk8cs9FY+jbW7nuANUcNDkKnj8p4T2abyseDAf7ZYk7EbX3cMJ2bXAU3lUdO
 +UjVD/HCXQZHWfLFQ5daYhqJjJGeX/RNyU5Lj40CXeJln0vouVpLZE0s8mbGLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711051853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=jLguDTnPXwAV3a+4iFDAPfNALK/NGMkTKnrXZ4StBM0=;
 b=zjUKgVUITWtJwwGHBxVy6UhfwMmjFvUOSoZspvy+9GIBmCeZDsS73TyAcz6+Rcx4PDJJw1
 GoyY9nxb5W7MgAlNmcyJoB8RcRfyZRu5AEfbJgaa4ex7BDX09YjMPFpWLNr9RHY2J5zvKt
 3R6i7SR97RvYGwCjUlCL61pt4wPVPn+0foFq8gLefk67af3vXiIBH/MCCkDbt/Ot8N6S7k
 k1mBg5eYeewgZreAwVfANTvenQeKVAU11ZRP5Yv4paVv/H+BSJ0MZm36svv2SLI3vASF3E
 n62HHqDvz++KQCozBAzscwV6ZGfs7QhdN4ddJLs719fbJDlo+AlCLsNeRJ2L0Q==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-jnsbj;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Wide-Eyed-Relation: 3c580482670e3633_1711051853309_3442596445
X-MC-Loop-Signature: 1711051853309:461535673
X-MC-Ingress-Time: 1711051853308
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.159.228 (trex/6.9.2); Thu, 21 Mar 2024 20:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711051817; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Rm2KmP+LMDQRhKrRTS1suhYYGL0QQ1XuERkhsMd+7VC1wfQl8wV+CCQQXwhF5qC9s5tz2r4lwGEI4
 MMxewQb1fhURofDmkY1fKdSfPBeYj/jfuXZoBqevZy01TGrvKTQTd70quw/ACePl9PQaKW+iHbzoSV
 54TIjoOvfBqNk0rJ6L38HST/9yBEZckP6zub8VmogsEyQ94PzluOaGPLVL4KfqLO5ON9QWv+O4O8rM
 JlXTBm6PRGrm4L7ZfOkxWRXt3rGdD6WzrRXbEOG7k1gV//IB4MUQYRcYdR8nzDmKUe/XslJL5V6JNk
 nSw/rMWfDxbK6BS4yZUFjB7gVJzlOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=jLguDTnPXwAV3a+4iFDAPfNALK/NGMkTKnrXZ4StBM0=;
 b=HH9sZFlx8TvckxHIIQJtJptJUPdJ5f29JReATUzpL/xEMVhEpVrQbrLTrS+dYL1n8CnF2rYwvQo48
 HR3PglhNRNN7ARrM+IhWdXHkUPReTk+pBWRxNSDxwSH7vHorhPrwswvOaUQ+DCk1wl4ciEfhbXUBPU
 Q8uzi/0/MX7kmZcE+MaGrQ03JMGCNZc6O4NHfiFsJOUbhBgu1rB6bFYWT5VycMAT+Ee910u4KEuF1q
 V/fdsm5PXADh1r/N4giPOnpvOY91s6iQjPMDC5etN6POjrVjL2qRasVkVeqFa9amjAPsx3Y/asKdnM
 mLxMxxlfiV4+niJ0V3qc6QjPhSGK6mg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=gpcbm7sv; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=jLguDTnPXwAV3a+4iFDAPfNALK/NGMkTKnrXZ4StBM0=;
 b=lo+p1qwTp8re6GA0jcNdKHIi6yAzaZbxtTd8bv5iN1SPA6+GVd7wTGq9C4oao+nnc6fgxzQNG2ifZ
 1mzXyHveAgY5/sC6U7Cn0zeux873E45W6wpJcU3LlTAW1ABMC+VeEnIWV0mVbD36UiuWAfoM9Di9MG
 hR8FfUnDz9OCjUwU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=jLguDTnPXwAV3a+4iFDAPfNALK/NGMkTKnrXZ4StBM0=;
 b=cDLq5Ga39zdOC6gXRfKH3p6Xz7JW2MNjFRs46VbOyfu7DWtBJGs7PWQI5ppZHg5MVc0ZPY+yXk2Py
 WDzVqaX7sDPgBGKtqI44v0dEk0OE7Lj0qh5nqBn8+uHd2TnRSVBI0OUaHkvzPs89+Dn5rw0o8oQnij
 Fnx43o/MGTcL5zd4lBtcDM9APUFnKCwYKzS6iCIjOPPp2mNj1PgsnN5HCN3jvpp2Vo4WP7mwYI7Hau
 ek0Xx6oXrq9ifCtN6GBoN8E8KSdK4XJC9WKAQ0aSvdZ2YKLjFIBqb7XP3Mahwbo7otzyZY7NXBrIHM
 X5npcRyvB1Xiusnzfz/pxVlNnY4iOcg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 0747fe52-e7bf-11ee-b21c-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 0747fe52-e7bf-11ee-b21c-eda7e384987e;
 Thu, 21 Mar 2024 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jLguDTnPXwAV3a+4iFDAPfNALK/NGMkTKnrXZ4StBM0=; b=gpcbm7svf1KMl6WKdl36xRxBIg
 l2tK2RKks0Z9Uk6QKAzGeq7as1s9rGD8wvzExA7jSUl3eF8C+/xsWTqmAOlLE0VozW3NBCR/pevSg
 pcqLc9zowx1lFZb/kU65sTCLtPx03Jd1r1nW86rqKQqkK0hgoRcFkqV22ZUnhmO5onCFjZopzX5oZ
 x8FSA0poSy4+GNkkwvR1KnDBY6g6Byky0So5+UQJSrpgRx0hzPc11CwsuyP6eMEvN8DjHTnsTSsKC
 irlKkoIPmNVA4l8pp/LAQRK2mRU3C0bH/IpkeI1ArxzcInaRsCJ6ygWHpn6+zY/uGKTRdJmY8agZs
 K1k00cWg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rnOkS-004uyi-1D;
 Thu, 21 Mar 2024 21:10:48 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/3] target/hppa: add unit conditions for wide mode
In-Reply-To: <134f8055-6b5a-4610-93d3-524d2f3de003@linaro.org> (Richard
 Henderson's message of "Thu, 21 Mar 2024 09:58:05 -1000")
References: <20240321184228.611897-1-svens@stackframe.org>
 <134f8055-6b5a-4610-93d3-524d2f3de003@linaro.org>
Date: Thu, 21 Mar 2024 21:10:47 +0100
Message-ID: <874jczmjlk.fsf@t14.stackframe.org>
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/21/24 08:42, Sven Schnelle wrote:
>> Wide mode provides two more conditions, add them.
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>   target/hppa/translate.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 8a87996fc1..f493e207e1 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -963,11 +963,22 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
>>         switch (cf >> 1) {
>>       case 0: /* never / TR */
>> -    case 1: /* undefined */
>> -    case 5: /* undefined */
>>           cond = cond_make_f();
>>           break;
>>   +    case 1:
>
> Wants a comment for /* SWZ / NWZ */
>
>> +    case 5:
>
> /* SWC / NWC */

Are you going to fix that up, or should i send a v2?

