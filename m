Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF7C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAB8u-0005oB-Jv; Fri, 25 Sep 2026 14:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xAB8t-0005nh-0u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 14:59:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xAB8r-0006XV-Ju
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 14:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790362767; bh=i7fn1iCiNxulUkl6FZl6ax7J/bLeBm22bmMz6yakAw8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cwjtkLopiIQGBTDiLjjatqObEaXsKVd3Z5vYLV89NX+FU8n+FocBc20Fpt3gaZhaX
 mY+OdLQ9FIBK8vfJIvMMb5sU0h0ENzjLeK+cxXMLmHxeRO3ba65tBrEjYFFRkwIZF6
 9nBwodxhnShdC7iAOBqFzejaVYGfzotpW8Zxm8RyoyXSoAo7loyMx/k5QyQD7x5QZI
 2icuVS2q+6CsghOQGFuVZC08nad48Q1pF4RtgL91sZMi8e/1m+kS9z36HXsfPtyXXT
 KDS4cIWQH2G3+o9ubbBvobL8t8pwsRh7SuD/WLTU4rUVsarjyhfcsPXkrtpglH/fXt
 z0Gv561ShxeqA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 80CA61D86C8;
 Fri, 25 Sep 2026 21:59:27 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 515D1430D37;
 Fri, 25 Sep 2026 21:59:27 +0300 (MSK)
Message-ID: <0101dce7-773d-44d1-9462-159c38a0a0f6@tls.msk.ru>
Date: Fri, 25 Sep 2026 21:59:27 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] linux-user: report EBADF for setsockopt()/getsockopt() on
 a bad fd
To: Michael Morrell <mmorrell@tachyum.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Shevlyakov <igor@tachyum.com>
References: <20260924193341.2064665-1-mmorrell@tachyum.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260924193341.2064665-1-mmorrell@tachyum.com>
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

On 9/24/26 22:33, Michael Morrell wrote:
> From: Igor Shevlyakov <igor@tachyum.com>
> 
> The kernel looks the fd up before validating the rest of the call, so a
> negative fd is EBADF whatever else is wrong with the arguments.  Several
> arms of do_setsockopt()/do_getsockopt() reject optlen or optname and
> return without ever reaching the host syscall, so the host never gets to
> supply that EBADF and the guest sees the argument error instead:
> 
>      setsockopt(-1, SOL_TCP, TCP_NODELAY, ptr, 0)    EINVAL, want EBADF
>      setsockopt(-1, 0x4321, 1, ptr, sizeof(int))     ENOPROTOOPT
>      getsockopt(-1, 0x4321, 1, ptr, &len)            EOPNOTSUPP

EBADF is not just -1, it is any number which does not have open FD.
Yes, -1 is probably most common bug here (passing -1 as fd is a bug
in the user program), but it is definitely not everything.

Thanks,

/mjt

