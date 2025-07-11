Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5533DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEEX-0006GG-Fq; Fri, 11 Jul 2025 09:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaEER-00061K-Mo
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaEEP-0003Gm-Fg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752242164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5TVHEFg8WK/rWD3bzTI+jxFa/UAo3D45mPFwRsaurw=;
 b=bczUCS4AJboXCW+xRC1A4dP616wHm6+prGDNSv+UxwjBNuHSd46wEA8EosGyvrdszpUqbf
 3oOaXUNqSLpQTfs3dGaopctuhlViEm/XtblbAGDgZHDPJo/OjK2WtXFrrpRyopna7oH2gY
 DKRa89MXAgqaEewCPW+68wFJg6VePvs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-thkfgdIjM4eJdbAfDd9jow-1; Fri,
 11 Jul 2025 09:56:00 -0400
X-MC-Unique: thkfgdIjM4eJdbAfDd9jow-1
X-Mimecast-MFC-AGG-ID: thkfgdIjM4eJdbAfDd9jow_1752242155
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38CFF1809C89; Fri, 11 Jul 2025 13:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD78D1956094; Fri, 11 Jul 2025 13:55:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A8B421E6A27; Fri, 11 Jul 2025 15:55:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Jiri Pirko <jiri@resnulli.us>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  qemu-trivial@nongnu.org,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Lukas
 Straub <lukasstraub2@web.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 4/4] qapi: rephrase return docs to avoid type name
In-Reply-To: <20250711051045.51110-5-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:10:45 -0400")
References: <20250711051045.51110-1-jsnow@redhat.com>
 <20250711051045.51110-5-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 15:55:48 +0200
Message-ID: <877c0eygpn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Recommend to explain *why* we want to avoid the type name.

  "Returns: <description>" is rendered like "Return: <Type> =E2=80=93
  <description>".  Mentioning the type in the description again is
  commonly redundant.  Rephrase such descriptions not to.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json   | 6 +++---
>  qapi/block-export.json | 2 +-
>  qapi/block.json        | 2 +-
>  qapi/control.json      | 5 ++---
>  qapi/dump.json         | 5 ++---
>  qapi/introspect.json   | 6 +++---
>  qapi/job.json          | 2 +-
>  qapi/misc-i386.json    | 2 +-
>  qapi/misc.json         | 5 ++---
>  qapi/net.json          | 2 +-
>  qapi/pci.json          | 2 +-
>  qapi/qdev.json         | 3 +--
>  qapi/qom.json          | 8 +++-----
>  qapi/stats.json        | 2 +-
>  qapi/trace.json        | 2 +-
>  qapi/ui.json           | 2 +-
>  qapi/virtio.json       | 6 +++---
>  17 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d64f482d9bd..f18db3149a3 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -763,7 +763,7 @@
>  #
>  # Get a list of BlockInfo for all virtual block devices.

Mentioning the type in the intro is commonly just as redundant as in
Returns:.

>  #
> -# Returns: a list of @BlockInfo describing each virtual block device.
> +# Returns: a list describing each virtual block device.

"A list" is arguably just as redundant as the list's element type.

The entire line is pretty redundant with the intro.

>  #     Filter nodes that were created implicitly are skipped over.
>  #
>  # Since: 0.14
> @@ -1168,7 +1168,7 @@
   ##
   # @query-blockstats:
   #
   # Query the `BlockStats` for all virtual block devices.
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

Again, the entire line is pretty redundant with the intro.

>  #
>  # Since: 0.14
>  #
> @@ -1440,7 +1440,7 @@
>  #
>  # Return information about long-running block device operations.
>  #
> -# Returns: a list of @BlockJobInfo for each active block job
> +# Returns: a list of job info for each active block job

Best not to abbreviate "information" to "info".

>  #
>  # Since: 1.1
>  ##

I need to stop here to take care of another series.  Gut feeling so far:
right direction, doesn't go far enough.

Choices:

* Go far enough.  Too close to the freeze for that, I'm afraid.

* Merge it basically as is, come back later to finish the job.

* Drop it for now, adjust your "QAPI: add cross-references to qapi docs"
  to enclose the type names not removed in `backquotes`.

Thoughts?

[...]


