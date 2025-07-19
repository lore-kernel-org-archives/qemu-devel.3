Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C3C83F34
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 07:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ud1qQ-0005ad-9p; Sat, 19 Jul 2025 03:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ud1W2-0002wG-0P
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 02:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ud1Vy-0006WS-SD
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 02:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752908264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJ3hMKEHfHFZ61T2qwp53VgFAJFPxiLsM47g75uzwzs=;
 b=a4xQuzNtSn+nFPHy7bXci2pqQ7W3Apdrj7EkWde+BOcjtR3cJi39ei7uiqbYPvxFdtvtgr
 ZsfzQfvLmUmo8XzzghVOzNURDKAgw3QLt5GvXg7cY2R7VX6x5HQaLiWT5qvqEybWQsg9BN
 On6JCAszcMZW6uoava1WSzjWZh+tkzY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-1Xp-RCJuNDCh8Cmq_nckHQ-1; Sat,
 19 Jul 2025 02:57:42 -0400
X-MC-Unique: 1Xp-RCJuNDCh8Cmq_nckHQ-1
X-Mimecast-MFC-AGG-ID: 1Xp-RCJuNDCh8Cmq_nckHQ_1752908261
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C3261800447; Sat, 19 Jul 2025 06:57:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3655D196664F; Sat, 19 Jul 2025 06:57:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5665E21E6A27; Sat, 19 Jul 2025 08:57:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Dmitry
 Fleytman <dmitry.fleytman@gmail.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Jason Wang <jasowang@redhat.com>,  Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Cornelia
 Huck <cohuck@redhat.com>,  Luigi Rizzo <lrizzo@google.com>,  Giuseppe
 Lettieri <g.lettieri@iet.unipi.it>,  Vincenzo Maffione
 <v.maffione@gmail.com>,  Eric Blake <eblake@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
In-Reply-To: <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
 (Paolo Abeni's message of "Fri, 18 Jul 2025 10:52:34 +0200")
References: <cover.1752828082.git.pabeni@redhat.com>
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
Date: Sat, 19 Jul 2025 08:57:34 +0200
Message-ID: <87seiswtup.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Abeni <pabeni@redhat.com> writes:

> Extend the VirtioDeviceFeatures struct with an additional u64
> to track unknown features in the 64-127 bit range and decode
> the full virtio features spaces for vhost and virtio devices.
>
> Also add entries for the soon-to-be-supported virtio net GSO over
> UDP features.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[...]

> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 3b6377cf0d..03c6163cf4 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c

[...]

> @@ -680,9 +715,10 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>          g_assert_not_reached();
>      }
>  
> -    features->has_unknown_dev_features = bitmap != 0;
> +    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
>      if (features->has_unknown_dev_features) {
> -        features->unknown_dev_features = bitmap;
> +        features->unknown_dev_features = bitmap[0];
> +        features->unknown_dev_features2 = bitmap[1];
>      }

Why not assign unconditionally?

>  
>      return features;

[...]

> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..f2e2dd6e97 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -490,14 +490,18 @@
>  #     unique features)
>  #
>  # @unknown-dev-features: Virtio device features bitmap that have not
> -#     been decoded
> +#     been decoded (bits 0-63)
> +#
> +# @unknown-dev-features2: Virtio device features bitmap that have not
> +#     been decoded (bits 64-127)
>  #
>  # Since: 7.2
>  ##
>  { 'struct': 'VirtioDeviceFeatures',
>    'data': { 'transports': [ 'str' ],
>              '*dev-features': [ 'str' ],
> -            '*unknown-dev-features': 'uint64' } }
> +            '*unknown-dev-features': 'uint64',
> +            '*unknown-dev-features2': 'uint64' } }
>  
>  ##
>  # @VirtQueueStatus:

I wish we could simply widen @unknown-dev-features, but we don't have
uint128, and adding it would risk breaking QMP clients.  64 bit integers
are already troublesome in JSON.

Does the example in x-query-virtio-status's doc comment need an update?


