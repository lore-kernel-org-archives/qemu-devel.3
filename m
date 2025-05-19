Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CC5C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzHc-0001FI-Um; Mon, 19 May 2025 08:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uGzHa-0001Ez-D0; Mon, 19 May 2025 08:07:50 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uGzHY-0003YS-2T; Mon, 19 May 2025 08:07:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CE9525C02DE;
 Mon, 19 May 2025 12:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F44EC4CEE4;
 Mon, 19 May 2025 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747656456;
 bh=yjKHiTlHdIkkYMIo3g9uwCoF4LNV0kpBCx25cMXp4SY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GSTaOzz59+CACK1aOP7TSEVsjF7d0kIwT73cKawINY5OJ/soBeHQ8ndTrfogjZU5d
 NloHQP60mNuv9vcMKafeb+XtL9HCQidCrJ7qbcX9142akbiB4MG336f3C4Qn6z8TJg
 vdHl8r5llKcIQSrX05M6u71pUeq/VFiUwleCv7KPgioBwj1zqDApuJ/BQaXkSpGqUB
 4kbgwfN0L1hn9ap9tv+si2w9X5zPWYIM+ISHM93zd88WH8OqKHsy/h1hqyHwQNoGJh
 dfY2IhY67pkAqzPwdHCJzIjyp75oJEA+nL3VpS6fOIpnRDWC7/ebSEkusSKJqN9BKS
 MNMef0ZaHb8kA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based
 on profile
In-Reply-To: <20250516122319.4100121-1-alexghiti@rivosinc.com>
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
Date: Mon, 19 May 2025 14:07:33 +0200
Message-ID: <87y0usiz22.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> The satp mode is set using the svXX properties, but that actually
> restricts the satp mode to the minimum required by the profile and
> prevents the use of higher satp modes.
>
> Fix this by not setting any svXX property and allow all satp mode to be
> supported.

I figured I'll add some more findings.

The RISC-V profile initialization seems a bit brittle; Without Alex' fix
we're getting different supported satp on the first hart (0) than the
other harts; Hart 0 has sv57, whereas the other harts has enforced sv39.
This caused the smp bringup on Linux to fail.

Some observations on, e.g., a
"rv64,b=3Don,zbc=3Doff,v=3Dtrue,vlen=3D256,elen=3D64,sscofpmf=3Don,svade=3D=
on,svinval=3Don,svnapot=3Don,svpbmt=3Don,zcb=3Don,zcmop=3Don,zfhmin=3Don,zi=
cond=3Don,zimop=3Don,zkt=3Don,zvbb=3Don,zvfhmin=3Don,zvkt=3Don,zkr=3Don"
8 hart machine:

When realizing the cpus, the first cpu calls riscv_cpu_add_profiles()
all profiles are disabled, whereas for the other cpu calls to
riscv_cpu_add_profiles() have some profiles enabled. Having some
profiles enabled, will issue a call to cpu_set_profile() that will
enforce the satp code that Alex removes in this patch.

The riscv_cpu_validate_profile() function is called after
riscv_cpu_add_profiles(), which explains why the harts subsequent the
first one will get the cpu_set_profile() call. The first hart will not
have cpu_set_profile() called.

IOW, there are more issues hiding here, in addition to Alex' fix.


Bj=C3=B6rn

