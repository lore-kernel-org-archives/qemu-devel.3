Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343BCCFC279
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dtf-0002LJ-2l; Tue, 15 Oct 2024 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t0dtd-0002Ka-Br
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t0dtb-0005Mp-1g
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728984673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aW4aksiIRieshzWK2lNxH1StV9FfxeqmsHHdPr0cfL4=;
 b=eiGwlMVtKR5Fw4zWw3FOZ2cXlygp+/nHMQEoyN0qrP16mWLXMfSAxmiJ+pPHdPcm1IrUj/
 gwIdYDW/alqrE+D91OgGl982fYngKzFz5KO6vxyoGseRcAouKzt64hcUIIqixybNBBch7P
 W+vkmu/B+4Ik5QvgzClkxd2xZrIYIjk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ziBYchEpMIS6n7izf3hNaw-1; Tue, 15 Oct 2024 05:31:10 -0400
X-MC-Unique: ziBYchEpMIS6n7izf3hNaw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso1428433f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 02:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984669; x=1729589469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aW4aksiIRieshzWK2lNxH1StV9FfxeqmsHHdPr0cfL4=;
 b=gbLDHpIaduIP/qp0PD1zFyZyWJsxPVb7OniUu4wbRIt3HSWr9HaKVvkvqgPvqEEHwS
 x7kThi4CPEjGZIKC9IzeO2LJvElE2MpWNK1Q55Bcp/NQwHqbwN4z8rBxhyEX2cfGGNUm
 vOyDqazIEr0u6yq+d9MvxulsI3m3VH4AM6IgS7StLmRI4jDxiNqsMJJBr29UYiKVuGUQ
 T3wQEZpQ6kRKBGyrTBHvw2STsT0qus/9mnmMRPcLE3vvCryIsvWxXoob5uKo9cwKbnaW
 fPRIzTWIVqxL4s0663AxmEiX/okWcwZw/YkTUlw4gYM29wUCGthGlh/93zweBhjXWL5S
 8NBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWud0rwXEjQaXUoSTOYzb3OWoFPfegLMZxvCX8rGrCOr+YL6qDcBIZ6xZ+jgPHa9Yru9pw5gFG5HHAZ@nongnu.org
X-Gm-Message-State: AOJu0Yx9yTnI8ZxktFW2gnr5cPGjT8Vkp0F+x6M5RdE6cuGeAelOdBWc
 Lm2MIV2wK6/Tw99hzLPV9sfw5vIUH4FZY526sCICWFmyv07ur5GAIxTCjZeG0mltJyIE6LHvfhB
 o50LvK27zYlMbJbtpl09fqmLaRwrSrAPvzxWVX+8KrFZNa8ExXg2i
X-Received: by 2002:a05:600c:605a:b0:431:43c6:e868 with SMTP id
 5b1f17b1804b1-43143c6e977mr8065045e9.23.1728984669259; 
 Tue, 15 Oct 2024 02:31:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnLAS3PyP7FaNG67DMmpwU5f57BZdwMV9jgifllBi96Lz0QZVzcF1QFv4bqMqiwj9gXDj4FQ==
X-Received: by 2002:a05:600c:605a:b0:431:43c6:e868 with SMTP id
 5b1f17b1804b1-43143c6e977mr8064815e9.23.1728984668832; 
 Tue, 15 Oct 2024 02:31:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm12145495e9.22.2024.10.15.02.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 02:31:08 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:31:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: maobibo <maobibo@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, zhukeqian <zhukeqian1@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Gavin Shan
 <gshan@redhat.com>, Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, "Miguel Luis"
 <miguel.luis@oracle.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20241015113105.121216e5@imammedo.users.ipa.redhat.com>
In-Reply-To: <f134c3491a4143269eb24d3023be82e6@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
 <f134c3491a4143269eb24d3023be82e6@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
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

