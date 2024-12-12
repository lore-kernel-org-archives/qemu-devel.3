Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C2E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLs4C-00029X-9j; Thu, 12 Dec 2024 17:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLs49-00022Q-Tp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:53:54 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLs48-0007DR-0f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:53:53 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLs43-00000003gWV-2LEi; Thu, 12 Dec 2024 23:53:47 +0100
Message-ID: <2c1d2c4c-d09f-4603-8bf6-c11a4faca0eb@maciej.szmigiero.name>
Date: Thu, 12 Dec 2024 23:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
To: Peter Xu <peterx@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
 <ceff9e17-b23e-472b-9f29-bf4c3c895c55@maciej.szmigiero.name>
 <Z1DbH5fwBaxtgrvH@x1n>
 <7e6373ca-b344-409f-a9ad-bce72779c10f@maciej.szmigiero.name>
 <Z1sVcJRamoUFshwk@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Z1sVcJRamoUFshwk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12.12.2024 17:55, Peter Xu wrote:
> On Wed, Dec 11, 2024 at 12:05:03AM +0100, Maciej S. Szmigiero wrote:
>> On 4.12.2024 23:43, Peter Xu wrote:
>>> On Thu, Nov 28, 2024 at 01:11:53PM +0100, Maciej S. Szmigiero wrote:
>>>>>> +static int qemu_loadvm_load_thread(void *thread_opaque)
>>>>>> +{
>>>>>> +    struct LoadThreadData *data = thread_opaque;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = data->function(&load_threads_abort, data->opaque);
>>>>>> +    if (ret && !qatomic_read(&load_threads_ret)) {
>>>>>> +        /*
>>>>>> +         * Racy with the above read but that's okay - which thread error
>>>>>> +         * return we report is purely arbitrary anyway.
>>>>>> +         */
>>>>>> +        qatomic_set(&load_threads_ret, ret);
>>>>>> +    }
>>>>>
>>>>> Can we use cmpxchg instead? E.g.:
>>>>>
>>>>> if (ret) {
>>>>>        qatomic_cmpxchg(&load_threads_ret, 0, ret);
>>>>> }
>>>>
>>>> cmpxchg always forces sequentially consistent ordering
>>>> while qatomic_read() and qatomic_set() have relaxed ordering.
>>>>
>>>> As the comment above describes, there's no need for sequential
>>>> consistency since which thread error is returned is arbitrary
>>>> anyway.
>>>
>>> IMHO this is not a hot path, so mem ordering isn't an issue.  If we could
>>> avoid any data race we still should try to.
>>>
>>> I do feel uneasy on the current design where everybody shares the "whether
>>> to quit" via one bool, and any thread can set it... meanwhile we can't
>>> stablize the first error to report later.
>>>
>>> E.g., ideally we want to capture the first error no matter where it came
>>> from, then keep it with migrate_set_error() so that "query-migrate" on dest
>>> later can tell us what was wrong.  I think libvirt generally uses that.
>>>
>>> So as to support a string error, at least we'll need to allow Error** in
>>> the thread fn:
>>>
>>> typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
>>>                                       Error **errp);
>>>
>>> I also changed retval to bool, as I mentioned elsewhere QEMU tries to stick
>>> with "bool SOME_FUNCTION(..., Error **errp)" kind of error reporting.
>>>
>>> Then any thread should only report error to qemu_loadvm_load_thread(), and
>>> the report should always be a local Error**, then it further reports to the
>>> global error.  Something like:
>>>
>>> static int qemu_loadvm_load_thread(void *thread_opaque)
>>> {
>>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>>       struct LoadThreadData *data = thread_opaque;
>>>       Error *error = NULL;
>>>
>>>       if (!data->function(data->opaque, &mis->should_quit, &error)) {
>>>          migrate_set_error(migrate_get_current(), error);
>>>       }
>>>
>>>       return 0;
>>> }
>>>
>>> migrate_set_error() is thread-safe, and it'll only record the 1st error.
>>>
>>> Then the thread should only read &should_quit, and only set &error.  If we
>>> want, migrate_set_error() can set &should_quit.
>>>
>>> PS: I wished we have an unified place to tell whether we should quit
>>> incoming migration - we already have multifd_recv_state->exiting, we could
>>> have had a global flag like that then we can already use.  But I know I'm
>>> asking too much.. However would you think it make sense to still have at
>>> least Error** report the error and record it?
>>>
>>
>> This could work with the following changes/caveats:
>> * Needs g_autoptr(Error) otherwise these Error objects will leak.
> 
> True.. or just error_free() it after set.
> 
>>
>> * "1st error" here is as arbitrary as with my current code since which
>> thread first acquires the mutex in migrate_set_error() is unspecified.
> 
> Yes that's still a step forward on being verbose of errors, which is almost
> always more helpful than a bool..
> 
> Not exactly the 1st error in time sequence is ok - we don't strongly ask
> for that, e.g. if two threads error at merely the same time it's ok we only
> record one of them no matter which one is first.  That's unusual to start
> with.
> 
> OTOH it matters on that we fail other threads only _after_ we set_error()
> for the first error.  If so it's mostly always the case the captured error
> will be valid and the real 1st error.
> 
>>
>> * We still need to test this new error flag (now as migrate_has_error())
>> in qemu_loadvm_state() to see whether we proceed forward with the
>> migration.
> 
> Yes, or just to work like what this patch does: set mis->should_quit within
> the 1st setup of migrate_set_error().  For the longer term, maybe we need
> to do more to put together all error setup/detection for migration.. but
> for now we can at least do that for this series to set should_quit=true
> there only.  It should work like your series, only that the boolean won't
> be writable to data->function() but read-only there, for the sake of
> capturing the Error string.

migrate_set_error() wouldn't be called until qemu_loadvm_state() exits
into process_incoming_migration_co().

Also this does not account other qemu_loadvm_state() callers like
qmp_xen_load_devices_state() or load_snapshot().

While these other callers might not use load threads currently, it feels
wrong to wait for these threads in qemu_loadvm_state() but set their
termination/abort flag as a side effect of completely different function
(migrate_set_error()).

Having a dedicated abort flag also makes the semantics easy to infer
from code since once can simply grep for this flag name (load_threads_abort)
to see where it is being written.

Its name is also pretty descriptive making it easy to immediately tell
what it does.

>>
>> -------------------------------------------------------------------
>>
>> Also, I am not in favor of replacing load_threads_abort with something
>> else since we still want to ask threads to quit for other reasons, like
>> earlier (non-load threads related) failure in the migration process.
>>
>> That's why we set this flag unconditionally in qemu_loadvm_state() -
>> see also my answer about that flag in the next message.
> 
> I'm not against having a boolean to say quit, maybe we should have that for
> !vfio use case too, and I'm ok we introduce one.  But I hope two things can
> work out:
> 
>    - Capture Error* and persist it in query-migrate (aka, use
>      migrate_set_error).

Will do.

>    - Avoid setting load_threads_abort explicitly in vmstate load path.  It
>      should really be part of destroy(), IMHO, as I mentioned in the other
>      email, to recycle load threads in a failure case.

That's the same thread abort flag issue as in the first block of my reply
above.

> Thanks,
> 

Thanks,
Maciej


