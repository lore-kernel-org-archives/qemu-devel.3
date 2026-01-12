Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC6EC9EC7A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfGn1-0007Jz-HP; Mon, 12 Jan 2026 07:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfGmw-0007BP-Bx
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfGmu-0000P2-HI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768219966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyKAAVbRiwpUoBFdn3/clJG0F+n4W2Li7tTGkoyMxfw=;
 b=XewUmX3ToWq2EhJj18Ly2klGVTIUKALZP3k5bqXza/+0htcM7xL2pQbvQfBgT/VNZuFy1L
 0oP6KrDXLN2c9JAcNSAwlDQQDNNIL0WKuYqtswLSLsPR+E9QQI2NWnUIyUoMqb9n/ruXXa
 pFyrX2d+t5vblogBomc7T947WI9kvf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502---VYPIF4Md-iIJkCiAEzoQ-1; Mon,
 12 Jan 2026 07:12:39 -0500
X-MC-Unique: --VYPIF4Md-iIJkCiAEzoQ-1
X-Mimecast-MFC-AGG-ID: --VYPIF4Md-iIJkCiAEzoQ_1768219958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C49ED1954B0B; Mon, 12 Jan 2026 12:12:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C96DE19560BA; Mon, 12 Jan 2026 12:12:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7803021E6683; Mon, 12 Jan 2026 13:12:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 1/5] qapi: cxl: Refactor CXL event injection for
 common commands arguments
In-Reply-To: <20260102151512.460766-2-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Fri, 2 Jan 2026 15:15:08 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
 <20260102151512.460766-2-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:12:34 +0100
Message-ID: <87pl7ff2rx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> Refactor CXL event injection to use struct for common command
> arguments.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I verified this does not change the external interface by comparing
generated qapi-introspect.c before and after.

> ---
>  qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 31 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index eeddb58d1d..d5b86159f1 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -31,11 +31,10 @@
>   }
>  
>  ##
> -# @cxl-inject-general-media-event:
> +# @CXLCommonEventBase:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event logs
> -# specified via the log parameter.
> +# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> +# Table 8-42 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
> @@ -44,6 +43,16 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# Since: 8.1
> +##
> +{ 'struct': 'CXLCommonEventBase',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +
> +##
> +# @CXLGeneralMediaEvent:
> +#
> +# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -74,26 +83,29 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLGeneralMediaEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>  
>  ##
> -# @cxl-inject-dram-event:
> -#
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> -# This event type is reported via one of the event logs specified via
> -# the log parameter.
> +# @cxl-inject-general-media-event:
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# logs specified via the log parameter.
>  #
> -# @log: Event log to add the event to
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': 'CXLGeneralMediaEvent' }
> +
> +##
> +# @CXLDRAMEvent:
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> @@ -133,9 +145,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLDRAMEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> @@ -143,18 +155,21 @@
>             }}
>  
>  ##
> -# @cxl-inject-memory-module-event:
> +# @cxl-inject-dram-event:
>  #
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> -# at the time of the event.
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': 'CXLDRAMEvent' }
> +
> +##
> +# @CXLMemModuleEvent:
>  #
> -# @log: Event Log to add the event to
> -#
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
>  #
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
> @@ -185,9 +200,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> -            'type': 'uint8', 'health-status': 'uint8',
> +{ 'struct': 'CXLMemModuleEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
> @@ -195,6 +210,18 @@
>              'corrected-persistent-error-count': 'uint32'
>              }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.3)
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.

I believe this should be

   # Inject an event record for a Memory Module Event (CXL r3.0
   # 8.2.9.2.1.3).  This event includes a copy of the Device Health info
   # at the time of the event.

> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': 'CXLMemModuleEvent' }
> +
>  ##
>  # @cxl-inject-poison:
>  #


