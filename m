Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2303BCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOfz-0005aj-FX; Mon, 27 Oct 2025 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDOft-0005V2-G2
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:58:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDOfm-00026S-E7
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:58:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 75FF7C00E2;
 Mon, 27 Oct 2025 17:58:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6wdd6Y1LomI0-fZXMFXvq; Mon, 27 Oct 2025 17:58:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761577086;
 bh=LABveeVuoNQv0XKdQWupoRWMz7Tu9n3cRS2GLoxA7kQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Zz1jrZFCHDfXojxikVHh0gekwWW3PkeXkN+oM2g9ycN7j2xJ8+vGtnUHzNVxLaVLG
 Ie2XhmXMV+U2PkCGc6DYPa0cKM15vFctcCpTl3QZHxQJOUdk6gt/xgSvQIrtqfmIkk
 gO+9Bm/84LPEmbCV/qur2MBzVQIGtPcTJY6KkU7Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
Date: Mon, 27 Oct 2025 17:58:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org, berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
 <87o6psocib.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87o6psocib.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27.10.25 13:38, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Switch the new API to simple bool-returning interface, as return value
>> is not used otherwise than check is function failed or not. No logic
>> depend on concrete errno values.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   backends/tpm/tpm_emulator.c   | 10 ++++------
>>   docs/devel/migration/main.rst |  6 +++---
>>   include/migration/vmstate.h   |  6 +++---
>>   migration/vmstate.c           | 14 ++++++--------
>>   4 files changed, 16 insertions(+), 20 deletions(-)
>>
>> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
>> index aa69eb606f..6cc9aa199c 100644
>> --- a/backends/tpm/tpm_emulator.c
>> +++ b/backends/tpm/tpm_emulator.c
>> @@ -947,25 +947,23 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
>>   
>>   /*
>>    * Load the TPM state blobs into the TPM.
>> - *
>> - * Returns negative errno codes in case of error.
>>    */
>> -static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>> +static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>>   {
>>       TPMBackend *tb = opaque;
>>       int ret;
>>   
>>       ret = tpm_emulator_set_state_blobs(tb, errp);
> 
> Note for later: this returns 0 or -EIO.
> 
>>       if (ret < 0) {
>> -        return ret;
>> +        return false;
>>       }
>>   
>>       if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
>>           error_setg(errp, "Failed to resume tpm");
>> -        return -EIO;
>> +        return false;
>>       }
>>   
>> -    return 0;
>> +    return true;
>>   }
>>   
>>   static const VMStateDescription vmstate_tpm_emulator = {
>> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
>> index 1afe7b9689..234d280249 100644
>> --- a/docs/devel/migration/main.rst
>> +++ b/docs/devel/migration/main.rst
>> @@ -446,15 +446,15 @@ The functions to do that are inside a vmstate definition, and are called:
>>   
>>   Following are the errp variants of these functions.
>>   
>> -- ``int (*pre_load_errp)(void *opaque, Error **errp);``
>> +- ``bool (*pre_load_errp)(void *opaque, Error **errp);``
>>   
>>     This function is called before we load the state of one device.
>>   
>> -- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
>> +- ``bool (*post_load_errp)(void *opaque, int version_id, Error **errp);``
>>   
>>     This function is called after we load the state of one device.
>>   
>> -- ``int (*pre_save_errp)(void *opaque, Error **errp);``
>> +- ``bool (*pre_save_errp)(void *opaque, Error **errp);``
>>   
>>     This function is called before we save the state of one device.
>>   
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 63ccaee07a..dbe330dd5f 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -218,11 +218,11 @@ struct VMStateDescription {
>>       int minimum_version_id;
>>       MigrationPriority priority;
>>       int (*pre_load)(void *opaque);
>> -    int (*pre_load_errp)(void *opaque, Error **errp);
>> +    bool (*pre_load_errp)(void *opaque, Error **errp);
>>       int (*post_load)(void *opaque, int version_id);
>> -    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
>> +    bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
>>       int (*pre_save)(void *opaque);
>> -    int (*pre_save_errp)(void *opaque, Error **errp);
>> +    bool (*pre_save_errp)(void *opaque, Error **errp);
>>       int (*post_save)(void *opaque);
>>       bool (*needed)(void *opaque);
>>       bool (*dev_unplug_pending)(void *opaque);
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 677e56c84a..adaaf91b3f 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -154,13 +154,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           return -EINVAL;
>>       }
>>       if (vmsd->pre_load_errp) {
>> -        ret = vmsd->pre_load_errp(opaque, errp);
>> -        if (ret < 0) {
>> +        if (!vmsd->pre_load_errp(opaque, errp)) {
>>               error_prepend(errp, "pre load hook failed for: '%s', "
>>                             "version_id: %d, minimum version_id: %d: ",
>>                             vmsd->name, vmsd->version_id,
>>                             vmsd->minimum_version_id);
>> -            return ret;
>> +            return -EINVAL;
>>           }
>>       } else if (vmsd->pre_load) {
>>           ret = vmsd->pre_load(opaque);
>> @@ -256,11 +255,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           return ret;
>>       }
>>       if (vmsd->post_load_errp) {
>> -        ret = vmsd->post_load_errp(opaque, version_id, errp);
>> -        if (ret < 0) {
>> +        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
>>               error_prepend(errp, "post load hook failed for: %s, version_id: "
>>                             "%d, minimum_version: %d: ", vmsd->name,
>>                             vmsd->version_id, vmsd->minimum_version_id);
>> +            ret = -EINVAL;
> 
> With ->post_load_errp is tpm_emulator_post_load(), the value returned on
> error changes from -EIO to -EINVAL.
> 
> Do callers of vmstate_load_state() care?

Fast check.. let see somewhere, OK: get_qlist() in vmstate-types.c.. That's a .get
in VMStateInfo structure.

Oh, and we do print this ret the same way:


int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)

  ...

                     ret = inner_field->info->get(f, curr_elem, size,
                                                  inner_field);
                     if (ret < 0) {
                         error_setg(errp,
                                    "Failed to load element of type %s for %s: "
                                    "%d", inner_field->info->name,
                                    inner_field->name, ret);
                     }


Not saying about a lot  of vmstate_load_state() other calls in the code, and callers do
passthrough the error to their callers, and so on. It's a huge work to analyze all of
them.


Hmm now I see that tpm_emulator_post_load() returns only -EIO code on all error paths.

Would it be correct just use -EIO here in my patch instead of -EINVAL? It will save
current behavior as is.



-- 
Best regards,
Vladimir

