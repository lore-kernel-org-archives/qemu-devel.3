Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47BEE4992
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soL06-0001n0-BN; Wed, 11 Sep 2024 06:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1soL03-0001h9-SP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:55:04 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1soL01-0004vc-5W
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=ye+zlWLgHPQt2ouCZpiboWo6ZlqTlM1tCB7npJUmQ5s=; b=XHotMe52Si/IT6ahPUzCLUAR1f
 u7cRDiwiCEbnF1ZmuF0Lo5PtWPSIKe5XB4PWhJKoOh4xDVldd1s1ZKo/UEKy9gKCNpShVgtPlI2WD
 eMeCLvCJUcm9ofgJGplAypuEEPksd+gFZx8D1rg17jAnTYzY4AfvOxBG9HpuMHqcJGiQeBiQtPNJY
 HuQ9ROJymBBZ6iEY40tXunTpTI1ooI56cI2OoEdwgAB1N0iwaD4thcbNoPIFr8CxYbesTSJJtEkVT
 VryB4lsSP2nPduelnJDJNn61RGv8/KMxP0sRi/3OTXMWBx/UU41hpJlLY3UPUz5WTzQSg7GaCEBso
 Gj7rZMMA==;
Received: from p578eca80.dip0.t-ipconnect.de ([87.142.202.128]
 helo=shark.fritz.box) by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1soKzu-00Bw2L-2I; Wed, 11 Sep 2024 12:54:54 +0200
Message-ID: <f53a98c763f55f56e189fcf7822d203872870eee.camel@kernkonzept.com>
Subject: Re: [PATCH] hw/intc/arm_gic: fix spurious level triggered interrupts
From: Jan =?ISO-8859-1?Q?Kl=F6tzke?= <jan.kloetzke@kernkonzept.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2024 12:54:53 +0200
In-Reply-To: <CAFEAcA-tK24wCPKZwig1iDPSOiHKqZMU4WH99ZZEG-awveEvag@mail.gmail.com>
References: <20240902123038.1135412-1-jan.kloetzke@kernkonzept.com>
 <CAFEAcA-tK24wCPKZwig1iDPSOiHKqZMU4WH99ZZEG-awveEvag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=jan.kloetzke@kernkonzept.com; helo=mx.kernkonzept.com
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

On Fri, 2024-09-06 at 13:50 +0100, Peter Maydell wrote:
> On Mon, 2 Sept 2024 at 13:32, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.=
com> wrote:
> >=20
> > Level triggered interrupts are pending when either the interrupt line
> > is asserted or the interrupt was made pending by a GICD_ISPENDRn write.
> > Making a level triggered interrupt pending by software persists until
> > either the interrupt is acknowledged or cleared by writing
> > GICD_ICPENDRn. As long as the interrupt line is asserted, the interrupt
> > is pending in any case.
> >=20
> > This logic is transparently implemented in gic_test_pending(). The
> > function combines the "pending" irq_state flag (used for edge triggered
> > interrupts and software requests) and the line status (tracked in the
> > "level" field). Now, writing GICD_ISENABLERn incorrectly set the
> > pending flag if the line of a level triggered interrupt was asserted.
> > This keeps the interrupt pending even if the line is de-asserted after
> > some time.
> >=20
> > Fix this by simply removing the code. The pending status is fully
> > handled by gic_test_pending() and does not need any special treatment
> > when enabling the level interrupt.
> >=20
> > Signed-off-by: Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.com>
>=20
> Thanks for this patch. I agree that this is wrong for the
> GICv2 -- I think this is a bit we missed in commit 8d999995e45c
> back in 2013 where we fixed most other places that were not
> correctly making this distinction of "pending because of
> ISPENDR write" and "pending because level triggered and
> line is held high".
>=20
> However I think for consistency with that commit, we should
> retain the current behaviour here for the s->revision =3D=3D REV_11MPCORE
> case. (This is basically saying "we don't really know exactly
> how the 11MPCore GIC behaved and we don't much care to try to
> find out, so leave it alone", which is the stance we were
> already taking in 2013...) In particular, notice that
> gic_test_pending() only does the "pending if level triggered
> and held high" logic for the not-REV_11MPCORE case.

Right. Thanks for catching this. I'll send a V2 shortly.

Actually, I tried to make sense out of the ARM11 MPCore TRM but gave
up. At least, I could not come with a consistent idea how the hardware
is supposed to behave. Keeping the old behavior really looks like the
most sensible option here.


Thanks,
Jan

--=20
Jan Kl=C3=B6tzke, jan.kloetzke@kernkonzept.com, +49 351 41883238

Kernkonzept GmbH, Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

