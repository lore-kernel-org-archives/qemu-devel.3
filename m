Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C6310F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXlC-0000N0-6M; Wed, 08 Apr 2026 14:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wAXl9-0000HI-PA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wASFe-0003ar-2A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775652201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCK6eMZdhrr+khkmZ5YjpjgyZSA5Hzy+0gwhwZZl8a4=;
 b=hdb9zOUkcRRa/9k4YgmuLoMsuuFETlnihlQw5ZJfRy5nxX2CpL86y/hxo91N1r7ikGIDVM
 A/D209W4jEw0K7dRD55Xz5u0dEmUognIS7zpWCo8sOZK/oFzXZilD9jyQev3PRKvNVFVEn
 FZFrCmKawmIsXhYPWwxnZ9nvP11C6yQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-S1ORxFPAMHikvwKzuL734w-1; Wed,
 08 Apr 2026 08:43:19 -0400
X-MC-Unique: S1ORxFPAMHikvwKzuL734w-1
X-Mimecast-MFC-AGG-ID: S1ORxFPAMHikvwKzuL734w_1775652197
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 369F01800619; Wed,  8 Apr 2026 12:43:17 +0000 (UTC)
Received: from localhost (unknown [10.44.33.128])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C8511955D84; Wed,  8 Apr 2026 12:43:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 01/15] s390x/pci: implement IOMMU replay
In-Reply-To: <20260402022921.298818-2-kshk@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260402022921.298818-1-kshk@linux.ibm.com>
 <20260402022921.298818-2-kshk@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 08 Apr 2026 14:43:13 +0200
Message-ID: <87bjftd3mm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 01 2026, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:

> From: Matthew Rosato <mjrosato@linux.ibm.com>
>
> There are a few scenarios where IOMMU replay can potentially be needed
> for zPCI device, namely VFIO device reset scenarios where the guest
> continues running and expects the contents of its IOMMU to be replayed
> upon IOAT re-registration and migration scenarios where the destination
> must reconstruct the IOMMU on the destination.
>
> zPCI migration is not supported yet, but the IOMMU replay function is
> implemented so that it can be called both from IOMMUMemoryRegionClass
> now and migration post_load later.
>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c          | 50 ++++++++++++++++++++++++++++----
>  hw/s390x/s390-pci-inst.c         |  4 +--
>  include/hw/s390x/s390-pci-inst.h |  1 +
>  3 files changed, 47 insertions(+), 8 deletions(-)

Just a procees nit: Please make sure that the s-o-b chain is complete,
i.e. that your s-o-b is always last in the chain, even if you pick up a
patch authored by someone else.


