Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1376EF9003
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxp4u-0005ZK-Bg; Wed, 04 Mar 2026 11:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxp4l-0005Yl-I3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:27:55 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxp4j-0005K3-Bi
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:27:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3528580C58;
 Wed, 04 Mar 2026 19:27:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:921::1:1b] (unknown
 [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mRrAp50A7a60-zqYTRDDk; Wed, 04 Mar 2026 19:27:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772641668;
 bh=kfrFmHQP6W7W749o1wdpk3GKo4NHyscvCKzgRrRZHb8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=DtjZ1LV4RSm3Bi7SV3JIFp5gM6fDenHGwyl5v+7bNoyM4ihm6CH4r0uIsAcAagsxh
 SItQ8Ane7kPBoxa9gODLsb/Qne5/mHPzpVEiTVUqM2Cq3nBjjwJJcViCgHwzQLnmUG
 j+P8EnuTI6SoZxtJFOWyW4ZLJ2eRruMPhjl4nOEY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <88cbfd0b-22d0-41e3-b671-a154f7edd12d@yandex-team.ru>
Date: Wed, 4 Mar 2026 19:27:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] migration: factor out vmstate_pre_save() from
 vmstate_save_state()
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-7-vsementsov@yandex-team.ru>
 <aab8mnOqwJh3AtgD@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aab8mnOqwJh3AtgD@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.03.26 18:22, Peter Xu wrote:
> On Sat, Feb 21, 2026 at 12:02:04AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Simplify vmstate_save_state() which is rather big, and simplify further
>> refactoring.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One trivial thing..
> 
>> ---
>>   migration/vmstate.c | 34 ++++++++++++++++++++++------------
>>   1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index b07bbdd366..810b131f18 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -430,6 +430,26 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
>>       return true;
>>   }
>>   
>> +static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
>> +                             Error **errp)
>> +{
>> +    ERRP_GUARD();
> 
> I can come up with no reason a caller should pass in NULL for errp..  I
> don't know why we assert(errp) so rarely in qemu for similar cases, but
> iiuc that's what we really want here..

assert(errp) will not handle error_fatal case correctly. ERRP_GUARD guarantees,
that in case of errp == &error_fatal, the error message will contain what we
prepend by error_prepend().

So, current practice is add ERRP_GUARD in any function which want to use
error_prepend(errp, ..).

May be, we may have some additional macro

#define ERRP_GOOD(); which will assert that errp is not in (NULL, &error_fatal),

and then, use it here, but then we should check, that for the whole callers *
caller either pass errp and has ERRP_GOOD() macro, or pass local error object.

> 
>> +
>> +    if (vmsd->pre_save_errp) {
>> +        if (!vmsd->pre_save_errp(opaque, errp)) {
>> +            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>> +            return false;
>> +        }
>> +    } else if (vmsd->pre_save) {
>> +        if (vmsd->pre_save(opaque) < 0) {
>> +            error_setg(errp, "pre-save failed: %s", vmsd->name);
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>                                   void *opaque, JSONWriter *vmdesc,
>>                                   int version_id, Error **errp)
>> @@ -440,18 +460,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>   
>>       trace_vmstate_save_state_top(vmsd->name);
>>   
>> -    if (vmsd->pre_save_errp) {
>> -        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
>> -        if (ret < 0) {
>> -            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>> -            return ret;
>> -        }
>> -    } else if (vmsd->pre_save) {
>> -        ret = vmsd->pre_save(opaque);
>> -        if (ret) {
>> -            error_setg(errp, "pre-save failed: %s", vmsd->name);
>> -            return ret;
>> -        }
>> +    if (!vmstate_pre_save(vmsd, opaque, errp)) {
>> +        return -EINVAL;
>>       }
>>   
>>       trace_vmstate_save_state_pre_save_done(vmsd->name);
>> -- 
>> 2.52.0
>>
> 


-- 
Best regards,
Vladimir

