Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA49E9128E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuNS-0000bU-GJ; Thu, 05 Feb 2026 03:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnuNQ-0000Wp-7y
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:06:12 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnuNN-0002Fk-I0
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:06:12 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 77833C0265;
 Thu, 05 Feb 2026 11:06:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 36lPS10AxW20-kqOEEzOC; Thu, 05 Feb 2026 11:06:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770278764;
 bh=sdQR/z8xeeHoF3dVyJIJcSh0UmGAzjk/4mur7Cj8m10=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zuCUsPxzIcuxOQE9pjqoCZMnQz1Na/hsR6iRNYlnYWaz4Rog23AhX0JciYA7pcyqE
 VQh80CaoGObemIuraWG3NqRDotSNKCf5DNTiMVVU0H5riC9GO2UMuUpz/kRhTMtN7f
 iodjrS/HGHjwDZ2AkstHLEQzB9UBIGWHRBqkwEhQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f83e7888-8159-4522-a40d-352ed0a81be3@yandex-team.ru>
Date: Thu, 5 Feb 2026 11:06:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, thuth@redhat.com, eblake@redhat.com, farosas@suse.de,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, davydov-max@yandex-team.ru,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-4-vsementsov@yandex-team.ru>
 <aYOAAfzZQ3PeKf4q@x1.local> <87ecmzu0qx.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ecmzu0qx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05.02.26 10:07, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Sun, Feb 01, 2026 at 07:19:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>   # @migrate-set-parameters:
>>> @@ -1004,6 +1005,13 @@
>>>   #     is @cpr-exec.  The first list element is the program's filename,
>>>   #     the remainder its arguments.  (Since 10.2)
>>>   #
>>> +# @backend-transfer: Enable backend-transfer feature for devices that
>>> +#     supports it.  In general that means that backend state and its
>>> +#     file descriptors are passed to the destination in the migraton
>>> +#     channel (which must be a UNIX socket).  Individual devices
>>> +#     declare the support for backend-transfer by per-device
>>> +#     backend-transfer option.  (Since 11.0)
>>
>> I still think it'll be nice to either have "local" in the name of parameter
>> or at least document it with crystal clear terms.
>>
>> I used to suggest fd-passing, but maybe you wanted to emphasize there's
>> more than fds to be migrated at least for tap?

For vhost-user-blk it's the same: not only FDs.

>> Then it can still be
>> "local-backend-transfer", because nobody stops a device to transfer backend
>> states in a remote migration either.. so "backend-transfer" seems to also
>> work for remote migrations, but it is not.

Hmm. I imagine a mechanism, where OS supports passing FDs to another host.
This needs support for actually migrating the corresponding kernel object
by OS automatically. But theoretically I think it can be done transparently
for userspace QEMU process, which will simply pass FDs to the some special
socket, similar to UNIX domain socket.

So, the key aspect is that we should be able to pass FDs to the migration
channel, which currently meant that it must be UNIX domain socket, and it
must be local migration. But in future it may change.

And yes, "backend-transfer" work for remote migration of backend.
If we ever implement remote backend migration, why not to
reuse "backend-transfer" for it? Even if there will not be transparent
support from OS, and we'll implement another mechanics, we may add
new parameter


    backend-transfer-mechanism = "scm-rights" | "something-other"

(or we can put this into "backend-transfer", supporting passing string to
it and deprecating boolean)

More over, this future "remote-backend-transfer" could be used for local
migration, so again, it should be called simply "backend-transfer"..

>>
>> Or at least mentioned explicitly in the comment, saying this is a local
>> migration / upgrade.
> 
> Documenting the restriction is a must regardless of naming.  The
> proposed text does document it, but only indirectly: "(which must be a
> UNIX socket)".  Could be improved, I guess.
> 
> Capturing the restriction in the name might help.  But it also makes the
> name longer.  Feels like a matter of taste to me.  You guys decide :)
> 
>> If you could at least update the doc on the locality attribute for the
>> migration (one way or another..), feel free to take:
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>>
>> If you decide to rename, that's even better.
>>
>> Thanks,
> 

I'm OK with any name, but if you agree with my arguments above, I'd keep
"backend-transfer" name, and update the spec:

   @backend-transfer: Enable backend-transfer feature for devices that
       support it.  In general that means that backend state and its
       file descriptors are passed to the destination in the migraton
       channel.  Individual devices declare the support for
       backend-transfer by per-device backend-transfer option.
       SCM_RIGHT mechanism used to pass FDs, so backend-transfer
       requires migration to be local and the channel to be UNIX domain
       socket.  (Since 11.0)


-- 
Best regards,
Vladimir

