Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C242CA0FE8
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 16:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uskYa-0003Z7-1H; Sun, 31 Aug 2025 12:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uskYN-0003Th-26; Sun, 31 Aug 2025 12:05:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uskYJ-00088x-Q1; Sun, 31 Aug 2025 12:05:14 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57VG4elo038262
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 01:04:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4LFtfIG+bqWaobcTdE2vQdHAxZpLQMMquGm/8a0boLs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756656281; v=1;
 b=LcnNGcchtzi249P3Fwb0p9CQNN5CaL9JBlfdSOYmjuGAhUlCGvwsVEjknqW1Y3tK
 A8fqoJoBN4i0FvxuqzRyWYWiT1pGhGt99SUocJHiHQsDG4BcxX+Qqv660gwUQ33V
 xNhEk1Bs708GSsjU9cY8vnqC80nsggOtAVZVoSiwRoZxTHumSXFeTz9BoX2GjVja
 /NHobGzHLqtHcXF9bP7+g9QzelfiXdk9mwRX9IFCx9wXv5ADReH5S7Hy5O7y7Zug
 yp7Yb4GmlEDpmebCvCek8AmYa6GHa6CpM4xDPMsCRp1QaSoSkzRKse0wyYQQBaGt
 cqN0wu683TgQc+Oc+zacCw==
Message-ID: <017c40a6-3347-43e7-b7b7-9e2e2130d19e@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 1 Sep 2025 01:04:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/27] migration: push Error **errp into
 qemu_loadvm_state()
To: armenon@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
 <20250830-propagate_tpm_error-v13-7-a4e777b7eb2c@redhat.com>
 <078e2ef1-fbfa-450a-a2ab-d1e77cc8e850@rsg.ci.i.u-tokyo.ac.jp>
 <aLRt_G-pOH1rwJbb@armenon-kvm.bengluru.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aLRt_G-pOH1rwJbb@armenon-kvm.bengluru.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/09/01 0:45, Arun Menon wrote:
> Hi Akihiko,
> Thanks for the review.
> 
> On Sat, Aug 30, 2025 at 02:58:05PM +0900, Akihiko Odaki wrote:
>> On 2025/08/30 5:01, Arun Menon wrote:
>>> This is an incremental step in converting vmstate loading
>>> code to report error via Error objects instead of directly
>>> printing it to console/monitor.
>>> It is ensured that qemu_loadvm_state() must report an error
>>> in errp, in case of failure.
>>>
>>> When postcopy live migration runs, the device states are loaded by
>>> both the qemu coroutine process_incoming_migration_co() and the
>>> postcopy_ram_listen_thread(). Therefore, it is important that the
>>> coroutine also reports the error in case of failure, with
>>> error_report_err(). Otherwise, the source qemu will not display
>>> any errors before going into the postcopy pause state.
>>>
>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>> ---
>>>    migration/migration.c |  9 +++++----
>>>    migration/savevm.c    | 30 ++++++++++++++++++------------
>>>    migration/savevm.h    |  2 +-
>>>    3 files changed, 24 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
>>>                          MIGRATION_STATUS_ACTIVE);
>>>        mis->loadvm_co = qemu_coroutine_self();
>>> -    ret = qemu_loadvm_state(mis->from_src_file);
>>> +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>>>        mis->loadvm_co = NULL;
>>>        trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
>>> @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
>>>        }
>>>        if (ret < 0) {
>>> -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>>> +        error_prepend(&local_err, "load of migration failed: %s: ",
>>> +                      strerror(-ret));
>>>            goto fail;
>>>        }
>>> @@ -924,13 +925,13 @@ fail:
>>>        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>>                          MIGRATION_STATUS_FAILED);
>>>        migrate_set_error(s, local_err);
>>> -    error_free(local_err);
>>> +    error_report_err(local_err);
>>
>> This is problematic because it results in duplicate error reports when
>> !mis->exit_on_error; in that case the query-migrate QMP command reports the
>> error and this error reporting is redundant.
> 
> If I comment this change, then all of the errors propagated up to now, using
> error_setg() will not be reported. This is the place where it is finally reported,
> when qemu_loadvm_state() fails. In other words, all the error_reports() we removed
> from all the files, replacing them with error_setg(), will finally be reported here
> using error_report_err().

My understanding of the code without these two changes is:
- If the migrate-incoming QMP command is used with false as
   exit-on-error, this function will not report the error but
   the query-migrate QMP command will report the error.
- Otherwise, this function reports the error.

With these two changes, if the migrate-incoming QMP command is used with 
false as exit-on-error, this function will report the error *and* the 
query-migrate QMP command will report the error, resulting in duplicate 
reports.

> 
>>
>>>        migration_incoming_state_destroy();
>>>        if (mis->exit_on_error) {
>>>            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>> -            error_report_err(s->error);
>>> +            error_free(s->error);
>>
>> This change is problematic because s->error set somewhere else here will be
>> ignored.
> 
> This is specific to the case when mis->exit_on_error is set.
> since we did a migrate_set_error(s, local_err) before, we free the
> error in s->error and set it to NULL, before an exit(EXIT_FAILURE)

It shouldn't just free the error but should print it or the error will 
be missed.

Regards,
Akihiko Odaki

