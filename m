Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D911DD5E12A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 04:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9GsT-0005yK-3L; Thu, 07 Nov 2024 23:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9GsQ-0005xz-Fp
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 23:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9GsO-0000Nz-2B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 23:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731041138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x4WJ0i9OIXdrVTAy04CcxIiSAEeWkPV6WfWuPlhc/M=;
 b=YR+6vwE/TkmW3unV35rpYsUZ2njiw8aP+C86AQ0sSBfmzrCWpVlhN01RYBjbOpIQZzPPmv
 uMbFR9paBCBXHvkBQ/W3vXqU0LC7Dny3Hc/CFJbyKEwFCglejuKpTn7DknoxzOeT9LL5Tx
 WpyTJMcYn3KlzMrtcsH2wKswTORxSPc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-dsd2lV1zMxiriLmrezyhWw-1; Thu, 07 Nov 2024 23:45:36 -0500
X-MC-Unique: dsd2lV1zMxiriLmrezyhWw-1
X-Mimecast-MFC-AGG-ID: dsd2lV1zMxiriLmrezyhWw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e2d17b0e86so1736675a91.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 20:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731041135; x=1731645935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4x4WJ0i9OIXdrVTAy04CcxIiSAEeWkPV6WfWuPlhc/M=;
 b=ATmlKwWNfm0AutmIq7k4KLZcaIlnkYPg1DHXhPDuiaEXN1nmDF+9Ej7NW44Gz+019E
 dE4JpXA0uCyVRilGCYolQp96wOk2jKu5j91+2wZm9udSRlt/ThiMQmyKJHX5HgEZ6Nt4
 LYtbDEMd5y1Qs25MD1W3XUWudxqhfEedHOMg8g7RaBcPkdwRSlV3aUsXxsE5vx8yR+Lv
 VmVGGseB20UCw+FKWsJ45otv5JhvCzSmeaaeL17ogNUcODWK1PsII2jdY9xkPogs70KP
 RuI8aEtfbhWJrL6v4upo7Gikr9OmXhuBo5IQjbd/gP8+wYggp1cYRvPGQLZoesxSd+z3
 h8Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp8TYyK4hfu3wy/kxBJo2XcVY2YM8Wms9BaCBJBqYt+OhdH2O2xzsNheU9lzxMbbh0QFEMLXvDBaqt@nongnu.org
X-Gm-Message-State: AOJu0YwCUKAvRoq7+7LrrK21wHRsSs+yEZey9Vq2IRThp8jvfakZpiqI
 FwsaYfarXb2uXr4DZS3qpJwLmyq5d6lutXQKTlLB/D4CfNJ9ZGnL3DwtvSDa2CuCEXmd42CNlfO
 K3g2fMjo+PssEAtXKy5/Fc+S6zzbmi+EmnNtCLVg+kQQIWq/GRh7ren22H3bByFVHC229hJhO+6
 CYTDFEbzI7jmrKSHgPs8H6ghqDNbE=
X-Received: by 2002:a17:90b:4a91:b0:2e2:a3aa:6509 with SMTP id
 98e67ed59e1d1-2e9b1697bf5mr2231036a91.14.1731041135683; 
 Thu, 07 Nov 2024 20:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiLAKdik99u9bSlSKZ1RUiA0LB7M9RGPLQ/YYLQC79zMLkx2L4QwCouRhfBNv7w9mQ5hv+EEPyJWg4gzbN60o=
X-Received: by 2002:a17:90b:4a91:b0:2e2:a3aa:6509 with SMTP id
 98e67ed59e1d1-2e9b1697bf5mr2230999a91.14.1731041135236; Thu, 07 Nov 2024
 20:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-17-zhenzhong.duan@intel.com>
 <ef0e97df-5b88-4329-906a-c8d0cab8bbdd@intel.com>
In-Reply-To: <ef0e97df-5b88-4329-906a-c8d0cab8bbdd@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 12:45:24 +0800
Message-ID: <CACGkMEtA7A0YGMRn+EOWR0D9K8Aag0xZ7dt_U3-D+06TKOxvKQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
To: Yi Liu <yi.l.liu@intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org, 
 alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com, 
 mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com, 
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com, 
 kevin.tian@intel.com, chao.p.peng@intel.com, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Mon, Nov 4, 2024 at 2:56=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2024/9/30 17:26, Zhenzhong Duan wrote:
> > This gives user flexibility to turn off FS1GP for debug purpose.
> >
> > It is also useful for future nesting feature. When host IOMMU doesn't
> > support FS1GP but vIOMMU does, nested page table on host side works
> > after turn FS1GP off in vIOMMU.
>
> s/turn/turning
>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


