Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7925BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weG5z-0001fS-4D; Mon, 29 Jun 2026 13:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1weG5v-0001eN-Bp; Mon, 29 Jun 2026 13:48:31 -0400
Received: from mail-24416.protonmail.ch ([109.224.244.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1weG5q-0001lJ-QN; Mon, 29 Jun 2026 13:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1782755296; x=1783014496;
 bh=4bMsr+d6qKHi9UY58BKRSqlmhDSxaAAyPCYk+jzAkyU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=KsckYbRnAkdpH9QuP96AjyIcJGKz8TVPIIlqO5u6R7Y8o0e/fd/twZEAE/wyM2njS
 R6b6ERlrmVyIwhizj9Nilq1lOYj2bqjslc8cj+43olZzVHorN7aGZVno3qZFNgPZ6e
 pnLNeEFJN826CvRmNWH0B/UByOR7NnhaTBh9u1FQ7GRAh3V+uuuM6eba0BxdgzD8ro
 0gwBJIK9hbeEolAX1ntUk96n/bxzxyavl3L8ZjgJgfC5t1URc4XfW+f3T1vn1SlIU/
 yfM0Su2XtC660ZUfGShFhJ7Lc0Bft1eoCTbGeZz+XCvsUx3HpIYWJYegc1CtpuMs5c
 J46V+LabQ4SuA==
Date: Mon, 29 Jun 2026 17:48:11 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: "Jason L. Wright'" <wrigjl@proton.me>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 agraf@csgraf.de, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 zenghui.yu@linux.dev, richard.henderson@linaro.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU
 init
Message-ID: <akKv1Ntig5cpwl9y@Jasons-MacBook-Pro.local>
In-Reply-To: <CAFEAcA_XPGPLeH6DtcKDv-o7AkrX4dEFwLX4L+tSQ4wJA=Xnhw@mail.gmail.com>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
 <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
 <aibmIdorcTobj2yo@Jasons-MacBook-Pro.local>
 <CAFEAcA85HahxFXoDVW_xBZEtG2SUd_3PseYLrpUXE6P_Hb_5mA@mail.gmail.com>
 <4e00be29-25b4-479b-ad6f-b79beed78dd1@oss.qualcomm.com>
 <CAFEAcA_XPGPLeH6DtcKDv-o7AkrX4dEFwLX4L+tSQ4wJA=Xnhw@mail.gmail.com>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 8814fd8cb8fa00f06fcf32fb22c89a27be47cff4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.16; envelope-from=wrigjl@proton.me;
 helo=mail-24416.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 23, 2026 at 09:42:47AM +0100, Peter Maydell wrote:
> On Tue, 23 Jun 2026 at 09:27, Philippe Mathieu-Daud=C3=A9
> <philmd@oss.qualcomm.com> wrote:
> >
> > Hi,
> >
> > On 8/6/26 18:05, Peter Maydell wrote:
> > > On Mon, 8 Jun 2026 at 16:56, Jason L. Wright' <wrigjl@proton.me> wrot=
e:
> > >> The three methods track different requirements, so I matched
> > >> the closest existing pattern for ID_AA64ISAR0_EL1 and left
> > >> the others alone.
> > >
> > > It seems to me that you've added a third thing that's different
> > > from either of the ways that we handle existing ID registers
> > > with an isar.idregs[] field.
> > >
> > > I think we need to figure out:
> >
> > Should we revert the commit until this is figured out
>=20
> I don't think it's difficult. Somebody who cares about hvf
> should just do it, and submit this patch with whatever the right
> approach is.
>=20
I'll have another look at it this week. I think we can unify the
approaches, but I need to make sure I understand the other registers
better (PFR0 and MMFR0).

--Jason Wright


