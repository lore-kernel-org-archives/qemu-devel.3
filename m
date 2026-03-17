Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9210FFD706B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2RhC-0006P9-D4; Tue, 17 Mar 2026 06:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2RhA-0006Oc-G4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2Rh7-0001Lm-TG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773743436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8B2hBNlN6aQ1y+9Liz0R3CT0TaEdyYtuXOz3v4aa0U=;
 b=c6qxev0FhhMZGbi57Tp72Z4OLroSPTqB0O95X1diAZCXeKF//uZz28Vqv00d89PEOEQ0mM
 pQTFHwFmWYLcFrltw5lHgIoBNChqAzmu1CX2m3ADayGdqEzl96Y2qQpkcex3ADzO41NktA
 LXF+yA8T4JTs6xcPp1VwE1jasBzZ9Z4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-VA8S9s4DOzC6VEdf5S9oqw-1; Tue,
 17 Mar 2026 06:30:33 -0400
X-MC-Unique: VA8S9s4DOzC6VEdf5S9oqw-1
X-Mimecast-MFC-AGG-ID: VA8S9s4DOzC6VEdf5S9oqw_1773743432
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D53B195608E; Tue, 17 Mar 2026 10:30:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DC2330002DA; Tue, 17 Mar 2026 10:30:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 146C421E6937; Tue, 17 Mar 2026 11:30:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: -device T,help crashes
In-Reply-To: <20bd24c2-01a3-43a8-b8f2-9004b16ae114@redhat.com> (Thomas Huth's
 message of "Tue, 17 Mar 2026 10:37:50 +0100")
References: <87pl5abgpl.fsf@pond.sub.org> <87bjgtzcoa.fsf@pond.sub.org>
 <bd616907-9265-4ca2-83d3-d157d717c916@redhat.com>
 <87y0jqlxhx.fsf@pond.sub.org>
 <af46754d-5602-41ec-9971-b3a3e3591ba9@redhat.com>
 <87jyvakdpu.fsf@pond.sub.org>
 <20bd24c2-01a3-43a8-b8f2-9004b16ae114@redhat.com>
Date: Tue, 17 Mar 2026 11:30:29 +0100
Message-ID: <87ms06iw8q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Thomas Huth <thuth@redhat.com> writes:

> On 17/03/2026 10.27, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 17/03/2026 08.35, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> On 12/03/2026 09.15, Markus Armbruster wrote:
>>>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>> ...
>>>>>>> These crashes escape tests/qtest/device-introspect-test, because it
>>>>>>> covers only HMP "device_add T,help", not CLI "-device T,help".
>>>>>>
>>>>>> Anyone wants to cook up a patch to cover -device?
> ...
>>>> Another idea to conserve cycles: use a unit test instead.
>>>
>>> Unit tests don't have a way yet to determine which qemu-system-xyz binaries
>>> are available, do they? ... so that would need some more logic in the
>>> meson.build file there - not sure whether that's worth the effort, I think
>>> the device-introspect qtest is likely a better place?
>> 
>> A unit test isn't supposed to run qemu-system-xyz.  Instead, it mocks up
>> the environment and just runs "the unit".  In this case,
>> qdev_device_help().
>> 
>> This is less protection than a qtest, but it can also be a lot faster.
>
> Ok, fair, but how do you link the code for *all* the devices into that unit 
> test? ... I guess that would need a lot of function stubbing?

Likely too much, i.e. you're right.

>>> Or maybe add it to scripts/device-crash-test ?
>> 
>> That's another option.
>
> Maybe the best option, since it does already similar things. The only 
> disadvantage is that we don't run it for all targets by default in the CI.

Feels quite acceptable to me.

The existing qtest should catch most offenders, and all offenders
capable of murdering guests.  Letting a -device T,help bug slip through
our testing isn't the end of the world.


