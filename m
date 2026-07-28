Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69020C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom0F-0001CE-PB; Tue, 28 Jul 2026 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wom0E-0001Bs-W8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wom0D-0000l6-Az
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785261243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JT5O7Xg+F0oBt+Vqm5cDqLn7G72pu03LazJ0At4a1I=;
 b=S/pNXe5MSg0Uu1G1e98X4dUN6SXXSBZzUYIfAAWMz2J75qWAlcBdJg5jyH2YcgaS8ZpTfp
 Ua7r+vbO4zvMyIwQjnOhhIxJM4LrIqxx2o5o96+T18KVlNDqoDnFalXe0yplSqB3hlmsCK
 Cz9hQ2YfQ/X0M/IIMkGT2qmDLN7Rh8I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-fqzOYjywPCCfgpLWHpPbAA-1; Tue,
 28 Jul 2026 13:54:01 -0400
X-MC-Unique: fqzOYjywPCCfgpLWHpPbAA-1
X-Mimecast-MFC-AGG-ID: fqzOYjywPCCfgpLWHpPbAA_1785261240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA86E1800370; Tue, 28 Jul 2026 17:53:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 710B2300019F; Tue, 28 Jul 2026 17:53:57 +0000 (UTC)
Date: Tue, 28 Jul 2026 19:53:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH for-11.1?] qemu-iotest 161: fix race
Message-ID: <amjss5kbAzHgjmdC@redhat.com>
References: <20260728163919.369020-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728163919.369020-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 28.07.2026 um 18:39 hat Michael Tokarev geschrieben:
> qemu-iotest 161 fails intermittedly due to a race condition:
> 
> qemu:block / io-qcow2-161             ERROR            2.08s   exit status 1
> ――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> --- tests/qemu-iotests/161.out
> +++ scratch/qcow2-file-161/161.out.bad
> @@ -34,6 +34,8 @@
>  *** Commit and then change an option on the backing file
> 
>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
> +qemu-img: TEST_DIR/t.IMGFMT.base: Failed to get "write" lock
> +Is another process using the image [TEST_DIR/t.IMGFMT.base]?
>  Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
>  { 'execute': 'qmp_capabilities' }
> 
> This test is run right after a previous test, where we've
> killed qemu process which holds the test image open.
> It looks like when the next test is started (with creating
> the image files), old qemu is still running, so we're racing
> with that qemu, and qemu-img is unable to lock the image file
> properly.
> 
> We can add some `sleep $little-amount` here, but it is simpler
> and more reliable to just remove the image files, so that new
> ones are created.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2867
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
> index f25effab936..0b8ba0b19e2 100755
> --- a/tests/qemu-iotests/161
> +++ b/tests/qemu-iotests/161
> @@ -106,6 +106,7 @@ echo
>  echo "*** Commit and then change an option on the backing file"
>  echo
>  # Create the images again
> +rm -f -- "$TEST_IMG.base" "$TEST_IMG.int"
>  TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
>  TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
>  _make_test_img -b "$TEST_IMG.int" -F $IMGFMT

This can only work for the file protocol, but the test also supports
fuse, which is now broken.

Kevin


161   fail       [19:51:58] [19:52:03]   5.3s                 output mismatch (see /home/kwolf/source/qemu/build-clang/scratch/qcow2-fuse-161/161.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/161.out
+++ /home/kwolf/source/qemu/build-clang/scratch/qcow2-fuse-161/161.out.bad
@@ -33,6 +33,8 @@

 *** Commit and then change an option on the backing file

+rm: cannot remove '/tmp/qemu-iotests-9_5xqdbm/qcow2-fuse-161/fuse-t.qcow2.base': Device or resource busy
+rm: cannot remove '/tmp/qemu-iotests-9_5xqdbm/qcow2-fuse-161/fuse-t.qcow2.int': Device or resource busy
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
 Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
Failures: 161
Failed 1 of 1 iotests


