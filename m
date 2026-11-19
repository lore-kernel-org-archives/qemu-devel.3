Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573D606D3A8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2Vu-0001aQ-05; Thu, 19 Nov 2026 08:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xU2Vr-0001Zv-IG
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:49:19 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xU2Vp-0005or-O0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:49:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8500060E017;
 Thu, 19 Nov 2026 14:49:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id QkCo2g5LEeTI; Thu, 19 Nov 2026 14:49:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3A1A260CCE7; Thu, 19 Nov 2026 14:49:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 373A713C28F;
 Thu, 19 Nov 2026 14:49:11 +0100 (CET)
Date: Thu, 19 Nov 2026 14:49:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Who should be allowed to unrealize a device, and what can you
 still do with it afterwards?
In-Reply-To: <CAFEAcA8VP4vf6=x6Np26FLYHBNXt2OzRMna92F6uJFvde=jCcA@mail.gmail.com>
Message-ID: <ce91d0a4-8364-752b-fc74-e45e6a51e35f@eik.bme.hu>
References: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
 <de8cfd7a-9c43-44ac-baba-c8f892749dc4@eik.bme.hu>
 <CAFEAcA9BnWRnyMp4rswY1dxA4b5FQpQhK3YsGYGPXzwa-5YfGA@mail.gmail.com>
 <64F81A8F-4EC2-4147-B254-089A2D956264@gmail.com>
 <CAFEAcA8VP4vf6=x6Np26FLYHBNXt2OzRMna92F6uJFvde=jCcA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Thu, 19 Nov 2026, Peter Maydell wrote:
> On Wed, 18 Nov 2026 at 18:58, Bernhard Beschow <shentey@gmail.com> wrote:
>> Am 14. November 2026 10:37:09 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
>>> One thing I'm not sure about is what unrealize is actually for.
>>> Is there ever anything that a device needs to do in unrealize that
>>> it could not postpone to deinit?
>>
>> I think this question boils down to what the difference between init() and realize() is. deinit() and unrealize() should be their respective duals, i.e. undo what has been done there.
>
> The main reason IMHO that we have split init and realize is:
> (1) init can't fail, so operations that can fail go in realize
> (2) operations that depend on properties set on the device
>     need to go in realize, which runs after properties are set
>
> But neither of those apply to unrealize:
> * unrealize can't fail
> * there's no equivalent of setting properties that happens
>   during the unrealize-and-destroy sequence
>
> "Undo in unrealize what you did in realize, and undo in
> deinit what you did in init" sounds like a nice rule, except
> for the fact that we have no reference counting for "keep
> this device realized', so there's no way for users of the
> device to make sure that things they're relying on don't
> go away if you clean them up in unrealize.

I think the question is if an unrealized device is useful to keep for 
anything. I can't think of a reason but I don't know a lot of details of 
QEMU so there might be some cases when that happens. I think this was your 
question too. If there's no reason to keep unrealized devices I'd say 
unrealize should not be called by anybody except qdev itself and do that 
on destroying the object which should only happen if there are no 
references left so that would ensure we won't have unrealized devices and 
other parts don't have to deal with it (which I think is better than 
trying to handle it at some places that could miss others or introduce 
problems in future models that don't handle this).

Currently within qdev hw/code/bus.c seems to be unrealizing devices apart 
from qdev itself, and some other device models call qdev_unrealize. 
Probably those should be reviewed why those are needed and if they could 
be replaced with proper refcounting so devices would be freed and 
unrealized by that or if there's any reason to keep devices unrealized but 
not destroyed. I've found these with
git grep "object_property_set.*realized\|qdev_unrealize"

Regards,
BALATON Zoltan

