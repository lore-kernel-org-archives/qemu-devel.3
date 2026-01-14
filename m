Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905FFD39005
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 18:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg5fP-0003Ok-Fy; Wed, 14 Jan 2026 13:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg5fL-0003O3-Un
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg5fK-0007DQ-7R
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768415540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7cfbpxHZbbD5cZVcv3GGiHTMaR+UMAKreSL99LFDr4=;
 b=fOYa8DJygZAqCEjl6kxAI9rz4c16eDFuYKRoilNSPYnel77Q/fhptf2HZf4peIs8R8BgfN
 6uVptAanORTV045TnGDQ0ZQmuGgbN+IzTE1USq6i+lV91TQ2b2edwSbs4gz+XhoQW13iSS
 t0wNy3fGUd6VLkXe1pbZcx+DFWW73Qk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-5o_fqJdMMvSUkPNWTgZ_Rw-1; Wed,
 14 Jan 2026 13:32:17 -0500
X-MC-Unique: 5o_fqJdMMvSUkPNWTgZ_Rw-1
X-Mimecast-MFC-AGG-ID: 5o_fqJdMMvSUkPNWTgZ_Rw_1768415536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 251DF1956096; Wed, 14 Jan 2026 18:32:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A101956056; Wed, 14 Jan 2026 18:32:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C25F321E692D; Wed, 14 Jan 2026 19:32:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>,  <armbru@redhat.com>,  <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v3 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
In-Reply-To: <20260114142713.617806-4-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Wed, 14 Jan 2026 14:27:11 +0000")
References: <20260114142713.617806-1-Jonathan.Cameron@huawei.com>
 <20260114142713.617806-4-Jonathan.Cameron@huawei.com>
Date: Wed, 14 Jan 2026 19:32:12 +0100
Message-ID: <87wm1kyrir.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
> table has updated with following new fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 4. Support for component ID in the PLDM format.
>
> Add updates for the above spec changes in the CXL general media event
> reporting and QMP command to inject general media event.
>
> In order to have one consistent source of references, update all to
> references for this command to CXL r3.2.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Update all references to 3.2 for consistency.
> ---
>  qapi/cxl.json               | 25 +++++++++++++++++++------
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 29 +++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  6 ++++++
>  4 files changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 82001c0591d8..c159687f849c 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -64,22 +64,22 @@
>  ##
>  # @CXLGeneralMediaEvent:
>  #
> -# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
> -#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
> +#     lower bits include some flags.  See CXL r3.2 Table 8-57 General
>  #     Media Event Record, Physical Address.
>  #
>  # @descriptor: Memory Event Descriptor with additional memory event
> -#     information.  See CXL r3.0 Table 8-43 General Media Event
> +#     information.  See CXL r3.2 Table 8-57 General Media Event
>  #     Record, Memory Event Descriptor for bit definitions.
>  #
> -# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
> +# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-57
>  #     General Media Event Record, Memory Event Type for possible
>  #     values.
>  #
>  # @transaction-type: Type of first transaction that caused the event
> -#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
> +#     to occur.  See CXL r3-2 Table 8-57 General Media Event Record,
>  #     Transaction Type for possible values.
>  #
>  # @channel: The channel of the memory event location.  A channel is an
> @@ -94,6 +94,16 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cme-count: Corrected memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLGeneralMediaEvent',
> @@ -101,7 +111,10 @@
>    'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            '*is-comp-id-pldm':'bool',
> +            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
> +            'sub-type':'uint8' } }
>  
>  ##
>  # @cxl-inject-general-media-event:
   #
   # Inject an event record for a General Media Event (CXL r3.0
   # 8.2.9.2.1.1).  This event type is reported via one of the event

Should we update this reference as well?

   # logs specified via the log parameter.
   #
   # Since: 8.1
   ##
   { 'command': 'cxl-inject-general-media-event',
     'data': 'CXLGeneralMediaEvent' }

[...]


