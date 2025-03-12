Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98755C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLRy-00045n-0w; Wed, 12 Mar 2025 08:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tsLRX-00042W-SH
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tsLRU-0004CY-1s
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741783446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdGSBzPaQlLZRoePUkt23kkl1gRyP2FiJGGoJS7tI14=;
 b=ancSFq9JIxdNI6xo/qlPPPy7JpAx3PcgHcrUxrS99CfXRd2/7YuGLTkVL65UvZxHjN3J0B
 I1ADgPTH4WdvEhIiZm1bHw9Mq5HNc/4rsaFrmLs29HkvttXEMRr4dsDDncnVJpoHfLwUHV
 WMpVjvTo1Wgq+nV0OChHenksG+hCvvc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-tN_IBuanMsWbQxPNvEM6xg-1; Wed, 12 Mar 2025 08:44:04 -0400
X-MC-Unique: tN_IBuanMsWbQxPNvEM6xg-1
X-Mimecast-MFC-AGG-ID: tN_IBuanMsWbQxPNvEM6xg_1741783443
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e6372ccd355so6748675276.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741783443; x=1742388243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdGSBzPaQlLZRoePUkt23kkl1gRyP2FiJGGoJS7tI14=;
 b=pJLI8ukVLody4wZ8XcaGzKE6hsmyYzQXDIcp8q7nTuPa+GwxwTdPtsO/idlzw29kRQ
 UNcRZp9Qbj3RDbq3S6otJ6qtKDCcYomrctizxORBlx+K6QxLdBQy+KQPDFLsTLJGjXoG
 ua1TtZXISTvvMUbkNYe1CWPCSIPIf0L11i19AonlWnHtklovZY60ZV4krn9X3tyZuYY/
 nOGoSU7Xr9he0hmhOxdJWhxw+9TNhMtFWY6RXz9XDvmhf0ehnq1U9mG9PtujAVwE8tIS
 c0TpnH+vsVa5ykMNYhjnMGlDCu5wXwvW5slwt2RtZeDHOIZ7BFBxo6ED37o8FVC74wWO
 Lx/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGg0sxvS7LUMHAdA3TZb15O18vBBfai6VrQbwUphBceHrY2v747cHf4mj66qsaoLveKxAkNfkZsxjY@nongnu.org
X-Gm-Message-State: AOJu0Yy609KwOUzQ9lLANP7I4LMJb+haHwUXXapMU6dBwFVwTQOWFte5
 eAsONX/iSk2ALkkd/bed1aQ+q7hRObSZUVgiGdiewdYTWlFLZ4BRj4k9u9ss153CsKIkcWIF+XZ
 9UpGrAPOIFt7TysXrr/MCnK/nexHvfVdYIPp2ld7XdznUb5SmrrsLTH8eq1XFMR5FwHC9YZjGMw
 YPTQP4S41pGq4+NkuQ3gJjzLbIPJM=
X-Gm-Gg: ASbGncs2nB4hyyfwuYh7n+BL0aK2bMRVZT+RQIxc8zmD6CSron8uyPzshP8b2EggVS9
 pjZrxkIyD55lHStjWlH6PK6yfLnD6dTHO4FiyY1ENFE7Rci7E5bIBh4eavyWNTKfJuQPKRAY=
X-Received: by 2002:a05:6902:e0e:b0:e60:915b:19e with SMTP id
 3f1490d57ef6-e635c13ac56mr27335623276.15.1741783443492; 
 Wed, 12 Mar 2025 05:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Z+QJ35S8Zf5oXfJgIGBtM0psiuqcnXHcT5igtflWNfWvpxBXQWkWaykpITGBGXQ3QYcg9ZSlnUM8sYVK1lc=
X-Received: by 2002:a05:6902:e0e:b0:e60:915b:19e with SMTP id
 3f1490d57ef6-e635c13ac56mr27335595276.15.1741783443216; Wed, 12 Mar 2025
 05:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250309094039-mutt-send-email-mst@kernel.org>
 <70b47c11-da90-4f93-b7b7-a522b8ae7def@amd.com>
In-Reply-To: <70b47c11-da90-4f93-b7b7-a522b8ae7def@amd.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Wed, 12 Mar 2025 14:43:52 +0200
X-Gm-Features: AQ5f1JrPRfhKn12RI80ykBCf0X8wr-PXWfr72W6t96ILxZdJQh5RrqDYEKKTfUM
Message-ID: <CAGoVJZwg0KvZX7_OCFYp+RBk_fO4kBV3MmY3FxUC=RbnNKLtZA@mail.gmail.com>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 mtosatti@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com, 
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Content-Type: multipart/alternative; boundary="00000000000068c3300630248f6b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--00000000000068c3300630248f6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 4:02=E2=80=AFAM Suthikulpanit, Suravee <
suravee.suthikulpanit@amd.com> wrote:

