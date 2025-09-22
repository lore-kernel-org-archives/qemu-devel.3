Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF29CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fm2-0008Ch-3D; Mon, 22 Sep 2025 08:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0flx-0008C2-8o
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0flp-00066f-CI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758544546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWGkxwc4fUX1NerxXN7iqjKsnwNCsuo/XNS+NOtkau4=;
 b=TXqg1oAjQIKfXQASYlpbVKYi9FWcVQl/myAzg93JM9OFx9GZpwNqNnlxFJm+X8bd32IU9t
 LHkyKwvD10yxf/jJACz8SrJhzbTeEMMlP+8HbrXmml4aRS5fCkFHPh8slAvq0o3Uxkv4n5
 RCmgrUk3Y+SIcvDlDlJY4UGhjB0iPrs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-OwRFFjeEOAOAvJqB_14W1A-1; Mon, 22 Sep 2025 08:35:45 -0400
X-MC-Unique: OwRFFjeEOAOAvJqB_14W1A-1
X-Mimecast-MFC-AGG-ID: OwRFFjeEOAOAvJqB_14W1A_1758544544
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46d88f7d691so3738665e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758544544; x=1759149344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWGkxwc4fUX1NerxXN7iqjKsnwNCsuo/XNS+NOtkau4=;
 b=XPkB6KR44ZyXR9+0WUZfc68UAeMsOtv7f3e7huuvz97EZFF00pAVSfanPwpsGRigo+
 sL8EHvJwZUapE5lBtc9c/WpH0M7s/pk94YYfWkU7QveqMalUEj2Vzl85nb6pQ7F4QzEr
 lZHUuwIZR3AIaRxlv3aBZoU6u3OlQqCuKjyk95Xv7kurreFg3zLrH1p2uosS4WvGTKqf
 qCE0EXN7H9FHmZsmsqiczxAPAdk0LvywMrDkQcRck4/dL6g/pEZAIhQOMK8Mo0xcfZwC
 mF1ZpQbd0hgjkQsl2q492K4Y68nkPAsIff9Mv+zUaQNbrWFIfBKlIJXltrR//b9x6v00
 4oRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDuRc/tVxfM/8y5sxMxPISYfjOLI3eajN7fprctN2sMVTIVu3fd9v0jwnYUjH8IxE73vF4lcRSEagK@nongnu.org
X-Gm-Message-State: AOJu0YyNCHnTrH1JkZYA7fUYlBdsz94SnZ5BJJE5BL8sPEdiqyywnEyS
 KB2Pb+GF/gRNRddapUAPXERpJQwcLGx+m2PE1ycAqzFAFkOiNoV4p3p93zKElmECYhArKIsuUnk
 1An/SvdEFufmoad3uRhHYd0FgBj+lpMNkZaERcTTV/sCLwD/m/QtIUc54
X-Gm-Gg: ASbGncvmm2w1+vRelXW2cEB05sSKwwgXadZYbcrMOjmm3yowZhIsW8kbhaJPM8ZUJch
 2dZ9Y2yTFjJ6X62peOGQ83ukjOyA+2Sib9+ukOmHxoHlVBA3Am1mH/FbWD7xEG0pNoRTC8O2SA4
 4uqaYEOKMM/oC1Bxd4wdPG30fn9JtjCJkML0l3nl8T33ldDpEIkRI2FhYhFptAbHrdNFY6cxLB6
 aBCvfPvdcTtRYFhqU6l6UViQwl1uwov7UQ50F8U/OZhVPyEHhNJCCLWZe7C55pdvwX+F1gNRkCj
 BfdXYAarzjkiY1AaYo+nwnJIH53r548=
X-Received: by 2002:a05:600c:3593:b0:45b:8477:de1a with SMTP id
 5b1f17b1804b1-467ead67316mr128581895e9.7.1758544543846; 
 Mon, 22 Sep 2025 05:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj0rJL7qGXh+oVBHWyGIV4XBZT4Q6/wa2yFL3WunyksLgTYyncYv2UpfB08WjKQQTOPTHkTg==
X-Received: by 2002:a05:600c:3593:b0:45b:8477:de1a with SMTP id
 5b1f17b1804b1-467ead67316mr128581575e9.7.1758544543354; 
 Mon, 22 Sep 2025 05:35:43 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d3ab09b27sm45254305e9.21.2025.09.22.05.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:35:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:35:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
