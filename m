Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9564E7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIg3r-0001YA-TU; Tue, 03 Dec 2024 22:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIg3p-0001Xh-TN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIg3o-0005aL-Hu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733282899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pp6J3ydXR8vQhfa0mhoB5WkeKohNy7fB8n8ujpiVYlQ=;
 b=OlBEx9VLsIUQzaAYMKIr6r1XsECqg5g4VhCYxQl1WWX3FiqXbR1Xnts+ZagoF/cP81kOeK
 4hx/WGms5KcAAkzFOZlzwlNxO1mzHehHaOv/TknKm+udI0YFsHCcx3Qm7DXkIhClucy2yL
 JVA1Xj1KWNVvFTdykVHNBQHIZ8UTgZQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-odgzcj1nPv6Fx_SPsBSEqA-1; Tue, 03 Dec 2024 22:28:17 -0500
X-MC-Unique: odgzcj1nPv6Fx_SPsBSEqA-1
X-Mimecast-MFC-AGG-ID: odgzcj1nPv6Fx_SPsBSEqA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee31227b58so5631081a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 19:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733282897; x=1733887697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp6J3ydXR8vQhfa0mhoB5WkeKohNy7fB8n8ujpiVYlQ=;
 b=aPF+ZEcxDwM/4dOPlMyAmLXMoB4k5k49VNQlolwOczpV1vTLA+KnJDDQxf7o3OkeNw
 7Yk5uP/79pBtrZNlFBXiydWvHGxd8j9/1nIlOG+oiYcCNW9luRj2onxRT0JGf1VGLbLM
 xt3jV1Qz6hFJrWrk/7LFD2tEMVQ3tgjDJv7Tev32vvHIzNQgtNOEezOfKIQS0INV5+eh
 Il75nK0D8mVrn8mOmPg45Jy5O5b/cm10hykWGucpe/w8yd/PxqBfGUkhwlDPTwggv4EY
 W3lzDkJdzzjZf3FoIyOHJM/GAi9RX+pyUxQ8BWlcac/ckefuNOujYZe3ShXw5r8wmGBK
 q9Fw==
X-Gm-Message-State: AOJu0YzpFWEVkWDe85RfVuD22iszsriX85PWleHHLUeVSVbdQEwCDTof
 XzZaiLIeM+By1f5AMirq+sS4EkDQ/QNl+EXozjM5GI74J5FmX7yTc/rKYlcvmEJ18PVRyhGIyaS
 UWeSaOSNrN92WRwZR8b0jAs/MTKTk05PdH3gVIFTSRKKEFYCIOYzZom+piil19bShT7+sOZfoKV
 j4yqxHB70BlsNbcuzQvwVuXQvc1Wg=
X-Gm-Gg: ASbGncsECBzcmDkLKQ0S6t742YxIVVbhNGNZkhUPWG6p1mt0SfqnVc04F7trtUhAX6L
 dC5r19aUy2ITQnkVootG3I7BUMnp1Hr9U
X-Received: by 2002:a17:90b:2245:b0:2ee:49c4:4a7c with SMTP id
 98e67ed59e1d1-2ef012101f6mr6273483a91.18.1733282896944; 
 Tue, 03 Dec 2024 19:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA6TP/x9WclUWluSvN2uaoZXMXp3yhh76IwLKyT1t67EP37adsHYLLTdV1QrAVZfmZqn28D26Xk/zr5kc0Z0g=
X-Received: by 2002:a17:90b:2245:b0:2ee:49c4:4a7c with SMTP id
 98e67ed59e1d1-2ef012101f6mr6273454a91.18.1733282896587; Tue, 03 Dec 2024
 19:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-17-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-17-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 11:28:05 +0800
Message-ID: <CACGkMEsfRRr2+4311aTGnAzy+Sck-qp1egdZ1R8WhB47iv260w@mail.gmail.com>
Subject: Re: [PATCH v5 16/20] intel_iommu: Set default aw_bits to 48 starting
 from QEMU 9.2
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Mon, Nov 11, 2024 at 4:39=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> According to VTD spec, stage-1 page table could support 4-level and
> 5-level paging.
>
> However, 5-level paging translation emulation is unsupported yet.
> That means the only supported value for aw_bits is 48. So default
> aw_bits to 48 in scalable modern mode.
>
> For legacy and scalable legacy modes, 48 is the default choice for
> modern OS when both 48 and 39 are supported. So it makes sense to
> set default to 48 for these two modes too starting from QEMU 9.2.
> Use pc_compat_9_1 to handle the compatibility for machines before
> 9.2.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


