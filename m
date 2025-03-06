Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDD1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8hP-0005mi-Hv; Thu, 06 Mar 2025 05:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tq8hH-0005U3-8N
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tq8hD-00013E-Dw
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741257797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCn44R6Jj2zqzNFRY/+pHZ0rHttc1kRizyt07LUZpf8=;
 b=Hsor+DzP79E/klwWrC5Ef7/RQHLhEqPIO/p0pd7rNSnLBS+AlAoeAMyrS52aKHfvGuT677
 Dzl1HM2jKTufkAQ93c1cRLp/sLCm72odzQ7wUc06mQGfL1jBQ3pPCGs/j5AIblW5tm/ldA
 aE15cZ7lwCVYTO5ryb0lc4PckErsUc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-rMXVYuggMd6u0hrAc2HfoQ-1; Thu,
 06 Mar 2025 05:43:09 -0500
X-MC-Unique: rMXVYuggMd6u0hrAc2HfoQ-1
X-Mimecast-MFC-AGG-ID: rMXVYuggMd6u0hrAc2HfoQ_1741257788
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 700A8180AF73; Thu,  6 Mar 2025 10:43:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.123])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B524180174D; Thu,  6 Mar 2025 10:43:05 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:43:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alberto Faria <afaria@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] scsi-disk: Advertise FUA support by default
Message-ID: <Z8l8N0JGULfuNrzH@redhat.com>
References: <20250304155232.1325581-1-afaria@redhat.com>
 <20250304155232.1325581-2-afaria@redhat.com>
 <Z8cnJB2KRxl9ULHC@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8cnJB2KRxl9ULHC@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 04.03.2025 um 17:15 hat Daniel P. Berrangé geschrieben:
> On Tue, Mar 04, 2025 at 03:52:31PM +0000, Alberto Faria wrote:
> > FUA emulation code is already is place.
> > 
> > Signed-off-by: Alberto Faria <afaria@redhat.com>
> > ---
> >  hw/scsi/scsi-disk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index e7f738b484..8cf50845ab 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -3212,7 +3212,7 @@ static const Property scsi_hd_properties[] = {
> >      DEFINE_PROP_BIT("removable", SCSIDiskState, features,
> >                      SCSI_DISK_F_REMOVABLE, false),
> >      DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
> > -                    SCSI_DISK_F_DPOFUA, false),
> > +                    SCSI_DISK_F_DPOFUA, true),
> 
> Should this come with machine type compat to prevent us advertizing FUA
> to existing machine type versions ?

To give a little more background to Alberto: When upgrading QEMU, you
don't want the guest-visible machine to change. You already don't really
want hardware changes while the VM is down (Windows might require
reactivation etc.), but we support live migration between old and new
versions (often in both directions) as long as you use the same machine
type, and no guest expects that the hardware changes while it's running.

So we can only change guest-visible features in new machine types. What
you set here is fine for all new machine types, but you'll have to set
it back to false in hw_compat_9_2 in hw/core/machine.c so that all older
machine types still get the old default.

Kevin


