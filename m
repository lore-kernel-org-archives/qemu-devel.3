Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D156010A88C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mRB-00077r-6O; Thu, 26 Mar 2026 11:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5mR9-00076N-BF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5mR7-0003sR-8J
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774538150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzpehDqYgCyCogpznJ1yRYvkvpNP6+3YYzUqRgqyluU=;
 b=BVG7UkoO6VgQlef+ucU1Jj5cgtahZ1BD9LLXxYZBsLlTvZFF4nvfskYBqlB0K9SJQTGY4N
 P+LzV44wIT95tTsMeZ9nfCORL5nJn0QNhAR2ezAUjuk7tZwJMKRzkXFEcMt4AYUlYy2R3s
 A4Dy2e+4BY/p4ev7GywY2hlPHoheMaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-dVAnXoqzMDWhQysiOPlhcw-1; Thu,
 26 Mar 2026 11:15:46 -0400
X-MC-Unique: dVAnXoqzMDWhQysiOPlhcw-1
X-Mimecast-MFC-AGG-ID: dVAnXoqzMDWhQysiOPlhcw_1774538145
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEABB1956048; Thu, 26 Mar 2026 15:15:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 085F31955D84; Thu, 26 Mar 2026 15:15:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 952BA21E6937; Thu, 26 Mar 2026 16:15:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
 <berrange@redhat.com>,  <eblake@redhat.com>,
 <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
 <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
 <me@linux.beauty>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
In-Reply-To: <20260325184259.366-10-alireza.sanaee@huawei.com> (Alireza
 Sanaee's message of "Wed, 25 Mar 2026 18:42:57 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-10-alireza.sanaee@huawei.com>
Date: Thu, 26 Mar 2026 16:15:40 +0100
Message-ID: <87mrzuei5f.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

I'm a near-complete CXL ignoramus, and beg your patience.

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> Add a small status query so orchestration layers can check whether a tagged
> extent is still pending, committed, or no longer present after a release
> request.

Why would they want to check?

What is a "release request"?

>
> Introduce the ExtentStatus QAPI struct and the
> cxl-release-dynamic-capacity-status command.
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 81d6198ba0..53325ba530 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -636,3 +636,49 @@
>             },
>    'features': [ 'unstable' ]
>  }
> +
> +##
> +# @ExtentStatus:

Blank line here, please.

> +# This is an object that describes the status of an extent.
> +#
> +# @status:   String indicating the overall result, e.g. "success".

What are the possible values?  Are they defined in some spec?

> +# @message:  Human-readable description of the outcome.

Intended use?

> +#
> +# Since: 9.1

11.1 most likely.

> +##
> +{ 'struct': 'ExtentStatus',
> +      'data': { 'status': 'str', 'message': 'str' }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity-status:
> +#
> +# This commands checks if an extent tag has been released or not.

Use imperative mood to describe commands: "Check whether an extent tag
has been released."

> +#
> +# @path: path to the CXL Dynamic Capacity Device in the QOM tree.

We commonly call such members @qom-path.

> +#
> +# @host-id: The "Host ID" field as defined in Compute Express Link
> +#     (CXL) Specification, Revision 3.1, Table 7-71.
> +#
> +# @region: The "Region Number" field as defined in Compute Express
> +#     Link Specification, Revision 3.1, Table 7-71.  Valid range
> +#     is from 0-7.
> +#
> +# @tag: The "Tag" field as defined in Compute Express Link (CXL)
> +#     Specification, Revision 3.1, Table 7-71.

I guess the command interrogates something called "extent", and the
something is related to the CXL device at @path in the QOM tree.
Correct?

How is it related?  Is it a part of the device?

I further guess multiple extends can be so related, and @host-id,
@region, and @tag identify select the one we want to interrogate.
Correct?

> +#
> +# Features:
> +#
> +# @unstable: For now this command is subject to change.

The conventional language is "This command is experimental."

> +#
> +# Since: 9.1

11.1 most likely.

> +##
> +{ 'command': 'cxl-release-dynamic-capacity-status',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'region': 'uint8',
> +            'tag': 'str'
> +          },
> +  'features': [ 'unstable' ],
> +  'returns': 'ExtentStatus'

Swap these two lines, please.

> +}


