Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA84D216B0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0id4-0004RK-Sy; Tue, 15 Oct 2024 10:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t0id0-0004Qe-2q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t0icy-0005Ka-8R
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729002861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWHxV6M7jizQ2LD+96Xl4mLqv+vLTcJ+RknXLhZ161E=;
 b=N6olZov7Cxfu7bgd9qCKWTC+EDXSSiKl7xHE5BM7R8g6GvHTI1ycweP4tkM7vrOPqTsXwk
 Y2Eig79iwcIpq00mu5hqT5levGp1O4jJfypnisDtUZ/4HOysD2DYjkHK877XebCG3TNryf
 usD7QYY1i12GAnk/XLJmlGaiEREAzY0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-cePYnWpyOYW3zXVARdT7ZQ-1; Tue, 15 Oct 2024 10:34:20 -0400
X-MC-Unique: cePYnWpyOYW3zXVARdT7ZQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431207426e3so18381035e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729002859; x=1729607659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWHxV6M7jizQ2LD+96Xl4mLqv+vLTcJ+RknXLhZ161E=;
 b=AJ5KO+6dQlflVWs9fbM32Ns/t3upSVA1YBNJkFpkuHrwiECIN9AjPdDWSu/nloEmw6
 xKNRheCHQ1N2SmbnxjpPV3OY1pNQ0658CJ0sukKLIlu3EkKa6NaTT4itIzvPmanQ7oPJ
 flU/IbVmz0ghqqC30AKXVNCdmsW7gU2tGHE9UcCkDueF0i01CpC4Gs6B/Lcdchw0T+TQ
 WLk8CLiKzePDLqDElLly/r74CgJ2ub6RopAZ44k6HvPahm7uOyNFwYZuHiJ18hmf1Moc
 3bWwPlsHcUUzZNSP1a0TTToO/jq2eqyMTcm7RAze4Gk/5txScgYgNjBqIvN1rrKXWWrA
 K08A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlj25EuhI8mCJLXCRfNAVLDX76IJAOGo8Ww67jG/Q2uVnpMDIsAL8suozz4BrmT2fvaBr6u7CVfieY@nongnu.org
X-Gm-Message-State: AOJu0YyKuyIfyxXWaH/PxCglYj9viu0PIOmNMrFCn3xD0LJWft0TUMQR
 eaW26NGJsvxcRM2QPbwE2ceflMj+Z9LxlS0IQ3T0zbq2sulsmLMTmDTe6oi7B+uDImwD/xuYzn+
 7FzcEISJBWo+BPQMkTPL1x+UXmaVvYk+n6PBYR2fsPDBLM56W3P01
X-Received: by 2002:a5d:6644:0:b0:37c:f997:5b94 with SMTP id
 ffacd0b85a97d-37d8628dac4mr791547f8f.12.1729002858949; 
 Tue, 15 Oct 2024 07:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Ht2ntdQ3UdJy7FErjkUXsBR8lQPWHWCwcCf4+5RYb+8PGlf1DxDueXvNPotwLlFKL8TZpg==
X-Received: by 2002:a5d:6644:0:b0:37c:f997:5b94 with SMTP id
 ffacd0b85a97d-37d8628dac4mr791524f8f.12.1729002858552; 
 Tue, 15 Oct 2024 07:34:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc11ff7sm1717633f8f.92.2024.10.15.07.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:34:17 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:34:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: maobibo <maobibo@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, zhukeqian <zhukeqian1@huawei.com>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, Gavin Shan
 <gshan@redhat.com>, "Vishnu Pajjuri" <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20241015163416.36da248a@imammedo.users.ipa.redhat.com>
In-Reply-To: <bb1fcf595ac04cac95bb3cc86ff9d242@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
 <f134c3491a4143269eb24d3023be82e6@huawei.com>
 <20241015113105.121216e5@imammedo.users.ipa.redhat.com>
 <bb1fcf595ac04cac95bb3cc86ff9d242@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 15 Oct 2024 09:41:24 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> HI Igor,
