Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EF5C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0Q3-0001p9-4l; Wed, 29 Jul 2026 05:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wp0Q0-0001nF-AT
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wp0Px-0005UR-7I
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785316656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6AZUni5pu3rT71xyj5RDOkhB5zsnWpKb5bvls+Gr4fE=;
 b=cGHNF+snESWgYTbCUjUfegDmUDQ0Z2Jyt+qZvLSdz+cv7H4xEztdhfCb5Txi8rosu7Hp1O
 mU4j7sg1p6x8SNIy0eRD7aJaOdaGXGiKKHLyJdHre0XCO9F+wNpqoNg23FztOJRyc2CAIc
 QfvpxSVxxKqFresul1jKRE5TpzOiQk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-2nWEASjcMgST-J4HII62fg-1; Wed,
 29 Jul 2026 05:17:33 -0400
X-MC-Unique: 2nWEASjcMgST-J4HII62fg-1
X-Mimecast-MFC-AGG-ID: 2nWEASjcMgST-J4HII62fg_1785316652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CEEE1800347; Wed, 29 Jul 2026 09:17:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.180])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19177300019F; Wed, 29 Jul 2026 09:17:28 +0000 (UTC)
Date: Wed, 29 Jul 2026 11:17:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH for-11.1?] qemu-iotest 161: fix race
Message-ID: <amnFJjf3_QVwNJwi@redhat.com>
References: <20260728163919.369020-1-mjt@tls.msk.ru>
 <amjss5kbAzHgjmdC@redhat.com>
 <9f831894-4184-4a8d-9ebd-f11ca941ef07@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f831894-4184-4a8d-9ebd-f11ca941ef07@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Am 28.07.2026 um 22:36 hat Michael Tokarev geschrieben:
> On 7/28/26 20:53, Kevin Wolf wrote:
> 
> > > diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
> > > index f25effab936..0b8ba0b19e2 100755
> > > --- a/tests/qemu-iotests/161
> > > +++ b/tests/qemu-iotests/161
> > > @@ -106,6 +106,7 @@ echo
> > >   echo "*** Commit and then change an option on the backing file"
> > >   echo
> > >   # Create the images again
> > > +rm -f -- "$TEST_IMG.base" "$TEST_IMG.int"
> > >   TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
> > >   TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
> > >   _make_test_img -b "$TEST_IMG.int" -F $IMGFMT
> > 
> > This can only work for the file protocol, but the test also supports
> > fuse, which is now broken.
> 
> I haven't noticed _rm_test_img function.  I wonder maybe we can add
> this rm into _make_test_img directly, and fix this for all tests?
> 
> _make_test_img already calls _rm_test_img - for fuse protocol exactly.
> It can call _rm_test_img unconditionally, I guess.

Using _rm_test_img should do the trick for 161 because it only supports
file and fuse anyway. Those are the obvious two protocols that work with
_rm_test_img.

Some others might work, too, because they just export a local file that
can be deleted normally (nbd, ssh, nfs). _make_test_img() seems to take
care of restarting the NBD server so that it would then serve the new
image. I suppose SSH and NFS don't need to be notified and would
automatically serve the new image. It's not entirely obvious, but it
looks like it could work.

rbd probably breaks, so we might need to exclude that.

Kevin


