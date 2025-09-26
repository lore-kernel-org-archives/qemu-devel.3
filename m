Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FBCCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 06:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22Iw-0001gX-Eb; Fri, 26 Sep 2025 02:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v22Iu-0001f0-2e
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v22If-0003fp-J2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758869479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRUZivPap8McvrSJcRmmzR23XjEuBZHs55biujcAoOI=;
 b=S3pmtk9t8hI1Ry5N/TaV5DdmemWjsYgCtvxSrxar95zeK8rGvdHtgOaRYlJKhGvoF3RZOz
 +FRxV9i8k8OYsf+9zuvJsAOgv0F4DTeJ7SfST+PZu/niIgwWKQW1//dpUOgBsomE3/crQT
 /1u4Fp1zjVuXYAIdF64Z5kL8+b3Zarc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-PG0qE7KUM_iRg0nWH-DtHA-1; Fri,
 26 Sep 2025 02:51:14 -0400
X-MC-Unique: PG0qE7KUM_iRg0nWH-DtHA-1
X-Mimecast-MFC-AGG-ID: PG0qE7KUM_iRg0nWH-DtHA_1758869472
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 713C61800370; Fri, 26 Sep 2025 06:51:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50F0E180044F; Fri, 26 Sep 2025 06:51:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EC5A21E6A27; Fri, 26 Sep 2025 08:51:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com,  berrange@redhat.com,
 richard.henderson@linaro.org,  Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v3 05/13] hw/remote/vfio-user: Clean up error reporting
In-Reply-To: <1a10e0d3-17fc-4ec9-aa4c-cdfed13988e6@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 23 Sep 2025 13:14:23 +0300")
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-6-armbru@redhat.com>
 <1a10e0d3-17fc-4ec9-aa4c-cdfed13988e6@yandex-team.ru>
Date: Fri, 26 Sep 2025 08:51:08 +0200
Message-ID: <878qi1so4j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On 23.09.25 12:09, Markus Armbruster wrote:
>> VFU_OBJECT_ERROR() reports the error with error_setg(&error_abort,
>> ...) when auto-shutdown is enabled, else with error_report().
>>
>> Issues:
>>
>> 1. The error is serious enough to warrant aborting the process when
>> auto-shutdown is enabled, yet harmless enough to permit carrying on
>> when it's disabled.  This makes no sense to me.
>>
>> 2. Like assert(), &error_abort is strictly for programming errors.  Is
>> this one?
>
> Brief look at the code make me think that, no it isn't.

So the use of &error_abort is wrong.

>>  Or should we exit(1) instead?
>>
>> 3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
>> assert()."
>>
>> This patch addresses just 3.
>>
>> Cc: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/remote/vfio-user-obj.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
>> index ea6165ebdc..eb96982a3a 100644
>> --- a/hw/remote/vfio-user-obj.c
>> +++ b/hw/remote/vfio-user-obj.c
>> @@ -75,12 +75,9 @@ OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
>>    */
>>   #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
>>       {                                                                     \
>> -        if (vfu_object_auto_shutdown()) {                                 \
>> -            error_setg(&error_abort, (fmt), ## __VA_ARGS__);              \
>> -        } else {                                                          \
>> -            error_report((fmt), ## __VA_ARGS__);                          \
>> -        }                                                                 \
>> -    }                                                                     \
>> +        error_report((fmt), ## __VA_ARGS__);                              \
>> +        assert(!vfu_object_auto_shutdown());                              \
>
> Probably, it's only my feeling, but for me, assert() is really strictly bound
> to programming errors, more than abort(). Using abort() for errors which are
> not programming, but we can't handle them looks less confusing, i.e.
>
> if (vfu_object_auto_shutdown()) {
>     abort();
> }

assert(COND) is if (COND) abort() plus a message meant to help
developers.  Both are for programming errors.  If it isn't something
that needs debugging, why dump core?

But this particular error condition is *not* a programming error.  So

        assert(!vfu_object_auto_shutdown());

and

        if (vfu_object_auto_shutdown()) {
            abort();
        }

are both equally wrong.  However, the latter makes it easier to add a
FIXME comment:

        if (vfu_object_auto_shutdown()) {
            /*
             * FIXME This looks inappropriate.  The error is serious
             * enough programming error to warrant aborting the process
             * when auto-shutdown is enabled, yet harmless enough to
             * permit carrying on when it's disabled.  Makes no sense.
             */
            abort();
        }

The commit message would then need a tweak.  Perhaps

  Issues:

  1. The error is serious enough to warrant killing the process when
  auto-shutdown is enabled, yet harmless enough to permit carrying on
  when it's disabled.  This makes no sense to me.

  2. Like assert(), &error_abort is strictly for programming errors.  Is
  this one?  Vladimir Sementsov-Ogievskiy tells me it's not.

  3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
  assert()."

  This patch addresses just 3.  It adds a FIXME comment for the other
  two.

Thoughts?

> Not really matter. Anyway:
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks!

>> +    }
>>     struct VfuObjectClass {
>>       ObjectClass parent_class;


