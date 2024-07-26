Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE24AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 16:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXO8y-0001gI-2y; Fri, 26 Jul 2024 12:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXO8w-0001eY-CT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:50:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXO8s-0006Bd-Po
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:50:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVtw42Qqrz6K9Lm;
 Sat, 27 Jul 2024 00:47:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A1191404FC;
 Sat, 27 Jul 2024 00:50:00 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 17:49:59 +0100
Date: Fri, 26 Jul 2024 17:49:58 +0100
To: David Woodhouse <dwmw2@infradead.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Peter Hilber <peter.hilber@opensynergy.com>,
 <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ridoux, 
 Julien" <ridouxj@amazon.com>, <virtio-dev@lists.linux.dev>, "Luu, Ryan"
 <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>, "Mohamed
 Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Christopher S . Hall"
 <christopher.s.hall@intel.com>, Jason Wang <jasowang@redhat.com>, "John
 Stultz" <jstultz@google.com>, <netdev@vger.kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, qemu-devel <qemu-devel@nongnu.org>, "Simon
 Horman" <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240726174958.00007d10@Huawei.com>
In-Reply-To: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 25 Jul 2024 14:50:50 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2024-07-25 at 08:33 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 01:31:19PM +0100, David Woodhouse wrote:  
> > > On Thu, 2024-07-25 at 08:29 -0400, Michael S. Tsirkin wrote:  
> > > > On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:  
> > > > > On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:  
> > > > > > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:  
> > > > > > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > > > > > trying to keep two specs in sync.  
> > > > > > > 
> > > > > > > The ACPI version is much more lightweight and doesn't take up a
> > > > > > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > > > > > complex in other ways).
> > > > > > >   
> > > > > > 
> > > > > > Hmm, should we support virtio over ACPI? Just asking.  
> > > > > 
> > > > > Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> > > > > exists with a DSM method which literally returns DT properties,
> > > > > including such properties as "compatible=virtio,mmio" ... do we
> > > > > already?
> > > > > 
> > > > >   
> > > > 
> > > > In a sense, but you are saying that is too complex?
> > > > Can you elaborate?  
> > > 
> > > No, I think it's fine. I encourage the use of the PRP0001 device to
> > > expose DT devices through ACPI. I was just reminding you of its
> > > existence.  
> > 
> > Confused. You said "I know, you can do virtio without PCI but that's
> > complex in other ways" as the explanation why you are doing a custom
> > protocol.  
> 
> Ah, apologies, I wasn't thinking that far back in the conversation.
> 
> If we wanted to support virtio over ACPI, I think PRP0001 can be made
> to work and isn't too complex (even though it probably doesn't yet work
> out of the box).
> 
> But for the VMCLOCK thing, yes, the simple ACPI device is a lot simpler
> than virtio-rtc and much more attractive.
> 
> Even if the virtio-rtc specification were official today, and I was
> able to expose it via PCI, I probably wouldn't do it that way. There's
> just far more in virtio-rtc than we need; the simple shared memory
> region is perfectly sufficient for most needs, and especially ours.
> 
> I have reworked
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/vmclock
> to take your other feedback into account.
> 
> It's now more flexible about the size handling, and explicitly checking
> that specific fields are present before using them. 
> 
> I think I'm going to add a method on the ACPI device to enable the
> precise clock information. I haven't done that in the driver yet; it
> still just consumes the precise clock information if it happens to be
> present already. The enable method can be added in a compatible fashion
> (the failure mode is that guests which don't invoke this method when
> the hypervisor needs them to will see only the disruption signal and
> not precise time).
> 
> For the HID I'm going to use AMZNVCLK. I had used QEMUVCLK in the QEMU
> patches, but I'll change that to use AMZNVCLK too when I repost the
> QEMU patch.

That doesn't fit with ACPI _HID definitions.
Second set 4 characters need to be hex digits as this is an
ACPI style ID (which I assume this is given AMZN is a valid
vendor ID.  6.1.5 in ACPI v6.5

Maybe I'm missing something...

J



