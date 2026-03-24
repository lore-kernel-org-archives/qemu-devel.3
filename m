Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C93E9A74B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yPF-0001Lk-Oe; Tue, 24 Mar 2026 05:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69c25920.v1-87f83ede378c4c789f06918e21d30ead@bounce.vates.tech>)
 id 1w4yMU-0000pG-0h
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:47:48 -0400
Received: from mail180-47.suw31.mandrillapp.com ([198.2.180.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69c25920.v1-87f83ede378c4c789f06918e21d30ead@bounce.vates.tech>)
 id 1w4yMR-000832-G4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1774344481; x=1774614481;
 bh=xySpiGsL6jhSgBQryanlxjULqiUOOXBfzlvPnW3Iw4Y=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=NrP3UO/9fBXGKR4Ku1lCHVLa7s+rlj3J6BOgGNZDFxCluPbeqRNe1ErnKNXRbymDE
 3JCwFrcgz69RvArhNHKIs8UXkgbe9ky+RE6Mvvscrro3efntXmhuyyddKaSGLYS+yu
 2o7mU5jXNh+wOhK5SIegT3S1w4PfpdCHSq4url3sIuddnsIhhigN07NFpLXOENeLSV
 vMOaFx6w2QgZVJYEqFF1SzxGXm9htmtuVwK2U6gzsdBcap13403C+WEFcNfZYXHA1C
 V73+gY3msGvylhEOrOi99CYixd0bdPRT2h7OvGF/wwNoKbd6N840IRxNVQKmXtG81z
 XcTV+vZ2t5chw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1774344481; x=1774604981; i=anthony.perard@vates.tech;
 bh=xySpiGsL6jhSgBQryanlxjULqiUOOXBfzlvPnW3Iw4Y=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=VFzxfT/ubcO/+ueQrA8nkBkMxDi9DO/dJ04dv0/Amnr3wau6PwP5EcGLKNxtNbdf0
 MTJWSE7jKcnxN7YmwJrM1ZZnLYbeFx19sunrr7LDEoYuSBa1frsUP/U5fODYrqsjJ8
 jDXpnqSiJEY4tKQLXvWMydD6C5nFT7PuzjFe3JfxLbeIlXI+fHZOMZSALNQh1V2DGj
 UZp3I0Ro5Gnk18rYd/+XcCqc0TIx3N0hqMtcKcxo/2+YheDdElTBrsWAM/3MtIM+xC
 aRz4OVF0rOFDOO2i0XaSQmBVHoX+G/rv1ITU+UrHfGxnL79nQUvsp/yjcTCDFw7tfA
 zwGCh2E9yreJg==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail180-47.suw31.mandrillapp.com (Mailchimp) with ESMTP id
 4fg4TD6rbFzPm0dZq
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 09:28:00 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=200/4]=20Xen:=20Add=20Q35=20initial=20support=20for=20HVM=20guests?=
Received: from [37.26.189.201] by mandrillapp.com id
 87f83ede378c4c789f06918e21d30ead; Tue, 24 Mar 2026 09:28:00 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1774344479469
To: "=?utf-8?Q?Marek=20Marczykowski-G=C3=B3recki?="
 <marmarek@invisiblethingslab.com>
Cc: "Thierry Escande" <thierry.escande@vates.tech>, qemu-devel@nongnu.org,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 xen-devel@lists.xenproject.org
Message-Id: <acJZHpw8tcTMPpCn@l14>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
 <abVtsK31t9tWgsaY@mail-itl>
In-Reply-To: <abVtsK31t9tWgsaY@mail-itl>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.87f83ede378c4c789f06918e21d30ead?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260324:md
Date: Tue, 24 Mar 2026 09:28:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.180.47;
 envelope-from=bounce-md_30504962.69c25920.v1-87f83ede378c4c789f06918e21d30ead@bounce.vates.tech;
 helo=mail180-47.suw31.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Mar 14, 2026 at 03:16:15PM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Fri, Mar 13, 2026 at 04:46:56PM +0000, Thierry Escande wrote:
> > This patch series introduces Q35 chipset support for Xen HVM guests. Th=
is is
> > based on the work from Alexey Gerasimenko (See patchset [1] for referen=
ce).
> > 
> > This series does not implement device passthrough as this will need mor=
e work
> > on the Xen side to support multiple PCI buses. Since Q35 chipset does n=
ot
> > support device hotplugging and with current Xen mechanism for device
> > passthrough, they have to be plugged to a new PCIe root port, i.e. not =
the PCI
> > bus 0.
> 
> I always found it weird that Xen does hot-plugging of PCI passthrough
> devices... Wouldn't it be easier to change this (connect them from the
> very start, via QEMU cmdline) and declare hotplug as unsupported (at
> least at this time)? I realize it's more complex change at the toolstack
> side, but overall may simplify things and maybe even improve
> reliability.

Skipping hot-plug on Q35 sounds good to me.

I though we could keep using QMP to do cold plug, with the experimental
"--preconfig", but "device_add" isn't allowed :-(. So yes, doing this
via command line sounds fine.

In libxl, we might be able to transform the json for `device_add` into
the command line counterpart for `-device` fairly easily so the argument
are only generated in a single place. Then we could skip the QMP
"device_add" in libxl when it's already done via command line.

But looks like XCP-ng also does QMP "device_add" for passthrough :-( but
one step-at a time.

Cheers,


--
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



