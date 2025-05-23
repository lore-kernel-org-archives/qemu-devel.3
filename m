Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D7BC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 18:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIXR7-0007B4-U1; Fri, 23 May 2025 14:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIXR0-00078v-3F
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIXQx-0005iB-CB
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748026072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mr0Rw4oI67oYiic6I6kSWvXHUcw+P+Bz6rsHDqomsGs=;
 b=Ucj0ovTK7HOJy1xp/CqKRm6/vuTbbZKexuqjITIXrwUCQeEPnSLfWYmafJJLn0GR6IfIWn
 fD0uBGK80MAHG0EC0xq/Vc9OuQpUoq9J6Azfh27Pzq9U7T4mrUkvzVcNq9JVDmfCc9PTit
 Enl+pi54FVKu4G4+DzusuIgj0myi1T8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-XHdOFIeqP0yi510zQv9QlQ-1; Fri,
 23 May 2025 14:47:49 -0400
X-MC-Unique: XHdOFIeqP0yi510zQv9QlQ-1
X-Mimecast-MFC-AGG-ID: XHdOFIeqP0yi510zQv9QlQ_1748026068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A55741956086; Fri, 23 May 2025 18:47:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6087E1800359; Fri, 23 May 2025 18:47:44 +0000 (UTC)
Date: Fri, 23 May 2025 13:47:41 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Stefan Weil <sw@weilnetz.de>,
 Jeff Cody <codyprime@gmail.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH] qcow2: Forbid use of protocol: prefix on data_file
Message-ID: <geglgzfps7fwui4kytb3dwazgk7nd4koef2ovqglntaecezph4@vebzxfodigc5>
References: <20250523182111.2575879-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182111.2575879-2-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 23, 2025 at 01:20:32PM -0500, Eric Blake wrote:
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

I should probably add an example to the commit message:

Pre-patch:

$ qemu-img create -f qcow2 -o data_file=rbd:virtual-disk-ceph-pool/datastore... datastore_rbd.qcow2 500M

tries to access the remote disk using rbd; but the "External data file
name" extension header in qcow2 stores an empty string; so the qcow2
file can't be reopened without QMP anyway.  Post-patch, the creation
attempt fails with:

$ qemu-img create -f qcow2 -o data_file=rbd:virtual-disk-ceph-pool/datastore datastore_rbd.qcow2 500M
Formatting 'datastore_rbd.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=524288000 data_file=rbd:virtual-disk-ceph-pool/datastore lazy_refcounts=off refcount_bits=16
qemu-img: datastore_rbd.qcow2: Could not create 'rbd:virtual-disk-ceph-pool/datastore': No such file or directory

and no qcow2 file is created.  It is still possible to use QMP to open
a qcow2 wrapper with rbd as the backing file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


