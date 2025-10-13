Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B52CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8DgY-0001JN-6V; Mon, 13 Oct 2025 04:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8DgW-0001IS-HN
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8DgT-0004T3-Lw
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760343208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=no34FeYhXf/6xkzuRuP6thTG+YZxNbEpE7tsG1/8f1k=;
 b=g1Pya8fKm7NiSN1T6twqe/ftoeD2g68De0Cii16B6S8IBpxPTAUNHyHWWsgCsUSWLBju2o
 HR8k9jsR9uOUmPzG2Oxwl8mhVV9tFmFXa42+ucrqSp2VEJg6yKmX8BB5JM3BmFZWBigE0L
 lfp0d/C2+UYB5v70VLTcYW2VI9uISQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-MByj-ftZNfaiQkkyrgiikw-1; Mon,
 13 Oct 2025 04:13:22 -0400
X-MC-Unique: MByj-ftZNfaiQkkyrgiikw-1
X-Mimecast-MFC-AGG-ID: MByj-ftZNfaiQkkyrgiikw_1760343201
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E108180057A; Mon, 13 Oct 2025 08:13:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 657161954102; Mon, 13 Oct 2025 08:13:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6E7821E6A27; Mon, 13 Oct 2025 10:13:16 +0200 (CEST)
Resent-To: raphael@enfabrica.net, fam@euphon.net,
 raphael.s.norwitz@gmail.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, d-tatianin@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 13 Oct 2025 10:13:16 +0200
Resent-Message-ID: <87ms5v8bj7.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  sgarzare@redhat.com,  raphael@enfabrica.net,
 qemu-devel@nongnu.org,  raphael.s.norwitz@gmail.com,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru,
 qemu-stable@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org (open list:Block layer core)
Subject: Re: [PATCH v2 02/23] vhost: drop backend_features field
In-Reply-To: <20251011232404.561024-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sun, 12 Oct 2025 02:23:41 +0300")
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-3-vsementsov@yandex-team.ru>
Date: Mon, 13 Oct 2025 06:42:10 +0200
Message-ID: <87plar9zvh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> This field is mostly unused and sometimes confusing (we even have
> a TODO-like comment to drop it). Let's finally do.
>
> The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
> and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
> vhost-user-net). But we can simply recalculate these two flags in place
> from hdev->features, and from net-client for VHOST_NET_F_VIRTIO_NET_HDR.
>
> Note: removing field from x-query-virtio-status result is incompatible
> change. We can do it because the command is unstable.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

You improved the commit message like I suggested, but lost my
Acked-by: Markus Armbruster <armbru@redhat.com>
:)

[...]

> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 1ee639dd7e..3e69e47833 100644
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
>       */

I guess this is the TODO-like comment mentioned in the commit message.

>      VIRTIO_DECLARE_FEATURES(features);
>      VIRTIO_DECLARE_FEATURES(acked_features);
> -    VIRTIO_DECLARE_FEATURES(backend_features);
>  
>      /**
>       * @protocol_features: is the vhost-user only feature set by
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 05295ab665..b995a5bb6d 100644
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


