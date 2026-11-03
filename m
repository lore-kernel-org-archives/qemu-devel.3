Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896A606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fihbpioq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGpi-0000zH-Nf; Tue, 03 Nov 2026 10:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOGph-0000z6-Au
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOGpf-0005zz-Vm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793721234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kt8qLP1csZDrqgyz51qRcfGjrbe/U6Ui+Tfo1k7oRyQ=;
 b=FihbpioqVVhtAs60Hhmp7Cf925XNS95F0bHXug7OSbl5+TBobViOzywxryozkCdGfdfHPY
 FkCBDuZ2bkzd0YM5WD6deKcQBqa76cmogY5joEa4r61X5eYms+eBm7gk73TkH0BTYvT8pB
 EYujJRfHpMY6I4mo72VYr7mYP4IlN4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-pYGLrNQdPfGwloH_XhIiAA-1; Tue,
 03 Nov 2026 10:53:53 -0500
X-MC-Unique: pYGLrNQdPfGwloH_XhIiAA-1
X-Mimecast-MFC-AGG-ID: pYGLrNQdPfGwloH_XhIiAA_1793721232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B69291955EA7; Tue,  3 Nov 2026 15:53:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59CE018002B6; Tue,  3 Nov 2026 15:53:49 +0000 (UTC)
Date: Tue, 3 Nov 2026 16:53:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jean-louis@dupond.be, den@openvz.org
Subject: Re: [PATCH 1/3] iotests/290: add test case to check
 'discard-no-unref' option behavior
Message-ID: <auoDiqgIluYOUr9F@redhat.com>
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 27.10.2026 um 11:44 hat Andrey Drobyshev geschrieben:
> We basically fill 2 images with identical data and perform discard
> operations with and without 'discard-no-unref' enabled.  Then we check
> that images still read identically, that their disk usage is the same
> (i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
> both) and that with the option enabled cluster is still marked as
> allocated in "qemu-img map" output.  We also check that the option
> doesn't work with qcow2 v2 images.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

This test fails with -fuse:

$ tests/qemu-iotests/check -fuse -qcow2 290
[...]
290   fail       [16:49:10] [16:49:16]   5.3s                 output mismatch (see /home/kwolf/source/qemu/build-clang/scratch/qcow2-fuse-290/290.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/290.out
+++ /home/kwolf/source/qemu/build-clang/scratch/qcow2-fuse-290/290.out.bad
@@ -77,7 +77,7 @@
 discard 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 # Compare disk usage of the 2 images
-disk_usage(t.qcow2) - disk_usage(t.qcow2.nounref) = 0
+disk_usage(fuse-t.qcow2) - disk_usage(fuse-t.qcow2.nounref) = 0
 # Check that images are still identical
 Images are identical.
 # Output of qemu-img map for the image with dropped reference
Failures: 290
Failed 1 of 1 iotests

Kevin


