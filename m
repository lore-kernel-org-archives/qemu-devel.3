Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0E5CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzE7C-0006hL-Qv; Thu, 18 Sep 2025 08:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzE79-0006ff-D9; Thu, 18 Sep 2025 08:51:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzE76-0003ko-6n; Thu, 18 Sep 2025 08:51:55 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58ICpVP8088645
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Sep 2025 21:51:31 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RqIUq7DUkO3YZTybQ3YeAw3GOsF4pR/RUON2kesoIcE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758199892; v=1;
 b=OPCgmVQistWl/m7gHdWLYT30nPnKTFN3PJEcHLVMV1+uXaPxclwI9orA6WbRJIX5
 Snnh8083/5zRRLMQDpDQwS5FCOEjnS5ZmrVqb0HQcIL+UTtJ2xFRV1x2S808Y0de
 5CdXrzHd6ovRRcWCYGGt7PuYqSbmw+YvgNCgtx/wTYGDdKQMGE5HYYi7C6Jctwyp
 lspg820MM3j+Hhy+7WKllRylXhyuRIfZnbbLnHmj0jrZv7goPwzQaMcTavqKuknm
 HLtb/hnwqIJZbxD+AUQhNWyEoHBxJo8ybq3Fe6k8OP27DJUuMs5f3aAc/FwGMYCd
 wGVMg97kmlpLgccrdYbc5w==
Message-ID: <615d09de-b7b8-47d3-9346-29cf27ee32e2@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Sep 2025 21:51:31 +0900
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
References: <aLR6mKJyVPZ4bqnZ@armenon-kvm.bengluru.csb>
 <6bee20a5-6f12-4b12-aab3-1a2019418611@rsg.ci.i.u-tokyo.ac.jp>
 <aLfklAy0qqetX8_K@armenon-kvm.bengluru.csb>
 <201bb795-57af-4614-8ef1-e5218108c13f@rsg.ci.i.u-tokyo.ac.jp>
 <aMoCIwzS7NWmTedG@armenon-kvm.bengluru.csb>
 <1cfcf036-0cdf-44a9-8c39-5219285a1dfa@rsg.ci.i.u-tokyo.ac.jp>
 <aMrFPbbbC3gIcvJu@armenon-kvm.bengluru.csb>
 <bb702a89-c198-43d0-bc4e-22c355d3ac20@rsg.ci.i.u-tokyo.ac.jp>
 <aMummAAkDFSvP-eT@armenon-kvm.bengluru.csb>
 <9d67536b-f28f-4db4-a0ff-f5c7b2476b83@rsg.ci.i.u-tokyo.ac.jp>
 <aMv_gTlkkpiYTO88@armenon-kvm.bengluru.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aMv_gTlkkpiYTO88@armenon-kvm.bengluru.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/09/18 21:48, Arun Menon wrote:
