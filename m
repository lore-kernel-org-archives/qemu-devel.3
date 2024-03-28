Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0639C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnFM-0006LO-3m; Thu, 28 Mar 2024 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rpnFI-0006Kp-UY; Thu, 28 Mar 2024 06:44:33 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rpnFD-0003GR-Jm; Thu, 28 Mar 2024 06:44:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 62A4960C9E;
 Thu, 28 Mar 2024 13:44:22 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LiKcnf3IiiE0-0s79kjbA; Thu, 28 Mar 2024 13:44:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711622661;
 bh=apzPpXM81NASxhAsVCTg9AX3TQNXLLylf7rn9Oqbm7g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pEa8/4TyXdzfea/W3KqoD5V2JM52RrZddI1jH0xJaDePUrtv0cz6D7Gi5BcIFTDt0
 uJ7Fg2WqkGB+YY4IQDcsknnOSJ9abYXe9HSBmOBX3v2Z/vHqnBE0hfU5yH5q/6v2QT
 afyCHGIBPjlr/xjuiy46sKnUxCD6ZOvcJal95/WU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <683eaa8b-8a11-4af7-9bdf-f8c0bcf8b49b@yandex-team.ru>
Date: Thu, 28 Mar 2024 13:44:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/15] scripts/qapi: support type-based unions
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, michael.roth@amd.com, pbonzini@redhat.com,
 pkrempa@redhat.com, f.ebner@proxmox.com
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
 <20240313150907.623462-2-vsementsov@yandex-team.ru>
 <87frwaemyc.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87frwaemyc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28.03.24 12:15, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Look at block-job-change command: we have to specify both 'id' to chose
>> the job to operate on and 'type' for QAPI union be parsed. But for user
>> this looks redundant: when we specify 'id', QEMU should be able to get
>> corresponding job's type.
>>
>> This commit brings such a possibility: just specify some Enum type as
>> 'discriminator', and define a function somewhere with prototype
>>
>> bool YourUnionType_mapper(YourUnionType *, EnumType *out, Error **errp)
>>
>> Further commits will use this functionality to upgrade block-job-change
>> interface and introduce some new interfaces.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   scripts/qapi/introspect.py |  5 +++-
>>   scripts/qapi/schema.py     | 50 +++++++++++++++++++++++---------------
>>   scripts/qapi/types.py      |  3 ++-
>>   scripts/qapi/visit.py      | 43 ++++++++++++++++++++++++++------
>>   4 files changed, 73 insertions(+), 28 deletions(-)
> 
> I believe you need to update docs/devel/qapi-code-gen.rst.
> 
> Current text:
> 
>      Union types
>      -----------
> 
>      Syntax::
> 
>          UNION = { 'union': STRING,
>                    'base': ( MEMBERS | STRING ),
>                    'discriminator': STRING,
>                    'data': BRANCHES,
>                    '*if': COND,
>                    '*features': FEATURES }
>          BRANCHES = { BRANCH, ... }
>          BRANCH = STRING : TYPE-REF
>                 | STRING : { 'type': TYPE-REF, '*if': COND }
> 
>      Member 'union' names the union type.
> 
>      The 'base' member defines the common members.  If it is a MEMBERS_
>      object, it defines common members just like a struct type's 'data'
>      member defines struct type members.  If it is a STRING, it names a
>      struct type whose members are the common members.
> 
>      Member 'discriminator' must name a non-optional enum-typed member of
>      the base struct.  That member's value selects a branch by its name.
>      If no such branch exists, an empty branch is assumed.
> 
> If I understand your commit message correctly, this paragraph is no
> longer true.


Right. Like this:

Member 'discriminator' must name either a non-optional enum-typed member, or an enum type name. (and more description follow, about user defined function and so on).


Do you think that mixing member name and type name here is OK? Or should I instead add another field 'discriminator-type', so that exactly one of 'discriminator' and 'discriminator-type' should be in union definition?


> 
>      Each BRANCH of the 'data' object defines a branch of the union.  A
>      union must have at least one branch.
> 
>      The BRANCH's STRING name is the branch name.  It must be a value of
>      the discriminator enum type.
> 
>      The BRANCH's value defines the branch's properties, in particular its
>      type.  The type must a struct type.  The form TYPE-REF_ is shorthand
>      for :code:`{ 'type': TYPE-REF }`.
> 
>      In the Client JSON Protocol, a union is represented by an object with
>      the common members (from the base type) and the selected branch's
>      members.  The two sets of member names must be disjoint.
> 
>      Example::
> 
>       { 'enum': 'BlockdevDriver', 'data': [ 'file', 'qcow2' ] }
>       { 'union': 'BlockdevOptions',
>         'base': { 'driver': 'BlockdevDriver', '*read-only': 'bool' },
>         'discriminator': 'driver',
>         'data': { 'file': 'BlockdevOptionsFile',
>                   'qcow2': 'BlockdevOptionsQcow2' } }
> 
>      Resulting in these JSON objects::
> 
>       { "driver": "file", "read-only": true,
>         "filename": "/some/place/my-image" }
>       { "driver": "qcow2", "read-only": false,
>         "backing": "/some/place/my-image", "lazy-refcounts": true }
> 
>      The order of branches need not match the order of the enum values.
>      The branches need not cover all possible enum values.  In the
>      resulting generated C data types, a union is represented as a struct
>      with the base members in QAPI schema order, and then a union of
>      structures for each branch of the struct.
> 
>      The optional 'if' member specifies a conditional.  See `Configuring
>      the schema`_ below for more on this.
> 
>      The optional 'features' member specifies features.  See Features_
>      below for more on this.
> 

-- 
Best regards,
Vladimir


