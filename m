Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05FD5E12B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 04:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Gn8-0003qd-1o; Thu, 07 Nov 2024 23:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9Gn6-0003o5-3r
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 23:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9Gn3-0008KZ-Kl
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 23:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731040806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1DBs2mTkExA50h+Eek4ShEgemiRmfqdO26jL8qBgp0=;
 b=fbU6ANdHiYA6CT/rvpPcvl+GzlHqswaUap2zdw+GHW1lN0uQlnUYokg8A5IaLWHa9+NbHB
 fw558avROJ7R2/9hzwQkog85ysDDApLcVAPmgLnPPPDCDoPRx2VjsxyZXHXShfdV3u/gyP
 5sBH0CQb7EibVoyNK2CM+Nf5DESa874=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-6jOrOp2XM6elB6MHOw3D3g-1; Thu, 07 Nov 2024 23:40:05 -0500
X-MC-Unique: 6jOrOp2XM6elB6MHOw3D3g-1
X-Mimecast-MFC-AGG-ID: 6jOrOp2XM6elB6MHOw3D3g
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e9b2c5189eso285631a91.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 20:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731040804; x=1731645604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1DBs2mTkExA50h+Eek4ShEgemiRmfqdO26jL8qBgp0=;
 b=mWXHmwk8yM3gni/LNi2RKMKtEREDbiPkPlcKzFj7NGKVWZ2mGyeB7w4Vnkf0pwmLTY
 6DswP1exfjCMr2wz3CsPiDJ9na3c477CobakdZ29idrmeYI4Bc2YfDdY3H7XSpb/OdKJ
 /GnZcRmf+yRS9QY06DrPNIsWlnXssL7Rpdea3IM8YeQ6LInN7xRec0js2U7/vQonxz7/
 U9IRFmuHocTjWNylc2N+OAm+P4HP+Ooeb2U5G6qbLo19W6kyH/eJgtwlz1o0Ujj3uuD5
 yHpN9XS8Hpqn2BBuiMrS3WiFJ6vp1DMgUvcfOTkg+PHCBzjMc+OT/U48g1J59KBxC2Zl
 etDA==
X-Gm-Message-State: AOJu0YyVTT/XB80YVjpP0N+atHnLbysLnjTFlyC8p7nTvWq4MJkoYT7b
 pcMOl6b8gjAM5YekURC7GXdzyNDs7pnHxDXPQFaZnKS94wNnZrUK3BsRf4MzhfhTltxRgCSno1Z
 xs+P2gDfgL8YofNUwmoUsRVcXxpBttFa6iYBrEqqbF+F5676vqTYQDJ+bDlPYFo8PaWzRmFfGfP
 3qtePEzUZX8TuUvj6dqUbCBweMRcM=
X-Received: by 2002:a17:90b:1805:b0:2e9:3056:71dd with SMTP id
 98e67ed59e1d1-2e9b0a31d44mr1809230a91.7.1731040804160; 
 Thu, 07 Nov 2024 20:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLaEleygWVOQsb5Uy/2RPbBa5eLZHX6EHNU5k0T/E2RJx3oOqQIa4dWFHx4EMnOaMuiJludzoU2cYHvwIH5ws=
X-Received: by 2002:a17:90b:1805:b0:2e9:3056:71dd with SMTP id
 98e67ed59e1d1-2e9b0a31d44mr1809203a91.7.1731040803726; Thu, 07 Nov 2024
 20:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-14-zhenzhong.duan@intel.com>
In-Reply-To: <20240930092631.2997543-14-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 12:39:52 +0800
Message-ID: <CACGkMEsH450rjwQ426xoJacGaFEA=g1dyVu9AP4F3O=ontjO+w@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Sep 30, 2024 at 5:30=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> This is used by some emulated devices which caches address
> translation result. When piotlb invalidation issued in guest,
> those caches should be refreshed.
>
> For device that does not implement ATS capability or disable
> it but still caches the translation result, it is better to
> implement ATS cap or enable it if there is need to cache the
> translation result.
>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thank


