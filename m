Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD79E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLwaF-00018i-8F; Thu, 12 Dec 2024 22:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLwaC-0000yH-KE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLwaA-0000sR-LM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734061392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYWJXEnJJJ+x3j49imr7tVMv7NuaBUDXw37k6TQuaPA=;
 b=NzPuqMqtkOj2DNTYHPddWYDBvZzhARaMKOm1cAQh70mpDHd+9tQ9MbAhOLp3x3CzWEvVGl
 JL48d2OwNdVxd8LZI5G++UnX/sj8rADgkPgBV18/Hnogg3z3LutayUrnVR4w8ALk+qUVPb
 EGlMl6rJizcEz46YLhhRDxIO1a+3N1M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-na4eG269PTihvHpBQtzkpA-1; Thu, 12 Dec 2024 22:43:11 -0500
X-MC-Unique: na4eG269PTihvHpBQtzkpA-1
X-Mimecast-MFC-AGG-ID: na4eG269PTihvHpBQtzkpA
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-211c1c131c4so21280805ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 19:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734061390; x=1734666190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYWJXEnJJJ+x3j49imr7tVMv7NuaBUDXw37k6TQuaPA=;
 b=KPQ22aqgpXXfxLRC8bCtLXCrIWBfIEX0q1hdOFQydf9U5vX56e4a5l9lKXOhEqfMPq
 sqfXvqI0We/AOf5ghQeqsA3S2Al7lcT9PzNbOzvat/TYVBs1+hxSQHIdqhSEzUt+mhtu
 QWaFh0hXWQ7O/Mb2auOPPfoQc0vp/B/quUFe3Au4qGXBGiu6OGUxeBbEJwS3FHRXcpVc
 1Uck+Z5+nEV0Bt+GUcCmVUx/cXJXYqPkZCPGxJrDre2X4UgRUu0AZ66+ztQDfWsliQt3
 TVcAHUY0PuB20weVX2oqGK8ow+F+AUX79o/Aq1ocz+67d5PhSmV2L1sulI/RDPgAfn0h
 Z0uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpj/Vxjh3lMijUlbVWU3CMODujYDPBvwWIenoYPG6ljP09YizRkBlcY1ZfIHde77nfl5NzNFD8gQ0u@nongnu.org
X-Gm-Message-State: AOJu0YwuQhHOZ7kqjH1OlTM/YQFqctgnHu2UEZPHB522AjHly9K94Q6L
 mBRpSYFTBOmE+N0j1LZGpGE9viBdfxUnSQ4XLi2cVfVt4xktdaMVJa+qTk4OSagHu/uaSJAnXKU
 +a0t6xeUcE/7031O5CdIJhsupu99DwJRSQAv+CMsyXcWn0afh2ZjzVewZOHZeBhf0zMTMMQFweo
 ruUd09Z5Cs4L3PPhjxuLQudJt4z/k=
X-Gm-Gg: ASbGncs0fUpuejpigXUOpLB2neJUG1yiJKD0Vxq63V8BH5FzTT2sTfmZcmfGd503p2m
 0meieM4NCFQs3/n+93+ETJQbDNAvLdryTzoc2nCY=
X-Received: by 2002:a17:902:f693:b0:216:11cf:790 with SMTP id
 d9443c01a7336-2178c83305emr84710605ad.16.1734061390175; 
 Thu, 12 Dec 2024 19:43:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDbC+eBuTH3y1IbWzTMsgkZs986YknSIgAyiigd2Gj/M7/41yA8XwboGyqk01erKQ/bG/qcHuiDRa36Wq8Vao=
X-Received: by 2002:a17:902:f693:b0:216:11cf:790 with SMTP id
 d9443c01a7336-2178c83305emr84709845ad.16.1734061388915; Thu, 12 Dec 2024
 19:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
 <a9f91dc0-a424-453f-bd8a-7777e269b961@eviden.com>
In-Reply-To: <a9f91dc0-a424-453f-bd8a-7777e269b961@eviden.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:42:57 +0800
Message-ID: <CACGkMEsYhZ2QwCMyDBzD5mBUZ9EuKaME=9=oB=Sm6YTudQaHjg@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, 
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>
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

On Thu, Dec 12, 2024 at 5:50=E2=80=AFPM CLEMENT MATHIEU--DRIF
<clement.mathieu--drif@eviden.com> wrote:
>
> Hi,
>
> Thanks for the new version, changes are ok for me!
>
> @Michael @LiuYi, @Jason, do you think we are ready to move forward?
>

I think so. (I've acked the series)

Thanks


