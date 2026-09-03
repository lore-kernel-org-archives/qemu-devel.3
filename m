Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE31C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Zh-0006SZ-CI; Thu, 03 Sep 2026 02:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x20Zf-0006On-QG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 02:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x20Ze-0007sX-0r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 02:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788415520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XNAlIZONo9Veshj1Ood70durc7fmRGGI7FM3Iujq90g=;
 b=U+0A/E4u0PygyjOEdkuyr5t9W5JSOl7unyhVO+I6ycNzUyZx+JrAiFfVQ9xTz0TCCU0ooo
 JqMo6LERIKHIRlmkJGABpmz3CdLMxx5lJudRRfDd1cmJrK7E1mMZ2qXHJRvRJ+CsoZHt4M
 aje+JEhIGO2nvM0VMCWJrtK8mugkVOo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-zd1sCxlBO_mh19sfxhW_Bw-1; Thu,
 03 Sep 2026 02:05:18 -0400
X-MC-Unique: zd1sCxlBO_mh19sfxhW_Bw-1
X-Mimecast-MFC-AGG-ID: zd1sCxlBO_mh19sfxhW_Bw_1788415517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADD831956080; Thu,  3 Sep 2026 06:05:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FA318005BA; Thu,  3 Sep 2026 06:05:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B20BD21E6837; Thu, 03 Sep 2026 08:05:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,  qemu-devel <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  'Daniel P . =?utf-8?Q?Berrang=C3=A9'?=
 <berrange@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
In-Reply-To: <20260902193518.GB787498@fedora> (Stefan Hajnoczi's message of
 "Wed, 2 Sep 2026 15:35:18 -0400")
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <20260902193518.GB787498@fedora>
Date: Thu, 03 Sep 2026 08:05:14 +0200
Message-ID: <87ik4mzx7p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Sep 01, 2026 at 12:00:27AM +0800, Zhang Chen wrote:
>> Monitors that require an IOThread share the internal mon_iothread.
>> Account for each monitor explicitly in IOThread holder tracking, using
>> the monitor's canonical QOM path to distinguish holders.
>> 
>> Acquire the shared monitor IOThread AioContext once, using the monitor
>> QOM path as the holder, and reuse the stored context for later
>> operations.
>> 
>> Release the holder from the Monitor ObjectClass::unparent callback,
>> while the canonical QOM path is still available. This covers every
>> object_unparent() path and avoids duplicating the cleanup in
>> monitor_cleanup() and monitor_qmp_prepare_delete().
>> 
>> The internal mon_iothread remains hidden from query-iothreads, as before.
>> Management applications therefore cannot use it to determine which
>> monitors are using the IOThread. Nevertheless, track the monitor
>> holders so that they follow the same explicit holder and
>> IOThread reference lifecycle as other AioContext users.
>> 
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>  monitor/monitor-internal.h |  3 +++
>>  monitor/monitor.c          | 33 ++++++++++++++++++++++++++++-----
>>  monitor/qmp.c              |  5 +++--
>>  3 files changed, 34 insertions(+), 7 deletions(-)
>> 
>> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
>> index e0a124a317..74ea15c85f 100644
>> --- a/monitor/monitor-internal.h
>> +++ b/monitor/monitor-internal.h
>> @@ -154,6 +154,9 @@ struct Monitor {
>>      guint out_watch;
>>      int mux_out;
>>      int reset_seen;
>> +
>> +    /* iothread context */
>> +    AioContext *ctx;
>>  };
>>  
>>  struct MonitorHMPClass {
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index 6af09f2f6e..9e3b639eff 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -81,6 +81,22 @@ int monitor_device_index;
>>  OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
>>                              { TYPE_USER_CREATABLE }, {});
>>  
>> +static void monitor_unparent(Object *obj)
>> +{
>> +    Monitor *mon = MONITOR(obj);
>> +
>> +    if (mon->ctx && monitor_requires_iothread(mon)) {
>> +        g_autofree char *path = object_get_canonical_path(obj);
>> +        const IOThreadHolder io_holder = {
>> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
>> +            .u.qom_object.qom_path = path,
>> +        };
>> +
>> +        iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
>> +        mon->ctx = NULL;
>
> mon->accept_input_bh still exits and uses the AioContext at this point
> (it is freed in monitor_finalize()). Strictly speaking, this violates
> the idea of not using the AioContext anymore after calling
> iothread_unref_and_put_aio_context().
>
> This could be a source of bugs, but mon->accept_input_bh won't be
> scheduled anymore in this code path, so I think we can live with this.

Worth a comment?

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


