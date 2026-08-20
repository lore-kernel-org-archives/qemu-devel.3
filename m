Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC72AC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxyD-0004iF-DB; Thu, 20 Aug 2026 04:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwxyB-0004hM-O7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 04:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwxy9-0003Jh-O4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 04:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787213867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GZkCWkJjYtaXDgztuqt6I73F66TW18sXpLStFtvAJjo=;
 b=ZZKjoqAoBhctmnHrzlkr7KrkgRD1YMcXetrQwnrgZtRKxClfrNLU+ycv7SDv4xdpRLg/5d
 otCxUmW0X9uGCe/N+5/M+bnyOkcfBYkWZKNJdj+KC2troRj7NFLQt1I4mNcabo559ZYI+U
 WYaori51v9sXRMEkYl7nKm2gER/6pok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-82tYoyvVNf-JMEY_bBcSHg-1; Thu,
 20 Aug 2026 04:17:43 -0400
X-MC-Unique: 82tYoyvVNf-JMEY_bBcSHg-1
X-Mimecast-MFC-AGG-ID: 82tYoyvVNf-JMEY_bBcSHg_1787213863
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D903B19560AA; Thu, 20 Aug 2026 08:17:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6013219560AB; Thu, 20 Aug 2026 08:17:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E852121E6920; Thu, 20 Aug 2026 10:17:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V12 13/15] monitor/hmp: display IOThread holders
In-Reply-To: <20260814174830.1691540-14-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 15 Aug 2026 01:48:27 +0800")
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-14-zhangckid@gmail.com>
Date: Thu, 20 Aug 2026 10:17:39 +0200
Message-ID: <87y0e12okc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Display holder information in info iothreads to aid manual debugging.
> Omit the holders line when an IOThread has no holders.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/hmp-cmds.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index e9fb8d827a..41a813e79f 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -240,11 +240,32 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
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
> +        for (h = value->holders; h; h = h->next) {
> +            IOThreadHolder *holder = h->value;
> +
> +            switch (holder->type) {
> +            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> +                monitor_printf(mon, "[block-export: %s]",
> +                               holder->u.block_export.export_id);
> +                break;
> +            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +                monitor_printf(mon, "[qom-path: %s]",
> +                               holder->u.qom_object.qom_path);
> +                break;
> +            default:
> +                monitor_printf(mon, "[unknown]");
> +                break;

This is unreachable.  Please use

               default:
                   g_assert_not_reached();

to make it obvious.

> +            }
> +        }
> +        monitor_printf(mon, "\n");
> +
>          monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
>          monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
>          monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);

Quick test:

    $ qemu-system-x86_64 -S -nodefaults -display none -chardev socket,id=chr-qmp,path=test-qmp,server=on,wait=off -object monitor-qmp,id=qmp,chardev=chr-qmp -monitor stdio
    QEMU 11.1.50 monitor - type 'help' for more information
    (qemu) info iothreads 
    (qemu) q

Hmm, no output?  The QMP monitor should be holding the monitor I/O
thread.  To confirm that, I made monitor_complete() print things (patch
appended), and got

    ### monitor qmp holding iothread mon_iothread
    ### monitor compat_monitor0 without iothread

What's going on here?


diff --git a/monitor/monitor.c b/monitor/monitor.c
index 26e7ef4d35..57672dbe0e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -751,8 +751,13 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
         };
 
         mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
+        printf("### monitor %s holding iothread %s\n",
+               object_get_canonical_path_component(OBJECT(mon)),
+               iothread_get_id(mon_iothread));
     } else {
         mon->ctx = qemu_get_aio_context();
+        printf("### monitor %s without iothread\n",
+               object_get_canonical_path_component(OBJECT(mon)));
     }
     mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }


