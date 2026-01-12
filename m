Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1452CC9EC7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfGtP-0007VF-9d; Mon, 12 Jan 2026 07:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfGtL-0007Qb-A2
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfGtE-00021t-Ka
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768220359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSzXhdlhQU08FAnxB9Em4ZWdMNWLxCuKZ7hGG6SV6Vw=;
 b=IO93ztEGLSv4YpY9N97HU465dvoKs/EkMx4UGz2igNXPBWhF0CioLBBxzBczghBXmZKr0J
 ykj5nio1ix5Eozjmz3k/y1eAOOrYvwgQMKU3lEjrtoxHzLkif5AwtgP4ZVED2RkcWXhaYh
 pW5EKyDs5YbgSeGxXMg8bw7F8o8a0pg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-lzoXL7nSO7eIS4SkwHSHjw-1; Mon,
 12 Jan 2026 07:19:16 -0500
X-MC-Unique: lzoXL7nSO7eIS4SkwHSHjw-1
X-Mimecast-MFC-AGG-ID: lzoXL7nSO7eIS4SkwHSHjw_1768220355
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98941956054; Mon, 12 Jan 2026 12:19:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5482319560BA; Mon, 12 Jan 2026 12:19:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B34BB21E6683; Mon, 12 Jan 2026 13:19:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>,  <armbru@redhat.com>,  <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 4/5] hw/cxl/events: Updates for rev3.2 DRAM
 event record
In-Reply-To: <20260102151512.460766-5-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Fri, 2 Jan 2026 15:15:11 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
 <20260102151512.460766-5-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:19:11 +0100
Message-ID: <87cy3ff2gw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
> CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
> has updated with following new fields.
> 1. Component Identifier
> 2. Sub-channel of the memory event location
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Volatile Memory Error Count at Event
> 5. Memory Event Sub-Type
>
> Add updates for the above spec changes in the CXL DRAM event
> reporting and QMP command to inject DRAM event.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               | 21 ++++++++++++++++++-
>  include/hw/cxl/cxl_events.h |  9 ++++++--
>  hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  7 +++++++
>  4 files changed, 76 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c5ecbe9646..3e4bad4ad0 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -168,6 +168,21 @@
   ##
   # @CXLDRAMEvent:
   #
   # Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
   #
   # @dpa: Device Physical Address (relative to @path device).  Note
   #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
   #     Event Record, Physical Address.
   #
   [...]
>  # @correction-mask: Bits within each nibble.  Used in order of bits
>  #     set in the nibble-mask.  Up to 4 nibbles may be covered.
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-channel: The sub-channel of the memory event location.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cvme-count: Corrected volatile memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#

You're not updating the reference to the CXL spec from 3.0 to 3.2.
Intentional?

>  # Since: 8.1
>  ##
>  { 'struct': 'CXLDRAMEvent',
> @@ -176,7 +191,11 @@
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> -            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            '*sub-channel':'uint8',
> +            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
> +            'sub-type':'uint8'
>             }}
>  
>  ##

[...]


