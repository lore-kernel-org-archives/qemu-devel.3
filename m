Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71536C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 06:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rodo6-0000ca-RW; Mon, 25 Mar 2024 02:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rodnw-0000cD-TQ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:27:34 -0400
Received: from cat.oak.relay.mailchannels.net ([23.83.215.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rodnt-0000hC-Ii
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:27:32 -0400
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 4C8725024E0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:27:27 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id BF0CF502536
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:27:06 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711348027; a=rsa-sha256;
 cv=pass;
 b=rwNMEHb/xztwZQFbszbItrJQy2Wm8233DTNMw53hCzKW7FVxoAVdf1ptyX46DZiEGGJADr
 9sMkfoRksW5c9JfZSLc6U/pIdBGcdD8EMTo6llO4enoWKQSZuLik2DRumyPCtieBw+YVDj
 zwSDPIA8qHM4GlXC+WC+Koy2uzBiLVqGVFJbIRCHIo1oNEIvHVDpI+Kcy8YkGjCgN+2jB5
 9jNXuss//JhH4Aa26nckSstE+OhhJ8YAZrLenr9fqL+xOYVbCv8VUpRl364aBQ2KLNmkHc
 4maLA/ehukAwGLsVhdFSU6oQJWLKiwsqvuyWqkx3djK2a/sQSf7owR40EDuCrA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711348027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=fxsfjUJ3SS7G27kDHJP891WrfbPyd7rtaLFNfNJmYeY=;
 b=vqyDFjrNHJqsmGcRs92aGF+eg1aovlxfiW8gWbrgO2gPmog82WMN8OOx8Ou1C8RU0Hpu6L
 nCrMA85kU7G/F9VAm/Yrlv7j+xmPNWjxlTH8yiXszYYUIZ/oSC0UQ1svW56dxAts9ThrWq
 DP3m/exUmj2Mx6GdJ6sO5LhFkA5R2bgClWjg6P0sVxv5eoSddFYlsTUcjjoDaRu+LYPSyT
 48a15qf+ms7iw2SutUPPoeXEeRLELYzsc/3el+Uitu+82xuukDSo0q5DFMwgMqa4H+rwcP
 UrBidvsS2kremJOKKDGDDn+0pHbYAkkmwvfJqxvAokOAYfm7KgzS1bx02JPaFg==
ARC-Authentication-Results: i=2; rspamd-6c65898bb7-hnzvm;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.187.25 (trex/6.9.2); Mon, 25 Mar 2024 06:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711347989; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Sgth5Dkn8WFi/ZUxRDL8wLJmpJ81Ok6nsvmLPB85c+7Ib1KJEOk7RfDmzu1hokUqGBuGHS7xmcqhA
 FHIslTPEM6WLnBkZrgyPzXlGbPWvRhfA5N9W1274K1A0kh9Ln7xC0IzfhLcT0y3gDpNgKx2spOEP9i
 Wok9pCBo+foSZXTmToe6fEU0JzC4YXUHFAwO5yo3TvDY6qjxyRtx959DCYmCPhsullzjgKTnqDM8vU
 EzJSKhDLAR1o3CXeZdO6ZtUvRikmErCjGTCSK0uA36USaqavTopr117wbyY4sc2hwp7xqhqFkMU/52
 DF51NZIx1fPujt3QOTEv+9L5u4N7CxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=fxsfjUJ3SS7G27kDHJP891WrfbPyd7rtaLFNfNJmYeY=;
 b=o8C/9lbbIq5NwRiOFOpCGHx2bJz2QENsurM7s9crTNktrzB/pp4Y7NN/kv4V7BWnyiDbKbXdMZAFn
 s3nOUnrH7j5zPdj8hdY7sK/K4sPf9WwCe/54KpGIreSLQ1a621DL7r8ClmZM4oHsj5OJsTMAVUTLvD
 0VfTPBurpEOnjfbuM4azz3s6gS9t+l0MWIGklmMYXMrmMwN/G5Hg9/jLQT7QB5y5Csw3YJsLWW2ke+
 shOYQOSdPLM6EIIyivCmRMJTb9AfIkoLT2aTNQvWFnSBhY39k37im1ljP2XZbr6mh5RpSu7Vw84+Js
 gqK8ET+tDOxiz/vi2NrkaNOxHb4bdaA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=E8tf1syL; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=fxsfjUJ3SS7G27kDHJP891WrfbPyd7rtaLFNfNJmYeY=;
 b=USB46T0qOw5v+Wjs2em8FoCul6ZN7p4U6uJOKBZY+p3yRZahvPlXU+ao0MDhWZZQBjWCof6qXpxSU
 yyKkgISC6EWj+hFZLly0NHQyj/4ft3WeGsgLSs0NsGHpuOka729LSB7TJ72wKLqgUS9dlK6WTRlTyj
 pycmMmpOnp7XmUW0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=fxsfjUJ3SS7G27kDHJP891WrfbPyd7rtaLFNfNJmYeY=;
 b=caYPMBACtmY70aLCMelUAXF8CVR4H219xK8pMf0qdpr01UxMnYmWJ7oUtobNJ7BOFzfJxDGKnh/ad
 xK5FIcD16R9XwOFcInCLmrbHwxO3bHRx2eEAKcB8LPnKD5wOnzcE/UPyBP3cS87nq7VgEA682Ocdra
 IAf/zgUFHJqeLpbgFuoR6XsXZ5+bIIj6Ouz7J+64sk1CeuRaf03PicKQ4TJTEi3wlAtDJOLXGnjGFg
 kQF5Srx8wm0U0DcJ5FPFSwm7NmJR5ovnwOXXhi+7GHShwiqFIRZ//UW/T4scNjrz56kV2lyEtlQVTm
 KMn1E9s4YfPC0h2smQH9WR31GK4kSyg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 9b943666-ea70-11ee-b288-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 9b943666-ea70-11ee-b288-eda7e384987e;
 Mon, 25 Mar 2024 06:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fxsfjUJ3SS7G27kDHJP891WrfbPyd7rtaLFNfNJmYeY=; b=E8tf1syLsu+5U7VgAUup/Pne8x
 dZuXkrgcFqNdrZI/PxXKt9wuAazgnh0Anj8+apQpEmYaqLhpMouGXFXKH0pI6UT0QrLZ1inCYFfmC
 gM1IhkkKekIwrpzJEhWmMbF9BKdN+ed2YK1ttiODWJ98kE+KaUdy+ylZOK2RU+dbMP9axFUQ55wvg
 dnlUjhF+SFCY3709GT+AYaNHFUB5qfgxzboiDvch/xGrSSzuIjt3ZZpPHTvypvCnAcVhOfpPxfl8p
 GlglwedCxG7+ZnoC6+gYC4ChNsLc7ibRubsCB5Q5F7psMABsLTOHisZtWn3xbQlx25DsfE1Y6VzYd
 5xKGzUmA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rodnS-005UV5-0J;
 Mon, 25 Mar 2024 07:27:02 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
In-Reply-To: <7785c89b-95eb-4b56-8fbd-5f14fba7de08@linaro.org> (Richard
 Henderson's message of "Sun, 24 Mar 2024 13:14:34 -1000")
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
 <87o7b31nhj.fsf@t14.stackframe.org>
 <7785c89b-95eb-4b56-8fbd-5f14fba7de08@linaro.org>
Date: Mon, 25 Mar 2024 07:27:00 +0100
Message-ID: <87h6gu25e3.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.215.31; envelope-from=svens@stackframe.org;
 helo=cat.oak.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 3/24/24 08:41, Sven Schnelle wrote:
>> 7f09e0: val=000fffb0301fffff r2=110e0f0000000001 r1=01fffffffffff600 phys=fffffffffffb0000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
>> 'val' is the value constructed from IOR/ISR,
>
> Is this byte swapped in some weird way?  I do not see how 'val'
> corresponds to any of the addresses we're talking about.  From here,
> the string "301fffff" appears to an out-of-context grep hit.

It's just both values combined together, where the 301fffff is basically
the ISR content. It's not a out of context grep - the real machines i have
are constructing the same value, and the same offset into the pagetable.
I verified that by patching the DTLB miss handler in HPUX to write the
ISR/IOR and calulated pagetable offset/value to PAGE0 and looked with
the kernel debugger at the values.

