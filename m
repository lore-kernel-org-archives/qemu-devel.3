Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEEAC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eq1-0002Z8-T3; Tue, 15 Apr 2025 07:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4epv-0002XK-Nx
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4ept-0002er-7X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744717935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmLuj6SbUylxg9uh0DFPX/gc0Z3SKez+BWyKb9n0JCw=;
 b=Qwe96qwnSupExJzHT6kJkRZenRtQfTMkSoXB9FsGdmx0Zxx4gzaO6PRIW1DhgV2JItUhAD
 xPP6oVe9PdzZ4o+E5dQ777TlHI6n24gTK7yjM2CXWvzBf8y4t4ppe8Hv19k2TnNA1gKfXI
 lQDM93j3higziWcyYkQj2De+A277TM0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-oSb1KTOUOEqsAz7KfCX3KA-1; Tue, 15 Apr 2025 07:52:12 -0400
X-MC-Unique: oSb1KTOUOEqsAz7KfCX3KA-1
X-Mimecast-MFC-AGG-ID: oSb1KTOUOEqsAz7KfCX3KA_1744717931
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso27298005e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744717931; x=1745322731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmLuj6SbUylxg9uh0DFPX/gc0Z3SKez+BWyKb9n0JCw=;
 b=QH3xVZmGAGHDF3DfmYmLTqB+ewn/pLq78ph3BjTFTi+mE1miANp+Sbx04q7hLSDPY4
 N0YTVeF/CNxOmbJQRLnGHW4ffyTaVJwhe3BhMDbkoEJfkTDbqw05gzNqRazlodT6vogr
 pJ/VkcEOzaqoKTOEF5nO3aBXEt7trp4pESv8wCCthXKZBj8LCCtAPix+S+Dm3XYuBCaI
 mYhKOtvDzUWJP+TXUi8WQaRyK3Q8IHh5toJJkxeNmqmWlN/Ez/HjKYsSuAn6wvk1TC5U
 LuESz6asKCQ/PHGI/AvOqpLORdeQVEq0Ifhahku0dLc0EfbjcIGxQLAX2eKmKSf16jKy
 bPqA==
X-Gm-Message-State: AOJu0YznEWr8nfWgCKuL0XVZoHTHkxSEL5fN/lFEZrHMT2m5gwbkDDyA
 2suOq/wKiFW1dX/bkaLddsp0XsNtnUWpYaZAPvKlrima+s/zBYx7K0D4MmlLBsq/80QJk3rB279
 LpPHC3JbrUenCXw84Cz2oC38FQRxuHJx0L4k3KRThfcJloC69UOQZe3fmorHxMQqj0cypnMkOqD
 2Oet8OxEqlQnzuvs8737sTeXizPtU=
X-Gm-Gg: ASbGncudkfaqI5Dot2XFKeUQ9XqI+E4QRQGzMDXqg2ukW0WC69rDJSnD8wFGfyxrmdy
 CKyaE0D6IhbStioim4YfXDerQAddIjJmLpG6ylUtZGrG8BMmmPkVCBMXBvZFdtTAiTHWH4g==
X-Received: by 2002:a05:600c:3148:b0:43b:ca8c:fca3 with SMTP id
 5b1f17b1804b1-43f9ad6ee73mr26834005e9.11.1744717931340; 
 Tue, 15 Apr 2025 04:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwlp36868LpQUjPHrMmCWFTFmEolm+hpK4MrvotqgJnYJioVbY20Idur2vLK4dOGO2BIKlVlW0lfPKLzHdynQ=
X-Received: by 2002:a05:600c:3148:b0:43b:ca8c:fca3 with SMTP id
 5b1f17b1804b1-43f9ad6ee73mr26833855e9.11.1744717931015; Tue, 15 Apr 2025
 04:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
 <ed082405-06a7-4407-9230-3a9b7e91406e@eviden.com>
In-Reply-To: <ed082405-06a7-4407-9230-3a9b7e91406e@eviden.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Apr 2025 13:51:48 +0200
X-Gm-Features: ATxdqUHpN3hvvrWwnErNOggZHgGP3CHt5fnblaITMEuJzi51XGXFm0HTBrpaJDc
Message-ID: <CABgObfb4knJpLiPsQY35dFbT6kpS6p4iKcjHTeUn3_9A_8XSpw@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, 
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 15, 2025 at 1:51=E2=80=AFPM CLEMENT MATHIEU--DRIF
<clement.mathieu--drif@eviden.com> wrote:
> On 15/04/2025 11:30 am, Paolo Bonzini wrote:
> > Caution: External email. Do not open attachments or click links, unless
> > this email comes from a known sender and you know the content is safe.
> >
> >
> > On 4/15/25 08:18, CLEMENT MATHIEU--DRIF wrote:
> >> Address space creation might end up being called without holding the
> >> bql as it is exposed through the IOMMU ops.
> >>
> >> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com=
>
> >
> > Please use a separate lock instead of the BQL.
>
> Hi Paolo,
>
> We need this particular lock because some of the functions we call
> require the bql to be held.

What functions do you need?

> Is it a problem?

It depends on the function. :)

Paolo


