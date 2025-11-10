Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED20CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIP3b-0007HJ-W6; Mon, 10 Nov 2025 05:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOuD-0001Yh-Bi
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIOuB-0007aJ-Ia
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762769626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdkDwqXfWLlMf/6ZNjt4tarYKjOCaK9C21xTKDJvhOE=;
 b=DV1YEjwek3Bgayv9+aDGpUxnMf4swIfjAQobYT8eeEYQzJwG9+VGSSbxFXF5Ujrm6QxDaq
 lrhMf30bLU+iL7pVM2Z027jH0HpqIyo3K3Cqql1u0V9/6KCaWsSM5gfnNL26dL7VjCag3r
 3qLCcKQd8simwHWQYdh07rIPbtRjyc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-mwZNI0YRNtWQ7FfkWkQFwQ-1; Mon,
 10 Nov 2025 05:13:42 -0500
X-MC-Unique: mwZNI0YRNtWQ7FfkWkQFwQ-1
X-Mimecast-MFC-AGG-ID: mwZNI0YRNtWQ7FfkWkQFwQ_1762769621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C2481956067; Mon, 10 Nov 2025 10:13:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02C06180087B; Mon, 10 Nov 2025 10:13:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F19C21E6A27; Mon, 10 Nov 2025 11:13:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  kwolf@redhat.com,
 hreitz@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
In-Reply-To: <20251107145327.539481-6-chigot@adacore.com> (=?utf-8?Q?=22Cl?=
 =?utf-8?Q?=C3=A9ment?= Chigot"'s
 message of "Fri, 7 Nov 2025 15:53:27 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
Date: Mon, 10 Nov 2025 11:13:38 +0100
Message-ID: <87zf8umbzh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> This allows more flexibility to vvfat backend. The values of "Number of
> Heads" and "Sectors per track" are based on SD specifications Part 2.
>
> Due to the FAT architecture, not all sizes are reachable. Therefore, it
> could be round up to the closest available size.
>
> FAT32 has not been adjusted and thus still default to 504 Mib.
>
> For floppy, only 1440 Kib and 2880 Kib are supported.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8a479ba090..0bcb360320 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3478,11 +3478,17 @@
>  #     (default: true)
>  #     (since 10.2)
>  #
> +# @fat-size: size of the device in bytes.  Due to FAT underlying
> +#     architecture, this size can be rounded up to the closest valid
> +#     size.
> +#     (since 10.2)
> +#

Can you explain again why you moved from @size to @fat-size?

I assume you dropped the horrible special floppy sizes because ordinary
sizes suffice.  Correct?

>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsVVFAT',
>    'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
> -            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
> +            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool',
> +            'fat-size': 'int' } }
>=20=20
>  ##
>  # @BlockdevOptionsGenericFormat:


