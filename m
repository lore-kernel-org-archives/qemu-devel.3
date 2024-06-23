Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B014C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 21:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLUkU-0001C5-0e; Sun, 23 Jun 2024 17:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sLUkR-0001Bp-NA
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 17:27:44 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sLUkP-0000mU-KG
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 17:27:43 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id B58D140762DA;
 Sun, 23 Jun 2024 21:27:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B58D140762DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1719178053;
 bh=C5+dB+xMQdIiE72UR9RqRn3TuxKfOQegvntPl/8vL34=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=tJlUeXKpkMYweWrbHTzN3LimRy4rPXJ5Z7UwdcC9jJQQ0ioGGGHrN4RaGaIe8jkBJ
 Kx6gE47SQ6HOrRgYtTpJhEu6f8rGtEwoip7TCrhg5nvPh1OEG/DtxUQrbPWR+S74Q8
 UN4ljqD6aPB5/YtPxmh32PRK07LzRG14WxOXN9I0=
Date: Mon, 24 Jun 2024 00:27:33 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
Message-ID: <972212d2-969d-263c-1ae0-84409703a8ce@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hello,

On Wed, 12 Jun 2024, Paolo Bonzini wrote:

> I didn't do this because of RHEL9, I did it because it's silly that
> QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
> compute the x86 parity flag (and POPCNT was introduced at the same
> time as SSE4.2).

I do not see where the 2% figure is coming from: even considering that
the 256-byte LUT may take an extra cache line due to misalignment, 320
bytes is still less than 1% of 32KB L1D size.

More importantly, the way this comment is phrased made me think that Qemu
eagerly computes PF. But the comment in target/i386/cpu.h is saying that
all flags are computed in an on-demand manner. Considering that software
pretty much never uses PF, why would the parity table be resident in L1D?
As far as I can see, the cost is rather a cache miss and perhaps a TLB miss
when PF is computed (mostly when EFLAGS are accessed all together on
context switches I think).

Is there something I'm not seeing?

Thanks.
Alexander