>=20
> >  From: Igor Mammedov <imammedo@redhat.com>
> >  Sent: Tuesday, October 15, 2024 10:31 AM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  Cc: maobibo <maobibo@loongson.cn>; qemu-devel@nongnu.org; Michael
> >  S. Tsirkin <mst@redhat.com>; Peter Maydell <peter.maydell@linaro.org>;
> >  zhukeqian <zhukeqian1@huawei.com>; Jonathan Cameron
> >  <jonathan.cameron@huawei.com>; Gavin Shan <gshan@redhat.com>;
> >  Vishnu Pajjuri <vishnu@os.amperecomputing.com>; Xianglai Li
> >  <lixianglai@loongson.cn>; Miguel Luis <miguel.luis@oracle.com>; Shaoqin
> >  Huang <shahuang@redhat.com>; Zhao Liu <zhao1.liu@intel.com>; Ani Sinha
> >  <anisinha@redhat.com>
> >  Subject: Re: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with
> >  CPU scan
> > =20
> >  On Mon, 14 Oct 2024 20:05:58 +0000
> >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >   =20
> >  > Hi Igor,
> >  > =20
> >  > >  From: qemu-devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org =20
> >  <qemu- =20
> >  > > devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of =20
> >  Igor =20
> >  > > Mammedov
> >  > >  Sent: Monday, October 14, 2024 10:38 AM
> >  > >
> >  > >  On Mon, 14 Oct 2024 16:52:55 +0800
> >  > >  maobibo <maobibo@loongson.cn> wrote:
> >  > > =20
> >  > >  > Hi Salil,
> >  > >  >
> >  > >  > When I debug cpu hotplug on LoongArch system, It reports error =
like =20
> >  this: =20
> >  > >  >      ACPI BIOS Error (bug): Could not resolve symbol [\_SB.GED.=
CSCN],
> >  > >  > AE_NOT_FOUND
> >  > >  >      ACPI Error: Aborting method \_SB.GED._EVT due to previous =
error
> >  > >  > (AE_NOT_FOUND)
> >  > >  >      acpi-ged ACPI0013:00: IRQ method execution failed
> >  > >  >
> >  > >  >
> >  > >  > With this patch, GED CPU call method is "\\_SB.GED.CSCN", howev=
er =20
> >  > > in  > function build_cpus_aml(), its method name is "\\_SB.CPUS.CS=
CN". =20
> >  > >  >      method =3D aml_method(event_handler_method, 0, =20
> >  > >  AML_NOTSERIALIZED); =20
> >  > >  >      aml_append(method, aml_call0("\\_SB.CPUS." =20
> >  CPU_SCAN_METHOD)); =20
> >  > >  >      aml_append(table, method);
> >  > >  >
> >  > >  > It seems that CPU scanning method name is not consistent between
> >  > > > function build_cpus_aml() and build_ged_aml().
> >  > >  >
> >  > >  > Regards
> >  > >  > Bibo Mao
> >  > >  >
> >  > >  > On 2024/7/23 =E4=B8=8B=E5=8D=886:59, Michael S. Tsirkin wrote: =
=20
> >  > >  > > From: Salil Mehta <salil.mehta@huawei.com>  > >  > > OSPM =20
> >  > > evaluates _EVT method to map the event. The CPU hotplug  event  > >
> >  > > eventually results in start of the CPU scan. Scan figures out the =
 > =20
> >  > > > CPU and the kind of  > > event(plug/unplug) and notifies it back=
 =20
> >  > > to the guest. Update the GED  > > AML _EVT method with the call to
> >  > > method \\_SB.CPUS.CSCN (via  > > \\_SB.GED.CSCN)  > >  > >
> >  > > Architecture specific code [1] might initialize its CPUs AML code =
by =20
> >  > > > > calling common function build_cpus_aml() like below for ARM:
> >  > >  > >
> >  > >  > > build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry, =20
> >  > > memmap[VIRT_CPUHP_ACPI].base, =20
> >  > >  > >                 "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY)=
; =20
> >  > >
> >  > >  it should be \\_SB.CPUS.CSCN =20
> >  >
> >  >
> >  > I guess we are getting back to where we started then?
> >  >
> >  > https://lore.kernel.org/qemu- =20
> >  devel/20240706162845.3baf5568@imammedo.us =20
> >  > ers.ipa.redhat.com/
> >  > =20
> > =20
> >  Indeed, CSCN in name had me confused,
> >  perhaps it would be better to rename that something else.
> >  maybe something like s/_SB.GED.CSCN/_SB.GED.ECPU/ =20
>=20
>=20
> Sure, we can definitely improve. But we are indeed triggering CPU Scan
> here so I don=E2=80=99t understand how will `ECPU` be more intuitive than
> `CSCN`.  what about below?
>=20
> s/_SB.GED.CSCN/_SB.GED.CPUSCAN/

ACPI name segment is limited to 4 characters only.

ECPU - Event handler for CPU
it could be something else though

the point is not confuse it with CSCN (apparently different namespace but
still it could lead to confusion as above shows )

>=20
>=20
> Thanks
> Salil.
>=20
> >   =20
> >  > Excerpt from above discussion and your suggestion:
> >  > [...]
> >  >
> >  > I don't particularly like exposing cpu hotplug internals for outside
> >  > code and then making that code do plumbing hoping that nothing will
> >  > explode in the future.
> >  >
> >  > build_cpus_aml() takes event_handler_method to create a method that
> >  > can be called by platform. What I suggest is to call that method here
> >  > instead of trying to expose CPU hotplug internals and manually
> >  > building call path here.
> >  > aka:
> >  >   build_cpus_aml(event_handler_method =3D =20
> >  PATH_TO_GED_DEVICE.CSCN) and =20
> >  > then call here
> >  >   aml_append(if_ctx, aml_call0(CSCN)); which will call  CSCN in GED
> >  > scope, that was be populated by
> >  > build_cpus_aml() to do cpu scan properly without need to expose cpu
> >  > hotplug internal names and then trying to fixup conflicts caused by =
that.
> >  >
> >  > PS:
> >  > we should do the same for memory hotplug, we see in context above
> >  >
> >  > [...]
> >  >
> >  >
> >  > Solution:
> >  > I've avoided above error in different way and keeping exactly what y=
ou
> >  > suggested \_SB.PATH_TO_GED_DEVICE.CSCN i.e. \_SB.GED.CSCN Please =20
> >  have =20
> >  > a look:
> >  >
> >  > https://lore.kernel.org/qemu-devel/20241009031815.250096-16-salil.me=
ht
> >  > a@huawei.com/
> >  >
> >  > Many thanks!
> >  >
> >  >
> >  > Best regards
> >  > Salil.
> >  > =20
> >   =20
>=20


