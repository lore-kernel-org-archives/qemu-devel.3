Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7771AC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 19:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo4y2-0005Ew-8h; Sun, 26 Jul 2026 15:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wo4y1-0005Ej-0H
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:56:57 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wo4xz-00077H-8X
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:56:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=VH0mq84
 xV3Em6cXL+M+fyZ+F3iqdHk/y2RIDSAFCib6BiwwjK9vXd9WwwW8+wxtw2a7diMqMworaP
 6qQj+9qUFqbzulP9hRTMRzSOxXSHpmTreAMcJkOK/7QqHVK3UO2zCe+cjF02thIu+ayCP/
 qgA47d68YWcuar6b9TXKpXv7XEpkh/Y9sndX/yvoJCOc1J1A7CGwPaqAZ3r0ek5yJg/1P5
 jLlFyAUNd6PLITq00F8/gv2LqDWamTQsCch4G7Qd3+0wtwg+BHOj6A+Y4d+WeH+LOnOXRY
 O5yrfarh4UWdsXZVuT/70g0V30TMLZL7nOJjsg8wdcsJiCR32XBi3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=G
 2acbE4KFHwzZNarUeihxqKZiMasGHiZjoGibupQcfU=;
 h=in-reply-to:subject:cc:
 to:from:date:dkim-signature:dkim-signature; d=mx.catap.net; b=SwGurWip
 b0iyfHF1IlBq2nJHBkOSOTjB8dpn80ZGTL0eiWy6d7kisx/0wpoV/yFpb0RPO/zMg09Ryo
 aGIqekwnBrNYJ7igcAPlKD01eMARWbipY0GmtA/RE1hMcBYCUF7sz2eftBYS/HU80JNq7m
 G62bsg/U2yDyWJ2VPEVO9o2zScrxaAgbaGI29Rc0nvr1RA/lktkS/3CeKyzjSwp0A5MNJd
 4zCQxs6Wz7545EVI73fryAOqdlr2pvj5ffAcgUaiplWtVP1DtpuBzmAzzla+z7xLsQg01V
 VCVAD1K5029pcjPYMjR9vLoh/LszyB3j37NawYojuaXvAvXBHsoHrg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=TE5e0Pj1; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=OOWYWaLD;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=G2acbE4K
 FHwzZNarUeihxqKZiMasGHiZjoGibupQcfU=;
 h=in-reply-to:subject:cc:to:
 from:date; d=korins.ky; b=TE5e0Pj1BV9eetZQ5I3/qW5NnpeLgiby7g0f/iBAn1D8
 uA7rhBTN7n73xiEAKr/9HsVEFdCpkcwt3CMSbdzlbG1UzvTKQv8C8zlUgnlHFwim7ikZOf
 FWfQTmyfNENMhLiik3/DzEJMuagw1XuRE+9bzmqWRymy88/aFjDtzBvt/TESx/jAYk5F6m
 2kx2kHM5Gq/nskpeAYVNKP5r9rqWMf7xpWLR7yf8LtFpfA1WQ5nZvYtYSel2Wo6wDx6J9Y
 a/Qrtwpbx31hBynEi6mSBz5rbeY3FeNx5M2SGyNjg5Ysgbo2JZzrd15pHtMkApbbJy20SJ
 TeUVvCo86ks3xjOypg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=G2acbE4KFHwzZNarUeihxqKZiMasGHiZjoGibupQcfU=; h=in-reply-to:
 subject:cc:to:from:date; d=korins.ky; b=OOWYWaLD9NiQSMcLJo9VO3OLjlapv3
 01+F4PbGaZNd70jXjbfZk0uyPef6UDHzHQwqL1as+yjnJwuWGjQ5MTCQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 20b87369
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 26 Jul 2026 21:56:50 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id 87ec9d3f;
 Sun, 26 Jul 2026 21:56:48 +0200 (CEST)
Date: Sun, 26 Jul 2026 21:56:48 +0200
Message-ID: <87ik61le2n.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: kirill@korins.ky
Subject: Re: [PATCH v2 0/25] hw/mips: add Octeon III EBB7304 support
In-Reply-To: 20260715134351.82007-1-kirill@korins.ky
User-Agent: Wanderlust
Mail-Followup-To: qemu-devel@nongnu.org,
	kirill@korins.ky
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


> The OpenBSD boot and USB stress testing used Philippe Mathieu-Daudé's
> suggested xHCI change which clears ERDP_EHB after a successful interrupt
> callback: https://marc.info/?l=qemu-devel&m=178402329968274&w=2
> 
> That one-line change is kept in the development branch and is not part
> of this series. With it applied, a full cvs -Q checkout of the OpenBSD
> ports tree to USB storage completed without a stall.

I'd like to clarify that non of these workaround solves issue the long term.

From antoher hand this fix:
https://marc.info/?l=qemu-devel&m=178449808743198&w=2

allows to run qemu machine for more than a week without any issues, when
machine was heavy used by IO and multiple gcc builds.

-- 
wbr, Kirill

