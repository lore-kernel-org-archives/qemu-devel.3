Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BEFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjWyX-0007mB-K1; Tue, 14 Jul 2026 02:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjWyV-0007lp-Ng
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:50:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjWyT-00060y-F3
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:50:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 97CC7C0ACA;
 Tue, 14 Jul 2026 09:50:35 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id YoIEJa0WQ4Y0-KUhBhWqG; Tue, 14 Jul 2026 09:50:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784011835;
 bh=9qWdvgEbYEGYWTHPFF1DyIfPX2YkQj4hR6QYxVP+K8k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FIIlXkXOlvobmvYTc7nZBNTE9/slrW5OtGWW2Z6dvRh6y/blfiDA+8TBjbSD/hIwz
 +62eqnpLi0Wt86N0qr0gOQqs4mZH/UJVGPPY379aJRW8AhMrht93sT9APbgnVW9aiq
 kbRXcwUGGJOXMBgaDKetuoPPm7I8AeIw8EQPOSwU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <37a769c6-b70d-4452-bdbc-d37a7ebcc732@yandex-team.ru>
Date: Tue, 14 Jul 2026 09:50:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Eric Blake <eblake@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
 <alTKMA87h9x951Ei@redhat.com>
 <25b5e9a6-e563-4ab0-9075-04a3a00d3b33@yandex-team.ru>
 <alUwflog7Xd34Vd4@redhat.com> <20260713162057-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260713162057-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 13.07.26 23:22, Michael S. Tsirkin wrote:
> On Mon, Jul 13, 2026 at 07:37:50PM +0100, Daniel P. Berrangé wrote:
>> On Mon, Jul 13, 2026 at 08:55:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> On 13.07.26 14:21, Daniel P. Berrangé wrote:
>>>> On Mon, Jul 13, 2026 at 01:55:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> On 13.07.26 12:51, Daniel P. Berrangé wrote:
>>>>>> On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> We are going to implement local-migration feature: some devices will be
>>>>>>> able to transfer open file descriptors through migration stream (which
>>>>>>> must UNIX domain socket for that purpose).  This allows to transfer the
>>>>>>> whole backend state without reconnecting and restarting the backend
>>>>>>> service. For example, virtio-net will migrate its attached TAP netdev,
>>>>>>> together with its connected file descriptors.
>>>>>>>
>>>>>>> In this commit we introduce a migration parameter, which enables
>>>>>>> the feature for devices that support it (none at the moment).
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>>>> Reviewed-by: Ben Chaney <bchaney@akamai.com>
>>>>>>> ---
>>>>>>>     include/migration/misc.h |  2 ++
>>>>>>>     migration/options.c      | 18 +++++++++++++++++-
>>>>>>>     qapi/migration.json      | 12 ++++++++++--
>>>>>>>     3 files changed, 29 insertions(+), 3 deletions(-)
>>>>>>
>>>>>>
>>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>>> index 66bd900465a..03bdf19f3a6 100644
>>>>>>> --- a/qapi/migration.json
>>>>>>> +++ b/qapi/migration.json
>>>>>>> @@ -830,7 +830,8 @@
>>>>>>>                'zero-page-detection',
>>>>>>>                'direct-io',
>>>>>>>                { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>>>>>>> -           'cpr-exec-command'] }
>>>>>>> +           'cpr-exec-command',
>>>>>>> +           'local'] }
>>>>>>>     ##
>>>>>>>     # @migrate-set-parameters:
>>>>>>> @@ -1012,6 +1013,12 @@
>>>>>>>     #     Must be set to the same value on both source and destination
>>>>>>>     #     before migration starts.  (Since 11.1)
>>>>>>>     #
>>>>>>> +# @local: Enable local migration for devices that support it.  Backend
>>>>>>> +#     state and its file descriptors can then be passed to the
>>>>>>> +#     destination in the migration channel.  The migration channel
>>>>>>> +#     must be a Unix domain socket.  Usually needs to be enabled per
>>>>>>> +#     device.  (Since 11.2)
>>>>>>
>>>>>> What happens when this is enabled and there are devices which
>>>>>> don't support it ?
>>>>>
>>>>> These devices are migrated as usual, ignoring "local" option.
>>>>>
>>>>>>
>>>>>> What happens when this is enabled and a device on the src
>>>>>> does not support it but a device on the (newer) QEMU dest
>>>>>> does support it ?  How does the mgmt app know which devices
>>>>>> support it ?
>>>>>
>>>>> The only supporting device (TAP-backend) declares support by
>>>>> "local-migration-supported", so mgmt app should care to set
>>>>> same value for it on host and target (like for other options
>>>>> actually). Or simply relay on default, which is true starting
>>>>> from 11.2 Machine Type.
>>>>>
>>>>>>
>>>>>> Can we document the semantics in these cases.
>>>>>
>>>>> That's: "Usually needs to be enabled per device."
>>>>
>>>> ....except that we have it enabled by default for TAP backends
>>>> in new machine types.... except that it will then break if the
>>>> app/user has enabled any of the "forbidden" options.
>>>>
>>>> The way this doc is written makes it sound like "local" is an
>>>> optimization you can turn on in any scenario, and it will do
>>>> the right thing if the device supports it. That is very much
>>>> not the case - enabling this flag will definitely break many
>>>> configs out of the box, with new machine types due to the TAP
>>>> device defaults & incompatible options.
>>>
>>> Ok, now we decided to NOT make default support for TAP in newer
>>> machine types.
>>>
>>> So, enabling "local" is safe in existing scenarios, only explicit
>>> enabling TAP.local-migration-supported will change the behavior.
>>>
>>> Keep "local" documentation as is?
>>>
>>> I see the only way to make it more informative: directly describe
>>> connection with TAP.local-migration-supported, without general
>>> phrases about "devices that support" and "usual". We'll have to
>>> update it when more devices added (my next step is vhost-user-blk),
>>> but at least, it would be absolutely correct at the moment.
>>
>> How about....
>>
>>   # @local: Permit the use of optimizations for local migration.
>>   #     This must only be set when both the source and destination
>>   #     QEMU processes are on the same OS and directly connected
>>   #     with a UNIX domain socket as the migration channel to enable
>>   #     use of file descriptor passing. Individual device backends
>>   #     may need additional configuration flags set  to enable local
>>   #     migration optimizations. This will be documented against the
>>   #     device backends where it applies. (Since 11.2)
>>
> 
> BTW surely qemu can just detect this? getsockname maybe?
> 

Yes, but this doesn't guarantee that it's a direct connection by UNIX
socket to target, and it really can pass FDs. UNIX socket may be only
a first part of transfer channel to the remote target.

-- 
Best regards,
Vladimir

