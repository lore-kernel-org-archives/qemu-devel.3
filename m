Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68506C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXPi0-0008Rp-0c; Fri, 26 Jul 2024 14:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+54b4fdbe2f31b2bce0ce+7642+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sXPhj-0008PW-Dn
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 14:30:11 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+54b4fdbe2f31b2bce0ce+7642+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sXPhg-0007OV-CN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 14:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=BHfyk4lid0LBsgW6Qbi96iERQ2QA5oUayAU6ZwaA/x4=; b=k7Io4BRCAEY+B/E02cjwN2TFVm
 +XHmCVyNg8Y/B/1ka63hMSeyuetois+YaavQDKjEOStsB/3GlrSkaLnkcLeud3Sda/9pPA3vMjuQ4
 Fi/K0ZTyQip2ElONaLATr7HDwSfL905Y2MdZG5E0BS8HcRUSXQJhE4s0yXdFXCQ5Vb+aClxHP2P5v
 3GImoefAgGKngWdw6A4bIhx1CO2ZBKanZZ+kWgZLi66ksDuxO3IeaRG8Ac0immDTdSA6ul8wY2Ofq
 mrMv04ta0ABbpXgLBgqzgD6D0Kt+GE6htuFWvKmbGvfL8NDSXRUMWdT/Hn9Lxtc/K1sOAWS2Lewfu
 RlWsRviA==;
Received: from [2a00:23ee:1008:2bab:d45e:a5c6:d63:3c97] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sXPhG-00000004HMP-3wSJ; Fri, 26 Jul 2024 18:29:43 +0000
Date: Fri, 26 Jul 2024 19:28:28 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>,
 "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
User-Agent: K-9 Mail for Android
In-Reply-To: <20240726174958.00007d10@Huawei.com>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
Message-ID: <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+54b4fdbe2f31b2bce0ce+7642+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 26 July 2024 17:49:58 BST, Jonathan Cameron <Jonathan=2ECameron@Huawei=
=2Ecom> wrote:
>On Thu, 25 Jul 2024 14:50:50 +0100
>David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>
>> On Thu, 2024-07-25 at 08:33 -0400, Michael S=2E Tsirkin wrote:
>> > On Thu, Jul 25, 2024 at 01:31:19PM +0100, David Woodhouse wrote: =20
>> > > On Thu, 2024-07-25 at 08:29 -0400, Michael S=2E Tsirkin wrote: =20
>> > > > On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote: =
=20
>> > > > > On Thu, 2024-07-25 at 08:17 -0400, Michael S=2E Tsirkin wrote: =
=20
>> > > > > > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wro=
te: =20
>> > > > > > > > Do you want to just help complete virtio-rtc then? Would =
be easier than
>> > > > > > > > trying to keep two specs in sync=2E =20
>> > > > > > >=20
>> > > > > > > The ACPI version is much more lightweight and doesn't take =
up a
>> > > > > > > valuable PCI slot#=2E (I know, you can do virtio without PC=
I but that's
>> > > > > > > complex in other ways)=2E
>> > > > > > >  =20
>> > > > > >=20
>> > > > > > Hmm, should we support virtio over ACPI? Just asking=2E =20
>> > > > >=20
>> > > > > Given that we support virtio DT bindings, and the ACPI "PRP0001=
" device
>> > > > > exists with a DSM method which literally returns DT properties,
>> > > > > including such properties as "compatible=3Dvirtio,mmio" =2E=2E=
=2E do we
>> > > > > already?
>> > > > >=20
>> > > > >  =20
>> > > >=20
>> > > > In a sense, but you are saying that is too complex?
>> > > > Can you elaborate? =20
>> > >=20
>> > > No, I think it's fine=2E I encourage the use of the PRP0001 device =
to
>> > > expose DT devices through ACPI=2E I was just reminding you of its
>> > > existence=2E =20
>> >=20
>> > Confused=2E You said "I know, you can do virtio without PCI but that'=
s
>> > complex in other ways" as the explanation why you are doing a custom
>> > protocol=2E =20
>>=20
>> Ah, apologies, I wasn't thinking that far back in the conversation=2E
>>=20
>> If we wanted to support virtio over ACPI, I think PRP0001 can be made
>> to work and isn't too complex (even though it probably doesn't yet work
>> out of the box)=2E
>>=20
>> But for the VMCLOCK thing, yes, the simple ACPI device is a lot simpler
>> than virtio-rtc and much more attractive=2E
>>=20
>> Even if the virtio-rtc specification were official today, and I was
>> able to expose it via PCI, I probably wouldn't do it that way=2E There'=
s
>> just far more in virtio-rtc than we need; the simple shared memory
>> region is perfectly sufficient for most needs, and especially ours=2E
>>=20
>> I have reworked
>> https://git=2Einfradead=2Eorg/users/dwmw2/linux=2Egit/shortlog/refs/hea=
ds/vmclock
>> to take your other feedback into account=2E
>>=20
>> It's now more flexible about the size handling, and explicitly checking
>> that specific fields are present before using them=2E=20
>>=20
>> I think I'm going to add a method on the ACPI device to enable the
>> precise clock information=2E I haven't done that in the driver yet; it
>> still just consumes the precise clock information if it happens to be
>> present already=2E The enable method can be added in a compatible fashi=
on
>> (the failure mode is that guests which don't invoke this method when
>> the hypervisor needs them to will see only the disruption signal and
>> not precise time)=2E
>>=20
>> For the HID I'm going to use AMZNVCLK=2E I had used QEMUVCLK in the QEM=
U
>> patches, but I'll change that to use AMZNVCLK too when I repost the
>> QEMU patch=2E
>
>That doesn't fit with ACPI _HID definitions=2E
>Second set 4 characters need to be hex digits as this is an
>ACPI style ID (which I assume this is given AMZN is a valid
>vendor ID=2E  6=2E1=2E5 in ACPI v6=2E5
>
>Maybe I'm missing something=2E=2E=2E
>
>J
>
>



Hm, is the same not true for QEMUVGID and AMZNVGID, which I was using as a=
n example?

QEMU seemed to get to 0002, and AFAICT the VMGENID patches were initially =
posted using QEMU0003, but what's actually in QEMU now is QEMUVGID=2E So I =
presumed that was now the preferred option=2E

