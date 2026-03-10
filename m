Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77362EB1070
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzIN-0007rp-J3; Tue, 10 Mar 2026 11:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vzzI8-0007q7-GV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:46:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vzzI5-0002Bt-7b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:46:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2F356C01BC;
 Tue, 10 Mar 2026 18:46:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VkHVpk1GO8c0-38Q992S2; Tue, 10 Mar 2026 18:46:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773157592;
 bh=icZnCzyL2MOyM4A61elfvxQBC6j2oBiYlLaEkDfIasM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Nkl5ScnpvzXlGKVtD/ujSh/5eB8SliWLK0ZY70x3FzpSt5wa0WY0wkFSqCPvM1omn
 FQPJSU9ASpW2VAc0FGjb2TlreQ7t8Y6gBF3QRy+4Ub6IIiYmTQDcdt5IHz6+soNwjw
 T7Qx4aeJTfVys3/zMl3LdPag0fKKFMmJAbX+v/nw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <76aff934-3740-4c95-9cd4-da458e7e29f7@yandex-team.ru>
Date: Tue, 10 Mar 2026 18:46:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/8] qapi: add local migration parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, thuth@redhat.com, eblake@redhat.com, 
 farosas@suse.de, peterx@redhat.com, zhao1.liu@intel.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
 <20260306213235.216863-4-vsementsov@yandex-team.ru>
 <87cy1biyeq.fsf@pond.sub.org>
 <f3ac4e30-60ee-42f6-99a8-d43f8e4c3587@yandex-team.ru>
 <87wlzjg14q.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87wlzjg14q.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10.03.26 18:22, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 10.03.26 16:53, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> We are going to implement local-migration feature: some devices will be
>>>> able to transfer open file descriptors through migration stream (which
>>>> must UNIX domain socket for that purpose).  This allows to transfer the
>>>> whole backend state without reconnecting and restarting the backend
>>>> service. For example, virtio-net will migrate its attached TAP netdev,
>>>> together with its connected file descriptors.
>>>>
>>>> In this commit we introduce a migration parameter, which enables
>>>> the feature for supporting devices (no one at the moment).
>>>
>>> for devices that support it (none at the moment).
>>>
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> [...]
>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index f925e5541bf..2c8d85f5834 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -828,7 +828,8 @@
>>>>              'mode',
>>>>              'zero-page-detection',
>>>>              'direct-io',
>>>> -           'cpr-exec-command'] }
>>>> +           'cpr-exec-command',
>>>> +           'local'] }
>>>>   
>>>>   ##
>>>>   # @migrate-set-parameters:
>>>> @@ -1004,6 +1005,15 @@
>>>>   #     is @cpr-exec.  The first list element is the program's filename,
>>>>   #     the remainder its arguments.  (Since 10.2)
>>>>   #
>>>> +# @local: Enable local migration feature for devices that support
>>>> +#     it.  The feature is for local migration only and rely on the
>>>> +#     channel support for passing file descriptors (it must be a UNIX
>>>> +#     socket).  In general that means that backend state and its file
>>>> +#     descriptors are passed to the destination in the migration
>>>> +#     channel.  In general devices may have an option which in
>>>> +#     conjunction with @local set to true enables the local-migration
>>>> +#     feature for that device.  (Since 11.0)
>>>
>>> This needs polish.  Let me try.
>>>
>>>     # @local: Enable local migration for devices that support it.  Backend
>>>     #     state and its file descriptors are then passed to the
>>>     #     destination in the migration channel.  The migration channel
>>>     #     must be a Unix domain socket.  Also needs to be enabled per
>>>     #     device by setting device property "local" to true.
>>
>> As discussed in v11, we don't want to require neither concrete property name
>> nor even the existence of such property, that why it was worded "may have an option".
>>
>> https://lore.kernel.org/qemu-devel/aZyS4UizvDq1Wnpq@x1.local/
> 
> Scratch "by setting ..." then, and maybe replace "also" by "usually".
> 

so,

   # @local: Enable local migration for devices that support it.  Backend
   #     state and its file descriptors are then passed to the
   #     destination in the migration channel.  The migration channel
   #     must be a Unix domain socket.  Usually needs to be enabled per
   #     device.


Sounds good to me. Will use it for v13, if no more comments.


-- 
Best regards,
Vladimir

