Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18854C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PAd-0008WJ-2O; Mon, 29 Apr 2024 07:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1PAb-0008W9-Dv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1PAY-0005QZ-QD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714390056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ea2DbaRK4pv78u6pvaUFQv2MS7lGi3f0LJRnRM8EvOA=;
 b=M4iuMF0PyMx1lDjIjRdr02LAC9Ajg28qNHdt8yF6sQbK9VKpufgI4ewXT9Dc4B0fpAmTWF
 F5qAfHBKMGTSJZuI//u2V/bZxv1TCGrYwKVNUogySiUjSJONTjaqRuCFU5KB1GR3XeScQU
 3NV8/WlFYSV9U8bLEmMgzzaAGM9Ipt8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-Zdu3eDfxPquIlX_preXyCg-1; Mon,
 29 Apr 2024 07:27:32 -0400
X-MC-Unique: Zdu3eDfxPquIlX_preXyCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B95829AB400;
 Mon, 29 Apr 2024 11:27:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F33962166B32;
 Mon, 29 Apr 2024 11:27:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B420421E66C8; Mon, 29 Apr 2024 13:27:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,  qemu-devel@nongnu.org,  BALATON Zoltan
 <balaton@eik.bme.hu>
Subject: Re: [PATCH v2] mc146818rtc: add a way to generate RTC interrupts
 via QMP
In-Reply-To: <8f93b3e3-dc20-4989-940c-20f87a7e3cfd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Apr 2024 11:51:07
 +0200")
References: <20240429094159.514096-1-d-tatianin@yandex-team.ru>
 <8f93b3e3-dc20-4989-940c-20f87a7e3cfd@linaro.org>
Date: Mon, 29 Apr 2024 13:27:27 +0200
Message-ID: <877cggjtnk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 29/4/24 11:41, Daniil Tatianin wrote:
>> This can be used to force-synchronize the time in guest after a long
>> stop-cont pause, which can be useful for serverless-type workload.
>> Also add a comment to highlight the fact that this (and one other QMP
>> command) only works for the MC146818 RTC controller.
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>> Changes since v0:
>> - Rename to rtc-inject-irq to match other similar API
>> - Add a comment to highlight that this only works for the I386 RTC
>> Changes since v1:
>> - Added a description below the QMP command to explain how it can be
>>    used and what it does.

[...]

>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index 4e0a6492a9..0f2479f8f4 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -19,6 +19,24 @@
>>   { 'command': 'rtc-reset-reinjection',
>>     'if': 'TARGET_I386' }
>> +##
>> +# @rtc-inject-irq:
>> +#
>> +# Inject an RTC interrupt. This command forces the guest to synchornize

synchronize

>> +# the time with RTC. This is useful after a long stop-cont pause, which
>> +# is common for serverless-type workload.

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

>> +#
>> +# Since: 9.1
>> +#
>> +# Example:
>> +#
>> +#     -> { "execute": "rtc-inject-irq" }
>> +#     <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'rtc-inject-irq',
>> +  'if': 'TARGET_I386' }
>
> Why is that restricted to x86? Ah, this is specific to the MC146818
> RTC... Other machines use hw accelerators and the MC146818, aren't
> we interested in synchronizing them the same way?
>
> Personally I'd name this command 'mc146818rtc-raise-irq-broadcast',
> KISS.

I might be wrong, but the *interface* looks general to me, only nobody
bothered to implement for the other RTCs.


