Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52836CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwc7-0007tQ-QQ; Mon, 18 May 2026 07:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwc3-0007re-5x
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwc1-0001jt-Lf
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779105500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpK5yqsoqj9UlaBWUeiau9gtnonHGehfPSikX7mRQ6o=;
 b=ibVX2YGR8GOOXqOMnDEmxDOiclfarbyuuRtMWwLtlUfkA/4RUsW/NMQMCnn8fLEzmrMRTL
 +MsZpQIVmg2L3KJyIEn8BaiLTtTlqMDuxb34fszAv+GxGRal4H/BWc8tQbUATmLIBvR85L
 iPW+zEBdMBZajg9LIpJ4wQydTbfEwik=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-X0aRewwUOf2zTVIUHgI_mg-1; Mon,
 18 May 2026 07:58:19 -0400
X-MC-Unique: X0aRewwUOf2zTVIUHgI_mg-1
X-Mimecast-MFC-AGG-ID: X0aRewwUOf2zTVIUHgI_mg_1779105498
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDF5D18005B9; Mon, 18 May 2026 11:58:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80A4130001A2; Mon, 18 May 2026 11:58:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E8B621E6A01; Mon, 18 May 2026 13:58:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,  qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,  Eric Blake
 <eblake@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V7 02/14] iothread: introduce iothread_ref/unref to
 track attached devices
In-Reply-To: <20260511181425.GD536999@fedora> (Stefan Hajnoczi's message of
 "Mon, 11 May 2026 14:14:25 -0400")
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-3-zhangckid@gmail.com>
 <20260511181425.GD536999@fedora>
Date: Mon, 18 May 2026 13:58:15 +0200
Message-ID: <87y0hhsze0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Mon, May 11, 2026 at 10:04:04PM +0800, Zhang Chen wrote:
>> Currently, IOThreads do not maintain a record of which devices are
>> associated with them. This makes it difficult to monitor the
>> workload distribution of IOThreads, especially in complex
>> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>> 
>> This patch introduces a reference counting and tracking mechanism
>> within the IOThread object:
>> 
>> - iothread_ref(): Prepends the device's QOM path to a list.
>> - iothread_unref(): Searches for the device path using a custom
>>   string comparison (g_strcmp0), releases the associated memory
>>   upon a successful match.
>> - holders: A GList storing the QOM paths of attached devices
>>   for runtime introspection.
>> 
>> A later commit will add QMP commands to let management applications
>> query the attachment status of IOThreads.
>> 
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>  include/system/iothread.h |  5 +++
>>  iothread.c                | 67 +++++++++++++++++++++++++++++++++++++++
>>  qapi/misc.json            | 48 ++++++++++++++++++++++++++++
>>  3 files changed, 120 insertions(+)
>> 
>> diff --git a/include/system/iothread.h b/include/system/iothread.h
>> index a1ef7696cb..2871b06edc 100644
>> --- a/include/system/iothread.h
>> +++ b/include/system/iothread.h
>> @@ -50,6 +50,11 @@ struct IOThread {
>>      bool stopping;              /* has iothread_stop() been called? */
>>      bool running;               /* should iothread_run() continue? */
>>      int thread_id;
>> +    /*
>> +     * The list elements are of type IoThreadHolder, which can
>> +     * represent either a QOM path or a block node name.
>> +     */
>> +    GList *holders;
>>  
>>      /* AioContext poll parameters */
>>      int64_t poll_max_ns;
>> diff --git a/iothread.c b/iothread.c
>> index 3558535b40..b805e4f97d 100644
>> --- a/iothread.c
>> +++ b/iothread.c
>> @@ -25,6 +25,66 @@
>>  #include "qemu/rcu.h"
>>  #include "qemu/main-loop.h"
>>  
>> +/*
>> + * Add the @holder path to the iothread's tracking list.
>> + * The @holder is a QOM path if it starts with '/', else a block node name.
>> + */
>
> It would be cleaner to use IoThreadHolder in the iothread_ref() and
> iothread_unref() APIs instead of a string:
>
>   static void iothread_ref(IOThread *iothread, const IoThreadHolder *holder);
>   static void iothread_unref(IOThread *iothread, const IoThreadHolder *holder);
>
> That way the caller already uses IO_THREAD_HOLDER_KIND_QOM_OBJECT or
> IO_THREAD_HOLDER_KIND_BLOCK_NODE to clearly distinguish QOM paths from
> block node names. No string parsing is necessary.

Exactly.

[...]


