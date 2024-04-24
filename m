Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D652C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 13:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzcNw-0000qa-Ff; Wed, 24 Apr 2024 09:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcNu-0000qL-VQ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcNs-0002Ul-Rb
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713964199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=702f7RWc9UdE6UuFLqM4KgRdi7amap9QXG2xh3eTZx4=;
 b=L7TmWENebcEAyxjzPAF1JTm+WAyLO575n1Nhc02Pa8l4TCdJOXnBCYcb4sAwWHMEKqyPhT
 jYG1DqD2OSGBfHZJ5yYByA8SDuwqS6+D4u0duQuQgqirOiFiCxs4RnIuvVgjKOoPnGLNIC
 EfsfqjJO2zoOIu1tycX4TnpuNn6B5Mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-DhYI6sFIPfu_WHX7Gnv1Ag-1; Wed, 24 Apr 2024 09:09:54 -0400
X-MC-Unique: DhYI6sFIPfu_WHX7Gnv1Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 882D418065AA;
 Wed, 24 Apr 2024 13:09:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A82C13FA4;
 Wed, 24 Apr 2024 13:09:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 174DD21E66C8; Wed, 24 Apr 2024 15:09:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
 ira.weiny@intel.com,  dan.j.williams@intel.com,
 a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
 jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240304194331.1586191-10-nifan.cxl@gmail.com> (nifan cxl's
 message of "Mon, 4 Mar 2024 11:34:04 -0800")
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
Date: Wed, 24 Apr 2024 15:09:52 +0200
Message-ID: <87a5livrdr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

nifan.cxl@gmail.com writes:

> From: Fan Ni <fan.ni@samsung.com>
>
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.

Will fabric manager emulation obsolete these commands?

> Note: we skips any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.
>
> 1. Add dynamic capacity extents:
>
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
>
> { "execute": "qmp_capabilities" }
>
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 0,
>           "len": 134217728
>       },
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
>
> 2. Release dynamic capacity extents:
>
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) look like below:
>
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8cc4c72fa9..2645004666 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -19,13 +19,16 @@
>  #
>  # @fatal: Fatal Event Log
>  #
> +# @dyncap: Dynamic Capacity Event Log
> +#
>  # Since: 8.1
>  ##
>  { 'enum': 'CxlEventLog',
>    'data': ['informational',
>             'warning',
>             'failure',
> -           'fatal']
> +           'fatal',
> +           'dyncap']

We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.

>   }
>  
>  ##
> @@ -361,3 +364,59 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDCExtentRecord:

Such traffic jams of capital letters are hard to read.

What does DC mean?

> +#
> +# Record of a single extent to add/release
> +#
> +# @offset: offset to the start of the region where the extent to be operated

Blank line here, please

> +# @len: length of the extent
> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'CXLDCExtentRecord',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to start add dynamic capacity extents flow. The device will

I think we're missing an article here.  Is it "a flow" or "the flow"?

> +# have to acknowledged the acceptance of the extents before they are usable.

to acknowledge

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +#
> +# @path: CXL DCD canonical QOM path

What is a CXL DCD?  Is it a device?

I'd prefer @qom-path, unless you can make a consistency argument for
@path.

> +# @region-id: id of the region where the extent to add

What's a region, and how do they get their IDs?

> +# @extents: Extents to add

Blank lines between argument descriptions, please.

> +#
> +# Since : 9.0

9.1

> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'region-id': 'uint8',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to start release dynamic capacity extents flow. The host will

Article again.

The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.

> +# need to respond to indicate that it has released the capacity before it
> +# is made unavailable for read and write and can be re-added.

Is "and can be re-added" relevant here?

> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to release
> +# @extents: Extents to release
> +#
> +# Since : 9.0

9.1

> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'region-id': 'uint8',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}


