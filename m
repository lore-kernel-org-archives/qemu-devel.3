Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17B5C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVv9-0005N1-Fb; Tue, 01 Jul 2025 04:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWVv6-0005MX-RY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWVv3-0006OG-AY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751356843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DJDeBgWjXBYAypbopyDuPYkcXQu8vwRoaKZ7orLjRzs=;
 b=bWNuMye1kL1d30BuZQ5PZdxeUqG3dM3Z2rZD2bfO+i8IUDqJ6i2TCsxlKjeUvefFNvlsvr
 IPml3HNFsfSkRSRGQIb6io775hd9ezXMEJnvSG1BL5alzq8ei1lL1Lda1sGPQr1omxSzvI
 Sr0O1+reTzD6iG8xvBL83nBKzAbPg4k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-IAYJ3DosOByF6qgZXBKSdQ-1; Tue,
 01 Jul 2025 04:00:41 -0400
X-MC-Unique: IAYJ3DosOByF6qgZXBKSdQ-1
X-Mimecast-MFC-AGG-ID: IAYJ3DosOByF6qgZXBKSdQ_1751356840
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96F6318011DF; Tue,  1 Jul 2025 08:00:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6703195609D; Tue,  1 Jul 2025 08:00:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DC1F21E6A27; Tue, 01 Jul 2025 10:00:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  armbru@redhat.com,  Peter
 Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 04/24] migration: Remove MigrateSetParameters
In-Reply-To: <20250630195913.28033-5-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 30 Jun 2025 16:58:53 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-5-farosas@suse.de>
Date: Tue, 01 Jul 2025 10:00:37 +0200
Message-ID: <87jz4s1gt6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Now that the TLS options have been made the same between
> migrate-set-parameters and query-migrate-parameters, a single type can
> be used. Remove MigrateSetParameters.
>
> The TLS options documentation from MigrationParameters were replaced
> with the ones from MigrateSetParameters which was more complete.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 97bb022c45..3788c39857 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,206 +914,10 @@
>             'zero-page-detection',
>             'direct-io'] }
>  
> -##
> -# @MigrateSetParameters:

[...]

>  ##
>  # @migrate-set-parameters:
>  #
> -# Set various migration parameters.
> +# Set migration parameters.  All fields are optional.

Use "arguments" instead of "fields".

>  #
>  # Since: 2.4
>  #
> @@ -1124,13 +928,11 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'migrate-set-parameters', 'boxed': true,
> -  'data': 'MigrateSetParameters' }
> +  'data': 'MigrationParameters' }
>  
>  ##
>  # @MigrationParameters:
>  #
> -# The optional members aren't actually optional.
> -#
>  # @announce-initial: Initial delay (in milliseconds) before sending
>  #     the first announce (Since 4.0)
>  #
> @@ -1148,12 +950,12 @@
>  #     percentage.  The default value is 50.  (Since 5.0)
>  #
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
> -#     throttled when migration auto-converge is activated.
> -#     (Since 2.7)
> +#     throttled when migration auto-converge is activated.  The
> +#     default value is 20.  (Since 2.7)
>  #
>  # @cpu-throttle-increment: throttle percentage increase each time
>  #     auto-converge detects that migration is not making progress.
> -#     (Since 2.7)
> +#     The default value is 10.  (Since 2.7)
>  #
>  # @cpu-throttle-tailslow: Make CPU throttling slower at tail stage.
>  #     At the tail stage of throttling, the Guest is very sensitive to
> @@ -1172,21 +974,25 @@
>  #     for establishing a TLS connection over the migration data
>  #     channel.  On the outgoing side of the migration, the credentials
>  #     must be for a 'client' endpoint, while for the incoming side the
> -#     credentials must be for a 'server' endpoint.  An empty string
> -#     means that QEMU will use plain text mode for migration, rather
> -#     than TLS.  (Since 2.7)
> -#
> -#     Note: 2.8 omits empty @tls-creds instead.
> +#     credentials must be for a 'server' endpoint.  Setting this to a
> +#     non-empty string enables TLS for all migrations.  An empty
> +#     string means that QEMU will use plain text mode for migration,
> +#     rather than TLS.  This is the default.  (Since 2.7)
>  #
>  # @tls-hostname: migration target's hostname for validating the
>  #     server's x509 certificate identity.  If empty, QEMU will use the
> -#     hostname from the migration URI, if any.  (Since 2.7)
> +#     hostname from the migration URI, if any.  A non-empty value is
> +#     required when using x509 based TLS credentials and the migration
> +#     URI does not include a hostname, such as fd: or exec: based
> +#     migration.  (Since 2.7)
>  #
> -#     Note: 2.8 omits empty @tls-hostname instead.
> +#     Note: empty value works only since 2.9.
>  #
>  # @tls-authz: ID of the 'authz' object subclass that provides access
>  #     control checking of the TLS x509 certificate distinguished name.
> -#     (Since 4.0)
> +#     This object is only resolved at time of use, so can be deleted
> +#     and recreated on the fly while the migration server is active.
> +#     If missing, it will default to denying access (Since 4.0)
>  #
>  # @max-bandwidth: maximum speed for migration, in bytes per second.
>  #     (Since 2.8)
> @@ -1205,8 +1011,8 @@
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
>  #
> -# @x-checkpoint-delay: the delay time between two COLO checkpoints.
> -#     (Since 2.8)
> +# @x-checkpoint-delay: the delay time between two COLO checkpoints in
> +#     periodic mode.  (Since 2.8)
>  #
>  # @multifd-channels: Number of channels used to migrate data in
>  #     parallel.  This is the same number that the number of sockets

Please add

   ##
   # @query-migrate-parameters:
   #
  -# Return information about the current migration parameters
  +# Return information about the current migration parameters.
  +# Optional members of the return value are always present.
   #
   # Returns: @MigrationParameters
   #
   # Since: 2.4
   #

and double-check "always" is actually true.

With that, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


