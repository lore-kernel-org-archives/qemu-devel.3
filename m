Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26963D35157
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7qgB-00028s-Sw; Wed, 01 Apr 2026 04:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7qg6-00028a-7C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7qg3-0005Fs-4T
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775031108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuPA7WACLmMycg3RakcnPA99oMkiN1W2xhh4BQ6SBFM=;
 b=Y3pI73j3wov2NLNjNrg7bgAYKk17Q+BCB4lviLM4+7fL9kF7NZy7rplO3hqZYV/nlYWFAm
 pp9vHGRfJiOl4rzAqDOiYUm2voTd2CtMHOl9xQOk4nrOz46GRDcOSgmIHRYpmCfFne2pa8
 9mxRNbvlCJ6xHNSqUUIG17PGWzIztcw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-wzs2cX9yPJKFokKm0NKtFA-1; Wed,
 01 Apr 2026 04:11:44 -0400
X-MC-Unique: wzs2cX9yPJKFokKm0NKtFA-1
X-Mimecast-MFC-AGG-ID: wzs2cX9yPJKFokKm0NKtFA_1775031102
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F2B318002E5; Wed,  1 Apr 2026 08:11:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BF1119560AB; Wed,  1 Apr 2026 08:11:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0609D21E6A28; Wed, 01 Apr 2026 10:11:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Sergei Heifetz" <heifetz@yandex-team.com>
Cc: <qemu-devel@nongnu.org>,  "Eric Blake" <eblake@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Marcel
 Apfelbaum"
 <marcel.apfelbaum@gmail.com>,  "Paolo Bonzini" <pbonzini@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "Eduardo Habkost" <eduardo@habkost.net>,
 "Yanan Wang" <wangyanan55@huawei.com>,  "Zhao Liu" <zhao1.liu@intel.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  "Thomas Huth" <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Laurent Vivier"
 <lvivier@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>
Subject: Re: [PATCH v3 09/11] audio: do not build audio-related sources with
 --disable-audio
In-Reply-To: <DHHJ37V0JNBW.JENSG5ZXL7Z1@yandex-team.com> (Sergei Heifetz's
 message of "Wed, 01 Apr 2026 09:20:15 +0500")
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-10-heifetz@yandex-team.com>
 <87fr5wcj14.fsf@pond.sub.org>
 <DHHJ37V0JNBW.JENSG5ZXL7Z1@yandex-team.com>
Date: Wed, 01 Apr 2026 10:11:36 +0200
Message-ID: <874ilv3xs7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

"Sergei Heifetz" <heifetz@yandex-team.com> writes:

> On Thu Mar 19, 2026 at 1:36 PM +05, Markus Armbruster wrote:
>> [...]
>>> index 2df87b97101..28fda7c8ac3 100644
>>> --- a/qapi/audio.json
>>> +++ b/qapi/audio.json
>>> @@ -540,4 +540,5 @@
>>>  # Since: 8.0
>>>  ##
>>>  { 'command': 'query-audiodevs',
>>> -  'returns': ['Audiodev'] }
>>> +  'returns': ['Audiodev'],
>>> +  'if': 'CONFIG_AUDIO' }
>>
>> Could we disable all the audio stuff here?
>>
>> I tried, patch appended.  What do you think?
>
> For some reason, I thought it was undesirable to alter the header files.
> That's what I had in mind while working on the series.
>
> In particular, when you previously suggested emptying out audio.json,
> I used that idea to find other parts of the source code we can compile
> out, but I thought that was it, and that there is no real reason to
> actually remove the QAPI definitions.
>
> I don't have any strong arguments against it. If we are okay with
> changing the headers, what you suggest makes perfect sense.

We'd add a bunch of #if defined(CONFIG_AUDIO) to generated
qapi-*-audio.h.

If these were handwritten, would we do the same?

I figure we would, because that way we get compile errors instead of
link errors.  Likely one big #ifdef to guard everything but #include.

>>> [...]
>>>
>>> +#include "qemu/osdep.h"
>>> +#include "system/replay.h"
>>> +
>>> +void replay_audio_in_start(size_t *nsamples)
>>> +{
>>> +}
>>> +void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
>>> +{
>>> +}
>>> +void replay_audio_in_finish(void)
>>> +{
>>> +}
>>> +void replay_audio_out(size_t *played)
>>> +{
>>> +}
>>
>> Should this go into stubs/ instead?  Genuine question!  I can't tell
>> when we use stubs/foo*.c and when we use foo/*stub.c.
>
> I don't think we should move this to stubs/ unless we also move 
> replay/stubs-system.c there. I put the new file in replay/ because 
> that's where these stubs originally came from.
>
> Also, here is a quote from stubs/meson.build: 'If possible, add new
> files to other directories, by using "if_false"'.

Alright, I learned something :)

>> [...]
>
> P.S. Thank you for the review and for your suggestions. I'm really
> grateful for them. I'm still interested in working on this, and I'm very
> sorry it took so long to respond. 

No worries!


