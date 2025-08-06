Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C88C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZDm-0008Bl-Ag; Wed, 06 Aug 2025 04:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujZCV-0006iX-1Z
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujZCR-0004Fx-QC
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754467719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPtvIjzKcpv8YfEw3+TrvU4XWpxM4d3bHoKpLzFYhzw=;
 b=OLZABSxgX3Y29dg3qFD04xHnSLGE6Wv5RlTZ0HuKEAkn3L4p3+gEP/ekQCozcNLFxrLdRE
 ZKStzMUnl8rO+ful/ZIw4w2BJvQ13vfwkjQdw6o6Ij7MRVeR2+pRtCUpjVmSjSJcoMjKzZ
 NOb5qMpxZDBJ9TJtlzAsuF5FOh26pEs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-IF-cHPSLNsC-XIosPZ0A0g-1; Wed,
 06 Aug 2025 04:08:33 -0400
X-MC-Unique: IF-cHPSLNsC-XIosPZ0A0g-1
X-Mimecast-MFC-AGG-ID: IF-cHPSLNsC-XIosPZ0A0g_1754467712
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAEEA1955E95; Wed,  6 Aug 2025 08:08:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 991C23000198; Wed,  6 Aug 2025 08:08:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC62421E6A27; Wed, 06 Aug 2025 10:08:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: shiju.jose--- via <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>,  <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>,  <dave@stgolabs.net>,  <shiju.jose@huawei.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 4/7] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20250721172228.2118-5-shiju.jose@huawei.com> (shiju jose's
 message of "Mon, 21 Jul 2025 18:22:25 +0100")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
 <20250721172228.2118-5-shiju.jose@huawei.com>
Date: Wed, 06 Aug 2025 10:08:27 +0200
Message-ID: <874iukq3d0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

shiju.jose--- via <qemu-devel@nongnu.org> writes:

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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index f84088c0b9..118dec5362 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -261,6 +261,16 @@
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#     See CXL r3.2 Table 8-59 Memory Module Event Record.
> +#
> +# @is-comp-id-pldm: Flag represents device specific component identifier
> +#     format is PLDM or not.
> +#
> +# @sub-type: Device event sub-type.
> +#     See CXL r3.2 Table 8-59 Memory Module Event Record.
> +#
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-memory-module-event',

Again, partial copy of stuff the previous two patches added to related
commands.

> @@ -272,7 +282,9 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'uint8',
> +            'sub-type':'uint8'
>              }}
>  
>  ##


