Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21326CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMFn-0004OJ-GS; Wed, 07 Oct 2026 03:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEGdZ-0005T6-86
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEGdJ-0000it-1g
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791337059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWt1RENlaja18bj4zAOHqkajKHTMTxvdPYvImNSEX4g=;
 b=LtF0YHLfJMR5mQJx9Qx9alejVhOApTjBXGvgOVpgficE/wOWWFbYh82NoqEBXo9Gc2Ixqr
 pUc63ZjJI3c5mMIQeV7Y659TkGsVFIunVsM71eMfU7f17EO6Qc2OsWofLA9EUOhSZf6VTv
 bIbvOnnQnTPD5NMkiLQDryBrzSJcC14=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-m7cn2nkOM3G3W1W5tiGFbw-1; Tue,
 06 Oct 2026 10:29:10 -0400
X-MC-Unique: m7cn2nkOM3G3W1W5tiGFbw-1
X-Mimecast-MFC-AGG-ID: m7cn2nkOM3G3W1W5tiGFbw_1791296949
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9141E1967C50; Tue,  6 Oct 2026 14:29:08 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DECFC433; Tue,  6 Oct 2026 14:29:05 +0000 (UTC)
Date: Tue, 6 Oct 2026 09:29:03 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH qemu 4/4] qemu-img: convert: flush target image after
 copying
Message-ID: <asUDdHfFgP7RoMk5@redhat.com>
References: <20260930132140.2342574-1-f.ebner@proxmox.com>
 <20260930132140.2342574-5-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930132140.2342574-5-f.ebner@proxmox.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Wed, Sep 30, 2026 at 03:19:25PM +0200, Fiona Ebner wrote:
> With 'qemu-img convert', when using a cache mode with 'cache.no-flush
> = off', the expectation is that the data is flushed to the disk, which
> happens since commit 80ccf93b88 ("qemu-img: let 'qemu-img convert'
> flush data"). This expectation also encompasses that failure to do so
> is properly reported, so ensure that 'qemu-img convert' exits with a
> non-zero status code when the target image cannot be flushed.
> 
> In particular, the reproducer below [0], based on a report by
> Ing. Alfonso Kuen Arroyo [1], would result in
> > rc=0
> > Content mismatch at offset XYZ!
> before this change, and in
> > rc=1
> > Content mismatch at offset XYZ!
> after this change.
> 
> Note that this change does not affect the (default) 'unsafe' cache
> mode, because bdrv_co_flush() still skips flush to disk for that cache
> mode.

Should we rethink the default? I get that during a long-running
qemu-img convert, it makes sense to avoid intermediate calls to flush
(the destination image is not going to be in use by a guest until the
qemu-img process completes, so there is no need to slow down the
conversion). But should we have a mode of operation where we guarantee
that we flush before exiting qemu-img, while ginoring all other flush
points in the middle (in between an explicit request for all
intermediate flushes to be acted on, vs. an explicit request to not do
any flushing at all), as as safer default going forward? That way, you
have to explicitly opt in to a case where qemu-img convert might
produce a corrupted copy due to an undiagnosed flush failure.

But I think that question can be deferred to another day - this patch
has merit of adding diagnosis for the setup of anyone explicitly
requesting flush safety of some sort, even if it doesn't change
behavior for the defaults when the user did not make an explicit flush
request.

Reviewed-by: Eric Blake <eblake@redhat.com>

This series caught my eyes because of the scenario you mentioned of an
NBD connection dying before a flush can finalize; so I'm planning on
queuing it through my NBD tree shortly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


