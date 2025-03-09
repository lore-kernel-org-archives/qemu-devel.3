Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A398C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 06:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trASF-0006VR-5T; Sun, 09 Mar 2025 01:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1trAS8-0006Un-EV
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 01:48:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1trAS5-0004PL-Sl
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 01:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741502875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2yUJwt9VuPvmWWDDaf3g+wgRgDAZtseWGNxg1oWiX8=;
 b=EITrtIqEpeG/oqfq+RrXksi5B2yDPGMNvY6O7FX9XkTgGQoql+PAqMSgasdp90rMwgHIzN
 UCvbieP7LV55BiY5leIzMH+5bgeBkfkTbYa+yFm3+X8Yr+lBIyWNuWBWolvg2oIlMvAODC
 qryaEBfR+K1VKAIY3xqjYBqDDtKdW04=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-85jX-I_9NR2ZW6tH3dNmZQ-1; Sun, 09 Mar 2025 01:47:54 -0500
X-MC-Unique: 85jX-I_9NR2ZW6tH3dNmZQ-1
X-Mimecast-MFC-AGG-ID: 85jX-I_9NR2ZW6tH3dNmZQ_1741502873
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6f3ff1ff13aso53933327b3.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 22:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741502873; x=1742107673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2yUJwt9VuPvmWWDDaf3g+wgRgDAZtseWGNxg1oWiX8=;
 b=ZOof5j8sdkS+xWdmJgHZBK0wiOpQBX/ycbK1VcGbbHdpcubrj3XlYVUmGxVZAQygn5
 SJ0TD7Yvql0XOe9BkFw7w6E0nzHnzeColpGgi9ntAdz6881u8umwn6ku7Q87i4f9zGF3
 9xkCDuwM1AfJEbbJLgcO127lWBFs75Hx32FblZP1eURZRvGa8F7+ChVLcc+QzRlDK2Ad
 YQvnkgulsJ9gGSDdjatQimIb5ey4iXO+ItggdvX+yrhqx15JZtaelWWmOnrErQQo77v0
 0oDm40NZxPLTqjIR1FrjH3Xwc8Plc61TbgswXcyArk5s13VQESSX36hfbyPa6lmYLh6k
 /T4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUZ18QJa8moTraD4bsjXYtu+KnQcugZTOyCHcpqb+ODO9znAYwhZg6SuWRzxMEDJ9YLq+qmPtUIQJg@nongnu.org
X-Gm-Message-State: AOJu0YzYuFfCVmFaPu8m/xj5PWATVKMe9QWlmEjEprsFZXK6a9rRdwRq
 7+EnEff2eOfKFjwaa3nDf8R+pmcejyonVSDmtUGH/PZYyLQsickRcW3m9tcKej4EjgPE9isumPo
 4ZcqX46fabSstwBusLp6e5u4Xt3rU8hHY3KyiZF5ww4a3bCziJBmBLlsa0YDP4XRwfNFEAURM+H
 KVHtdMsPohy4OidiwdtvQLZSQu83s=
X-Gm-Gg: ASbGncsr1CQu2fn3mMjnxWBuJ5I1tWGrL2pxbbGHvo2RRL4saFlN+Iu0xbuHFHzNVmJ
 UY51Jdc4fpfPvX8frX6SFT+HZXDGyiTqxtP4EAhXQfKZTvbunYlmdW/JjECnB1+gJ5chSdvPT
X-Received: by 2002:a05:6902:2481:b0:e60:a6a0:f5bf with SMTP id
 3f1490d57ef6-e635c1002dcmr12450304276.5.1741502873694; 
 Sat, 08 Mar 2025 22:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9I0IU93LotEa5LcZzWwOuQHJ2GWD9RbgkLgiV4/D8e+6GaInbbQ4vJRp/dN8TSkh3yqdBVTCYkXv44eSZK4Q=
