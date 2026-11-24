Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E38606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=Nd1msNLH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVo0I-00058l-1a; Tue, 24 Nov 2026 05:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVo0G-00058d-GU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:44:01 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVo0E-0002sQ-Eq
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795517023; bh=rAuoTkZchoD0qv4BoxZfJZlQ8GvtXwZIS6VcnRZcRAY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Nd1msNLHQVzv7ybPfqi3bdlBNJozNvkpidcUyqybno19uX10Fk3yLloTrktPg9gqh
 XMGVOgaPeCQQTZwRqZmHUOswMLudYGOqTyVGR3RKUSOhfpc9RM4NvLDWZWigO1RQRi
 kKz5Zdw3Chd2HE3Y3hLlFgUm6BxePABmuYwBYnMs=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id AB6DF20C73;
 Tue, 24 Nov 2026 11:43:43 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EACE321E6A04; Tue, 24 Nov 2026 11:43:51 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/5] qga: implement 'guest-get-disks' for FreeBSD
In-Reply-To: <20261122090511.15121-4-bogorodskiy@gmail.com> (Roman
 Bogorodskiy's message of "Sun, 22 Nov 2026 10:05:08 +0100")
References: <20261122090511.15121-1-bogorodskiy@gmail.com>
 <20261122090511.15121-4-bogorodskiy@gmail.com>
Date: Tue, 24 Nov 2026 11:43:51 +0100
Message-ID: <87ld6ifr14.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Roman Bogorodskiy <bogorodskiy@gmail.com> writes:

> The implementation uses the "kern.geom.conftxt" sysctl.
> It resides under the "#ifdef __FreeBSD__" block as
> other BSDs do not have GEOM.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 4856a549a6..35aaa040cf 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -947,7 +947,7 @@
>             'media-errors-hi': 'uint64',
>             'number-of-error-log-entries-lo': 'uint64',
>             'number-of-error-log-entries-hi': 'uint64' },
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
>  
>  ##
>  # @GuestDiskSmart:
> @@ -961,12 +961,12 @@
>    'base': { 'type': 'GuestDiskBusType' },
>    'discriminator': 'type',
>    'data': { 'nvme': 'GuestNVMeSmart' },
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
>  
>  ##
>  # @GuestDiskInfo:
>  #
> -# @name: device node (Linux) or device UNC (Windows)
> +# @name: device node (Linux, FreeBSD) or device UNC (Windows)
>  #
>  # @partition: whether this is a partition or disk
>  #
> @@ -987,7 +987,7 @@
>    'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
>             '*address': 'GuestDiskAddress', '*alias': 'str',
>             '*smart': 'GuestDiskSmart'},
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
>  
>  ##
>  # @guest-get-disks:
> @@ -995,13 +995,14 @@
>  # Returns: The list of disks in the guest.  For Windows these are only
>  #     the physical disks.  On Linux these are all root block devices
>  #     of non-zero size including e.g. removable devices, loop devices,
> -#     NBD, etc.
> +#     NBD, etc.  On FreeBSD these are nonzero-size GEOM DISK and PART
> +#     providers (since 12.0).

The (since 12.0) applies just to the sentence about FreeBSD.  Rather
subtle.

Elsewhere in this series, you don't add (since 12.0) when you implement
something for FreeBSD.  How useful is it here?

>  #
>  # Since: 5.2
>  ##
>  { 'command': 'guest-get-disks',
>    'returns': ['GuestDiskInfo'],
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
>  
>  ##
>  # @GuestFilesystemInfo:

