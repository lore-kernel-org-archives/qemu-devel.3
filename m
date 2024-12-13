Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E6E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLwZI-0008EZ-1h; Thu, 12 Dec 2024 22:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLwZG-0008EQ-MU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLwZA-0000jH-GC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734061331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aRc9XLztSkzaT+nGwLp6yGHq11OmiApKhhJKP8qeFg=;
 b=BUxSUtL9piWIuTx12ycTAmtOhh7apAoh14lX849iDc9MNY52AJQLZagYaGWe1V/zRCAc1w
 7ZLXXxIRwi45KZ8/495J8ikiXvwG30DnaWA9LTyU9wnidrJxyiLCaaxNcwgufp/4/fWAY3
 H10U1TcLlv1T/tLomaZLL2xptlbt4RQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-unJLaNbMMlmCo08WVIbfNQ-1; Thu, 12 Dec 2024 22:42:09 -0500
X-MC-Unique: unJLaNbMMlmCo08WVIbfNQ-1
X-Mimecast-MFC-AGG-ID: unJLaNbMMlmCo08WVIbfNQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee36569f4cso1296389a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 19:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734061328; x=1734666128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aRc9XLztSkzaT+nGwLp6yGHq11OmiApKhhJKP8qeFg=;
 b=NR1pEJ0a+7i5LZlAgeYPZR2SpAKkZhZy1uL+u8QbHOSC88l4jh6FUMtLtpqgc0A87H
 0SQONu0kmEgk00XetMcafBB/MhnJ7Ng4UmI+Yyo6vVx1gql7jkoYdWdOYr7MrUkZu0OJ
 pSjyh340uPbRGWY3ziYRXmLANKrP2AFP711OHg3KfIhtMQ2x8IpD2BKsB0xqnnwo4LJq
 kZ+HbTq9heOus+dqY+Dxl0XRI6nooF3j0yTP1Kk1GrwtQGkwMm9xvfNR9nmkf+Dzzz1N
 zsWDKxvImpSucXB4PZhBa7sjnMeXYrDCsu0vgQZHE3d4n9H8fCavdQUzvhazcxFijtg7
 dX9g==
X-Gm-Message-State: AOJu0YyB5cJv7FUhfT4uxZAD9Gs/DDX/9h2AiZszor2YcD3c6Ro8fhK3
 9cuw3GAvCzlnblWljXR+h9LKQ+Z9HBpY0L8hfcSL6+xpMYiDrKySnWOTLaat48PrayoLkOHidSy
 tS2ChKmESfPvA76NOUKpird/Z669Ap6FnOrqnFJc3UHkHHf/pmCSMLWTQcgO97vusKBcdAeuMGi
 OwPG4Wo9w69rvd5bSrZb4DaEKOq0k=
X-Gm-Gg: ASbGncuML2aJj+p+bewmRQbf/7t3pdikLFFLbqZhVBraszJJQ80ekob2zsY9eZISqWm
 +6P3WhrubVJfb11Lj2QC93X1T5M67EQOzKMJy7y0=
X-Received: by 2002:a17:90b:3803:b0:2ee:7824:be93 with SMTP id
 98e67ed59e1d1-2f2902ac584mr1571570a91.34.1734061328326; 
 Thu, 12 Dec 2024 19:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh0ZJBy6yYbHx7yVqksi7QfO8J6yVsZACkJFRlF/srXz1dKewK9fITypSgehmw+ALMqQFFtj0G28n+bgczgyc=
X-Received: by 2002:a17:90b:3803:b0:2ee:7824:be93 with SMTP id
 98e67ed59e1d1-2f2902ac584mr1571540a91.34.1734061327897; Thu, 12 Dec 2024
 19:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
 <20241212083757.605022-19-zhenzhong.duan@intel.com>
In-Reply-To: <20241212083757.605022-19-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:41:56 +0800
Message-ID: <CACGkMEvJxCAp8Ma7wEu4GY7e_jQQdbW8L0DVYWh5iXCjv+Yg4g@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] intel_iommu: Introduce a property x-flts for
 stage-1 translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 4:42=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
>
> This vIOMMU implementation wants to simplify it with a new property "x-fl=
ts".
> When turned on in scalable mode, stage-1 translation is supported. When t=
urned
> on in legacy mode, throw out error.
>
> With stage-1 translation support exposed to user, also accurate the pasid=
 entry
> check in vtd_pe_type_check().
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


