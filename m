Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1214310BA42B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w604f-0006HA-Jc; Fri, 27 Mar 2026 01:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w604O-0006GN-Fb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 01:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w604J-0000cc-C1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 01:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774590552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46efmYL6r9QtbAJfuZMORqJ5cHNVHDBj4owsKqAuSes=;
 b=iMwOxLCFaaAyUcct/i6LBeKQjXLx+QVVP2D/ZJ5FCIAFae5fJ21xz19T3EHcaiYToTGvJH
 rnTmd9sMifH2J5GbBGbokPEs+/ZZy6esbi5IxPPKZkI0p3EarJ0IdKRT5nUXHrj/0AP9rG
 +fQMDiA2cU1CbnAataBRBXuskX1Wruo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-h6ZSCUUjOOKI_XG-gtMGMA-1; Fri,
 27 Mar 2026 01:49:08 -0400
X-MC-Unique: h6ZSCUUjOOKI_XG-gtMGMA-1
X-Mimecast-MFC-AGG-ID: h6ZSCUUjOOKI_XG-gtMGMA_1774590547
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 554501800345; Fri, 27 Mar 2026 05:49:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C13E30001A1; Fri, 27 Mar 2026 05:49:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCBEB21E6937; Fri, 27 Mar 2026 06:49:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  mjrosato@linux.ibm.com,
 farman@linux.ibm.com,  pbonzini@redhat.com,  stefanha@redhat.com,
 fam@euphon.net,  eblake@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  dave@treblig.org,  sw@weilnetz.de
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
In-Reply-To: <738e8d90-b08f-4ded-bd8d-3155a665a725@linux.ibm.com> (JAEHOON
 KIM's message of "Thu, 26 Mar 2026 10:55:19 -0500")
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com>
 <87o6kckntx.fsf@pond.sub.org>
 <738e8d90-b08f-4ded-bd8d-3155a665a725@linux.ibm.com>
Date: Fri, 27 Mar 2026 06:49:02 +0100
Message-ID: <871ph5ddpt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

JAEHOON KIM <jhkim@linux.ibm.com> writes:

> On 3/25/2026 9:04 AM, Markus Armbruster wrote:
>> Jaehoon Kim <jhkim@linux.ibm.com> writes:
>>
>>> Introduce a configurable poll-weight parameter for adaptive polling
>>> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
>>> constant, allowing runtime control over how much the most recent
>>> event interval affects the next polling duration calculation.
>>>
>>> The poll-weight parameter uses a shift value where larger values
>>> decrease the weight of the current interval, enabling more gradual
>>> adjustments. When set to 0, a default value of 3 is used (meaning
>>> the current interval contributes approximately 1/8 to the weighted
>>> average).
>>>
>>> This patch also removes the hardcoded default values for poll-grow
>>> and poll-shrink parameters from the grow_polling_time() and
>>> shrink_polling_time() functions, as these defaults are now properly
>>> initialized in iothread.c during IOThread creation.
>>>
>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

[...]

>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c653248f85..feb80b6cfe 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -606,6 +606,11 @@
>>>  #     algorithm detects it is spending too long polling without
>>>  #     encountering events.  0 selects a default behaviour (default: 0)
>>>  #
>>> +# @poll-weight: the weight factor for adaptive polling.
>>> +#     Determines how much the current event interval contributes to
>>> +#     the next polling time calculation.  Valid values are 1 or
>>> +#     greater.  If set to 0, the default value of 3 is used.
>>
>> The commit message hints what the valid values mean, the doc comment
>> doesn't even that.  Do users need to know?
>>
>> Code [*] below uses it like time >> poll_weight, where @time is int64_t.
>> poll_weight > 63 is undefined behavior, which is a no-no.  Please reject
>> such values.  poll_weight =3D=3D 64 results in zero.  Is that useful?
>>
>> Missing: (default: 0) (since 11.1)
>
> I agree. I will update the doc comment to give users a practical hint,
> for example like this:
>
> # @poll-weight: the weight factor for adaptive polling.
> #=C2=A0 =C2=A0 =C2=A0Determines how much the most recent event interval a=
ffects
> #=C2=A0 =C2=A0 =C2=A0the next polling duration calculation.
> #=C2=A0 =C2=A0 =C2=A0If set to 0, the system default value of 3 is used.
> #=C2=A0 =C2=A0 =C2=A0Typical values: 1 (high weight on recent interval),
> #=C2=A0 =C2=A0 =C2=A02-4 (moderate weight on recent interval).
> #=C2=A0 =C2=A0 (default: 0) (since 11.1)

Better, thanks!

> I will also a check in the code so that values exceeding the maximum
> allowed will revert to the system default.

Don't silently "correct" invalid input, reject it!

[...]


