Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877F3C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaim-0000pQ-6H; Thu, 29 Feb 2024 02:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfaih-0000p1-R4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:20:44 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfaic-00079h-VC
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:20:43 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:4da0:0:640:817e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3457260B52;
 Thu, 29 Feb 2024 10:20:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UKURvx2IbKo0-6DhiD1VU; Thu, 29 Feb 2024 10:20:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709191231;
 bh=oWZI024h7GNYUt7b7MURwv9PeTvP4wdNEZGbXnXnLTU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NVFjSpP6ELCjCfNQWFhPf6wb3NjDv3WF0g9mRKSBwI8GWLxchLU1UNxq4j5OO6Hfk
 aznKQD3apZlawy0xIe0MyWynlvgCNX2QPm2xGYYEvnY1+DD8foTv/zFZN9bE1PTzc0
 PMOvfIlqo6/98QWRwpiNeHADyZquXdVt62AxkGC8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <86d70a2e-7250-440b-bcd6-7877fe3b3dba@yandex-team.ru>
Date: Thu, 29 Feb 2024 10:20:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com> <87zfvj3hnd.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87zfvj3hnd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29.02.24 09:32, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> The purpose is to record a potential error in the migration stream if
>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>> handlers can be modified to use the Error argument instead of managing
>> their own and calling locally error_report(). The following patches
>> will introduce such changes for VFIO first.
>>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
> 
> [...]
> 
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
>>       return ret;
>>   }
>>   
>> -static int cmma_save_setup(QEMUFile *f, void *opaque)
>> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>         int res;
>         /*
>          * Signal that we want to start a migration, thus needing PGSTE dirty
>          * tracking.
>          */
>         res = sac->set_migrationmode(sas, 1);
>         if (res) {
>             return res;
> 
> I believe this is a failure return.
> 
> Anti-pattern: fail without setting an error.  There might be more
> elsewhere in the series.
> 
> qapi/error.h's big comment:
> 
>   * - On success, the function should not touch *errp.  On failure, it
>   *   should set a new error, e.g. with error_setg(errp, ...), or
>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>   *
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> 
>         }
>         qemu_put_be64(f, STATTR_FLAG_EOS);
>         return 0;
>     }
> 
> When adding Error **errp to a function, you must also add code to set an
> error on failure to every failure path.  Adding it in a later patch in
> the same series can be okay,

Personally, I'd prefer not doing so. Creating wrong commits and fixing them in same series - better to merge all fixes into bad commit:)

> but I'd add a TODO comment to the function
> then, and mention it in the commit message.
> 
> Questions?
> 
> [...]
> 

-- 
Best regards,
Vladimir


