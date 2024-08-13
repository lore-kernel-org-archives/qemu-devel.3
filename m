Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7625EC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdnUX-0007u1-0F; Tue, 13 Aug 2024 05:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdnUO-0007ih-Qe
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdnUL-0003D3-RY
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723540002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kyrnuwm3scw1wk3jemcCC2FVr3wKBo0KrzdBI3MdMdM=;
 b=JRX0EIlNXvGYJaTmrbVnSIJC9mvW1AbHHoKeNFJ+UqSnkscufj+LBU/mo4UO0M31VYOl1+
 GRN+zFL+uM2GViIZv3/U6A3GDOr5e/yxtELjYb5RL9R4t0LA818Q+oS6Arj7+gtQCpIpb8
 ONx/WQrcSo1p4mnDEh6Z0OCR66vX9qE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-zNrco3aTM0GnGFF7QfLFpA-1; Tue, 13 Aug 2024 05:06:40 -0400
X-MC-Unique: zNrco3aTM0GnGFF7QfLFpA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb6c5f9810so5401313a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723539999; x=1724144799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kyrnuwm3scw1wk3jemcCC2FVr3wKBo0KrzdBI3MdMdM=;
 b=j5PQ9D05o+C7R2D6TkOfPwnq0a6/+hc7k0+mUyFAYLC9Nira7eA98y1dzWFCDg5z8Z
 wxeVKpONVrVWUaY5bk8pdOHlX8wxfC9iwqQ5H2ozhol0XRNqMCjDUs3sadN12o1n9T9d
 EaW+BwpQhLvX042kF8Xg4KJNum8u4gB4DCu/dL02nLsk8F9gWUaE2fCptIujBvLKLLq/
 xoggABfppBI0dDj0ogyE9THVLy/KMm6CwGhjwgsYobrMMCyadzoXy7OcyrNOGf7gdamu
 H7PMfG0jysOiYwdvIwezXc1ZQSXd0ag3S34WsZogbVuYgo9M4Kczmvvp8jwPDFFhBuJx
 OJ7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU+PDJi9GA4OnXaZfkPJr73Ops/6rYikEdm5IMbYLzrWXxpDzFpkgk0WRTYB4wnbilmG4NVzxJwvYqFNLYwFUkzRkgFP0=
X-Gm-Message-State: AOJu0Yzy3v1+ZMbyOIHGdXvfFCipuxOI7gMfjN4KlEpzHSvn/Ak6dFCk
 RJ71HeIhDi/btno9XEInZhl30Cdn9Sv0SqF61fDGrsmLRAmRrE/YgtQ/2R/PnjD2cDJSnoCm40p
 rvdLv3KwYg1Ny4g6sP3gHxsONlY2Ez6mJliMGQngZ6AyhM1EL9W12UuEQyfBQQ2wnaOBok4j6e5
 fhjhJkiaiqhQFdvEDDPv1Ke5ZJIk9TPrIXjvfv1g==
X-Received: by 2002:a17:90a:5106:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d3924e033fmr3057212a91.5.1723539999009; 
 Tue, 13 Aug 2024 02:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvAkU7xRu0JtzSi4eQ+tkdSR0fITCshGKJnQ7XEMwd+GKp30+9dU88c8tzgrn1MpgHXi74I54pjciixHF4KOI=
X-Received: by 2002:a17:90a:5106:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d3924e033fmr3057180a91.5.1723539998450; Tue, 13 Aug 2024
 02:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
 <20240813074410.2571369-3-zhenzhong.duan@intel.com>
 <5889eca7-7f2e-4a15-bce0-84af981044e3@intel.com>
In-Reply-To: <5889eca7-7f2e-4a15-bce0-84af981044e3@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 17:06:27 +0800
Message-ID: <CACGkMEvK4P=4qUSFkkWZAAHhR37CMBWkR7BtKLWArC_1G6hEdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
To: Yi Liu <yi.l.liu@intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 chao.p.peng@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 13, 2024 at 4:31=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2024/8/13 15:44, Zhenzhong Duan wrote:
> > In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB are
> > bypassed without scalable mode check. These two types are not valid
> > in legacy mode and we should report error.
> >
> > Suggested-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > ---
> >   hw/i386/intel_iommu.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>
> Do you think a fix tag is needed or not? @Jason

I think so (as it might have a guest triggerable issue).

Thanks


