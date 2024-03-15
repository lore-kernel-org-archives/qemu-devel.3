Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C05C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl3M4-0005aj-3c; Fri, 15 Mar 2024 04:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rl3M2-0005aY-65
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rl3Lz-0004vr-Ne
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710492950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q4ipSGUyG86vFZSHl350EOBEovQV+3dng95/pzfOyss=;
 b=izTDtnNalxbUlFb/hYs6ivkeFqedMxdLbaNMedyRhrIGzzbA5m/6slRV/+AIbZGj+C52bX
 hM0Ul+P6Q7pqvkfGQZl51n7PDRb/Fotequ0fNrsQupZmUtzsz2ViQSAe3uGK+cSxSKaG4a
 DaaR/NATBfgE2+swrb5yy31SkzZQt+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-I9PAtkWuN9Glthbq6obWLw-1; Fri, 15 Mar 2024 04:55:46 -0400
X-MC-Unique: I9PAtkWuN9Glthbq6obWLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37700185A781;
 Fri, 15 Mar 2024 08:55:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A0AF1C060A4;
 Fri, 15 Mar 2024 08:55:44 +0000 (UTC)
Date: Fri, 15 Mar 2024 08:55:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Message-ID: <ZfQNDv--4BnN5zYx@redhat.com>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315032040.7974-4-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 15, 2024 at 12:20:40AM -0300, Fabiano Rosas wrote:
> The fd: URI has supported migration to a file or socket since before
> QEMU 8.2. In 8.2 we added the file: URI that supported migration to a
> file. So now we have two ways (three if you count exec:>cat) to
> migrate to a file. Fine.
> 
> However,
> 
> In 8.2 we also added the new qmp_migrate API that uses a JSON channel
> list instead of the URI. It added two migration transports SOCKET and
> FILE. It was decided that the new API would classify the fd migration
> as a type of socket migration, neglecting the fact that the fd.c code
> also supported file migrations.
> 
> In 9.0 we're adding support for fd + multifd + mapped-ram, which is
> tied to the file migration. This was implemented in fd.c, which is
> only reachable when the SOCKET address type is used.
> 
> The result of this is that we're asking users of the new API to create   (1)
> something called a "socket" to perform migration to a plain file. And
> creating something called a "file" provides no way of passing in a
> file descriptor. This is confusing.

The 'file:' protocol eventually calls into qemu_open, and this
transparently allows for FD passing using /dev/fdset/NNN syntax
to pass in FDs. 


> diff --git a/qapi/migration.json b/qapi/migration.json
> index aa1b39bce1..37f4b9c6fb 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1656,13 +1656,20 @@
>  #
>  # @filename: The file to receive the migration stream
>  #
> +# @fd: A file descriptor name or number.  File descriptors must be
> +#     first added with the 'getfd' command. (since 9.0).
> +#
>  # @offset: The file offset where the migration stream will start
>  #
> +# Since 9.0, all members are optional, but at least one of @filename
> +# or @fd are required.
> +#
>  # Since: 8.2
>  ##
>  { 'struct': 'FileMigrationArgs',
> -  'data': { 'filename': 'str',
> -            'offset': 'uint64' } }
> +  'data': { '*filename': 'str',
> +            '*fd': 'str',
> +            '*offset': 'uint64' } }

Adding 'fd' here is not desirable, because 'filename' is
resolved via qemu_open which allows for FD passing without
introducing any new syntax in interfaces which take filenames.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


