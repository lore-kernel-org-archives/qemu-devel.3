Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3487FCE076
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 19:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvh3F-0001tF-H1; Thu, 26 Feb 2026 14:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvh39-0001sW-D1
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:29:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvh37-0000mM-Bt
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772134164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ZA/xWB6pqUESqkju7p6VKhJck10ZrjnfS32iGX2OTk=;
 b=NRWSFrJloGkUHu24S98JaVGJFgn3Ukv5gIjw8ywlzvUJrO7m0E+uOpIrGHNNg8I2kdexCn
 bjGTpysv8gv60Ys3b80CJeYB4cby/aqfNpteMa+XFlRjwWaYePyzQdjfMZ0eJ5DBxgCSzX
 KEHfdqDsKLz86kmfpfRxlvLyICa27g0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-D89ixG1rMeOu6LE5q1qNLQ-1; Thu,
 26 Feb 2026 14:29:23 -0500
X-MC-Unique: D89ixG1rMeOu6LE5q1qNLQ-1
X-Mimecast-MFC-AGG-ID: D89ixG1rMeOu6LE5q1qNLQ_1772134162
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE9A81956080; Thu, 26 Feb 2026 19:29:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBABB1800465; Thu, 26 Feb 2026 19:29:19 +0000 (UTC)
Date: Thu, 26 Feb 2026 20:29:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Brian Song <hibriansong@gmail.com>, bernd@bsbernd.com
Subject: Re: [PATCH v4 16/24] fuse: Manually process requests (without libfuse)
Message-ID: <aaCfDatNHMJZsZom@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
 <20260218132633.29748-17-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218132633.29748-17-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

Am 18.02.2026 um 14:26 hat Hanna Czenczek geschrieben:
> @@ -278,6 +390,17 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
>      char *mount_opts;
>      struct fuse_args fuse_args;
>      int ret;
> +    /*
> +     * We just create the session for mounting/unmounting, no need to provide
> +     * any operations.  However, since libfuse commit 52a633a5d, we have to
> +     * provide some op struct and cannot just pass NULL (even though the commit
> +     * message ("allow passing ops as NULL") seems to imply the exact opposite,
> +     * as does the comment added to fuse_session_new_fn() ("To create a no-op
> +     * session just for mounting pass op as NULL.").
> +     * This is how said libfuse commit implements a no-op session internally, so
> +     * do it the same way.
> +     */
> +    static const struct fuse_lowlevel_ops null_ops = { 0 };
>  
>      /*
>       * Note that these mount options differ from what we would pass to a direct
> @@ -301,8 +424,8 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
>      fuse_argv[3] = NULL;
>      fuse_args = (struct fuse_args)FUSE_ARGS_INIT(3, (char **)fuse_argv);
>  
> -    exp->fuse_session = fuse_session_new(&fuse_args, &fuse_ops,
> -                                         sizeof(fuse_ops), exp);
> +    exp->fuse_session = fuse_session_new(&fuse_args, &null_ops,
> +                                         sizeof(null_ops), NULL);

Bernd, is it intentional that the external interface changed in the way
the comment explains or is this accidental breakage?

Kevin


