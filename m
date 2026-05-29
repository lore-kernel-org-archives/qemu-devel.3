Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8E8CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxnB-0004fY-0T; Fri, 29 May 2026 10:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxn9-0004aH-2g
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxn7-0007Ou-1N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qLc9/FKTOR8Ia6LRmqiLdVOg3rcV9rVBSg78YDl4nk=;
 b=TAIOlXnDNJsKYQS7YyY/Mz5T+bExYi3EIvFK6WBTU9IoGWAaL2DMAgmJuo0lb02p0WZnya
 f1Crt1V0gMomRSFt4lrZ0XVAhTfMsV7Y40qAYxqFXUxkmLkrg7vyuQdujcCwFU/xuvKCfJ
 EUUCxSrDf+HOqq7frhu00XbLhfKGmL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-HA7x0lszMbCy7UUkdYohbw-1; Fri,
 29 May 2026 10:02:19 -0400
X-MC-Unique: HA7x0lszMbCy7UUkdYohbw-1
X-Mimecast-MFC-AGG-ID: HA7x0lszMbCy7UUkdYohbw_1780063336
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A0419560AE; Fri, 29 May 2026 14:02:16 +0000 (UTC)
Received: from localhost (unknown [10.67.32.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5B371800465; Fri, 29 May 2026 14:02:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: Re: [PATCH v1] hw/s390x/ccw: Mark virtio-pci disable-legacy
 property as optional
In-Reply-To: <20260520183403.223983-1-jhkim@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260520183403.223983-1-jhkim@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 29 May 2026 16:02:09 +0200
Message-ID: <8733zamhzy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, May 20 2026, Jaehoon Kim <jhkim@linux.ibm.com> wrote:

> The s390-ccw-virtio-11.0 compatibility property for TYPE_VIRTIO_PCI
> "disable-legacy" causes QEMU to abort when instantiating
> vhost-user-fs-pci devices:
>
>   Unexpected error in object_property_find_err() at
>   ../qom/object.c:1284:
>   qemu-system-s390x: -device vhost-user-fs-pci: can't apply
>   global virtio-pci.disable-legacy=off: Property
>   'vhost-user-fs-pci.disable-legacy' not found
>
> The issue occurs because some vhost-user devices like
> vhost-user-fs-pci only implement the non-transitional variant
> and do not define a generic device type. Non-transitional
> devices have disable-legacy hardcoded to "on" and do not
> expose it as a property, while only generic device types have
> the "disable-legacy" property. This affects users running
> older machine versions (11.0 and earlier) even when using the
> latest QEMU version.
>
> Mark the global property as optional so it only applies to
> devices that actually have the property, allowing vhost-user
> devices without a generic variant to be instantiated
> successfully on older machine versions.
>
> Fixes: 26103c13cff0 ("hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)")
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4d35f9b10b..25a9fa4955 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -946,7 +946,7 @@ static void ccw_machine_11_0_class_options(MachineClass *mc)
>       * keep legacy virtio-pci enabled.
>       */
>      static GlobalProperty compat[] = {
> -        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "off", .optional = true },
>      };
>      ccw_machine_11_1_class_options(mc);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));

Thanks, queued to s390-next.


