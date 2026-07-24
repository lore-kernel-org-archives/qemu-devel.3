Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DDDC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBQX-00051k-Bl; Fri, 24 Jul 2026 04:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wnBQP-0004sA-8L
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wnBQN-0003N7-3i
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784882305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgIBRmicN9h4bBiDRn0VGIqHOycUo/puoDIVi8avihQ=;
 b=ayChqkQ/D24tIlojjUYKb7CgfCwxUeS35/NhTWsOkTHPVXhNVsdscR1n8f88nmn7C6hHXm
 4fSgo8c1hVj4W5SVuZWZH+PsRkIiv1kTjp1MpIWeGfytRBSXepqgbZdECCy4eAK41gahBt
 0Joar8hYLvOs0QJIwQZBkmH/OlBIpL8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-VOcuL-kPNjCLML9EkW7tAw-1; Fri,
 24 Jul 2026 04:38:21 -0400
X-MC-Unique: VOcuL-kPNjCLML9EkW7tAw-1
X-Mimecast-MFC-AGG-ID: VOcuL-kPNjCLML9EkW7tAw_1784882299
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6393195DBA3; Fri, 24 Jul 2026 08:38:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 071A815A5; Fri, 24 Jul 2026 08:38:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98ED021E6920; Fri, 24 Jul 2026 10:38:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Zhao Liu <zhao1.liu@intel.com>,  Laurent
 Vivier <laurent@vivier.eu>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Alex
 Williamson
 <alex@shazbot.org>,  zhenwei pi <zhenwei.pi@linux.dev>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for
 block-core.json
In-Reply-To: <20260723044805.527643-45-jsnow@redhat.com> (John Snow's message
 of "Thu, 23 Jul 2026 00:48:05 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-45-jsnow@redhat.com>
Date: Fri, 24 Jul 2026 10:38:12 +0200
Message-ID: <87y0f0aikr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> (Trivial)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 646 +++++++++++++++++--------------------------
>  1 file changed, 255 insertions(+), 391 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1f87b078505..bd98af2f298 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

[...]

> @@ -422,10 +417,9 @@
>  
>  ##
>  # @BlockGraphInfo:
> -#
> -# Information about all nodes in a block (sub)graph in the form of
> -# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
> -# information for the (sub)graph's root node.
> +#     Information about all nodes in a block (sub)graph in the form of
> +#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
> +#     the information for the (sub)graph's root node.
>  #
>  # @children: Array of links to this node's child nodes' information
>  #

The first sentence is clearly overview, but the second caught my eye.
What would we want the inliner to do with it?

Looks like the inliner isn't going to do anything with it right now,
because BlockGraphInfo is only used as member type.

[...]

> @@ -1378,10 +1355,9 @@
>  
>  ##
>  # @BlockdevOnError:
> -#
> -# An enumeration of possible behaviors for errors on I/O operations.
> -# The exact meaning depends on whether the I/O was initiated by a
> -# guest or by a block job
> +#     An enumeration of possible behaviors for errors on I/O
> +#     operations.  The exact meaning depends on whether the I/O was
> +#     initiated by a guest or by a block job
>  #
>  # @report: for guest operations, report the error to the guest; for
>  #     jobs, cancel the job

The first sentence is clearly overview, but the second caught my eye.

Because this is an enum type, and we're not going to inline these, we
can leave it as is.

[...]

> @@ -1636,9 +1605,8 @@
>  
>  ##
>  # @BackupPerf:
> -#
> -# Optional parameters for backup.  These parameters don't affect
> -# functionality, but may significantly affect performance.
> +#     Optional parameters for backup.  These parameters don't affect
> +#     functionality, but may significantly affect performance.

The first sentence is clearly overview.  What would we want the inliner
to do with the second?

Looks like the inliner isn't going to do anything with it right now,
because BackupPerf is only used as member type.

Aside: this only user BackupCommon member x-perf has been @unstable for
more than five years.  That's a long time to sit on a fence.

>  #
>  # @use-copy-range: Use copy offloading.  Default false.
>  #

[...]

> @@ -1845,12 +1812,12 @@
>  
>  ##
>  # @change-backing-file:
> -#
> -# Change the backing file in the image file metadata.  This does not
> -# cause QEMU to reopen the image file to reparse the backing filename
> -# (it may, however, perform a reopen to change permissions from r/o ->
> -# r/w -> r/o, if needed).  The new backing file string is written into
> -# the image file metadata, and the QEMU internal strings are updated.
> +#     Change the backing file in the image file metadata.  This does
> +#     not cause QEMU to reopen the image file to reparse the backing
> +#     filename (it may, however, perform a reopen to change
> +#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
> +#     file string is written into the image file metadata, and the
> +#     QEMU internal strings are updated.

This is an example of a first paragraph I might flag for review if it
was a struct or union type.

>  #
>  # @image-node-name: The name of the block driver state node of the
>  #     image to modify.  The "device" argument is used to verify

[...]

> @@ -2746,11 +2700,10 @@
>  
>  ##
>  # @ThrottleLimits:
> -#
> -# Limit parameters for throttling.  Since some limit combinations are
> -# illegal, limits should always be set in one transaction.  All fields
> -# are optional.  When setting limits, if a field is missing the
> -# current value is not changed.
> +#     Limit parameters for throttling.  Since some limit combinations
> +#     are illegal, limits should always be set in one transaction.
> +#     All fields are optional.  When setting limits, if a field is
> +#     missing the current value is not changed.

The first sentence is clearly overview, but what would we want the
inliner to do with the remainder?

Looks like the inliner isn't going to do anything with it right now,
because ThrottleLimits is only used as member type.

>  #
>  # @iops-total: limit total I/O operations per second
>  #

[...]

> @@ -3548,12 +3486,11 @@
>  
>  ##
>  # @Qcow2OverlapCheckFlags:
> -#
> -# Structure of flags for each metadata structure.  Setting a field to
> -# 'true' makes QEMU guard that Qcow2 format structure against
> -# unintended overwriting.  See Qcow2 format specification for detailed
> -# information on these structures.  The default value is chosen
> -# according to the template given.
> +#     Structure of flags for each metadata structure.  Setting a field
> +#     to 'true' makes QEMU guard that Qcow2 format structure against
> +#     unintended overwriting.  See Qcow2 format specification for
> +#     detailed information on these structures.  The default value is
> +#     chosen according to the template given.
>  #
>  # @template: Specifies a template mode which can be adjusted using the
>  #     other flags, defaults to 'cached'

The first sentence is clearly overview, but what would we want the
inliner to do with the remainder?

Looks like the inliner isn't going to do anything with it right now,
because Qcow2OverlapCheckFlags is only used as member type.


[...]

> @@ -4550,9 +4460,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlHttp:
> -#
> -# Driver specific block device options for HTTP connections over the
> -# curl backend.  URLs must start with "http://".
> +#     Driver specific block device options for HTTP connections over
> +#     the curl backend.  URLs must start with "http://".
>  #
>  # @cookie: List of cookies to set; format is "name1=content1;
>  #     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to

The first sentence is clearly overview, but what about the second?
"URLs" are actually member @url of base type BlockdevOptionsCurlBase.
What would we want the inliner to do with it?

BlockdevOptionsCurlBase is the base type of BlockdevOptionsCurlHttps and
a branch type of BlockdevOptions, where this will get inlined.

> @@ -4576,9 +4485,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlHttps:
> -#
> -# Driver specific block device options for HTTPS connections over the
> -# curl backend.  URLs must start with "https://".
> +#     Driver specific block device options for HTTPS connections over
> +#     the curl backend.  URLs must start with "https://".
>  #
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)

