Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3809C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 08:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty5D2-0000JV-MD; Fri, 28 Mar 2025 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ty5Ct-0000HF-7p
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 04:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ty5Cp-0003DO-SS
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 04:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743151007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jQo3SYbIH2xS24gQn/PqAMrTv2PngwzkiXR2mQRDI14=;
 b=DjJqRiRBOewW06fspWNMqkUdzKHjgFnJCpd7IAlq83NjgTEFENf4KS71A2EjRedsmX+tGZ
 ph4ewfB8/RYzjUhGLs1+p5qZoEgPhowdvF+cj+RkswT7c4xle1eE0RTX/bcB9G5cUPw3Gi
 autVP7BfCNLwRki3NxD3vLinZQ2yyJ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-AXUkay0XM6yeRFdtpwKGIA-1; Fri,
 28 Mar 2025 04:36:42 -0400
X-MC-Unique: AXUkay0XM6yeRFdtpwKGIA-1
X-Mimecast-MFC-AGG-ID: AXUkay0XM6yeRFdtpwKGIA_1743151000
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FCD5180049D; Fri, 28 Mar 2025 08:36:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9B5730001A1; Fri, 28 Mar 2025 08:36:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D43F21E6773; Fri, 28 Mar 2025 09:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Hanna Reitz
 <hreitz@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  qemu-trivial@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-block@nongnu.org,  Lukas Straub <lukasstraub2@web.de>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Laurent
 Vivier <laurent@vivier.eu>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Kevin Wolf
 <kwolf@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v2 4/4] qapi: rephrase return docs to avoid type name
In-Reply-To: <20250326195756.330817-5-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Mar 2025 15:57:56 -0400")
References: <20250326195756.330817-1-jsnow@redhat.com>
 <20250326195756.330817-5-jsnow@redhat.com>
Date: Fri, 28 Mar 2025 09:36:25 +0100
Message-ID: <87jz89mu0m.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Well, I tried. Maybe not very hard. Sorry!

No need to be sorry!  Kick-starting discussion with limited effort is
better than a big effort going into a direction that turns out to be
unwanted once we discuss it.

Instead of just rephrasing Returns descriptions, I'd like us to consider
both Returns and intro.  See below for why.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json     | 6 +++---
>  qapi/block-export.json   | 2 +-
>  qapi/block.json          | 2 +-
>  qapi/control.json        | 5 ++---
>  qapi/dump.json           | 5 ++---
>  qapi/introspect.json     | 6 +++---
>  qapi/job.json            | 2 +-
>  qapi/machine-target.json | 7 +++----
>  qapi/misc-target.json    | 2 +-
>  qapi/misc.json           | 5 ++---
>  qapi/net.json            | 2 +-
>  qapi/pci.json            | 2 +-
>  qapi/qdev.json           | 3 +--
>  qapi/qom.json            | 8 +++-----
>  qapi/stats.json          | 2 +-
>  qapi/trace.json          | 2 +-
>  qapi/ui.json             | 2 +-
>  qapi/virtio.json         | 6 +++---
>  18 files changed, 31 insertions(+), 38 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 92b2e368b72..eb97b70cd80 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -763,7 +763,7 @@
   ##
   # @query-block:
>  #
>  # Get a list of BlockInfo for all virtual block devices.
>  #
> -# Returns: a list of @BlockInfo describing each virtual block device.
> +# Returns: a list describing each virtual block device.
>  #     Filter nodes that were created implicitly are skipped over.
>  #
>  # Since: 0.14
> @@ -1168,7 +1168,7 @@
   ##
   # @query-blockstats:
   #
   # Query the @BlockStats for all virtual block devices.
   #
   # @query-nodes: If true, the command will query all the block nodes
   #     that have a node name, in a list which will include "parent"
   #     information, but not "backing".  If false or omitted, the
   #     behavior is as before - query all the device backends,
   #     recursively including their "parent" and "backing".  Filter
