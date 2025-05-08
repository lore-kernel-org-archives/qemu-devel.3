Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017B6C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 05:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCtoG-0001pk-JP; Thu, 08 May 2025 01:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCtoD-0001jm-0E
 for qemu-devel@nongnu.org; Thu, 08 May 2025 01:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCtoB-0002up-1x
 for qemu-devel@nongnu.org; Thu, 08 May 2025 01:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746682113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+4PdNRIyENoiTLWmpt6AArGC8flgEo5jSfP5hSVozQ=;
 b=dAAsLzI4MCaM0cTZA1SPMA3FoGuLl8WVDpG/6A65uEUF0HtiYYSrM4ldkCTJ82CeXY8wy5
 n/vdya2unzpOqtJahoe8O0t3yOjhQYIVUe6iAxFpqsV+1J6snJ9fOVi2gYbMnVaYTf4Mg9
 /Qk3C45QV3GxmbotZfNTz/fXZ4Y+4ak=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-bMX_D7q2M6i8N4K4hgshsA-1; Thu,
 08 May 2025 01:28:30 -0400
X-MC-Unique: bMX_D7q2M6i8N4K4hgshsA-1
X-Mimecast-MFC-AGG-ID: bMX_D7q2M6i8N4K4hgshsA_1746682109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 934401956051; Thu,  8 May 2025 05:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAC441956058; Thu,  8 May 2025 05:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40ADA21E6768; Thu, 08 May 2025 07:28:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] block/null: Add read-pattern option
In-Reply-To: <20250430203717.16359-3-nirsof@gmail.com> (Nir Soffer's message
 of "Wed, 30 Apr 2025 23:37:17 +0300")
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-3-nirsof@gmail.com>
Date: Thu, 08 May 2025 07:28:26 +0200
Message-ID: <87h61vekn9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Nir Soffer <nirsof@gmail.com> writes:

> When the `read-zeroes` is set, reads produce zeroes, and block status
> return BDRV_BLOCK_ZERO, emulating a sparse image.
>
> If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image data
> is undefined; posix_memalign, _aligned_malloc, valloc, or memalign do
> not promise to zero allocated memory.
>
> When computing a blkhash of an image via qemu-nbd, we want to test 3
> cases:
>
> 1. Sparse image: skip reading the entire image based on block status
>    result, and use a pre-computed zero block hash.
> 2. Image full of zeroes: read the entire image, detect block full of
>    zeroes and skip block hash computation.
> 3. Image full of data: read the entire image and compute a hash of all
>    blocks.
>
> This change adds `read-pattern` option. If the option is set, reads
> produce the specified pattern. With this option we can emulate an image
> full of zeroes or full of non-zeroes.
>
> The following examples shows how the new option can be used with blksum
> (or nbdcopy --blkhash) to compute a blkhash of an image using the
> null-co driver.
>
> Sparse image - the very fast path:
>
>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10=
0g', 'read-zeroes': true}}" &
>
>     % time blksum 'nbd+unix:///?socket=3D/tmp/sparse.sock'
>     300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd=
+unix:///?socket=3D/tmp/sparse.sock
>     blksum 'nbd+unix:///?socket=3D/tmp/sparse.sock'  0.05s user 0.01s sys=
tem 92% cpu 0.061 total
>
> Image full of zeros - same hash, 268 times slower:
>
>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10=
0g', 'read-pattern': 0}}" &
>
>     % time blksum 'nbd+unix:///?socket=3D/tmp/zero.sock'
>     300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd=
+unix:///?socket=3D/tmp/zero.sock
>     blksum 'nbd+unix:///?socket=3D/tmp/zero.sock'  7.45s user 22.57s syst=
em 183% cpu 16.347 total
>
> Image full of data - difference hash, heavy cpu usage:
>
>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10=
0g', 'read-pattern': 255}}" &
>
>     % time blksum 'nbd+unix:///?socket=3D/tmp/data.sock'
>     2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  nbd=
+unix:///?socket=3D/tmp/data.sock
>     blksum 'nbd+unix:///?socket=3D/tmp/data.sock'  46.05s user 14.15s sys=
tem 448% cpu 13.414 total
>
> Specifying both `read-zeroes` and `read-pattern` is an error since
> `read-zeroes` implies a sparse image. Example errors:
>
>     % ./qemu-img map --output json \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'read-patte=
rn': -1}}"
>     qemu-img: Could not open 'json:{...}': read_pattern is out of range (=
0-255)
>
>     % ./qemu-img map --output json \
>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'read-patte=
rn': 0, 'read-zeroes': true}}"
>     qemu-img: Could not open 'json:{...}': The parameters read-zeroes and=
 read-pattern are in conflict
