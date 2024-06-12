Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24740C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHM1H-0006R3-N7; Wed, 12 Jun 2024 07:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHM1E-0006Qg-Ut
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:19:56 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHM1B-0005X9-L5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:19:56 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id DC82240755E8;
 Wed, 12 Jun 2024 11:19:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DC82240755E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718191188;
 bh=qWUQFtLzO1JgXRX60+SzqyyzoxG0n6bTArGZ/rOlTzs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=s/bFPmFHxAOjxfX0m+AIlS62RZrgg4fzkmiEnWglk2U5iFzVwIIY3vrJtpg36VE6p
 /UUIQGr163zcClc0Vckrg/w2BVOsXaAxni+dGUJy/ZE8UOwHsgGGnCmviRh31ytTQE
 Oiby8zk3VZAjoFVHu0hhXjWPAwYj6eS0DkV4nIDw=
Date: Wed, 12 Jun 2024 14:19:48 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
Message-ID: <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
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


On Wed, 12 Jun 2024, Paolo Bonzini wrote:

> I didn't do this because of RHEL9, I did it because it's silly that
> QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
> compute the x86 parity flag (and POPCNT was introduced at the same
> time as SSE4.2).

From looking at that POPCNT patch I understood that Qemu detects
presence of POPCNT at runtime and will only use the fallback when
POPCNT is unavailable. Did I misunderstand?

Alexander

