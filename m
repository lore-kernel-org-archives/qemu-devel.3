Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC8DCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxnm-0005Fz-Hz; Fri, 29 May 2026 10:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxnd-00056B-KD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxnb-0007aX-CT
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnziDNrW+RfSo4sSZ/252Mbjd95KALAn8SjKwgl/ObA=;
 b=ZpL0Mr/K7qAXxmUF81uFHCTJ1RjKmU6PjR1LzvI2oZFRlVIJKfLb1iCsmSOY7YfmjoAzxK
 pAEiW5MNTrS4+8GTtqOpD8sVrjtCFwg3cmUa1eKZyjn/1B14vBmEhpIxw+JnsSoj1ZiNi1
 7nu2CwFo+1Marf/hLI7TPevA0I/56D4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-touvozbFMeKz4sZJfiYfDg-1; Fri,
 29 May 2026 10:02:49 -0400
X-MC-Unique: touvozbFMeKz4sZJfiYfDg-1
X-Mimecast-MFC-AGG-ID: touvozbFMeKz4sZJfiYfDg_1780063368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 731641800589; Fri, 29 May 2026 14:02:48 +0000 (UTC)
Received: from localhost (unknown [10.67.32.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED2B6180034E; Fri, 29 May 2026 14:02:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, alifm@linux.ibm.com,
 qemu-stable@nongnu.org, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v1] s390x/pci: Fix interrupt forwarding disable for
 interpreted devices
In-Reply-To: <20260521182946.1607-1-alifm@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260521182946.1607-1-alifm@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 29 May 2026 16:02:41 +0200
Message-ID: <87zf1il3em.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 21 2026, Farhan Ali <alifm@linux.ibm.com> wrote:

> Remove the FH_MASK_ENABLE check when disabling interrupt forwarding
> during device reset. This check was broken for the default case in
> the switch statement above, preventing proper cleanup of interrupt
> forwarding.
>
> The pbdev->aif check in s390_pci_kvm_aif_disable() already guards
> against double-disabling of interrupt forwarding.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 3665aba106..2f7b214891 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1542,7 +1542,7 @@ static void s390_pci_device_reset(DeviceState *dev)
>          break;
>      }
>  
> -    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE)) {
> +    if (pbdev->interp) {
>          /* Interpreted devices were using interrupt forwarding */
>          s390_pci_kvm_aif_disable(pbdev);
>      } else if (pbdev->summary_ind) {

Thanks, queued to s390-next.


