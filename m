Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0AACD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJg1q-0007YZ-7v; Thu, 13 Nov 2025 17:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJg1n-0007KD-KP
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJg1m-0004D3-8e
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763073773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdhseRZ3o7KG+2nDC0OMb0BBiZ4pLm8/3ZaWjyBwErw=;
 b=TguyKFJwsnJLGL7fKPRU8+UgDufb+5dzhs4fp7yyeJYr3yIXaGFozaKYJ8hB9STOLpV+XF
 gSwDm3R481pzq5A/pUrf1iYV1xiC1HqoSSSyQf8vOeZYdIRIym/wSWm80A7Sl0f7W3Bcpl
 9MkQ9LGa4n9I0RVgR5FsbaEAon/6tSU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-j7-20DBNNpu89P5Cf7zFtQ-1; Thu,
 13 Nov 2025 17:42:50 -0500
X-MC-Unique: j7-20DBNNpu89P5Cf7zFtQ-1
X-Mimecast-MFC-AGG-ID: j7-20DBNNpu89P5Cf7zFtQ_1763073769
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 664D91956088; Thu, 13 Nov 2025 22:42:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2DA61800451; Thu, 13 Nov 2025 22:42:46 +0000 (UTC)
Date: Thu, 13 Nov 2025 16:42:44 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] tests/qemu-iotest: fix iotest 024 with qed images
Message-ID: <5to6ncfcyiyu3ry2wfrp4wjmv3vebqcefjdq26fbb437qffdms@xzsc4o6gubx3>
References: <20251112170959.700840-1-berto@igalia.com>
 <f5ea38e0-e707-4222-ad69-2edf39d5fe15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ea38e0-e707-4222-ad69-2edf39d5fe15@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Nov 13, 2025 at 08:29:54AM +0100, Thomas Huth wrote:
> On 12/11/2025 18.09, Alberto Garcia wrote:
> > Use 'qemu-io -c map' instead of 'qemu-img map' to get an output that
> > works with both image types.
> > 
> > Cc: qemu-stable <qemu-stable@nongnu.org>
> > Fixes: 909852ba6b4a ("qemu-img rebase: don't exceed IO_BUF_SIZE in one operation")
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > ---
> >   tests/qemu-iotests/024     | 2 +-
> >   tests/qemu-iotests/024.out | 3 +--
> >   2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
> > index 021169b4a1..10be2bd845 100755
> > --- a/tests/qemu-iotests/024
> > +++ b/tests/qemu-iotests/024
> > @@ -359,7 +359,7 @@ $QEMU_IO "$OVERLAY" -c "read -P 0x00  0 1M" | _filter_qemu_io
> >   $QEMU_IO "$OVERLAY" -c "read -P 0xff 1M 2M" | _filter_qemu_io
> >   $QEMU_IO "$OVERLAY" -c "read -P 0x00 3M 1M" | _filter_qemu_io
> > -$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
> > +$QEMU_IO -c map "$OVERLAY" | _filter_qemu_io
> >   echo
> > diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
> > index 1b7522ba71..da8fedc08b 100644
> > --- a/tests/qemu-iotests/024.out
> > +++ b/tests/qemu-iotests/024.out
> > @@ -266,7 +266,6 @@ read 2097152/2097152 bytes at offset 1048576
> >   2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >   read 1048576/1048576 bytes at offset 3145728
> >   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -Offset          Length          File
> > -0               0x400000        TEST_DIR/subdir/t.IMGFMT
> > +4 MiB (0x400000) bytes     allocated at offset 0 bytes (0x0)
> >   *** done
> 
> Thanks!
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

Not exactly NBD related, but since I wanted a cleaner iotests run
before submitting my pull request, I went ahead and queued this
through my tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


