Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59927CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy1I-0000dR-EE; Fri, 29 May 2026 10:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSy1G-0000d1-Hu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSy1E-0005ac-R3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780064219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaOsw2yPCM+YUSoF5bwX/fshlOBNdq2pweasnBN4ECI=;
 b=feVO2gbIEltLdghaTZHqUefpuPAJLyGJoB9s+s3GxXi4UOJ8mlDbJgMrOS1kQomH8e1MqH
 IIR0YolRfHRqzkylDPHpCSvusEj9f91YM1g+6JsOWebq3Q3TzqeQQRhPSAe9mSnsk5iLxb
 LMErYZeiRtEwg+jXcdjLBud0O5+0Qmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-Oh8L9X5GNP-fFIBnmyHQww-1; Fri,
 29 May 2026 10:16:57 -0400
X-MC-Unique: Oh8L9X5GNP-fFIBnmyHQww-1
X-Mimecast-MFC-AGG-ID: Oh8L9X5GNP-fFIBnmyHQww_1780064216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BE9A1800BE1; Fri, 29 May 2026 14:16:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33D621955F22; Fri, 29 May 2026 14:16:50 +0000 (UTC)
Date: Fri, 29 May 2026 16:16:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
Message-ID: <ahmf0NMXECP6_6sc@redhat.com>
References: <20260520235952.500250-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520235952.500250-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 21.05.2026 um 01:59 hat Denis V. Lunev geschrieben:
> From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convenient. One should
> perform
>     qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>     qemu-img bitmap --remove
> for each present bitmap.
> 
> The patch adds --remove-all sub-command to 'qemu-img bitmap'. The
> new sub-command also composes with other bitmap actions in the same
> invocation, so a common "wipe and recreate" workflow can be expressed
> as
>     qemu-img bitmap --remove-all --add NEW FILE
> instead of enumerating existing bitmaps, removing them one by one,
> and only then adding the fresh one.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>

Thanks, applied to the block branch.

Kevin


