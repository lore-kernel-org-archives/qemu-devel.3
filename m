Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43782109022A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3DuV-0002Hl-AM; Thu, 19 Mar 2026 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3DuT-0002HG-PH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3DuR-0002EK-3S
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=flxRzih1QNbJVCICFpJ0NhKGm/gYzAXkFFLq51JzkTA=;
 b=e4SWmscaASDGtll4jWbQ2t6nQgy+RamCerg/B0ZzSERuhC0WnCNj5ndvqb5jtLQSwPaBMr
 WZS3BGaTx+SnFpBUUZIZQ7B8nk8ovo0k/dj6JksrCxQsM2O4dgnIZabFMfGrq6+JXJsFkP
 rjJK4+Nx1mjbduCfSUF0h5H16vg7D58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-kkF_hi7yMK-1xozDFDWbfA-1; Thu,
 19 Mar 2026 09:59:29 -0400
X-MC-Unique: kkF_hi7yMK-1xozDFDWbfA-1
X-Mimecast-MFC-AGG-ID: kkF_hi7yMK-1xozDFDWbfA_1773928768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F35B91944EAA; Thu, 19 Mar 2026 13:59:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D94AC1800361; Thu, 19 Mar 2026 13:59:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BA3321E6937; Thu, 19 Mar 2026 14:59:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] qmp: Check vhost protocol features for NULL prior to
 dumping
In-Reply-To: <20260319085050.1982608-1-kniv@yandex-team.ru> (Nikolay Kuratov's
 message of "Thu, 19 Mar 2026 11:50:50 +0300")
References: <20260319085050.1982608-1-kniv@yandex-team.ru>
Date: Thu, 19 Mar 2026 14:59:24 +0100
Message-ID: <871phfx6mb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Nikolay Kuratov <kniv@yandex-team.ru> writes:

> vhost_dev->protocol_features field can be legitimately set to NULL
> as apparently it's vhost-user only field. At least I was able to get
> NULL deref with a vhost-net VM.
>
> Without that check querying vhost-net device:
> info virtio-status /machine/peripheral-anon/device[0]/virtio-backend
> will lead to SIGSEGV.
>
> Fixes: 8a8287981d1169f534894d983ecfd3b70b71918b ("hmp: add virtio commands")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  hw/virtio/virtio-hmp-cmds.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 1daae482d3..b9980197ef 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -15,6 +15,9 @@
>  static void hmp_virtio_dump_protocols(Monitor *mon,
>                                        VhostDeviceProtocols *pcol)
>  {
> +    if (pcol == NULL) {
> +        return;
> +    }
>      strList *pcol_list = pcol->protocols;
>      while (pcol_list) {
>          monitor_printf(mon, "\t%s", pcol_list->value);

I fear this papers over the real bug.

Here's the only caller:

    void hmp_virtio_status(Monitor *mon, const QDict *qdict)
    {
        Error *err = NULL;
        const char *path = qdict_get_try_str(qdict, "path");
        VirtioStatus *s = qmp_x_query_virtio_status(path, &err);

        if (err != NULL) {

Aside: I'd prefer if (!s) here.

            hmp_handle_error(mon, err);
            return;
        }

        [...]

        if (s->vhost_dev) {
            [...]
            monitor_printf(mon, "    Protocol features:\n");
            hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);

We're passing VirtioStatus member @protocol-features.  It's not supposed
to be null, because ...

        }

        qapi_free_VirtioStatus(s);
    }

In qapi/virtio.json:

    { 'struct': 'VhostStatus',
      'data': { 'n-mem-sections': 'int',
                'n-tmp-sections': 'int',
                'nvqs': 'uint32',
                'vq-index': 'int',
                'features': 'VirtioDeviceFeatures',
                'acked-features': 'VirtioDeviceFeatures',
                'backend-features': 'VirtioDeviceFeatures',
                'protocol-features': 'VhostDeviceProtocols',

... member @protocol-features is *not* optional.

Since you obseved it to be null, whatever created s->vhost_dev must have
screwed up.

If s->vhost_dev->protocol-features needs to be null in certain
situations, you must declare it optional in the QAPI schema.

                'max-queues': 'uint64',
                'backend-cap': 'uint64',
                'log-enabled': 'bool',
                'log-size': 'uint64' } }


