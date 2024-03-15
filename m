Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB88C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7rd-0000fY-P2; Fri, 15 Mar 2024 09:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl7rb-0000fH-2Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl7rY-0007bE-8u
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710510282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zNjahT3d2nZxwcCaVP9rl4fjt4m4rz6ioOxRDpGCAs=;
 b=UWgQpqmLKNgvQnN0k/UVQDdGs4gWUr69jgPOVCbzIOeo6y8WXF0CthKYQLkkCTiPDhsv7X
 lCRluak0FxxDPu4mzV48YxLoZSTfrIHDaEO2jR5bAevXCxAEDs1h3nNceLc8/P5/GjgmSu
 HWEjUjEpCGM+dCTza/jab2VD2sfH8bE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-Mt8zbjfwN8evHEwFkpWdRA-1; Fri,
 15 Mar 2024 09:44:41 -0400
X-MC-Unique: Mt8zbjfwN8evHEwFkpWdRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C225C3C0D842;
 Fri, 15 Mar 2024 13:44:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E62B2022C1E;
 Fri, 15 Mar 2024 13:44:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9885C21E6A24; Fri, 15 Mar 2024 14:44:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  michael.roth@amd.com,
 kkostiuk@redhat.com,  marcandre.lureau@redhat.com,  philmd@linaro.org,
 den@virtuozzo.com
Subject: Re: [PATCH v3 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-root' field
In-Reply-To: <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com> (Andrey
 Drobyshev's message of "Fri, 15 Mar 2024 14:29:40 +0200")
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
 <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com>
Date: Fri, 15 Mar 2024 14:44:39 +0100
Message-ID: <87le6jehiw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:

> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
> returned by statvfs(3).  While on Windows guests that's all we can get
> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
> total file system size, as it's visible for root user.  Let's add an
> optional field 'total-bytes-root' to GuestFilesystemInfo struct, which'd
> only be reported on POSIX and represent f_blocks value as returned by
> statvfs(3).
>
> While here, let's document better where those values come from in both
> POSIX and Windows.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b8efe31897..093a5ab602 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1031,8 +1031,18 @@
>  # @type: file system type string
>  #
>  # @used-bytes: file system used bytes (since 3.0)
> +#     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by statvfs(3)
> +#     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as returned
> +#       by GetDiskFreeSpaceEx()
>  #
>  # @total-bytes: non-root file system total bytes (since 3.0)
> +#     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
> +#       statvfs(3)
> +#     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
> +#
> +# @total-bytes-root: total file system size in bytes (as visible for a
> +#     priviledged user) (since 8.3)

privileged

> +#     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)
>  #
>  # @disk: an array of disk hardware information that the volume lies
>  #     on, which may be empty if the disk type is not supported
> @@ -1042,7 +1052,7 @@
>  { 'struct': 'GuestFilesystemInfo',
>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
> -           'disk': ['GuestDiskAddress']} }
> +           '*total-bytes-root': 'uint64', 'disk': ['GuestDiskAddress']} }
>  
>  ##
>  # @guest-get-fsinfo:

Fails to build the manual:

    qga/qapi-schema.json:1019:Unexpected indentation.

To fix, add blank lines before the lists, like this:

   # @used-bytes: file system used bytes (since 3.0)
   #
   #     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by
   #       statvfs(3)
   #     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as
   #       returned by GetDiskFreeSpaceEx()
   #
   # @total-bytes: non-root file system total bytes (since 3.0)
   #
   #     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
   #       statvfs(3)
   #     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
   #
   # @total-bytes-root: total file system size in bytes (as visible for a
   #     privileged user) (since 8.3)
   #
   #     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)
   #

Yes, reST can be quite annoying.


