Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10D5C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eiv-0005Bp-KP; Fri, 18 Sep 2026 15:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x7eip-0005AR-KN; Fri, 18 Sep 2026 15:58:11 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x7ein-0004gW-W4; Fri, 18 Sep 2026 15:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=HpHiUQK
 qA+39MAeLrwWqD44W3+bHotf/YPjcHlWzstSeJi8e5jF/QuYuzAG+Bt3vw9ySUmm+GuaFx
 s1QPGHz4rVWhB8IHqXAKsM5UNBhCsC+Qj+KTK7Bec9tnuTDbrSN0Nr0stz6PcGx1wKiRV2
 WTwIXr62uhJMYA89nwoAjIoQ7Tku6HWqGF6tiEhQf+rvtzaPlsJyWOdO2Z3Ct/zO6b/9r5
 NOXEU/YLiZdRLy91tePOPNR9cKnWkgFezOpbIVKbvx6SH4+Cfvpx2DOv/xXR5inx+zV1a+
 /11XS8weREH26B0tIPc/hyfwEjZI2M8JBkYf4k6fuC7URcxXulArQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=Q
 3oC94hsCElkXImz8Zf7mmH2YJt7SH4HxhLu8/o1TRg=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=A27z+eLn3nB6o7nZCAbAmqE25fN0nGszNQdV8bdz2vaJWkQljXp45hHqLsM9uLF0CL1b
 cMkCsb07K8J4sxbWxkLku99mLj3QVce0c2O0vAwAHwdgSF3m2T2ENDCUjx9wXGWgyhBqNG
 bwZJLKyAqHSxqdJpDQrD5y6DaI8OVP3TsRSNu1VhWaofSAHTp/lL4fdb/l1b9WWHA2tMic
 BR44JBlOY02pbTfyBfhTUAXEO79uJMyYdY/Y7UV0D1WE+0SuMzYdvNhzJKkIHhXLh85S00
 sElZ5EVljZYRlvZPIkk9JgZ/3Zrnnmf8+5oB2NDUk1Bxy4wkmWinx+BzzcoL+Jbg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=pNAqdcxD; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=mwO+0S+C;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Q3oC94hs
 CElkXImz8Zf7mmH2YJt7SH4HxhLu8/o1TRg=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=pNAqdcxDNXCO6iGrolsoIkrMSNPzZM
 W8fqvjwxG5l2vi2EV+sU3dd5VhCiKzZU7VWuTgGp42Kk/TXYIJwpp5JGcKoqOYfxEaOViP
 gi5/LSOTmL3+EdxgtBfABL38iNdbu/91/LDACsZja4a6ReXAxU5UiQtuQLKVALjCYxqB+K
 UFIvnoOwJG32me7HaelJBA6YJ6ZG64cEhPLbcgOFH9N/2ZODvHMGufWpr5psar6a4LVl6J
 eTD6MvLMzEgkHIIeB1+3u9why7n8iMPdi++OQpXG0hXQmeZ7QIPh4kyA3QHsB/DXQG/lq1
 PUkb3dnQUJ3M6cUr2crPb+XDSLon6uBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Q3oC94hsCElkXImz8Zf7mmH2YJt7SH4HxhLu8/o1TRg=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=mwO+0S+CqZO7t80Cp4
 ClwnvC/ILvNFwp0u48/aJ81Y+ej1FqnutK1QfOPvnmoy/FslI8Ia1ZPQc96ohyNdGrBw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 99318a32
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 18 Sep 2026 21:58:07 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) id 71421515;
 Fri, 18 Sep 2026 21:58:05 +0200 (CEST)
Date: Fri, 18 Sep 2026 21:58:05 +0200
Message-ID: <87fqz6uyb6.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 4/5] cuda: Make shift register delay configurable
In-Reply-To: <71fb85ee-3cb8-4201-b470-d481a5b24fb4@ilande.co.uk>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-5-kirill@korins.ky>
 <71fb85ee-3cb8-4201-b470-d481a5b24fb4@ilande.co.uk>
User-Agent: Wanderlust
Mail-Followup-To: mark.cave-ayland@ilande.co.uk, rathc@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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

On Fri, 18 Sep 2026 15:27:09 +0200,
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
> On 03/09/2026 12:50, Kirill A. Korinsky wrote:
> 
> > The CUDA model assumes a 20 microsecond delay before each shift
> > register interrupt. OpenBSD times out during device discovery with that
> > timing, so retain the existing default but allow an override.
> 
> This is curious: 20us is effectively nothing, but we need a slight delay
> otherwise MacOS 9 fails to read from the CUDA device (maybe one day I
> will analyse the code to understand why this is the case).
> 
> Can you explain a bit more why 20us is enough to cause a timeout but only for OpenBSD?
> 

If I recall right it right, it ends that I run Qemu on OpenBSD host and here
hz=100 and ppoll() sleep in host's timeout between ticks. What makes it that
sleep something like 10 or 20 ms.

so, 20us is nothing, but on OpenBSD host it turns to larger value 20-40 ms,
and it was enough to reach a timeout.

This is why I added a way to switch off that delay.

-- 
wbr, Kirill

