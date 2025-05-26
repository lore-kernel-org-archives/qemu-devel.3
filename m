Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A6FC5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTFg-0006TR-9z; Mon, 26 May 2025 04:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJTFa-0006T5-Ef
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJTFY-0005QG-6P
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748248318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Esq7xKROOlRw0mvWrnkVTb5jcSQamC5zRAUJL+JL2A=;
 b=OEea/qB1m75PlzzduEQf7BAHTt9eT+n9VBcUvvoPfAWXRwpbIvVil4dOBwlFJ9HXcq239N
 LJM9cWkqKhJT66V4Rc+dKDVaGZJMN9BnUznC5+YCxGC9lwhC2+FmfAtLp7YQ8pmDij8uHH
 Tr4iU6cFj88X/pKo3TxfW53fwlql4uM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-G4a7AF_mNXii66HPDKXmOQ-1; Mon,
 26 May 2025 04:31:06 -0400
X-MC-Unique: G4a7AF_mNXii66HPDKXmOQ-1
X-Mimecast-MFC-AGG-ID: G4a7AF_mNXii66HPDKXmOQ_1748248265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C409E19560A1; Mon, 26 May 2025 08:31:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.150])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 717F018003FD; Mon, 26 May 2025 08:31:01 +0000 (UTC)
Date: Mon, 26 May 2025 10:30:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Weil <sw@weilnetz.de>,
 Jeff Cody <codyprime@gmail.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH] qcow2: Forbid use of protocol: prefix on data_file
Message-ID: <aDQmwoUmWWAyZc5k@redhat.com>
References: <20250523182111.2575879-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182111.2575879-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

Am 23.05.2025 um 20:20 hat Eric Blake geschrieben:
> Ever since CVE-2024-4467 (see commit 7ead9469 in qemu v9.1.0), we have
> intentionally treated command-line arguments as local files, and not
> protocol specifications (you have to specify backing files with
> full-blown QMP if it is intentional to access something more
> complicated).  However, that patch forgot about qcow2 data-file, which
> is another place where we really should not be hard-coding protocol
> names in the qcow2 metadata.
> 
> Fix this by changing the decision point on whether to allow protocols
> to each driver, rather than hard-coded to true in the generic code;
> qcow2 data_file is the only place where we change the former default
> of true.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

This commit message is very confusing. Commit 7ead9469 was primarily
about qcow2 data files, it certainly didn't forget them. It also didn't
do something in other places, but not in qcow2. Another thing it wasn't
about is command line arguments, but it restricted the references stored
in (potentially untrusted) image files.

The main difference between it and this patch is that commit 7ead9469
was about opening images (which is a security problem because you might
deal with untrusted images), and this one is about creating images
(which has no such problem, you're creating the image only now).

Of course, if you can't open an image with protocol: syntax, it makes
sense that creating it with the same syntax fails, too, for consistency.
So I'm not opposed to this patch, but I think it needs a completely
different commit message.

> diff --git a/block/vmdk.c b/block/vmdk.c
> index 9c7ab037e14..576af241e59 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2332,7 +2332,7 @@ vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
>      int ret;
>      BlockBackend *blk = NULL;
> 
> -    ret = bdrv_co_create_file(filename, opts, errp);
> +    ret = bdrv_co_create_file(filename, opts, true, errp);
>      if (ret < 0) {
>          goto exit;
>      }

If we want to be consistent with opening, VMDK extents should pass
allow_protocol_prefix=false.

Kevin


