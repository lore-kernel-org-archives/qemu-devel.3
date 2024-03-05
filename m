Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4520AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbzl-00075X-Vs; Tue, 05 Mar 2024 16:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rhbzj-00074O-QK
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rhbzh-0007A9-8z
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709672796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9w03BcOqjTzgd4vKbQG9yBp9Khp4JPRBtPNjWiUKZc=;
 b=Iv+LyjDR9DHMuWTDrktnzdZDUBBCkCGRKtQUWMVEOKz9fbFVA73eVF06blPZigfYYLs5cx
 fWuLf3iI4n7wefMmQIgIbIronUA/JOPOWA412RCVXrVk6LRq+nWKzEJwQpv9kaMb8vhpmS
 zWlFxwS/jKs6hPG2Wk98kS7kHu8aPbs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-N-ZdlrMEMP-F0wYFrByXvg-1; Tue, 05 Mar 2024 16:06:34 -0500
X-MC-Unique: N-ZdlrMEMP-F0wYFrByXvg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-21e7751f76fso7697355fac.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709672794; x=1710277594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9w03BcOqjTzgd4vKbQG9yBp9Khp4JPRBtPNjWiUKZc=;
 b=DL17hk8iyjXy4evTulYdZKtUBgQlYKCYJlTQIsMmjjh0UJxPLJ3llvmMzmyMdDi6j4
 bKYN+qZKskV72lzowfBP+XpktbFVWd+1E0bHFe5+CZURQxHbp+hir+IQjHI1PIb9JrDB
 O946yPq5VJfuqTxqVAEx8L1dd1avcxJXbKiwt3rE4frbmmD0DL1nvcHPNoNkzL8bYbhE
 usikr5sFnrRiFgQqfyBSM5H7ZDTx/FC2sxlOWIF56CHNyBu4X07zHOcCieDKhm1Qb6gX
 PnHm4NqtLtYwiEE0youdgZSM1FH5niIejnOxrT+iN/r7VadAhld+8DUQ8x2upLQPs5GI
 ui+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyNGBLXza5GlWlP/ak72lKR3oj0skv0Kx7BGFrHVGw9Qrr6WDD+vjsaFt/Vvtz7OR6NLTF5/hwZeNYAOTtkMVLU9s3fuA=
X-Gm-Message-State: AOJu0YwOQ2C0KO5kmkrmB30n89QY0XzYzc0xes5SvyU4rjiJVuP83VzL
 1tTNGzLhWj0MAv+HMAWX6ss4/gX3i9x2LD8fST1l7YjISFhHUYXs4JEnV/eecmG4gwZAR0PNblZ
 r0TAiGfOJFZRsuxTEQ+ppk5+tluV7CxkF3NvFEnFHrSg65PGi7PmX
X-Received: by 2002:a05:6870:612a:b0:21e:9ef7:f1df with SMTP id
 s42-20020a056870612a00b0021e9ef7f1dfmr3089485oae.9.1709672793836; 
 Tue, 05 Mar 2024 13:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgsRa5SO10KB+iXM3kkhcwtLK2+4gASZzEIReXB2GQqvWbfMOMBz/kXoZrp8VxdMxA0TDpRQ==
X-Received: by 2002:a05:6870:612a:b0:21e:9ef7:f1df with SMTP id
 s42-20020a056870612a00b0021e9ef7f1dfmr3089461oae.9.1709672793476; 
 Tue, 05 Mar 2024 13:06:33 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 nd6-20020a056871440600b0022147ef9172sm177056oab.52.2024.03.05.13.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 13:06:32 -0800 (PST)
Date: Tue, 5 Mar 2024 14:06:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang <zhiw@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)"
 <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy Currid
 <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20240305140630.5a3dd69b.alex.williamson@redhat.com>
In-Reply-To: <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 5 Mar 2024 05:59:46 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> > One thing I forgot.
> >
> > Please add a test.=C2=A0 tests/qtest/bios-tables-test.c
> > + relevant table dumps. =20
>=20
> Here I need to add a test that creates a vfio-pci device and numa
> nodes and link using the acpi-generic-initiator object. One thing
> here is that the -device vfio-pci needs a host=3D<bdf> argument. I
> probably cannot provide the device bdf from my local setup. So
> I am not sure how can I add this test to tests/qtest/bios-tables-test.c.
> FYI, the following is a sample args we use for the
> acpi-generic-initiator object.
>=20
>        -numa node,nodeid=3D2
>        -device vfio-pci-nohotplug,bus=3Dpcie.0,addr=3D04.0,rombar=3D0,id=
=3Ddev0 \
>        -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,node=3D2 \
>=20
> Moreover based on a quick grep, I don't see any other test that
> have -device vfio-pci argument.
>=20
> Jonathan, Alex, do you know how we may add tests that is dependent
> on the vfio-pci device?
>=20

As Jonathan notes, we've decoupled this from vfio-pci, the pci-dev=3D arg
can point to any PCI device.  For example, any emulated PCI NIC could
be a stand-in for the vfio-pci device used in practice.  Thanks,

Alex


