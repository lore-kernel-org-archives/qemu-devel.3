Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64427C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR98o-0001sh-JI; Tue, 09 Jul 2024 07:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR98m-0001qr-7C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR98W-0002uO-Su
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720524955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RGhRgs1v32g/5H0w5aUKTxw+RAzFqjgpGlfR2LFu3dA=;
 b=E5ESyKPUcAYO0rNsOdu0Om2g0UyA3L4ZOX1S9+oxFP4VCH/O1m8s3jSZ4kSnqoFFQ4aI46
 CpD+4uxY1I+KrsSHbOedAYjUCX7q7kZcK5sal9QDANn+PzJPfi2fqk0dAE5igcjViwEIq6
 hGYZf7fTFyfW7yIrUlNJQza5TQ2Q96c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-C62S6gBYObecb3IBu95Ryw-1; Tue,
 09 Jul 2024 07:35:50 -0400
X-MC-Unique: C62S6gBYObecb3IBu95Ryw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81C231953962; Tue,  9 Jul 2024 11:35:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A7C195605F; Tue,  9 Jul 2024 11:35:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 394AB21E668F; Tue,  9 Jul 2024 13:35:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Ani Sinha <anisinha@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 7/8] qapi: convert "Example" sections with longer prose
In-Reply-To: <20240703210144.339530-8-jsnow@redhat.com> (John Snow's message
 of "Wed, 3 Jul 2024 17:01:42 -0400")
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-8-jsnow@redhat.com>
Date: Tue, 09 Jul 2024 13:35:44 +0200
Message-ID: <87o776g5m7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> These examples require longer explanations or have explanations that
> require markup to look reasonable when rendered and so use the longer
> form of the ".. qmp-example::" directive.
>
> By using the :annotated: option, the content in the example block is
> assumed *not* to be a code block literal and is instead parsed as normal
> rST - with the exception that any code literal blocks after `::` will
> assumed to be a QMP code literal block.
>
> Note: There's one title-less conversion in this patch that comes along
> for the ride because it's part of a larger "Examples" block that was
> better to convert all at once.
>
> See commit-5: "docs/qapidoc: create qmp-example directive", for a
>               detailed explanation of this custom directive syntax.
>
> See commit+1: "qapi: remove "Example" doc section" for a detailed
>               explanation of why.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block.json     | 26 ++++++++++++++++----------
>  qapi/machine.json   | 30 ++++++++++++++++++++----------
>  qapi/migration.json |  7 +++++--
>  qapi/virtio.json    | 24 ++++++++++++++++++------
>  4 files changed, 59 insertions(+), 28 deletions(-)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 5ddd061e964..d95e9fd8140 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -545,31 +545,37 @@
>  #
>  # Since: 4.0
>  #
> -# Example:
> +# .. qmp-example::
> +#    :annotated:
>  #
> -#     Set new histograms for all io types with intervals
> -#     [0, 10), [10, 50), [50, 100), [100, +inf):
> +#    Set new histograms for all io types with intervals
> +#    [0, 10), [10, 50), [50, 100), [100, +inf)::
>  #
>  #     -> { "execute": "block-latency-histogram-set",
>  #          "arguments": { "id": "drive0",
>  #                         "boundaries": [10, 50, 100] } }
>  #     <- { "return": {} }
>  #
> -# Example:
> +# .. qmp-example::
> +#    :annotated:
>  #
> -#     Set new histogram only for write, other histograms will remain
> -#     not changed (or not created):
> +#    Set new histogram only for write, other histograms will remain
> +#    not changed (or not created)::
>  #
>  #     -> { "execute": "block-latency-histogram-set",
>  #          "arguments": { "id": "drive0",
>  #                         "boundaries-write": [10, 50, 100] } }
>  #     <- { "return": {} }
>  #
> -# Example:
> +# .. qmp-example::
> +#    :annotated:
>  #
> -#     Set new histograms with the following intervals:
> -#       read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
> -#       write: [0, 1000), [1000, 5000), [5000, +inf)
> +#    Set new histograms with the following intervals:
> +#
> +#    - read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
> +#    - write: [0, 1000), [1000, 5000), [5000, +inf)
> +#
> +#    ::
>  #
>  #     -> { "execute": "block-latency-histogram-set",
>  #          "arguments": { "id": "drive0",
   #                         "boundaries": [10, 50, 100],
   #                         "boundaries-write": [1000, 5000] } }
   #     <- { "return": {} }
   #
   # .. qmp-example::
   #    :title: Remove all latency histograms
   #
   #     -> { "execute": "block-latency-histogram-set",
   #          "arguments": { "id": "drive0" } }
   #     <- { "return": {} }
   ##

I think using :annotated: for this one as well will look better.

[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


