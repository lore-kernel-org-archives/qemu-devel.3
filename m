Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA8CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ENy-0007Os-3i; Fri, 10 Oct 2025 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v7ENw-0007Oi-H4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v7ENp-0004kF-Vl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760107567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PnN9kyBFhdvnZcBXAnMOLjobbTFEGueEfcrRePfodk=;
 b=cVFTOsrbkkNGGGzWUoLNFoeoursQY7c8dIEPxEfeP0fwINxAObyZp3DXPbWhUX+625ic6D
 eeyut8Ipy022Ur85SVRJxzUL7nkiEMEpp19mnVLFdP3DxUpPitzB0QoChelGIJpP+9dGlb
 bvE3Nh/SIxM2N8Kq1S5FNTFC24xs6CI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-xqx27mVHPRWFZqNPQYsFew-1; Fri, 10 Oct 2025 10:46:06 -0400
X-MC-Unique: xqx27mVHPRWFZqNPQYsFew-1
X-Mimecast-MFC-AGG-ID: xqx27mVHPRWFZqNPQYsFew_1760107566
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-81d800259e3so45866796d6.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107566; x=1760712366;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7PnN9kyBFhdvnZcBXAnMOLjobbTFEGueEfcrRePfodk=;
 b=LZtsJaEUldWUFZwb7rxIoHBDvRWNmCu5l3yMzmnDvDe3vRmKhcHREfo36bec4NRcFX
 UbhBbhjAxI2wq2kyr9gXkgBoTKulRznsZfIFoQKMlHuNFBgsOwsdjbyAJG/fjjeTsWwW
 x0PyQ0rzearcQQzvqBR1qrXAhS5ZY/t00Bo0GfIwhA/5vQ50S3jJKAJUr5QKe53A9AGO
 326OrxhwoQ7piUO5zX1wy2GO0b+5+4n1zyFKPCASQ3hZr8GStSWPi9xh6TSd4tNSjUa/
 RBXX44ypX15QS/ZhIr1SSOuqOpGIeJW60hEQTgmFHcwcPx+U9WORx78hJrPhqSAnQ4+C
 jM+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh8/u7tfToHQDS7QZ9OnZBFHulTWC927Nd+NkxSYoURUjWix5YuDmm+Wk094iBrPrsa/vyyick8+m/@nongnu.org
X-Gm-Message-State: AOJu0YxLm7xm3GOrWtYp8POUQTIpwT6HI3taGBwTNhkYUvL8eXcxwwXY
 m5GB7Gna2mb2UVhSq6HlgOUpjjBOOSz2yx7U8ETGnZz4+wM0ChLjMaN50RxadR7i967zIm0Ye6N
 4we+UWsNurfgG6LjMUgFBGpYZlHD0/mcGrG7sK9CsW9xdcAW/iaqKecP6
X-Gm-Gg: ASbGncujzc4IZ1u0R26c65wGvxTYH8flE6NdGjxk4AzAHWhuWFQ+RnRkD8yLFbAtEtQ
 00HzmjBtPw90ReCsdbgLfjSfYTlWzMJFeqb9r/WxakvDX1MHXiurMUUujBSh5wo5OSvBK+uRKzu
 wYj1UmqkwCdHfH1GuGX01K8JVIyDRi7xsc9U6nJj/I8grcey6m2LlVwMwbqoX6chPgeuZyuHJys
 qCm1kK4DLsdBCOMpiswvzyZigAjJ4RWqzOzL16gaCHiX+VKnsc8X0jertWc33sNWuJHmd+fl0+q
 J1CJYoV0yAZr8cQKN8dJc123oQBNdQ==
X-Received: by 2002:a05:6214:da5:b0:77f:4415:6d8b with SMTP id
 6a1803df08f44-87b20fede4bmr163232086d6.8.1760107565740; 
 Fri, 10 Oct 2025 07:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/QDmzTGoLGmcsbGtXv26FVmJMJlqoV066hjwYHCvlgYOpgayqITsZAxQN2BPQXPfCl5eCPw==
X-Received: by 2002:a05:6214:da5:b0:77f:4415:6d8b with SMTP id
 6a1803df08f44-87b20fede4bmr163231056d6.8.1760107564894; 
 Fri, 10 Oct 2025 07:46:04 -0700 (PDT)
Received: from redhat.com ([45.88.222.110]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc35713ccsm17432306d6.37.2025.10.10.07.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:46:04 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:45:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 santosh.shukla@amd.com, aik@amd.com
Subject: Re: [PATCH 0/2] Cleanups and fixes (PART 2)
Message-ID: <20251010104532-mutt-send-email-mst@kernel.org>
References: <20251008164324.21553-1-sarunkod@amd.com>
 <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
 <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
 <7f0a34c6-eefe-4bfa-80cc-d1c9a3b5148b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f0a34c6-eefe-4bfa-80cc-d1c9a3b5148b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 10, 2025 at 10:37:55AM -0400, Alejandro Jimenez wrote:
> Hi Philippe,
> 
> On 10/9/25 10:19 PM, Philippe Mathieu-Daudé wrote:
> > Hi Alejandro,
> > 
> > On 10/10/25 03:33, Alejandro Jimenez wrote:
> > 
> > > I know the commit log is not consistent so far, but going forward I
> > > propose we adopt the shorter prefix "amd_iommu: " for commit
> > > summaries. There is no ambiguity (only one arch has amd_iommu), so
> > > the full path is not required (i.e. avoid 'hw/i386/amd_iommu: ').
> > > Shorter boilerplate leaves more space for relevant details, and
> > > helps people like me who struggle to comply with character limits
> > > :).
> > 
> > What about "hw/amd_iommu:" to keep 'hw' in subject?
> 
> Is there any tooling that relies on the hw prefix? Skipping the arch in the
> prefix is confusing I think, since hw/amd_iommu is not a valid path in the
> repository.
> 
> I was looking for precedent of any preferred format in the commit logs under
> hw/i386/ and there is a lot of variance. But specifically for IOMMU
> emulation code, my interpretation is that the short prefix style is most
> commonly used e.g.
> 
> Common x86 IOMMU uses "x86-iommu: "
> 
> The VT-d changes are typically in the form:
> "intel_iommu: XYZ", which Clément also pointed out recently in:
> https://lore.kernel.org/qemu-devel/f97bc435e8ed1c295919350d300068e45ab0bb67.camel@eviden.com/
> 
> virtio IOMMU uses "virtio-iommu: "
> 
> RISC-V IOMMU uses the full path: "hw/riscv/riscv-iommu: "
> 
> SPARC64 has a few commits with "sun4u_iommu: "
> 
> I don't believe the 'hw' component is required to avoid ambiguity, but
> perhaps there is something else I am missing...
> 
> Thank you,
> Alejandro

FWIW I like amd_iommu

-- 
MST


