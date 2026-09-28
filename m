Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE72C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB5D-0004W0-BX; Mon, 28 Sep 2026 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBB4o-0004FG-ES
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBB4l-0004tr-DD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpacEvx24w/wPUnNZdIqPqC0z5kn3YcTX7KjkQ6RE+U=;
 b=Oi+IgxcP7aok1H7erLmTIkKK+B6Jh4p8dgffyUSBajxDYgPZcT0TRw2x9/QmL2HUZVQrMe
 +9Zq3UNMBZlM+esIoD1yRPA99a4sINNlhG87+ClkJScH72z+BAr4PcUoviSNxNNMGwwFfA
 hFFO5UQtSpEhqSvhZU3EHINa8JAuIsI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Slu5LfRwPW27lV2cJu98eg-1; Mon,
 28 Sep 2026 09:07:19 -0400
X-MC-Unique: Slu5LfRwPW27lV2cJu98eg-1
X-Mimecast-MFC-AGG-ID: Slu5LfRwPW27lV2cJu98eg_1790600838
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DF9195DE0D; Mon, 28 Sep 2026 13:07:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E08EE180035F; Mon, 28 Sep 2026 13:07:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F9F121E6A04; Mon, 28 Sep 2026 15:07:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  eblake@redhat.com,  th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com,  berrange@redhat.com,  pbonzini@redhat.com,
 zhao1.liu@intel.com,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org,
 Nikolay Kuratov <kniv@yandex-team.ru>
Subject: Re: [PATCH 3/3] qapi/monitor: Handle missing vhost-user protocol
 features
In-Reply-To: <20260922213210.1429435-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 23 Sep 2026 00:32:10 +0300")
References: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
 <20260922213210.1429435-4-vsementsov@yandex-team.ru>
Date: Mon, 28 Sep 2026 15:07:13 +0200
Message-ID: <875wzp5xtq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Commit f9a8f5812607 moved protocol_features to the vhost-user backend.
> As a result, VhostStatus.protocol_features is only populated for
> vhost-user devices.
>
> For an active kernel vhost device, HMP info virtio-status and QMP
> x-query-virtio-status crashes now because of unset protocol-features.
>
> Make protocol-features optional in VhostStatus and skip dumping a
> missing object in HMP.
>
> For QMP we can change the x-query-virtio-status command semantics
> because it is unstable.

Suggest

  This is a compatibility break.  Okay, since VhostStatus is only used
  by x-query-virtio-status, which is unstable.

> Enable corresponding test, it works now.
>
> Fixes: f9a8f5812607 ("vhost: move protocol_features to vhost_user")
> Co-authored-by: Nikolay Kuratov <kniv@yandex-team.ru>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/virtio-hmp-cmds.c                   | 6 ++++--
>  qapi/virtio.json                              | 5 +++--
>  tests/functional/x86_64/test_virtio_status.py | 1 -
>  3 files changed, 7 insertions(+), 5 deletions(-)
>

The actual bug is in qmp_x_query_virtio_status(), which can leave
status->vhost_dev->protocol null:

           if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER) {
               vhost_user_qmp_status(hdev, status);
           }

A non-optional struct pointer must not be null.  I believe the visitor
detects this programming error and crashes.

An optional struct pointer may be null: it means "absent".  Making the
struct optional fixes the crash.

> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index e5da6f00699..5b08a06ec42 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -176,8 +176,10 @@ void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
>          hmp_virtio_dump_features(hmp, s->vhost_dev->features);
>          monitor_hmp_printf(hmp, "    Acked features:\n");
>          hmp_virtio_dump_features(hmp, s->vhost_dev->acked_features);
> -        monitor_hmp_printf(hmp, "    Protocol features:\n");
> -        hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
> +        if (s->vhost_dev->protocol_features) {
> +            monitor_hmp_printf(hmp, "    Protocol features:\n");
> +            hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
> +        }

This isn't the bug fix, it's the adjustment for optional, as you write
in the commit message.

>      }
>  
>      qapi_free_VirtioStatus(s);
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 1fc4e38a44d..f8e699a0e4e 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -85,7 +85,8 @@
>  #
>  # @acked-features: vhost_dev acked_features
>  #
> -# @protocol-features: vhost_dev protocol_features
> +# @protocol-features: vhost-user protocol features.  Present only for
> +#     vhost-user devices.
>  #
>  # @max-queues: vhost_dev max_queues
>  #
> @@ -104,7 +105,7 @@
>              'vq-index': 'int',
>              'features': 'VirtioDeviceFeatures',
>              'acked-features': 'VirtioDeviceFeatures',
> -            'protocol-features': 'VhostDeviceProtocols',
> +            '*protocol-features': 'VhostDeviceProtocols',
>              'max-queues': 'uint64',
>              'backend-cap': 'uint64',
>              'log-enabled': 'bool',
> diff --git a/tests/functional/x86_64/test_virtio_status.py b/tests/functional/x86_64/test_virtio_status.py
> index 1e72c713cc6..a88823004f8 100755
> --- a/tests/functional/x86_64/test_virtio_status.py
> +++ b/tests/functional/x86_64/test_virtio_status.py
> @@ -45,7 +45,6 @@ def check_commands(self, vm):
>          vm.cmd("x-query-virtio-status", path=self.VIRTIO_PATH)
>  
>      @skipIfMissingCommands("unshare")
> -    @skipIfMissingEnv("QEMU_FAILING_TESTS")
>      def test_vhost(self):
>          self.require_netdev("tap")
>          for device in ("/dev/net/tun", "/dev/vhost-net"):

Reviewed-by: Markus Armbruster <armbru@redhat.com>


