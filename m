Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543ECC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnKY-0006g0-Dx; Fri, 02 Aug 2024 04:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZnKX-0006fM-B7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZnKV-0001yb-3r
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722586081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUxWxbCNTc08pTxUet5GncnWC9TsmJAKimAQAcSYDjk=;
 b=iYChSEfOpcY2n2jN6j0fBQHrN/EXy0dH2ElkTjwiCs2gg3vbzHfepyHJoo0bsl1ZTIMIcf
 L6ZIId/r3JL6RgrmtsWP4DaKL4bvDrX+/00E/qxnuFbR/8M71dZ4NAxxDpj9klY7sFTaBh
 +l7YVAtRg+1vWStgPZnd0JCWjImlM5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-emkUHM8fNLW2rkK7XvZWPw-1; Fri,
 02 Aug 2024 04:07:57 -0400
X-MC-Unique: emkUHM8fNLW2rkK7XvZWPw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D739195609F; Fri,  2 Aug 2024 08:07:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345F61955F6B; Fri,  2 Aug 2024 08:07:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 083DA21E6682; Fri,  2 Aug 2024 10:07:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  pkrempa@redhat.com,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] vl: use qmp_device_add() in
 qemu_create_cli_devices()
In-Reply-To: <20240801140552.1021693-3-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Thu, 1 Aug 2024 10:05:52 -0400")
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <20240801140552.1021693-3-stefanha@redhat.com>
Date: Fri, 02 Aug 2024 10:07:53 +0200
Message-ID: <871q3773fq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> qemu_create_cli_devices() should use qmp_device_add() to match the
> behavior of the QMP monitor. A comment explained that libvirt changes
> implementing strict CLI syntax were needed.
>
> Peter Krempa <pkrempa@redhat.com> has confirmed that modern libvirt uses
> the same JSON for -device (CLI) and device_add (QMP). Go ahead and use
> qmp_device_add().
>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  system/vl.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 9e8f16f155..0beb8bfb57 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2651,17 +2651,11 @@ static void qemu_create_cli_devices(void)
>      qemu_opts_foreach(qemu_find_opts("device"),
>                        device_init_func, NULL, &error_fatal);
>      QTAILQ_FOREACH(opt, &device_opts, next) {
> -        DeviceState *dev;
> +        QObject *ret_data = NULL;
> +
>          loc_push_restore(&opt->loc);
> -        /*
> -         * TODO Eventually we should call qmp_device_add() here to make sure it
> -         * behaves the same, but QMP still has to accept incorrectly typed
> -         * options until libvirt is fixed and we want to be strict on the CLI
> -         * from the start, so call qdev_device_add_from_qdict() directly for
> -         * now.
> -         */
> -        dev = qdev_device_add_from_qdict(opt->opts, true, &error_fatal);
> -        object_unref(OBJECT(dev));
> +        qmp_device_add(opt->opts, &ret_data, &error_fatal);
> +        assert(ret_data == NULL); /* error_fatal aborts */
>          loc_pop(&opt->loc);
>      }
>      rom_reset_order_override();

Reviewed-by: Markus Armbruster <armbru@redhat.com>


