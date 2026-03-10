Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85161EB1070
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyvF-0007nv-79; Tue, 10 Mar 2026 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzyvD-0007nl-QG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzyvA-0002f7-VF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773156175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Fzvf3v7hPgWIc8VdligtBDlOPc2L91UogibbjStJp0=;
 b=QBTFNsywBIhYNS0XLCErUQx2Llkfc+913MIKrxzVTRwCzXN6oHs2ZnP2NiznZ28P8uRya0
 A/+vqC014WoWW1N7QpFtCQ9OdRwMQJ9SWSrTv1hON6hh0fYumsBF8d7VQk2HGIPXRSEhzc
 dpX4fDU9PI8xdxjiKjVr2ySLR5RjI/0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-tppurs3JMD6bZb8d1E07Og-1; Tue,
 10 Mar 2026 11:22:52 -0400
X-MC-Unique: tppurs3JMD6bZb8d1E07Og-1
X-Mimecast-MFC-AGG-ID: tppurs3JMD6bZb8d1E07Og_1773156170
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6210C1956068; Tue, 10 Mar 2026 15:22:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05952180035F; Tue, 10 Mar 2026 15:22:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BD8421E681B; Tue, 10 Mar 2026 16:22:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  thuth@redhat.com,
 eblake@redhat.com,  farosas@suse.de,  peterx@redhat.com,
 zhao1.liu@intel.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,
 davydov-max@yandex-team.ru,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,  leiyang@redhat.com,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com
Subject: Re: [PATCH v12 3/8] qapi: add local migration parameter
In-Reply-To: <f3ac4e30-60ee-42f6-99a8-d43f8e4c3587@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 10 Mar 2026 18:06:59 +0300")
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
 <20260306213235.216863-4-vsementsov@yandex-team.ru>
 <87cy1biyeq.fsf@pond.sub.org>
 <f3ac4e30-60ee-42f6-99a8-d43f8e4c3587@yandex-team.ru>
Date: Tue, 10 Mar 2026 16:22:45 +0100
Message-ID: <87wlzjg14q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 10.03.26 16:53, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> We are going to implement local-migration feature: some devices will be
>>> able to transfer open file descriptors through migration stream (which
>>> must UNIX domain socket for that purpose).  This allows to transfer the
>>> whole backend state without reconnecting and restarting the backend
>>> service. For example, virtio-net will migrate its attached TAP netdev,
>>> together with its connected file descriptors.
>>>
>>> In this commit we introduce a migration parameter, which enables
>>> the feature for supporting devices (no one at the moment).
>> 
>> for devices that support it (none at the moment).
>> 
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> 
>> [...]
>> 
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index f925e5541bf..2c8d85f5834 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -828,7 +828,8 @@
>>>             'mode',
>>>             'zero-page-detection',
>>>             'direct-io',
>>> -           'cpr-exec-command'] }
>>> +           'cpr-exec-command',
>>> +           'local'] }
>>>  
>>>  ##
>>>  # @migrate-set-parameters:
>>> @@ -1004,6 +1005,15 @@
>>>  #     is @cpr-exec.  The first list element is the program's filename,
>>>  #     the remainder its arguments.  (Since 10.2)
>>>  #
>>> +# @local: Enable local migration feature for devices that support
>>> +#     it.  The feature is for local migration only and rely on the
>>> +#     channel support for passing file descriptors (it must be a UNIX
>>> +#     socket).  In general that means that backend state and its file
>>> +#     descriptors are passed to the destination in the migration
>>> +#     channel.  In general devices may have an option which in
>>> +#     conjunction with @local set to true enables the local-migration
>>> +#     feature for that device.  (Since 11.0)
>> 
>> This needs polish.  Let me try.
>> 
>>    # @local: Enable local migration for devices that support it.  Backend
>>    #     state and its file descriptors are then passed to the
>>    #     destination in the migration channel.  The migration channel
>>    #     must be a Unix domain socket.  Also needs to be enabled per
>>    #     device by setting device property "local" to true.
>
> As discussed in v11, we don't want to require neither concrete property name
> nor even the existence of such property, that why it was worded "may have an option".
>
> https://lore.kernel.org/qemu-devel/aZyS4UizvDq1Wnpq@x1.local/

Scratch "by setting ..." then, and maybe replace "also" by "usually".

[...]


