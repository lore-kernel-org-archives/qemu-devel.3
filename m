Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA17C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fhn-0000HW-PQ; Fri, 04 Apr 2025 07:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0fhW-0000Gg-Sn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0fhU-0003iQ-Uc
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743767947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQM0DPkfAorfuQC4l4nYyGqEewUpTJzbaM4iHZFpOjU=;
 b=SwuddGMFTs5a1LBj/wAv+VMX8OwpCvkVNEV+FJREsfPZChfg0JhJ1FE/XRnmINa9CxmKAV
 E3io1k2XDeVZDuxHA4LVSt5hZ1ZG8oIMhuLSoP5MRmxMWQqOI4xXL6aDMtbhLoHTPjzaSa
 hK4cx2kY3QCgxxYgocY4KGQDmAt94xo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-dyRqVlZ2MzmzTpwF-Phk0w-1; Fri, 04 Apr 2025 07:59:05 -0400
X-MC-Unique: dyRqVlZ2MzmzTpwF-Phk0w-1
X-Mimecast-MFC-AGG-ID: dyRqVlZ2MzmzTpwF-Phk0w_1743767944
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso14326785e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743767943; x=1744372743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQM0DPkfAorfuQC4l4nYyGqEewUpTJzbaM4iHZFpOjU=;
 b=WN9TyR2PXQ10YtMh3guy4KffpWP1HDQdPg36spOmpRTnbq6bDWgD5y6KzCiNfEssMQ
 26L5DlR5M2cfP+5droPQnP3OANUvwpy4cQTw/vYCFzNo75a3a7/OibgbNu6fu0zvcPp6
 HtV1gQ8Kwu7WFETmRsQyXLe/Eiq6n0iiEvrTFaPZgz+gcVihMGIFCHaQEOiyP92yfYs7
 A85FpXDF2cMqYKVXz+QF0t8rLQLX/K0fuAbdbx/O9QMdAgT1GA1FkwK5rigWGP/PzHkp
 yXQgCfnnwgn9isjv6PC21G9J/HT9+d0f86RChqBOJ4NGIbBjwRrDtU/iWCgpWpjfRYkL
 mqWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEBxX5WnsY706K7gfQVP74GL8AwLUS/zYsDoFy9m7NjR2SurRrO8IGOUE7pL3sQThkgyzdiPCqk/2h@nongnu.org
X-Gm-Message-State: AOJu0Yy1ImlX4kX//Ri0twZHaGqcXJvKSFzt1iTNMWgtvDHeVQBUlHks
 EuJL60p+GAnMqIzSCQKTbA58wz0qGN9x8HWMruPUHcvAOnOqaTZtmQRFZbbib3h0apxMvPuNxV8
 e50gt4luqWTaBxDp+sX9q7kW7JiN3pqxxhPuJGG/Gtj3ChQOHIidDVb1Ec6L8
X-Gm-Gg: ASbGncuPuyYw7xE3jmaDmfWFhkAZiNifjIclfB7Q31Zee7tt0UdoL51NPGqthltp3VC
 udTec5+U8LJLKn/6iucTp3x8wMmr6gBJ/9BzQ6B2rBRjkkPYL8hiyqQi/B+MJ43ms1xn5yTxEk/
 35HYbCd2KpurK0Nglwov7GXswxYKLhyHWzhqbaVsQE+aaj2xmDdM37KflHhwQx25c4iZ1LeMYHC
 C4lkvjlChwLNTtnzn+GJmhrZA+KjVeVcEemxcuWavk5FgZEofLuamBzV3IARbdyaWblAjhRQsX3
 A7tcPcL+QPt0Hh/2P5S4lJOeRUntzgsdTcoQ
X-Received: by 2002:a05:600c:1ca4:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43ecf842872mr23691155e9.7.1743767943083; 
 Fri, 04 Apr 2025 04:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcx9NPaHVvx/EfiN147qJ/I7hmMYgl0nOTrEeF5HrlYc4BdsXR5vPQu3W0HnUhDedU1hsxTA==
X-Received: by 2002:a05:600c:1ca4:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43ecf842872mr23691035e9.7.1743767942715; 
 Fri, 04 Apr 2025 04:59:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364cb9asm43888945e9.31.2025.04.04.04.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 04:59:02 -0700 (PDT)
Date: Fri, 4 Apr 2025 13:59:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v6 3/6] hw/loongarch/virt: Fix error handling in cpu unplug
Message-ID: <20250404135901.2f102a66@imammedo.users.ipa.redhat.com>
In-Reply-To: <ff30bac6-9004-0ba2-505a-3406e66623da@loongson.cn>
References: <20250321031259.2419842-1-maobibo@loongson.cn>
 <20250321031259.2419842-4-maobibo@loongson.cn>
 <87ecyq98y1.fsf@pond.sub.org>
 <87d1b58e-1b8b-f582-753b-574c4ba44a6b@loongson.cn>
 <87ldsy7sry.fsf@pond.sub.org>
 <ff30bac6-9004-0ba2-505a-3406e66623da@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 21 Mar 2025 15:35:37 +0800
bibo mao <maobibo@loongson.cn> wrote:

