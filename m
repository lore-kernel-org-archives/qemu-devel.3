Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C60606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRxYe-0002EW-IA; Fri, 13 Nov 2026 15:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xRxYc-0002DT-TV
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 15:07:34 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xRxYa-0000gV-NW
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 15:07:34 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6DAD460C38A;
 Fri, 13 Nov 2026 21:07:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id zXqDAyshLcTx; Fri, 13 Nov 2026 21:07:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 61F1F60C349; Fri, 13 Nov 2026 21:07:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 601D913991F;
 Fri, 13 Nov 2026 21:07:26 +0100 (CET)
Date: Fri, 13 Nov 2026 21:07:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: QEMU Developers <qemu-devel@nongnu.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Who should be allowed to unrealize a device, and what can you
 still do with it afterwards?
In-Reply-To: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
Message-ID: <de8cfd7a-9c43-44ac-baba-c8f892749dc4@eik.bme.hu>
References: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026, Peter Maydell wrote:
> We give QOM objects a reference count. This means that if you are
> going to try to use one, you can take a ref to it, and then you're
> guaranteed that it won't disappear while you're working with it.
>
> For QDEV devices, we add the "realize" and "unrealize" steps to
> the lifecycle. There is no "reference count for having a realized
> device". So what do we intend here?
>
> (1) We could say that if you have a reference to the device then you
> can assume it's not going to be unrealized under your feet, and have
> very careful rules about who can unrealize a device and when.
>
> (2) We could say that if you have a reference to the device then it
> might be unrealized, but it won't be deinitialized, and you can assume
> that all the API calls you might make on it will in some sense still
> work, and at any rate at least won't try to access memory that's been
> freed or crash.

I have no idea but (2) seems to be impossible to achieve without likely 
also patching all devices one by one that don't expect this now. So I 
think requiring that a device should only be unrealized if the caller of 
unrealize has the only reference to it would make sense. This is at least 
easy to check but may not be easy to ensure in every case but, failing 
that may only leave a leaked device at worst but not break things. So I'd 
vote (1).

Regards,
BALATON Zoltan

