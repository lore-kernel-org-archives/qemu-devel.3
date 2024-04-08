Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6563C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlkj-0007Ac-Rc; Mon, 08 Apr 2024 05:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rtlki-00078y-BK
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rtlke-0006yM-AQ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712570236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpPwwhZQvfyVKI1ScATuiFqUzbMNKFoAwt3rnrlKkOE=;
 b=g5RkQZarC3W94e/0Xrd4gtZIU6+B7is6N3Pg83NJc6GGvxnMyycCxv3Uus9qdWbuLbxk/9
 lFcITJGW9QC5+2Br/LQMf6PUBaTZo/yR4UR+BPQZWxSTUz+WviQuXhBozHwCWog5PRkOTR
 Jgoz+WozKNRaQ2Tpbf2XwiS4On5lM7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-6gsbntKdPLqQWfpK7YDd8Q-1; Mon, 08 Apr 2024 05:57:15 -0400
X-MC-Unique: 6gsbntKdPLqQWfpK7YDd8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E6E488CE80
 for <qemu-devel@nongnu.org>; Mon,  8 Apr 2024 09:57:15 +0000 (UTC)
Received: from localhost (unknown [10.39.194.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0156A17AB3;
 Mon,  8 Apr 2024 09:57:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Revert "hw/virtio: Add support for VDPA network
 simulation devices"
In-Reply-To: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 08 Apr 2024 11:57:09 +0200
Message-ID: <87ttkci3d6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 08 2024, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.
>
> The patch adds non-upstream code in
> include/standard-headers/linux/virtio_pci.h
> which would make maintainance harder.
>
> Revert for now.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio-pci.h              |   5 -
>  include/hw/virtio/virtio.h                  |  19 --
>  include/standard-headers/linux/virtio_pci.h |   7 -
>  hw/net/virtio-net.c                         |  16 --
>  hw/virtio/virtio-pci.c                      | 189 +-------------------
>  hw/virtio/virtio.c                          |  39 ----
>  MAINTAINERS                                 |   5 -
>  docs/system/device-emulation.rst            |   1 -
>  docs/system/devices/vdpa-net.rst            | 121 -------------
>  9 files changed, 3 insertions(+), 399 deletions(-)
>  delete mode 100644 docs/system/devices/vdpa-net.rst

Acked-by: Cornelia Huck <cohuck@redhat.com>

We should get rid of this before we release a version with non-upstream
header code.


