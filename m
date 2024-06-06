Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC0C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 16:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFGMf-0005Hs-1r; Thu, 06 Jun 2024 12:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sFGMd-0005Hj-6I
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:53:23 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sFGMa-0004FN-Gg
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:53:22 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 94B8540755CC;
 Thu,  6 Jun 2024 16:52:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 94B8540755CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1717692774;
 bh=2FUUvxvBE/4233kw+C1QcWjP5fOcdEuxYdW/3dUH6yw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=aGub7GloniU+Kq4CyDnjsHY/A3xXTjRqNyZmAy7yyTbo30jxuGPHxOUQAmtNEIE1p
 U/s3G/knkVVAk0Guuf3LxYSCHroGpLpa/pdC70yz23O9L5RGo5o1M9aL/dHagnPPXq
 V1HQAl2faeLGkN7AOHeSBYRVk3u1yYmk3hCl8ibE=
Date: Thu, 6 Jun 2024 19:52:54 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/6] host/i386: require x86-64-v2 ISA
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
Message-ID: <29024a93-5fbf-293b-06e5-bd45b437b49c@ispras.ru>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On Fri, 31 May 2024, Paolo Bonzini wrote:

> x86-64-v2 processors were released in 2008, assume that we have one.
> This provides CMOV on 32-bit processors, and also POPCNT and various
> vector ISA extensions.

If my contributions to recent cleanups and speedups for buffer_is_zero
count for something, I'd like to ask you to reconsider. I do not see
what distribution maintainers (where there's no distro-wide switch to
x86_64-v2 baseline happening yet) are supposed to do with SIGILL reports
coming from affected users after this change.

I'm sure it's not "here's a nickel, kid...", but I'm honestly at a loss
what you'd suggest.

Looking at the patches, the gains appear to be so remarkably tiny, with
the exception of adding CMOV to baseline, that I question if it's worth
the friction. Is there something I'm not seeing?

I think basing the decision on when the earliest x86_64-v2 processors appeared
is not right.

Would you consider a reversal of the three patches that bump the baseline
beyond SSE2?

>   meson: assume x86-64-v2 baseline ISA
>   host/i386: assume presence of SSSE3
>   host/i386: assume presence of POPCNT

Thank you.
Alexander

