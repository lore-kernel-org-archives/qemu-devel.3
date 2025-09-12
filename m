Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD429CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4wE-0003Nk-9I; Fri, 12 Sep 2025 10:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux4wB-0003ND-U2
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux4w5-0005tZ-UG
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757687976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XndAHQXz3pJqh92rZEbiXfbEhSH8/wawjXH8c4hu/fI=;
 b=eVXem3cW7pcnuV3CV19QsQqpDyn7hY0u4rHsYnqh/rQPUx7KRMqRrMNOz1odLBIDWd3yc7
 +EToTZTWyIc3lgV/nc9V88FUblYpqL4Kdis8M32W9KvtOIFzihYuNj4254Ge9gnJQcsbS+
 eISBvLvaC6QUTVneOPYNLX8I6CIqW/A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-YRMl5rZmNUaBqgUYh-Y-bw-1; Fri,
 12 Sep 2025 10:39:31 -0400
X-MC-Unique: YRMl5rZmNUaBqgUYh-Y-bw-1
X-Mimecast-MFC-AGG-ID: YRMl5rZmNUaBqgUYh-Y-bw_1757687970
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D9B418004D8; Fri, 12 Sep 2025 14:39:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB32180035E; Fri, 12 Sep 2025 14:39:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96CB121E6A27; Fri, 12 Sep 2025 16:39:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  peterx@redhat.com,  farosas@suse.de,
 raphael@enfabrica.net,  sgarzare@redhat.com,
 marcandre.lureau@redhat.com,  pbonzini@redhat.com,  kwolf@redhat.com,
 hreitz@redhat.com,  berrange@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org,
 steven.sistare@oracle.com,  den-plotnikov@yandex-team.ru,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>, devel@lists.libvirt.org
Subject: Re: [PATCH 02/33] vhost: drop backend_features field
In-Reply-To: <20250813164856.950363-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 13 Aug 2025 19:48:23 +0300")
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-3-vsementsov@yandex-team.ru>
Date: Fri, 12 Sep 2025 16:39:25 +0200
Message-ID: <877by368gy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Cc: libvirt

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> This field is mostly unused and sometimes confusing (we even have
> a TODO-like comment to drop it). Let's finally do.
>
> The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
> and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
> vhoust-user-net). But we can simply recalculte these two flags inplace
> from hdev->features, and from net-client for
> VHOST_NET_F_VIRTIO_NET_HDR.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 66be6afc88..9f9dd2d46d 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -100,16 +100,9 @@ struct vhost_dev {
>       *
>       * @features: available features provided by the backend
>       * @acked_features: final negotiated features with front-end driver
> -     *
> -     * @backend_features: this is used in a couple of places to either
> -     * store VHOST_USER_F_PROTOCOL_FEATURES to apply to
> -     * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
> -     * future use should be discouraged and the variable retired as
> -     * its easy to confuse with the VirtIO backend_features.

I guess this is the TODO-like comment mentioned in the commit message.

>       */
>      uint64_t features;
>      uint64_t acked_features;
> -    uint64_t backend_features;
>  
>      /**
>       * @protocol_features: is the vhost-user only feature set by
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..0aae77340d 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -85,8 +85,6 @@
>  #
>  # @acked-features: vhost_dev acked_features
>  #
> -# @backend-features: vhost_dev backend_features
> -#
>  # @protocol-features: vhost_dev protocol_features
>  #
>  # @max-queues: vhost_dev max_queues
> @@ -106,7 +104,6 @@
>              'vq-index': 'int',
>              'features': 'VirtioDeviceFeatures',
>              'acked-features': 'VirtioDeviceFeatures',
> -            'backend-features': 'VirtioDeviceFeatures',
>              'protocol-features': 'VhostDeviceProtocols',
>              'max-queues': 'uint64',
>              'backend-cap': 'uint64',

Incompatible change.  We can do this because it's only visible in the
return value of x-query-virtio-status, which is unstable.  Recommend to
note this in the commit message.

Acked-by: Markus Armbruster <armbru@redhat.com>


