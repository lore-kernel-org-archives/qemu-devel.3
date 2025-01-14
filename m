Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5764EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXe0P-00026w-69; Tue, 14 Jan 2025 05:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXe0M-00026g-Qk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXe0K-0001zn-8y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736849914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myPq1uOm35JFGG7Y8AsaBvG68ds3085UXWbKY+ZXWec=;
 b=f5tyTxsGvGIOcw+/PC0XNaWksUoYvalGLZ1xC29KDTAIqlza5CWCL/Nhk9tq9vRXQc3ELK
 LSqMHGLHTRov0m8m9k6gIqKWG6zM1q9mDs92b1ezZnyNWnmImMIEqFULLtvG8IvIzjFlEX
 9TAwcQsWyoSfGKXRQj3/wao4wp4aADM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-C5KdJcAGM3yuYG5Wo6Km1g-1; Tue, 14 Jan 2025 05:18:32 -0500
X-MC-Unique: C5KdJcAGM3yuYG5Wo6Km1g-1
X-Mimecast-MFC-AGG-ID: C5KdJcAGM3yuYG5Wo6Km1g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so3138102f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 02:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736849911; x=1737454711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myPq1uOm35JFGG7Y8AsaBvG68ds3085UXWbKY+ZXWec=;
 b=DPzNK1Of7s+Ezse4ajYb2H+Sd/yHWsy4zj8t2aOgzOpSLx5jkxDfCieBcWIpgydjsE
 CWpRmYVaCiTK3uLm392msQpuny30YzQSZk++/sFw+i8vf+QBQ2dSRPuf1MiBHp5K2zs8
 k/cg0e3POVG0JxnBEuZh+EXbZHaCxySCQEnf9YWR6qaFiOc5oBkItS076btR6K0i7V3Z
 HLV3iu4/QqWSA5AFGfnGgV7PTXXqR6oB+QfKVtwolu+aOsC9okEUQDIM2Xizef3CBAwf
 ycgVrN3X3CfoofsblZPFB/k27bwmzEDAicvn5gO0vJ0BZbO+PJOsxMAw2fUhOX5EdT3b
 mm+g==
X-Gm-Message-State: AOJu0Yxdz3af7NmiJeHtKyw1WjiwUH1v1glYmTFSE9YR8yWv5nAxYSQe
 J3pmebHUFi2Qy7LDTKgEy3PTz2VTw9Skpt74coRztoPmAGxIpbXHYXZRIfRXTdDHtNe33g9Wbyh
 bPsjNNDnoG92O9sxdmEIHr81WfC5BzZBJyBatDWsLFn+06bwwnfiP
X-Gm-Gg: ASbGncsEKAez1eUAWWxDIgU6lh03Bb+95sVq3k9XB2zxuVi4f+k8ics6BqUJ+X8nr0f
 MBmu1jUoZrFmYaLE1T18+4wNq1xv3YSyQn7CQIHn8t36lFWmNLAdC/xxIQvdkXy+wf/lMrcRinG
 oc2SvWii4Z763CqRxLISjlrR4VINA7aDcecgXX8NJOiFu+9ml/L3lKEdvn2CixM7bo5AVfZI5a0
 eGB0ONyLDHSQIEhslnwDZK4H77aCpmR28g4o4boXaQazcN5qmXTyiGG9j0hkiZnpwdJQXs5V7Ma
 TVBN/KYBoWMWj6/MZByaxLjxlPyK
X-Received: by 2002:a5d:648a:0:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38a87313097mr20629935f8f.33.1736849910916; 
 Tue, 14 Jan 2025 02:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFixRcnG/f3BfGntKkbUoqSNeX8NrFro3eBe/w8F7N0InEkzhdWgSm2pANOtacUXcL76NnXCQ==
X-Received: by 2002:a5d:648a:0:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38a87313097mr20629909f8f.33.1736849910506; 
 Tue, 14 Jan 2025 02:18:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bd0dsm14326817f8f.45.2025.01.14.02.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:18:29 -0800 (PST)
Date: Tue, 14 Jan 2025 11:18:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
In-Reply-To: <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 13 Jan 2025 17:00:55 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 13/1/25 13:28, Igor Mammedov wrote:
> > On Sun, 12 Jan 2025 23:16:40 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >  =20
> >> QDev objects created with object_new() need to manually add
> >> their parent relationship with object_property_add_child().
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >> Message-Id: <20240216110313.17039-22-philmd@linaro.org>
> >> ---
> >>   hw/i386/x86-common.c                     | 1 +
> >>   hw/microblaze/petalogix_ml605_mmu.c      | 1 +
> >>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
> >>   hw/mips/cps.c                            | 1 +
> >>   hw/ppc/e500.c                            | 1 +
> >>   hw/ppc/spapr.c                           | 1 +
> >>   6 files changed, 6 insertions(+)
> >>
> >> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> >> index 97b4f7d4a0d..9c9ffb3484a 100644
> >> --- a/hw/i386/x86-common.c
> >> +++ b/hw/i386/x86-common.c
> >> @@ -60,6 +60,7 @@ static void x86_cpu_new(X86MachineState *x86ms, int6=
4_t apic_id, Error **errp)
> >>       if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
> >>           goto out;
> >>       }
> >> +    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu)); =
=20
> >=20
> > I might  be missing something but why it needs to be done manually?
> >=20
> > device_set_realized() will place any parent-less device under (1) /mach=
ine/unattached =20
>=20
> This is exactly what we want to avoid, to eventually remove
> the "/machine/unattached" container for good.
>=20
> See "=3D Problem 4: The /machine/unattached/ orphanage =3D" in:
> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/


QOM paths as far as I'm aware were never part ABI nor I'm aware of
of any proposal to make it or some parts of it a public interface.

IMHO for public ABI, QEMU provides explicit QMP commands while
QOM should stay a playground for developers.

I this specific case, one basically replaces /machine/unattached
orphanage with explicit /machine one and many 'cpuN' children,
which ain't any better than device[N].

and in future I can imagine that at least in x86 case vcpus
might have another parent depending on configuration.
(i.e. being parented to cores instead)

If goal is to get rid of /machine/unattached, that's fine.
But please not make brittle naming under /machine/unattached
as a reason as 'cpu[N]' is the same just in different place
and scattered all over code (hence doubts if it's any better than current w=
ay).
(ps: don't we have exactly the same for peripheral-anon container)


> > while devices created with device_add() are be placed under /machine/pe=
ripheral[-anon]
> >=20
> > The commit message unfortunately doesn't explain why [1] shall be repla=
ced
> > by direct cpu[*] array property directly under machine. =20
>=20
> Right. I'll drop for now and respin once reworded.
>=20
> > Granted, those paths aren't any kind of ABI and wrt x86 cpus
> > nothing should break (or I'd say it shouldn't break our promises)
> > But I'd rather not do this without a good reason/explanation.
> >  =20
> >>       qdev_realize(DEVICE(cpu), NULL, errp);
> >>  =20
> >>   out: =20
>=20


