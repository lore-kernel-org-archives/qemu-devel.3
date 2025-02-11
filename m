Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84447C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thtGz-0003XW-IR; Tue, 11 Feb 2025 11:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thtGr-000348-CH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thtGp-0000A8-H7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739291876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9zYju0cgo8r2+qiw1betYGzWi8jKGhs+YXYtyhzrT8=;
 b=hOiryfr1O8vNKElq7xafihxoNMYx2FjeBsqlioTbzJFW7gPcSqseE9zX1Je/JaCi3UNLDw
 9TOzpB0NbOJvQWy6vgAnqjOl9qNpNPey6/nwiLg4Yu8lqjuCN6YiV8dlFO6WGrcQVlOl9Y
 vPpvmfwMjqEDsFRESGWjnBcD5PArwGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-C2TjtXwxPkujQ9-DpD0NFg-1; Tue,
 11 Feb 2025 11:37:52 -0500
X-MC-Unique: C2TjtXwxPkujQ9-DpD0NFg-1
X-Mimecast-MFC-AGG-ID: C2TjtXwxPkujQ9-DpD0NFg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 407361800997; Tue, 11 Feb 2025 16:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E566619560A3; Tue, 11 Feb 2025 16:37:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D04321E6A28; Tue, 11 Feb 2025 17:37:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 9/9] migration: Update migrate_cancel documentation
In-Reply-To: <20250211150136.6781-10-farosas@suse.de> (Fabiano Rosas's message
 of "Tue, 11 Feb 2025 12:01:36 -0300")
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-10-farosas@suse.de>
Date: Tue, 11 Feb 2025 17:37:47 +0100
Message-ID: <87y0ycsahw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Update the migrate_cancel command documentation with a few words about
> postcopy and the expected state of the machine after migration.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  qapi/migration.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 43babd1df4..8b9c53595c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1524,7 +1524,9 @@
>  ##
>  # @migrate_cancel:
>  #
> -# Cancel the current executing migration process.
> +# Cancel the currently executing migration process.  Allows a new
> +# migration to be started right after.  When postcopy-ram is in use,
> +# cancelling is not allowed after the postcopy phase has started.
>  #
>  # .. note:: This command succeeds even if there is no migration
>  #    process running.

Acked-by: Markus Armbruster <armbru@redhat.com>


