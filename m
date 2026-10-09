Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127FCCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEvY-0003T2-R2; Fri, 09 Oct 2026 14:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xFEvH-0003Rz-8U; Fri, 09 Oct 2026 14:02:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xFEvE-0007CC-Q7; Fri, 09 Oct 2026 14:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=c5jZR665gBsAhMn6HMD6N+1onWjS1Ansxphl0yYFKlw=; b=qr3X7S5gr7Viq00liV2yLQsHRf
 qvrH2COPchHV7v1cmda0RVBhijSxUZqwAP2O0csRD4xs3zgrohRu2mpaYuH2Icud04JPqFGjBwBfB
 TLwJY6R1cq3YBMY6ovonemkivFvz7lGEF4rLtL8wZe/A1mq3+LyKWf+k80PGk0K+E52OMuWvxPZVo
 YsixPutkn3l9Q9aEWZULSkIzsRr+2/qezgYg3C+K1mW7vRGG0INrbY2mrVW9hN2XvQzzmabPRA70k
 jyCxZ+XojkRpfqxNK5p6Rz5PLBvZClvST3IeEQkG7o1bcU0lsjaliu4/iTvXbssaKYOaDXtoIZPdW
 N+SW/OCA==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xFEv9-0000000CG6H-2TBo;
 Fri, 09 Oct 2026 20:02:15 +0200
Date: Fri, 9 Oct 2026 20:02:15 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tcg/riscv64: Fix vector constant matching for logical ops
Message-ID: <asksJ0sjVi9BZ5m0@aurel32.net>
References: <20261008181647.3015949-1-aurelien@aurel32.net>
 <118805f8-bc4c-4600-b156-5b494a840ef5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118805f8-bc4c-4600-b156-5b494a840ef5@linaro.org>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi,

On 2026-10-09 07:05, Richard Henderson wrote:
> On 10/8/26 20:16, Aurelien Jarno wrote:
> > +        if ((vece != MO_8) || (val == (uint8_t)val * 0x0101010101010101ull)) {
> 
> Do you really want
> 
>     val = dup_const(vece, val)
> 
> ?

No, I do not want that, as vece is not defined (in practice is 0 aka 
MO_8) for logical ops.

What I want is really extracting the element only if:

- vece != MO_8
 
=> This means VECE is defined (not 0), so it is possible to blindly 
extract a single element.

OR

- val == dup_const(vece, val)

=> When VECE is possibly undefined, this checks that the constant can be 
properly represented as an element replicated using VECE.

Or maybe you just mean to replace the check by

+        if ((vece != MO_8) || (val == dup_const(vece, val))) {

?

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

