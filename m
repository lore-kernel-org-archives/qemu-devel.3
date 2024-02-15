Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A5C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ragke-0000Df-MN; Thu, 15 Feb 2024 13:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1ragkc-0000CV-95
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:46:26 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1ragkZ-0004Uf-UP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:46:26 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 3DAED40762DF;
 Thu, 15 Feb 2024 18:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3DAED40762DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708022779;
 bh=bbYtPRFuMdaGYrsiQumLSofHRt5QzJKtXqkkIoaM6X0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=DbtI5ZLWrA1usmLUIpANvVqQJDQKpQI3acKrGXLklrXp5Cvq3+AVBA6Foc3f1RVki
 m4PfvR1hdz2ixuaHgyPHCstJvVEFAr0OkpJU+kV4WJmerFMHPlYpgfJd4KKees9Jql
 7NFmPJz03tHhC0H9KiUE9ruozUD8sCch7M9f0mXY=
Date: Thu, 15 Feb 2024 21:46:19 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v4 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
In-Reply-To: <6499be56-2002-44b3-9c53-1a1ec2fde53f@linaro.org>
Message-ID: <1e4d5081-d86b-84f5-20f7-8e48044b751a@ispras.ru>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-10-richard.henderson@linaro.org>
 <1f038576-5121-e84c-8196-ae5f9ca3a75b@ispras.ru>
 <6499be56-2002-44b3-9c53-1a1ec2fde53f@linaro.org>
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


On Thu, 15 Feb 2024, Richard Henderson wrote:

> On 2/14/24 22:47, Alexander Monakov wrote:
> > 
> > On Wed, 14 Feb 2024, Richard Henderson wrote:
> > 
> >> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
> >> double-check with the compiler flags for __ARM_NEON and don't bother with
> >> a runtime check.  Otherwise, model the loop after the x86 SSE2 function,
> >> and use VADDV to reduce the four vector comparisons.
> > 
> > I am not very familiar with Neon but I wonder if this couldn't use SHRN
> > for the final 128b->64b reduction similar to 2022 Glibc optimizations:
> > https://inbox.sourceware.org/libc-alpha/20220620174628.2820531-1-danilak@google.com/
> 
> The reason they use SHRN for memchr is that they have also applied a mask
> to the comparison so that they can identify which byte contained the match.
> That is not required here, so any reduction will do.

Right, so we can pick the cheapest reduction method, and if I'm reading
Neoverse-N1 SOG right, SHRN is marginally cheaper than ADDV (latency 2
instead of 3), and it should be generally preferable on other cores, no?

For that matter, cannot UQXTN (unsigned saturating extract narrow) be
used in place of CMEQ+ADDV here?

Alexander

