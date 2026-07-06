Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5443DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpUJ-00072h-Qt; Mon, 06 Jul 2026 16:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wgpUH-00071F-JZ; Mon, 06 Jul 2026 16:00:17 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wgpUE-0005MQ-Uj; Mon, 06 Jul 2026 16:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=pmCrpYc
 Fb1aUBJg8h+oLanZJXNAGszCa8jK5Bw71TmVWi4YfUZUc4F3uxkbjPAD6o+CpvrKdUAIHz
 /EK3qt4hRuIDvY7LDm2R6BXQZ6x0OIIY84kIOnrtA/UoGIvQ5xZtzI6ASVvF1Ub1DAuMKq
 TGfM+sU4OiMWONFVWAcJL+EFw2e4uLB1XKk3uDot/5SIJkFAfHLhVhfvxzuiBL81E6XU+o
 MD1JhmsQaaTFz2H3cOArc1lSugfoSCl3j0dsfkr92OMcRBDxwDlnhVXX8YaikmD3YQNkcx
 vxUmt7tFwdom8jBho6bAdM5AS34UCmTGvOGP3Gaj825nBuhjxwaKODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=4
 2kQYdU1lBBtINcFi4QdcPbLocDX8Le6vS/pcXKohC0=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=dkscLFUJb+0wvXMSeCROCaJgDwha2vvoxG3zFVCxGM3futf5/lFtriXmCaQSdjxuX4TW
 bohFTZcg3pE0+g0siVrGA1ZTBLIEET5id32yhfh79c6FPwGqpBcYp3xmoLTAYcew0iGUia
 bOl4Dhbg/GHIu6kbGi5cucs+AE5+8reC7fMqiH19zLhlOyMXf4eZpJVTJxwkAoH1eK+/1r
 Ge1JsBacE6+7RaUNHKgDFo9wJlGt8np/GsJU7N+WF74eOMGf4lv2Po0K16rClSrXgT35kQ
 2BpwYkLgWAcWKmf5dssTO2t1Xa8GP4z2JfFDjRqNCDdcKtJeuXn4J3uaB+zFS9cQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=gVuv6NlS; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=BJCsqqOG;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=42kQYdU1
 lBBtINcFi4QdcPbLocDX8Le6vS/pcXKohC0=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=gVuv6NlS+oS+DEQfuqC/S5P/m5J8Ie
 kq0WSJLpZACgJ2cLQ8nzgW8b8X+ty5BqLoUBfHjNLHFp0FaWD3qk5h0u43jos5lBtVJcW/
 5b2MMMiX4aLkk1oEyKfnMGC25yG316VecCgFpdQ4SQI7zgV2VgY1kkRF+A4T/55eVaXm6D
 G1S6eU9PMoSlfhbdLbixy0VK+461P0eCPKt17O4p2aYi8/0b65T35pOmNWqI5OTV8uBGoB
 n0MeJDaHwmkCpFlHRdNrssJUPwCCplx/sHuFG7Rwva+QQBuqWrh1NkQ6yljqZidCbYsvtD
 4IzkLbd9XPj+JluejY7xCj/Mzksy8VUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=42kQYdU1lBBtINcFi4QdcPbLocDX8Le6vS/pcXKohC0=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=BJCsqqOGnjnfWFkclI
 jOe4CfpgMOy8ygBZc9w7QwUF7cVv+ObMFKfN+5x74wxudHVb0lPJHdnqqgxAQ6wHhcDA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 0fa9252d
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 6 Jul 2026 22:00:08 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id d20ebc7c;
 Mon, 6 Jul 2026 22:00:06 +0200 (CEST)
Date: Mon, 06 Jul 2026 22:00:06 +0200
Message-ID: <87wlv73n3t.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: kettenis@openbsd.org, Shivang Upadhyay <shivangu@linux.ibm.com>
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
Mail-Followup-To: kettenis@openbsd.org, shivangu@linux.ibm.com,
 adityag@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, brad@comstyle.com,
 Kirill A. Korinsky <kirill@korins.ky>
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
> Thanks.
>

I'd like to add Mark to the loop who is the author of that code.

> > 
> > which was introduced by this commit:
> > https://github.com/openbsd/src/commit/dfe2a24332fd6769a7f9bb5806753189dae4d9c9
> > 
> > --
> 

-- 
wbr, Kirill

