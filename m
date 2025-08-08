Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8883FC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 18:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukRg7-0007em-Sm; Fri, 08 Aug 2025 14:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukRg6-0007eQ-Fu
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukRg3-0001nd-OS
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754677129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDv1ZkVjhvp2pwDWnu+yg1ns4eVqnFwa3FltznPcVbo=;
 b=SIS/7havQzPQzFzUyKToE0Mvt45xgFD2mQPjx1t8L5EzJwAivOhYMjtW5dT9lHlNyGsTWa
 RU2LSlzhcf41Ob89vSr/ZCM6dOd4NwvP3FYYrybUZGIO4ZMT1UedFBaMOHD3KAoTldaAZK
 mwiPiq+TbYRtaOYmOVne2qay/8sKF0A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-wr-HfqDKN6CpiyPbtJVgmA-1; Fri,
 08 Aug 2025 14:18:45 -0400
X-MC-Unique: wr-HfqDKN6CpiyPbtJVgmA-1
X-Mimecast-MFC-AGG-ID: wr-HfqDKN6CpiyPbtJVgmA_1754677124
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3BAC19560B0; Fri,  8 Aug 2025 18:18:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17F4A195419D; Fri,  8 Aug 2025 18:18:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61F6D21E6A27; Fri, 08 Aug 2025 20:18:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,  <ira.weiny@intel.com>,
 <alucerop@amd.com>,  <a.manzanares@samsung.com>,
 <linux-cxl@vger.kernel.org>,  <qemu-devel@nongnu.org>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
In-Reply-To: <20250808164216.0000196b@huawei.com> (Jonathan Cameron's message
 of "Fri, 8 Aug 2025 16:42:16 +0100")
References: <20250806055708.196851-1-dave@stgolabs.net>
 <20250806055708.196851-2-dave@stgolabs.net>
 <20250808164216.0000196b@huawei.com>
Date: Fri, 08 Aug 2025 20:18:40 +0200
Message-ID: <87ldntsmm7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Tue,  5 Aug 2025 22:57:05 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> As with the link speed and width training, have ad-hoc property for
>> setting the flit mode and allow CXL components to make use of it.
>> 
>> For the CXL root port and dsp cases, always report flit mode but
>> the actual value after 'training' will depend on the downstream
>> device configuration.
>> 
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Hi Davidlohr,
>
> This looks a bit like an interface that evolved, but in the end
> you seem to have something that is a simple boolean property.
> As such you can avoid a fair bit of complexity.
> Look for disable-acs for an example.
>
>
> I don't know if it is desirable to make it an explicit type or not,
> but my gut says boolean is fine here.
>
> +CC A few potentially relevant people to answer that question more
> definitively.

[...]

>> diff --git a/qapi/common.json b/qapi/common.json
>> index 0e3a0bbbfb0b..da047fbf874f 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -140,6 +140,20 @@
>>  { 'enum': 'PCIELinkWidth',
>>    'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
>>  
>
> Hmm. Not sure why these are here rather than pci.json.

Pretty sure there was a good reason back then.  Less sure there is a
good reason now :)

>> +##
>> +# @PCIELinkFlit:
>> +#
>> +# An enumeration of PCIe link FLIT mode
>
> Bit odd having an enumeration for 'on' vs 'off'

Indeed.  Please stick to bool.

>> +#
>> +# @off: the link is not operating in FLIT mode
>> +#
>> +# @on: each FLIT is a fixed 256 bytes in size
>> +#
>> +# Since: 10.0
>
> That was a while back.
>
>> +##
>> +{ 'enum': 'PCIELinkFlit',
>> +  'data': [ 'off', 'on'] }
>> +
>>  ##
>>  # @HostMemPolicy:
>>  #