X-Received: by 2002:a05:6902:2481:b0:e60:a6a0:f5bf with SMTP id
 3f1490d57ef6-e635c1002dcmr12450279276.5.1741502873406; Sat, 08 Mar 2025
 22:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250305015122-mutt-send-email-mst@kernel.org>
 <234a0790-e256-4cd8-808d-90f821911881@amd.com>
In-Reply-To: <234a0790-e256-4cd8-808d-90f821911881@amd.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Sun, 9 Mar 2025 08:47:42 +0200
X-Gm-Features: AQ5f1JrOYoAbO3EaFTCebLSxT2Si62_iqVi5n7CxL2ZzFUCoTqRc80QmIOODJlo
Message-ID: <CAGoVJZxf0iWZcVQMZmfvuyM=bYwoPwqkcNe71RDZ6spumKZ0Ow@mail.gmail.com>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 mtosatti@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com, 
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002532c3062fe33c56"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--0000000000002532c3062fe33c56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:55=E2=80=AFAM Suthikulpanit, Suravee <
suravee.suthikulpanit@amd.com> wrote:

>
>
> On 3/5/2025 1:52 PM, Michael S. Tsirkin wrote:
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
> > undefined?
> >
> >> Therefore, change the vendor id to Red Hat and request a new
> QEMU-specific
> >> device id.
> > Won't the drivers fail to load then?
> >
> >
> >> [1]
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/
> >> specifications/48882_IOMMU.pdf
> > what is this link teaching us? It's a 300 page document. Where to look
> > in there?
>
> What I am trying to say is that all AMD IOMMU implementations must
> adhere to this specification including the QEMU-emulated AMD IOMMU.
> Unlike cpu emulation, we don't need to exactly mimic a particular
> hardware implementation.
>
> QEMU-emulated AMD IOMMU device can have its own set of features that it
> supports. Going forward, we might even have QEMU-specific feature /
> behavior. So, we should not be using an existing PCI ID.
>
> And in this case how "other" (namely Windows) OSes will know how to use
the device?


> Thanks,
> Suravee
>
>

--0000000000002532c3062fe33c56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 4:55=E2=80=AFAM Suthikulpanit, Suravee &lt;<a href=3D"mailto:surave=
e.suthikulpanit@amd.com">suravee.suthikulpanit@amd.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,20=
4);padding-left:1ex"><br>
<br>
On 3/5/2025 1:52 PM, Michael S. Tsirkin wrote:<br>
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
&gt; undefined?<br>
&gt; <br>
&gt;&gt; Therefore, change the vendor id to Red Hat and request a new QEMU-=
specific<br>
&gt;&gt; device id.<br>
&gt; Won&#39;t the drivers fail to load then?<br>
&gt; <br>
&gt; <br>
&gt;&gt; [1]<a href=3D"https://www.amd.com/content/dam/amd/en/documents/pro=
cessor-tech-docs/" rel=3D"noreferrer" target=3D"_blank">https://www.amd.com=
/content/dam/amd/en/documents/processor-tech-docs/</a> <br>
&gt;&gt; specifications/48882_IOMMU.pdf<br>
&gt; what is this link teaching us? It&#39;s a 300 page document. Where to =
look<br>
&gt; in there?<br>
<br>
What I am trying to say is that all AMD IOMMU implementations must <br>
adhere to this specification including the QEMU-emulated AMD IOMMU. <br>
Unlike cpu emulation, we don&#39;t need to exactly mimic a particular <br>
hardware implementation.<br>
<br>
QEMU-emulated AMD IOMMU device can have its own set of features that it <br=
>
supports. Going forward, we might even have QEMU-specific feature / <br>
behavior. So, we should not be using an existing PCI ID.<br>
<br></blockquote><div>And in this case how &quot;other&quot; (namely Window=
s) OSes will know how to use the device?</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
Thanks,<br>
Suravee<br>
<br>
</blockquote></div></div>

--0000000000002532c3062fe33c56--


