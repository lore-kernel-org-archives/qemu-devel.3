Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F3104951B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0G1u-0000NP-FR; Wed, 11 Mar 2026 05:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0G1s-0000N0-6d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0G1q-00042G-J2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773221936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GPENB8X/GGkKQtJ22NqgJPvhCO6a4eylY2lA9lTt7Ss=;
 b=TWSspABVI+d6mBbY61S+zDySuVlwkGfDfebOGeyPSb7Wllm8ommpG5b2TztOmMc6Q31j2O
 i5z7CafwlkIGNJKM47zhSq+hYlrK/u5Eezr/anjZTyEqcTiQ57U+043XEupXJAMp79wUYJ
 og8SN9iDtfZDMEknHDYJlAfRx14Any0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-J-UK2zjWNdO_7Ak6hbKVkA-1; Wed,
 11 Mar 2026 05:38:52 -0400
X-MC-Unique: J-UK2zjWNdO_7Ak6hbKVkA-1
X-Mimecast-MFC-AGG-ID: J-UK2zjWNdO_7Ak6hbKVkA_1773221931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79FCA18005BE; Wed, 11 Mar 2026 09:38:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3380418001FE; Wed, 11 Mar 2026 09:38:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D079021E681E; Wed, 11 Mar 2026 10:38:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  thuth@redhat.com,
 eblake@redhat.com,  farosas@suse.de,  peterx@redhat.com,
 zhao1.liu@intel.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,
 davydov-max@yandex-team.ru,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,  leiyang@redhat.com,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com
Subject: Re: [PATCH v12 6/8] net/tap: support local migration with virtio-net
In-Reply-To: <3408f5b9-d0b8-4005-853c-119b2b429829@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 10 Mar 2026 18:42:53 +0300")
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
 <20260306213235.216863-7-vsementsov@yandex-team.ru>
 <87jyvjiypw.fsf@pond.sub.org>
 <3408f5b9-d0b8-4005-853c-119b2b429829@yandex-team.ru>
Date: Wed, 11 Mar 2026 10:38:46 +0100
Message-ID: <87bjgueme1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 10.03.26 16:46, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Support transferring of TAP state (including open fd) through
>>> migration stream as part of viritio-net "local-migration".
>>>
>>> Add new option, incoming-fds, which should be set to true to
>>> trigger new logic.
>>>
>>> For new option require explicitly unset script and downscript,
>>> to keep possibility of implementing support for them in future.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> [...]
>> 
>>> diff --git a/qapi/net.json b/qapi/net.json
>>> index 118bd349651..79f5ce9f431 100644
>>> --- a/qapi/net.json
>>> +++ b/qapi/net.json
>>> @@ -355,6 +355,9 @@
>>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>>   #     polling for tap (since 2.7)
>>>   #
>>> +# @incoming-fds: do not open/connnect any resources, instead wait for
>>> +#     TAP state from incoming migration stream.  (Since 11.0)
>> "resources"?  The name @incoming-fds suggests this is about file
>> descriptors...
>
> Hmm. But, I can't say "open any file descriptors"..
>
>
>> "wait for TAP state from" does not make sense.  Do you mean "retrieve
>> TAP state from"?
>
> Retrieve means actively do something, but I mean, that FDs will come in
> future from incoming migration stream, and we just wait for it and "do nothing"
> at the moment of net-tap initialization.
>
>
> Let me try to reword:
>
> Do not open or create any TAP devices. Prepare for getting opened
> TAP file descriptors from incoming migration stream.

Better, thanks!

>> Is any part of NetdevTapOptions ignored when @incoming-fds is true?
>
> Hmm yes. sndbuf, vnet_hdr and ifname. I should add this information here.

I dislike ignoring the user's instructions silently.  Can we make it an
error?

[...]


