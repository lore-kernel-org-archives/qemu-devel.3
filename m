Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21ACC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwu7-0007lY-AA; Thu, 20 Aug 2026 03:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwwu6-0007lA-6g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwwu4-0004VU-KC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787209770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfYEZq3OcN0LIVul9UvsK4UuDL00qC7WzFptssOLu64=;
 b=Ma3Bs0ItPYsQBfgNof8zw6HNwce7SbolpQkiwEk+Lf5f5AfjVfFBYdpt0kzTi3zdl0+kel
 cIHoxPEIQs6j8UTQnAFLosTv6i1OIxQfqfBn+wtlYZDmb0J5sjkBz28ciWq0vK83rZbUYI
 N1myv1G/s+0HjwqhZah1bkSvKj8PlVM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-lSpMRRZDNDiZMfJc4YIzJA-1; Thu,
 20 Aug 2026 03:09:24 -0400
X-MC-Unique: lSpMRRZDNDiZMfJc4YIzJA-1
X-Mimecast-MFC-AGG-ID: lSpMRRZDNDiZMfJc4YIzJA_1787209762
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 948411956049; Thu, 20 Aug 2026 07:09:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 311F1180049F; Thu, 20 Aug 2026 07:09:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B3ADD21E6920; Thu, 20 Aug 2026 09:09:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  maciej.szmigiero@oracle.com,  mark.kanda@oracle.com,
 bchaney@akamai.com,  pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
In-Reply-To: <20260812232842.470225-2-dongli.zhang@oracle.com> (Dongli Zhang's
 message of "Wed, 12 Aug 2026 16:27:46 -0700")
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
Date: Thu, 20 Aug 2026 09:09:19 +0200
Message-ID: <87a4qh46ao.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> Add a memfd migration transport to the MigrationAddress QAPI schema. The
> new transport has no user-supplied arguments because QEMU creates and
> passes the backing memfd internally.
>
> The initial user is cpr-exec, where the main VM/device migration stream can
> be stored in an inherited memfd instead of an external file.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  qapi/migration.json | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b1eaf7b054..1505c201ca 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -702,9 +702,11 @@
>  # @cpr-exec: The migrate command stops the VM, saves state to the
>  #     migration channel, directly exec's a new version of QEMU on the
>  #     same host, replacing the original process while retaining its
> -#     PID, and loads state from the channel.  Guest RAM is preserved
> -#     in place.  Devices and their pinned pages are also preserved for
> -#     VFIO and IOMMUFD.
> +#     PID, and loads state from the channel.  With the @memfd
> +#     migration transport, QEMU saves VM/device state to an internal
> +#     memfd instead of an external main migration channel.  Guest RAM
> +#     is preserved in place.  Devices and their pinned pages are also
> +#     preserved for VFIO and IOMMUFD.
>  #
>  #     Old QEMU starts new QEMU by exec'ing the command specified by
>  #     the @cpr-exec-command parameter.  The command may be a direct
> @@ -716,6 +718,13 @@
>  #     as a file, that accepts all data before old QEMU exits.
>  #     Otherwise, old QEMU may quietly block writing to the channel.
>  #
> +#     Alternatively, use the @memfd migration transport to save
> +#     VM/device state to an internal memfd inherited by new QEMU.
> +#

Any guidance on when to use @memfd?

> +#     With @memfd, the new QEMU command may include '-incoming memfd:'
> +#     to load the migration stream automatically, or '-incoming defer'
> +#     to load it later with `migrate-incoming`.
> +#

Isn't that the same for any transport?  I.e. old and new QEMU must use a
common transport, and you configure it for the new one with -incoming
right away, or later with migrate-incoming.

>  #     Memory-backend objects must have the share=on attribute, but
>  #     memory-backend-epc is not supported.  The VM must be started
>  #     with the '-machine aux-ram-share=on' option.
> @@ -1309,10 +1318,14 @@
>  #
>  # @file: Direct the migration stream to a file.
>  #
> +# @memfd: Direct the migration stream to an internal memfd.  This
> +#     transport is currently only valid with cpr-exec migration mode.
> +#     (Since 11.2)
> +#
>  # Since: 8.2
>  ##
>  { 'enum': 'MigrationAddressType',
> -  'data': [ 'socket', 'exec', 'rdma', 'file' ] }
> +  'data': [ 'socket', 'exec', 'rdma', 'file', 'memfd' ] }
>  
>  ##
>  # @FileMigrationArgs:
> @@ -1337,6 +1350,14 @@
>  { 'struct': 'MigrationExecCommand',
>    'data': {'args': [ 'str' ] } }
>  
> +##
> +# @MemfdMigrationArgs:
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'MemfdMigrationArgs',
> +  'data': { } }
> +
>  ##
>  # @MigrationAddress:
>  #
> @@ -1353,7 +1374,8 @@
>      'socket': 'SocketAddress',
>      'exec': 'MigrationExecCommand',
>      'rdma': 'InetSocketAddress',
> -    'file': 'FileMigrationArgs' } }
> +    'file': 'FileMigrationArgs',
> +    'memfd': 'MemfdMigrationArgs' } }

Simpler: omit branch @memfd, no need for struct MemfdMigrationArgs.

>  ##
>  # @MigrationChannelType:


