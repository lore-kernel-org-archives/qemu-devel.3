Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D46C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5j3-0006i8-Jj; Mon, 19 Feb 2024 10:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5j1-0006hT-Pz
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5j0-0008CF-EN
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708357113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6gOAk9dKraK6KCXg9oWRWIbk3YBA055sIODPEhg8T0s=;
 b=Ey2iT/ukpcKUsIBAofBUh+LKsRUTpcxL4V7MQyWMqUolDm6W6e9toRzsm1T/5KPkcIY4jv
 DWrP5Oth2esvhsAX2AhcVAnTkNtz/dgy+enBsK78/Y/L56AD/CTjSGXRKYZPP+qEyzwCut
 oTFSoo9sc5tCDfYwgKW5VPWwR2oAO4s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-XsxSdubtORmbo8jFgvsoiw-1; Mon, 19 Feb 2024 10:38:29 -0500
X-MC-Unique: XsxSdubtORmbo8jFgvsoiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4AFF85A588;
 Mon, 19 Feb 2024 15:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 668878BCC;
 Mon, 19 Feb 2024 15:38:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E25221E6740; Mon, 19 Feb 2024 16:38:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/3] virtio: Declare the decoding functions to static
In-Reply-To: <7b92f9ccc9ca5e4d6a2e2dd7804f172dc538f355.1706883915.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Fri, 2 Feb 2024 22:32:16 +0800")
References: <cover.1706883915.git.yong.huang@smartx.com>
 <7b92f9ccc9ca5e4d6a2e2dd7804f172dc538f355.1706883915.git.yong.huang@smartx.com>
Date: Mon, 19 Feb 2024 16:38:27 +0100
Message-ID: <87bk8cihvw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hyman Huang <yong.huang@smartx.com> writes:

> qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()
> are now only used in virtio-hmp-cmds.c.  So move them into there,
> redeclare them to static, and replace the qmp_ prefix with hmp_.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  hw/virtio/meson.build       |   3 +-
>  hw/virtio/virtio-hmp-cmds.c | 677 +++++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-qmp.c      | 661 -----------------------------------
>  hw/virtio/virtio-qmp.h      |   3 -
>  4 files changed, 670 insertions(+), 674 deletions(-)
>
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 47baf00366..6665669480 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -9,7 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c')
>  
>  specific_virtio_ss = ss.source_set()
>  specific_virtio_ss.add(files('virtio.c'))
> -specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
> +specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c', 'virtio-hmp-cmds.c'))

I think you can also move virtio-qmp.c, i.e.

   specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-hmp-cmds.c'))

here, and ...

>  
>  if have_vhost
>    system_virtio_ss.add(files('vhost.c'))
> @@ -74,7 +74,6 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>  system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
>  system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
>  system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
> -system_ss.add(files('virtio-hmp-cmds.c'))

   system_ss.add(files('virtio-qmp.c'))

here.

[...]


