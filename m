Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7A5C5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUe0-0007vJ-1A; Mon, 10 Aug 2026 14:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUdy-0007ux-H0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUdw-00045n-NI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386155;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32zK8qytSbf1umQ18espdH7GfaZ2QCsQUDlYJYBbA3c=;
 b=NaQTvAaAn/I1GPi3XaKMXt4XPvmIRBxJmdoo7YfDP1Xq8sSL5dCvobF+xCxPzWdmSTPoFg
 ggfscLUp4MQTXqq6gqUHUmPDepbM3ASHETbxnYYdhDPKNC6gpS2ciXP9bjih60AApRYq/7
 ywpFQ7jsh+z0yJOXmr4DnkWNkT63zeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-8IbBnLCdNcWYc1Kp-mYjGQ-1; Mon,
 10 Aug 2026 14:22:27 -0400
X-MC-Unique: 8IbBnLCdNcWYc1Kp-mYjGQ-1
X-Mimecast-MFC-AGG-ID: 8IbBnLCdNcWYc1Kp-mYjGQ_1786386146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9335A195608A; Mon, 10 Aug 2026 18:22:26 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BDD818005BB; Mon, 10 Aug 2026 18:22:24 +0000 (UTC)
Date: Mon, 10 Aug 2026 19:22:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 23/39] RFC: qtest: add qemu-io command to the qtest
 protocol
Message-ID: <anoW3hSjOmdo5t8c@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-23-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-23-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 26, 2026 at 01:19:24AM +0400, Marc-André Lureau wrote:
> Add a "qemu-io" command to the qtest protocol so that tests can issue
> block layer I/O commands without going through the HMP monitor's
> "human-monitor-command" QMP, or use QMP at all.
> 
> Unfortunately, many tests will prefer to use QMP as they also monitor
> and log other events. It's easier if it is pipelined in the same stream.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/libqtest.h | 11 +++++++++++
>  system/qtest.c         | 14 ++++++++++++++
>  tests/qtest/libqtest.c | 14 ++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 45217fb8dc0..58491ca53ab 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -424,6 +424,17 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
>  char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
>      G_GNUC_PRINTF(2, 0);
>  
> +/**
> + * qtest_qemu_io:
> + * @s: #QTestState instance to operate on.
> + * @device: block device node-name or BlockBackend name.
> + * @fmt: qemu-io command to send, formats arguments like sprintf().
> + *
> + * Send a qemu-io command via the qtest protocol.
> + */
> +void qtest_qemu_io(QTestState *s, const char *device,
> +                   const char *fmt, ...) G_GNUC_PRINTF(3, 4);
> +
>  void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
>  
>  /**
> diff --git a/system/qtest.c b/system/qtest.c
> index fd37bcbfaab..f7f2636854b 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -33,6 +33,7 @@
>  #include "qom/object_interfaces.h"
>  #include "qom/qom-qobject.h"
>  #include "qobject/qobject.h"
> +#include "qapi-commands-block.h"
>  
>  #define MAX_IRQ 256
>  
> @@ -800,6 +801,19 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>          }
>          g_slist_free(list);
>          qtest_send(chr, "OK\n");
> +    } else if (strcmp(words[0], "qemu-io") == 0) {
> +        const char *io_dev;
> +        g_autofree char *io_cmd = NULL;
> +        Error *err = NULL;
> +
> +        g_assert(words[1] && words[2]);
> +        io_dev = words[1];
> +        io_cmd = g_strjoinv(" ", &words[2]);
> +
> +        qmp_x_qemu_io(io_dev, NULL, io_cmd, &err);

This function isn't defined until patch 25 AFAICT, so need to re-order.

> +        qtest_sendf(chr, err ? "FAIL %s\n" : "OK\n",
> +                    err ? error_get_pretty(err) : NULL);
> +        error_free(err);
>      } else if (process_command_cb && process_command_cb(chr, words)) {
>          /* Command got consumed by the callback handler */
>      } else {
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 4e22c66b754..eccffd3a0c2 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1012,6 +1012,20 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
>      return ret;
>  }
>  
> +void qtest_qemu_io(QTestState *s, const char *device,
> +                   const char *fmt, ...)
> +{
> +    va_list ap;
> +    g_autofree char *cmd = NULL;
> +
> +    va_start(ap, fmt);
> +    cmd = g_strdup_vprintf(fmt, ap);
> +    va_end(ap);
> +
> +    qtest_sendf(s, "qemu-io %s %s\n", device, cmd);
> +    qtest_rsp(s);
> +}
> +
>  const char *qtest_get_arch(void)
>  {
>      /*
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


