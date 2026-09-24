Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB445C9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ZOn-0005Ec-1T; Wed, 23 Sep 2026 22:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x9ZOg-0005EM-L2; Wed, 23 Sep 2026 22:41:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x9ZOe-00052D-Nj; Wed, 23 Sep 2026 22:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790217662; bh=xu0SsgtrQIGd7V+XT4gcblrGwXfgYJxzjA1hEodA+xc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=b0HZSjuNLLv95OhNkzC21qne1z6BZhaCwCKAXNtMq5kw52Hw2tr1V6EY4GUWUQWzn
 4rkqseMir7pVONSQVyV+kncS19b6LxxRmYrfciCnqJbDAzwvptY9p5EJqRfpU7RydR
 zdIdhu2VIwjm4t3jtkkq71Uh12sbwlfVfxYgU0zqZAFFt9XUmGzrE6MfJjX8fRkhus
 QdVfsP4bUwWxo4EFz/NHDVpDgIAIfhcCYhaUPA3hskEtM8TWvUBBKRq6fbD/JoNukK
 wzvsTsmsTJ3fPdMdaw1h4qXKIpursoMQ9FSfwQK8JM7i9NIpU1tL1nzHXZ+jKaqZfU
 YR/jcvIGe2+jQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADB3A1D7B1F;
 Thu, 24 Sep 2026 05:41:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CC6042FCC0;
 Thu, 24 Sep 2026 05:41:02 +0300 (MSK)
Message-ID: <251a95b2-3bf2-4d22-8dbf-402b9c56b197@tls.msk.ru>
Date: Thu, 24 Sep 2026 05:41:02 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] tcg/riscv64: Set vtype before whole-register vector loads
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Max Chou <max.chou@sifive.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260918201007.153384-1-richard.henderson@linaro.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260918201007.153384-1-richard.henderson@linaro.org>
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

On 9/18/26 23:10, Richard Henderson wrote:
> With vtype uninitialized, VILL might be set, leading to SIGILL.
> Also, assert vtype initialized for whole-register stores and moves.
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Reported-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This looks like a qemu-stable material.
I'm picking it up, please let me know if I shouldn't.

Thanks,

/mjt