> Hi Akihiko,
> 
> On Thu, Sep 18, 2025 at 09:08:05PM +0900, Akihiko Odaki wrote:
>> On 2025/09/18 15:28, Arun Menon wrote:
>>> Hi Akihiko,
>>>
>>> On Thu, Sep 18, 2025 at 11:06:58AM +0900, Akihiko Odaki wrote:
>>>> On 2025/09/17 23:27, Arun Menon wrote:
>>>>> Hi Akihiko,
>>>>>
>>>>> On Wed, Sep 17, 2025 at 04:54:11PM +0900, Akihiko Odaki wrote:
>>>>>> On 2025/09/17 9:34, Arun Menon wrote:
>>>>>>> Hi Akihiko,
>>>>>>>
>>>>>>> On Sat, Sep 06, 2025 at 05:22:31AM +0200, Akihiko Odaki wrote:
>>>>>>>> On 2025/09/03 8:47, Arun Menon wrote:
>>>>>>>>> Hi Akihiko,
>>>>>>>>>
>>>>>>>>> It took some time to set up the machines; apologies for the delay in response.
>>>>>>>>>
>>>>>>>>> On Mon, Sep 01, 2025 at 02:12:54AM +0900, Akihiko Odaki wrote:
>>>>>>>>>> On 2025/09/01 1:38, Arun Menon wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On Mon, Sep 01, 2025 at 01:04:40AM +0900, Akihiko Odaki wrote:
>>>>>>>>>>>> On 2025/09/01 0:45, Arun Menon wrote:
>>>>>>>>>>>>> Hi Akihiko,
>>>>>>>>>>>>> Thanks for the review.
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Sat, Aug 30, 2025 at 02:58:05PM +0900, Akihiko Odaki wrote:
>>>>>>>>>>>>>> On 2025/08/30 5:01, Arun Menon wrote:
>>>>>>>>>>>>>>> This is an incremental step in converting vmstate loading
>>>>>>>>>>>>>>> code to report error via Error objects instead of directly
>>>>>>>>>>>>>>> printing it to console/monitor.
>>>>>>>>>>>>>>> It is ensured that qemu_loadvm_state() must report an error
>>>>>>>>>>>>>>> in errp, in case of failure.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> When postcopy live migration runs, the device states are loaded by
>>>>>>>>>>>>>>> both the qemu coroutine process_incoming_migration_co() and the
>>>>>>>>>>>>>>> postcopy_ram_listen_thread(). Therefore, it is important that the
>>>>>>>>>>>>>>> coroutine also reports the error in case of failure, with
>>>>>>>>>>>>>>> error_report_err(). Otherwise, the source qemu will not display
>>>>>>>>>>>>>>> any errors before going into the postcopy pause state.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>>>>>>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>>>>>>>>>>>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>          migration/migration.c |  9 +++++----
>>>>>>>>>>>>>>>          migration/savevm.c    | 30 ++++++++++++++++++------------
>>>>>>>>>>>>>>>          migration/savevm.h    |  2 +-
>>>>>>>>>>>>>>>          3 files changed, 24 insertions(+), 17 deletions(-)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>>>>>>>>>>> index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
>>>>>>>>>>>>>>> --- a/migration/migration.c
>>>>>>>>>>>>>>> +++ b/migration/migration.c
>>>>>>>>>>>>>>> @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
>>>>>>>>>>>>>>>                                MIGRATION_STATUS_ACTIVE);
>>>>>>>>>>>>>>>              mis->loadvm_co = qemu_coroutine_self();
>>>>>>>>>>>>>>> -    ret = qemu_loadvm_state(mis->from_src_file);
>>>>>>>>>>>>>>> +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>>>>>>>>>>>>>>>              mis->loadvm_co = NULL;
>>>>>>>>>>>>>>>              trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
>>>>>>>>>>>>>>> @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
>>>>>>>>>>>>>>>              }
>>>>>>>>>>>>>>>              if (ret < 0) {
>>>>>>>>>>>>>>> -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>>>>>>>>>>>>>>> +        error_prepend(&local_err, "load of migration failed: %s: ",
>>>>>>>>>>>>>>> +                      strerror(-ret));
>>>>>>>>>>>>>>>                  goto fail;
>>>>>>>>>>>>>>>              }
>>>>>>>>>>>>>>> @@ -924,13 +925,13 @@ fail:
>>>>>>>>>>>>>>>              migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>>>>>>>>>>>>>>                                MIGRATION_STATUS_FAILED);
>>>>>>>>>>>>>>>              migrate_set_error(s, local_err);
>>>>>>>>>>>>>>> -    error_free(local_err);
>>>>>>>>>>>>>>> +    error_report_err(local_err);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This is problematic because it results in duplicate error reports when
>>>>>>>>>>>>>> !mis->exit_on_error; in that case the query-migrate QMP command reports the
>>>>>>>>>>>>>> error and this error reporting is redundant.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If I comment this change, then all of the errors propagated up to now, using
>>>>>>>>>>>>> error_setg() will not be reported. This is the place where it is finally reported,
>>>>>>>>>>>>> when qemu_loadvm_state() fails. In other words, all the error_reports() we removed
>>>>>>>>>>>>> from all the files, replacing them with error_setg(), will finally be reported here
>>>>>>>>>>>>> using error_report_err().
>>>>>>>>>>>>
>>>>>>>>>>>> My understanding of the code without these two changes is:
>>>>>>>>>>>> - If the migrate-incoming QMP command is used with false as
>>>>>>>>>>>>         exit-on-error, this function will not report the error but
>>>>>>>>>>>>         the query-migrate QMP command will report the error.
>>>>>>>>>>>> - Otherwise, this function reports the error.
>>>>>>>>>>>
>>>>>>>>>>> With my limited experience in testing, I have a question,
>>>>>>>>>>> So there are 2 scenarios,
>>>>>>>>>>> 1. running the virsh migrate command on the source host. Something like the following,
>>>>>>>>>>>         virsh -c 'qemu:///system' migrate --live --verbose --domain guest-vm --desturi qemu+ssh://10.6.120.20/system
>>>>>>>>>>>         OR for postcopy-ram,
>>>>>>>>>>>         virsh migrate guest-vm --live qemu+ssh://10.6.120.20/system --verbose --postcopy --timeout 10 --timeout-postcopy
>>>>>>>>>>>
>>>>>>>>>>> 2. Using QMP commands, performing a migration from source to destination.
>>>>>>>>>>>         Running something like the following on the destination:
>>>>>>>>>>>         {
>>>>>>>>>>>           "execute": "migrate-incoming",
>>>>>>>>>>>           "arguments": {
>>>>>>>>>>>             "uri": "tcp:127.0.0.1:7777",
>>>>>>>>>>>             "exit-on-error": false
>>>>>>>>>>>           }
>>>>>>>>>>>         }
>>>>>>>>>>>         {
>>>>>>>>>>>           "execute": "migrate-incoming",
>>>>>>>>>>>           "arguments": {
>>>>>>>>>>>             "uri": "tcp:127.0.0.1:7777",
>>>>>>>>>>>             "exit-on-error": false
>>>>>>>>>>>           }
>>>>>>>>>>>         }
>>>>>>>>>>>         and the somthing like the following on source:
>>>>>>>>>>>         {
>>>>>>>>>>>           "execute": "migrate",
>>>>>>>>>>>           "arguments": {
>>>>>>>>>>>             "uri": "tcp:127.0.0.1:7777"
>>>>>>>>>>>           }
>>>>>>>>>>>         }
>>>>>>>>>>>         {"execute" : "query-migrate"}
>>>>>>>>>>>
>>>>>>>>>>> In 1, previously, the user used to get an error message on migration failure.
>>>>>>>>>>> This was because there were error_report() calls in all of the files.
>>>>>>>>>>> Now that they are replaced with error_setg() and the error is stored in errp,
>>>>>>>>>>> we need to display that using error_report_err(). Hence I introduced an error_report_err()
>>>>>>>>>>> call in the fail section.
>>>>>>>>>>>
>>>>>>>>>>> In 2, we have 2 QMP sessions, one for the source and another for the destination.
>>>>>>>>>>> The QMP command migrate will be issued on the source, and the errp will be set.
>>>>>>>>>>> I did not understand the part where the message will be displayed because of the
>>>>>>>>>>> error_report_err() call. I did not see such a message on failure scenario on both
>>>>>>>>>>> the sessions.
>>>>>>>>>>> If the user wants to check for errors, then the destination qemu will not exit
>>>>>>>>>>> (exit-on-error = false ) and we can retrieve it using {"execute" : "query-migrate"}
>>>>>>>>>>>
>>>>>>>>>>> Aren't the 2 scenarios different by nature?
>>>>>>>>>>
>>>>>>>>>> In 1, doesn't libvirt query the error with query-migrate and print it?
>>>>>>>>>
>>>>>>>>> Ideally it should find the the error, and print the whole thing. It does work
>>>>>>>>> in the normal scenario. However, the postcopy scenario does not show the same result,
>>>>>>>>> which is mentioned in the commit message.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> In any case, it would be nice if you describe how libvirt interacts with
>>>>>>>>>> QEMU in 1.
>>>>>>>>>
>>>>>>>>> Please find below the difference in the command output at source, when we run a live migration
>>>>>>>>> with postcopy enabled.
>>>>>>>>>
>>>>>>>>> =========
>>>>>>>>> With the current changes:
>>>>>>>>> [root@dell-per750-42 qemu-priv]# virsh migrate-setspeed guest-vm 1
>>>>>>>>>
>>>>>>>>> [root@dell-per750-42 build]# virsh migrate guest-vm --live qemu+ssh://10.6.120.9/system --verbose --postcopy --timeout 10 --timeout-postcopy
>>>>>>>>> root@10.6.120.9's password:
>>>>>>>>> Migration: [ 1.26 %]error: internal error: QEMU unexpectedly closed the monitor (vm='guest-vm'): 2025-09-03T06:19:15.076547Z qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (2) exceeds the recommended cpus supported by KVM (1)
>>>>>>>>> 2025-09-03T06:19:15.076586Z qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (2) exceeds the recommended cpus supported by KVM (1)
>>>>>>>>> 2025-09-03T06:19:27.776715Z qemu-system-x86_64: load of migration failed: Input/output error: error while loading state for instance 0x0 of device 'tpm-emulator': post load hook failed for: tpm-emulator, version_id: 0, minimum_version: 0, ret: -5: tpm-emulator: Setting the stateblob (type 1) failed with a TPM error 0x21 decryption error
>>>>>>>>>
>>>>>>>>> [root@dell-per750-42 build]#
>>>>>>>>>
>>>>>>>>> =========
>>>>>>>>>
>>>>>>>>> Without the current changes:
>>>>>>>>> [root@dell-per750-42 qemu-priv]# virsh migrate-setspeed guest-vm 1
>>>>>>>>>
>>>>>>>>> [root@dell-per750-42 qemu-priv]# virsh migrate guest-vm --live qemu+ssh://10.6.120.9/system --verbose --postcopy --timeout 10 --timeout-postcopy
>>>>>>>>> root@10.6.120.9's password:
>>>>>>>>> Migration: [ 1.28 %]error: internal error: QEMU unexpectedly closed the monitor (vm='guest-vm'): 2025-09-03T06:26:17.733786Z qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (2) exceeds the recommended cpus supported by KVM (1)
>>>>>>>>> 2025-09-03T06:26:17.733830Z qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (2) exceeds the recommended cpus supported by KVM (1)
>>>>>>>>>
>>>>>>>>> [root@dell-per750-42 qemu-priv]#
>>>>>>>>>
>>>>>>>>> =========
>>>>>>>>> The original behavior was to print the error to the console regardless of whether the migration is normal or postcopy.
>>>>>>>>
>>>>>>>> This was true for messages in qemu_loadvm_state(), but the message "load of
>>>>>>>> migration failed" was printed or queried with query-migrate, not both. We
>>>>>>>> should think of which behavior is more appropriate, and I think we should
>>>>>>>> avoid duplicate reports.
>>>>>>>>
>>>>>>>>> The source machine goes in to a paused state after this.
>>>>>>>>
>>>>>>>> The output is informative. It implies the destination machine exited, and it
>>>>>>>> makes sense to print error messages as it is done for
>>>>>>>> mis->exit_on_error. I wonder if it is possible to detect the condition and
>>>>>>>> treat it identically to mis->exit_on_error.
>>>>>>>
>>>>>>> I see that we want to catch a specific scenario in postcopy ram migration
>>>>>>> where the destination abruptly exits without a graceful shutdown,
>>>>>>> thus failing to inform the source the reason for its failure through a
>>>>>>> 'query-migrate' even though 'exit-on-error' was set to false on the destination.
>>>>>>>
>>>>>>> However, I am not sure how to reliably detect the specific error condition of
>>>>>>> such a connection close that you have described. Given that this is a large
>>>>>>> patch series already, could we keep the current change as is for now?
>>>>>>>     From what I can tell, the additional log message "load of migration failed"
>>>>>>> is not a breaking change and will not cause a crash. We can develop a more
>>>>>>> elegant solution to handle the issue of duplication in a separate patch.
>>>>>> There are two regressions:
>>>>>> 1) Duplicate error reports when exit-on-error is false and postcopy is
>>>>>> disabled.
>>>>>
>>>>> Thank you for your detailed response.
>>>>> I am trying to fully understand the logic here, so please correct me if I'm wrong.
>>>>> My understanding of the patch is that all errors are chained together
>>>>> in local_err by propagating them through the call stack and prepending them with
>>>>> "load of migration failed."
>>>>> This creates a single, comprehensive error message, which is then passed to
>>>>>      migrate_set_error(s, local_err) in the fail section.
>>>>> This line already existed. So in effect we are setting the error here.
>>>>
>>>> There are two other changes:
>>>> - The message is printed immediately with error_report_err(). This causes
>>>> 1).
>>>> - The error set with migrate_set_error() is ignored. This causes 2).
>>>>
>>>>>
>>>>> Regarding the second regression you mentioned:
>>>>>
>>>>>> 2) Errors reported code else qemu_loadvm_state() are ignored when
>>>>>> exit-on-error is true.
>>>>>
>>>>> Doesn't the error_prepend() function ensure that errors set higher up the call stack
>>>>> are preserved and only "load of migration failed" is prepended to it?
>>>>> When the fail section is reached, local_err will have the complete error message.
>>>>>
>>>>>>
>>>>>> 1) is trivial yet difficult to fix and I agree that it can be handled later.
>>>>>> Ideally there should be a comment to note that.
>>>>>>
>>>>>> However, there is also 2), which is more serious and easier to fix so I
>>>>>> suggest fixing it now. More concretely, the code will look like as follows:
>>>>>>
>>>>>>        migrate_set_error(s, local_err);
>>>>>>        if (mis->exit_on_error) {
>>>>>>            error_free(local_err);
>>>>>>        } else {
>>>>>>            /*
>>>>>>             * Report the error here in case that QEMU abruptly exits when
>>>>>>             * postcopy is enabled.
>>>>>>             */
>>>>>>            error_report_err(s->error);
>>>>>>        }
>>>>>>
>>>>>>        migration_incoming_state_destroy();
>>>>>>
>>>>>>        if (mis->exit_on_error) {
>>>>>>            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>>>>>                error_report_err(s->error);
>>>>>>
>>>>>> This ensures errors set by anyone will be reported while duplicate error
>>>>>> reports are avoided when exit-on-error is true.
>>>>>
>>>>> yes, this part (set by anyone), I fail to follow. Do you mean that there can be
>>>>> chances of a race condition between migrate_set_error() and error_report_err()?
>>>>>
>>>>> My analysis of your proposed code shows that whether mis->exit_on_error is true (in the final if block)
>>>>> or false (in the else block), error_report_err() is called.
>>>>> This seems to result in the error being reported regardless, which is similar to my original patch.
>>>>> Yes in both the cases, s->error is being reported. However in my view, in the fail section, both
>>>>> local_err and s->error will be the same.
>>>>>
>>>>> I appreciate your patience as I try to understand this better.
>>>>
>>>> I indeed suspect the possibility of a race condition between
>>>> migration_set_error() and error_report_err(). The code implies an error can
>>>> be concurrently reported when migration_incoming_state_destroy() is called,
>>>> and synchronized with WITH_QEMU_LOCK_GUARD(&s->error_mutex).
>>>>
>>>> This code fragment is useless if there is no such concurrency at all and
>>>> should look like the following:
>>>>
>>>>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>>>                         MIGRATION_STATUS_FAILED);
>>>>       error_report_err(local_err);
>>>>
>>>>       if (mis->exit_on_error) {
>>>>           exit(EXIT_FAILURE);
>>>>       }
>>>>
>>>>       migrate_set_error(s, local_err);
>>>>
>>>>       migration_incoming_state_destroy();
>>>>
>>>> But it is not how the code is written, so I suspect there is a race
>>>> condition.
>>>
>>> Thank you. That is clear to me now.
>>> We need to report s->error because it can be set somewhere else.
>>> We are creating separate paths but only adding a placeholder comment
>>> for now for the postcopy scenario. I suppose local_err can be freed outside the if clause.
>>
>> The separate paths or the if clause for error_free() and error_report_err()
>> is necessary because both functions free the error object and calling both
>> results in double-free.
> 
> Doesn't error_copy() called inside migrate_set_error() create a deep copy of the error
> object? Such that local_err and s->error point to separate locations in memory.
> 
> The following has more boilerplate code as it does not change the existing sequence
> of instructions but it can create confusion while reading.
> fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      migrate_set_error(s, local_err);
>      error_free(local_err);
> 
>      if (!mis->exit_on_error) {
>          /*
>           * Report the error here in case that QEMU abruptly exits when
>           * postcopy is enabled.
>           */
>          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>              error_report_err(s->error);
>              s->error = NULL;
>          }
>      }
>      migration_incoming_state_destroy();
>      if (mis->exit_on_error) {
>          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>              error_report_err(s->error);
>              s->error = NULL;
>          }
>          exit(EXIT_FAILURE);
>      }
> 
> To avoid the confusion we can do the following,
> fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      migrate_set_error(s, local_err);
>      error_free(local_err);
> 
>      migration_incoming_state_destroy();
> 
>      if (mis->exit_on_error) {
>          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>              error_report_err(s->error);
>              s->error = NULL;
>          }
>          exit(EXIT_FAILURE);
>      } else {
>          /*
>           * Report the error here in case that QEMU abruptly exits when
>           * postcopy is enabled.
>           */
>          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>              error_report_err(s->error);
>              s->error = NULL;
>          }
>      }
> 
> This way, we are freeing local_err, and reporting s->error, solving regression 2
> We also have 2 code paths to deal with the postcopy scenario later (regression 1).
> reporting the error and setting it to NULL requires a lock guard as it is a
> shared object.

I forgot the possibility that s->error may be set when postcopy is 
enabled. The code looks good to me.

Regards,
Akihiko Odaki

