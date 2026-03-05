Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F8FF47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCwE-0006RX-HD; Thu, 05 Mar 2026 12:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyCwA-0006Qh-JP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyCw7-0003M1-5p
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fAA/w+AS77WVjnK5Pr36ehedmgIZGCGuIrFUtn4eS0k=;
 b=iUb+pK35Bh8QYru4iL2S3TTXEgpb1zXZCZD+Gf4vQ95zXm8Paa+F77OEkpwiD/FTMyam9U
 7xUe3o1Xpb+eIOf2zKzplAcMuLaFbzIzB4rRseSO+7seXnTvqExamIkrE7c4NZegiwDTKe
 zMdOlrLQU96/00zja2xM8k+NPHUVN9o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-siQbyvmWNnergzJlS4X6AQ-1; Thu,
 05 Mar 2026 12:56:29 -0500
X-MC-Unique: siQbyvmWNnergzJlS4X6AQ-1
X-Mimecast-MFC-AGG-ID: siQbyvmWNnergzJlS4X6AQ_1772733387
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D3891956052; Thu,  5 Mar 2026 17:56:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12EA21800361; Thu,  5 Mar 2026 17:56:25 +0000 (UTC)
Date: Thu, 5 Mar 2026 18:56:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v4 07/24] fuse: Fix mount options
Message-ID: <aanDx_9i6UfXvWzM@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
 <20260218132633.29748-8-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218132633.29748-8-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Since I actually took a look into how mounting with libfuse works[1], I
> now know that the FUSE mount options are not exactly standard mount
> system call options.  Specifically:
> - We should add "nosuid,nodev,noatime" because that is going to be
>   translated into the respective MS_ mount flags; and those flags make
>   sense for us.
> - We can set rw/ro to make the mount writable or not.  It makes sense to
>   set this flag to produce a better error message for read-only exports
>   (EROFS instead of EACCES).
>   This changes behavior as can be seen in iotest 308: It is no longer
>   possible to modify metadata of read-only exports.
> 
> In addition, in the comment, we can note that the FUSE mount() system
> call actually expects some more parameters that we can omit because
> fusermount3 (i.e. libfuse) will figure them out by itself:
> - fd: /dev/fuse fd
> - rootmode: Inode mode of the root node
> - user_id/group_id: Mounter's UID/GID
> 
> [1] It invokes fusermount3, an SUID libfuse helper program, which parses
>     and processes some mount options before actually invoking the
>     mount() system call.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

This breaks the fuse-allow-other iotest for me.

It doesn't look to me like the test actually requires a read-only
export, so I'd suggest to just make it writable like below. I'll apply
this now, if there are any objections let me know so that we can change
it again before I send a pull request.

Kevin

diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index 19f494aefb1..eaa39f8f236 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -101,7 +101,8 @@ run_permission_test()

     fuse_export_add 'export' \
         "'mountpoint': '$EXT_MP',
-         'allow-other': '$1'"
+         'allow-other': '$1',
+         'writable': true"

     # Should always work
     echo '(Removing all permissions)'
diff --git a/tests/qemu-iotests/tests/fuse-allow-other.out b/tests/qemu-iotests/tests/fuse-allow-other.out
index 3219fc35e05..62660b40bfc 100644
--- a/tests/qemu-iotests/tests/fuse-allow-other.out
+++ b/tests/qemu-iotests/tests/fuse-allow-other.out
@@ -12,7 +12,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'off'
+         'allow-other': 'off',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
@@ -41,7 +42,8 @@ stat: cannot statx 'fuse-export': Permission denied
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'on'
+         'allow-other': 'on',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
@@ -68,7 +70,8 @@ Permissions seen by nobody: 440
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'auto'
+         'allow-other': 'auto',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)


