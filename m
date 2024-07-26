Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D188BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 16:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXNjc-0004qr-2X; Fri, 26 Jul 2024 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+54b4fdbe2f31b2bce0ce+7642+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sXNja-0004qH-S5
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:23:58 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+54b4fdbe2f31b2bce0ce+7642+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sXNjX-0004Hc-KH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=41663bMFA4MJ9CK5rUQXGIVfpcilzT1W+csMGnpYlEQ=; b=T89omwwVfh59xYu5VR+dN2nEQX
 dK9ZaHd3xfexNMfFsajB6aWDwohmK72hGNicz1fn9+99oXeuo2aLacK85UC9icqs1g378R4qJ43y5
 KVncNahhEL5yGrgpeOOJ7+SkKUlsmxSzzo1hXmjmz4U1c5x7ChemYnlEfYrXclu15o8JKggBjo9Dg
 o1qF+Vz0JJX+q95ZbXY93JfHg40QPZc6xQdLl4XqUQ8CEnurrxWo9yRONIIqD/rfwBxNCXOwgnf+6
 0BRg6ZYaKE/xptx0Tg0J9e2aRGs9onh/Ys+xTLisWprb/RDnFpgJGe2hKUp4GKUdZiCIvx52v9Y4A
 ZW2BH6Eg==;
Received: from [2a00:23ee:1910:3d2f:6a4d:614a:18ee:5940] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sXNj8-00000004G7h-1mz2; Fri, 26 Jul 2024 16:23:30 +0000
Date: Fri, 26 Jul 2024 17:23:27 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>,
 "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] ptp: Add vDSO-style vmclock support
User-Agent: K-9 Mail for Android
In-Reply-To: <20240726075734.1ee6a57c@kernel.org>
References: <7b3a2490d467560afd2fe08d4f28c4635919ec48.camel@infradead.org>
 <20240726075734.1ee6a57c@kernel.org>
Message-ID: <C24DBE80-D654-49D6-A021-E84F10238F86@infradead.org>
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

On 26 July 2024 15:57:34 BST, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>On Fri, 26 Jul 2024 13:28:17 +0100 David Woodhouse wrote:
>> +`       status =3D acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
>
>   ^ watch out for ticks!

Oops, that last minute space->tab fix after I'd already left home for the =
weekend was clearly not as cosmetic as I'd intended=2E Will fix; thanks!

