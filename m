Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27715CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOw08-0005Cc-7R; Mon, 18 May 2026 07:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wOw00-0005Bv-9D
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wOvzx-0006ee-DW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779103138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwEWrOOYTLAPMaO3lRn5iSKX4UDUY5G2Dr42FVTOx8E=;
 b=AoZlnr2A1Znc7EkgSC13zLyJkAm+1cjtat7HqVvPKvECIc9EQSOIFXa7ULqeKcXmePAbKU
 K+1bCmvs9suMpxdbVaqsuV6TV6FPerlCGTnN5atkA2/D0mhxPOWbewbn1G9o2STqOoJZP1
 HFQ+bpsyCx5xSP96pVPUY0HyzN1deHY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-UyQKlyHdNjKyBMuzCWXmQQ-1; Mon,
 18 May 2026 07:18:55 -0400
X-MC-Unique: UyQKlyHdNjKyBMuzCWXmQQ-1
X-Mimecast-MFC-AGG-ID: UyQKlyHdNjKyBMuzCWXmQQ_1779103134
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF6718005B6; Mon, 18 May 2026 11:18:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78D211956053; Mon, 18 May 2026 11:18:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6624B1800603; Mon, 18 May 2026 13:18:52 +0200 (CEST)
Date: Mon, 18 May 2026 13:18:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
Message-ID: <agrz1zBDwGc9Bvlo@sirius.home.kraxel.org>
References: <agRC56rkfb4z6zSO@redhat.com>
 <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
 <agrtSFk-XGA-EcQd@sirius.home.kraxel.org>
 <CAFEAcA9b2oeZaZtGkn5YPMKOXWDdZQEvdoBj5mGVh51aKi-BYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9b2oeZaZtGkn5YPMKOXWDdZQEvdoBj5mGVh51aKi-BYw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 18, 2026 at 12:00:02PM +0100, Peter Maydell wrote:
> On Mon, 18 May 2026 at 11:53, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > I fully support that too, recommending xhci since 2018 ;)
> >
> > https://www.kraxel.org/blog/2018/08/qemu-usb-tips/
> >
> > Except for the claim that windows 7 is in widespread use this
> > still applies today.
> 
> Is it still the case that the "-usb" QEMU option gives you the
> old OHCI/UHCI controller? (My quick look at the source code suggests
> it is.) If so, that's an unfortunate default, since it makes it very
> easy to pick the non-security-supported bad config by accident.

It was still the case when I stopped maintaining usb and it is unlikely
it has changed since.

> Could we make "-usb" give the PC machines an XHCI controller for new
> machine version types ?

Sounds reasonable to me.  libvirt has changed defaults years ago.

take care,
  Gerd