>
> Tested on top of
> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.
>
> Signed-off-by: Nir Soffer <nirsof@gmail.com>

[...]

> diff --git a/docs/devel/secure-coding-practices.rst b/docs/devel/secure-c=
oding-practices.rst
> index 0454cc527e..73830684ea 100644
> --- a/docs/devel/secure-coding-practices.rst
> +++ b/docs/devel/secure-coding-practices.rst
> @@ -111,5 +111,6 @@ Use of null-co block drivers
>  The ``null-co`` block driver is designed for performance: its read acces=
ses are
>  not initialized by default. In case this driver has to be used for secur=
ity
>  research, it must be used with the ``read-zeroes=3Don`` option which fil=
ls read
> -buffers with zeroes. Security issues reported with the default
> +buffers with zeroes, or with the ``read-pattern=3DN`` option which fills=
 read
> +buffers with pattern. Security issues reported with the default
>  (``read-zeroes=3Doff``) will be discarded.
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7c95c9e36a..2205ac9758 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3295,13 +3295,23 @@
>  #
>  # @read-zeroes: if true, emulate a sparse image, and reads from the
>  #     device produce zeroes; if false, emulate an allocated image but
> -#     reads from the device leave the buffer unchanged.
> +#     reads from the device leave the buffer unchanged. Mutually
> +#     exclusive with @read-pattern.
>  #     (default: false; since: 4.1)

Correct before the patch: absent behaves just like present and false.

That's no longer the case afterwards.  Hmm.

>  #
> +# @read-pattern: if set, emulate an allocated image, and reads from the
> +#     device produce the specified byte value; if unset, reads from the
> +#     device leave the buffer unchanged. Mutually exclusive with
> +#     @read-zeroes.
> +#     (since: 10.1)

Default?  The usual way to document it would be something like (default:
false), but that's again problematic.

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsNull',
> -  'data': { '*size': 'int', '*latency-ns': 'uint64', '*read-zeroes': 'bo=
ol' } }
> +  'data': { '*size': 'int',
> +            '*latency-ns': 'uint64',
> +            '*read-zeroes': 'bool',
> +            '*read-pattern': 'uint8' } }
>=20=20
>  ##
>  # @BlockdevOptionsNVMe:

Let's take a step back from the concrete interface and ponder what we're
trying to do.  We want three cases:

* Allocated, reads return unspecified crap (security hazard)

* Allocated, reads return specified data

* Sparse, reads return zeroes

How would we do this if we started on a green field?

Here's my try:

    bool sparse
    uint8 contents

so that

* Allocated, reads return unspecified crap (security hazard)

  @sparse is false, and @contents is absent

* Allocated, reads return specified data

  @sparse is false, and @contents is present

* Sparse, reads return zeroes

  @sparse is true, and @contents must absent or zero

I'd make @sparse either mandatory or default to true, so that we don't
default to security hazard.

Now compare this to your patch: same configuration data (bool =C3=97 uint8),
better names, cleaner semantics, better defaults.

Unless we want to break compatibility, we're stuck with the name
@read-zeroes for the bool, and its trap-for-the-unwary default value,
but cleaner semantics seem possible.

Thoughts?


