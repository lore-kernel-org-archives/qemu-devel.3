Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D55E1093183
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3UgL-0005Xq-PG; Fri, 20 Mar 2026 03:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3UgJ-0005XH-Am
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3UgH-0005gZ-Fy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773993243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4B+tu9jbDyQXpklx1Jdq79ejng5F7HGDu14WuZ/5zxM=;
 b=ZX7vjvazSqoc925sN0e5D/+GgefJbLSE6jJMWKPfR31eL/Dqz3cpucJW9znIz1ngEbT6cE
 yeLIwfo6MXc2xAp2iTSJCiJ5IOUu0NgNlZ0xTSPrMEv5/+6Y4PN9AaUr2Jc9lTSP4AdOT1
 EcuzAN/LkfVUfok2G77U5HZgkioHJvk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-K3bpfZRQOumUttOjtABDGA-1; Fri,
 20 Mar 2026 03:54:00 -0400
X-MC-Unique: K3bpfZRQOumUttOjtABDGA-1
X-Mimecast-MFC-AGG-ID: K3bpfZRQOumUttOjtABDGA_1773993239
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D784D19560B5; Fri, 20 Mar 2026 07:53:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 936611800765; Fri, 20 Mar 2026 07:53:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34CAB21E6937; Fri, 20 Mar 2026 08:53:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Shannon Zhao
 <shannon.zhaosl@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,  Matt Ochs
 <mochs@nvidia.com>,  Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
In-Reply-To: <654cb406-93fd-4c20-8dec-d01fc7d245ee@nvidia.com> (Nathan Chen's
 message of "Thu, 19 Mar 2026 09:57:34 -0700")
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-8-nathanc@nvidia.com>
 <87pl5080zl.fsf@pond.sub.org>
 <654cb406-93fd-4c20-8dec-d01fc7d245ee@nvidia.com>
Date: Fri, 20 Mar 2026 08:53:56 +0100
Message-ID: <874imbj5rf.fsf@pond.sub.org>
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

Nathan Chen <nathanc@nvidia.com> writes:

> On 3/19/2026 5:20 AM, Markus Armbruster wrote:

[...]

>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 79018f8d66..c67819d6f2 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>>           error_setg(errp, "ssidsize auto mode is not supported");
>>>           return false;
>>>       }
>>> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>>> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
>>> +        return false;
>>> +    }
>>
>> So, OasMode values other than 44 and 48 are currently useless.  Correct?
>
> Yes, in an earlier version we had only implemented auto, 44, and 48 for OasMode, but we included the other OasMode values according to the SMMUv3 spec after receiving feedback to do so.

I'm not sure that's a good idea.  Not an objection, mind.  I'm just
giving you something to consider.

If we define exactly the values that work, query-qmp-schema can tell
management applications which values work.  Whether that's useful I
can't say.

It falls apart as soon as different devices implement different values.
Do we expect that to happen?

If we stick to defining all values, maybe rephrase the error message to
express it's an implementation restriction?  Entirely up to you.


