Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C511CCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxk0-0002mG-5Q; Fri, 29 May 2026 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxjz-0002ly-Ah
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxjx-00063z-UB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiS8bcIb+BqCkMAohiQczjMC6mlOMAvSJWOqIYJXCBA=;
 b=BeY9rfVY1lIcskDumL9n6LCrA/V8QaT+y7qYnlCcjDJCDRfVdDu3QBsjtLwi+qQdeN2j8n
 uWLJt0hIcKzqKtNI1ZeZfuh7emK3mZeX059MFa7Hx62dAayKUeOaufzBEqtWnaEjopgNYp
 HY4//mz7joY8POvoweTxl03pE7ZZKRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-e-3itRP4OHWv1IcIJMan7Q-1; Fri,
 29 May 2026 09:59:04 -0400
X-MC-Unique: e-3itRP4OHWv1IcIJMan7Q-1
X-Mimecast-MFC-AGG-ID: e-3itRP4OHWv1IcIJMan7Q_1780063142
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D32180061A; Fri, 29 May 2026 13:59:02 +0000 (UTC)
Received: from localhost (unknown [10.67.32.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27D619560A3; Fri, 29 May 2026 13:59:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Matthew Rosato
 <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] hw/s390x: Fix memory leaks after removing elements
 with QTAILQ_REMOVE
In-Reply-To: <20260511063825.53633-1-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260511063825.53633-1-thuth@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 29 May 2026 15:58:55 +0200
Message-ID: <87cxyemi5c.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11 2026, Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
>
> The elements that get removed with QTAILQ_REMOVE are never referenced
> afterwards anymore, so the corresponding memory should get freed.
>
> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Drop change to hw/s390x/s390-pci-bus.c (since it needs other rework)
>
>  hw/s390x/s390-pci-vfio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 7c754b656da..db6de00bd28 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -101,6 +101,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>      cnt->users--;
>      if (cnt->users == 0) {
>          QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
> +        g_free(cnt);
>      }
>  }
>  

Thanks, queued to s390-next.


