Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721E2CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHvK-0008C4-4B; Wed, 27 May 2026 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSHvI-0008BV-36
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:20:04 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSHvD-0006ta-PJ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:20:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5B33E81E4A;
 Wed, 27 May 2026 20:19:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:69::1:d] (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id rJdUx50XIuQ0-Qlt3aP8E; Wed, 27 May 2026 20:19:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779902393;
 bh=EXXotGhLP9fjMv8+8r/dYD3N1JU+OKPpYWDEiLMYvmM=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=A54sX2NoN7AAby60l6TamXZjT8S3pvW3q8T7ZZk9lzoK7q5FQIIg0TPNKkbmlQxbx
 zkkMosSr/ubct9D7Lb4JXFSJd9sjxz62hFWcDBn9yutcvpfeXkHo5tSj7wC+495EAg
 mTbOWktN/k2N7SXaTc2MOQr5ahSU7NuG0buBExug=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f84de0fe-8c93-4c3f-ad05-de40410b4697@yandex-team.ru>
Date: Wed, 27 May 2026 20:19:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
 <20260524050632-mutt-send-email-mst@kernel.org>
 <c34e9bba-0e98-4694-870f-5f92f34f1076@yandex-team.ru>
 <ahRgbmVKuonjprB2@x1.local>
 <62045016-a892-43b8-87b1-869ef8d8e9d7@yandex-team.ru>
 <a572dadb-6ea6-48f2-a77c-3a4531dbad49@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <a572dadb-6ea6-48f2-a77c-3a4531dbad49@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 27.05.26 14:35, Vladimir Sementsov-Ogievskiy wrote:
> On 26.05.26 14:23, Vladimir Sementsov-Ogievskiy wrote:
>> +
>> +type_init(tap_register_types)
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 82ddbb51cd7..029f5a4532c 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -429,9 +429,18 @@
> 
> a bit more context:
> 
>   # @incoming-fds: do not open or create any TAP devices.  Prepare for
> 
> 
>>   #     getting TAP file descriptors from incoming migration stream.
>>   #     The option is incompatible with any of @fd, @fds, @helper, @br,
>>   #     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
>> -#     @downscript be explicitly set to nothing (empty string or "no")
>> +#     @downscript be explicitly set to nothing (empty string or "no"),
>> +#     and requires also @local-migration to be set an "local"
>> +#     migration parameter be set as well.
>>   #     (Since 11.1)
>>   #
>> +# @local-migration: enable local migration for this TAP backend.
>> +#     When set, local migration is enabled/disabled by "local"
>> +#     migration parameter for this TAP backend.  When unset, "local"
>> +#     migration parameter is ignored for this TAP backend.
>> +#     (Since 11.1.  Defaults to true for MT >= 11.1,
>> +#     and to false for MT < 11.1)
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -451,7 +460,8 @@
>>       '*vhostforce': 'bool',
>>       '*queues':     'uint32',
>>       '*poll-us':    'uint32',
>> -    '*incoming-fds': 'bool' } }
>> +    '*incoming-fds': 'bool',
>> +    '*local-migration': 'bool' } }
> 
> 
> Having both "incoming-fds" and "local-migration" (or rename
> it to "support-local-migration") seems too much.
> 
> But, we can't simply drop "incoming-fds" and rely only on
> "local-migration", a this make logic a lot more complicated,
> as "local" migration parameter starts to "decide" how tap
> initialization works:
> 
> We have to postpone opening any files up to "pre-incoming"
> point, when all migration parameters are known, to decide:
> 
>    if "local-migration"=true and "local"=true - do not open
>       any files, wait for incoming FDs
> 
>    if "local-migration"=true and "local"-false - open files
> 
> In this picture, the fact that migration parameter influence
> device initialization - seems rather bad precedent, which is
> better to avoid.
> 
> On the other hand, with "incoming-fds" parameter, everything is
> explicit. We can simply detect and error-out incorrect
> combinations (like incoming-fds=true, but incoming migration
> started with local=false, etc.), but user is sure, that target
> QEMU process will not open any files with this parameter set.
> That's a safe way.
> 
> 
> Still, I have alternative idea:
> 
> Instead of combination "-incoming defer" + "incoming-fds=true",
> make a new "-incoming local".
> 
> "-incoming local" would be equal to "-incoming defer", but also
> implies local=true (i.e. starting incoming migration with
> local=false will simply fail).
> 
> This way, we know that local=True from the start of the process,
> and don't have to wait for some pre-incoming point to be sure
> in value of "local" parameter.
> 
> So, we simply check "local-migration == True  +  incoming == local"
> instead of "incoming-fds == True" in tap code, and we are done.
> 
> What do you think?
> 
> 

Hmm. Bad idea. It may have same problem if use commandline options
to create devices, as ordering of "-incoming local" and "-netdev"
may affect how tap device will be initialized. It can be solved (or,
maybe, it works as expected even now, if "-incoming" always handled
before "-netdev" options... But anyway that's much more shaky than
simple incoming-fds=True.

-- 
Best regards,
Vladimir

