Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1463AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9wo-0001gG-MJ; Tue, 21 Jul 2026 08:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm9wn-0001g4-BU
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm9wl-0000vI-Pu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784638302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfGjVxj0zYeYIgwOkcaWVwMbY7bT3t0NnYdpAGK+liA=;
 b=HT3WNQVJicLCh10nPIcb/fqC90cj3xt3UOq7VuDmR6hfHo8G8/htF2JSpQF/87PEcUJq59
 UXzoZHmJoN0Ehv/S4jalrdhTAipMn4ldhPFa+lF97v3ITmeO5Iks762fHDeAXWJSC3Cb5v
 qxpUWcnzp7SIMVRRxlZ+iFIiP7AK2rM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Ns7WOR6QMWinDuVdH2xDkQ-1; Tue,
 21 Jul 2026 08:51:41 -0400
X-MC-Unique: Ns7WOR6QMWinDuVdH2xDkQ-1
X-Mimecast-MFC-AGG-ID: Ns7WOR6QMWinDuVdH2xDkQ_1784638300
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C78F21964CE2; Tue, 21 Jul 2026 12:51:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB6D1955F74; Tue, 21 Jul 2026 12:51:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8858021E6920; Tue, 21 Jul 2026 14:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RESEND PATCH V10 13/15] monitor/hmp: Add holders support for
 hmp_info_iothreads
In-Reply-To: <20260716172108.87700-14-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 17 Jul 2026 01:20:54 +0800")
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-14-zhangckid@gmail.com>
Date: Tue, 21 Jul 2026 14:51:36 +0200
Message-ID: <87se5co693.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Exposed the iothread holders via the Human Monitor Interface (HMP)
> command 'info iothreads' to assist with manual debugging and
> performance tuning.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index e9fb8d827a..cd2d9c1d59 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -240,11 +240,33 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
>      IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
>      IOThreadInfoList *info;
>      IOThreadInfo *value;
> +    IOThreadHolderList *h;
>  
>      for (info = info_list; info; info = info->next) {
>          value = info->value;
>          monitor_printf(mon, "%s:\n", value->id);
>          monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
> +        monitor_printf(mon, "  holders=");

This is unconditional.

> +        if (value->holders) {
> +            for (h = value->holders; h; h = h->next) {
> +                IOThreadHolder *holder = h->value;
> +
> +                switch (holder->type) {
> +                case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> +                    monitor_printf(mon, "[block-export: %s]",
> +                                   holder->u.block_export.export_name);
> +                    break;
> +                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +                    monitor_printf(mon, "[qom-path: %s]",
> +                                   holder->u.qom_object.qom_path);
> +                    break;
> +                default:
> +                    monitor_printf(mon, "[unknown]");
> +                    break;
> +                }
> +            }
> +            monitor_printf(mon, "\n");

This isn't.  Results in messed-up output when there are no holders:

    $ qemu-system-x86_64 -S -display none -monitor stdio -object iothread,id=iot0
    QEMU 11.0.90 monitor - type 'help' for more information
    (qemu) info iothreads 
    iot0:
      thread_id=1035908
      holders=  poll-max-ns=32768
      poll-grow=2
      poll-shrink=2
      poll-weight=3
      aio-max-batch=0

There's no need for a conditional here, the loop does nothing just fine
when the list is empty.

> +        }
>          monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
>          monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
>          monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);


