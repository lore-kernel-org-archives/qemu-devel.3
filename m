Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19E2C9EC77
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfGy4-0004Vo-W6; Mon, 12 Jan 2026 07:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfGxQ-0004TX-Fp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfGxO-0003GC-75
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768220616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bBcbqJ+HaHOXY1qhhR27ENO31OIiH/4ni506XBX8/OI=;
 b=ClGig6MkUgAW0VMpaxv3b98u45z7K9cNth7DKnrVkYGc+BCHevL5t6IzKTjgk8YM/P/1tj
 h4nVdRIPux4pNJcz6NKVajI/bnq6IiL+eEVZk6oT2C8ApQTSlwmxtFkgR+6rjJTjZDtkVt
 PgThzAyv6d45HVTeGVV3sB1a+yrpyN8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-h7EH7fDmMaetLCthkVBawQ-1; Mon,
 12 Jan 2026 07:23:31 -0500
X-MC-Unique: h7EH7fDmMaetLCthkVBawQ-1
X-Mimecast-MFC-AGG-ID: h7EH7fDmMaetLCthkVBawQ_1768220610
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3630B19560B2; Mon, 12 Jan 2026 12:23:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2E9A18004D8; Mon, 12 Jan 2026 12:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F89821E6742; Mon, 12 Jan 2026 13:23:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20260102151512.460766-6-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Fri, 2 Jan 2026 15:15:12 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
 <20260102151512.460766-6-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:23:27 +0100
Message-ID: <87344bf29s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
> CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> event record has updated with following new fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
>
> Add updates for the above spec changes in the CXL memory module
> event reporting and QMP command to inject memory module event.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               | 12 +++++++++++-
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  4 ++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 3e4bad4ad0..752d46cda2 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -242,6 +242,14 @@
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

These three seem to be the same in CXLGeneralMediaEvent, CXLDRAMEvent,
and CXLMemModuleEvent.  Should they live in their common base type
CXLCommonEventBase?

>  # Since: 8.1
>  ##
>  { 'struct': 'CXLMemModuleEvent',
> @@ -251,7 +259,9 @@
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

[...]


