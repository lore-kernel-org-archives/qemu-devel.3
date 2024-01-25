Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39624C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT3Wc-0004Lu-4R; Thu, 25 Jan 2024 12:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rT3WY-0004K0-SW; Thu, 25 Jan 2024 12:28:22 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rT3WX-0005o1-4Q; Thu, 25 Jan 2024 12:28:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 04A6661E69;
 Thu, 25 Jan 2024 20:28:18 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b678::1:5] (unknown
 [2a02:6b8:b081:b678::1:5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HSYE9a1IkiE0-TyjSznMm; Thu, 25 Jan 2024 20:28:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1706203697;
 bh=L9IrCFHjo4klQXKJZ3uNYnl+eXqDWOTPWgVKozg/5VA=;
 h=In-Reply-To:Cc:References:To:From:Subject:Date:Message-ID;
 b=gUryWXbamadOC9QfIho01KWxXU4brPnomexozql6Sb1ACuyLSRiKLTNxZMlEE/AIX
 3+Hoz0NJKxRB1roQRz2AY3PRq8IArVT8Czva502TFDtSG4Tkb2tWaaowolpps6EWD2
 sV6izu0mf8SDHUtU4lOAZNSXz2ERhOHuBlcoaVlE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <823f29e0-46b4-40bc-8158-163b3ad828fe@yandex-team.ru>
Date: Thu, 25 Jan 2024 20:28:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
 <20240117160737.1057513-4-vsementsov@yandex-team.ru>
 <9479f045-1c09-41a6-b625-940b0ee723d5@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <9479f045-1c09-41a6-b625-940b0ee723d5@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19.01.24 17:46, Fiona Ebner wrote:
> Am 17.01.24 um 17:07 schrieb Vladimir Sementsov-Ogievskiy:
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
>> copy-before-write filter, for discard to work.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Unfortunately, setting BLK_PERM_WRITE unconditionally breaks
> blockdev-backup for a read-only node (even when not using discard-source):

Ohh, right.

So, that's the place when we have to somehow pass through discrard-souce option to CBW filter, so that it know that WRITE permission is needed. Will try in v3. Thanks again for testing!

> 
>> #!/bin/bash
>> ./qemu-img create /tmp/disk.raw -f raw 1G
>> ./qemu-img create /tmp/backup.raw -f raw 1G
>> ./qemu-system-x86_64 --qmp stdio \
>> --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw,read-only=true \
>> --blockdev raw,node-name=node1,file.driver=file,file.filename=/tmp/backup.raw \
>> <<EOF
>> {"execute": "qmp_capabilities"}
>> {"execute": "blockdev-backup", "arguments": { "device": "node0", "target": "node1", "sync": "full", "job-id": "backup0" } }
>> EOF
> 
> The above works before applying this patch, but leads to an error
> afterwards:
> 
>> {"error": {"class": "GenericError", "desc": "Block node is read-only"}}
> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