>
>
> On 3/9/2025 8:44 PM, Michael S. Tsirkin wrote:
> > On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> >> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD
> I/O
> >> Virtualization Technology (IOMMU) Specification [1]. The PCI id for th=
is
> >> device is platform-specific.
> >>
> >> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id a=
nd
> >> undefined device id.
> >>
> >> Therefore, change the vendor id to Red Hat and request a new
> QEMU-specific
> >> device id.
> >>
> >> [1]
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/spec=
ifications/48882_IOMMU.pdf
> >>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >
> > Will the existing drivers bind with the device then?
>
> Existing Windows would not recognize the device ID.
>
> Actually, Linux and Windows does not depend on the PCI vendor / device
> ids to probe devices and initialize AMD IOMMU. Instead, it depends on
> the ACPI IVRS table.
>
> Checking on a real system w/ AMD IOMMU enabled booting Windows Server
> 2022, there is no AMD IOMMU device showing in the Device Manger.
>
> In this case, I believe Windows is not fully initializing the
> QEMU-emulated AMD IOMMU. So Windows would not remove the IOMMU PCIe from
> the list of OS visible devices and therefore expose the PNPID to the
> device manager. And since the device ID is zero, it appears as an "Other
> devices->PCI Device (with warning sign).
>
> Therefore, it we have two options:
>
> 1. Fake the device ID to 0x1419, which is current appear in the
> machine.inf as an entry in section [AMD_SYS.NTamd64]:
>
> %IommuDevice_Desc% =3D NO_DRV,PCI\VEN_1022&DEV_1419
>
Considering that this is a "null driver" (no actual driver is loaded for
the PCIe endpoint according to machine.inf), I recommend using this PNP ID.


>
> 2. Figure out why Windows does not recognize the device.
>
The answer is simple: the PCIe endpoint's PNP ID is unknown to Windows. So
technically device is recognized (it is shown in Device Manager after all),
but there are no compatible drivers for it. And in anycase, machine.inf
specifies "null driver" for AMD PCIe endpoint IOMMU device. The device will
get a friendly name in Device Manager and considered to be "installed" by
Windows, by there is no actual driver associated with the device.

Best regards,
Yan.


>
> Anyhow, we should still assign some PCI ID value (instead of zero).
>
> Thanks,
> Suravee
>
>
>
>

--00000000000068c3300630248f6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 11,=
 2025 at 4:02=E2=80=AFAM Suthikulpanit, Suravee &lt;<a href=3D"mailto:surav=
ee.suthikulpanit@amd.com">suravee.suthikulpanit@amd.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex"><br>
<br>
On 3/9/2025 8:44 PM, Michael S. Tsirkin wrote:<br>
&gt; On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:=
<br>
&gt;&gt; The QEMU-emulated AMD IOMMU PCI device is implemented based on the=
 AMD I/O<br>
&gt;&gt; Virtualization Technology (IOMMU) Specification [1]. The PCI id fo=
r this<br>
&gt;&gt; device is platform-specific.<br>
&gt;&gt;<br>
&gt;&gt; Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor =
id and<br>
&gt;&gt; undefined device id.<br>
&gt;&gt;<br>
&gt;&gt; Therefore, change the vendor id to Red Hat and request a new QEMU-=
specific<br>
&gt;&gt; device id.<br>
&gt;&gt;<br>
&gt;&gt; [1] <a href=3D"https://www.amd.com/content/dam/amd/en/documents/pr=
ocessor-tech-docs/specifications/48882_IOMMU.pdf" rel=3D"noreferrer" target=
=3D"_blank">https://www.amd.com/content/dam/amd/en/documents/processor-tech=
-docs/specifications/48882_IOMMU.pdf</a><br>
&gt;&gt;<br>
&gt;&gt; Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=
=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Suravee Suthikulpanit &lt;<a href=3D"mailto:suravee=
.suthikulpanit@amd.com" target=3D"_blank">suravee.suthikulpanit@amd.com</a>=
&gt;<br>
&gt; <br>
&gt; Will the existing drivers bind with the device then?<br>
<br>
Existing Windows would not recognize the device ID.<br>
<br>
Actually, Linux and Windows does not depend on the PCI vendor / device <br>
ids to probe devices and initialize AMD IOMMU. Instead, it depends on <br>
the ACPI IVRS table.<br>
<br>
Checking on a real system w/ AMD IOMMU enabled booting Windows Server <br>
2022, there is no AMD IOMMU device showing in the Device Manger.<br>
<br>
In this case, I believe Windows is not fully initializing the <br>
QEMU-emulated AMD IOMMU. So Windows would not remove the IOMMU PCIe from <b=
r>
the list of OS visible devices and therefore expose the PNPID to the <br>
device manager. And since the device ID is zero, it appears as an &quot;Oth=
er <br>
devices-&gt;PCI Device (with warning sign).<br>
<br>
Therefore, it we have two options:<br>
<br>
1. Fake the device ID to 0x1419, which is current appear in the <br>
machine.inf as an entry in section [AMD_SYS.NTamd64]:<br>
<br>
%IommuDevice_Desc% =3D NO_DRV,PCI\VEN_1022&amp;DEV_1419<br></blockquote><di=
v>Considering that this is a &quot;null driver&quot; (no actual driver is l=
oaded for the PCIe endpoint according=C2=A0to machine.inf), I recommend usi=
ng this PNP ID.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
2. Figure out why Windows does not recognize the device.<br></blockquote><d=
iv>The answer is simple: the PCIe endpoint&#39;s PNP ID is unknown to Windo=
ws. So technically device is recognized (it is shown in Device Manager afte=
r all), but there are no compatible drivers for it. And in anycase, machine=
.inf specifies &quot;null driver&quot; for AMD PCIe endpoint IOMMU device. =
The device will get a friendly name in Device Manager and considered to be =
&quot;installed&quot; by Windows, by there is no actual driver associated w=
ith the device.=C2=A0</div><div><br></div><div>Best regards,</div><div>Yan.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-c=
olor:rgb(204,204,204);padding-left:1ex">
<br>
Anyhow, we should still assign some PCI ID value (instead of zero).<br>
<br>
Thanks,<br>
Suravee<br>
<br>
<br>
<br>
</blockquote></div></div>

--00000000000068c3300630248f6b--