Message-ID: <20250922143537.39896851@fedora>
In-Reply-To: <1178e514-a054-4ace-a5b7-06ca899badec@linaro.org>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <aK7wDn03e8RtKmk3@redhat.com>
 <1178e514-a054-4ace-a5b7-06ca899badec@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 22 Sep 2025 14:05:13 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 27/8/25 13:46, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 27, 2025 at 12:10:00PM +0100, Mark Cave-Ayland wrote: =20
> >> On 26/08/2025 08:25, Xiaoyao Li wrote:
> >> =20
> >>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote: =20
> >>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst =
it is
> >>>> possible to specify any CPU via -cpu on the command line, it makes no
> >>>> sense to allow modern 64-bit CPUs to be used.
> >>>>
> >>>> Restrict the isapc machine to the available 32-bit CPUs, taking care=
 to
> >>>> handle the case where if a user inadvertently uses -cpu max then the
> >>>> "best"
> >>>> 32-bit CPU is used (in this case the pentium3).
> >>>>
> >>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>> ---
> >>>>  =C2=A0 hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
> >>>>  =C2=A0 1 file changed, 26 insertions(+)
> >>>>
> >>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >>>> index c03324281b..5720b6b556 100644
> >>>> --- a/hw/i386/pc_piix.c
> >>>> +++ b/hw/i386/pc_piix.c
> >>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj,
> >>>> int value, Error **errp)
> >>>>  =C2=A0 #ifdef CONFIG_ISAPC
> >>>>  =C2=A0 static void pc_init_isa(MachineState *machine)
> >>>>  =C2=A0 {
> >>>> +=C2=A0=C2=A0=C2=A0 /*
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * There is a small chance that someone uni=
ntentionally passes
> >>>> "- cpu max"
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * for the isapc machine, which will provid=
e a much more modern
> >>>> 32-bit
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * CPU than would be expected for an ISA-er=
a PC. If the "max"
> >>>> cpu type has
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * been specified, choose the "best" 32-bit=
 cpu possible which
> >>>> we consider
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * be the pentium3 (deliberately choosing a=
n Intel CPU given
> >>>> that the
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * default 486 CPU for the isapc machine is=
 also an Intel CPU).
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME=
("max"))) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->cpu_type =3D X8=
6_CPU_TYPE_NAME("pentium3");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("-cpu max is=
 invalid for isapc machine, using
> >>>> pentium3");
> >>>> +=C2=A0=C2=A0=C2=A0 } =20
> >>>
> >>> Do we need to handle the case of "-cpu host"? =20
> >>
> >> I don't believe so. I wasn't originally planning to support "-cpu max"=
 for
> >> isapc, however Daniel mentioned that it could possibly be generated fr=
om
> >> libvirt so it makes sense to add the above check to warn in this case =
and
> >> then continue. =20
> >=20
> > Libvirt will support sending any valid -cpu flag, including both
> > 'max' (any config) and 'host' (if KVM).
> >=20
> > If 'isapc' still expects to support KVM, then it would be odd to
> > reject 'host', but KVM presumably has no built-in way to limit to
> > 32-bit without QEMU manually masking many features ?
> >=20
> > I'm a little worried about implications of libvirt sending '-cpu max'
> > and QEMU secretly turning that into '-cpu pentium3', as opposed to
> > having '-cpu max' expand to equiv to 'pentium3', which might cauase
> > confusion when libvirt queries the expanded CPU ? Copying Jiri for
> > an opinion from libvirt side, as I might be worrying about nothing. =20
>=20
> OK, on 2nd thought, even while warning the user, changing the type
> under the hood isn't great.

I second that,
Please don't do magical mutations of CPUs, just error out.

we used to 'fix|tweak' CPUs using machine compat hack,
however with introduction of versioned cpu models we shouldn't do that anym=
ore.
(aka: existing CPU devices should stay immutable if possible, and any visib=
le
changes should go into new version)


> What about simply removing "max" of valid_cpu_types[], since it is
> clearly confusing "max" =3D=3D "pentium3"...

it seems that specifying supported cpu models in valid_cpu_types[] is the w=
ay to go.



