Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12593C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmPO-0006LE-Kg; Wed, 21 May 2025 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmPG-0006Ee-1D; Wed, 21 May 2025 12:35:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmPD-0004zG-Kw; Wed, 21 May 2025 12:35:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93831629EF;
 Wed, 21 May 2025 16:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39B5C4CEE4;
 Wed, 21 May 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747845296;
 bh=hq9vsUXwe3ZOpP75DXIXeso8I5obmtX9OCPhGrYPpFE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lviZJK3dcIIlwoOw13dekz7eXMSu0TDCbA9UJ3XWmfrIfoBLx5glT0jHJyzJl7jds
 IuNaCxzaB1lVtfHcakvVTPDZnu7nwW8oTe+1cayajl1j1S/8z/ZnOFRBDzYAXbsLsY
 cD6qk7S6vPUuC9PDejbZNDQlHkiHT433BaoF1oGA7+DworaBAwDLUyYyJpFQmLF4SJ
 n5PrimWdQXfs3mReeaFuYaNHKmiru9bU7jwPXPAUPd/IDzFRu0MFFhyCPnQwSxgzfb
 mzLyYq60b9PcqWKEPX1LKuAQ6e8bt1Bu7Ndm4hCRAutZdw1v5etpGNheWN0APGg2A5
 iPV9Y5ynstTfg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 2/3] target/riscv/tcg: decouple profile enablement from
 user prop
In-Reply-To: <20250520172336.759708-3-dbarboza@ventanamicro.com>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-3-dbarboza@ventanamicro.com>
Date: Wed, 21 May 2025 18:34:53 +0200
Message-ID: <87y0upylaq.fsf@all.your.base.are.belong.to.us>
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> We have code in riscv_cpu_add_profiles() to enable a profile right away
> in case a CPU chose the profile during its cpu_init(). But we're using
> the user callback option to do so, setting profile->user_set.
>
> Create a new helper that does all the grunt work to enable/disable a
> given profile. Use this new helper in the cases where we want a CPU to
> be compatible to a certain profile, leaving the user callback to be used
> exclusively by users.
>
> Fixes: fba92a92e3 ("target/riscv: add 'rva22u64' CPU")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

