Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB75CC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmIL-0003DI-7o; Wed, 21 May 2025 12:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmIJ-0003Cz-Cq; Wed, 21 May 2025 12:27:51 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmIC-00043c-Ew; Wed, 21 May 2025 12:27:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C48C9629D6;
 Wed, 21 May 2025 16:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C609C4CEE4;
 Wed, 21 May 2025 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747844853;
 bh=tzb5sGhVMDzupySLCWTjAhBuzcNQW3B0ZTsCc6E/cug=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lacOkdGn7xc8P6y3aHP5bCJbbr287dY+NwtnxZ20HOp1NrnQZx5fZ9l9IHpJRvYtU
 7t1kJFc/C2UYNNHd4/osNxG8kFlb9tH6J4nN0OMvLHh2hFjet93IxnEAZ7St7Phrb2
 4TqsaQ0vCPc5Gj7RZK6vykX3m6fz4n9dlF0Ss3f+nUqHkjkugwekXZ5LGuIBHdJTPY
 vJH2/zYIw6AVEut8yDmsPOes5uoTYqSDpc2I1m4ApupJDKoz1np0Nnk8hBbW4NhOzf
 XlM9+rndyZUX/BCmlCd4UEQapugwUYQXnrlhIGzO1gCKzFPBwF/0H0lR5V4wkDZxRx
 rT3OHB7o6AmjA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 0/3] target/riscv: profile handling fixes
In-Reply-To: <20250520172336.759708-1-dbarboza@ventanamicro.com>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
Date: Wed, 21 May 2025 18:27:29 +0200
Message-ID: <87bjrmyln2.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=bjorn@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel!

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> Hi,
>
> The motivation of this short series is to fix a reported in [1]. A
> couple of bugs were fixed along the way.
>
> Bj=C3=B6rn, these patches should remediate the situation you're experienc=
ing.

Thanks for the fast turn-around!

This indeed fixes the hart0 boot!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

