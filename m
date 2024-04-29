Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEDAC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PDF-0000ub-Fo; Mon, 29 Apr 2024 07:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1s1PDD-0000uK-M1
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:30:23 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1s1PD9-0005kA-SP
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:30:22 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id BAE2E4078515;
 Mon, 29 Apr 2024 11:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BAE2E4078515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1714390198;
 bh=Xji0r6fnd14ca6ilceNmy9XGbfHKUFBN9/nCcYrphVw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=HtQyUz06C2/5GCIQFsBckvLP03Ipm1JyGibGX6HGarAQfhxJh0u9Onfa+VZVLMY8y
 3dUgiMkqYu2AQyCXh6cBi+BSn3JMoaL1h5ztaeW6UwxBSTaJa9sEhg/jEJGk8PYdse
 +xdL4VxiKpVMdFL1g+9txsiOpZZaPNfDfhXo39dA=
Date: Mon, 29 Apr 2024 14:29:58 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: Re: [PATCH v6 02/10] util/bufferiszero: Remove AVX512 variant
In-Reply-To: <Zi-BqBjND3Wcq3Eq@redhat.com>
Message-ID: <a2606c36-0f8b-5e67-abab-08390c81ad80@ispras.ru>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-3-richard.henderson@linaro.org>
 <Zi-BqBjND3Wcq3Eq@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-591192398-1714390198=:27629"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-591192398-1714390198=:27629
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


On Mon, 29 Apr 2024, Daniel P. Berrangé wrote:

> On Wed, Apr 24, 2024 at 03:56:57PM -0700, Richard Henderson wrote:
> > From: Alexander Monakov <amonakov@ispras.ru>
> > 
> > Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
> > routines are invoked much more rarely in normal use when most buffers
> > are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
> > frequency and voltage transition periods during which the CPU operates
> > at reduced performance, as described in
> > https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html
> 
> This is describing limitations of Intel's AVX512 implementation.
> 
> AMD's AVX512 implementation is said to not have the kind of
> power / frequency limitations that Intel's does:
> 
>   https://www.mersenneforum.org/showthread.php?p=614191
> 
>   "Overall, AMD's AVX512 implementation beat my expectations.
>    I was expecting something similar to Zen1's "double-pumping"
>    of AVX with half the register file and cross-lane instructions
>    being super slow. But this is not the case on Zen4. The lack
>    of power or thermal issues combined with stellar shuffle support
>    makes it completely worthwhile to use from a developer standpoint.
>    If your code can vectorize without excessive wasted computation,
>    then go all the way to 512-bit. AMD not only made this worthwhile,
>    but *incentivizes* it with the power savings. And if in the future
>    AMD decides to widen things up, you may get a 2x speedup for free."
> 
> IOW, it sounds like we could be sacrificing performance on modern
> AMD Genoa generation CPUs by removing the AVX512 impl

No, the new implementation saturates load ports, and Genoa runs 512-bit
AVX instructions at half throughput compared to their 256-bit counterparts
(so one 512-bit load or two 256-bit loads per cycle), so there's no
obvious reason why this patch would sacrifice performance there.

Maybe it could, indirectly, by lowering the turbo clock limit due to
higher front-end activity, but I don't have access to a Zen 4 machine
to check, and even so it would be a few percent, not 2x.

Alexander
--8323328-591192398-1714390198=:27629--

