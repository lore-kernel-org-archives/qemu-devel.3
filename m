Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105E606A336
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MkHxNIPQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnVZ-00078Y-Ct; Tue, 10 Nov 2026 10:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQnVW-00078A-VB
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQnVV-0001HT-DZ
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794323491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKImayUcNvzNj599xfEmYeVHESZuNlvvUEQZInPdB64=;
 b=MkHxNIPQ2DhfO2g/8qlJVJ0FD/e52U7WzR7kfWscTSKw/EK6AIodR2+HFtYWYDsSXFVYZT
 rqYAQS8vS0ASFNwGI2aNuXk2OuMHuWhMg3jwOPaFUghLdhjYBcmHrUvE5i+RM4Ah6RYauf
 8s0ZzfQDgf9NGjouBm6kulV06N3Fvmg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-72e7_HSLMc-v84zRpGtK2g-1; Tue,
 10 Nov 2026 10:11:28 -0500
X-MC-Unique: 72e7_HSLMc-v84zRpGtK2g-1
X-Mimecast-MFC-AGG-ID: 72e7_HSLMc-v84zRpGtK2g_1794323487
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A26F619560A2; Tue, 10 Nov 2026 15:11:26 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.125])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E738930030FB; Tue, 10 Nov 2026 15:11:24 +0000 (UTC)
Date: Tue, 10 Nov 2026 16:11:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: malike <malike@kylinos.cn>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH] block/bochs: validate bitmap size and compute
 extent_blocks after validation
Message-ID: <avM0GuId9N5ncs_S@redhat.com>
References: <20261014033419.236057-1-malike@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014033419.236057-1-malike@kylinos.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 14.10.2026 um 05:34 hat malike geschrieben:
> bochs_open() computes bitmap_blocks using the formula
> "1 + (le32_to_cpu(bochs.bitmap) - 1) / 512".  le32_to_cpu() returns
> uint32_t, so when bochs.bitmap is zero the subtraction wraps to
> UINT32_MAX (0xFFFFFFFF) in unsigned arithmetic, yielding
> bitmap_blocks = 8388608 instead of 1.
> 
> The bitmap field is read directly from the on-disk image header and was
> never validated.  The overflowed bitmap_blocks propagates into
> seek_to_sector()'s bitmap_offset calculation, causing reads to target
> wrong offsets and return I/O errors or incorrect data.
> 
> Add an explicit zero check for bochs.bitmap before the formula.
> 
> Also move the extent_blocks calculation to after the existing
> extent_size validation.  The same "1 + (x - 1) / 512" pattern applies
> to extent, but extent==0 is already caught by the "extent_size <
> BDRV_SECTOR_SIZE" check; the calculation is moved after that check for
> clarity and robustness, and uses the already-validated s->extent_size
> instead of re-reading the header field.
> 
> Fixes: a8753c3466dc ("Bochs disk image support")
> Signed-off-by: malike <malike@kylinos.cn>

Thanks, applied to the block branch.

Of course, this alone isn't enough to fully validate the bitmap size.
Instead of incorrectly wrapping for a zero size bitmap and getting a too
large number from this, the header field could directly specify an
incorrect number that would have the same result in seek_to_sector().

qemu-iotests 078 could be extended to check different values for the
bitmap size, too, to catch these cases.

Kevin


