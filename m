Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595FD39005
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 18:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg5gp-0004YJ-VN; Wed, 14 Jan 2026 13:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg5go-0004X2-UH
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg5gn-0007lI-AJ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768415632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtLuvrn6a4KY4sJu9DGVXcHRxVa+NW6NOmxvH2VUWW4=;
 b=FMG0yCRPS3rWR91FlmfjDu0lFplukXCRRfL5JtU0oq5GogIl1X4Fsgz1HP1UON8lgx37h9
 Ib5SGRpc4DPIemkxPQTtcHU3qLBMuWTn4iER1/R+eOgvgcJme/BKY9aQMEiR8UgzvzBjeu
 Hhyd/WYDowkO2pm5oEDlMAoz94YnYjo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-LZnIsgYVP5yVJbCMgZapOg-1; Wed,
 14 Jan 2026 13:33:45 -0500
X-MC-Unique: LZnIsgYVP5yVJbCMgZapOg-1
X-Mimecast-MFC-AGG-ID: LZnIsgYVP5yVJbCMgZapOg_1768415624
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B895195609D; Wed, 14 Jan 2026 18:33:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF2A30002DC; Wed, 14 Jan 2026 18:33:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81A3721E692D; Wed, 14 Jan 2026 19:33:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>,  <armbru@redhat.com>,  <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v3 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20260114142713.617806-6-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Wed, 14 Jan 2026 14:27:13 +0000")
References: <20260114142713.617806-1-Jonathan.Cameron@huawei.com>
 <20260114142713.617806-6-Jonathan.Cameron@huawei.com>
Date: Wed, 14 Jan 2026 19:33:41 +0100
Message-ID: <87o6mwyrga.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
> CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> event record has updated with following new fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
>
> Add updates for the above spec changes in the CXL memory module
> event reporting and QMP command to inject memory module event.
>
> Updated all references for this command to the CXL r3.2
> specification.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> V3: Update spec references for whole command (Markus)
> ---
>  qapi/cxl.json               | 26 ++++++++++++++++++--------
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  4 ++++
>  4 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 630c37d64eed..fc2ff2e080b4 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -214,20 +214,20 @@
>  ##
>  # @CXLMemModuleEvent:
>  #
> -# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
> +# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
>  #
> -# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
> +# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
>  #     Event Record for bit definitions for bit definiions.
>  #
> -# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
> -#     8-100 Get Health Info Output Payload, Health Status for bit
> +# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
> +#     8-148 Get Health Info Output Payload, Health Status for bit
>  #     definitions.
>  #
> -# @media-status: Overall media health summary.  See CXL r3.0 Table
> -#     8-100 Get Health Info Output Payload, Media Status for bit
> +# @media-status: Overall media health summary.  See CXL r3.2 Table
> +#     8-148 Get Health Info Output Payload, Media Status for bit
>  #     definitions.
>  #
> -# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
> +# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
>  #     Payload, Additional Status for subfield definitions.
>  #
>  # @life-used: Percentage (0-100) of factory expected life span.
> @@ -243,6 +243,14 @@
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-type: Device event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLMemModuleEvent',
> @@ -252,7 +260,9 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            'sub-type':'uint8'
>              }}
>  
>  ##
   # @cxl-inject-memory-module-event:
   #
   # Inject an event record for a Memory Module Event (CXL r3.0
   # 8.2.9.2.1.3).  This event includes a copy of the Device Health info

Should we update this reference as well?

   # at the time of the event.
   #
   # Since: 8.1
   ##
   { 'command': 'cxl-inject-memory-module-event',
     'data': 'CXLMemModuleEvent' }

[...]