Likewise.

> @@ -4591,9 +4499,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlFtp:
> -#
> -# Driver specific block device options for FTP connections over the
> -# curl backend.  URLs must start with "ftp://".
> +#     Driver specific block device options for FTP connections over
> +#     the curl backend.  URLs must start with "ftp://".
>  #
>  # Since: 2.9
>  ##

Likewise.

> @@ -4603,9 +4510,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlFtps:
> -#
> -# Driver specific block device options for FTPS connections over the
> -# curl backend.  URLs must start with "ftps://".
> +#     Driver specific block device options for FTPS connections over
> +#     the curl backend.  URLs must start with "ftps://".
>  #
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)

Likewise.


[...]

> @@ -4735,14 +4637,13 @@
>  
>  ##
>  # @BlockdevOptionsCbw:
> -#
> -# Driver specific block device options for the copy-before-write
> -# driver, which does so called copy-before-write operations: when data
> -# is written to the filter, the filter first reads corresponding
> -# blocks from its file child and copies them to @target child.  After
> -# successfully copying, the write request is propagated to file child.
> -# If copying fails, the original write request is failed too and no
> -# data is written to file child.
> +#     Driver specific block device options for the copy-before-write
> +#     driver, which does so called copy-before-write operations: when
> +#     data is written to the filter, the filter first reads
> +#     corresponding blocks from its file child and copies them to
> +#     @target child.  After successfully copying, the write request is
> +#     propagated to file child.  If copying fails, the original write
> +#     request is failed too and no data is written to file child.
>  #
>  # @target: The target for copy-before-write operations.
>  #

What would we want the inliner to do with this one?

BlockdevOptionsCbw is a branch type of BlockdevOptions, where this will
get inlined.

> @@ -4778,9 +4679,8 @@
>  
>  ##
>  # @BlockdevOptions:
> -#
> -# Options for creating a block device.  Many options are available for
> -# all block devices, independent of the block driver:
> +#     Options for creating a block device.  Many options are available
> +#     for all block devices, independent of the block driver:
>  #
>  # @driver: block driver name
>  #

What would we want the inliner to do with this one?

BlockdevOptions is used as argument of blockdev-add, where it will be
inlined.


[...]

> @@ -5587,9 +5465,8 @@
>  
>  ##
>  # @BlockdevAmendOptionsQcow2:
> -#
> -# Driver specific image amend options for qcow2.  For now, only
> -# encryption options can be amended
> +#     Driver specific image amend options for qcow2.  For now, only
> +#     encryption options can be amended
>  #
>  # @encrypt: Encryption options to be amended
>  #

What would we want the inliner to do with this one?

BlockdevAmendOptionsQcow2 is used as branch of BlockdevAmendOptions,
where it will be inlined.

[...]

I believe all the problematic first paragraphs consist of more than one
sentence.  What about splitting "trivial" into "very trivial" (just one
paragraph, no sentence-ending punctuation in the middle) and "hopefully
trivial" (just one paragraph, remainder)?


