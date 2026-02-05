Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EEEEC1EAC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 12:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnyP0-000790-UN; Thu, 05 Feb 2026 07:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastien.michelland@inria.fr>)
 id 1vnyOz-00078m-1r; Thu, 05 Feb 2026 07:24:05 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastien.michelland@inria.fr>)
 id 1vnyOw-0000hk-Al; Thu, 05 Feb 2026 07:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=date:from:to:cc:message-id:in-reply-to:references:
 subject:mime-version:content-transfer-encoding;
 bh=4Gx2ZH2cSBkkdeGCtptbnTIiyX8Pf3a8Om1tEjwDOfc=;
 b=mAqQwQ+StYZbMxqzcSgWWIJ0TLnTlT6QHtmp1G3wsVlBvRB6PvqI+tka
 FXP/1I8rEtmfjAuuDryWNyJ2tfbu6Ux2/qfqYETM9kbuu02jju29+UpEM
 sUSWcXycphVbCurS1pusOZy6dal/FvE1h1sDM0R82q3iQ4MTiavOIEJjs Q=;
X-CSE-ConnectionGUID: S4o1cPMJTmKEaiXBSz4EjA==
X-CSE-MsgGUID: liY6gEq/RV+3OfsN8AshBQ==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=Pass smtp.mailfrom=sebastien.michelland@inria.fr;
 spf=None smtp.helo=postmaster@zcs2-store8.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
 sebastien.michelland@inria.fr designates 128.93.142.6 as
 permitted sender) identity=mailfrom; client-ip=128.93.142.6;
 receiver=mail2-relais-roc.national.inria.fr;
 envelope-from="sebastien.michelland@inria.fr";
 x-sender="sebastien.michelland@inria.fr";
 x-conformance=spf_only; x-record-type="v=spf1";
 x-record-text="v=spf1 include:mailout.safebrands.com
 a:basic-mail.safebrands.com a:basic-mail01.safebrands.com
 a:basic-mail02.safebrands.com ip4:128.93.142.0/24
 ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:128.93.162.3
 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
 authenticity information available from domain of
 postmaster@zcs2-store8.inria.fr) identity=helo;
 client-ip=128.93.142.6;
 receiver=mail2-relais-roc.national.inria.fr;
 envelope-from="sebastien.michelland@inria.fr";
 x-sender="postmaster@zcs2-store8.inria.fr";
 x-conformance=spf_only
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.21,274,1763420400"; d="scan'208";a="262062780"
X-MGA-submission: =?us-ascii?q?MDGHH8u6zwjUOwVrasmT2UKFuIw8CO86R//vOl?=
 =?us-ascii?q?e+RTv8lVVlCUKMFkgoAj4gVhIgLWa5JEhHyn/49Gco7h7gYBy1BM+No0?=
 =?us-ascii?q?VAoRbhgFZtN48Lzafpz/6umnqyPbb35R5+PCt4IxiD3sZ6g/vH/GkZIl?=
 =?us-ascii?q?rQJkqkGbT6BiMJaQOcAad0CQ=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
 by mail2-relais-roc.national.inria.fr with ESMTP; 05 Feb 2026 13:23:57 +0100
Date: Thu, 5 Feb 2026 13:23:57 +0100 (CET)
From: Sebastien Michelland <sebastien.michelland@inria.fr>
To: Max Chou <max.chou@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv <qemu-riscv@nongnu.org>, 
 Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
Message-ID: <1553882346.22736589.1770294237295.JavaMail.zimbra@inria.fr>
In-Reply-To: <aYNhZQC7_JRrBNlU@sifive.com>
References: <20260126172246.2521444-1-sebastien.michelland@inria.fr>
 <81d962d8-52fb-4203-a3fc-f3980b8a93bb@ventanamicro.com>
 <2132391437.15681684.1769606774227.JavaMail.zimbra@inria.fr>
 <aYNhZQC7_JRrBNlU@sifive.com>
Subject: Re: [PATCH] target/riscv: fix vs*r.v missing SIGILL check
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [131.254.16.132]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraWebClient - FF147
 (Linux)/10.1.14_GA_4838)
Thread-Topic: target/riscv: fix vs*r.v missing SIGILL check
Thread-Index: Unbzb0Ssqu4sWU7V5N/aXSFFNptt4A==
Received-SPF: pass client-ip=192.134.164.83;
 envelope-from=sebastien.michelland@inria.fr;
 helo=mail2-relais-roc.national.inria.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Max,

> But I think that the proposed fix of adding vext_check_isa_ill to whole
> register load/store instructions will violate the RISC-V vector specifica=
tion.
>=20
> With this patch, whole register load/store instructions would incorrectly
> raise illegal instruction exceptions when vill=3D1, even though the V ext=
ension
> is enabled.

You're entirely correct! I should probably have known or noticed that, oops=
.

So to sum up:

* The bug is that vs*r currently don't raise SIGILL when using a non-RVV CP=
U;
* but vs*r.v not having a vill check is intended and not the cause;
* instead the bug affects all instructions but the vill check just masks it=
 for
  everyone except vs*r.v.

> I would recommend that we should fix this bug at riscv_get_tb_cpu_state b=
y
> checking the CPU configuration in CONFIG_USER_ONLY block (user mode) to
> ensures require_rvv returns false when the vector is disabled.

I'll start from here and come back with a v2 that (hopefully) does the righ=
t thing.

S=E9bastien

