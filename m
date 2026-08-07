Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E16C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKsi-0007F7-BL; Fri, 07 Aug 2026 09:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKsb-0007ES-Oc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKsa-0003gj-51
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786110295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOQPxqOZ9x3g9271tzA4WwcW64jjC3oHwdnYzV+wEL4=;
 b=UFeRjNQMu0nxHSFAkxq+yC4q151oFcWpu37T7eFlV5JQph4K3frNzklyQ17XmMgyyS3/YP
 lNdok6p+GSzeoadYF59fxz9joJGRHH15bXzwRc+QVClAms29+jJ+37ugJHpeeJrDnoLjLH
 XqnaGcAW3o9QWN+1sR8KV4vCsfhW52g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-9oXve-qKM_udHcDK_WhY6A-1; Fri,
 07 Aug 2026 09:44:52 -0400
X-MC-Unique: 9oXve-qKM_udHcDK_WhY6A-1
X-Mimecast-MFC-AGG-ID: 9oXve-qKM_udHcDK_WhY6A_1786110291
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FE7F195604C; Fri,  7 Aug 2026 13:44:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2524B1800346; Fri,  7 Aug 2026 13:44:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBCBA21E6920; Fri, 07 Aug 2026 15:44:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  'Daniel P . =?utf-8?Q?Berrang=C3=A9'?=
 <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V11 13/15] monitor/hmp: display IOThread holders
In-Reply-To: <20260806202531.243806-14-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 7 Aug 2026 04:25:22 +0800")
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-14-zhangckid@gmail.com>
Date: Fri, 07 Aug 2026 15:44:48 +0200
Message-ID: <87se4qniy7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Display holder information in info iothreads to aid manual debugging.
> Omit the holders line when an IOThread has no holders.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index e9fb8d827a..de37f83a72 100644
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
> +        if (value->holders) {
> +            monitor_printf(mon, "  holders=");
> +            for (h = value->holders; h; h = h->next) {
> +                IOThreadHolder *holder = h->value;
> +
> +                switch (holder->type) {
> +                case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> +                    monitor_printf(mon, "[block-export: %s]",
> +                                   holder->u.block_export.export_id);
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
> +        }

This prints nothing when we have no holders.

If you delete the if (value->holders) guard, it prints a line

    holders=

Matter of taste.  Anyone got a preference?

>          monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
>          monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
>          monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);


