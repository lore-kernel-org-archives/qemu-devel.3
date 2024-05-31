Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FCEC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4ug-0006R8-Hx; Fri, 31 May 2024 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sD4ue-0006Py-OU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sD4uc-0000Bf-Lg
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717172124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0FkPaLYe4VCB6ASRtzRR8KMy2GVWMXf/VtaaUd+Ov8=;
 b=fwZeSwxN+ldQuUqA0P5dv4/B9jnSAWqoSzHvWcG9J9+QHKAKjadgOjem6w5kzK9J8o7vbh
 /tHv7oIWjJgQsoy5MMtYzBd0xczDJz9a67KEC6PNP1P3uUOLaLARcmWMTugkRBcKp57fSl
 ER1sHefBJ4Mk0pcgUAQiIYS18ZDDsbw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-j4sK556HM3mTNMM77mo4pQ-1; Fri,
 31 May 2024 12:15:22 -0400
X-MC-Unique: j4sK556HM3mTNMM77mo4pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 702C829AA381;
 Fri, 31 May 2024 16:15:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA943C27;
 Fri, 31 May 2024 16:15:19 +0000 (UTC)
Date: Fri, 31 May 2024 11:15:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, 
 berrange@redhat.com, qemu-stable@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: test NBD+TLS+iothread
Message-ID: <opadb5a3jcbgdz6dqyauuqunzo4aohezwilhz2r65prl74mll3@4gwkddg4l2md>
References: <20240518025246.791593-4-eblake@redhat.com>
 <20240518025246.791593-6-eblake@redhat.com>
 <ZlngZP-wAfRSE7rL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlngZP-wAfRSE7rL@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 04:36:20PM GMT, Kevin Wolf wrote:
> Am 18.05.2024 um 04:50 hat Eric Blake geschrieben:
> > Prevent regressions when using NBD with TLS in the presence of
> > iothreads, adding coverage the fix to qio channels made in the
> > previous patch.
> > 
> > CC: qemu-stable@nongnu.org
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> > diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread.out b/tests/qemu-iotests/tests/nbd-tls-iothread.out
> > new file mode 100644
> > index 00000000000..b5e12dcbe7a
> > --- /dev/null
> > +++ b/tests/qemu-iotests/tests/nbd-tls-iothread.out

> > +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
> > +Formatting '/home/eblake/qemu/build/tests/qemu-iotests/scratch/qcow2-file-nbd-tls-iothread/dst.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
> 
> /home/eblake is suboptimal in reference output. :-)

Indeed. Will fix, which means I need a v2 pull request.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


