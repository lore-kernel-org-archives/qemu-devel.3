Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85AFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJgl-0001kK-8F; Fri, 10 Jul 2026 18:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1wiJgj-0001f7-9Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:27:17 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1wiJgh-0007oq-7u
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:27:16 -0400
Received: from frill.fritz.box (p5dd8e490.dip0.t-ipconnect.de [93.216.228.144])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4749E20B7169;
 Fri, 10 Jul 2026 15:27:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4749E20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783722425;
 bh=sj0PfH244kbjoAGFfvNzcoFTeoU242zQh2NBPagGri8=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
 b=drzkYVipoFxSDxhCfC9AqxZOn6vVSVVt4MaqGqzFymg2GFT5Epn26QqDbXEVXLF3z
 8v6/DIqEqINrzANaainj2n6yScbw17la+jGor6wdlz1H5758tgmanW8hvts432Bi3b
 ZL2w8G645Cx+qiiVTuRBYMhu/CQ+JcRGuMsixFjI=
Message-ID: <7f7d22fc2ddfa25d9f10ee928dfef302eabde6d4.camel@linux.microsoft.com>
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
From: Anatol Belski <anbelski@linux.microsoft.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Sat, 11 Jul 2026 00:27:08 +0200
In-Reply-To: <alDrJiFzJsf04RFT@fedora>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <alDrJiFzJsf04RFT@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=anbelski@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-To: anbelski@linux.microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Matias,

On Fri, 2026-07-10 at 14:52 +0200, Matias Ezequiel Vara Larsen wrote:
>=20


> Thanks for sharing it. I am also interesting on finding violations of
> the virtio specification. I presented something two years ago in LPC
> (see https://lpc.events/event/18/contributions/1897/). As a result of
> that work, we worked adding kani proofs in rust-vmm devices. The
> validation of the spec is coded in RUST and by using kani we verify
> that
> the implemented devices follows the specification. For some
> requirements, we were able to prove that the device is conform. The
> proofs are written together with the implementation of the device
> like
> tests.=C2=A0=20

Thanks for the pointer. The virtio-sound case is a good example of why
this matters. The driver was exposing buffers back into the avail ring
while still owned by the device, and nothing caught it until it was
traced by hand.

The work you describe verifies that the rust-vmm device implementations
follow the spec both through formal proofs and runtime observation.
virtio-villain comes at it from the other end by acting as a
deliberately broken guest driver against any VMM and checking whether
the device handles the violation gracefully. Different sides of the
same medal.

>=20
> Feel free to file patches to the virtio specification in cases you
> think
> the spec is too permissive.=20

That would be worth doing. Several of the divergences I see between
VMMs come down to the spec being silent on what the device should do,
so tightening the normative text would help everyone.

One example is that the spec defines the descriptor addr and len fields
in virtio 1.4 section 2.7.5 but never states what the device must do
when addr plus len falls outside guest physical memory. Every VMM needs
to handle this, and Cloud Hypervisor already fixed it after the harness
surfaced the issue. A normative statement there would save each
implementation from rediscovering the same gap on its own.

>=20
> At some point, I wanted to add some checks in QEMU to inform user
> when
> guest violates the spec. That would help to catch some issues with
> less
> testing. For example, two years ago the virtio-sound driver was
> silently
> violating the spec by writing the content of the buffers that were
> already in the available ring.=20

That lines up with the discussion in your talk about placing the
observer on the device side. virtio-villain already classifies each
case as pass, reject, or wedge, so the cases where QEMU silently
tolerates a violation instead of flagging it are straightforward to
spot.

Regards

Anatol
>=20

