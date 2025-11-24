Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716CBCFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNadi-0005se-Ta; Mon, 24 Nov 2025 12:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNadh-0005ru-Fl
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:46:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNadd-0004ov-Qy
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764006368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmDKBfVGBF54B/6CW9BfJUfYffvny7jTASdhSiRW2Jc=;
 b=g7HpVAFu1pw2CgOqMXXLyx6Y+15mzsou3eLuIQu7q7kyNIdIXlFUZ5PqeexQDY8Yh3U1ZA
 xHBfp8tYWeUE9ruqvtqChl0fJq4NpXS9XJBDbVY0dsKov5BwyNu6++H0dVJXYf2vfs6Qhx
 9jEwz3an1vNr6P1p2PyvvrPgVd2wRzc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-qO9GSB6oPdK09byJM-5j1A-1; Mon,
 24 Nov 2025 12:46:04 -0500
X-MC-Unique: qO9GSB6oPdK09byJM-5j1A-1
X-Mimecast-MFC-AGG-ID: qO9GSB6oPdK09byJM-5j1A_1764006362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAC3C1956048; Mon, 24 Nov 2025 17:46:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.81])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 450DB1956056; Mon, 24 Nov 2025 17:45:58 +0000 (UTC)
Date: Mon, 24 Nov 2025 18:45:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 0/3] block: use pwrite_zeroes_alignment when writing
 first sector
Message-ID: <aSSZ1Jbj2K-G4SnS@redhat.com>
References: <20251007141700.71891-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007141700.71891-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 07.10.2025 um 16:16 hat Stefan Hajnoczi geschrieben:
> v2:
> - Simplify condition to if (!s->needs_alignment) in patch 1 [Vladimir]
> 
> This series fixes a bug I introduced in commit 5634622bcb33 ("file-posix: allow
> BLKZEROOUT with -t writeback"). The Linux fallocate(2) and ioctl(BLKZEROOUT)
> syscalls require logical block size alignment of the offset and length, even
> when the file is opened in buffered I/O mode where read/write operations do not
> require alignment.
> 
> The fix is to populate the pwrite_zeroes_alignment block limits field and to
> use that limit in create_file_fallback_zero_first_sector().
> 
> One issue I want to raise is that pwrite_zeroes_alignment is an "optimal
> alignment" hint. Hence create_file_fallback_zero_first_sector() had to be
> modified to honor the limit explicitly. The block layer doesn't automatically
> apply padding in order to align requests. This is different from how QEMU's
> block layer pwrite/pread works, where it does automatically apply padding and
> read/modify/write as necessary. If you want consistency, please let me know.

Thanks, applied to the block branch.

Kevin


