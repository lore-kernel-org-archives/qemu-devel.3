Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF84C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8fs-0005Mc-FP; Mon, 03 Mar 2025 11:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tp8fq-0005M6-Bn
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tp8fo-0007H2-Gc
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741019381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhW7cc44GKryUNBaF9jnyuX+qcn1w+Jj1l15W/x3wZk=;
 b=RrzzwLCw33niJKF2j1UWCYvYWO+sqsgpOAzc7bTmMxWu5Ypg2BiYXlqGvr1yKr9IKrhPjQ
 mACCQaNajXkMwk8JuFK2aCUabYCNj/eOb1dUdtIPqELdSbPB0Yvc+PWewqwOGB7+sfdiLT
 iPQrcdRrvLXBhRPEeP7yyDjqqYbXdsg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-cVmTstPNPvm402otEHqnkw-1; Mon,
 03 Mar 2025 11:29:28 -0500
X-MC-Unique: cVmTstPNPvm402otEHqnkw-1
X-Mimecast-MFC-AGG-ID: cVmTstPNPvm402otEHqnkw_1741019367
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23D5C19540F3; Mon,  3 Mar 2025 16:29:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59F1300019F; Mon,  3 Mar 2025 16:29:23 +0000 (UTC)
Date: Mon, 3 Mar 2025 10:29:21 -0600
From: Eric Blake <eblake@redhat.com>
To: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Wen Congyang <wencongyang2@huawei.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] blockdev-backup: Add error handling option for
 copy-before-write jobs
Message-ID: <ib3winvu67xep4eulruuw6kbxz7gggiiewssnw226wj2ch3hj6@ko7xdxjqfdw5>
References: <20250303133510.246424-1-Raman.Dzehtsiar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303133510.246424-1-Raman.Dzehtsiar@gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 03, 2025 at 02:35:10PM +0100, Raman Dzehtsiar wrote:
> This patch extends the blockdev-backup QMP command to allow users to specify
> how to behave when IO errors occur during copy-before-write operations.
> Previously, the behavior was fixed and could not be controlled by the user.
> 
> The new 'on-cbw-error' option can be set to one of two values:
> - 'break-guest-write': Forwards the IO error to the guest and triggers
>   the on-source-error policy. This preserves snapshot integrity at the
>   expense of guest IO operations.
> - 'break-snapshot': Allows the guest OS to continue running normally,
>   but invalidates the snapshot and aborts related jobs. This prioritizes
>   guest operation over backup consistency.
> 
> This enhancement provides more flexibility for backup operations in different
> environments where requirements for guest availability versus backup
> consistency may vary.
> 
> The default behavior remains unchanged to maintain backward compatibility.
> 
> Signed-off-by: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>
> ---

> +++ b/blockdev.c
> @@ -2752,6 +2752,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
>                              &perf,
>                              backup->on_source_error,
>                              backup->on_target_error,
> +                            backup->has_on_cbw_error ? backup->on_cbw_error : ON_CBW_ERROR_BREAK_GUEST_WRITE,

Is there a way to avoid this long line, perhaps by using assignment
into a temporary variable prior to the function call?

>                              job_flags, NULL, NULL, txn, errp);
>      return job;
>  }

> +++ b/qapi/block-core.json
> @@ -1622,6 +1622,9 @@
>  # @discard-source: Discard blocks on source which have already been
>  #     copied to the target.  (Since 9.1)
>  #
> +# @on-cbw-error: optional policy defining behavior on I/O errors in
> +#     copy-before-write jobs; defaults to break-guest-write.  (Since 9.3)

The next release is 10.0, not 9.3.

> +#
>  # @x-perf: Performance options.  (Since 6.0)
>  #
>  # Features:
> @@ -1641,6 +1644,7 @@
>              '*compress': 'bool',
>              '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
> +            '*on-cbw-error': 'OnCbwError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
>              '*filter-node-name': 'str',
>              '*discard-source': 'bool',
> -- 
> 2.43.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


