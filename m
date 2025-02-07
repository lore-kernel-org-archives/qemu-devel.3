Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5837EC02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 12:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNGc-0004qX-VI; Fri, 07 Feb 2025 07:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgNGU-0004oh-Jz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgNGR-0007AB-Sq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738930517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y/CaYrFtOfYhyhA+xoYXbMIxEz05ffcLKkPYphZiKf8=;
 b=NOIFAtFDrciMBCwnUAA/QN2xvNMGN5E96KZEtNqPqyZ4GXMNyKGfP8a8OMbnci5Mpmemuq
 D6vAMEGbNEcx0qWmbcSOfbD92zFZdY6mRjgGHJqpS8WLBjJCfWMLzBGWoUOpLrCFSaoQlk
 gstzV7qUw1dm28ILzjRdRO1oypGKG40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-nYq2juOSOy-SYk0AZQlf0A-1; Fri,
 07 Feb 2025 07:15:10 -0500
X-MC-Unique: nYq2juOSOy-SYk0AZQlf0A-1
X-Mimecast-MFC-AGG-ID: nYq2juOSOy-SYk0AZQlf0A
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17F921800873; Fri,  7 Feb 2025 12:15:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756B21800352; Fri,  7 Feb 2025 12:15:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC9E121E6A28; Fri, 07 Feb 2025 13:15:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Jason Wang
 <jasowang@redhat.com>,  Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Luigi Rizzo <rizzo@iet.unipi.it>,  Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>,  Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Michael Roth <michael.roth@amd.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Lei Yang <leiyang@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
In-Reply-To: <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu> (BALATON
 Zoltan's message of "Thu, 6 Feb 2025 14:23:39 +0100 (CET)")
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
 <87cyfwxveo.fsf@pond.sub.org>
 <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
 <87r04bs8sj.fsf@pond.sub.org>
 <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
 <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu>
Date: Fri, 07 Feb 2025 13:15:02 +0100
Message-ID: <87o6zehry1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 6 Feb 2025, Akihiko Odaki wrote:
>> On 2025/02/06 18:48, Markus Armbruster wrote:
>>>>                                              This problem can be solved
>>>> using an existing mechanism, OnOffAuto, which differentiates the "auto"
>>>> state and explicit the "on" state.
>>>
>>> I guess you're proposing something like this:
>>>
>>> * auto: on if possible, else off
>>>
>>> * on: on if possible, else error
>>>
>>> * off: off (always possible)
>>>
>>> Which one is the default?
>>
>> I converted on to auto and off to false in a following patch.
>>
>>>> However, converting bool to OnOffAuto surfaces another problem: they
>>>> disagree how "on" and "off" should be written. Please note that the
>>>> disagreement already exists and so it is nice to solve anyway.
>>> 
>>> Yes, converting bool to OnOffAuto is an incompatible change.
>>
>> Not just about conversion, but this inconsistency require users to know whether a property is bool or OnOffAuto and change how the values are written in JSON accordingly. This somewhat hurts usability.
>
> Worse than that, the help text is also confusing.
> Excerpt from -device virtio-gpu,help
>
>   blob=<bool>            - on/off (default: false)
>   busnr=<busnr>
>   disable-legacy=<OnOffAuto> - on/off/auto (default: "auto")
>   disable-modern=<bool>  -  (default: false)
>   edid=<bool>            - on/off (default: true)
>   event_idx=<bool>       - on/off (default: true)
>
> For bools it says on/off yet expects true/false. Wasn't originally true/on/1 and false/off/0 accepted for bools? Where that got lost? I think getting back that behaviour would be easiest for users. Users don't care if OnOffAuto is an enum internally and can't (or don't want to) remember if bools are written on/off or true/false so accepting these as synonyms would help users.

The help text printed by -device is about usage of -device, not about
QMP.

There, the preferred syntax for bool values is on/off, but
yes/true/y/no/false/n are also accepted.  I think that's a disgusting
mess, but it's here to stay, so let's not argue this any further.

Instead of "(default: true)" we should have "(default: on)".

All of this is a digression from the topic at hand, which is QMP.


