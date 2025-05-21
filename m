Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C09C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 07:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHe9k-0004vK-Ms; Wed, 21 May 2025 03:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1uHe9i-0004uu-Eb
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1uHe9h-0003Vw-0H
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747813582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HTYA6Ms4cOfXCG0L9BMp4TZzRc9XQdJ6ePiqF4v+1AM=;
 b=Jm9pPgzWWLxgZW/0wkJkMANjul5YlK6KdebIlmSIoECW+MHfFFNYwB2GL/ZiESmRfvsi1u
 qiIMQ2Lg5FuMcjqMR2e2+m0uGNSw5DXNXSSf8+KZfHb6v1ZgCEuU3HiGBXjdn6Lw+CLxhs
 ORm6LvcFfaKZtC0rJqszHNclzaSULsw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-DQXlrh8gO9ukd25HXRewPw-1; Wed,
 21 May 2025 03:46:18 -0400
X-MC-Unique: DQXlrh8gO9ukd25HXRewPw-1
X-Mimecast-MFC-AGG-ID: DQXlrh8gO9ukd25HXRewPw_1747813577
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BC551956080; Wed, 21 May 2025 07:46:17 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D728195608F; Wed, 21 May 2025 07:46:14 +0000 (UTC)
Date: Wed, 21 May 2025 09:46:10 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] qapi/migration: Deprecate migrate argument @detach
Message-ID: <aC2EwjHq82ANZ83J@angien.pipo.sk>
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521063711.29840-3-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 08:37:09 +0200, Markus Armbruster via Devel wrote:
> Argument @detach has always been ignored.  Start the clock to get rid
> of it.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/about/deprecated.rst |  5 +++++
>  qapi/migration.json       | 18 +++++++++---------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 9665bc6fcf..ef4ea84e69 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -179,6 +179,11 @@ Use ``job-dismiss`` instead.
>  
>  Use ``job-finalize`` instead.
>  
> +``migrate`` argument ``detach`` (since 10.1)
> +''''''''''''''''''''''''''''''''''''''''''''
> +
> +This argument has always been ignored.

Huh; libvirt is actually always specifying it for some reason.

I'll post patches shortly getting rid of it completely in libvirt


