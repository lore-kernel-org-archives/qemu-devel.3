Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E49EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 22:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgXla-0000Kb-Aa; Tue, 20 Aug 2024 18:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgXlZ-0000JV-4N
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:55:53 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgXlX-0002G3-Ku
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail; t=1724194549; x=1724453749;
 bh=puMpdFCFlsOtL7e4NLkd9eHVg+k82EBw3PYuCj7Hmb4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ytBB5JtfbpodoFXg9fJtw12GQtCD0vkwY20kICbi/A/OTxEET6wtY8cyaq8Ex9eh2
 jKlVkDpGNNTmks0uVsMywEhcvPPk1OnRMx93l3F2ojNZFWT61VVAeLCq6cDl+Q0Vbj
 JxJ/ooc5MEduQqPjMET8oWbiYkoMgj07Yp9siokSepK2d3orBd87lskIbfbcazIf/Q
 IzLy+fXpEfdV0Tsgha59LWsZT87aXUiXNADmouZZ8i8z9SgK60XTj5uERWLZdDi2qc
 vTwiek/Ywfru3u0yYK38KIiVcGezKpfgEh3lnD6DW8D48SHs7RwP+NNVTfZ+k4p8LR
 Z7+MK1AOvbnSA==
Date: Tue, 20 Aug 2024 22:55:46 +0000
To: Richard Henderson <richard.henderson@linaro.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PULL 18/20] hw/i386/pc: Unify vmport=auto handling
Message-ID: <WRb-ltK_l3gBJ9cVBG1NGj6JY8EwdAWHsFc7vPuLpYC0kdz2Y1F1wEpNSwTj4YbteJrK12PCmsiC7hYRoKcIo-GhZid3zS87mwgUtPvLhls=@szczek.dev>
In-Reply-To: <4b8540be-bdb2-44c7-b50e-a87ac03ba1b3@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
 <20240819225116.17928-19-philmd@linaro.org>
 <ee5b8c9e-09fe-4b28-86fb-c6859085f988@linaro.org>
 <l60k6IPuP5TW4SNWI9iSNbMRiENiDl10oJROwImn9NsILTP6M-CVvIV42wUG8RYSdW_o6xdPhhr27Cqc0_2MgvZaBRn2B2poF6CYMGtn3Rc=@szczek.dev>
 <4b8540be-bdb2-44c7-b50e-a87ac03ba1b3@linaro.org>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 42b87ccdce87daa5eeeeb8db6b34f888c9066a34
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.22; envelope-from=kamil@szczek.dev;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wednesday, August 21st, 2024 at 00:45, Richard Henderson <richard.hender=
son@linaro.org> wrote:
> On 8/21/24 06:32, Kamil Szcz=C4=99k wrote:
>=20
> > Also, just as a test I added a single line of code before the assert:
> >=20
> > pcms->vmport =3D -1;
> >=20
> > And, to my surprise, it compiled successfully without any warning and a=
s expected, aborted on the assert:
> >=20
> > qemu-system-x86_64: ../hw/i386/pc.c:1225: pc_basic_device_init: Asserti=
on 'pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX' failed.
> >=20
> > Is this expected behavior?
>=20
>=20
> Yes.
>=20
> The underlying integral type for enum in C is implementation defined.
> It can and does vary between compilers, leading to this sort of thing.
>=20
> The only reasonable fix is
>=20
> (unsigned)foo < max

Fair enough, just posted a patch.

