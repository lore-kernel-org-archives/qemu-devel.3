Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81147D5E120
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9FTT-0006nN-Ut; Thu, 07 Nov 2024 22:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9FTR-0006n5-RO
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9FTQ-00080S-7W
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731035744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaMRLmNOOUYMp/aL2Ejl2SIIm+ReMsWrygED3ofnd0I=;
 b=Z+K71NDryOWVtQ4MjcjPWSzut7wVJOSmdQ6pQ3imjUIF/2qzAXYWs2oPqB4PZgSB65ZJ5x
 r5NGyDEwDjE8vbreAhlzSratEQI7QDTJ1qkfxPsrcvVAA6p6GYkefFoexidhJXofDvWI1n
 piKCoV0AIEbYuxWTqjl+i5ICV5LXw5g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-uyjbmn-5Mn-a2bBxoXH4Jg-1; Thu, 07 Nov 2024 22:15:39 -0500
X-MC-Unique: uyjbmn-5Mn-a2bBxoXH4Jg-1
X-Mimecast-MFC-AGG-ID: uyjbmn-5Mn-a2bBxoXH4Jg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e9b5209316so97441a91.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731035739; x=1731640539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gaMRLmNOOUYMp/aL2Ejl2SIIm+ReMsWrygED3ofnd0I=;
 b=q0UJySqFrtoZ2X4CVVK5We7g2is6uFiGItYUSxyh6CKAKD+I3VQv6UE88wkAjHV/I0
 vPJrgASFh9NKldsgkFSqY8/YgusvS5FktPxLW25MVPhdf1PG2/Mh7re5k1nVEIHCk6F+
 CjdpLBcB46e4Xj3WN45Bq1ghJwGf5dIS0v2tEobau7ENhi5y2aMoEf943B2MT8I0oY6K
 ZngzXv8PCpOpqZzyVZSxel56cDeSGM6ZPMl2a1/NSmpRpwiDZFNbKvKsKmuOychrEpdQ
 cs2GuR4yhDmvtzQpCFKgtRrxZJraYYi8oy7aotzNVrd0D5AeXRsmC+djdKmibMfRTBdE
 N4ww==
X-Gm-Message-State: AOJu0Yxf+sKBTX5KJQiizZP+jOzLhmd7BdXBVF+muyJlWFeliE6djfs4
 C7E7xkJdJGfloLk68dcp8a0SNOa7l1ZSuk89mj9uMsA5stOSo4zMG+BkliPFELC/8zyuMZbSJ3V
 qE9DqzHOjAQeXajOsDR8IJ14VmTFOiePJN3h+nTSC4ojUao2euhphZxTJWHGJ8VSZPj6Fd7XjbP
 tZww27h9rWa8fpdCCfGUDq8yKvuc4=
X-Received: by 2002:a17:90b:3884:b0:2e7:7f7f:9681 with SMTP id
 98e67ed59e1d1-2e9b16eebdbmr2175006a91.6.1731035738774; 
 Thu, 07 Nov 2024 19:15:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjND73ycWFWY92uuLl1BRkwvzysRlXUb2AM7pXLSCxeN734WBjU/vntQBUfo0sR3IGjiwigCTatT9wB0DT58g=
X-Received: by 2002:a17:90b:3884:b0:2e7:7f7f:9681 with SMTP id
 98e67ed59e1d1-2e9b16eebdbmr2174985a91.6.1731035738398; Thu, 07 Nov 2024
 19:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-9-zhenzhong.duan@intel.com>
In-Reply-To: <20240930092631.2997543-9-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 11:15:27 +0800
Message-ID: <CACGkMEus1FJC1E4rEowxpXwcx2ntWjCyKeQgaTxtAtogZ=6sHw@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
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

On Mon, Sep 30, 2024 at 5:30=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
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


