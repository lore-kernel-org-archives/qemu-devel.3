Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBA606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ri2TTVSG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTtDu-000832-RJ; Wed, 18 Nov 2026 22:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTtDn-00082Z-Pj; Wed, 18 Nov 2026 22:54:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTtDk-00069a-K9; Wed, 18 Nov 2026 22:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795060436; bh=3tm+C6qEjlgV/alB0R5qyZmy4b3Azc1Pl6l7weVJHOc=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=ri2TTVSGGV9NRwQjAcqQUJuP3A7LDzKk5BNu0wfQzB1SOQiE7eigQ8PY6iptoqHnp
 QrVQYrivUUFloyyhJ+tNHRBbe5oN7Ar3W7D/ZUTMOIqNM+WOBjJaJrgUfHS6uQHTeF
 GSY2CnZPjuvssZlMDWMY27+NV+of89WiLaybmVFpzhbz/pVSHq/j+hTteksSodriBM
 k7H6QkVwz5usVC3mBdNUPWtlFjG+0wMtzqJqyWD55hPuAlg+OE0JydR7i53GOKoqwb
 5pFFDkDg5y7B96tq325vZTpl/Y+CZecIrcAXTnwJ2D+Ya92piOZ8MKYlLy9F7K0KNt
 diYr3gq82nZLA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E25E21E7CB7;
 Thu, 19 Nov 2026 06:53:56 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CB68646150C;
 Thu, 19 Nov 2026 06:53:56 +0300 (MSK)
Message-ID: <14fff594-e370-4fe3-9e34-b1e8dcd14a3d@tls.msk.ru>
Date: Thu, 19 Nov 2026 06:53:56 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: raise #DE for INT_MIN / -1 in IDIV helpers
To: Jiang Yuxuan <hooyan2024@gmail.com>, qemu-devel@nongnu.org
References: <CAAt7E3+jVR+YHZC3996kdC_Xrh9aVJ4YLy8X7+1HyjvOQk09Ug@mail.gmail.com>
Content-Language: en-US, ru-RU
Cc: QEMU Stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAAt7E3+jVR+YHZC3996kdC_Xrh9aVJ4YLy8X7+1HyjvOQk09Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/17/26 05:04, Jiang Yuxuan wrote:
> helper_idivw_AX() and helper_idivl_EAX() perform the division before
> checking whether the quotient fits in the destination.  If the dividend
> is the minimum value and the divisor is -1, the division overflows in
> the host: INT32_MIN / -1 and INT64_MIN / -1 are undefined behaviour in C
> and trap with SIGFPE on x86 hosts.  QEMU then dies of a host SIGFPE
> instead of raising #DE in the guest, taking down the emulator (or the
> whole VM under TCG).
> 
> Reject the two overflowing cases before dividing.  The 8-bit form is not
> affected (it widens the dividend to int), and the 64-bit form already
> checks first.
> 
> Add a regression test for both the 16-bit and 32-bit forms, run by the
> i386 and x86_64 linux-user test suites.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4687 <https://gitlab.com/qemu-project/qemu/-/issues/4687>
> Signed-off-by: fujo <hooyan2024@gmail.com <mailto:hooyan2024@gmail.com>>
> ---
>   target/i386/tcg/int_helper.c        |  4 +-
>   tests/tcg/i386/meson.build          |  1 +
>   tests/tcg/i386/test-idiv-overflow.c | 70 +++++++++++++++++++++++++++++
>   tests/tcg/x86_64/meson.build        |  1 +
>   4 files changed, 74 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/i386/test-idiv-overflow.c

It feels like this change should go to the stable qemu series too.
I'm picking it up.  Please let me know if I should not.

Thanks,

/mjt

