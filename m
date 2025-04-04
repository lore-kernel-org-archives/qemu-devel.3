Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A2C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0hnr-0002iK-Jf; Fri, 04 Apr 2025 10:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0hnX-0002hd-6X
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0hnV-0006y0-8A
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743776007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4MyFWXG2YhlUbhuaOS+mRD1plPnbKXuE0bl8UMumNc=;
 b=K+cptxQQe7IusmMC/VUdXABT8Xr+buDy1MS+DsLfTMNfnGzWAvfrrM1iLDZ+8yH0RQgVqn
 yZ9U1fVF7C0tcIqSHB8BBkoCJZgHyWyYZbOufxU34ITATqnkAYX+RdrkClC4sao7HHpq29
 k8z9wnZagyX8MBP9FFqCO8JPNGXdaQw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-A0TW5M5bOXegusG_rsV3kg-1; Fri,
 04 Apr 2025 10:13:22 -0400
X-MC-Unique: A0TW5M5bOXegusG_rsV3kg-1
X-Mimecast-MFC-AGG-ID: A0TW5M5bOXegusG_rsV3kg_1743776001
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7EFB1954B39; Fri,  4 Apr 2025 14:13:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08866180176A; Fri,  4 Apr 2025 14:13:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B52EB21E66C7; Fri, 04 Apr 2025 16:13:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com,  eblake@redhat.com,  jsnow@redhat.com,
 devel@lists.libvirt.org,  pkrempa@redhat.com,  michael.roth@amd.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
In-Reply-To: <638e4d21-6440-47e7-9ad5-ac44b0c03cb0@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 4 Apr 2025 14:33:37 +0300")
References: <20250401155730.103718-1-vsementsov@yandex-team.ru>
 <8734eosb14.fsf@pond.sub.org>
 <638e4d21-6440-47e7-9ad5-ac44b0c03cb0@yandex-team.ru>
Date: Fri, 04 Apr 2025 16:13:15 +0200
Message-ID: <87ecy8nhfo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 04.04.25 09:20, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

[...]

>>> +
>>> +``block-job-finalize`` (since 10.1)
>>> +''''''''''''''''''''''''''''''''''
>>> +
>>> +Use ``job-finalize`` instead.
>>> +
>> 
>> block-job-finalize's doc comment:
>> 
>>      # Once a job that has manual=true reaches the pending state, it can be
>>      # instructed to finalize any graph changes and do any necessary
>>      # cleanup via this command.  [...]
>> 
>> There is no member @manual anywhere in the QAPI schema.  I figure this
>> should be @auto-finalize.
>> 
>> job-finalize's doc comment:
>> 
>>      # Instructs all jobs in a transaction (or a single job if it is not
>>      # part of any transaction) to finalize any graph changes and do any
>>      # necessary cleanup.  This command requires that all involved jobs are
>>      # in the PENDING state.
>> 
>> Nothing on @auto-finalize.
>> 
>> @auto-finalize defaults to true for jobs that support controlling it.
>> These are exactly the ones that support @auto-dismiss.
>> 
>> I figure @auto-dismiss is always false for the other jobs, but that
>> doesn't seem to be documented anywhere.
>> 
>> The only other bits related to @auto-dismiss and @auto-finalize seem to
>> be two states in JobStatus:
>> 
>>      # @pending: The job has finished its work, but has finalization steps
>>      #     that it needs to make prior to completing.  These changes will
>>      #     require manual intervention via @job-finalize if auto-finalize
>>      #     was set to false.  These pending changes may still fail.
>>      [...]
>>      # @concluded: The job has finished all work.  If auto-dismiss was set
>>      #     to false, the job will remain in the query list until it is
>>      #     dismissed via @job-dismiss.
>> 
>> 
>> Is it possible to observe @concluded via QMP when @auto-dismiss is on?
>
> Seems not.
>
>> 
>> What about @pending?
>
> Hmm probably, if we have a transaction of several jobs (actually only backups may be joined to transactions), where some have auto-finalize and some not, the whole transaction would be pending, including jobs that has auto-finalize=true. Still, it's a strange case.

So, auto-finalize=true is silently ignored when another job in the same
transaction has auto-finalize=false?

>> Aside: getting rid of auto-dismiss and auto-finalize some day would be
>> nice.
>> 
>
> Hmm.. You mean, deprecated "true" value, and finally drop the fields, making "false" the default? May be.

May or may not be practical.

> I'll resend, with additional patch to touch-up the documentation.

Thanks!


