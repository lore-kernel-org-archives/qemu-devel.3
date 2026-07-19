Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816ABC44521
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 14:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlSjK-0004TX-TL; Sun, 19 Jul 2026 10:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wlSjJ-0004TK-Az; Sun, 19 Jul 2026 10:42:57 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wlSjH-0003KM-8C; Sun, 19 Jul 2026 10:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=lvZiJKE
 BDwnHjMKueWK2arO9oujjQBayJhihmkUHpnntQ0nCcBDsELtiezvIsmhtMZLM9aAh0/eAJ
 6/Y1SyN77nd0APQoLt4DCyV9OKicFNf62eT5djLtENTIo/fCss1Ch6OuGxgDT5Puoa8F5X
 E004kKwYe6uODYbqDbO0IdgcjEru0AT1hY+XGD0y0xYKnvAJdm4xlaJbFTQgJEZDWuSBd1
 NEFnGC1pHkSRu4jDzI60SJ3lcqfsrq9OgFLi3OuA6u2G6BDejv0FbETxeBSTy4bwr76w/Y
 t3qZO1Ok58cP8uk4HaaHkSv7lESWAod4j5WvhYP9PGwlr6wDGbtMgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=w
 +QgTrgozqx2mqFhlOj3soekEXgWBP5LbuMq+6YYnyA=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=wo5ChizuDcaO7THQczKB8nCqUMKS21g9lAdgJrswKqHQ+qpBaz2+5nEwhjjvweG7RhWf
 NBxEC/tqPRvIyjnm/0f1V0lk6qkOyJWc03iQvWfG4GWoUZaR5iJKTarCvTXU8B5c9en6WG
 B9jtKv7FExUmmsMrTZCGIh5kMqnGVXRYYzPscPxKDWaWtnCkS0KzqT4HAMwF7vpE9pBsnN
 X03p9/vR6dqDVDr4QvdPFfTZHwUyuVQ9hrnyWyjkwCvXayetEy8ouqvYxXbDImu9XpCpZ/
 IUmnjk1SaeFnocpj3IywPD2HHRNRcjIGLA+qIZRPOjL64x3Q6JZX5XgA0waYUPWg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=sIMuSV/X; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=e54USCeP;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=w+QgTrgo
 zqx2mqFhlOj3soekEXgWBP5LbuMq+6YYnyA=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=sIMuSV/XJV1kPdmXBvpZoRAQ6pEtBQ
 XWzEXKTJ+lrI9K9uddFbDYa0AA2uyKbfS1uDRVbeqJedGLq58c0OcZRz8iaT9uLC9jTIJQ
 sJee7T//j325TnF3SOTirTAZMv5C+UEM9wIvWf/H5UUhrsrM/sYTZhziaF1HmObjAc2JHi
 9TigsTKupw/dBiz14jiXMZrdB/69yZ3EQcYnCilyyZYr6bqOJjPskuAUgBpYAppbpBwgk7
 NHcMTg1bIp7oObJtF/B26eueoKWxffBTK4sbubDdY0P2Xdx+n158GEZOytVCz1Cg1mNgBQ
 D5rVNA1rYk6PNH5E0mEW8+tuf8/gF55A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=w+QgTrgozqx2mqFhlOj3soekEXgWBP5LbuMq+6YYnyA=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=e54USCePONld0PfawN
 C/lNUpOySEv+D2lNDFBOpiotxAc9hjImJE+SE2aF6C9GAzgqm7Ktpqx4hUZZWF8AgzCg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 0840d681
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 19 Jul 2026 16:42:49 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id e4f46a35;
 Sun, 19 Jul 2026 16:42:47 +0200 (CEST)
Date: Sun, 19 Jul 2026 16:42:47 +0200
Message-ID: <87qzkzujko.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: adityag@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, brad@comstyle.com
Subject: Re: [PATCH v3] powernv: boot OpenBSD on POWER9
In-Reply-To: <01f03069db4b48499c0f138e8afa9b0971e863b4.camel@linux.ibm.com>
References: <20260702130152.89334-2-kirill@korins.ky>
 <a52771d5-0179-48de-a0e3-eac95192b789@linux.ibm.com>
 <871pdkmdd3.wl-kirill@korins.ky>
 <01f03069db4b48499c0f138e8afa9b0971e863b4.camel@linux.ibm.com>
User-Agent: Wanderlust
Mail-Followup-To: shivangu@linux.ibm.com, adityag@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, rathc@linux.ibm.com, brad@comstyle.com,
 "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 06 Jul 2026 10:36:57 +0200,
Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
> 
> On Fri, 2026-07-03 at 15:06 +0200, Kirill A.Korinsky wrote:
> > I have no idea why OpenBSD does it but I see in powerpc64's pmap.c:
> > 
> > #define PATMEMSZ	(64 * 1024)
> > #define PATSIZE		(ffs(PATMEMSZ) - 12)
> Hi,
> 
> This seems like a bug in openbsd to me.
> PowerISAv3.1 under PTCR says,
> 	
> 
> 	4:51 PATB  | Partition Table Base
> 	59:63 PATS | Partition Table Size=2^12+PATS , PATS≤24
> 
> I think the developer was perhaps wanted a LOG2 functions instead of
> ffs (which is just LOG2, but 1-indexed). IMO, this should better
> handled on OS side.
> 

Thanks, OpenBSD was fixed:

https://marc.info/?l=openbsd-cvs&m=178436960888757&w=2

I'll send new version of original diff shortly.

-- 
wbr, Kirill

