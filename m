Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A00C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 12:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR8yh-0007k2-Lz; Mon, 16 Jun 2025 08:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uR8yb-0007h4-L5; Mon, 16 Jun 2025 08:30:15 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uR8yZ-0006Xq-9F; Mon, 16 Jun 2025 08:30:13 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0AD0745E28;
 Mon, 16 Jun 2025 14:29:57 +0200 (CEST)
Message-ID: <10336f91-fcb5-44bf-aebe-70ec5b274fd3@proxmox.com>
Date: Mon, 16 Jun 2025 14:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
To: Ilya Dryomov <idryomov@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Am 16.06.25 um 11:41 schrieb Daniel P. Berrangé:
> On Thu, May 15, 2025 at 01:29:07PM +0200, Fiona Ebner wrote:
>> @@ -4327,6 +4360,9 @@
>>  #     authentication.  This maps to Ceph configuration option "key".
>>  #     (Since 3.0)
>>  #
>> +# @key-value-pairs: Key-value pairs for additional Ceph configuraton.
>> +#     (Since 10.1)
>> +#
>>  # @server: Monitor host address and port.  This maps to the "mon_host"
>>  #     Ceph option.
>>  #
>> @@ -4342,6 +4378,7 @@
>>              '*user': 'str',
>>              '*auth-client-required': ['RbdAuthMode'],
>>              '*key-secret': 'str',
>> +            '*key-value-pairs' : 'RbdKeyValuePairs',
>
> I'm not seeing any point in this 'RbdKeyValuePairs' struct. Why isn't
> the 'rbd-cache-policy' field just directly part of the BlockdevOptionsRbd
> struct like all the other options are ?
>
> Also, 'rbd-' as a prefix in the field name is redundant when this is
> already in an RBD specific struct.

Am 16.06.25 um 11:25 schrieb Ilya Dryomov:
> Hi Fiona,
> 
> I'm not following the rationale for introducing RbdKeyValuePairs
> struct.  If there is a desire to expose rbd_cache_policy option this
> way, couldn't it just be added to BlockdevOptionsRbd struct?  The
> existing auth_client_required option has a very similar pattern.

Hi Ilya and Daniel,

my intention was to not "pollute" the top-level struct with rather
uncommon options, but collect them separately and also make it explicit
that those are the key-value pairs passed along to Ceph.

> If exposing rbd_cache_policy option, rbd_cache option (enabled/disabled
> bool) should likely be exposed as well.  It doesn't make much sense to
> provide a built-in way to adjust the cache policy without also providing
> a built-in way to disable the cache entirely.  Then the question of what
> would be better from the QAPI perspective arises: a bool option to map
> to Ceph as close as possible or perhaps an additional 'disabled' value
> in RbdCachePolicy enum?  And regardless of that, the need to remember
> to update QEMU if a new cache policy is ever added because even though
> these are just strings, QEMU is going to be validating them...

Good point! If going with the key-value-pairs approach, it would be
nicer to go with a direct mapping IMHO. If adding it to the top-level,
I'd be in favor of the 'disabled' value.

Best Regards,
Fiona