On Mon, 14 Oct 2024 20:05:58 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
>=20
> >  From: qemu-devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org <qemu-
> >  devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Igor
> >  Mammedov
> >  Sent: Monday, October 14, 2024 10:38 AM
> > =20
> >  On Mon, 14 Oct 2024 16:52:55 +0800
> >  maobibo <maobibo@loongson.cn> wrote:
> >   =20
> >  > Hi Salil,
> >  >
> >  > When I debug cpu hotplug on LoongArch system, It reports error like =
this:
> >  >      ACPI BIOS Error (bug): Could not resolve symbol [\_SB.GED.CSCN],
> >  > AE_NOT_FOUND
> >  >      ACPI Error: Aborting method \_SB.GED._EVT due to previous error
> >  > (AE_NOT_FOUND)
> >  >      acpi-ged ACPI0013:00: IRQ method execution failed
> >  >
> >  >
> >  > With this patch, GED CPU call method is "\\_SB.GED.CSCN", however in
> >  > function build_cpus_aml(), its method name is "\\_SB.CPUS.CSCN".
> >  >      method =3D aml_method(event_handler_method, 0, =20
> >  AML_NOTSERIALIZED); =20
> >  >      aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> >  >      aml_append(table, method);
> >  >
> >  > It seems that CPU scanning method name is not consistent between
> >  > function build_cpus_aml() and build_ged_aml().
> >  >
> >  > Regards
> >  > Bibo Mao
> >  >
> >  > On 2024/7/23 =E4=B8=8B=E5=8D=886:59, Michael S. Tsirkin wrote: =20
> >  > > From: Salil Mehta <salil.mehta@huawei.com>
> >  > >
> >  > > OSPM evaluates _EVT method to map the event. The CPU hotplug =20
> >  event =20
> >  > > eventually results in start of the CPU scan. Scan figures out the
> >  > > CPU and the kind of
> >  > > event(plug/unplug) and notifies it back to the guest. Update the G=
ED
> >  > > AML _EVT method with the call to method \\_SB.CPUS.CSCN (via
> >  > > \\_SB.GED.CSCN)
> >  > >
> >  > > Architecture specific code [1] might initialize its CPUs AML code =
by
> >  > > calling common function build_cpus_aml() like below for ARM:
> >  > >
> >  > > build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry, =20
> >  memmap[VIRT_CPUHP_ACPI].base, =20
> >  > >                 "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY); =20
> > =20
> >  it should be \\_SB.CPUS.CSCN =20
>=20
>=20
> I guess we are getting back to where we started then?
>=20
> https://lore.kernel.org/qemu-devel/20240706162845.3baf5568@imammedo.users=
.ipa.redhat.com/
>=20

Indeed, CSCN in name had me confused,
perhaps it would be better to rename that something else.
maybe something like s/_SB.GED.CSCN/_SB.GED.ECPU/

> Excerpt from above discussion and your suggestion:
> [...]
>=20
> I don't particularly like exposing cpu hotplug internals for outside code
> and then making that code do plumbing hoping that nothing will explode
> in the future.
>=20
> build_cpus_aml() takes event_handler_method to create a method that
> can be called by platform. What I suggest is to call that method here
> instead of trying to expose CPU hotplug internals and manually building
> call path here.
> aka:
>   build_cpus_aml(event_handler_method =3D PATH_TO_GED_DEVICE.CSCN)
> and then call here=20
>   aml_append(if_ctx, aml_call0(CSCN));
> which will call  CSCN in GED scope, that was be populated by
> build_cpus_aml() to do cpu scan properly without need to expose
> cpu hotplug internal names and then trying to fixup conflicts caused by t=
hat.
>=20
> PS:
> we should do the same for memory hotplug, we see in context above
>=20
> [...]
>=20
>=20
> Solution:
> I've avoided above error in different way and keeping exactly what you
> suggested \_SB.PATH_TO_GED_DEVICE.CSCN i.e. \_SB.GED.CSCN
> Please have a look:
>=20
> https://lore.kernel.org/qemu-devel/20241009031815.250096-16-salil.mehta@h=
uawei.com/
>=20
> Many thanks!
>=20
>=20
> Best regards
> Salil.
>=20


