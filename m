Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404BBE7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIg35-0001Mf-8s; Tue, 03 Dec 2024 22:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIg33-0001MD-CV
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIg31-0004Vh-Bo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733282847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWSS29+EeRcrE5t5LqlBkapCrC+hfJnqImcX4fyzlNQ=;
 b=aSmXJCLggo8QzSn2XEkChwLShy9J6gxV2Wy5tnj2u59ezGcfZD++UeTZ8OlscVRdNg7jOW
 +KJ+usDcTQRMyZIl2epN3rhT+dA35EZdT6Z3BZFUz4RelC/599qxpa3/7UyBXHbR7g0twY
 LZKDUOvuLgY7bHZ9YbfBHFF6oIrjqiM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-5QNOF2LTPfyiDiscsu9plg-1; Tue, 03 Dec 2024 22:27:22 -0500
X-MC-Unique: 5QNOF2LTPfyiDiscsu9plg-1
X-Mimecast-MFC-AGG-ID: 5QNOF2LTPfyiDiscsu9plg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee964e6a50so4654758a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 19:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733282839; x=1733887639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWSS29+EeRcrE5t5LqlBkapCrC+hfJnqImcX4fyzlNQ=;
 b=ml27IxJpI6YiiTuNtFzskmg3FZqaINiFrYtYF4NHvlbUGs8Ns3IGDtEkFUPHQFHH0p
 l87mPRrLwZbbnFdj1BAR0HYD1W1kWC/OfTPADoRX2Zk+o8ZrRwD3cNR0eBdoiQJw3md8
 WWKLxeHtIvi8ANgFgHBSpOne49IF7sAYbPJi+G8Au8H4AxAixIIozAvrdvCMpd/OYBJS
 lwMtDbfc7dXSh6rVBlEFXnDCjaw2VJIm9XARH1AUDawPG/vBGkSzM1UScDqzP6dsnmSp
 eymx6nPhTYdM3m1XH/o69uBF+oCnC4DbbvSHZTh+DLw3UeQFYZeI0yoj+jhJtTD/JtpS
 0Q3Q==
X-Gm-Message-State: AOJu0YwBObYBy9nrSIq2K1xtlU7ocWTdP/K+ffbT7toixe33qcnxXS6g
 33T3LvwI7B6sNicj8AQSgg9BeAfgTzl15+Z2ahxLNKipl4S9V0nP0PhB3XfBS4uElCHzxZq87O3
 UYvY2We87iy3roBOFPwxIbWL4+ct0nMfOYECCUBuANN6CYdPuCy4eO0m9Q2oqyhV3V2HzW8LlFX
 ycPGNgBaa1OChs+KNkZ4Jd7C9RCWc=
X-Gm-Gg: ASbGncuNZvaiNXFWgfX/MxdRd6a8IsA93TJvIxMWTfiUjj7CPuatA6vN9FH+U9rairX
 +BBJMTghyl1qckbjbBSRe0S/PxuuPF3rr
X-Received: by 2002:a17:90b:3803:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2ef011eb672mr6103144a91.13.1733282839122; 
 Tue, 03 Dec 2024 19:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEigXtvCHCnIkvQnB2QIFEscOO/g9u4IsqPA363iaJJpLh0gJPhXMLrc7EPZWc9GWwQf45WQFdMOjgUx0oDJJk=
X-Received: by 2002:a17:90b:3803:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2ef011eb672mr6103125a91.13.1733282838785; Tue, 03 Dec 2024
 19:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-14-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-14-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 11:27:07 +0800
Message-ID: <CACGkMEtNgA_wSLufqH3BAN43AJ+W6UJnsrRhGyDfmjbzdLQJ=w@mail.gmail.com>
Subject: Re: [PATCH v5 13/20] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Mon, Nov 11, 2024 at 4:39=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


