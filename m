Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816011062862
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Hme-0005YY-VX; Wed, 11 Mar 2026 07:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0HmW-0005S1-OE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:31:19 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0HmS-0005OI-TM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:31:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B17D080776;
 Wed, 11 Mar 2026 14:31:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2VE1l20ApSw0-SSFCHKCd; Wed, 11 Mar 2026 14:31:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773228663;
 bh=uXI5Rficp6QUvlo1dBBW5zwxdWLoVk/4dUrsHrwrEEg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=COmvsZgc0bj7jeVxVy7gs+on49s4J1Tunr4qIumPNvNe8FvcxpTlqdy53vTmfdo+B
 0t/NcvX/fWqBPK083XV25WPfYZQjramNxA+sKrvlnIIPP+rQxYXNhSSS96mrMUsgUw
 12mBHheNoha+VksvVvm6tZY5Fdr8Vh5wnTY4m62Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fc18734a-2933-465f-93d4-9db850f2e3c6@yandex-team.ru>
Date: Wed, 11 Mar 2026 14:31:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/8] net/tap: support local migration with virtio-net
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, thuth@redhat.com, eblake@redhat.com, 
 farosas@suse.de, peterx@redhat.com, zhao1.liu@intel.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
 <20260306213235.216863-7-vsementsov@yandex-team.ru>
 <87jyvjiypw.fsf@pond.sub.org>
 <3408f5b9-d0b8-4005-853c-119b2b429829@yandex-team.ru>
 <87bjgueme1.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87bjgueme1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11.03.26 12:38, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 10.03.26 16:46, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Support transferring of TAP state (including open fd) through
>>>> migration stream as part of viritio-net "local-migration".
>>>>
>>>> Add new option, incoming-fds, which should be set to true to
>>>> trigger new logic.
>>>>
>>>> For new option require explicitly unset script and downscript,
>>>> to keep possibility of implementing support for them in future.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> [...]
>>>
>>>> diff --git a/qapi/net.json b/qapi/net.json
>>>> index 118bd349651..79f5ce9f431 100644
>>>> --- a/qapi/net.json
>>>> +++ b/qapi/net.json
>>>> @@ -355,6 +355,9 @@
>>>>    # @poll-us: maximum number of microseconds that could be spent on busy
>>>>    #     polling for tap (since 2.7)
>>>>    #
>>>> +# @incoming-fds: do not open/connnect any resources, instead wait for
>>>> +#     TAP state from incoming migration stream.  (Since 11.0)
>>> "resources"?  The name @incoming-fds suggests this is about file
>>> descriptors...
>>
>> Hmm. But, I can't say "open any file descriptors"..
>>
>>
>>> "wait for TAP state from" does not make sense.  Do you mean "retrieve
>>> TAP state from"?
>>
>> Retrieve means actively do something, but I mean, that FDs will come in
>> future from incoming migration stream, and we just wait for it and "do nothing"
>> at the moment of net-tap initialization.
>>
>>
>> Let me try to reword:
>>
>> Do not open or create any TAP devices. Prepare for getting opened
>> TAP file descriptors from incoming migration stream.
> 
> Better, thanks!
> 
>>> Is any part of NetdevTapOptions ignored when @incoming-fds is true?
>>
>> Hmm yes. sndbuf, vnet_hdr and ifname. I should add this information here.
> 
> I dislike ignoring the user's instructions silently.  Can we make it an
> error?
> 

Agree, will do.

-- 
Best regards,
Vladimir