>  #     nodes that were created implicitly are skipped over in this
>  #     mode.  (Since 2.3)
>  #
> -# Returns: A list of @BlockStats for each virtual block devices.
> +# Returns: A list of statistics for each virtual block device.
>  #
>  # Since: 0.14
>  #
> @@ -1440,7 +1440,7 @@
   ##
   # @query-block-jobs:
>  #
>  # Return information about long-running block device operations.
>  #
> -# Returns: a list of @BlockJobInfo for each active block job
> +# Returns: a list of job info for each active block job
>  #
>  # Since: 1.1
>  ##

Stopping here, because I believe this is already enough to make a useful
observation.

There's overlap between query-FOO's intro and Returns.  The intro
describes the command's purpose, and the purpose of a query-FOO is to
return certain information.  Returns describes the value returned.  Both
talk about the same thing, namely the value returned.

Why two prose descriptions of the value returned?  Wouldn't one be
better?

Let's try.  We need to choose where to put it, intro or Returns.

When Returns comes right after intro, putting it into Returns can work
fine, because the command's purpose still comes first.  For instance:

   ##
   # @query-block:
   #
   # Return information about all virtual block devices.  Filter nodes
   # that were created implicitly are skipped over.

renders like

    Command query-block (Since: 0.14)

       Return information about all virtual block devices. Filter nodes
       that were created implicitly are skipped over.

       Return:
          ["BlockInfo"]

and

   ##
   # @query-block:
   #
   # Returns: Information about all virtual block devices.
   #     Filter nodes that were created implicitly are skipped over.

renders like

    Command query-block (Since: 0.14)

       Return:
          ["BlockInfo"] -- Information about all virtual block
          devices. Filter nodes that were created implicitly are skipped
          over.

Both work.

But when there's something in between, intro is preferable.  For
instance:

   ##
   # @query-blockstats:
   #
   # Return statistics for all virtual block devices.
   #
   # @query-nodes: If true, the command will query all the block nodes
   #     that have a node name, in a list which will include "parent"
   #     information, but not "backing".  If false or omitted, the
   #     behavior is as before - query all the device backends,
   #     recursively including their "parent" and "backing".  Filter
   #     nodes that were created implicitly are skipped over in this
   #     mode.  (Since 2.3)

renders like

    Command query-blockstats (Since: 0.14)

       Return statistics for all virtual block devices.

       Arguments:
          * **query-nodes** ("boolean", *optional*) -- If true, the
            command will query all the block nodes that have a node name,
            in a list which will include "parent" information, but not
            "backing".  If false or omitted, the behavior is as before -
            query all the device backends, recursively including their
            "parent" and "backing".  Filter nodes that were created
            implicitly are skipped over in this mode.  (Since 2.3)

       Return:
          ["BlockStats"]

while

   ##
   # @query-blockstats:
   #
   # @query-nodes: If true, the command will query all the block nodes
   #     that have a node name, in a list which will include "parent"
   #     information, but not "backing".  If false or omitted, the
   #     behavior is as before - query all the device backends,
   #     recursively including their "parent" and "backing".  Filter
   #     nodes that were created implicitly are skipped over in this
   #     mode.  (Since 2.3)
   #
   # Returns: Statistics for all virtual block devices

renders like

    Command query-blockstats (Since: 0.14)

       Arguments:
          * **query-nodes** ("boolean", *optional*) -- If true, the
            command will query all the block nodes that have a node name,
            in a list which will include "parent" information, but not
            "backing".  If false or omitted, the behavior is as before -
            query all the device backends, recursively including their
            "parent" and "backing".  Filter nodes that were created
            implicitly are skipped over in this mode.  (Since 2.3)

       Return:
          ["BlockStats"] -- Statistics for all virtual block devices

I much prefer the former, because it puts the command's purpose where it
belongs: first.

Perhaps we should simply use the intro always.

Thoughts?


