Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A29CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 05:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uPV-00011A-9J; Wed, 15 Oct 2025 01:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8uPS-00010R-Jf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 01:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8uPM-0007Vv-N0
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 01:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760507438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doYfQ04zxKVDefG+tjuoJ5edIX9ZvZ5HtUkiz/HfXAs=;
 b=gFHYjD3ItJLRBPOPOaNqDbh9eDmxgMtE+o97DyNsBbJup8y5D68cL4V75rpIJvEiOto/p0
 aJn7lpOn62dgy/StzEChB4RjAjtA74QxOzv0wociQ1gOXNmO3sBkUzOe4KsJHTv1vhaydY
 LUpA3dvA+eQV1BK9N92gfIpdaejS37o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-pdZXh2k1OHqTGUKYh4e8Kg-1; Wed,
 15 Oct 2025 01:50:35 -0400
X-MC-Unique: pdZXh2k1OHqTGUKYh4e8Kg-1
X-Mimecast-MFC-AGG-ID: pdZXh2k1OHqTGUKYh4e8Kg_1760507433
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F4A118001D1; Wed, 15 Oct 2025 05:50:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D9F019560AD; Wed, 15 Oct 2025 05:50:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D03E721E6A27; Wed, 15 Oct 2025 07:50:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 sstabellini@kernel.org,  anthony@xenproject.org,  paul@xen.org,
 edgar.iglesias@gmail.com,  xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
In-Reply-To: <2cad2907-5a93-4630-856f-7237063eb3ce@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 14 Oct 2025 17:19:31
 +0200")
References: <20250729111226.3627499-1-armbru@redhat.com>
 <CAFEAcA-UrCD7mrmX_4dCK0urMmY5+qs=Y268WerQVq1c+7nB=Q@mail.gmail.com>
 <CAFEAcA-01WR=jgdiCY57P_88ez-mRw07ShU0eWyzLPB+WbT_xg@mail.gmail.com>
 <2cad2907-5a93-4630-856f-7237063eb3ce@linaro.org>
Date: Wed, 15 Oct 2025 07:50:29 +0200
Message-ID: <87y0pck922.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 14/10/25 14:59, Peter Maydell wrote:
>> On Tue, 14 Oct 2025 at 09:36, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>>
>>> On Tue, 29 Jul 2025 at 12:14, Markus Armbruster <armbru@redhat.com> wro=
te:
>>>>
>>>> xenfb_mouse_event() has a switch statement whose controlling
>>>> expression move->axis is an enum InputAxis.  The enum values are
>>>> INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
>>>> case for both axes.  In addition, it has an unreachable default label.
>>>> This convinces Coverity that move->axis can be greater than 1.  It
>>>> duly reports a buffer overrun when it is used to subscript an array
>>>> with two elements.
>>>
>>> I think also that Coverity gets confused by QAPI's convention
>>> in generated code of defining enumerations like this:
>>>
>>> typedef enum InputAxis {
>>>      INPUT_AXIS_X,
>>>      INPUT_AXIS_Y,
>>>      INPUT_AXIS__MAX,
>>> } InputAxis;
>>>
>>> Coverity thinks that INPUT_AXIS__MAX might be a valid
>>> value it can see in move->axis, because we defined the
>>> enum that way.
>>>
>>> In theory I suppose that since the __MAX value is only
>>> there to be an array or enumeration bound

Correct.

>>>                                           that we could
>>> emit code that #defines it rather than making it part
>>> of the enum.

I'd love that, but it's harder than it has any right to be; see the
message Philippe referred to below.

>> Also, there's an argument that this function should
>> ignore unknown input-axis enum values. If we ever in future
>> extend this to support a Z-axis, it would be better to
>> ignore the events we can't send, the same way we already
>> do for unknown INPUT_EVENT_KIND_BTN button types, rather
>> than aborting.

No objection.

>>                But it's not very important, so the
>> g_assert_not_reached() will do.
>>=20
>> (In some other languages, we'd get a compile failure for
>> adding a new value to the enum that we didn't handle.
>> But not in C :-))
>
> See this thread where it was discussed (until I gave up...):
> https://lore.kernel.org/qemu-devel/873564spze.fsf@pond.sub.org/


