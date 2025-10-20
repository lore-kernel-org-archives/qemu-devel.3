Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F35CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArRr-0008J5-DY; Mon, 20 Oct 2025 11:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vArRj-0008HL-V5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:05:16 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vArRg-0006wi-SA
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:05:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5EE3D8044F;
 Mon, 20 Oct 2025 18:05:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a51::1:37] (unknown
 [2a02:6bf:8080:a51::1:37])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 65XwAj4FSOs0-7dtshxC8; Mon, 20 Oct 2025 18:05:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760972706;
 bh=inKM70hgOMMHVR6iRkftWsru3Hdw0CTGmjkCCdMso5M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0oDqslAyfQaq0oJxdBB6MmiiG/s8HdJLlibTIiA6YT4d9sTsCZ9fhsGYwonexxj8R
 4wSLvMo1k6Zuz5iSzTSQRqGmHoFkguwINgEjm2rC15ImpZewIY9CzI4qT9iUVju4pi
 Zuo7jVnGi8rPWMZLOV5nl1ltaZcNLV8o09ZrhodE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9ed4df07-fdae-4435-8f84-e3d53816e87b@yandex-team.ru>
Date: Mon, 20 Oct 2025 18:05:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
To: Peter Xu <peterx@redhat.com>
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <aPY90JnJtyHZUUuq@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPY90JnJtyHZUUuq@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.10.25 16:49, Peter Xu wrote:
> On Mon, Oct 20, 2025 at 12:19:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> @@ -255,13 +252,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           qemu_file_set_error(f, ret);
>>           return ret;
>>       }
>> -    if (vmsd->post_load_errp) {
>> -        ret = vmsd->post_load_errp(opaque, version_id, errp);
>> -        if (ret < 0) {
>> -            error_prepend(errp, "post load hook failed for: %s, version_id: "
>> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
>> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
>> -        }
>> +    if (vmsd->post_load_errp && !vmsd->post_load_errp(opaque, version_id,
> 
> I think this will change the semantics even if I do not expect a real user
> to exist.. if post_load_errp() returned true here, then it'll keep looking
> for post_load() and execute.
> 
> It might still be good to keep the old semantics, so that if
> post_load_errp() is provided, then we ignore post_load().  Same to the rest
> hooks.
> 

Oh, right.

>> +                                                      errp)) {
>> +        error_prepend(errp, "post load hook failed for: %s, version_id: "
>> +                      "%d, minimum_version: %d, ret: %d: ", vmsd->name,
>> +                      vmsd->version_id, vmsd->minimum_version_id, ret);
>> +        ret = -EINVAL;
>>       } else if (vmsd->post_load) {
>>           ret = vmsd->post_load(opaque, version_id);
>>           if (ret < 0) {
>> @@ -438,9 +434,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>       trace_vmstate_save_state_top(vmsd->name);
>>   
>>       if (vmsd->pre_save_errp) {
>> -        ret = vmsd->pre_save_errp(opaque, errp);
>>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>> -        if (ret < 0) {
>> +        if (!vmsd->pre_save_errp(opaque, errp)) {
>>               error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>>                             vmsd->name, ret);
>>           }
>> -- 
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

