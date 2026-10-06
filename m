Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD26CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENDK-0002Lh-UF; Wed, 07 Oct 2026 04:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEIdG-0005l7-9k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEId0-0002FM-85
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791344829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvCuYo7LM3wz7Lzm3h15anRgvsp2rTRxJ9EFQ93MvTo=;
 b=Equj/INKuVz/qJrfQvvzJxXzimVqwDOGSpb6NP8AokweFkZTZ5BXQRr414pNh8mF1YWUvw
 2jjPkC/ViLnsGNLTiHeRWznDx0uv6INfjFsY9hJXOb8tEXj/1/dJPc9WRxeuN4AH3oozha
 Ja7H1+9xi3dGPa308guis9QtoaWMdvE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-JYING7tdO6SFAym0Q2leNA-1; Tue,
 06 Oct 2026 11:11:50 -0400
X-MC-Unique: JYING7tdO6SFAym0Q2leNA-1
X-Mimecast-MFC-AGG-ID: JYING7tdO6SFAym0Q2leNA_1791299509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FEC31845548; Tue,  6 Oct 2026 15:11:49 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14F9A1956042; Tue,  6 Oct 2026 15:11:46 +0000 (UTC)
Date: Tue, 6 Oct 2026 10:11:44 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v8 1/3] parallels: report the stored dirty bitmaps in
 qemu-img info
Message-ID: <asUG9aE3xczhaQM9@redhat.com>
References: <20260913195301.1514888-1-den@openvz.org>
 <20260913195301.1514888-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913195301.1514888-2-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Sep 13, 2026 at 09:52:59PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Nothing tells which persistent bitmaps an image carries. qemu-img info
> says nothing about them, and the only other way to see one is to export
> the image over NBD and ask for a bitmap by name, which needs the name
> beforehand.

I would amend that statement, "s/an image/a parallels image/"; because
existing 'qemu-img info' definitely tells you what bitmaps a qcow2
image has:

$ qemu-img create -f qcow2 base.qcow2 100M
Formatting 'base.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=104857600 lazy_refcounts=off refcount_bits=16
$ qemu-img bitmap --add -f qcow2 base.qcow2 bm1
$ qemu-img bitmap --add -f qcow2 base.qcow2 bm2
$ qemu-img info base.qcow2
image: base.qcow2
file format: qcow2
virtual size: 100 MiB (104857600 bytes)
disk size: 220 KiB
cluster_size: 65536
Format specific information:
    compat: 1.1
    compression type: zlib
    lazy refcounts: false
    bitmaps:
        [0]:
            flags:
                [0]: auto
            name: bm1
            granularity: 65536
        [1]:
            flags:
                [0]: auto
            name: bm2
            granularity: 65536
    refcount bits: 16
...


Also, the NBD protocol indeed allows a client to query what
metacontexts an image supports, which can be used to expose bitmaps;
and both 'qemu-nbd -L' and libnbd's 'nbdinfo' are happy to read that
information.  But, at present, qemu-nbd limits us to exposing that on
a per-bitmap basis, rather than having an easy way to export all
bitmaps at once.  For example,

$ qemu-nbd -L
exports available: 1
 export: ''
...
  available meta contexts: 4
   base:allocation
   qemu:allocation-depth
   qemu:dirty-bitmap:bm2
   qemu:dirty-bitmap:bm1
$ nbdinfo nbd://localhost
protocol: newstyle-fixed without TLS, using extended packets
export="":
...
	contexts:
		base:allocation
		qemu:allocation-depth
		qemu:dirty-bitmap:bm2
		qemu:dirty-bitmap:bm1
...

So I will probably submit a patch to add a command-line flag to
qemu-nbd to expose all known bitmaps without having to do a -B option
per name, on top of this series.

> 
> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
> in the same way as qcow2 reports the contents of its bitmap directory:
> 
>     Format specific information:
>         bitmaps:
>             [0]:
>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>                 granularity: 65536
> 
> For running VM process the list is built on the fly from in-memory
> list. This is the best we can do. FormatExtension could be dead in
> the image while VMs are running as all bitmaps are cleared on
> non-clean VM stop.
> 
> A bitmap of an image which was not closed correctly is inconsistent
> and can not be used. Report that as well, the way qcow2 reports its
> in-use flag, so such a bitmap is not listed as a valid one.
> 
> The section is left empty for an image with no persistent dirty
> bitmaps, and an empty section is not printed, so the human readable
> output of "qemu-img info" and "info block" is unchanged.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels-ext.c                         | 26 +++++++++++
>  block/parallels.c                             | 20 +++++++++
>  block/parallels.h                             |  3 ++
>  qapi/block-core.json                          | 45 ++++++++++++++++++-
>  tests/qemu-iotests/tests/parallels-checks     |  6 +++
>  tests/qemu-iotests/tests/parallels-checks.out | 19 ++++++++
>  6 files changed, 117 insertions(+), 2 deletions(-)
> 

> +++ b/qapi/block-core.json

> +##
> +# @ParallelsBitmapInfo:
> +#
> +# Parallels bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @inconsistent: true if the bitmap is in an inconsistent state and
> +#     cannot be used
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ParallelsBitmapInfo',
> +  'data': { 'name': 'str', 'granularity': 'uint32',
> +            '*inconsistent': 'bool' } }

Should @inconsistent mention that it is default false, since it is
listed as optional? Or is there any reason why we should not output an
explicit value of false and make the field non-optional?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


