Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B2ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIOxX-00033q-96; Mon, 10 Nov 2025 05:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOo0-0006v0-Na
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOny-00070L-Ni
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762769241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PoQXAbcajfTM7eJJSSXmzoUHpDiIspocIB84wK+bd14=;
 b=aDVKjiOXlSIWmopIyLcAtLh8c1JqayQ/1jiBFvLcnlgGkfHgtTXqsF4RZScOV7NbfAh+kZ
 sn7b7+dCzU1oj9hB9iB9r1UERVh9Lqt/ENWH+NHyfEyNJfxvyJB1euBmxM081bc5X+blEE
 1bBtrVwS3frXGMJ0IJg/e+dNNjhoSnQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-w1sgjlUKPNGpik1rgGThaw-1; Mon,
 10 Nov 2025 05:07:17 -0500
X-MC-Unique: w1sgjlUKPNGpik1rgGThaw-1
X-Mimecast-MFC-AGG-ID: w1sgjlUKPNGpik1rgGThaw_1762769236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345D019560B5; Mon, 10 Nov 2025 10:07:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADE161800451; Mon, 10 Nov 2025 10:07:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0EC3921E6A27; Mon, 10 Nov 2025 11:07:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  kwolf@redhat.com,
 hreitz@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
In-Reply-To: <20251107145327.539481-2-chigot@adacore.com> (=?utf-8?Q?=22Cl?=
 =?utf-8?Q?=C3=A9ment?= Chigot"'s
 message of "Fri, 7 Nov 2025 15:53:23 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
Date: Mon, 10 Nov 2025 11:07:13 +0100
Message-ID: <878qgenqum.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Cl=C3=A9ment Chigot <chigot@adacore.com> writes:

> This option tells whether a hard disk should be partitioned or not. It
> defaults to true and have the prime effect of preventing a master boot
> record (MBR) to be initialized.
>
> This is useful as some operating system (QNX, Rtems) don't
> recognized FAT mounted disks (especially SD cards) if a MBR is present.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b82af74256..8a479ba090 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3464,8 +3464,8 @@
>  #
>  # @fat-type: FAT type: 12, 16 or 32
>  #
> -# @floppy: whether to export a floppy image (true) or partitioned hard
> -#     disk (false; default)
> +# @floppy: whether to export a floppy image (true) or hard disk
> +#     (false; default)
>  #
>  # @label: set the volume label, limited to 11 bytes.  FAT16 and FAT32
>  #     traditionally have some restrictions on labels, which are
> @@ -3474,11 +3474,15 @@
>  #
>  # @rw: whether to allow write operations (default: false)
>  #
> +# @partitioned: whether a hard disk will be partitioned

How does "partitioned" combine with "floppy": true?

Is it silently ignored?

Is it an error if present?

Is it an error if true?

Does it add a partition table if true?

> +#     (default: true)

Hmm, this suggests it's silently ignored.

Silently ignoring nonsensical configuration is usually a bad idea.

> +#     (since 10.2)
> +#

Not sure I like "partitioned".  Is a disk with an MBR and a partition
table contraining a single partition partitioned?  Call it "mbr"?

>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsVVFAT',
>    'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
> -            '*label': 'str', '*rw': 'bool' } }
> +            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
>=20=20
>  ##
>  # @BlockdevOptionsGenericFormat:


