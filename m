Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7809FC53200
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJAQ-00075t-3S; Fri, 24 Jul 2026 12:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnJAH-000737-4a
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnJAE-0007nl-Q3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784912061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXFXpTPZzhwZ/ClLgshlarO1WN2u+4BowMqW42cVlhQ=;
 b=G1VeWylC9SIaSAqeOo1lqZXlV618lVE3SntvJbo0cX1n87vuKDapsqiuiSYb49dOwMr9pi
 ljg668ql+u9ql9mPqr+ycu/7QdHXDLqMi7QkcY5cIsP+Gt2BmEF3xBCosxDmWQuiE4kr5q
 6jGhQt2KLfa6kqbrFnu5n3+eGFlHA3k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-q5KcBKPXODSifzFnOcxVTA-1; Fri,
 24 Jul 2026 12:54:19 -0400
X-MC-Unique: q5KcBKPXODSifzFnOcxVTA-1
X-Mimecast-MFC-AGG-ID: q5KcBKPXODSifzFnOcxVTA_1784912058
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C7A01882449; Fri, 24 Jul 2026 16:54:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7616F1591; Fri, 24 Jul 2026 16:54:16 +0000 (UTC)
Date: Fri, 24 Jul 2026 18:54:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/1] qcow2: do not try to clear the dirty bit on a
 read-only node
Message-ID: <amOYtc1byX2pFOH5@redhat.com>
References: <20260716153552.3376009-1-den@openvz.org>
 <e586cdd4-f9c6-4889-894c-7fc71ca15286@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e586cdd4-f9c6-4889-894c-7fc71ca15286@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 16.07.2026 um 19:54 hat Denis V. Lunev geschrieben:
> On 7/16/26 17:35, Denis V. Lunev wrote:
> > This email originated from an IP that might not be authorized by the domain it was sent from.
> > Do not click links or open attachments unless it is an email you expected to receive.
> > qcow2_do_close() -> qcow2_inactivate() clears the dirty bit with a
> > plain write to bs->file, unconditionally. A read-only node can still
> > be dirty, inherited from an earlier writable session, and that write
> > then hits a missing BLK_PERM_WRITE and asserts in
> > bdrv_co_write_req_prepare() (block/io.c) on an entirely ordinary
> > close -- closing is expected, the dirty bit on a read-only node
> > is not.
> >
> > Skip the clear for read-only nodes, same as read access already does.
> > Any other still-dirty node keeps the unguarded write: it is expected
> > to hold write permission, and a missing one there is a bug worth
> > seeing.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Kevin Wolf <kwolf@redhat.com>
> > CC: Hanna Reitz <hreitz@redhat.com>
> > ---
> >  block/qcow2.c              |  6 +++++-
> >  tests/qemu-iotests/039     | 11 +++++++++++
> >  tests/qemu-iotests/039.out |  3 +++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 2ab6ddd7b0..adb177e6b6 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2870,7 +2870,11 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
> >                       strerror(-ret));
> >      }
> >  
> > -    if (result == 0) {
> > +    /*
> > +     * A read-only node cannot resolve an inherited dirty bit here;
> > +     * leave it dirty, same as plain read access already does.
> > +     */
> > +    if (result == 0 && !bdrv_is_read_only(bs)) {
> >          qcow2_mark_clean(bs);
> >      }
> >  
> > diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> > index e43e7026ce..94a8bfe754 100755
> > --- a/tests/qemu-iotests/039
> > +++ b/tests/qemu-iotests/039
> > @@ -84,6 +84,17 @@ $QEMU_IO -r -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
> >  # The dirty bit must be set
> >  _qcow2_dump_header | grep incompatible_features
> >  
> > +echo
> > +echo "== Read-only open must not crash on close =="
> > +
> > +# We must not try to write the QCOW2 header to a read-only image.
> > +$QEMU_IMG info --image-opts \
> > +    "driver=$IMGFMT,read-only=on,file.driver=file,file.filename=$TEST_IMG,file.read-only=off" \
> > +    > /dev/null
> > +
> > +# The dirty bit must still be set: this open never wrote any guest data
> > +_qcow2_dump_header | grep incompatible_features
> > +
> >  echo
> >  echo "== Repairing the image file must succeed =="
> >  
> > diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> > index 8fdbcc528a..c66361128f 100644
> > --- a/tests/qemu-iotests/039.out
> > +++ b/tests/qemu-iotests/039.out
> > @@ -24,6 +24,9 @@ read 512/512 bytes at offset 0
> >  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  incompatible_features     [0]
> >  
> > +== Read-only open must not crash on close ==
> > +incompatible_features     [0]
> > +
> >  == Repairing the image file must succeed ==
> >  ERROR cluster 5 refcount=0 reference=1
> >  Rebuilding refcount structure
> Actually the problem is more subtle. The following command line results in
> 
> qemu-storage-daemon \                                                   
>   --blockdev
> '{"driver":"file","filename":"dirty.qcow2","aio":"threads","node-name":"file0","cache":{"direct":false,"no-flush":false},"auto-read-only":true,"discard":"unmap"}'
> \                    
>   --blockdev
> '{"node-name":"fmt0","read-only":true,"discard":"unmap","cache":{"direct":false,"no-flush":false},"driver":"qcow2","file":"file0"}'
> \                                                   
>   --chardev socket,id=qmp,path=master.sock,server=on,wait=off \         
>   --monitor chardev=qmp                                                 
>                                                          
> via query-named-block-nodes:
> 
>   node-name=fmt0     drv=qcow2  ro=True
>   node-name=file0    drv=file   ro=False
> 
> which would come to exactly configuration being asserted in the test
> and this setup is pretty legal at my opinion. In production we have
> had something lengthier with more snapshots.

Yes, I don't see a problem with it.

However, I also don't get a crash or anything with your QSD command line
and a dirty image with this patch applied, so what is the part that is
still incorrect?

What is the final result that you're seeing here?

> File descriptor in turn is opened in a correct way - with O_RDONLY
> that is why the problem was hidden for a lot of time.
> 
> Would it be more reasonable to disallow to set dirty rather than
> to ignore is open question to me. Playing with permissions and
> changing bdrv_is_read_only() seems more dangerous.

I don't follow, sorry. The patch fixes a code path that marks the image
as clean. Setting the dirty flag is the opposite operation and happens
here before we even opened the image. How would you disallow that?

> Also worth to note that bdrv_co_write_req_prepare() has wrong check.
> It should check file descriptor rather than administrative permission.

That doesn't sounds right. bdrv_co_write_req_prepare() is a generic
block layer function, the file descriptor is a file-posix implementation
detail.

> This looks toooooooooo complex to me :(
> 
> Den

Kevin


