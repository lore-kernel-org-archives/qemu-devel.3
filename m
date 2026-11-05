Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DF606A338
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GVnMq3Hm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxC5-0005u6-8z; Thu, 05 Nov 2026 08:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOxC4-0005tb-1f
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOxC2-0007tF-6s
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793884068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/NHjJ4oRDywNrIhVjk6h12piizGbv5UkdSkbZKz0SdI=;
 b=GVnMq3HmqpWVUZRgB88RJ9tdDZLOJ3rmBVSttrKjm7dF6hzLglpfLGdXcGdTUwptYCZ4fD
 JskLyZ+IUi4uSyXew+NPiFoW4j5nMOOZ1yp6mhnqCg1HPD09esBQOYIBem1G7DHMWKGb8Y
 cizBfsiM/1UUDgdHyScEy3tvrucrMW4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-unXA7i6TO36PWPhyQ66Ghw-1; Thu,
 05 Nov 2026 08:07:46 -0500
X-MC-Unique: unXA7i6TO36PWPhyQ66Ghw-1
X-Mimecast-MFC-AGG-ID: unXA7i6TO36PWPhyQ66Ghw_1793884065
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 971CA1955F2C; Thu,  5 Nov 2026 13:07:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.106])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB68E18004F5; Thu,  5 Nov 2026 13:07:43 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:07:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Sanne Raymaekers <sraymaek@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 hreitz@redhat.com
Subject: Re: [PATCH v3 0/3] block/vmdk: fixes for stream optimized disks
Message-ID: <aux_nVIm9lsxuRX0@redhat.com>
References: <20261016123750.94769-1-sraymaek@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016123750.94769-1-sraymaek@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 16.10.2026 um 14:37 hat Sanne Raymaekers geschrieben:
> The stream optimized disks produced by qemu-img did not quite adhere to
> the specification. This could trip up other software consuming these
> disks. The goal of these patches is to get the VMDKs produced by QEMU to
> better match the specification, the Virtual Disk Format 5.0 Technical
> Note.
> 
> For instance, when packaging the VMDK up in an OVA archive (a ustar
> archive containing an OVF, a manifest and a VMDK), errors occur when
> importing that OVA into VMWare Workstation. Specifically the digest in
> the manifest does not match the digest of the VMDK, because Workstation
> reads (and parses) the disk contents and then makes a digest, rather
> than making a digest of the whole VMDK file. Extra null bytes at the
> very end will trip it up, as they are ignored in the digest made by
> Workstation, but are included in the digest produced by something like
> shasum.
> 
> Note that stream optimized disks, while not adhering to the
> specification fully, are still useable by VMWare tooling, with some
> workarounds where needed. For instance, VSphere does not have the same
> issue as Workstation.
> 
> V3 cleans up some formatting and makes the commit messages clearer.
> 
> Sanne Raymaekers (3):
>   block/vmdk: align stream optimized data grains on 512 byte chunks
>   block/vmdk: skip RGD for stream optimized disks
>   block/vmdk: add eos marker for stream optimized disks

Thanks, applied to the block branch (and meanwhile merged into master as
well; somehow I missed sending this reply).

Kevin


