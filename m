Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3407C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 06:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYK9h-0003hL-J9; Mon, 29 Jul 2024 02:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2bd621eeca9bebf9fb5a+7645+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sYK9Y-0003fq-Rm
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:46:42 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2bd621eeca9bebf9fb5a+7645+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sYK9T-0006gY-RQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=R3wogILUarLMuOKLK0lDpfm3PIGb/vJu4lEvZa0OeBM=; b=Fxru4Y+toyFmdCw6icmB/YNWlv
 j9jVZ7bm1SbESqDXtPHmtxrXQAOQOE0H0oSCGedJ1I+Kc8/K3MyMnf2Pu4vsPR7LMk1BXMWKPUb01
 TmuScp7QY9dxgDUhr0TOehkRw/RxA6kQqBZKWWoG+yAMXxloOiUiS3NkCZcI/oXAYfDzOaRk4n+r1
 it7UJNTjsT6qv1P4Rh0fbB6HtCA9CHciNGmKxWIOvJWn6LAEitXfz1ga200CmJGS4uLQcKHRElUuM
 kUFWYuhQFhY3qQnO/g99i0aAQLE5YuhJvXFdEdXwcjPDfkRGI6tVlRU45gi05n64a/SPKI24bCNFj
 WWshRG+w==;
Received: from dyn-224.woodhou.se ([90.155.92.224] helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sYK8s-00000004jfc-44xo; Mon, 29 Jul 2024 06:45:59 +0000
Date: Mon, 29 Jul 2024 07:45:59 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
In-Reply-To: <20240728111746-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
 <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
 <20240728062521-mutt-send-email-mst@kernel.org>
 <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
 <20240728111746-mutt-send-email-mst@kernel.org>
Message-ID: <92D47BE5-4D57-4C4A-A250-20B9C9EFD862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+2bd621eeca9bebf9fb5a+7645+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 28 July 2024 16:23:49 BST, "Michael S=2E Tsirkin" <mst@redhat=2Ecom> wro=
te:
>On Sun, Jul 28, 2024 at 02:07:01PM +0100, David Woodhouse wrote:
>> On 28 July 2024 11:37:04 BST, "Michael S=2E Tsirkin" <mst@redhat=2Ecom>=
 wrote:
>> >Glad you asked :)
>>=20
>> Heh, I'm not sure I'm so glad=2E Did I mention I hate ACPI? Perhaps it'=
s still not too late for me just to define a DT binding and use PRP0001 for=
 it :)
>>=20
>> >Long story short, QEMUVGID is indeed out of spec, but it works
>> >both because of guest compatibility with ACPI 1=2E0, and because no on=
e
>> >much uses it=2E

But why *did* it change from QEMU0003 which was in some of the patches tha=
t got posted?

>> I think it's reasonable enough to follow that example and use AMZNVCLK =
(or QEMUVCLK, but there seems little point in both) then?
>
>I'd stick to spec=2E If you like puns, QEMUC10C maybe?

Meh, might as well be sensible=2E I'll chase up which of my colleagues cur=
ates the AMZN space (which will no doubt be me by the end of that thread), =
and issue the next one from that=2E


