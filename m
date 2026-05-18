Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ECACD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOuxv-0008QV-0v; Mon, 18 May 2026 06:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wOuxp-0008Pv-RW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wOuxn-0007lH-Ec
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779099161;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ictx6tmXSZla2QZrcKUNPjqRR50OBgZJczgtmgc8/ik=;
 b=Q4ymEPpnzOY/C3362HkhnQCIVu96qmF7WrauB6oYqdltivH/vxQdcKAlZcyTkML25n/IBQ
 R+lDwx67vzz1IRVhe+sBzeTpAREPH7Z5mtRnRSsZgET6nI1Ys0GTsjlXX+5Hyvi02rrArH
 NifOnIOpXrBG8mMQt2kWPBEmPh5vpzI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-QjY-he9QMdeE5V5Jmugteg-1; Mon,
 18 May 2026 06:12:38 -0400
X-MC-Unique: QjY-he9QMdeE5V5Jmugteg-1
X-Mimecast-MFC-AGG-ID: QjY-he9QMdeE5V5Jmugteg_1779099156
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D2D619560A7; Mon, 18 May 2026 10:12:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.79])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15A9C18004A3; Mon, 18 May 2026 10:12:32 +0000 (UTC)
Date: Mon, 18 May 2026 11:12:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "Emily.Deng@amd.com" <Emily.Deng@amd.com>,
 "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>,
 "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>,
 "Qing.Ma@amd.com" <Qing.Ma@amd.com>
Subject: Re: [PATCH] migration/rdma: change default rdma chunk size to 64MiB
Message-ID: <agrmDSZWT6Jl26P0@redhat.com>
References: <20260514031848.2422203-1-guoqing.zhang@amd.com>
 <eadfa566-9f75-408b-971f-986315b49476@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eadfa566-9f75-408b-971f-986315b49476@fujitsu.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 18, 2026 at 02:17:58AM +0000, Zhijian Li (Fujitsu) wrote:
> Samuel,
> 
> 
> Thanks for the patch.
> 
> On 14/05/2026 11:18, Samuel Zhang wrote:
> > The 1MiB default dates back to the original RDMA implementation in
> > 2013 (commit 2da776db48), and is too conservative for modern hardware.
> > 
> > 64MiB captures most of the throughput gain (~10x over 1MiB) while
> > keeping transferred data low.  Larger chunks cause more data to be
> > retransferred per dirty page, so the largest chunk size is not
> > necessarily optimal (see 1024MiB row).  The x-rdma-chunk-size
> > parameter remains available for user tuning.
> > 
> > Test config: BlueField-3 ConnectX-7, 8GB VM RAM, pin-all off,
> >    `stress-ng --vm 4 --vm-bytes 1G --vm-method rand-set`
> > 
> > chunk_size  total(ms)  down(ms)  Throughput(Mbps)  transferred
> > 1m            45,156    1,166          1,252.50     6.46 GiB
> > 32m           15,034    1,864          3,401.26     5.57 GiB
> > 64m            4,492    1,554         13,637.46     5.75 GiB
> > 128m           3,940    1,662         16,860.59     6.06 GiB
> > 1024m          3,665    2,238         24,676.59     8.04 GiB
> > 
> > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> > ---
> >   migration/options.c | 2 +-
> >   qapi/migration.json | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/options.c b/migration/options.c
> > index 5cbfd29099..ea2137372c 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -91,7 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
> >   
> >   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
> >   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
> > -#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
> > +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           (64 * MiB)
> 
> 
> I have a concern about backward compatibility.
> 
> AFAIK, changing the default chunk size could break RDMA migration between hosts running different QEMU versions.
> If this happens, the error message is not clear enough for a user to understand that the failure
> is due to a mismatch in 'x-rdma-chunk-size'?

Oh that's rather unfortunate. Even though x-rdma-chunk-size is marked
experimental/unstable, we can't change its default value if it breaks
migration compatibility out of the box :-(  Libvirt (or equivalent)
would need to negotiate the chunk size to a larger value, which would
mean we need to declare x-rdma-chunk-size stable by removing the x-
prefix.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


