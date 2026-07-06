Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F956C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgotb-0007f5-Mp; Mon, 06 Jul 2026 15:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1wgotY-0007ei-DG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:22:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1wgotW-0005fA-7C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:22:19 -0400
Received: from frill.fritz.box (p5dd8f8a7.dip0.t-ipconnect.de [93.216.248.167])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5B27120B716B;
 Mon,  6 Jul 2026 12:22:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B27120B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783365731;
 bh=gN7spSy6BrP/5YveIIKT8/Vx3Hapi/Sn4qjEcxHK53g=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
 b=Sk8ZNYos81hbM/bG5uOBt8/A7b629w3P1LS7CBBh0cbQ/fb+K564S5Vz2kqD27V6J
 qJDkOQWNLZ4vDZhbrlFEK7nuhVuNI28c47iQ+guVlJ3aESCg4BurlQeTD2xKwG6GsZ
 KSnPtltguDP/WGFiB3tvogznMxN1SG4SG7Arfaqc=
Message-ID: <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
From: Anatol Belski <anbelski@linux.microsoft.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Mon, 06 Jul 2026 21:22:12 +0200
In-Reply-To: <aktl-ojkXVZ4Jira@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
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

Hi Daniel,

On Mon, 2026-07-06 at 09:29 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Jul 04, 2026 at 03:37:21PM +0200, Anatol Belski wrote:
>=20
>=20
> The README only lists=C2=A0 cloud hypervisor bugs.=C2=A0 Did you file any=
 for
> QEMU yet ?

Thanks for checking. Yeah, the README only has the Cloud Hypervisor
fixes so far, those being the ones already merged. The QEMU ones are
not filed yet, they are still just reproducer tests in the harness.

There are several findings, though. As one example, a block read whose
data descriptor points at the device own MMIO BAR deadlocks the VM
under the BQL, so a single descriptor freezes the whole thing.
https://github.com/weltling/virtio-villain/blob/main/tests/vring/t0063_desc=
_addr_pci_bar.c

I have been reaching out to a few QEMU maintainers individually first,
to confirm these are ordinary robustness bugs and not security
sensitive before anything goes public. I am being careful because
automated and AI generated reports are flooding projects right now,
and I did not want to add noise or mishandle something sensitive.

>=20
> If this is finding bugs in QEMU this test harness sounds like the
> kind
> of thing we ought to have integrated in QEMU's meson test suite such
> that it runs in CI to prevent regressions.
>=20

Makes sense. I have been exercising QEMU regularly anyway, since it is
the de facto standard to compare against, so wiring the harness into
the QEMU test setup to catch regressions is a natural fit. One note on
shape. qtest drives a device from outside the guest, poking its
registers over a socket with no guest code running. virtio-villain
works the other way around, it boots a tiny init into an initramfs,
with no full OS, and that guest drives the device as real guest code.
So it stays lightweight, just a booted guest rather than an external
driver. I think that is worth exploring. The harness is public, so it
is there to build on, and I am glad to help work out how it could fit.

Thanks

Anatol

