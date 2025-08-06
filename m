Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA9C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 10:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujbJ5-0006HY-Fi; Wed, 06 Aug 2025 06:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujbIv-0006FS-NP
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 06:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujbIt-00044b-Vf
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 06:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754475807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJ+zJ/yZ5yKJT/1RqpkTJyRojwEgcT0Z65kF8AQNcjU=;
 b=FU5+sIaja2hahwBHpWsOQjymGhSsDetW2G1a9d/cQbpT2jJd3HtoEjfjtombXOn/Z0R2Ii
 UNi1wn9e1bpsElZwW1v/Ni57Kmj22dRNuEDM1g4mSjZr7cnUvQ2RwqIZJ/FWq9gAD9DdI/
 GASik9oFWRrRtqqbHB++sGmvnEysmIw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-TvKlYAeHNIaH5HMsqnyUaQ-1; Wed,
 06 Aug 2025 06:23:21 -0400
X-MC-Unique: TvKlYAeHNIaH5HMsqnyUaQ-1
X-Mimecast-MFC-AGG-ID: TvKlYAeHNIaH5HMsqnyUaQ_1754475800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90F7F180036E; Wed,  6 Aug 2025 10:23:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA02A180035C; Wed,  6 Aug 2025 10:23:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C85FB21E6A27; Wed, 06 Aug 2025 12:23:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: shiju.jose--- via <qemu-devel@nongnu.org>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  "fan.ni@samsung.com" <fan.ni@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,  Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
 media event record
In-Reply-To: <13bd805817af44268da6ab63513045dd@huawei.com> (Shiju Jose's
 message of "Wed, 6 Aug 2025 09:21:19 +0000")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
 <20250721172228.2118-3-shiju.jose@huawei.com>
 <87ms8cq3ug.fsf@pond.sub.org>
 <13bd805817af44268da6ab63513045dd@huawei.com>
Date: Wed, 06 Aug 2025 12:23:15 +0200
Message-ID: <87h5ykn3zg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Shiju Jose <shiju.jose@huawei.com> writes:

>>-----Original Message-----
>>From: Markus Armbruster <armbru@redhat.com>
>>Sent: 06 August 2025 08:58
>>To: shiju.jose--- via <qemu-devel@nongnu.org>
>>Cc: linux-cxl@vger.kernel.org; Jonathan Cameron
>><jonathan.cameron@huawei.com>; fan.ni@samsung.com; dave@stgolabs.net;
>>Shiju Jose <shiju.jose@huawei.com>; Linuxarm <linuxarm@huawei.com>
>>Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
>>media event record
>>
>>shiju.jose--- via <qemu-devel@nongnu.org> writes:
>>
>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>
>>> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
>>> table has updated with following new fields.
>>> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
>>> 2. Corrected Memory Error Count at Event 3. Memory Event Sub-Type 4.
>>> Support for component ID in the PLDM format.
>>>
>>> Add updates for the above spec changes in the CXL general media event
>>> reporting and QMP command to inject general media event.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>
>>[...]
>>
>>> diff --git a/qapi/cxl.json b/qapi/cxl.json index
>>> c1fe8319c8..e8060d16f7 100644
>>> --- a/qapi/cxl.json
>>> +++ b/qapi/cxl.json
>>> @@ -82,6 +82,19 @@
>>>  # @component-id: Device specific component identifier for the event.
>>>  #     May describe a field replaceable sub-component of the device.
>>>  #
>>> +# @is-comp-id-pldm: Flag represents device specific component identifier
>>> +#     format is PLDM or not.
>>
>>Awkward phrasing.  Before I can suggest a better one, I have a question.
>>The type is uint8, which isn't a flag.  What are the possible values?
> Thanks Markus for the comments.

You're welcome!

> 'is-comp-id-pldm' is flag with possible values 0 and 1.
> I will use type bool instead of uint8?

Yes, please!

[...]


