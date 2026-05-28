Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B1DCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSc9f-0003VY-WC; Thu, 28 May 2026 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSc9e-0003V1-7b
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSc9b-0007Ww-VA
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779980170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6lUp5UGWLPTlmMScWFRoUehbX7GBzBwAHtuMCJMitE=;
 b=Y+n9GkOIJvofha06WQvVOo3Qx63Mqd0aNtkNbsCdq1jqRGOow17I1xBGYsbz1IKHK/OyDM
 gcdqGL9tKSQ2rAZIaqVEyh/A3A5tOmEBkj6emcHi2B6Do2weta2f9Fjzl13cw9VBUrRpgc
 78JLRou9V/6+TAnfHtx4ST8OS7ITD7Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-NawsTox0M--AM6t39XSo8A-1; Thu,
 28 May 2026 10:56:04 -0400
X-MC-Unique: NawsTox0M--AM6t39XSo8A-1
X-Mimecast-MFC-AGG-ID: NawsTox0M--AM6t39XSo8A_1779980162
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AC7B1955F41; Thu, 28 May 2026 14:55:53 +0000 (UTC)
Received: from localhost (unknown [10.44.49.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07B41800357; Thu, 28 May 2026 14:55:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: zhaoguohan@kylinos.cn, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] vfio: propagate IRQ notifier registration failure
In-Reply-To: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 28 May 2026 16:55:49 +0200
Message-ID: <87o6hzmvm2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 10 2026, zhaoguohan@kylinos.cn wrote:

> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() clean
> up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
> fails, but still return true to their callers.
>
> Return false after cleanup so callers can handle the failed registration
> path instead of treating it as a successful notifier setup.
>
> Please ignore the previous version.
>
> GuoHan Zhao (2):
>   vfio/ap: Return false when IRQ notifier setup fails
>   vfio/ccw: Return false when IRQ notifier setup fails
>
>  hw/vfio/ap.c  | 1 +
>  hw/vfio/ccw.c | 1 +
>  2 files changed, 2 insertions(+)
>

...I guess this should go through the s390 tree (and not the vfio tree?)
If yes, I'll pick it up.


