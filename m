Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FB9C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZ2N-0004eB-2m; Wed, 06 Aug 2025 03:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujZ2L-0004an-EP
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujZ2J-0002Bt-Gl
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754467090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPmikXRTOFmMM79qW7tCghU8gonU2zNSDP0mrdBBWfE=;
 b=XqEIxsVDb/Klzpedn2fRhelK11jjvf/ejcOpKL+9wmcGXOXg1xyByA5UJj15etPwcCthTG
 jx0tiiYjmUVFguWcbhZVxoUXzLck8wQSuUFUlguwOUiePT+iC3RW9HZW/X0biwH25LfL1j
 6cynCAWYZ8l6G5Z3mtW7RE4qHPG8308=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-dykqIJ3NOkuXZ0H0bWQAvQ-1; Wed,
 06 Aug 2025 03:58:05 -0400
X-MC-Unique: dykqIJ3NOkuXZ0H0bWQAvQ-1
X-Mimecast-MFC-AGG-ID: dykqIJ3NOkuXZ0H0bWQAvQ_1754467084
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE0361800296; Wed,  6 Aug 2025 07:58:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87F531956086; Wed,  6 Aug 2025 07:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C59B721E6A27; Wed, 06 Aug 2025 09:57:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: shiju.jose--- via <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>,  <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>,  <dave@stgolabs.net>,  <shiju.jose@huawei.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
 media event record
In-Reply-To: <20250721172228.2118-3-shiju.jose@huawei.com> (shiju jose's
 message of "Mon, 21 Jul 2025 18:22:23 +0100")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
 <20250721172228.2118-3-shiju.jose@huawei.com>
Date: Wed, 06 Aug 2025 09:57:59 +0200
Message-ID: <87ms8cq3ug.fsf@pond.sub.org>
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

shiju.jose--- via <qemu-devel@nongnu.org> writes:

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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c1fe8319c8..e8060d16f7 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -82,6 +82,19 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @is-comp-id-pldm: Flag represents device specific component identifier
> +#     format is PLDM or not.

Awkward phrasing.  Before I can suggest a better one, I have a question.
The type is uint8, which isn't a flag.  What are the possible values?

> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.

The line break will not make it into generated HTML (it's all one
wrapped paragraph).

We commonly wrap like this:

   # @cme-ev-flags: Advanced programmable corrected memory error
   #     threshold event flags.  See CXL r3.2 Table 8-57 General Media
   #     Event Record.

If you want a line break in generated documentation, you need to start a
new paragraph like this:

   # @cme-ev-flags: Advanced programmable corrected memory error
   #     threshold event flags.
   #
   #     See CXL r3.2 Table 8-57 General Media Event Record.

Same below.

> +#
> +# @cme-count: Corrected memory error count at event.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
> +# @sub-type: Memory event sub-type.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-general-media-event',
> @@ -91,7 +104,10 @@
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            '*is-comp-id-pldm':'uint8',
> +            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
> +            'sub-type':'uint8' } }
>  
>  ##
>  # @cxl-inject-dram-event:


