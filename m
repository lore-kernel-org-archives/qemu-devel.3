Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB73C021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 01:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkCBu-0003lW-O6; Mon, 17 Feb 2025 20:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tkCBs-0003kx-TW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 20:14:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tkCBr-00063g-6c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 20:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739841260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QKc2rW0i1wV4Fb2kzyC2Hy9fnWSA4bTzdwDG7iLwSE=;
 b=ex/7iuYstVBBZs+GedULq/Qu776uFJS0PlNce3VOX4fYJraxPgyNzriBsDuXyNCdDyqdek
 SNt5lUVsO44TY60jaSjofhFkBa49DKf2VHLRutLYrY6sEVlBlUpK4jEdzed2MWkDxUQV1v
 NkPHH5GTEdatCD6YkDWQXTmeY7ghZho=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-9YpD4aVYMU22FdVrFG-lqg-1; Mon, 17 Feb 2025 20:14:16 -0500
X-MC-Unique: 9YpD4aVYMU22FdVrFG-lqg-1
X-Mimecast-MFC-AGG-ID: 9YpD4aVYMU22FdVrFG-lqg_1739841255
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc45101191so4382472a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 17:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739841255; x=1740446055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QKc2rW0i1wV4Fb2kzyC2Hy9fnWSA4bTzdwDG7iLwSE=;
 b=dr006TqFStFL2lmiZ8Me/bl5ceijm7ml1allyanMjRN36BrPxvwEhpFgkNDMprqVYJ
 EwdDjHTfj2eAaC8EDF5Dn3/CtQMtQaZIiBEm/BdOyN+1UcfAcyo4x8GZ8EC3x/5joQe8
 P2eGhXLmuKSGsgteOdf7BY1vQmtpUBgkEe84Ccrva2RJcpdQXTdFEgps/ddSqwF/BrL2
 JO5pYqKJSA1FBhIOSJ3NeQ6fFRhs91vA2UQEa+LFGyZlabH1GfscHqy6wUO0xWLqs569
 2MVp6zjC655HkzoICPNBshQXf5DLX2DZf69tvFY2CFBozDzVyzzWzpqNZ3SdyYC79qvt
 ZAXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlM1+c7S5ezTLGoZj4NJAkNv1CjK9AQfkG5DuNrCwnYpvxDUy0DKPOfto2fQrbfl7yomg3kCzEsVdN@nongnu.org
X-Gm-Message-State: AOJu0YyY5ywUwpPPoqufEwZpV9biSy1IPxEqYT/4EbfllfCAbQCoJi/e
 Ehgq/08Mq/q778+1bD65cb9YtdRlMNMySCNIA940YmrS7gOQDnhsvkotrgT9yeCWZeh2dIanWDY
 eYlwDxRyOqTXNmVlEY+KuLNgaHalLy9Jh/Rpas69mWquB+NeGSuR8AkfCXEw7OxupSohEkJMcYG
 EOyIZZ0bhoLEgt6BgPBh/amww3Em8=
X-Gm-Gg: ASbGncugiTWGmfh3EtPsaQGV3+n3GXiGEJ8SNZJEqM53QfcpshJ+V7UPTrzTOs11idV
 xeBObQD8qWNBilLoW2B44eg8AAjwQZ0Ji9aFb2d84UtNThcx4F4GBlm48mTVXyPA=
X-Received: by 2002:a17:90b:4d87:b0:2fa:1e3e:9be7 with SMTP id
 98e67ed59e1d1-2fc40d131d9mr17051765a91.5.1739841255319; 
 Mon, 17 Feb 2025 17:14:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGorY586wLmmmW5bOA2C+v4uJ4dV0/ji3GOH5veTnPzlDFOe7AxPFS9pbWvnOHRrI3YVoJbkZH95W8Kbalm5dY=
X-Received: by 2002:a17:90b:4d87:b0:2fa:1e3e:9be7 with SMTP id
 98e67ed59e1d1-2fc40d131d9mr17051740a91.5.1739841254908; Mon, 17 Feb 2025
 17:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20250217133746.6801-1-eric.auger@redhat.com>
 <20250217133746.6801-2-eric.auger@redhat.com>
In-Reply-To: <20250217133746.6801-2-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Feb 2025 09:14:03 +0800
X-Gm-Features: AWEUYZmcL4l4IpCMxpmu4MjRrSZnsA3hNG9wOACjiC59gINijRtHbheMI2NqjU8
Message-ID: <CACGkMEurfw7Sq8ctLj99QcY_mhKGcqCd+NT+p+suJPUW1NLoCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/virtio/virtio-iommu: Migrate to 3-phase reset
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, mst@redhat.com, imammedo@redhat.com, 
 peterx@redhat.com, alex.williamson@redhat.com, clg@redhat.com, 
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 17, 2025 at 9:38=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> Currently the iommu may be reset before the devices
> it protects. For example this happens with virtio-net.
>
> Let's use 3-phase reset mechanism and reset the IOMMU on
> exit phase after all DMA capable devices have been
> reset during the 'enter' or 'hold' phase.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


