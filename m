Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BE6C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x79Nh-0007QU-VN; Thu, 17 Sep 2026 06:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x79Nf-0007Mp-JT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 06:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x79Ne-0007ZI-81
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789641013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuTnlwpJkb0jyqTg1Hci9D8vdGLyHOD/ft+tMC2XDMk=;
 b=Cr6rce0v33EPEp9l805tM9uH2KKRttxeCt8qLn5o/6IchdKer9rvQXV0W3Uj8rZpw6eOKA
 HetwN6aCMNu2jXr5s1DmxykNGgrbhVP+rAUy+AZN6OwehppF8aSZIIoqlgiorWmP14Zopj
 lepuhEO0uGABQJImv1qKis8HTFd9fNQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-olL65rsONrKnvU9cZEdFNw-1; Thu,
 17 Sep 2026 06:30:05 -0400
X-MC-Unique: olL65rsONrKnvU9cZEdFNw-1
X-Mimecast-MFC-AGG-ID: olL65rsONrKnvU9cZEdFNw_1789641004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9ED8195F15E; Thu, 17 Sep 2026 10:30:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.151])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6726D19AC044; Thu, 17 Sep 2026 10:30:03 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Nariman Sayed <narimansayed28@gmail.com>
Cc: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 1/3] net/tap: add tap_fd_get_mtu() to query host tap MTU
Date: Thu, 17 Sep 2026 12:28:49 +0200
Message-ID: <20260917102921.210023-3-eperezma@redhat.com>
In-Reply-To: <20260816043451.2547-2-narimansayed28@gmail.com>
References: <20260816043451.2547-2-narimansayed28@gmail.com>
 <20260917102921.210023-2-eperezma@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Eugenio Perez Martin <eperezma@redhat.com>


Good feature! I'm sorry, all of the series fell through the cracks.

On Sun, 16 Aug 2026 at 07:34:49 +0300, Nariman Sayed wrote:
> +    if (n->net_conf.mtu_from_tap) {
> +        NetClientState *tap_peer = n->nic_conf.peers.ncs[0];
> +        if (tap_peer && tap_peer->info->type == NET_CLIENT_DRIVER_TAP) {
> +            int mtu = tap_get_mtu(tap_peer);
> +            if (mtu > 0) {
> +                n->net_conf.mtu = mtu;
> +                n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> +            }
> +        }
> +    }

The series looks good, but this part should not check for the backend type.
Instead, rename the callback as get_mtu and call peer->get_mtu, so if we add
the feature to other backends like vhost-user or vhost-vdpa this part of the
code does not need to be modified.

Good addition by the way :).

Thanks!