> On 2025/3/21 =E4=B8=8B=E5=8D=883:21, Markus Armbruster wrote:
> > bibo mao <maobibo@loongson.cn> writes:
> >  =20
> >> +Igor
> >>
> >>
> >> On 2025/3/21 =E4=B8=8B=E5=8D=882:47, Markus Armbruster wrote: =20
> >>> Bibo Mao <maobibo@loongson.cn> writes:
> >>> =20
> >>>> In function virt_cpu_unplug(), it will send cpu unplug message to
> >>>> interrupt controller extioi and ipi irqchip. If there is problem in
> >>>> this function, system should continue to run and keep state the same
> >>>> before cpu is removed.
> >>>>
> >>>> If error happends in cpu unplug stage, send cpu plug message to exti=
oi
> >>>> and ipi irqchip to restore to previous stage, and then return immedi=
ately.
> >>>>
> >>>> Fixes: 2cd6857f6f5b (hw/loongarch/virt: Implement cpu unplug interfa=
ce)
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>    hw/loongarch/virt.c | 6 ++++++
> >>>>    1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> >>>> index 8563967c8b..503362a69e 100644
> >>>> --- a/hw/loongarch/virt.c
> >>>> +++ b/hw/loongarch/virt.c
> >>>> @@ -958,6 +958,8 @@ static void virt_cpu_unplug(HotplugHandler *hotp=
lug_dev,
> >>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &e=
rr);
> >>>>        if (err) {
> >>>>            error_propagate(errp, err);
> >>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
> >>>> +                             &error_abort);
> >>>>            return;
> >>>>        }
> >>>>   =20
> >>>> @@ -965,6 +967,10 @@ static void virt_cpu_unplug(HotplugHandler *hot=
plug_dev,
> >>>>        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, =
&err);
> >>>>        if (err) {
> >>>>            error_propagate(errp, err);
> >>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev,
> >>>> +                             &error_abort);
> >>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev,
> >>>> +                             &error_abort);
> >>>>            return;
> >>>>        } =20
> >>>
> >>> virt_cpu_unplug() calls hotplug_handler_unplug() three times to notify
> >>> ipi, extioi, and acpi_get.  If any notification fails, virt_cpu_unplu=
g()
> >>> calls hotplug_handler_plug() to "un-notify" the preceeding ones, if a=
ny.
> >>> This must not fail.
> >>>
> >>> virt_cpu_plug() does it the other way round (see previous patch).
> >>>
> >>> So, hotplug_handler_plug() must not fail in virt_cpu_unplug(), yet we
> >>> check for it to fail in virt_cpu_plug().
> >>>
> >>> Can it really fail in virt_cpu_plug()?
> >>>
> >>> If yes, why can't it fail in virt_cpu_unplug()? =20
> >> you can check function acpi_cpu_plug_cb()/loongarch_ipi_cpu_plug(), th=
at
> >> is cpuplug callback for acpi_ged and ipi. it will not fail.
> >>
> >> If *virt_cpu_pre_plug()* pass, it will succeed.
> >>
> >> Regards
> >> Bibo Mao
> >> =20
> >>>
> >>> Same questions for hotplug_handler_unplug(). =20
> >=20
> > Let me restate my argument.
> >=20
> > We call hotplug_handler_plug() on the happy path, and on error recovery
> > paths.  Four cases:
> >=20
> > 1. Can fail on the happy path
> >=20
> >     Error recovery is required.
> >=20
> > 1.1 Can fail on the error recovery path
> >=20
> >      Error recovery is required, but broken.
> >=20
> > 1.2 Can't fail on the error recovery path
> >=20
> >      Error recovery is required and works, but why it works is not
> >      obvious.  Deserves a comment explaining why hotplug_handler_plug()
> >      can't fail here even though it can fail on the happy path next doo=
r.
> >=20
> > 2. Can't fail on the happy path
> >=20
> >     Error recovery is unreachable.
> >=20
> > 2.1 Can fail on the error recovery path
> >=20
> >      Error recovery is unreachable and broken.  Possibly a time bomb, a=
nd
> >      possibly misleading readers.
> >=20
> > 2.2 Can't fail on the error recovery path
> >=20
> >      Error recovery is unreachable and would work, but why it would work
> >      is again a not obvious.
> >=20
> > Which of the four cases is it? =20
> By my understanding, it is "2. Can't fail on the happy path",  and Error=
=20
> recovery is unreachable.
>=20
> I have said that it is impossible and recovery is only for future use.

_plug() handler can't fail hence error_abort.
the same likely goes for _unplug() though I haven't audited it's usage so I=
 won't bet here.
In cpu/mem cases it shall not fail, but there were cases where device_del b=
ypasses
_unplug_request and calls _unplug directly (and those should be re-checked)

handlers that can fail and require graceful recovery are _pre and _request =
variants.

wrt: _plug() handler, we shall drop errp argument across the tree so
it won't confuse anyone, smth like this:
   hotplug_handler_plug(otplugHandler *hotplug_dev, DeviceState *dev)
and then fixup callers to do the same.

Bibo,
can you take care of that?


Perhaps also check _unplug path and if it shall not fail either, clean it u=
p as well.

>=20
> do you mean recovery should be removed? And directly &error_abort is=20
> used in virt_cpu_plug() such as:
> static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>                            DeviceState *dev, Error **errp)
> {
>    if (lvms->ipi) {
>      hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);
>=20
> Regards
> Bibo Mao
>=20


