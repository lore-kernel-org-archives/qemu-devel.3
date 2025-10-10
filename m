Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20ECCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76bZ-0006p9-2D; Fri, 10 Oct 2025 02:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v76bU-0006ny-Om; Fri, 10 Oct 2025 02:27:49 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v76bN-0004c6-My; Fri, 10 Oct 2025 02:27:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 35FC3C026C;
 Fri, 10 Oct 2025 09:27:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:116::1:20] (unknown
 [2a02:6bf:8080:116::1:20])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VREmPJ1FpKo0-gvTxG99z; Fri, 10 Oct 2025 09:27:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760077652;
 bh=n0/uYJUhvI2JIQEYXnrohyBewug3GRY7NeIQTJ7tt7A=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HS6x8F6uJU/AcP9MI4PfwASyv0DweFgzlmm5dDYonTGMyVXxWKFPXl45PAUE2f9VH
 93k7zP/qmEIsH6Ia7HWXhLO9mBKDPDISFBkxvL36k9rZYaOCuo8cUOekurYcMcL6bI
 Nc6hG5cCQPfzGvy6M9wfQSNE38FOsw8C93171iv8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <335e1969-f1ab-45b1-8d38-221f09cea8bf@yandex-team.ru>
Date: Fri, 10 Oct 2025 09:27:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/33] vhost-user-blk: support vhost backend migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-32-vsementsov@yandex-team.ru>
 <CAFubqFsL4O=zEbmCEQ9KtBYVOsFjf6tuaur+oU9=1+hRDrPtNw@mail.gmail.com>
 <800c806a-c44c-4c4b-827b-acd9eb4a0e53@yandex-team.ru>
 <CAFubqFv7M4tD14PaWWDg1+K70NLL+jN-Qjxkv=dFAQ9inOULmg@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFv7M4tD14PaWWDg1+K70NLL+jN-Qjxkv=dFAQ9inOULmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10.10.25 02:43, Raphael Norwitz wrote:
> On Thu, Oct 9, 2025 at 5:14 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 09.10.25 22:09, Raphael Norwitz wrote:
>>> A small question here but will review more thoroughly pending feedback
>>> on my overall comments.
>>>
>>
>> I really hope you didn't spent much time on these 28-31 patches :/
>>
> 
> I spent much more time on the cleanups :)
> 
>>> On Wed, Aug 13, 2025 at 12:53 PM Vladimir Sementsov-Ogievskiy
>>> <vsementsov@yandex-team.ru> wrote:
>>>>
>>
>> [..]
>>
>>>> --- a/migration/options.c
>>>> +++ b/migration/options.c
>>>> @@ -269,6 +269,13 @@ bool migrate_local_char_socket(void)
>>>>        return s->capabilities[MIGRATION_CAPABILITY_LOCAL_CHAR_SOCKET];
>>>>    }
>>>>
>>>> +bool migrate_local_vhost_user_blk(void)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +
>>>
>>> Where was MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK added/defined?
>>
>> It is generated by QAPI code generator.
>>
>> Exactly, it's defined by 'local-vhost-user-blk' member inside 'MigrationCapability':
>>
>> { 'enum': 'MigrationCapability',
>>     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>>
>>              ...
>>
>>              { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] } ] }
>>
>>
>> and after build, the generated code is in build/qapi/qapi-types-migration.h, as a enum:
>>
>> typedef enum MigrationCapability {
>>       MIGRATION_CAPABILITY_XBZRLE,
>>
>>       ,,,
>>
>>       MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK,
>>       MIGRATION_CAPABILITY__MAX,
>> } MigrationCapability;
>>
>>
>> In v2, I'll follow the interface of virtio-net series, look at
>>
>> https://patchew.org/QEMU/20250923100110.70862-1-vsementsov@yandex-team.ru/20250923100110.70862-17-vsementsov@yandex-team.ru/
>>
>> so, it would be migration parameter instead of capability, like
>>
>>       QMP migrate-set-parameters {... backend-transfer = ["vhost-user-blk"] }
>>
>> and to enable both vhost-user-blk and virtio-net-tap together:
>>
>>       QMP migrate-set-parameters {... backend-transfer = ["vhost-user-blk", "virtio-net-tap"] }
>>
> 
> Why do we need two separate migration parameters for vhost-user-blk
> and virtio-net-tap? Why not have a single parameter for virtio local
> migrations and, if it is set, all backends types which support local
> migration can advertise and take advantage of it?

As I describe in the commit message https://patchew.org/QEMU/20250923100110.70862-1-vsementsov@yandex-team.ru/20250923100110.70862-17-vsementsov@yandex-team.ru/ :


Why not simple boolean? To simplify migration to further versions,
when more devices will support backend-transfer migration.

Alternatively, we may add per-device option to disable backend-transfer
migration, but still:

1. It's more comfortable to set same capabilities/parameters on both
source and target QEMU, than care about each device.

2. To not break the design, that machine-type + device options +
migration capabilities and parameters are fully define the resulting
migration stream. We'll break this if add in future more
backend-transfer support in devices under same backend-transfer=true
parameter.


> 
>>>
>>>
>>>> +    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK];
>>>> +}
>>>> +
>>
>> [..]
>>
>>
>> --
>> Best regards,
>> Vladimir


-- 
Best regards,
Vladimir

