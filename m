Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6CFC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x67CH-0000mQ-SL; Mon, 14 Sep 2026 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x67C4-0000kS-C5; Mon, 14 Sep 2026 09:58:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x67C1-0001Kj-DO; Mon, 14 Sep 2026 09:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789394226; bh=6lYLZsszSiCgxeQWbyMitOWO+G1NEcJPneoZgAYb4R0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pis5EjJULDXnLtDnkvcumPCjlA2G1xgWyd0e49Vw+2Ouvv/f6K/vOT4J8Dm8WgcZ9
 dzYvX1xsBM/2EmoBj2zC/9npNLc2+ZzIzXwkikmPOuzt7h0Oo6D3f7+GJgZU5BGDPS
 fhqADbytdSCBprHtObdO/iU13K//Gnksrcr/eBRttfZVw5GlQ+H183ggnQx41ibd22
 WVE68YRYKOrILrYNY0I4FqTehtx6zpHGxheACjMIwNt6vbsS0qZk3/ccddnMrAdA6c
 liryUWcGIz3KicctcKBeYeh3oL57TrdOA/TYnB/f6HUeIHlSMZMNQWd7k1mSaAAQxT
 x6StIamgbvd2w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 41BAD1D4D4B;
 Mon, 14 Sep 2026 16:57:06 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 408874280F4;
 Mon, 14 Sep 2026 16:57:45 +0300 (MSK)
Message-ID: <320463c3-973e-47cb-aa9f-153816a1b4c8@tls.msk.ru>
Date: Mon, 14 Sep 2026 16:57:45 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest
 addresses in qxl_post_load
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@oss.qualcomm.com, den@openvz.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/25/26 20:20, Andrey Drobyshev wrote:
> We've experienced crashes when spice-server aborts on migration target
> when processing an invalid/stale guest address pointer.  While those are
> hard to reproduce, it seems they can be fairly easily avoided by simply
> skipping commands with invalid addresses in qxl_post_load.
> 
> Andrey Drobyshev (3):
>    hw/display/qxl: factor out qxl_guest_phys2virt()
>    hw/display/qxl: validate replayed commands in qxl_post_load
>    hw/display/qxl: trace skipped stale loadvm commands
> 
>   hw/display/qxl.c        | 132 +++++++++++++++++++++++++++++-----------
>   hw/display/trace-events |   1 +
>   2 files changed, 97 insertions(+), 36 deletions(-)
Hi!

Is this a qemu-stable material?  Or there's no need to bother?

Thanks,

/mjt

