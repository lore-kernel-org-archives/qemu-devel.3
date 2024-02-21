Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E64C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoX8-0002LL-FC; Wed, 21 Feb 2024 10:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rcoMW-0003Wj-JX; Wed, 21 Feb 2024 10:18:26 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rcinL-0002TR-Oa; Wed, 21 Feb 2024 04:21:41 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 09BC944398;
 Wed, 21 Feb 2024 10:21:35 +0100 (CET)
Message-ID: <c4b70504-0111-4747-a430-6fddfddf7e22@proxmox.com>
Date: Wed, 21 Feb 2024 10:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] drive-mirror: add support for sync=bitmap mode=never
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <20240216105513.309901-2-f.ebner@proxmox.com> <87il2i1f3u.fsf@pond.sub.org>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <87il2i1f3u.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 21.02.24 um 07:55 schrieb Markus Armbruster:
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index ab5a93a966..ac05483958 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2181,6 +2181,15 @@
>>  #     destination (all the disk, only the sectors allocated in the
>>  #     topmost image, or only new I/O).
>>  #
>> +# @bitmap: The name of a bitmap to use for sync=bitmap mode.  This
>> +#     argument must be present for bitmap mode and absent otherwise.
>> +#     The bitmap's granularity is used instead of @granularity.
>> +#     (Since 9.0).
> 
> What happens when the user specifies @granularity anyway?  Error or
> silently ignored?
> 

It's an error:

>> +    if (bitmap) {
>> +        if (granularity) {
>> +            error_setg(errp, "granularity (%d)"
>> +                       "cannot be specified when a bitmap is provided",
>> +                       granularity);
>> +            return NULL;
>> +        }

>> +#
>> +# @bitmap-mode: Specifies the type of data the bitmap should contain
>> +#     after the operation concludes.  Must be present if sync is
>> +#     "bitmap".  Must NOT be present otherwise.  (Since 9.0)
> 
> Members that must be present when and only when some enum member has a
> certain value should perhaps be in a union branch.  Perhaps the block
> maintainers have an opinion here.
> 

Sounds sensible to me. Considering also the next patches, in the end it
could be a union discriminated by the @sync which contains @bitmap and
@bitmap-mode when it's the 'bitmap' sync mode, @bitmap when it's the
'incremental' sync mode (@bitmap-sync mode needs to be 'on-success'
then, so there is no choice for the user) and which contains
@granularity for the other sync modes.

Best Regards,
Fiona


