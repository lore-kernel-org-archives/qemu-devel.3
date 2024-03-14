Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DF4C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklNx-0004fQ-4l; Thu, 14 Mar 2024 09:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rklNu-0004ef-9s; Thu, 14 Mar 2024 09:44:38 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rklNp-0001n3-6p; Thu, 14 Mar 2024 09:44:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8825:0:640:5dd4:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 6521860B44;
 Thu, 14 Mar 2024 16:44:26 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b707::1:11] (unknown
 [2a02:6b8:b081:b707::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PioQpC0Vq8c0-5hZ8Nadk; Thu, 14 Mar 2024 16:44:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710423865;
 bh=uAIrrfZYngry/MSNzyMXh+UHTFBh+GO/KiL6JWNPBas=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=p4xVbrCYUJ+4+qkJ/H42ci56yVd5mH+AuXLMlPVfpBEieJ6bRaUrKmhniUmQJB1IL
 QuUV5VF2dI59bH07vsfSwIku49WmsAp0QAkoRrW7Eg8/T3dxGhcHOdq5OLG+Pe/Xtl
 CIsNNj32VWfNudvxK9ANHuo4nrj+wreVo0gjZGM8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c6dae943-cac6-4103-b345-49ff5bd0ae1c@yandex-team.ru>
Date: Thu, 14 Mar 2024 16:44:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, f.ebner@proxmox.com
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
 <20240313152822.626493-5-vsementsov@yandex-team.ru>
 <87o7bicdwv.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87o7bicdwv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 13.03.24 19:08, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add a parameter that enables discard-after-copy. That is mostly useful
>> in "push backup with fleecing" scheme, when source is snapshot-access
>> format driver node, based on copy-before-write filter snapshot-access
>> API:
>>
>> [guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
>>     |            |
>>     | root       | file
>>     v            v
>> [copy-before-write]
>>     |             |
>>     | file        | target
>>     v             v
>> [active disk]   [temp.img]
>>
>> In this case discard-after-copy does two things:
>>
>>   - discard data in temp.img to save disk space
>>   - avoid further copy-before-write operation in discarded area
>>
>> Note that we have to declare WRITE permission on source in
>> copy-before-write filter, for discard to work. Still we can't take it
>> unconditionally, as it will break normal backup from RO source. So, we
>> have to add a parameter and pass it thorough bdrv_open flags.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 
> [...]
> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 1874f880a8..2ef52ae9a7 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1610,6 +1610,9 @@
>>   #     node specified by @drive.  If this option is not given, a node
>>   #     name is autogenerated.  (Since: 4.2)
>>   #
>> +# @discard-source: Discard blocks on source which are already copied
> 
> "have been copied"?

Oh, right

> 
>> +#     to the target.  (Since 9.1)
>> +#
>>   # @x-perf: Performance options.  (Since 6.0)
>>   #
>>   # Features:
>> @@ -1631,6 +1634,7 @@
>>               '*on-target-error': 'BlockdevOnError',
>>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
>>               '*filter-node-name': 'str',
>> +            '*discard-source': 'bool',
>>               '*x-perf': { 'type': 'BackupPerf',
>>                            'features': [ 'unstable' ] } } }
> 
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir


