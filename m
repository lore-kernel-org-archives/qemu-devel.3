Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87211C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 07:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwiJ-0002Np-N1; Thu, 06 Feb 2025 02:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tfwiI-0002N9-BL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 02:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tfwiG-0008Ss-A6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 02:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738828452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpM1DiCWJCCEVa3lgqZkhlN5dBSq8bOKzIQyE6SJ7kY=;
 b=NbordLiFhGFi6nFN0XMgACcKIx02wnC/sKy2yhGgQym6C4l/Fc3MpK32d4nAnYuK+/Hn9R
 tPWb7B4GYcVc6H7y2auJydo8dVNB/3Ykf83hymopMY+f4Zq7kz393rdYTq1TonIKvLJOdG
 z/kysqZvu4b+e8AdOLSi5Zl1mm4ik9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-xN6pM1XmNcqUY-Q03sKEng-1; Thu,
 06 Feb 2025 02:54:08 -0500
X-MC-Unique: xN6pM1XmNcqUY-Q03sKEng-1
X-Mimecast-MFC-AGG-ID: xN6pM1XmNcqUY-Q03sKEng
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E1111956086
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2025 07:54:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.57])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D826019560B9; Thu,  6 Feb 2025 07:54:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4811A1800396; Thu, 06 Feb 2025 08:54:03 +0100 (CET)
Date: Thu, 6 Feb 2025 08:54:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU
 address space width
Message-ID: <2rywkwsowee2sqj7ss7uqceis25i5ohf3n2jbpgmy24mqxwtqb@u4o37jpf7fky>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
 <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
 <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
 <22bb3017-1db3-4041-81f0-972568de1017@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bb3017-1db3-4041-81f0-972568de1017@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

> > Note that there is a 'guest-phys-bits' property for x86 CPUs, which is a
> > hint for the guest what the usable address width is.  It was added
> > because there are cases where the guest simply can't figure that it is
> > not possible to use the full physical address space of the cpu.  There
> > are some non-obvious limitations around 5-level paging.  Intel has some
> > CPUs with phys-bits > 48 but only 4-level EPT for example.
> > 
> > So one option to handle this is to make sure guest-phys-bits is not
> > larger than the iommu width.
> 
> Yes. This is what I am trying to do.
> 
> Patch [1] returns X86_CPU(cs)->phys_bits. I was not sure which *phys*
> property to use. If you think this is incorrect and not returning the
> right information, I will change the proposal with guest-phys-bits.

> [1] https://lore.kernel.org/qemu-devel/20250130134346.1754143-8-clg@redhat.com/

Yes, guest-phys-bits should be used here (and the helpers renamed too
for consistency, to avoid making all this more complex than it already
is).

take care,
  Gerd


